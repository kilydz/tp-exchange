unit docrec_dr4;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, etalon_dr, dxCntner, IBSQL, IBDatabase, DB, Grids, ExtCtrls,
  uZMaster, document_h, kernel_h, dxEditor, dxExEdtr, dxEdLib, StdCtrls, genstor_h;

type
  Tfdocrec_dr4 = class(Tfetalon_dr)
    Label2: TLabel;
    Label4: TLabel;
    Label3: TLabel;
    Label5: TLabel;
    procedure ed_goods_listSelectCell(Sender: TObject; ACol, ARow: Integer;
      var CanSelect: Boolean);
    procedure ed_goods_listClick(Sender: TObject);
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

function DocrecDialogDR4(id: integer; nomen_id: integer; resulted: lpZDocrecDialogResulted; var prm: ZVelesInfoRec): integer;

implementation

{$R *.dfm}

function DocrecDialogDR4(id: integer; nomen_id: integer; resulted: lpZDocrecDialogResulted; var prm: ZVelesInfoRec): integer;
var
  dlg: Tfdocrec_dr4;
  returned: integer;
begin
// Перевірка прав
  returned := 0;
// Створення та ініціалізація форми діалогу.
    dlg := Tfdocrec_dr4.Create(Application);
  try
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
//
//------------------------------------------------------------------------------
procedure Tfdocrec_dr4.InitInfo;
begin
  inherited InitInfo;
//  resulted.typepdv_id := 1;
 try
  if trR.InTransaction then trR.Commit;
  trR.StartTransaction;
   qR.SQL.Text := 'select count(goods_id) as goods_cnt from t_goods where nomen_id = :inomen_id';
   qR.ParamByName('inomen_id').AsInteger := nomen_id;
   qR.ExecQuery;
   if (qR.FieldByName('goods_cnt').AsInteger = 0) then
   begin
     raise Exception.Create('Не було жодного приходу на даний товар.');
   end;
  if trR.InTransaction then trR.Commit;
 except
  raise;
 end;
end;

procedure Tfdocrec_dr4.InitINS;
begin
  inherited InitINS;
  resulted.price_pdv := CurrentInPrice;
end;

procedure Tfdocrec_dr4.InitUPD;
begin
  inherited InitUPD;
  ed_goods_list.Enabled := false;
end;

procedure Tfdocrec_dr4.InitControls;
begin
  resulted.typepdv_id := 1;
  inherited InitControls;
end;

function Tfdocrec_dr4.AnalizChanges: integer;
var returned: integer;
begin
  returned := inherited AnalizChanges;


  AnalizChanges := returned;
end;

procedure Tfdocrec_dr4.ApplyChanges;
begin
  inherited ApplyChanges;
end;

procedure Tfdocrec_dr4.ApplyControls;
begin
  inherited ApplyControls;
end;

procedure Tfdocrec_dr4.ApplyINS;
begin
  {qW.SQL.Text := 'select odocrec_id from PS_DOCREC_TD4_INS (:idocument_id, :igoods_id, ' +
                     ' :ikilk, :iprice, :idiscount)';
  qW.ParamByName('idocument_id').AsInteger    := resulted.document.document_id;
  qW.ParamByName('igoods_id').AsInteger       := StrToInt(ed_goods_list.Cells[0, current_goods_row]);
  qW.ParamByName('ikilk').AsCurrency          := resulted.kilk;
  qW.ParamByName('iprice').AsCurrency         := resulted.price_pdv;
  qW.ParamByName('idiscount').AsCurrency      := resulted.discount;
  qW.ExecQuery;
  resulted.docrec_id := qW.FieldByName('odocrec_id').AsInteger;}
end;

procedure Tfdocrec_dr4.ApplyUPD;
begin
  qW.SQL.Text := 'select okilk from PS_DOCREC_TD4_UPD (:idocrec_id, ' +
                     ' :ikilk)';
  qW.ParamByName('idocrec_id').AsInteger      := resulted.docrec_id;
  qW.ParamByName('ikilk').AsCurrency          := resulted.kilk;
//  qW.ParamByName('iprice').AsCurrency         := resulted.price_pdv;
//  qW.ParamByName('idiscount').AsCurrency      := resulted.discount;
  qW.ExecQuery;
end;

procedure Tfdocrec_dr4.ed_goods_listClick(Sender: TObject);
begin
  //
end;

procedure Tfdocrec_dr4.ed_goods_listSelectCell(Sender: TObject; ACol,
  ARow: Integer; var CanSelect: Boolean);
begin
  current_goods_row := ARow;
  ed_price.Text := FloatToStr(CurrentInPrice);
end;

end.
