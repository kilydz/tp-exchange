unit upoint_l1;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, etalon_dlg, ComCtrls, dxCntner, IBSQL, IBDatabase, DB, uZMaster,
  dxEditor, dxEdLib, StdCtrls, ExtCtrls, kernel_h;

type
ZPontL1DialogResulted = record
  l1_point_id: integer;
  name: string;
end;

  Tfpoint_l1 = class(Tfetalon_dlg)
    TabSheet1: TTabSheet;
    pStage0: TPanel;
    Label2: TLabel;
    ed_name: TdxEdit;
  private
    { Private declarations }
  public
    resulted: ZPontL1DialogResulted;
    prew_id: integer;

    procedure InitINS; override;
    procedure InitUPD; override;
    procedure InitControls; override;

    function  AnalizChanges: integer; override;
    procedure ApplyChanges; override;
    procedure ApplyControls; override;
    procedure ApplyINS; override;
    procedure ApplyUPD; override;
  end;

var
  fpoint_l1: Tfpoint_l1;

function PointL1Dialog(id, prew_id: integer; var prm: ZVelesInfoRec): integer;

implementation

{$R *.dfm}

function PointL1Dialog(id, prew_id: integer; var prm: ZVelesInfoRec): integer;
var
  dlg: Tfpoint_l1;
  returned: integer;
begin
  returned := 0;
try
    dlg := Tfpoint_l1.Create(Application);
    dlg.id.id := id;
    dlg.prew_id := prew_id;
    dlg.prm := prm;
    dlg.InitInfo;

    if (dlg.ShowModal = mrOk) then
    begin
      returned := dlg.resulted.l1_point_id;
    end;
finally
  if dlg <> nil then dlg.Free;
end;

  Result := returned;
end;


procedure Tfpoint_l1.InitINS;
begin
  Caption := 'Процедура створення області.';
  resulted.l1_point_id := 0;
  resulted.name := '';
end;

procedure Tfpoint_l1.InitUPD;
begin
  Caption := 'Процедура редагування області.';
  if(trR.InTransaction)then trR.Commit;
  trR.StartTransaction;
   qR.SQL.Text := 'select l1_point_id, name from t_l1_points where l1_point_id = :iid';
   qR.ParamByName('iid').AsInteger := id.id;
   qR.ExecQuery;
   resulted.l1_point_id         := qR.FieldByName('l1_point_id').AsInteger;
   resulted.name                := qR.FieldByName('name').AsString;
  if(trR.InTransaction) then trR.Commit;
end;

procedure Tfpoint_l1.InitControls;
begin
  ed_name.Text              := resulted.name;
end;

function Tfpoint_l1.AnalizChanges: integer;
var returned: integer;
begin
  returned := 0;

  if(ed_name.Text = '')then
  begin
    ShowMessage('Не вказано назви області.');
    master.PageIndex := 0;
    ed_name.SetFocus;
    returned := -1;
  end;

  AnalizChanges := returned;
end;

procedure Tfpoint_l1.ApplyChanges;
begin
  inherited ApplyChanges;
end;

procedure Tfpoint_l1.ApplyControls;
begin
  resulted.name           := ed_name.Text;
end;

procedure Tfpoint_l1.ApplyINS;
var new_id: integer;
begin
  new_id := GetNextID('GEN_T_L1_POINTS_ID');

  qW.SQL.Text := 'insert into t_l1_points(l1_point_id, name, l0_point_id)' +
                      ' values (:il1_point_id, :iname, :il0_point_id)';
  qW.ParamByName('il1_point_id').AsInteger    := new_id;
  qW.ParamByName('iname').AsString            := resulted.name;
  qW.ParamByName('il0_point_id').AsInteger    := prew_id;
  qW.ExecQuery;
  resulted.l1_point_id := new_id;
end;

procedure Tfpoint_l1.ApplyUPD;
begin
  qW.SQL.Text := 'update t_l1_points set ' +
                     ' name = :iname ' +
                 ' where l1_point_id = :il1_point_id ';
  qW.ParamByName('il1_point_id').AsInteger    := resulted.l1_point_id;
  qW.ParamByName('iname').AsString            := resulted.name;
  qW.ExecQuery;
end;

end.
