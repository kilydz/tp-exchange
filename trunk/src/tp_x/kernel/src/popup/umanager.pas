unit umanager;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, etalon_dlg, kernel_h, dxCntner, dxEditor, dxEdLib, StdCtrls,
  ExtCtrls, ComCtrls, IBSQL, IBDatabase, DB, uZMaster, CheckLst, uZFilterCombo;

type
  ZManagerDialogResulted = record
     manager_id:    integer;
     manager_name:  string;
   end;
lpZManagerDialogResulted = ^ZManagerDialogResulted;

  Tfmanager = class(Tfetalon_dlg)
    TabSheet1: TTabSheet;
    pStage0: TPanel;
    Label4: TLabel;
    ed_manager_name: TdxEdit;
    TabSheet2: TTabSheet;
    Panel1: TPanel;
    ed_groups: ZFilterCombo;
  private
    { Private declarations }
  public
    resulted: ZManagerDialogResulted;

    procedure InitInfo; override;
    procedure InitINS; override;
    procedure InitUPD; override;
    procedure InitControls; override;

    function  AnalizChanges: integer; override;
    procedure ApplyChanges; override;
    procedure ApplyControls; override;
    procedure ApplyDefault; override;
    procedure ApplyINS; override;
    procedure ApplyUPD; override;
  end;

function ManagerDialog(var id: ZFuncArgs; var prm: ZVelesInfoRec): integer;

implementation

{$R *.dfm}

function ManagerDialog(var id: ZFuncArgs; var prm: ZVelesInfoRec): integer;
var
  dlg: Tfmanager;
  returned: integer;
begin
// Перевірка прав
  returned := 0;
  Result := -1;

try
// Створення та ініціалізація форми діалогу.
    dlg := Tfmanager.Create(Application);
    dlg.id := id;
    dlg.prm := prm;
    dlg.InitInfo;
// Візуалізація діалогу

    if (dlg.ShowModal = mrOk) then
    begin
      returned := dlg.resulted.manager_id;
    end;
finally
  if dlg <>nil then dlg.Free;
end;
//    returned <= 0 - код помилки, або відмова;
//    returned > 0  - id результату;
  ManagerDialog := returned;
end;

procedure Tfmanager.InitInfo;
var zkpo:integer;
    typeclient_sql: string;
begin
  inherited InitInfo;
end;


procedure Tfmanager.InitINS;
begin
  Caption := 'Створення нового менеджера.';
  resulted.manager_id      := 0;
  resulted.manager_name := '';
end;

procedure Tfmanager.InitUPD;
begin
  Caption := 'Редагування менеджера.';
  if(trR.InTransaction)then trR.Commit;
  trR.StartTransaction;
   qR.SQL.Text := 'select manager_id, manager_name '+
                      '  from t_managers where manager_id = :imanager_id';
   qR.ParamByName('imanager_id').AsInteger := id.id;
   qR.ExecQuery;
   resulted.manager_id    := qR.FieldByName('manager_id').AsInteger;
   resulted.manager_name  := qR.FieldByName('manager_name').AsString;
  if(trR.InTransaction) then trR.Commit;
end;

procedure Tfmanager.InitControls;
begin
  ed_manager_name.Text        := resulted.manager_name;

  ed_groups.FillFromSQLChecked('select grp_id as id, grp_name as name, min2(manager_id, 1) as is_checked ' +
' from t_nomen_groups where prew_grp_id is null and ((manager_id is null) or (manager_id = '+IntToStr(id.id)+'))',
      prm.db_handle);
end;

function Tfmanager.AnalizChanges: integer;
var returned: integer;
begin
  returned := 0;

  AnalizChanges := returned;
end;

procedure Tfmanager.ApplyChanges;
begin
  inherited ApplyChanges;
end;

procedure Tfmanager.ApplyControls;
begin
  resulted.manager_name    := ed_manager_name.Text;
end;

procedure Tfmanager.ApplyINS;
var manager_id: integer;
begin
  manager_id := GetNextID('GEN_MANAGER_ID');

  qW.SQL.Text := ' insert into t_managers (manager_id, manager_name) ' +
  ' values (:imanager_id, :imanager_name) ';
  qW.ParamByName('imanager_id').AsInteger     := manager_id;
  qW.ParamByName('imanager_name').AsString    := resulted.manager_name;
  qW.ExecQuery;
  resulted.manager_id := manager_id;
end;

procedure Tfmanager.ApplyDefault;
var group_id: integer;
    i: integer;
begin
     for i := 1 to ed_groups.Count - 1 do
     begin
         group_id := ed_groups.PosToId(i);
        try
         qW.Close;
         if ed_groups.Checked[i] then
         begin
           qW.SQL.Text := ' update t_nomen_groups set manager_id = :imanager_id where grp_id = :igroup_id ';
           qW.ParamByName('imanager_id').AsInteger := resulted.manager_id;
           qW.ParamByName('igroup_id').Value  := group_id;
         end
         else
         begin
           qW.SQL.Text := ' update t_nomen_groups set manager_id = null where grp_id = :igroup_id ';
           qW.ParamByName('igroup_id').Value  := group_id;
         end;

          qW.ExecQuery;
        except

        end;
     end;
end;

procedure Tfmanager.ApplyUPD;
begin
  qW.SQL.Text := 'update t_managers set ' +
                        ' manager_name = :imanager_name ' +
                   ' where manager_id = :imanager_id ';
  qW.ParamByName('imanager_id').AsInteger     := id.id;
  qW.ParamByName('imanager_name').AsString    := resulted.manager_name;
  qW.ExecQuery;
end;

end.
