unit upoint_l0;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, kernel_h, etalon_dlg, dxCntner, dxEditor, dxEdLib, StdCtrls,
  ExtCtrls, ComCtrls, IBSQL, IBDatabase, DB, uZMaster;

type
ZPontL0DialogResulted = record
  l0_point_id: integer;
  name: string;
end;

  Tfpoint_l0 = class(Tfetalon_dlg)
    TabSheet1: TTabSheet;
    pStage0: TPanel;
    Label2: TLabel;
    ed_name: TdxEdit;
  private
    { Private declarations }
  public
    resulted: ZPontL0DialogResulted;

    procedure InitINS; override;
    procedure InitUPD; override;
    procedure InitControls; override;

    function  AnalizChanges: integer; override;
    procedure ApplyChanges; override;
    procedure ApplyControls; override;
    procedure ApplyINS; override;
    procedure ApplyUPD; override;
  end;

function L0PointDialog(id: integer; var prm: ZVelesInfoRec): integer;

implementation

{$R *.dfm}

function L0PointDialog(id: integer; var prm: ZVelesInfoRec): integer;
var
  dlg: Tfpoint_l0;
  returned: integer;
begin
  returned := 0;
try
    dlg := Tfpoint_l0.Create(Application);
    dlg.id.id := id;
    dlg.prm := prm;
    dlg.InitInfo;

    if (dlg.ShowModal = mrOk) then
    begin
      returned := dlg.resulted.l0_point_id;
    end;
finally
  if dlg <> nil then dlg.Free;
end;

  Result := returned;
end;


procedure Tfpoint_l0.InitINS;
begin
  Caption := 'Процедура створення країни.';
  resulted.l0_point_id := 0;
  resulted.name := '';
end;

procedure Tfpoint_l0.InitUPD;
begin
  Caption := 'Процедура редагування країни.';
  if(trR.InTransaction)then trR.Commit;
  trR.StartTransaction;
   qR.SQL.Text := 'select l0_point_id, name from t_l0_points where l0_point_id = :iid';
   qR.ParamByName('iid').AsInteger := id.id;
   qR.ExecQuery;
   resulted.l0_point_id         := qR.FieldByName('l0_point_id').AsInteger;
   resulted.name                := qR.FieldByName('name').AsString;
  if(trR.InTransaction) then trR.Commit;
end;

procedure Tfpoint_l0.InitControls;
begin
  ed_name.Text              := resulted.name;
end;

function Tfpoint_l0.AnalizChanges: integer;
var returned: integer;
begin
  returned := 0;

  if(ed_name.Text = '')then
  begin
    ShowMessage('Не вказано назви країни.');
    master.PageIndex := 0;
    ed_name.SetFocus;
    returned := -1;
  end;

  AnalizChanges := returned;
end;

procedure Tfpoint_l0.ApplyChanges;
begin
  inherited ApplyChanges;
end;

procedure Tfpoint_l0.ApplyControls;
begin
  resulted.name           := ed_name.Text;
end;

procedure Tfpoint_l0.ApplyINS;
var new_id: integer;
begin
  new_id := GetNextID('GEN_T_L0_POINTS_ID');

  qW.SQL.Text := 'insert into t_l0_points(l0_point_id, name)' +
                      ' values (:il0_point_id, :iname)';
  qW.ParamByName('il0_point_id').AsInteger    := new_id;
  qW.ParamByName('iname').AsString            := resulted.name;
  qW.ExecQuery;
  resulted.l0_point_id := new_id;
end;

procedure Tfpoint_l0.ApplyUPD;
begin
  qW.SQL.Text := 'update t_l0_points set ' +
                     ' name = :iname ' +
                 ' where l0_point_id = :il0_point_id ';
  qW.ParamByName('il0_point_id').AsInteger    := resulted.l0_point_id;
  qW.ParamByName('iname').AsString            := resulted.name;
  qW.ExecQuery;
end;

end.
