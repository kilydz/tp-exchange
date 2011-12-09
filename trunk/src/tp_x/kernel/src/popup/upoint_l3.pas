unit upoint_l3;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, etalon_dlg, ComCtrls, dxCntner, IBSQL, IBDatabase, DB, uZMaster,
  dxEditor, dxEdLib, StdCtrls, ExtCtrls, kernel_h, dxExEdtr;

type
 ZPontL3DialogResulted = record
   l3_point_id: integer;
   name: string;
   post_code: string;
   point_type_id: integer;
 end;

  Tfpoint_l3 = class(Tfetalon_dlg)
    TabSheet1: TTabSheet;
    pStage0: TPanel;
    Label2: TLabel;
    ed_name: TdxEdit;
    ed_post_code: TdxMaskEdit;
    Label1: TLabel;
    ed_point_type_id: TdxImageEdit;
    Label3: TLabel;
  private
    { Private declarations }
  public
    resulted: ZPontL3DialogResulted;
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

function PointL3Dialog(id, prew_id: integer; var prm: ZVelesInfoRec): integer;

implementation

{$R *.dfm}

function PointL3Dialog(id, prew_id: integer; var prm: ZVelesInfoRec): integer;
var
  dlg: Tfpoint_l3;
  returned: integer;
begin
  returned := 0;
try
    dlg := Tfpoint_l3.Create(Application);
    dlg.id.id := id;
    dlg.prew_id := prew_id;
    dlg.prm := prm;
    dlg.InitInfo;

    if (dlg.ShowModal = mrOk) then
    begin
      returned := dlg.resulted.l3_point_id;
    end;
finally
  if dlg <> nil then dlg.Free;
end;

  Result := returned;
end;


procedure Tfpoint_l3.InitINS;
begin
  Caption := 'Процедура створення району.';
  resulted.l3_point_id := 0;
  resulted.name := '';
  resulted.post_code := '';
  resulted.point_type_id := 0;
end;

procedure Tfpoint_l3.InitUPD;
begin
  Caption := 'Процедура редагування району.';
  if(trR.InTransaction)then trR.Commit;
  trR.StartTransaction;
   qR.SQL.Text := 'select l3_point_id, name, post_code, point_type_id from t_l3_points where l3_point_id = :iid';
   qR.ParamByName('iid').AsInteger := id.id;
   qR.ExecQuery;
   resulted.l3_point_id         := qR.FieldByName('l3_point_id').AsInteger;
   resulted.name                := qR.FieldByName('name').AsString;
   resulted.post_code           := qR.FieldByName('post_code').AsString;
   resulted.point_type_id       := qR.FieldByName('point_type_id').AsInteger;
  if(trR.InTransaction) then trR.Commit;
end;

procedure Tfpoint_l3.InitControls;
begin
  ed_name.Text              := resulted.name;
  ed_post_code.Text         := resulted.post_code;
  ed_point_type_id.Text     := IntToStr(resulted.point_type_id);
end;

function ClearBanks(str: string): string;
var i: integer;
begin
  i := 1;
  while i <= strlen(PAnsiChar(str)) do
  begin
    if str[i] = ' ' then
      delete(str, i, 1)
    else
      i := i+1;
  end;
  result := str;
end;

function Tfpoint_l3.AnalizChanges: integer;
var returned: integer;
begin
  returned := 0;
  if(ed_name.Text = '')then
  begin
    ShowMessage('Не вказано назви населеного пункту.');
    master.PageIndex := 0;
    ed_name.SetFocus;
    returned := -1;
  end
  else if(strlen(PAnsiChar(ClearBanks(ed_post_code.Text))) < 5)then
  begin
    ShowMessage('Поштовий індекс має бути довжиною 5 символів.');
    master.PageIndex := 0;
    ed_post_code.SetFocus;
    returned := -1;
  end
  else if(ed_point_type_id.Text = '0')then
  begin
    ShowMessage('Не вказано тип населеного пункту.');
    master.PageIndex := 0;
    ed_point_type_id.SetFocus;
    returned := -1;
  end;

  AnalizChanges := returned;
end;

procedure Tfpoint_l3.ApplyChanges;
begin
  inherited ApplyChanges;
end;

procedure Tfpoint_l3.ApplyControls;
begin
  resulted.name           := ed_name.Text;
  resulted.post_code      := ed_post_code.Text;
  resulted.point_type_id  := StrToInt(ed_point_type_id.Text);
end;

procedure Tfpoint_l3.ApplyINS;
var new_id: integer;
begin
  new_id := GetNextID('GEN_T_L3_POINTS_ID');

  qW.SQL.Text := 'insert into t_l3_points(l3_point_id, name, l2_point_id, post_code, point_type_id)' +
                      ' values (:il3_point_id, :iname, :il2_point_id, :ipost_code, :ipoint_type_id)';
  qW.ParamByName('il3_point_id').AsInteger    := new_id;
  qW.ParamByName('iname').AsString            := resulted.name;
  qW.ParamByName('ipost_code').AsString       := resulted.post_code;
  qW.ParamByName('il2_point_id').AsInteger    := prew_id;
  qW.ParamByName('ipoint_type_id').AsInteger  := resulted.point_type_id;

  qW.ExecQuery;
  resulted.l3_point_id := new_id;
end;

procedure Tfpoint_l3.ApplyUPD;
begin
  qW.SQL.Text := 'update t_l3_points set ' +
                     ' name = :iname, ' +
                     ' post_code = :ipost_code, ' +
                     ' point_type_id = :ipoint_type_id ' +
                 ' where l3_point_id = :il3_point_id ';
  qW.ParamByName('il3_point_id').AsInteger    := resulted.l3_point_id;
  qW.ParamByName('iname').AsString            := resulted.name;
  qW.ParamByName('ipost_code').AsString       := resulted.post_code;
  qW.ParamByName('ipoint_type_id').AsInteger  := resulted.point_type_id;
  qW.ExecQuery;
end;

end.
