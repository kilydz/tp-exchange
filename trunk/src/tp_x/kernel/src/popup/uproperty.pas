unit uproperty;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, etalon_dlg, dxCntner, IBSQL, IBDatabase, DB, ComCtrls, uZMaster,
  ExtCtrls, dxEditor, dxEdLib, StdCtrls, kernel_h;

type
XProperty = record
  typeprop_id: integer;
  name: string;
  short_name: string;
end;

  Tfproperty = class(Tfetalon_dlg)
    TabSheet1: TTabSheet;
    Panel1: TPanel;
    Label2: TLabel;
    ed_name: TdxEdit;
    Label1: TLabel;
    ed_short_name: TdxEdit;
  private
    { Private declarations }
  public
    resulted: XProperty;

    procedure InitINS; override;
    procedure InitUPD; override;
    procedure InitControls; override;

    function  AnalizChanges: integer; override;
    procedure ApplyChanges; override;
    procedure ApplyControls; override;
    procedure ApplyINS; override;
    procedure ApplyUPD; override;
  end;

function PropertyDialog(id: integer; var prm: XVelesInfoRec): integer;

implementation

{$R *.dfm}

function PropertyDialog(id: integer; var prm: XVelesInfoRec): integer;
var
  dlg: Tfproperty;
  returned: integer;
begin
  returned := 0;
try
    dlg := Tfproperty.Create(Application);
    dlg.id.id := id;
    dlg.prm := prm;
    dlg.InitInfo;

    if (dlg.ShowModal = mrOk) then
    begin
      returned := dlg.resulted.typeprop_id;
    end;
finally
  if dlg <> nil then dlg.Free;
end;

  Result := returned;
end;

procedure Tfproperty.InitINS;
begin
  Caption := 'Процедура форми власності.';
  resulted.typeprop_id := 0;
  resulted.name := '';
  resulted.short_name := '';
end;

procedure Tfproperty.InitUPD;
begin
  Caption := 'Процедура редагування форми власності.';
  if(trR.InTransaction)then trR.Commit;
  trR.StartTransaction;
   qR.SQL.Text := 'select tp.typeprop_id, tp.name, tp.short_name from T_OWNER_FORMS tp where tp.typeprop_id = :iid';
   qR.ParamByName('iid').AsInteger := id.id;
   qR.ExecQuery;
   resulted.typeprop_id         := qR.FieldByName('typeprop_id').AsInteger;
   resulted.name                := qR.FieldByName('name').AsString;
   resulted.short_name          := qR.FieldByName('short_name').AsString;
  if(trR.InTransaction) then trR.Commit;
end;

procedure Tfproperty.InitControls;
begin
  ed_name.Text              := resulted.name;
  ed_short_name.Text        := resulted.short_name;
end;

function Tfproperty.AnalizChanges: integer;
var returned: integer;
begin
  returned := 0;

  if(ed_name.Text = '')then
  begin
    ShowMessage('Не вказано назви форми власності.');
    master.PageIndex := 0;
    ed_name.SetFocus;
    returned := -1;
  end;

  AnalizChanges := returned;
end;

procedure Tfproperty.ApplyChanges;
begin
  inherited ApplyChanges;
end;

procedure Tfproperty.ApplyControls;
begin
  resulted.name           := ed_name.Text;
  resulted.short_name     := ed_short_name.Text;
end;

procedure Tfproperty.ApplyINS;
var new_id: integer;
begin
  new_id := GetNextID('GEN_TYPEPROP_ID');

  qW.SQL.Text := 'insert into T_OWNER_FORMS(typeprop_id, name, short_name)' +
                      ' values (:itypeprop_id, :iname, :ishort_name)';
  qW.ParamByName('itypeprop_id').AsInteger    := new_id;
  qW.ParamByName('iname').AsString            := resulted.name;
  qW.ParamByName('ishort_name').AsString      := resulted.short_name;
  qW.ExecQuery;
  resulted.typeprop_id := new_id;
end;

procedure Tfproperty.ApplyUPD;
begin
  qW.SQL.Text := 'update T_OWNER_FORMS set ' +
                     ' name = :iname, ' +
                     ' short_name = :ishort_name ' +
                 ' where typeprop_id = :itypeprop_id ';
  qW.ParamByName('itypeprop_id').AsInteger    := resulted.typeprop_id;
  qW.ParamByName('iname').AsString            := resulted.name;
  qW.ParamByName('ishort_name').AsString      := resulted.short_name;
  qW.ExecQuery;
end;

end.
