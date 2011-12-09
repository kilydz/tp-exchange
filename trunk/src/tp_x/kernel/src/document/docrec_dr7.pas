unit docrec_dr7;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, etalon_dr, dxCntner, IBSQL, IBDatabase, DB, Grids, ExtCtrls,
  uZMaster, document_h, kernel_h, dxEditor, dxExEdtr, dxEdLib, StdCtrls;

type
  Tfdocrec_dr7 = class(Tfetalon_dr)
    Label2: TLabel;
    Label4: TLabel;
    Label3: TLabel;
    Label5: TLabel;
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

function DocrecDialogDR7(id: integer; nomen_id: integer; resulted: lpZDocrecDialogResulted; var prm: ZVelesInfoRec): integer;

implementation

{$R *.dfm}

function DocrecDialogdr7(id: integer; nomen_id: integer; resulted: lpZDocrecDialogResulted; var prm: ZVelesInfoRec): integer;
var
  dlg: Tfdocrec_dr7;
  returned: integer;
begin
// Перевірка прав
  returned := 0;
try
// Створення та ініціалізація форми діалогу.
    dlg := Tfdocrec_dr7.Create(Application);
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
  DocrecDialogdr7 := returned;
end;

//------------------------------------------------------------------------------
//
//------------------------------------------------------------------------------
procedure Tfdocrec_dr7.InitInfo;
begin
  inherited InitInfo;
end;

procedure Tfdocrec_dr7.InitINS;
var price_tmp: real;
begin
  inherited InitINS;
try
  price_tmp := StrToFloat(ed_goods_list.Cells[2, 1]);
  resulted.price_pdv := price_tmp;
except
  resulted.price_pdv := 0.00;
end

end;

procedure Tfdocrec_dr7.InitUPD;
begin
  inherited InitUPD
end;

procedure Tfdocrec_dr7.InitControls;
begin
  if resulted.document.client_is_pdv = 0 then
  begin
    resulted.typepdv_id := 1;
    resulted.nomen.typepdv_id := 1;
  end;

  inherited InitControls;
end;

function Tfdocrec_dr7.AnalizChanges: integer;
var returned: integer;
begin
  returned := inherited AnalizChanges;


  AnalizChanges := returned;
end;

procedure Tfdocrec_dr7.ApplyChanges;
begin
  inherited ApplyChanges;
end;

procedure Tfdocrec_dr7.ApplyControls;
begin
  inherited ApplyControls;
end;

procedure Tfdocrec_dr7.ApplyINS;
begin
  qW.SQL.Text := 'select odocrec_id from PS_DOCREC_TD7_INS (:idocument_id, :inomen_id, ' +
                     ' :ikilk, :iprice, :idiscount)';
  qW.ParamByName('idocument_id').AsInteger    := resulted.document.document_id;
  qW.ParamByName('inomen_id').AsInteger       := resulted.nomen.nomen_id;
  qW.ParamByName('ikilk').AsCurrency          := resulted.kilk;
  qW.ParamByName('iprice').AsCurrency         := resulted.price;
  qW.ParamByName('idiscount').AsCurrency      := resulted.discount;
  qW.ExecQuery;
  resulted.docrec_id := qW.FieldByName('odocrec_id').AsInteger;
end;

procedure Tfdocrec_dr7.ApplyUPD;
begin
  qW.SQL.Text := 'select okilk from PS_DOCREC_TD7_UPD (:idocrec_id, ' +
                     ' :ikilk, :iprice, :idiscount)';
  qW.ParamByName('idocrec_id').AsInteger      := resulted.docrec_id;
  qW.ParamByName('ikilk').AsCurrency          := resulted.kilk;
  qW.ParamByName('iprice').AsCurrency         := resulted.price;
  qW.ParamByName('idiscount').AsCurrency      := resulted.discount;
  qW.ExecQuery;
end;

end.
