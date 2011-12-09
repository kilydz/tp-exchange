unit docrec_dr17;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, etalon_dr, dxCntner, IBSQL, IBDatabase, DB, Grids, ExtCtrls,
  uZMaster, document_h, kernel_h, dxEditor, dxExEdtr, dxEdLib, StdCtrls, secure_h;

type
  Tfdocrec_dr17 = class(Tfetalon_dr)
    Label2: TLabel;
    Label4: TLabel;
    Label3: TLabel;
    Label5: TLabel;
    procedure ed_goods_listSelectCell(Sender: TObject; ACol, ARow: Integer;
      var CanSelect: Boolean);
  private
    { Private declarations }
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

function DocrecDialogDR17(id: integer; nomen_id: integer; resulted: lpZDocrecDialogResulted; var prm: ZVelesInfoRec): integer;

implementation

{$R *.dfm}

function DocrecDialogDR17(id: integer; nomen_id: integer; resulted: lpZDocrecDialogResulted; var prm: ZVelesInfoRec): integer;
var
  dlg: Tfdocrec_dr17;
  returned: integer;
begin
// Перевірка прав
  returned := 0;
try
// Створення та ініціалізація форми діалогу.
    dlg := Tfdocrec_dr17.Create(Application);
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
  DocrecDialogDR17 := returned;
end;

//------------------------------------------------------------------------------
//
//------------------------------------------------------------------------------
procedure Tfdocrec_dr17.InitInfo;
var config_6: string;
begin
  // Чи відображати в при редагуванні повернення постачальнику всі аналітичні картки (yes/no)
  config_6 := GetConfig(prm.db_handle, 6, 'store_documents');
  if (config_6 = 'yes') then
    sql_goods_list := 'select goods_id, goods_rest, goods_inprice, doc_date from t_goods ' +
      ' where nomen_id = :inomen_id order by goods_id desc'
  else
    sql_goods_list := 'select goods_id, goods_rest, goods_inprice, doc_date from t_goods ' +
      ' where nomen_id = :inomen_id and clients_id = ' + IntToStr(resulted.document.client_id) +
      ' order by goods_id desc';

  inherited InitInfo;

  current_goods_row := 1;

 try
  if trR.InTransaction then trR.Commit;
  trR.StartTransaction;
   if (config_6 = 'yes') then
     qR.SQL.Text := 'select count(goods_id) as goods_cnt from t_goods where nomen_id = :inomen_id '
   else
     qR.SQL.Text := 'select count(goods_id) as goods_cnt from t_goods where nomen_id = :inomen_id ' +
          ' and clients_id = ' + IntToStr(resulted.document.client_id);
   qR.ParamByName('inomen_id').AsInteger := nomen_id;
   qR.ExecQuery;
   if (qR.FieldByName('goods_cnt').AsInteger = 0) then
   begin
     raise Exception.Create('Не було жодного приходу на даний товар від даного постачальника.');
   end;
  if trR.InTransaction then trR.Commit;
 except
  raise;
 end
end;

procedure Tfdocrec_dr17.InitINS;
begin
  inherited InitINS;
  resulted.price_pdv := CurrentInPricePDV;
end;

procedure Tfdocrec_dr17.InitUPD;
begin
  inherited InitUPD
end;

procedure Tfdocrec_dr17.InitControls;
begin
  inherited InitControls;
end;

function Tfdocrec_dr17.AnalizChanges: integer;
var returned: integer;
begin
  returned := inherited AnalizChanges;
  AnalizChanges := returned;
end;

procedure Tfdocrec_dr17.ApplyChanges;
begin
  inherited ApplyChanges;
end;

procedure Tfdocrec_dr17.ApplyControls;
begin
  inherited ApplyControls;
end;

procedure Tfdocrec_dr17.ApplyINS;
begin
  qW.SQL.Text := 'select odocrec_id from PS_DOCREC_TD17_INS (:idocument_id, :igoods_id, ' +
                     ' :ikilk, :iprice, :idiscount)';
  qW.ParamByName('idocument_id').AsInteger    := resulted.document.document_id;
  qW.ParamByName('igoods_id').AsInteger       := StrToInt(ed_goods_list.Cells[0, current_goods_row]);
  qW.ParamByName('ikilk').AsCurrency          := resulted.kilk;
  qW.ParamByName('iprice').AsCurrency         := resulted.price_pdv;
  qW.ParamByName('idiscount').AsCurrency      := resulted.discount;
  qW.ExecQuery;
  resulted.docrec_id := qW.FieldByName('odocrec_id').AsInteger;
end;

procedure Tfdocrec_dr17.ApplyUPD;
begin
  qW.SQL.Text := 'select okilk from PS_DOCREC_TD17_UPD_v1 (:idocrec_id, ' +
                     ' :ikilk, :iprice)';
  qW.ParamByName('idocrec_id').AsInteger      := resulted.docrec_id;
  qW.ParamByName('ikilk').AsCurrency          := resulted.kilk;
  qW.ParamByName('iprice').AsCurrency         := resulted.price_pdv;
  qW.ExecQuery;
end;

procedure Tfdocrec_dr17.ed_goods_listSelectCell(Sender: TObject; ACol,
  ARow: Integer; var CanSelect: Boolean);
begin
  current_goods_row := ARow;
  ed_price.Text := FloatToStr(CurrentInPrice);
end;

end.
