unit scale;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, Tabs, StdCtrls, Buttons, dxEdLib, dxCntner, dxEditor, dxExEdtr,
  ExtCtrls, ComCtrls, IBSQL, IBDatabase, DB,
  nomen_h, kernel_h, uZMaster, etalon_dlg, secure_h, libra_sync_h;

type
  Tfscale = class(Tfetalon_dlg)
    TabSheet1: TTabSheet;
    pStage0: TPanel;
    Label1: TLabel;
    Label2: TLabel;
    ed_scale: TdxEdit;
    ed_scale_type: TdxImageEdit;
    Label3: TLabel;
    ed_ip1: TdxMaskEdit;
    ed_ip2: TdxMaskEdit;
    ed_ip3: TdxMaskEdit;
    ed_ip4: TdxMaskEdit;
    Label4: TLabel;
    Label5: TLabel;
    Label6: TLabel;
    procedure FormDestroy(Sender: TObject); override;
    procedure EditsKeyPress(Sender: TObject; var Key: Char); override;
    procedure masterMasterResult(Sender: TObject;
      MasterResult: ZMasterResult); override;
    procedure FormShow(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
    resulted: lpZScaleDialogResulted;

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
    procedure scaleTypesInit;
    procedure scaleTypesClear;
  end;

function ScaleDialog(id: integer; resulted: lpZscaleDialogResulted; var prm: ZVelesInfoRec): integer;

implementation

{$R *.dfm}

function ByteFromIP(IP :string; ByteNo:integer):string;
var i, PointNo :integer;
begin
  Result := '';
  PointNo := 1;
  if ByteNo < 1 then ByteNo := 1
  else if ByteNo > 4 then ByteNo := 4;

  for I := 1 to Length(IP) do
  begin
    if IP[i] = '.' then
      PointNo := PointNo + 1
    else
      if ByteNo = PointNo then
        Result := Result + IP[i];
  end;
  Result := Copy(Result, 1, 3);
  try
    i := StrToInt(Result);
  except
    case ByteNo of
    1:Result := '192';
    2:Result := '168';
    3:Result := '1';
    4:Result := '201';
    end;
  end;
  if i > 256 then
    Result := '256';
end;

function scaleDialog(id: integer; resulted: lpZscaleDialogResulted; var prm: ZVelesInfoRec): integer;
var
  dlg: Tfscale;
  returned: integer;
begin
    returned := 0;
// Перевірка прав
try
// Створення та ініціалізація форми діалогу.
    dlg := Tfscale.Create(Application);
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
  scaleDialog := returned;
end;

//------------------------------------------------------------------------------
//
//------------------------------------------------------------------------------
procedure Tfscale.InitInfo;
begin
  inherited InitInfo;
  
  // Ініціалізація типів штрихкодів
  scaleTypesInit;
//  if (GetConfig(prm.db_handle, 400, 'store_nomen') = 'yes') then
//  begin
//    ed_scale.Enabled      := False;
//    ed_scale_type.Enabled := False;
//  end;
end;

procedure Tfscale.InitINS;
begin
  Caption := 'Створення нової ваги';
  resulted.scale_id := 0;
  resulted.name := '';
  resulted.IP := '192.168.1.201';
  resulted.type_scale := 1;
end;

procedure Tfscale.InitUPD;
begin
  Caption := 'Редагування ваги';
  if trR.InTransaction then trR.Commit;
  trR.StartTransaction;
  qR.SQL.Text := 'select ip, name, type_scale from t_scales where id = '+
                  IntToStr(id.id);
  qR.ExecQuery;
  resulted.IP         := qR.FieldByName('ip').AsString;
  resulted.name       := qR.FieldByName('name').AsString;
  resulted.type_scale := qR.FieldByName('type_scale').AsInteger;
  if trR.InTransaction then trR.Commit;
end;

procedure Tfscale.InitControls;
begin
  ed_scale_type.Text := IntToStr(resulted.type_scale);
  ed_scale.Text := resulted.name;
  ed_ip1.Text := ByteFromIP(resulted.IP, 1);
  ed_ip2.Text := ByteFromIP(resulted.IP, 2);
  ed_ip3.Text := ByteFromIP(resulted.IP, 3);
  ed_ip4.Text := ByteFromIP(resulted.IP, 4);
end;

function Tfscale.AnalizChanges: integer;
var returned: integer;
begin
  returned := 0;
  if(ed_scale.Text = '')then
  begin
    ShowMessage('Введіть назву ваги');
    master.PageIndex := 0;
    ed_scale.SetFocus;
    returned := -1;
  end
  else if(ed_ip1.Text = '')or(ed_ip2.Text = '')or
         (ed_ip3.Text = '')or(ed_ip4.Text = '') then
  begin
    ShowMessage('Невірно введено ІР');
    master.PageIndex := 0;
    ed_ip1.SetFocus;
    returned := -1;
  end;
  AnalizChanges := returned;
end;

procedure Tfscale.ApplyChanges;
begin
  inherited ApplyChanges;
end;

procedure Tfscale.ApplyControls;
var i: integer;
begin
// Підготовка даних
  resulted.name := ed_scale.Text;
  resulted.type_scale := StrToInt(ed_scale_type.Text);
  resulted.IP := ed_ip1.Text + '.' + ed_ip2.Text + '.' +
                 ed_ip3.Text + '.' + ed_ip4.Text;
end;

procedure Tfscale.ApplyINS;
begin
  if trW.InTransaction then trW.Commit;
  trW.StartTransaction;
  qW.SQL.Text := 'select oid from ps_scale_ins(:iip, :iname, :itype_scale)';
  qW.ParamByName('iip').AsString   := resulted.IP;
  qW.ParamByName('iname').AsString := resulted.name;
  qW.ParamByName('itype_scale').AsInteger := resulted.type_scale;
  qW.ExecQuery;

  id.id := qW.FieldByName('oid').AsInteger;
  resulted.scale_id := id.id;
  if trW.InTransaction then trW.Commit;
end;

procedure Tfscale.ApplyUPD;
begin
  if trW.InTransaction then trW.Commit;
  trW.StartTransaction;
  qW.SQL.Text := 'update t_scales                   ' +
                 '   set ip         = :iip,         ' +
                 '       name       = :iname,       ' +
                 '       type_scale = :itype_scale  ' +
                 ' where id = :iid                  ';
  qW.ParamByName('iid').AsInteger  := id.id;
  qW.ParamByName('iip').AsString   := resulted.IP;
  qW.ParamByName('iname').AsString := resulted.name;
  qW.ParamByName('itype_scale').AsInteger := resulted.type_scale;
  qW.ExecQuery;
  if trW.InTransaction then trW.Commit;
end;
// ********Методи роботи з типами ваг *************
procedure Tfscale.scaleTypesInit;
begin
  scaleTypesClear;

  if(trR.InTransaction)then trR.Commit;
  trR.StartTransaction;
   qR.SQL.Text := 'select id, name from T_TYPE_SCALES where is_visible = 1';
   qR.ExecQuery;
   while not qR.Eof do
   begin
     ed_scale_type.Values.Add(qR.FieldByName('id').AsString);
     ed_scale_type.Descriptions.Add(qR.FieldByName('name').AsString);
     qR.Next;
   end;
  if(trR.InTransaction) then trR.Commit;
end;

procedure Tfscale.scaleTypesClear;
begin
  ed_scale_type.Values.Clear;
  ed_scale_type.Descriptions.Clear;
end;

procedure Tfscale.FormDestroy(Sender: TObject);
begin
  inherited FormDestroy(Sender);
  scaleTypesClear;
end;

procedure Tfscale.EditsKeyPress(Sender: TObject; var Key: Char);
var currWin: TWinControl;
begin
  currWin := TWinControl(Sender);

  inherited EditsKeyPress(Sender, Key);

  if (currWin = ed_ip1)or(currWin = ed_ip2)or
     (currWin = ed_ip3)or(currWin = ed_ip4) then
  begin
    if (Key < '0') or (Key > '9') then
      Key := #0;
  end
//  else if (currWin = ed_out_price) then
//  begin
//    if ((Key = '.') or (Key = ',')) then
//      Key := ','
//    else if (Key < '0') or (Key > '9') then
//      Key := #0;
//  end
end;

procedure Tfscale.masterMasterResult(Sender: TObject;
  MasterResult: ZMasterResult);
begin
  inherited masterMasterResult(Sender, MasterResult);
end;

procedure Tfscale.FormShow(Sender: TObject);
begin
  inherited FormShow(Sender);
end;

end.
