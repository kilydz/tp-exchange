unit docrec_dr10;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, etalon_dr, dxCntner, IBSQL, IBDatabase, DB, Grids, ExtCtrls,
  uZMaster, document_h, kernel_h, dxEditor, dxExEdtr, dxEdLib, StdCtrls, genstor_h,
  secure_h;

type
  Tfdocrec_dr10 = class(Tfetalon_dr)
    Label2: TLabel;
    Label4: TLabel;
    Label3: TLabel;
    Label5: TLabel;
    Label9: TLabel;
    ed_discount: TdxCalcEdit;
    Label10: TLabel;
    Label6: TLabel;
    ed_markup: TdxCalcEdit;
    Label7: TLabel;
    Label8: TLabel;
    ed_inprice: TdxEdit;
    procedure EditsChange(Sender: TObject);
    procedure ed_markupChange(Sender: TObject);
    procedure ed_discountChange(Sender: TObject);
    function LastInPrice: real;
  private
    { Private declarations }
    real_price: real;
  public
    { Public declarations }
    procedure InitInfo; override;
    procedure InitINS; override;
    procedure InitUPD; override;
    procedure InitControls; override;

    function  AnalizChanges: integer; override;
    procedure ApplyChanges; override;
    procedure ApplyControls; override;
    procedure ApplyINS; override;
    procedure ApplyUPD; override;

    procedure RecalcInpriceAndMarkup;
  end;

function DocrecDialogDR10(id: integer; nomen_id: integer; resulted: lpZDocrecDialogResulted; var prm: ZVelesInfoRec): integer;

implementation

{$R *.dfm}

function RoundEx( Z: Double; Precision : Integer ): Double;
{Precision : 1 - до цілих, 10 - до десятих, 100 - до сотих...}
var
  ScaledFractPart, Temp : Double;
begin
  ScaledFractPart := Frac(Z)*Precision;
  Temp := Frac(ScaledFractPart);
  ScaledFractPart := Int(ScaledFractPart);
  if Temp >= 0.5 then ScaledFractPart := ScaledFractPart + 1;
  if Temp <= -0.5 then ScaledFractPart := ScaledFractPart - 1;
  RoundEx := Int(Z) + ScaledFractPart/Precision;
end;

function DocrecDialogDR10(id: integer; nomen_id: integer; resulted: lpZDocrecDialogResulted; var prm: ZVelesInfoRec): integer;
var
  dlg: Tfdocrec_dr10;
  returned: integer;
begin
// Перевірка прав
  returned := 0;
try
// Створення та ініціалізація форми діалогу.
    dlg := Tfdocrec_dr10.Create(Application);
    dlg.id := id;
    dlg.nomen_id := nomen_id;
    dlg.prm := prm;
    dlg.resulted := resulted;

    dlg.InitInfo;

// Візуалізація діалогу
    if (dlg.ShowModal = mrOk) then
    begin
      returned := dlg.resulted.docrec_id;
    end;
finally
  if dlg <> nil then dlg.Free;
end;
//    returned <= 0 - код помилки, або відмова;
//    returned > 0  - id результату;
  Result := returned;
end;

//------------------------------------------------------------------------------
function FormatData(s: String; i: Integer): String;
begin
  Result:=FloatToStr(Round(StrToFloat(s)*exp(i*ln(10)))/(exp(i*ln(10))));
end;
//------------------------------------------------------------------------------
procedure Tfdocrec_dr10.InitInfo;
begin
  inherited InitInfo;
  real_price := StrToFloat(ed_price_pdv.Text);
  if real_price <> 0 then
    ed_discount.Text := FormatData(FloatToStr((real_price - StrToFloat(ed_price_pdv.Text))*100/real_price),6);
  //Налаштування націнки
  if resulted.document.discont < 0 then
   ed_markup.Text := FloatToStr(resulted.document.discont * (-100));
end;

function Tfdocrec_dr10.LastInPrice: real;
begin
  if trR.InTransaction then trR.Commit;
  trR.StartTransaction;
  qR.SQL.Text := 'select last_inprice from T_RESTS where nomen_id ='+IntToStr(resulted.nomen.nomen_id);
  qR.ExecQuery;
  Result := qR.FieldByName('last_inprice').AsFloat;
  if trR.InTransaction then trR.Commit;
end;

procedure Tfdocrec_dr10.RecalcInpriceAndMarkup;
var inprice_pdv: real;
begin
  if (GetConfig(prm.db_handle, 3, 'store_documents') = 'yes') then
  begin
    inprice_pdv := LastInPrice;
  end else
    inprice_pdv := CurrentInPricePDV;
  if refresh_enabled then
  begin
    refresh_enabled := false;
    if (inprice_pdv = 0) then
      ed_markup.Text := FloatToStr(0.00)
    else
      ed_markup.Text := FloatToStr(RoundEx(((resulted.price_pdv - inprice_pdv) / inprice_pdv) * 100.0,1000));
    ed_inprice.Text := FloatToStr(RoundEx(inprice_pdv,1000));
    if real_price <> 0 then
      ed_discount.Text := FormatData(FloatToStr((real_price - StrToFloat(ed_price_pdv.Text))*100/real_price),6);
    refresh_enabled := true;
  end;
end;

procedure Tfdocrec_dr10.EditsChange(Sender: TObject);
begin
  inherited EditsChange(Sender);
  ReCalcInPriceAndMarkup;
end;

procedure Tfdocrec_dr10.ed_discountChange(Sender: TObject);
begin
  if refresh_enabled then
  begin
    refresh_enabled := false;
    if ed_discount.Text <> '' then
      ed_price_pdv.Text := FloatToStr(real_price * (100 - StrToFloat(ed_discount.Text))/100);
    refresh_enabled := true;

    CalcFromPricePDV;
  end;
end;

procedure Tfdocrec_dr10.InitINS;
begin
  inherited InitINS;
end;

procedure Tfdocrec_dr10.InitUPD;
begin
  inherited InitUPD
end;

procedure Tfdocrec_dr10.InitControls;
begin
  inherited InitControls;
end;

function Tfdocrec_dr10.AnalizChanges: integer;
var returned: integer;
begin
  returned := inherited AnalizChanges;


  AnalizChanges := returned;
end;

procedure Tfdocrec_dr10.ApplyChanges;
begin
  inherited ApplyChanges;
end;

procedure Tfdocrec_dr10.ApplyControls;
begin
  inherited ApplyControls;
end;

procedure Tfdocrec_dr10.ApplyINS;
begin
  qW.SQL.Text := 'select odocrec_id from PS_DOCREC_TD10_INS (:idocument_id, :inomen_id, ' +
                     ' :ikilk, :iprice, :idiscount)';
  qW.ParamByName('idocument_id').AsInteger    := resulted.document.document_id;
  qW.ParamByName('inomen_id').AsInteger       := resulted.nomen.nomen_id;
  qW.ParamByName('ikilk').AsCurrency          := resulted.kilk;
  qW.ParamByName('iprice').AsCurrency         := resulted.price_pdv;
  qW.ParamByName('idiscount').AsCurrency      := resulted.discount;
  qW.ExecQuery;
  resulted.docrec_id := qW.FieldByName('odocrec_id').AsInteger;
end;

procedure Tfdocrec_dr10.ApplyUPD;
begin
  qW.SQL.Text := 'select okilk from PS_DOCREC_TD10_UPD (:idocrec_id, ' +
                     ' :ikilk, :iprice, :idiscount)';
  qW.ParamByName('idocrec_id').AsInteger      := resulted.docrec_id;
  qW.ParamByName('ikilk').AsCurrency          := resulted.kilk;
  qW.ParamByName('iprice').AsCurrency         := resulted.price_pdv;
  qW.ParamByName('idiscount').AsCurrency      := resulted.discount;
  qW.ExecQuery;
end;

procedure Tfdocrec_dr10.ed_markupChange(Sender: TObject);
var inprice_pdv: real;
    markup: real;
begin
  if refresh_enabled then
  begin
    refresh_enabled := false;
    if (GetConfig(prm.db_handle, 3, 'store_documents') = 'yes') then
    begin
      inprice_pdv := LastInPrice;
    end else
      inprice_pdv := CurrentInPricePDV;
    markup := ConvertEditorExt(ed_markup);
    ed_price_pdv.Text := FloatToStr(((inprice_pdv * markup)/100.0 + inprice_pdv));
    refresh_enabled := true;

    CalcFromPricePDV;
  end;
end;

end.
