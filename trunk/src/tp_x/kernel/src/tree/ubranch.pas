unit ubranch;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, etalon_dlg, dxCntner, IBSQL, IBDatabase, DB, ComCtrls, uZMaster,
  dxExEdtr, dxEdLib, dxEditor, StdCtrls, ExtCtrls, tree_h, kernel_h;

type
  Tfbranch = class(Tfetalon_dlg)
    TabSheet1: TTabSheet;
    Panel1: TPanel;
    Label3: TLabel;
    Label1: TLabel;
    Label8: TLabel;
    ed_name: TdxEdit;
    ed_code: TdxEdit;
    ed_maker: TdxImageEdit;
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

function BranchDialog(grp_id: integer; prew_grp_id: integer;  resulted: PTGroupTreeNode; var prm: ZVelesInfoRec): integer;

implementation

{$R *.dfm}

function BranchDialog(grp_id: integer; prew_grp_id: integer; resulted: PTGroupTreeNode; var prm: ZVelesInfoRec): integer;
var
  dlg: Tfbranch;
  returned: integer;
begin
// Перевірка прав
  returned := 0;
  Result := -1;

try
// Створення та ініціалізація форми діалогу.
    dlg := Tfbranch.Create(Application);
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


procedure Tfbranch.InitInfo;
begin
  inherited InitInfo;

  // Ініціалізація списків
  ListClear(ed_maker);
  ListInit(ed_maker, 'select maker_id as id, maker_name as name from t_makers order by maker_name');
end;

procedure Tfbranch.InitINS;
begin
  Caption := 'Створення нової гілки.';
  resulted.id                 := 0;
  resulted.code               := 0;
  resulted.name               := '';
  resulted.maker_id           := 0;
  resulted.prew_id            := prew_grp_id;
end;

procedure Tfbranch.InitUPD;
var tmp_int: integer;
begin
  Caption := 'Редагування даних про гілку.';
  if(trR.InTransaction)then trR.Commit;
  trR.StartTransaction;
   qR.SQL.Text := 'select grp_id, grp_code, grp_name, prew_grp_id, maker_id from T_NOMEN_GROUPS where grp_id = :igrp_id';
   qR.ParamByName('igrp_id').AsInteger := id.id;
   qR.ExecQuery;
   resulted.id                := qR.FieldByName('grp_id').AsInteger;
   resulted.name              := qR.FieldByName('grp_name').AsString;
   resulted.code              := qR.FieldByName('grp_code').AsInteger;
   resulted.prew_id           := qR.FieldByName('prew_grp_id').AsInteger;
   resulted.maker_id          := qR.FieldByName('maker_id').AsInteger;
  if(trR.InTransaction) then trR.Commit;
end;

procedure Tfbranch.InitControls;
begin
  ed_code.Text                := IntToStr(resulted.code);
  ed_name.Text                := resulted.name;
  ed_maker.Text               := IntToStr(resulted.maker_id);
end;

function Tfbranch.AnalizChanges: integer;
var returned: integer;
begin
  returned := 0;


  Result := returned;
end;

procedure Tfbranch.ApplyChanges;
begin
  inherited ApplyChanges;
end;

procedure Tfbranch.ApplyControls;
begin
  // Підготовка даних
  resulted.code             := StrToInt(ed_code.Text);
  resulted.name             := ed_name.Text;
  resulted.maker_id         := StrToInt(ed_maker.Text);
  if ed_maker.Text <> '0' then
    resulted.maker_name       := ed_maker.Descriptions[ed_maker.Values.IndexOf(ed_maker.Text)]
  else
    resulted.maker_name       := '';
end;

procedure Tfbranch.ApplyINS;
begin
  qW.SQL.Text := 'select ogrp_id from T_GRP_CREATE_CHILD_V1(:iprew_grp_id, :iname, ' +
            ' :icode, :imaker_id)';
  qW.ParamByName('iprew_grp_id').AsInteger        := resulted.prew_id;
  qW.ParamByName('iname').AsString                := resulted.name;
  qW.ParamByName('icode').AsInteger               := resulted.code;
  qW.ParamByName('imaker_id').AsInteger           := resulted.maker_id;
  qW.ExecQuery;
  resulted.id := qW.FieldByName('ogrp_id').AsInteger;
end;

procedure Tfbranch.ApplyUPD;
begin
  qW.SQL.Text := 'update T_NOMEN_GROUPS set ' +
                     ' grp_name = :iname, ' +
                     ' grp_code = :icode ' +
                ' where grp_id = :igrp_id ';
  qW.ParamByName('igrp_id').AsInteger             := resulted.id;
  qW.ParamByName('iname').AsString                := resulted.name;
  qW.ParamByName('icode').AsInteger               := resulted.code;
  qW.ExecQuery;
end;

end.
