unit shtrih_print;
{Модуль для роботи з вагами Штрих-Принт з використанням оле-драйвера}

interface

uses SysUtils, Classes, Windows, ComObj;

const PassWord = 30;

function ShtrihPrInitDriver(var LP: Variant; mes: string):boolean;
function ShtrihPrEthernetConnect(var LP: Variant; IP:string):boolean;
function ShtrihPrEthernetDisconnect(var LP: Variant):integer;

function ShtrihPrPLUCount(var LP: Variant):integer;

function ShtrihPrAddNomen(var LP: Variant; Nomen_no, nomen_code:integer; nomen_name:string; price:real):integer;

function ShtrihPrGenStringError(var LP: Variant):string;

procedure ShtrihPrSetBarcodePropertys(var LP: Variant;  flag: string);

implementation

procedure ShtrihPrFormatedName(Name:string; var FirstLine, SecondLine:string);
const
  FirstLineLength :integer = 18;
  MaxLineLength   :integer = 18;
begin
  if length(Name) < FirstLineLength then
  begin
    FirstLine   := Name;
    SecondLine  := '';
  end
  else // length(Name) < FirstLineLength then
  begin
    FirstLine := Copy(Name, 0, MaxLineLength);
    if Pos(' ', FirstLine) > 0 then
    begin
      while (FirstLine[Length(FirstLine)] <> ' ') do
        Delete(FirstLine, Length(FirstLine), 1);
      Delete(FirstLine, Length(FirstLine), 1);
    end;

    SecondLine := Copy(Name, Length(FirstLine) + 2, MaxLineLength);
  end;
end;

function ShtrihPrInitDriver(var LP: Variant; mes: string):boolean;
var i,j:integer;
    ms,ls:DWORD;
begin
  Result := True;
  try
    LP:=CreateOleObject('AddIn.DrvLP');
  except
    on EOleError do begin
      mes := 'Увага! Драйвер "Штрих-Принт" не встановлено';
      Result := False;
    end;
  end;
  try
    ms:=LP.FileVersionMS;
    ls:=LP.FileVersionLS;
  except
    ms:=0;
    ls:=0;
  end;
  if (ms<$00010001) or ((ms=$00010001) and (ls<$00030000)) then begin
    mes := 'Увага! Встановлено стару версію драйверу'#13#10'Встановіть драйвер версії A.1.3 або вище';
    Result := False;
  end;
end;

function ShtrihPrEthernetConnect(var LP: Variant; IP:string):boolean;
begin
  LP.DeviceInterface := 1;
  LP.RemoteHost      := IP;
  LP.RemotePort      := 1111;
  LP.LocalPort       := 2000;
  LP.TimeoutUDP      := 500;
  LP.BroadcastPause  := 500;
  LP.Synchronize     := False;
  LP.Broadcast       := False;

  LP.Connect;
  if LP.ResultCode = 0 then
    Result := True
  else
    Result := False;
end;

function ShtrihPrEthernetDisconnect(var LP: Variant):integer;
begin
  LP.Disconnect;
  Result := 1;
end;

function ShtrihPrAddNomen(var LP: Variant; Nomen_no, nomen_code:integer; nomen_name:string; price:real):integer;
var FirstLine, SecondLine :string;
begin
  LP.Password      := PassWord;
  LP.PLUNumber     := Nomen_No;
  LP.ItemCode      := nomen_code;
  ShtrihPrFormatedName(nomen_name, FirstLine, SecondLine);
  LP.NameFirst     := FirstLine;
  LP.NameSecond    := SecondLine;
  LP.Price         := price;
  LP.ShelfLife     := 30; //Строк зберігання
  LP.Tare          := 0;  //Тара
  LP.GroupCode     := 1;  //Груповий код
  LP.MessageNumber := 1;  //Номер повідомлення
  LP.PictureNumber := 1;  //Номер картинки
  LP.ROSTEST       := 1;  //Код РОСТЕСТ
//  LP.GoodsType     := 0;
//  try
//    LP.ExpiryDate  := date;
//  except
//    LP.ExpiryDate:=EncodeDate(1,1,1);
//  end;
  LP.SetPLUData;
  //LP.SetPLUDataEx;
  Result := $50;
end;

function ShtrihPrGenStringError(var LP: Variant):string;
begin
  if LP.ResultCode <> 0 then
  begin
    Result := 'Помилка! ' + IntToStr(LP.ResultCode)+': '+LP.ResultCodeDescription;
    if LP.ResultCode = -13 then
      Result := Result + #13#10' (' + LP.Invader+': '+IntToStr(LP.InvaderPort)+')';
  end;
//  if LP.IsPreviousAnswer then begin
//    LP.GetPreviousAnswer;
//    Result := Result + #13#10'Прийшла відповідь на попередню команду';
//  end;
end;

function ShtrihPrPLUCount(var LP: Variant):integer;
begin
  Result := LP.PLUCount;
end;

procedure ShtrihPrSetBarcodePropertys(var LP: Variant; flag: string);
begin
  LP.Password  := PassWord;
  LP.PLUAccess := 0;
  LP.SetPLUAccess;

  LP.Password := PassWord;
  LP.BCFormat := 7;
  LP.SetBCFormat;

  LP.Password     := PassWord;
  LP.PrefixBCType := 2;
  LP.SetPrefixBCType;

  LP.Password   := PassWord;
  LP.PrefixBCPieceGoods := 20;
  LP.SetPiecePrefixBC;

  LP.Password   := PassWord;
  LP.PrefixBCTotalLabel := 23;
  LP.SetTotalPrefixBC;

  LP.Password := PassWord;
  LP.PrefixBCWeightGoods := StrToInt(flag);
  LP.SetWeightPrefixBC;
end;

end.
