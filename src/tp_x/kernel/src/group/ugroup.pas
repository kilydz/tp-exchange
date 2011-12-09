unit ugroup;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, etalon_dlg, dxCntner, IBSQL, IBDatabase, DB, ComCtrls, uZMaster,
  secure_h, kernel_h, utils_h, ExtCtrls, StdCtrls, dxEditor, dxEdLib,
  dxExEdtr, group_h, genstor_h, zutils_h;

type
  Tfgroup = class(Tfetalon_dlg)
    tab_sheet_0: TTabSheet;
    page_0: TPanel;
    ed_name: TdxEdit;
    Label1: TLabel;
  private
    { Private declarations }
  public
    { Public declarations }
    resulted: ZGroupDlgResulted;

    procedure InitINS; override;
    procedure InitUPD; override;
    procedure InitControls; override;

    function  AnalizChanges: Integer; override;

    procedure ApplyChanges; override;
    procedure ApplyControls; override;
    procedure ApplyINS; override;
    procedure ApplyUPD; override;
  end;

function GroupDialog(id: Integer; resulted: lpZGroupDlgResulted;
    var prm: ZVelesInfoRec): Integer;

implementation

{$R *.dfm}

function GroupDialog(id: Integer; resulted: lpZGroupDlgResulted;
    var prm: ZVelesInfoRec): Integer;
var
  dlg: Tfgroup;

begin
    Result:=0;
    if id > 0 then
    begin
        if not HasUserAccessEx(prm, ACCESS_TO_EDIT_GROUP) then
            Exit;
    end
    else begin
        if not HasUserAccessEx(prm, ACCESS_TO_ADD_GROUP) then
            Exit;
    end;

    // Створення та ініціалізація форми діалогу.
    dlg := Tfgroup.Create(Application);
    try
        dlg.id.id := id;
        dlg.prm := prm;
        dlg.resulted := resulted^;
        dlg.InitInfo;
        // Візуалізація діалогу

        if dlg.ShowModal = mrOk then
        begin
            resulted^ := dlg.resulted;
            Result := dlg.resulted.id;
        end;
    finally
        dlg.Free;
    end;
    //    returned <= 0 - код помилки, або відмова;
    //    returned > 0  - id результату;
end;

{ Tfgroup }

function Tfgroup.AnalizChanges: Integer;
begin
    Result:=0;
    if ed_name.Text = '' then
    begin
        GMessageBox('Введіть назву групи', 'OK');
        master.PageIndex:=0;
        ed_name.SetFocus;
        Result:=-1;
    end;
end;//Tfgroup.AnalizChanges

procedure Tfgroup.ApplyChanges;
begin
    inherited;
    //нічого не робимо - немає потреби
end;

procedure Tfgroup.ApplyControls;
begin
    inherited;
    resulted.name:=ed_name.Text;
end;

procedure Tfgroup.ApplyINS;
begin
    inherited;
    try
        if trW.InTransaction then trW.Commit;
        trW.StartTransaction;
        qW.SQL.Text:='SELECT oid FROM pa_group_ins(:iname)';
        qW.ParamByName('iname').AsString:=resulted.name;
        qW.ExecQuery;
        resulted.id:=qW.FieldByName('oid').AsInteger;
        trW.Commit;
    except
        on E: Exception do
        begin
            if trW.InTransaction then trW.Rollback;
            ErrorDialog(E.Message, 'Tfgroup.ApplyINS');
        end;
    end;
end;

procedure Tfgroup.ApplyUPD;
begin
    inherited;
    try
        if trW.InTransaction then trW.Commit;
        trW.StartTransaction;
        qW.SQL.Text:='SELECT oid FROM pa_group_upd(:iid, :iname)';
        qW.ParamByName('iid').AsInteger:=resulted.id;
        qW.ParamByName('iname').AsString:=resulted.name;
        qW.ExecQuery;
        trW.Commit;
    except
        on E: Exception do
        begin
            if trW.InTransaction then trW.Rollback;
            ErrorDialog(E.Message, 'Tfgroup.ApplyUPD');
        end;
    end;
end;

procedure Tfgroup.InitControls;
begin
    inherited;
    if id.id > 0 then//редагування користувача
    begin
        ed_name.Text:=resulted.name;
    end;
end;

procedure Tfgroup.InitINS;
begin
    inherited;
    Caption:=' Нова група';
    resulted.id:=-1;
end;

procedure Tfgroup.InitUPD;
begin
    inherited;
    Caption:=' Редагування групи';
    try
        if trR.InTransaction then trR.Commit;
        trR.StartTransaction;
        qR.SQL.Text:='SELECT oid, oname FROM pa_group_view(:iright_grp_id)';
        qR.ParamByName('iright_grp_id').AsInteger:=id.id;
        qR.ExecQuery;
        resulted.id:=qR.FieldByName('oid').AsInteger;
        resulted.name:=qR.FieldByName('oname').AsString;
        trR.Commit;
    except
        on E: Exception do
        begin
            if trR.InTransaction then trR.Rollback;
            ErrorDialog(E.Message, 'Tfgroup.InitUPD');
        end;
    end;
end;//Tfgroup.InitUPD

end.
