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

//Перетворює рядок з датою формату DATE_FORMAT у рядок формату NEW_DATE_FORMAT
//Функціональними є комбінації символів виду
// dd - день
// mm - місяць
// yyyy - рік у звичайному форматі
// решта комбінація символів розцінюється, як символи форматування тексту
function ApplyNewFormat(Date, DATE_FORMAT, NEW_DATE_FORMAT:string):string;
var i: integer;
    dd, mm: string[2];
    yyyy: string[4];
begin
  Result := Date;
  if Length(Date)<>Length(DATE_FORMAT) then
    Exit //Неправильні вхідні дані
  else
  begin
    //Підготовка вхідних даних
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
//Функція котра повертає "Дату смерті" - дату завершення ліцензії,
//котра встановлюється при реєстрації програми
//Якщо повертається 0 (12/30/1899 12:00 am) значить відбулася помилка
//(при читанні файлу, розшифруванні або неспівпадання SN жорсткого диску)
function GetDateOfDeath(var a_veles_info: ZVelesInfoRec): TDateTime; stdcall;
var
    f:                 TextFile;
    crypted_str:       string;
    key_fname:         String;
    uncryp_str:        string;
    key_sn, hdd_sn:    string;
    key_date:          string;
begin
//    можна також використати ip машини
//    ed_ip.Text:=GetLocalIP;
    Result := 0;
    hdd_sn:=Trim(GetIDEDiskSerialNumber);
    if hdd_sn = '' then
    begin//неможливо отримати серійник вінта - використовуємо серійник по замовчуванню
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
        if crypted_str = '' then//неможливо зчитати ключ
        begin
            Exit;
        end;
        uncryp_str:=DecodeMin(crypted_str);//розшифрували

        if Pos('_', uncryp_str) <= 0 then
        begin//ключ не розділений на дату смерті та серійний номер вінта - отже сміття
            Exit;
        end;
        key_sn:=Copy(uncryp_str, Pos('_', uncryp_str) + 1, Length(uncryp_str));
        if (hdd_sn <> key_sn) then//серійник вінта у ключі та реальний серійник машини не збігаються
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



//функція перевіряє чи має користувач (a_veles_info.user_id) право на
//використання програми;
//якщо користувач має право і функція нормально виконується, то вертає RESULT_OK
//(див. veles_h); якщо не має права - RESULT_CANCEL; якщо під час виконання
//функції відбувається якась помилка вертає - RESULT_FAIL;
//Також дана функція ініціалізує виділення "дати смерті" з реєстраційного ключа
//а у разі відсутності чи невірності останнього(ключа), повертає - RESULT_CANCEL
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
