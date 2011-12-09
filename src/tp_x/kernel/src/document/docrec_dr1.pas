unit docrec_dr1;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, etalon_dr, dxCntner, IBSQL, IBDatabase, DB, Grids, ExtCtrls,
  uZMaster, document_h, kernel_h, dxEditor, dxExEdtr, dxEdLib, StdCtrls, genstor_h,
  Zutils_h, dxDBEdtr, dxDBELib, IBCustomDataSet, IBQuery;

type
  Tfdocrec_dr1 = class(Tfetalon_dr)
    Label2: TLabel;
    Label4: TLabel;
    Label3: TLabel;
    Label5: TLabel;
    procedure ed_kilkChange(Sender: TObject);
  private
    { Private declarations }
    Max_kilk :double;
    MustClose: Boolean;
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
  end;

function DocrecDialogDR1(id: integer; nomen_id: integer; code_unit: Integer; resulted: lpZDocrecDialogResulted; var prm: ZVelesInfoRec): integer;

implementation

{$R *.dfm}

function DocrecDialogDR1(id: integer; nomen_id: integer; code_unit: Integer; resulted: lpZDocrecDialogResulted; var prm: ZVelesInfoRec): integer;
var
  dlg: Tfdocrec_dr1;
  returned: integer;
begin
// Перевірка прав
  returned := 0;
try
// Створення та ініціалізація форми діалогу.
    dlg := Tfdocrec_dr1.Create(Application);
    dlg.id := id;
    dlg.nomen_id := nomen_id;
    dlg.code_unit := code_unit;
    dlg.prm := prm;
    dlg.resulted := resulted;

    dlg.InitInfo;
    if not(dlg.MustClose) then
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
  DocrecDialogDR1 := returned;
end;

//------------------------------------------------------------------------------
//
//------------------------------------------------------------------------------
procedure Tfdocrec_dr1.InitInfo;
var max_int_kilk: integer;
begin
  Max_Kilk := -1;
  MustClose := False;
  inherited InitInfo;

 { if resulted.document.typedoc_id = 1 then
  begin
  try
    Max_Kilk := -1;
    if trR.InTransaction then trR.Commit;
    trR.StartTransaction;
    qR.SQL.Text := 'select go.oaor_ordered, go.okilk, go.ois_weight, go.ocount_not_ao_docrec from ps_get_ordered(:idocuments_id, :inomen_id) go ';
    qR.ParamByName('idocuments_id').AsInteger := resulted.document.document_id;
    qR.ParamByName('inomen_id').AsInteger := resulted.nomen.nomen_id;
    qR.ExecQuery;
    if qR.RecordCount > 0 then
    begin
      Max_kilk := qR.FieldByName('okilk').AsDouble;
      if (resulted.docrec_id = 0) then
        resulted.kilk := Max_kilk;
      //
      if Max_kilk >= 10 then
      begin
        if (qR.FieldByName('ois_weight').AsInteger > 0) then
          Max_kilk := Max_kilk * 1.1
        else
        begin
          max_int_kilk := round(Max_kilk * 1.1);
          Max_kilk := max_int_kilk;
        end;
      end
      else
        Max_kilk := Max_kilk + 1;
      if (qR.FieldByName('oaor_ordered').AsInteger = 0) then
         Max_kilk := 9999999;
      ed_kilk.Text := FloatToStr(resulted.kilk);
    //  if ((resulted.docrec_id = 0)and
    //      (qR.FieldByName('oaor_ordered').AsInteger = 0)and
    //      (qR.FieldByName('ocount_not_ao_docrec').AsInteger >= 2)) then
    //  begin
    //     GMessageBox('Неможна заводити більш як 2 позиції не з автозамовлення', 'Закрити');
    //     MustClose := True;
    //  end;

    end
    finally
      if trR.InTransaction then trR.Commit;
    end;
  end;   }
end;

procedure Tfdocrec_dr1.InitINS;
var price_tmp: real;
begin
  inherited InitINS;
{try
  price_tmp := StrToFloat(ed_goods_list.Cells[2, 1]);
  resulted.price_pdv := price_tmp;
except
  resulted.price_pdv := 0.00;
end}

end;

procedure Tfdocrec_dr1.InitUPD;
begin
  inherited InitUPD;
end;

procedure Tfdocrec_dr1.InitControls;
begin
{  if resulted.document.client_is_pdv = 0 then
  begin
    resulted.typepdv_id := 1;
    resulted.nomen.typepdv_id := 1;
  end;}

  inherited InitControls;
end;

function Tfdocrec_dr1.AnalizChanges: integer;
var returned: integer;
begin
  returned := inherited AnalizChanges;


  AnalizChanges := returned;
end;

procedure Tfdocrec_dr1.ApplyChanges;
begin
  inherited ApplyChanges;
end;

procedure Tfdocrec_dr1.ApplyControls;
begin
  inherited ApplyControls;
end;

procedure Tfdocrec_dr1.ApplyINS;
begin
  qW.SQL.Text :=
    'select ODOC_REC_ID' + #13#10 +
    'from PTP_DOC_REC_INS(:DOC_ID, :CODE_WARES, :CODE_UNIT, :QUANTITY, :PRICE_WITH_VAT, :VAT)';
  qW.ParamByName('DOC_ID').AsInteger    := resulted.document.document_id;
  qW.ParamByName('CODE_WARES').AsInteger      := resulted.nomen.code_wares;
  qW.ParamByName('QUANTITY').AsDouble         := resulted.kilk;
  qW.ParamByName('PRICE_WITH_VAT').AsDouble   := resulted.price_pdv;
  qW.ParamByName('CODE_UNIT').AsInteger       := resulted.code_unit;
  qW.ParamByName('vat').AsDouble              := resulted.vat;
  qW.ExecQuery;
  resulted.docrec_id := qW.FieldByName('odoc_rec_id').AsInteger;
end;

procedure Tfdocrec_dr1.ApplyUPD;
begin
  qW.SQL.Text :=
    'update T_DOC_RECS' + #13#10 +
    'set CODE_UNIT = :CODE_UNIT,' + #13#10 +
      'QUANTITY = :QUANTITY,' + #13#10 +
      'PRICE_WITH_VAT = :PRICE_WITH_VAT' + #13#10 +
      'where (DOC_REC_ID = :DOC_REC_ID)';
  qW.ParamByName('doc_rec_id').AsInteger    := resulted.docrec_id;
  qW.ParamByName('code_unit').AsInteger    := resulted.code_unit;
  qW.ParamByName('QUANTITY').AsDouble       := resulted.kilk;
  qW.ParamByName('PRICE_WITH_VAT').AsDouble := resulted.price_pdv;
  qW.ExecQuery;
end;

procedure Tfdocrec_dr1.ed_kilkChange(Sender: TObject);
begin
  if ((Max_kilk >= 0)and(StrToFloat(ed_kilk.Text) > Max_kilk)) then
    ed_kilk.Text := FloatToStr(Max_Kilk);

  EditsChange(Sender);
end;

end.
