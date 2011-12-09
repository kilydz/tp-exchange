unit DIGI_SP;
 { ������ ��� ������ � ������ SP-80SX, SP-90, SP-300, SP-500
   � ������������� �������� TWSWTCP.dll}
interface

uses Convertation, SysUtils, Classes;

type TOperation = (UPLOAD, DOWNLOAD, ERASEPLULIST, ERASEOBJECT);
type TOperationResult =
        (NON_ERROR, OPEN_FILE_ERR, READ_FILE_ERR, WRITE_FILE_ERR,
         NETWORK_OPEN_ERR, NETWORK_READ_ERROR, NETWORK_WRITE_ERR,
         MACHINE_READ_ERR, MACHINE_WRITE_ERR, MACHINE_NOREC_ERR,
         MACHINE_SPASE_ERR, MACHINE_UNDEF_ERR);

function StrToDigiASCII(str:string):string;
function IntToBCD(value, ByteCount:Integer):string;
function IntToBCDLen(value, Leng:Integer):string;
function FloatToBCD(value:real; ByteCount:Integer):string;
function IntToHEX(value:Integer; ByteCount:Integer):string;
function DigiFormatedName(Name:string):string;

function DigiGenStringError(mes :TOperationResult):string;

function DigiExecute(Operation: TOperation; ScaleIP, FileName:PChar; Command :BYTE):TOperationResult;   stdcall
    external 'digiTCPdrv.dll' name 'Execute';

function DigiGenNomenLine(nomen_No:integer; flag:string; nomen_name:string; price:real; barcode_type:byte):string;
{ �����! ϳ����������� ��� ���� ���������:
    5: F1F2 CCCCC ZXXXX CD 0
    9: F1F2 CCCC ZXXXXX CD 0
    �� F1F2 - flag, �..� :����� ���, �..� :����, CD -���������� ���� (������ EAN-13)}
implementation

function StrToDigiASCII(str:string):string;
var i:Integer;
begin
  str := WinToDOS(str);
  Result := '';
  for I := 1 to length(str) do
    Result := Result + DEC2HEX(ord(str[i]));
end;

function IntToBCD(value, ByteCount:Integer):string;
var diff, i: integer;
begin
  Result := IntToStr(value);
  diff := 2*ByteCount - length(Result);
  if (diff > 0) then
    for i := 1 to diff do
      Result := '0' + Result;
end;

function IntToBCDLen(value, Leng:Integer):string;
var diff, i: integer;
begin
  Result := IntToStr(value);
  diff := Leng - length(Result);
  if (diff > 0) then
    for i := 1 to diff do
      Result := '0' + Result;
end;

function FloatToBCD(value:real; ByteCount:Integer):string;
var str_val, before_point, after_point:string;
    i, val_diff: integer;
    is_point: boolean;
    ch: char;
begin
  if value < 0.002     then  value := 0.00 else
  if value > 999999.99 then  value := 999999.99;

  value := value + 0.005;

  str_val := FloatToStr(value);

  Result       := '';
  after_point  := '';
  before_point := '';
  is_point     := False;

  for I := 1 to length(str_val) do
  begin
    ch := str_val[i];
    if ch = ',' then is_point := True
    else
    begin
      if is_point then
        after_point  := after_point + ch
      else
        before_point := before_point + ch;
    end;
  end;

  val_diff     := 6 - length(before_point);
  for I := 1 to val_diff do
    Result := '0' + Result;
  if val_diff < 0 then
    before_point := Copy(before_point, -val_diff - 1, 6);

  after_point := copy(after_point, 0, 2);
  if length(after_point) = 1 then after_point := after_point + '0' else
  if length(after_point) = 0 then after_point := '00';

  Result := Result + before_point + after_point;
end;

function IntToHEX(value:Integer; ByteCount:Integer):string;
var diff, i: integer;
begin
  Result := DEC2HEX(value);
  diff := 2*ByteCount - length(Result);
  if (diff > 0) then
    for i := 1 to diff do
      Result := '0' + Result;
end;

function DigiFormatedName(Name:string):string;
const
  FirstLineLength :integer = 18;
  MaxLineLength   :integer = 26;
var
  FirstLine, SecondLine: string;
begin
  if length(Name) < FirstLineLength then
  begin
    Result := '08' + IntToHEX(length(Name), 1) + StrToDigiASCII(Name) + '0C';
  end
  else // length(Name) < FirstLineLength then
  begin
    FirstLine := Copy(Name, 0, MaxLineLength);
    if Pos(' ',FirstLine) > 0 then
    begin
      while (FirstLine[Length(FirstLine)] <> ' ') do
        Delete(FirstLine, Length(FirstLine), 1);
      Delete(FirstLine, Length(FirstLine), 1);
    end;

    SecondLine := Copy(Name, Length(FirstLine) + 2, MaxLineLength);
    Result := '04' + IntToHEX(length(FirstLine),  1) + StrToDigiASCII(FirstLine)  + '0D' +
              '04' + IntToHEX(length(SecondLine), 1) + StrToDigiASCII(SecondLine) + '0C';
  end;
end;

function DigiGenNomenLine(nomen_No:integer; flag:string; nomen_name:string; price:real; barcode_type:byte):string;
begin
  flag := Copy(flag, 0, 2);
//  try flag := IntToBCD(IntToStr(flag) ,1); except flag := '00' end;
  Result := '54' +        //1-�� ���� 1-��� ������� (������� �����, ���� ���� �������� � �������, ��� �������)
            '00' +        //2-�� ���� 1-��� ������� (��� ���������� - � �������� ���, ���� �� 1 ��)
            '0D' +        //1-�� ���� 2-��� ������� (��������������� ������� ����� �� �����������.
                          //���� ���� ����, �������, ����������. � ���� �������� ���������,
                          //������ ���������, � ������ 1-� ��������. ����� �������� �� ���������)
            '26' +        //2-�� ���� 2-��� �������. � ����� ������ �������� ����� ������, �����䳺���
                          //� ����. ����������� ���������� �� ��������. ������ �������� � ������� ������.
            '01' +        //3-�� ���� 2-��� �������. � ���� ��� ������ ������� � ����, ���� ������ ������������,
                          //����� ������� � �������, � ����� ���������� � ����. ���� ���� ������ � ������ ���� ���������
            FloatToBCD(price, 4) +     //����
            '11' ;        //����� ������� �������� - ��������������������� ������ ������ F1
  if (barcode_type = 5) then
  begin
    Result := Result + '05' +        //������ �����-���� (2 ����� - ����, 5 - ������� � 5 - ����)
            flag + IntToBCDLen(nomen_No, 5) + '0000000' ; //��� �����-����
  end else
  //if (barcode_type = 9) then
  begin
    Result := Result + '09' +        //������ �����-���� (2 ����� - ����, 4 - ������� � 6 - ����)
            flag + IntToBCD(nomen_No, 2)    + '00000000' ; //��� �����-����
  end;

  Result := Result + '0003' +  //���� ������� � ����
            '01' +        //����� ���� �����������
            '01' +        //����� �����䳺���
            DigiFormatedName(nomen_name) + //� ����������� ������ ����������� ����� ������
            '00';         //���������� ���� (��� ����� ���� ����� �� ���� ������ '00')
  Result := IntToBCD(Nomen_No, 4) + //����� ������ (�� ����� ���� ���� ����������)
            IntToHEX((Length(Result) div 2) + 6, 2) + //������� ������ � ������� ������
            Result;
end;

function DigiGenStringError(mes :TOperationResult):string;
begin
 case mes of
  NON_ERROR           :Result := '�������� �������� ��� �������';
  OPEN_FILE_ERR       :Result := '������� �������� ����� (OPEN_LILE_ERR)';
  READ_FILE_ERR       :Result := '������� ������� ����� (READ_FILE_ERR)';
  WRITE_FILE_ERR      :Result := '������� ������ � ���� (WRITE_FILE_ERR)';
  NETWORK_OPEN_ERR    :Result := '������� �''������� � ����� (NETWORK_OPEN_ERR)';
  NETWORK_READ_ERROR  :Result := '������� ��������� ����� � ���� (NETWORK_READ_ERROR)';
  NETWORK_WRITE_ERR   :Result := '������� ��������� ����� �� ���� (NETWORK_WRITE_ERR)';
  MACHINE_READ_ERR    :Result := '�������: ���� ������� ��� ������� ������� (MACHINE_READ_ERR)';
  MACHINE_WRITE_ERR   :Result := '�������: ���� ������� ��� ������� ������ (MACHINE_WRITE_ERR)';
  MACHINE_NOREC_ERR   :Result := '�������: ���� ������� ��� ������� "���� ������" (MACHINE_NOREC_ERR)';
  MACHINE_SPASE_ERR   :Result := '�������: ���� ������� ��� ������� "���� ������� ����" (MACHINE_SPASE_ERR)';
  MACHINE_UNDEF_ERR   :Result := '�������: ���� ������� ��� ������� ������� (MACHINE_UNDEF_ERR)';
 end;
end;

end.
