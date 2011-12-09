unit umaker;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ComCtrls, uZMaster, ExtCtrls, StdCtrls, dxExEdtr, dxEdLib,
  dxCntner, dxEditor, dxTL, dxDBCtrl, dxDBGrid, ImgList, IBSQL, IBDatabase,
  DB, IB,
  kernel_h, editors_h, popup_h, etalon_dlg;

type
  Tfmaker = class(Tfetalon_dlg)
    ImageList1: TImageList;
    TabSheet1: TTabSheet;
    pStage0: TPanel;
    Label2: TLabel;
    ed_maker_name: TdxEdit;
    procedure FormDestroy(Sender: TObject); override;
  private
    { Private declarations }
  public
    { Public declarations }
    resulted: lpZMakerDialogResulted;

    procedure InitINS; override;
    procedure InitUPD; override;
    procedure InitControls; override;

    function  AnalizChanges: integer; override;
    procedure ApplyChanges; override;
    procedure ApplyControls; override;
    procedure ApplyINS; override;
    procedure ApplyUPD; override;
  end;

function MakerDialog(id: integer; resulted: lpZMakerDialogResulted; var prm: ZVelesInfoRec): integer;
implementation

{$R *.dfm}

function MakerDialog(id: integer; resulted: lpZMakerDialogResulted; var prm: ZVelesInfoRec): integer;
var
  dlg: Tfmaker;
  returned: integer;
begin
// Перевірка прав
  returned := 0;
try
// Створення та ініціалізація форми діалогу.
    dlg := Tfmaker.Create(Application);
    dlg.id.id := id;
    dlg.prm := prm;
    dlg.resulted := resulted;
    dlg.InitInfo;

// Візуалізація діалогу
    if (dlg.ShowModal = mrOk) then
    begin
      returned := dlg.resulted.maker_id;
    end;
finally
  if dlg <> nil then dlg.Free;
end;
//    returned <= 0 - код помилки, або відмова;
//    returned > 0  - id результату;
  Result := returned;
end;

procedure Tfmaker.InitINS;
begin
  Caption := 'Процедура створення виробника.';
  resulted.maker_id := 0;
  resulted.maker_name := '';
end;

procedure Tfmaker.InitUPD;
begin
  Caption := 'Процедура редагування виробника.';
  if(trR.InTransaction)then trR.Commit;
  trR.StartTransaction;
   qR.SQL.Text := 'select maker_id, maker_name ' +
                           ' from t_makers where maker_id = :imaker_id';
   qR.ParamByName('imaker_id').AsInteger := id.id;
   qR.ExecQuery;
   resulted.maker_id     := qR.FieldByName('maker_id').AsInteger;
   resulted.maker_name   := qR.FieldByName('maker_name').AsString;
  if(trR.InTransaction) then trR.Commit;
end;

procedure Tfmaker.InitControls;
begin
  ed_maker_name.Text        := resulted.maker_name;
end;

function Tfmaker.AnalizChanges: integer;
var returned: integer;
begin
  returned := 0;

  if(ed_maker_name.Text = '')then
  begin
    ShowMessage('Не вказано назву виробника.');
    master.PageIndex := 0;
    ed_maker_name.SetFocus;
    returned := -1;
  end;

  AnalizChanges := returned;
end;

procedure Tfmaker.ApplyChanges;
begin
  inherited ApplyChanges;
end;

procedure Tfmaker.ApplyControls;
begin
  resulted.maker_name        := ed_maker_name.Text;
end;

procedure Tfmaker.ApplyINS;
begin
  qW.SQL.Text := 'select omaker_id from PS_MAKER_INS(:imaker_name)';
  qW.ParamByName('imaker_name').AsString    := resulted.maker_name;
  qW.ExecQuery;
  resulted.maker_id := qW.FieldByName('omaker_id').AsInteger;
end;

procedure Tfmaker.ApplyUPD;
begin
  qW.SQL.Text := 'update t_makers set ' +
                     ' maker_name = :imaker_name ' +
                 ' where maker_id = :imaker_id ';
  qW.ParamByName('imaker_id').AsInteger   := resulted.maker_id;
  qW.ParamByName('imaker_name').AsString  := resulted.maker_name;
  qW.ExecQuery;
end;

procedure Tfmaker.FormDestroy(Sender: TObject);
begin
  inherited FormDestroy(Sender);
end;

end.
