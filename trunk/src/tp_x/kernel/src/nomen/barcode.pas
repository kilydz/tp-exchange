unit barcode;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, Tabs, StdCtrls, Buttons, dxEdLib, dxCntner, dxEditor, dxExEdtr,
  ExtCtrls, ComCtrls, IBSQL, IBDatabase, DB,
  nomen_h, {veles_h,} uZMaster, etalon_dlg{, ib_h}, kernel_h, secure_h;

type
  Tfbarcode = class(Tfetalon_dlg)
    TabSheet1: TTabSheet;
    pStage0: TPanel;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    ed_barcode: TdxEdit;
    ed_barcode_type: TdxImageEdit;
    ed_out_price: TdxCalcEdit;
    procedure FormDestroy(Sender: TObject); override;
    procedure EditsKeyPress(Sender: TObject; var Key: Char); override;
    procedure masterMasterResult(Sender: TObject;
      MasterResult: ZMasterResult); override;
    procedure FormShow(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
    resulted: lpZBarcodeDialogResulted;

    procedure InitInfo; override;
    procedure InitINS; override;
    procedure InitUPD; override;
    procedure InitControls; override;

    function  AnalizChanges: integer; override;
    procedure ApplyChanges; override;
    procedure ApplyControls; override;
    procedure ApplyINS; override;
    procedure ApplyUPD; override;

// ********Методи роботи з типами штрихкодів *************
    procedure BarcodeTypesInit;
    procedure BarcodeTypesClear;
  end;

function BarcodeDialog(id: integer; resulted: lpZBarcodeDialogResulted; var prm: ZVelesInfoRec): integer;

implementation

{$R *.dfm}

function BarcodeDialog(id: integer; resulted: lpZBarcodeDialogResulted; var prm: ZVelesInfoRec): integer;
var
  dlg: Tfbarcode;
  returned: integer;
begin
    returned := 0;
// Перевірка прав
try
// Створення та ініціалізація форми діалогу.
    dlg := Tfbarcode.Create(Application);
    dlg.id.id := id;
    dlg.prm := prm;
    dlg.resulted := resulted;
    dlg.InitInfo;
// Візуалізація діалогу

    if dlg.ShowModal = mrOk then
    begin
      returned := 1;
    end;
finally
  if dlg <> nil then dlg.Free;
end;
//    returned <= 0 - код помилки, або відмова;
//    returned > 0  - все ок;
  BarcodeDialog := returned;
end;

//------------------------------------------------------------------------------
//
//------------------------------------------------------------------------------
procedure Tfbarcode.InitInfo;
begin
  inherited InitInfo;
  
  // Ініціалізація типів штрихкодів
  BarcodeTypesInit;
  // Перевірка можливості редагування властивостей товару
  if (GetConfig(prm.db_handle, 400, 'store_nomen') = 'yes') then
  begin
    ed_barcode.Enabled      := False;
    ed_barcode_type.Enabled := False;
  end;
end;

procedure Tfbarcode.InitINS;
begin
  Caption := 'Створення нового штрихкоду.';
  resulted.barcode_id := 0;
  resulted.barcode_type_id := 0;
  resulted.out_price := 0;
end;

procedure Tfbarcode.InitUPD;
begin
  Caption := 'Редагування штрихкода.';
  ed_barcode.Enabled := false;
end;

procedure Tfbarcode.InitControls;
begin
  ed_barcode_type.Text := IntToStr(resulted.barcode_type_id);
  ed_barcode.Text := resulted.barcode;
  ed_out_price.Text := Format('%0.02f', [resulted.out_price]);
end;

function Tfbarcode.AnalizChanges: integer;
var returned: integer;
begin
  returned := 0;
  if(ed_barcode.Text = '')then
  begin
    ShowMessage('Не вказано штрихкода.');
    master.PageIndex := 0;
    ed_barcode.SetFocus;
    returned := -1;
  end;
  AnalizChanges := returned;
end;

procedure Tfbarcode.ApplyChanges;
begin
  inherited ApplyChanges;
end;

procedure Tfbarcode.ApplyControls;
var i: integer;
begin
// Підготовка даних
  resulted.barcode := ed_barcode.Text;
  resulted.barcode_type_id := StrToInt(ed_barcode_type.Text);
  resulted.out_price := StrToFloat(ed_out_price.Text);
  for i := 0 to ed_barcode_type.Values.Count - 1 do
    if ed_barcode_type.Values[i] = ed_barcode_type.Text then
      resulted.type_name := ed_barcode_type.Descriptions[i];
end;

procedure Tfbarcode.ApplyINS;
begin
end;

procedure Tfbarcode.ApplyUPD;
begin
end;
// ********Методи роботи з типами штрихкодів *************
procedure Tfbarcode.BarcodeTypesInit;
begin
  BarcodeTypesClear;

  if(trR.InTransaction)then trR.Commit;
  trR.StartTransaction;
   qR.SQL.Text := 'select barcode_type_id, type_name from t_barcode_types';
   qR.ExecQuery;
   while not qR.Eof do
   begin
     ed_barcode_type.Values.Add(qR.FieldByName('barcode_type_id').AsString);
     ed_barcode_type.Descriptions.Add(qR.FieldByName('type_name').AsString);
     qR.Next;
   end;
  if(trR.InTransaction) then trR.Commit;
end;

procedure Tfbarcode.BarcodeTypesClear;
begin
  ed_barcode_type.Values.Clear;
  ed_barcode_type.Descriptions.Clear;
end;

procedure Tfbarcode.FormDestroy(Sender: TObject);
begin
  inherited FormDestroy(Sender);
  BarcodeTypesClear;
end;

procedure Tfbarcode.EditsKeyPress(Sender: TObject; var Key: Char);
var currWin: TWinControl;
begin
  currWin := TWinControl(Sender);

  inherited EditsKeyPress(Sender, Key);

  if (currWin = ed_barcode) then
  begin
    if (Key < '0') or (Key > '9') then
      Key := #0;
  end else if (currWin = ed_out_price) then
  begin
    if ((Key = '.') or (Key = ',')) then
      Key := ','
    else if (Key < '0') or (Key > '9') then
      Key := #0;
  end
end;

procedure Tfbarcode.masterMasterResult(Sender: TObject;
  MasterResult: ZMasterResult);
begin
  inherited masterMasterResult(Sender, MasterResult);
end;

procedure Tfbarcode.FormShow(Sender: TObject);
begin
  inherited FormShow(Sender);
end;

end.
