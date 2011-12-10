library start;

uses
  FastShareMem,
  SysUtils,
  Classes,
  kernel_h,
  utils_h,
  crypt_h,
  secure_h,
  functional in 'functional.pas';

{$R *.res}

//���������� ����� � ����� ������� DATE_FORMAT � ����� ������� NEW_DATE_FORMAT
//��������������� � ��������� ������� ����
// dd - ����
// mm - �����
// yyyy - �� � ���������� ������
// ����� ��������� ������� ������������, �� ������� ������������ ������
function ApplyNewFormat(Date, DATE_FORMAT, NEW_DATE_FORMAT:string):string;
var i: integer;
    dd, mm: string[2];
    yyyy: string[4];
begin
  Result := Date;
  if Length(Date)<>Length(DATE_FORMAT) then
    Exit //���������� ����� ���
  else
  begin
    //ϳ�������� ������� �����
    dd := Copy(Date, Pos('dd', DATE_FORMAT), 2);
    mm := Copy(Date, Pos('mm', DATE_FORMAT), 2);
    yyyy := Copy(Date, Pos('yyyy', DATE_FORMAT), 4);
    //
    i := Pos('dd', NEW_DATE_FORMAT);
    Delete(NEW_DATE_FORMAT, i, 2);
    Insert(dd, NEW_DATE_FORMAT, i);

    i := Pos('mm', NEW_DATE_FORMAT);
    Delete(NEW_DATE_FORMAT, i, 2);
    Insert(mm, NEW_DATE_FORMAT, i);

    i := Pos('yyyy', NEW_DATE_FORMAT);
    Delete(NEW_DATE_FORMAT, i, 4);
    Insert(yyyy, NEW_DATE_FORMAT, i);

    Result := NEW_DATE_FORMAT;
  end;
end;
//������� ����� ������� "���� �����" - ���� ���������� ����糿,
//����� �������������� ��� ��������� ��������
//���� ����������� 0 (12/30/1899 12:00 am) ������� �������� �������
//(��� ������ �����, ������������ ��� ������������ SN ��������� �����)
function GetDateOfDeath(var a_veles_info: ZVelesInfoRec): TDateTime; stdcall;
var
    f:                 TextFile;
    crypted_str:       string;
    key_fname:         String;
    uncryp_str:        string;
    key_sn, hdd_sn:    string;
    key_date:          string;
begin
//    ����� ����� ����������� ip ������
//    ed_ip.Text:=GetLocalIP;
    Result := 0;
    hdd_sn:=Trim(GetIDEDiskSerialNumber);
    if hdd_sn = '' then
    begin//��������� �������� ������� ���� - ������������� ������� �� ������������
        hdd_sn:=DEFAULT_DISK_SN;
    end;
    hdd_sn:=IntToHex(CRC32(Length(hdd_sn), hdd_sn), HEX_DIGITS);

    key_fname := a_veles_info.prog_way + KEY_FILE_NAME;
    if not FileExists(key_fname) then
    begin
        Exit;
    end;
    AssignFile(f, key_fname);
    try//finally
        Reset(f);
        ReadLn(f, crypted_str);
        if crypted_str = '' then//��������� ������� ����
        begin
            Exit;
        end;
        uncryp_str:=DecodeMin(crypted_str);//������������

        if Pos('_', uncryp_str) <= 0 then
        begin//���� �� ��������� �� ���� ����� �� ������� ����� ���� - ���� �����
            Exit;
        end;
        key_sn:=Copy(uncryp_str, Pos('_', uncryp_str) + 1, Length(uncryp_str));
        if (hdd_sn <> key_sn) then//������� ���� � ����� �� �������� ������� ������ �� ���������
        begin
            Exit;
        end;
        key_date := Copy(uncryp_str, 1, Pos('_', uncryp_str)-1);
        try
          Result := StrToDate(ApplyNewFormat(key_date, DATE_FORMAT, CURENT_DATE_FORMAT));
        except
          Exit;
        end;
    finally
        CloseFile(f);
    end;
end;//function GetDateOfDeath(var a_veles_info: ZVelesInfoRec): TDateTime;



//������� �������� �� �� ���������� (a_veles_info.user_id) ����� ��
//������������ ��������;
//���� ���������� �� ����� � ������� ��������� ����������, �� ����� RESULT_OK
//(���. veles_h); ���� �� �� ����� - RESULT_CANCEL; ���� �� ��� ���������
//������� ���������� ����� ������� ����� - RESULT_FAIL;
//����� ���� ������� �������� �������� "���� �����" � ������������� �����
//� � ��� ��������� �� �������� ����������(�����), ������� - RESULT_CANCEL
function GetStartResult(var a_veles_info: ZVelesInfoRec): Integer; stdcall;
begin
    try
        a_veles_info.user_id:=GetUserID(a_veles_info.db_handle, a_veles_info.user_name);
        if HasUserAccessEx(a_veles_info, ACCESS_TO_PROGRAM) then
        begin
            a_veles_info.custom_data.DateOfDeath := GetDateOfDeath(a_veles_info);
            if a_veles_info.custom_data.DateOfDeath = 0 then
              Result:=RESULT_CANCEL
            else
            begin
              Result:=RESULT_OK;
              RunTD10Correct(a_veles_info);
            end;
        end
        else begin
            Result:=RESULT_CANCEL;
        end;
    except
        on E:Exception do
        begin
            Result:=RESULT_FAIL;
            ErrorDialog(E.Message, 'GetStartResult');
        end;
    end;
end;

exports
    GetStartResult;

begin
end.
