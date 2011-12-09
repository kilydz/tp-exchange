unit uscale;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, etalon_dlg, dxCntner, IBSQL, IBDatabase, DB, ComCtrls, uZMaster,
  dxExEdtr, dxEdLib, dxEditor, StdCtrls, ExtCtrls, kernel_h;

type
  ZScaleDialogResulted = record
    scale_id:             integer;
    number:               integer;
    name:                 string;
    scale_interface_id:   smallint;
    scale_type_id:        smallint;
    prefix:               integer;
   end;
lpZScaleDialogResulted = ^ZScaleDialogResulted;

  Tfscale = class(Tfetalon_dlg)
    TabSheet1: TTabSheet;
    pStage0: TPanel;
    Label1: TLabel;
    Label2: TLabel;
    Label10: TLabel;
    ed_name: TdxEdit;
    ed_scale_interface: TdxImageEdit;
    ed_scale_type: TdxImageEdit;
    ed_number: TdxSpinEdit;
    ed_prefix: TdxImageEdit;
    Label3: TLabel;
    Label4: TLabel;
    procedure ed_scale_typeChange(Sender: TObject);
  private
    { Private declarations }
  public
    resulted: ZScaleDialogResulted;

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

function ScaleDialog(var id: ZFuncArgs; var prm: ZVelesInfoRec): integer;

var
  fscale: Tfscale;

implementation

{$R *.dfm}

function ScaleDialog(var id: ZFuncArgs; var prm: ZVelesInfoRec): integer;
var
  dlg: Tfscale;
  returned: integer;
begin
// Перевірка прав
  returned := 0;
  Result := -1;
 // if not HasUserAccessEx(prm, ACCESS_TO_CLIENT_INS_UPD) then
 //   Exit;
try
// Створення та ініціалізація форми діалогу.
    dlg := Tfscale.Create(Application);
    dlg.id := id;
    dlg.prm := prm;
    dlg.InitInfo;
// Візуалізація діалогу

    if (dlg.ShowModal = mrOk) then
    begin
      returned := dlg.resulted.scale_id;
    end;
finally
  if dlg <>nil then dlg.Free;
end;
//    returned <= 0 - код помилки, або відмова;
//    returned > 0  - id результату;
  ScaleDialog := returned;
end;

//------------------------------------------------------------------------------
//
//------------------------------------------------------------------------------
procedure Tfscale.InitInfo;
var zkpo:integer;
    typeclient_sql: string;
begin

  inherited InitInfo;

  ListClear(ed_scale_type);
  ListInit(ed_scale_type, 'select scale_type_id as id, name from t_scale_types order by name');
 {
  ListClear(ed_typeprop);
  ListInit(ed_typeprop, 'select typeprop_id as id, ' + #39 + '(' + #39 + ' || short_name ||  ' +
                   #39 + ') ' + #39 + ' || name as name from T_OWNER_FORMS order by short_name');
                   }
end;


procedure Tfscale.InitINS;
begin
  Caption := 'Створення нового клієнта.';
  resulted.scale_id             := 0;
  resulted.number               := 0;
  resulted.prefix               := 22;
  resulted.name                 := '';
  resulted.scale_interface_id   := 0;
  resulted.scale_type_id        := 1;
end;

procedure Tfscale.InitUPD;
begin
  Caption := 'Редагування ваги.';
  if(trR.InTransaction)then trR.Commit;
  trR.StartTransaction;
   qR.SQL.Text := 'select scale_id, number, name, scale_interface_id, ' +
                           ' scale_type_id, prefix ' +
                      '  from t_scales_v1 where scale_id = :iscale_id';
   qR.ParamByName('iscale_id').AsInteger := id.id;
   qR.ExecQuery;
   resulted.scale_id            := qR.FieldByName('scale_id').AsInteger;
   resulted.number              := qR.FieldByName('number').AsInteger;
   resulted.name                := qR.FieldByName('name').AsString;
   resulted.scale_interface_id  := qR.FieldByName('scale_interface_id').AsInteger;
   resulted.scale_type_id       := qR.FieldByName('scale_type_id').AsInteger;
   resulted.prefix              := qR.FieldByName('prefix').AsInteger;
  if(trR.InTransaction) then trR.Commit;

  ed_scale_type.Enabled := false;
  ed_scale_interface.Enabled := false;
end;

procedure Tfscale.InitControls;
begin
  ed_number.Value             := resulted.number;
  ed_name.Text                := resulted.name;
  ed_scale_interface.Text     := IntToStr(resulted.scale_interface_id);
  ed_scale_type.Text          := IntToStr(resulted.scale_type_id);
  ed_prefix.Text              := IntToStr(resulted.prefix);
end;

function Tfscale.AnalizChanges: integer;
var returned: integer;
    date_tmp: TDateTime;
begin
  returned := 0;

  AnalizChanges := returned;
end;

procedure Tfscale.ApplyChanges;
begin
  inherited ApplyChanges;
end;

procedure Tfscale.ApplyControls;
begin
  // Підготовка даних
  resulted.number               := Round(ed_number.Value);
  resulted.name                 := ed_name.Text;
  resulted.scale_interface_id   := StrToInt(ed_scale_interface.Text);
  resulted.scale_type_id        := StrToInt(ed_scale_type.Text);
  resulted.prefix               := StrToInt(ed_prefix.Text);
end;

procedure Tfscale.ApplyINS;
var gen_id: integer;
begin
  gen_id := GetNextID('GEN_T_SCALES_V1_ID');

  qW.SQL.Text := ' insert into t_scales_v1 (scale_id, number, prefix, name, scale_interface_id, scale_type_id) ' +
  ' values (:iscale_id, :inumber, :iprefix, :iname, :iscale_interface_id, :iscale_type_id) ';
  qW.ParamByName('iscale_id').AsInteger           := gen_id;
  qW.ParamByName('inumber').AsInteger             := resulted.number;
  qW.ParamByName('iprefix').AsInteger             := resulted.prefix;
  qW.ParamByName('iname').AsString                := resulted.name;
  qW.ParamByName('iscale_interface_id').AsInteger := resulted.scale_interface_id;
  qW.ParamByName('iscale_type_id').AsInteger      := resulted.scale_type_id;
  qW.ExecQuery;
  resulted.scale_id := gen_id;
end;

procedure Tfscale.ApplyUPD;
begin
  qW.SQL.Text := 'update t_scales_v1 set ' +
                        ' number = :inumber, ' +
                        ' name = :iname,' +
                        ' prefix = :iprefix, ' +
                        ' scale_interface_id = :iscale_interface_id, ' +
                        ' scale_type_id = :iscale_type_id ' +
                   ' where scale_id = :iscale_id ';
  qW.ParamByName('iscale_id').AsInteger           := resulted.scale_id;
  qW.ParamByName('inumber').AsInteger             := resulted.number;
  qW.ParamByName('iprefix').AsInteger             := resulted.prefix;
  qW.ParamByName('iname').AsString                := resulted.name;
  qW.ParamByName('iscale_interface_id').AsInteger := resulted.scale_interface_id;
  qW.ParamByName('iscale_type_id').AsInteger      := resulted.scale_type_id;
  qW.ExecQuery;
end;


procedure Tfscale.ed_scale_typeChange(Sender: TObject);
var has_com, has_eithernet: integer;
    i: integer;
begin
  if trR.InTransaction then trR.Commit;
  trR.StartTransaction;
   qR.SQL.Text := 'select has_com, has_eithernet from t_scale_types where scale_type_id = :itype';
   qR.ParamByName('itype').AsInteger := StrToInt(ed_scale_type.Text);
   qR.ExecQuery;
   has_com := qR.FieldByName('has_com').AsInteger;
   has_eithernet := qR.FieldByName('has_eithernet').AsInteger;
  if trR.InTransaction then trR.Commit;

  ed_scale_interface.Descriptions.Clear;
  ed_scale_interface.Values.Clear;
  if has_com = 1 then
  begin
    ed_scale_interface.Descriptions.Add('COM порт');
    ed_scale_interface.Values.Add('0');
    if resulted.scale_interface_id = 0 then
      ed_scale_interface.Text := '0'
    else
      ed_scale_interface.Text := '1'
  end;
  if has_eithernet = 1 then
  begin
    ed_scale_interface.Descriptions.Add('Eithernet');
    ed_scale_interface.Values.Add('1');
    if resulted.scale_interface_id = 1 then
      ed_scale_interface.Text := '1'
    else
      ed_scale_interface.Text := '0';
  end;

  ed_scale_interface.Text := ed_scale_interface.Values[0];
  for i := 0 to ed_scale_interface.Descriptions.Count - 1 do
  begin
   try
    if resulted.scale_interface_id = StrToInt(ed_scale_interface.Values[i]) then
      ed_scale_interface.Text := ed_scale_interface.Values[i];
   except

   end;
  end;
end;

end.
