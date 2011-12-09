unit ubranchC;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, etalon_dlg, dxCntner, IBSQL, IBDatabase, DB, ComCtrls, uZMaster,
  dxExEdtr, dxEdLib, dxEditor, StdCtrls, ExtCtrls, tree_h, kernel_h;

type
  TfbranchC = class(Tfetalon_dlg)
    TabSheet1: TTabSheet;
    Panel1: TPanel;
    Label1: TLabel;
    ed_name: TdxEdit;
  private
    { Private declarations }
  public
    resulted: PTGroupTreeNode;
    prew_grp_id: integer;

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

function BranchCDialog(grp_id: integer; prew_grp_id: integer;  resulted: PTGroupTreeNode; var prm: ZVelesInfoRec): integer;

implementation

{$R *.dfm}

function BranchCDialog(grp_id: integer; prew_grp_id: integer; resulted: PTGroupTreeNode; var prm: ZVelesInfoRec): integer;
var
  dlg: TfbranchC;
  returned: integer;
begin
// Перевірка прав
  returned := 0;
  Result := -1;

try
// Створення та ініціалізація форми діалогу.
    dlg := TfbranchC.Create(Application);
    dlg.id.id := grp_id;
    dlg.prew_grp_id := prew_grp_id;
    dlg.prm := prm;
    dlg.resulted := resulted;
    dlg.InitInfo;
// Візуалізація діалогу

    if (dlg.ShowModal = mrOk) then
    begin
      returned := resulted.id;
    end;
finally
  dlg.Free;
end;
//    returned <= 0 - код помилки, або відмова;
//    returned > 0  - id результату;
  Result := returned;
end;
  
procedure TfbranchC.InitInfo;
begin
  inherited InitInfo;
end;

procedure TfbranchC.InitINS;
begin
  Caption := 'Створення нової гілки.';
  resulted.id                 := 0;
  resulted.name               := '';
  resulted.prew_id            := prew_grp_id;
end;

procedure TfbranchC.InitUPD;
var tmp_int: integer;
begin
  Caption := 'Редагування даних про гілку.';
  if(trR.InTransaction)then trR.Commit;
  trR.StartTransaction;
   qR.SQL.Text := 'select grpc_id, grpc_name, prew_grpc_id from T_CLIENT_GROUPS where grpc_id = :igrpc_id';
   qR.ParamByName('igrpc_id').AsInteger := id.id;
   qR.ExecQuery;
   resulted.id                := qR.FieldByName('grpc_id').AsInteger;
   resulted.name              := qR.FieldByName('grpc_name').AsString;
   resulted.prew_id           := qR.FieldByName('prew_grpc_id').AsInteger;
  if(trR.InTransaction) then trR.Commit;
end;

procedure TfbranchC.InitControls;
begin
  ed_name.Text                := resulted.name;
end;

function TfbranchC.AnalizChanges: integer;
var returned: integer;
begin
  returned := 0;


  Result := returned;
end;

procedure TfbranchC.ApplyChanges;
begin
  inherited ApplyChanges;
end;

procedure TfbranchC.ApplyControls;
begin
  // Підготовка даних
  resulted.name             := ed_name.Text;
end;

procedure TfbranchC.ApplyINS;
begin
  qW.SQL.Text := 'select rgrpc_id from T_GRPC_CREATE_CHILD(:iprew_grpc_id, :iname)';
  qW.ParamByName('iprew_grpc_id').AsInteger        := resulted.prew_id;
  qW.ParamByName('iname').AsString                := resulted.name;
  qW.ExecQuery;
  resulted.id := qW.FieldByName('rgrpc_id').AsInteger;
end;

procedure TfbranchC.ApplyUPD;
begin
  qW.SQL.Text := 'update T_CLIENT_GROUPS set ' +
                     ' grpc_name = :iname ' +
                 ' where grpc_id = :igrpc_id ';
  qW.ParamByName('igrpc_id').AsInteger             := resulted.id;
  qW.ParamByName('iname').AsString                := resulted.name;
  qW.ExecQuery;
end;

end.
