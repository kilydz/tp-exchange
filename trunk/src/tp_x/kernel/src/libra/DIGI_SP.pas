unit DIGI_SP;
 { Модуль для роботи з вагами SP-80SX, SP-90, SP-300, SP-500
   з використанням драйвера TWSWTCP.dll}
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
{ Увага! Підтримуються такі типи штрихкода:
    5: F1F2 CCCCC ZXXXX CD 0
    9: F1F2 CCCC ZXXXXX CD 0
    Де F1F2 - flag, С..С :номер ПЛУ, Х..Х :вага, CD -Контрольна сума (Обидва EAN-13)}
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
  Result := '54' +        //1-ий байт 1-ого статусу (ваговий товар, друк дати упаковки і продажу, час продажу)
            '00' +        //2-ий байт 1-ого статуса (час упакування - з встроєних ваг, ціна за 1 Кг)
            '0D' +        //1-ий байт 2-ого статусу (Використовується основна група по замовчуванні.
                          //Нема полів тари, кількості, собівартості. Є поля артикула штрихкоду,
                          //формат штрихкоду, і формат 1-ої етикетки. Друге етикетка не друкується)
            '26' +        //2-ий байт 2-ого статусу. В записі товару присутня назва товару, інгредієнти
                          //і спец. повідомлення друкуються по посиланні. Розділи посилань і ситності відсутні.
            '01' +        //3-ій байт 2-ого статусу. Є поле для строку продажу в днях, Поля строку використання,
                          //сроку продажу в годинах, і сроку упакування в днях. Нема полів бонуса й номеру місця зберігання
            FloatToBCD(price, 4) +     //ціна
            '11' ;        //Номер формату етикетки - використовуватиметься вільний формат F1
  if (barcode_type = 5) then
  begin
    Result := Result + '05' +        //Формат штрих-коду (2 цифри - флаг, 5 - артикул і 5 - вага)
            flag + IntToBCDLen(nomen_No, 5) + '0000000' ; //дані штрих-коду
  end else
  //if (barcode_type = 9) then
  begin
    Result := Result + '09' +        //Формат штрих-коду (2 цифри - флаг, 4 - артикул і 6 - вага)
            flag + IntToBCD(nomen_No, 2)    + '00000000' ; //дані штрих-коду
  end;

  Result := Result + '0003' +  //Срок продажу в днях
            '01' +        //номер спец повідомлення
            '01' +        //номер інгредієнту
            DigiFormatedName(nomen_name) + //В правильному вигляді згенерована назва товару
            '00';         //Контрольна сума (Для файлів котрі йдуть НА вагу завжди '00')
  Result := IntToBCD(Nomen_No, 4) + //Номер товару (по якому його потім пробивають)
            IntToHEX((Length(Result) div 2) + 6, 2) + //Довжина запису в умовних байтах
            Result;
end;

function DigiGenStringError(mes :TOperationResult):string;
begin
 case mes of
  NON_ERROR           :Result := 'Операція відбулась без помилки';
  OPEN_FILE_ERR       :Result := 'ПОМИЛКА відкриття файлу (OPEN_LILE_ERR)';
  READ_FILE_ERR       :Result := 'ПОМИЛКА читання файлу (READ_FILE_ERR)';
  WRITE_FILE_ERR      :Result := 'ПОМИЛКА запису в файл (WRITE_FILE_ERR)';
  NETWORK_OPEN_ERR    :Result := 'ПОМИЛКА з''єднання з вагою (NETWORK_OPEN_ERR)';
  NETWORK_READ_ERROR  :Result := 'ПОМИЛКА прийняття даних з ваги (NETWORK_READ_ERROR)';
  NETWORK_WRITE_ERR   :Result := 'ПОМИЛКА посилання даних на вагу (NETWORK_WRITE_ERR)';
  MACHINE_READ_ERR    :Result := 'ПОМИЛКА: Вага вернула код помилки читання (MACHINE_READ_ERR)';
  MACHINE_WRITE_ERR   :Result := 'ПОМИЛКА: Вага вернула код помилки запису (MACHINE_WRITE_ERR)';
  MACHINE_NOREC_ERR   :Result := 'ПОМИЛКА: Вага вернула код помилки "Немає запису" (MACHINE_NOREC_ERR)';
  MACHINE_SPASE_ERR   :Result := 'ПОМИЛКА: Вага вернула код помилки "Немає вільного місця" (MACHINE_SPASE_ERR)';
  MACHINE_UNDEF_ERR   :Result := 'ПОМИЛКА: Вага вернула код невідомої помилки (MACHINE_UNDEF_ERR)';
 end;
end;

end.
