unit crypt_h;
//  Name: uxml_crypt.pas
//  Copyright: SoftWest group.
//  Author: Maxim Mihaluk
//  Date: 28.03.06
//  Description: містить функції шифрування

interface

uses Windows, SysUtils, kernel_h, Controls, Classes, Math, Winsock;

const
    KEY_FILE_NAME     = 'softwest';
    HEX_DIGITS        = 8;
    DATE_FORMAT       = 'ddmmyyyy';
    CURENT_DATE_FORMAT = 'dd.mm.yyyy'; //формат представлення дати поточний для системи
    DEATH_DATE_LENGTH = 8;
    DEFAULT_DISK_SN   = '123ABC456DEF';    

function CryptStr(const s: string): string;
function UncryptStr(const s: string): string;
procedure LoadCryptedFileToStream(const a_crypted_file_name: string; a_stream: TStream);
function UncryptFile(const a_crypted_file_name: string): string;

//function CryptStream(stream: TFileStream): Boolean;
//function UncryptStream(stream: TFileStream): Boolean;

//вертає серійний номер жорсткого диска.
function GetIDEDiskSerialNumber: string;

//вертає контрольну суму.
function CRC32(const iniCRC:Integer; source: AnsiString): Integer;

//доволі простий симетричний алгоритм шифрування даних (строки).
function EncodeMin(const data: String): String;
function DecodeMin(const data: String): String;

//вертає системну змінну.
function GetEnvVar(const varName: string): string;

//шукає файли у каталозі aDir (без вкладених підкаталогів) та вертає
//найбільшу дату файлу. Якщо щось не так вертає MinDouble;
//тобто найкращий спосіб отримати поточну дату викликати функцію так:
//GetCurDate(GetEnvVar('windir')).
function GetCurDate(aDir: string): TDate;

function GetLocalIP: String;
function GetLocalHostAddress: string;
function my_ip_address: string;

implementation
uses Dialogs;

const
    STR_OFFSET_START_VALUE = 1;
    STR_OFFSET_MAX_VALUE   = 3;
    STR_OFFSET_STEP        = 1;

    BIN_OFFSET_START_VALUE = 1;
    BIN_OFFSET_MAX_VALUE   = 10;
    BIN_OFFSET_STEP        = 2;

//функція шифрування строки;        
//алгоритм дуже простий;
function CryptStr(const s: string): string;
var
    temp:   string;
    i:      Integer;
    offset: Integer;

begin
    temp:=s;
    offset:=STR_OFFSET_START_VALUE;
    for i:=1 to Length(temp) do
    begin
        temp[i]:=chr(ord(temp[i]) - offset);
        Inc(offset, STR_OFFSET_STEP);
        if offset > STR_OFFSET_MAX_VALUE then offset:=STR_OFFSET_START_VALUE;
    end;
    Result:=temp;
end;

//функція дешифрування строки;
function UncryptStr(const s: string): string;
var
    temp:   string;
    i:      Integer;
    offset: Integer;

begin
    temp:=s;
    offset:=STR_OFFSET_START_VALUE;
    for i:=1 to Length(temp) do
    begin
        temp[i]:=chr(ord(temp[i]) + offset);
        Inc(offset, STR_OFFSET_STEP);
        if offset > STR_OFFSET_MAX_VALUE then offset:=STR_OFFSET_START_VALUE;
    end;
    Result:=temp;
end;

//загружає в потік a_stream зашифрований файл конфігурації a_crypted_file_name;
//загружає у розшифрованому вигляді придатному для зчитування TECXMLParser-ом;
procedure LoadCryptedFileToStream(const a_crypted_file_name: string; a_stream: TStream);
var
    s:          string;
    f:          TextFile;
    s_list:     TStringList;

begin
    AssignFile(f, a_crypted_file_name);
    s_list:=TStringList.Create;
    try
        Reset(f);
        while not EOF(f) do
        begin
            ReadLn(f, s);
            s:=UncryptStr(s);
            s_list.Add(s);
        end;
        s_list.SaveToStream(a_stream);
    finally
        CloseFile(f);
        s_list.Free;
    end;
end;

//розшифровує зашифрований файл конфігурації a_crypted_file_name та
//зберігає його в xml файл (з тим самим ім'ям і в тій самій папці);
//вертає ім'я xml файла якщо все нормально, або пусту строку якщо сталася якась
//помилка;
function UncryptFile(const a_crypted_file_name: string): string;
var
    s:               string;
    f:               TextFile;
    s_list:          TStringList;

begin
    Result:='';
    AssignFile(f, a_crypted_file_name);
    s_list:=TStringList.Create;
    try
        Reset(f);
        while not EOF(f) do
        begin
            ReadLn(f, s);
            s:=UncryptStr(s);
            s_list.Add(s);
        end;
        Result:=ChangeFileExt(a_crypted_file_name, xml_EXTENTION);
        s_list.SaveToFile(Result);
    finally
        CloseFile(f);
        s_list.Free;
    end;
end;

{
function CryptStream(stream: TFileStream): Boolean;
var
    p:          Pointer;
    i:          Integer;
    offset:     Byte;

begin
    Result:=false;
    GetMem(p, 1);
    try
        offset:=BIN_OFFSET_START_VALUE;
        for i:=0 to stream.Size - 1 do
        begin
            stream.Seek(i, soFromBeginning);
            if stream.Read(p^, 1) > 0 then
            begin
                Byte(p^):=Byte(p^) - offset;
                Inc(offset, BIN_OFFSET_STEP);
                if offset > BIN_OFFSET_MAX_VALUE then offset:=BIN_OFFSET_START_VALUE;
                stream.Seek(i, soFromBeginning);
                stream.Write(p^, 1);
            end
            else begin
                raise Exception.Create('Помилка зчитування даних (процедура CryptStream)');
            end;
        end;
    finally
        FreeMem(p, 1);
    end;
    Result:=true;
end;

function UncryptStream(stream: TFileStream): Boolean;
var
    p:      Pointer;
    i:      Integer;
    offset: Byte;

begin
    Result:=false;
    GetMem(p, 1);
    try
        offset:=BIN_OFFSET_START_VALUE;
        for i:=0 to stream.Size - 1 do
        begin
            stream.Seek(i, soFromBeginning);
            if stream.Read(p^, 1) > 0 then
            begin
                Byte(p^):=Byte(p^) + offset;
                Inc(offset, BIN_OFFSET_STEP);
                if offset > BIN_OFFSET_MAX_VALUE then offset:=BIN_OFFSET_START_VALUE;
                stream.Seek(i, soFromBeginning);
                stream.Write(p^, 1);
            end
            else begin
                raise Exception.Create('Помилка зчитування даних (процедура UncryptStream)');
            end;
        end;
    finally
        FreeMem(p, 1);
    end;
    Result:=true;
end;
}

function GetIDEDiskSerialNumber: string;
type
 TSrbIoControl = packed record
   HeaderLength : ULONG;
   Signature : Array[0..7] of Char;
   Timeout : ULONG;
   ControlCode : ULONG;
   ReturnCode : ULONG;
   Length : ULONG;
 end;
 SRB_IO_CONTROL = TSrbIoControl;
 PSrbIoControl = ^TSrbIoControl;

 TIDERegs = packed record
   bFeaturesReg : Byte; // Used for specifying SMART "commands".
   bSectorCountReg : Byte; // IDE sector count register
   bSectorNumberReg : Byte; // IDE sector number register
   bCylLowReg : Byte; // IDE low order cylinder value
   bCylHighReg : Byte; // IDE high order cylinder value
   bDriveHeadReg : Byte; // IDE drive/head register
   bCommandReg : Byte; // Actual IDE command.
   bReserved : Byte; // reserved for future use. Must be zero.
 end;
 IDEREGS = TIDERegs;
 PIDERegs = ^TIDERegs;

 TSendCmdInParams = packed record
   cBufferSize : DWORD; // Buffer size in bytes
   irDriveRegs : TIDERegs; // Structure with drive register values.
   bDriveNumber : Byte; // Physical drive number to send command to (0,1,2,3).
   bReserved : Array[0..2] of Byte; // Reserved for future expansion.
   dwReserved : Array[0..3] of DWORD; // For future use.
   bBuffer : Array[0..0] of Byte; // Input buffer.
 end;
 SENDCMDINPARAMS = TSendCmdInParams;
 PSendCmdInParams = ^TSendCmdInParams;

 TIdSector = packed record
   wGenConfig : Word;
   wNumCyls : Word;
   wReserved : Word;
   wNumHeads : Word;
   wBytesPerTrack : Word;
   wBytesPerSector : Word;
   wSectorsPerTrack : Word;
   wVendorUnique : Array[0..2] of Word;
   sSerialNumber : Array[0..19] of Char;
   wBufferType : Word;
   wBufferSize : Word;
   wECCSize : Word;
   sFirmwareRev : Array[0..7] of Char;
   sModelNumber : Array[0..39] of Char;
   wMoreVendorUnique : Word;
   wDoubleWordIO : Word;
   wCapabilities : Word;
   wReserved1 : Word;
   wPIOTiming : Word;
   wDMATiming : Word;
   wBS : Word;
   wNumCurrentCyls : Word;
   wNumCurrentHeads : Word;
   wNumCurrentSectorsPerTrack : Word;
   ulCurrentSectorCapacity : ULONG;
   wMultSectorStuff : Word;
   ulTotalAddressableSectors : ULONG;
   wSingleWordDMA : Word;
   wMultiWordDMA : Word;
   bReserved : Array[0..127] of Byte;
 end;
 PIdSector = ^TIdSector;

const
 IDE_ID_FUNCTION = $EC;
 IDENTIFY_BUFFER_SIZE = 512;
 DFP_RECEIVE_DRIVE_DATA = $0007c088;
 IOCTL_SCSI_MINIPORT = $0004d008;
 IOCTL_SCSI_MINIPORT_IDENTIFY = $001b0501;
 DataSize = sizeof(TSendCmdInParams)-1+IDENTIFY_BUFFER_SIZE;
 BufferSize = SizeOf(SRB_IO_CONTROL)+DataSize;
 W9xBufferSize = IDENTIFY_BUFFER_SIZE+16;
var
 hDevice : THandle;
 cbBytesReturned : DWORD;
 pInData : PSendCmdInParams;
 pOutData : Pointer; // PSendCmdInParams;
 Buffer : Array[0..BufferSize-1] of Byte;
 srbControl : TSrbIoControl absolute Buffer;

 procedure ChangeByteOrder( var Data; Size : Integer );
 var ptr : PChar;
     i : Integer;
     c : Char;
 begin
   ptr := @Data;
   for i := 0 to (Size shr 1)-1 do
   begin
     c := ptr^;
     ptr^ := (ptr+1)^;
     (ptr+1)^ := c;
     Inc(ptr,2);
   end;
 end;

begin//GetIDEDiskSerialNumber
 Result := '';
 FillChar(Buffer,BufferSize,#0);
 if Win32Platform=VER_PLATFORM_WIN32_NT then
   begin // Windows NT, Windows 2000
     // Get SCSI port handle
     hDevice := CreateFile( '\\.\Scsi0:', GENERIC_READ or GENERIC_WRITE,
       FILE_SHARE_READ or FILE_SHARE_WRITE, nil, OPEN_EXISTING, 0, 0 );
     if hDevice=INVALID_HANDLE_VALUE then Exit;
     try
       srbControl.HeaderLength := SizeOf(SRB_IO_CONTROL);
       System.Move('SCSIDISK',srbControl.Signature,8);
       srbControl.Timeout := 2;
       srbControl.Length := DataSize;
       srbControl.ControlCode := IOCTL_SCSI_MINIPORT_IDENTIFY;
       pInData := PSendCmdInParams(PChar(@Buffer)+SizeOf(SRB_IO_CONTROL));
       pOutData := pInData;
       with pInData^ do
       begin
         cBufferSize := IDENTIFY_BUFFER_SIZE;
         bDriveNumber := 0;
         with irDriveRegs do
         begin
           bFeaturesReg := 0;
           bSectorCountReg := 1;
           bSectorNumberReg := 1;
           bCylLowReg := 0;
           bCylHighReg := 0;
           bDriveHeadReg := $A0;
           bCommandReg := IDE_ID_FUNCTION;
         end;
       end;
       if not DeviceIoControl( hDevice, IOCTL_SCSI_MINIPORT, @Buffer,
         BufferSize, @Buffer, BufferSize, cbBytesReturned, nil ) then Exit;
     finally
       CloseHandle(hDevice);
     end;
   end
 else
   begin // Windows 95 OSR2, Windows 98
     hDevice := CreateFile( '\\.\SMARTVSD', 0, 0, nil, CREATE_NEW, 0, 0 );
     if hDevice=INVALID_HANDLE_VALUE then Exit;
     try
       pInData := PSendCmdInParams(@Buffer);
       pOutData := PChar(@pInData^.bBuffer);
       with pInData^ do
       begin
         cBufferSize := IDENTIFY_BUFFER_SIZE;
         bDriveNumber := 0;
         with irDriveRegs do
         begin
           bFeaturesReg := 0;
           bSectorCountReg := 1;
           bSectorNumberReg := 1;
           bCylLowReg := 0;
           bCylHighReg := 0;
           bDriveHeadReg := $A0;
           bCommandReg := IDE_ID_FUNCTION;
         end;
       end;
       if not DeviceIoControl( hDevice, DFP_RECEIVE_DRIVE_DATA, pInData,
          SizeOf(TSendCmdInParams)-1, pOutData, W9xBufferSize,
          cbBytesReturned, nil ) then Exit;
     finally
       CloseHandle(hDevice);
     end;
   end;
   with PIdSector(PChar(pOutData)+16)^ do
   begin
     ChangeByteOrder(sSerialNumber,SizeOf(sSerialNumber));
     SetString(Result,sSerialNumber,SizeOf(sSerialNumber));
   end;
end;//GetIDEDiskSerialNumber

function CRC32(const IniCRC:Integer;Source:AnsiString):Integer; 
asm 
 Push EBX
 Push ESI
 Push EDI
 Or EDX,EDX
 Jz @Done
 Mov ESI,EDX
 Mov ECX,[EDX-4]
 Jecxz @Done
 Lea EDI,@CRCTbl
 Mov EDX,EAX
 xor EAX,EAX
 Cld
 @L1:
 Lodsb
 Mov EBX,EDX
 xor EBX,EAX
 And EBX,$FF
 Shl EBX,2
 Shr EDX,8
 And EDX,$FFFFFF
 xor EDX,[EDI+EBX]
 Dec ECX
 Jnz @L1
 Mov EAX,EDX
 @Done:
 Pop EDI
 Pop ESI
 Pop EBX
 Ret
 @CRCTbl:
 DD $00000000, $77073096, $ee0e612c, $990951ba
 DD $076dc419, $706af48f, $e963a535, $9e6495a3
 DD $0edb8832, $79dcb8a4, $e0d5e91e, $97d2d988
 DD $09b64c2b, $7eb17cbd, $e7b82d07, $90bf1d91
 DD $1db71064, $6ab020f2, $f3b97148, $84be41de
 DD $1adad47d, $6ddde4eb, $f4d4b551, $83d385c7
 DD $136c9856, $646ba8c0, $fd62f97a, $8a65c9ec
 DD $14015c4f, $63066cd9, $fa0f3d63, $8d080df5
 DD $3b6e20c8, $4c69105e, $d56041e4, $a2677172
 DD $3c03e4d1, $4b04d447, $d20d85fd, $a50ab56b
 DD $35b5a8fa, $42b2986c, $dbbbc9d6, $acbcf940
 DD $32d86ce3, $45df5c75, $dcd60dcf, $abd13d59
 DD $26d930ac, $51de003a, $c8d75180, $bfd06116
 DD $21b4f4b5, $56b3c423, $cfba9599, $b8bda50f
 DD $2802b89e, $5f058808, $c60cd9b2, $b10be924
 DD $2f6f7c87, $58684c11, $c1611dab, $b6662d3d
 DD $76dc4190, $01db7106, $98d220bc, $efd5102a
 DD $71b18589, $06b6b51f, $9fbfe4a5, $e8b8d433
 DD $7807c9a2, $0f00f934, $9609a88e, $e10e9818
 DD $7f6a0dbb, $086d3d2d, $91646c97, $e6635c01
 DD $6b6b51f4, $1c6c6162, $856530d8, $f262004e
 DD $6c0695ed, $1b01a57b, $8208f4c1, $f50fc457
 DD $65b0d9c6, $12b7e950, $8bbeb8ea, $fcb9887c
 DD $62dd1ddf, $15da2d49, $8cd37cf3, $fbd44c65
 DD $4db26158, $3ab551ce, $a3bc0074, $d4bb30e2
 DD $4adfa541, $3dd895d7, $a4d1c46d, $d3d6f4fb
 DD $4369e96a, $346ed9fc, $ad678846, $da60b8d0
 DD $44042d73, $33031de5, $aa0a4c5f, $dd0d7cc9
 DD $5005713c, $270241aa, $be0b1010, $c90c2086
 DD $5768b525, $206f85b3, $b966d409, $ce61e49f
 DD $5edef90e, $29d9c998, $b0d09822, $c7d7a8b4
 DD $59b33d17, $2eb40d81, $b7bd5c3b, $c0ba6cad
 DD $edb88320, $9abfb3b6, $03b6e20c, $74b1d29a
 DD $ead54739, $9dd277af, $04db2615, $73dc1683
 DD $e3630b12, $94643b84, $0d6d6a3e, $7a6a5aa8
 DD $e40ecf0b, $9309ff9d, $0a00ae27, $7d079eb1
 DD $f00f9344, $8708a3d2, $1e01f268, $6906c2fe
 DD $f762575d, $806567cb, $196c3671, $6e6b06e7
 DD $fed41b76, $89d32be0, $10da7a5a, $67dd4acc
 DD $f9b9df6f, $8ebeeff9, $17b7be43, $60b08ed5
 DD $d6d6a3e8, $a1d1937e, $38d8c2c4, $4fdff252
 DD $d1bb67f1, $a6bc5767, $3fb506dd, $48b2364b
 DD $d80d2bda, $af0a1b4c, $36034af6, $41047a60
 DD $df60efc3, $a867df55, $316e8eef, $4669be79
 DD $cb61b38c, $bc66831a, $256fd2a0, $5268e236
 DD $cc0c7795, $bb0b4703, $220216b9, $5505262f
 DD $c5ba3bbe, $b2bd0b28, $2bb45a92, $5cb36a04
 DD $c2d7ffa7, $b5d0cf31, $2cd99e8b, $5bdeae1d
 DD $9b64c2b0, $ec63f226, $756aa39c, $026d930a
 DD $9c0906a9, $eb0e363f, $72076785, $05005713
 DD $95bf4a82, $e2b87a14, $7bb12bae, $0cb61b38
 DD $92d28e9b, $e5d5be0d, $7cdcefb7, $0bdbdf21
 DD $86d3d2d4, $f1d4e242, $68ddb3f8, $1fda836e
 DD $81be16cd, $f6b9265b, $6fb077e1, $18b74777
 DD $88085ae6, $ff0f6a70, $66063bca, $11010b5c
 DD $8f659eff, $f862ae69, $616bffd3, $166ccf45
 DD $a00ae278, $d70dd2ee, $4e048354, $3903b3c2
 DD $a7672661, $d06016f7, $4969474d, $3e6e77db
 DD $aed16a4a, $d9d65adc, $40df0b66, $37d83bf0
 DD $a9bcae53, $debb9ec5, $47b2cf7f, $30b5ffe9
 DD $bdbdf21c, $cabac28a, $53b39330, $24b4a3a6
 DD $bad03605, $cdd70693, $54de5729, $23d967bf
 DD $b3667a2e, $c4614ab8, $5d681b02, $2a6f2b94
 DD $b40bbe37, $c30c8ea1, $5a05df1b, $2d02ef8d
end;

function EncodeMin(const data: String): String;
var
    step:             Integer;
    cur_index:        Integer;
    temp_char:        Char;

begin
    Result:=data;
    if Length(Result) <= 1 then Exit;

    if Pos('_', Result) > 0 then
        Result[Pos('_', Result)]:='G';

    step:=1;
    while (step + 1) <= Length(Result) do
    begin
        cur_index:=1;
        while (cur_index + step) <= Length(Result) do
        begin
            temp_char:=Result[cur_index];
            Result[cur_index]:=Result[cur_index + step];
            Result[cur_index + step]:=temp_char;
            cur_index:=cur_index + step + 1;
        end;
        Inc(step);
    end;
    Result:=Result;
end;

function DecodeMin(const data: String): String;
var
    step:             Integer;
    cur_index:        Integer;
    temp_char:        Char;

begin
    Result:=data;
    if Length(Result) <= 1 then Exit;

    step:=Length(Result) - 1;
    while step >= 1 do
    begin
        cur_index:=1;
        while (cur_index + step) <= Length(Result) do
        begin
            temp_char:=Result[cur_index];
            Result[cur_index]:=Result[cur_index + step];
            Result[cur_index + step]:=temp_char;
            cur_index:=cur_index + step + 1;
        end;
        Dec(step);
    end;

    if Pos('G', Result) > 0 then
        Result[Pos('G', Result)]:='_';

    Result:=Result;
end;

function GetEnvVar(const varName: string): string;
var
    i:            Integer;

begin
    Result:='';
    try
        i:=GetEnvironmentVariable(PChar(varName), nil, 0);
        if i > 0 then
        begin
            SetLength(Result, i);
            GetEnvironmentVariable(PChar(varName), PChar(Result), i);
        end;
    except
        Result:='';
    end;
end;

//шукає файли лише у каталозі aDir (без вкладених підкаталогів) та вертає
//найбільшу дату файлу. Якщо щось не так вертає MinDouble.
function GetCurDate(aDir: string): TDate;

function FileTime2DateTime(FT:_FileTime): TDateTime;
var
    FileTime:           _SystemTime;

begin
    FileTimeToLocalFileTime(FT, FT);
    FileTimeToSystemTime(FT,FileTime);
    Result:=EncodeDate(FileTime.wYear, FileTime.wMonth, FileTime.wDay)+
    EncodeTime(FileTime.wHour, FileTime.wMinute, FileTime.wSecond, FileTime.wMilliseconds);
end;

var
    searchRec:          TSearchRec;
    tempDate:           TDate;
    maxDate:            TDate;

begin
    Result:=0;
    if aDir = '' then Exit;

    maxDate:=MinDouble;
    if aDir <> '' then
        if aDir[length(aDir)] <> '\' then aDir:=aDir + '\';

    if FindFirst(aDir + '*.*', faAnyFile, searchRec) = 0 then
    begin
        repeat
            tempDate:=FileTime2DateTime(searchRec.FindData.ftLastAccessTime);
            if tempDate > maxDate then
                maxDate:=tempDate;
        until FindNext(searchRec) <> 0;
    end;
    SysUtils.FindClose(searchRec);
    Result:=maxDate;
end;

function GetLocalIP: String;
var
    WSAData:
    TWSAData;
    SockAddrIn:     TSockAddrIn;
    Host:           PHostEnt;  // Эти переменные объявлены в Winsock.pas
    comp_name:      PChar;
    name_size:      Cardinal;

begin
    Result:='';
    if WSAStartup($101, WSAData) = 0 then
    begin
//        Host:=GetHostByName(@Localname[1]);
        name_size:=MAX_COMPUTERNAME_LENGTH + 1;
        GetMem(comp_name, name_size);
        try
            if GetComputerName(comp_name, name_size) then
            begin
                Host:=GetHostByName(comp_name);
                if Host<>nil then
                begin
                    SockAddrIn.sin_addr.S_addr:=longint(plongint(Host^.h_addr_list^)^);
                    Result:=inet_ntoa(SockAddrIn.sin_addr);
                end;
                WSACleanUp;
            end;
        finally
            FreeMem(comp_name, name_size);
        end;
    end;
end;

function GetLocalHostAddress: string;
var
    SockAddrIn:       TSockAddrIn;
    HostEnt:          PHostEnt;
    szHostName:       array[0..128] of Char;

begin
    if GetHostName(szHostName, 128) = 0 then
    begin
        HostEnt:=GetHostByName(szHostName);
        if HostEnt = nil then
            Result:= ''
        else begin
            SockAddrIn.sin_addr.S_addr:=longint(plongint(HostEnt^.h_addr_list^)^);
            Result:=inet_ntoa(SockAddrIn.sin_addr);
        end;
    end
    else begin
        //Error handle
    end;
end;

function my_ip_address: string;
const
    BUF_SIZE = 255;

var
    buf:            Pointer;
    HostEnt :       PHostEnt;//Не освобождайте это!
    SockAddrIn:     TSockAddrIn;
    ipInt:          Longint;

begin
    buf:=nil;
    try
        GetMem(buf, BUF_SIZE);
        Winsock.GetHostname(buf, BUF_SIZE);//это может работать и без сети
        HostEnt:=Winsock.GetHostByName(buf);
        if HostEnt = nil then
        begin
            ipInt:=Winsock.htonl($07000001)// 127.0.0.1
        end
        else begin
            ipInt:=Longint(PLongint(HostEnt^.h_addr_list^)^);
        end;
        SockAddrIn.sin_addr.S_addr:=ipInt;
    finally
        if buf <> nil then  FreeMem(buf, BUF_SIZE);
    end;
    Result:=Winsock.inet_ntoa(SockAddrIn.sin_addr);
end;

end.
