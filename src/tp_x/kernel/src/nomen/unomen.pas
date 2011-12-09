unit unomen;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, dxCntner, Tabs, StdCtrls, Buttons, dxExEdtr, dxEdLib, dxEditor,
  ExtCtrls, ComCtrls, IB,
  ImgList, IBSQL, IBDatabase, DB, uZMaster, Grids, ToolWin, tree_h, nomen_h, ExtDlgs,
  uZToolBar, etalon_dlg, popups_h, kernel_h, secure_h, DBGrids,
  uZVirtualGrid, RxMemDS, uZToolButton;

type

  ZNomenDialogResulted = record
     nomen_id: integer;
     grp_id: integer;
     sg_id: integer;
     si_id: integer;
     typepdv_id: integer;
     is_dividend: integer;
     code: string;
     full_name: string;
     short_name: string;
     netto: real;
     min_rest: real;
     is_visible: integer;
     is_active: integer;
     out_price: real;
     maker_id: integer;
     type_nomen: integer;
     is_in_discount: integer;
     termin: integer;
     src_client_id: integer;
     l0_point_id: integer;
   end;
lpZNomenDialogResulted = ^ZNomenDialogResulted;

  Tfnomen = class(Tfetalon_dlg)
    ImageList1: TImageList;
    TabSheet1: TTabSheet;
    pStage0: TPanel;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    Label8: TLabel;
    ed_tree: TdxPopupEdit;
    ed_code: TdxEdit;
    ed_full_name: TdxEdit;
    ed_short_name: TdxEdit;
    ed_sg: TdxImageEdit;
    TabSheet2: TTabSheet;
    pStage1: TPanel;
    Label5: TLabel;
    Label7: TLabel;
    Label6: TLabel;
    Label9: TLabel;
    ed_is_dividend: TdxCheckEdit;
    ed_typePDV: TdxImageEdit;
    ed_min_rest: TdxCalcEdit;
    ed_netto: TdxCalcEdit;
    ed_si: TdxImageEdit;
    ed_is_visible: TdxCheckEdit;
    ed_is_active: TdxCheckEdit;
    TabSheet3: TTabSheet;
    pStage2: TPanel;
    ZToolBar1: ZToolBar;
    TabSheet4: TTabSheet;
    pStage3: TPanel;
    Label10: TLabel;
    ed_out_price: TdxCalcEdit;
    Label11: TLabel;
    Label12: TLabel;
    ed_maker: TdxPopupEdit;
    ed_type_nomen: TdxImageEdit;
    Label14: TLabel;
    ed_is_in_discount: TdxCheckEdit;
    ed_barcodes: ZVirtualGrid;
    bt_ins_barcode: ZToolButton;
    bt_del_barcode: ZToolButton;
    Label15: TLabel;
    ed_termin: TdxSpinEdit;
    Label16: TLabel;
    Label13: TLabel;
    ed_src_client: TdxPopupEdit;
    Label17: TLabel;
    ed_l0_point: TdxPopupEdit;
    procedure EditsKeyPress(Sender: TObject; var Key: Char); override;
    procedure barcodeClick(Sender: TObject);
    procedure FormDestroy(Sender: TObject); override;
    procedure masterMasterResult(Sender: TObject; MasterResult: ZMasterResult);
  private
    { Private declarations }
  public
    { Public declarations }
    resulted: ZNomenDialogResulted;

    tree_prm: TTreeParams;

    conf_price_edit: boolean;

    maker_popup_prm: ZPopupParams;
    src_client_popup_prm: ZPopupParams;
    l0_point_popup_prm: ZPopupParams;

    procedure InitInfo; override;
    procedure InitINS; override;
    procedure InitUPD; override;
    procedure InitControls; override;

    function  AnalizChanges: integer; override;
    procedure ApplyChanges; override;
    procedure ApplyControls; override;
    procedure ApplyINS; override;
    procedure ApplyUPD; override;
    procedure ApplyDefault; override;
    
// ********Методи роботи зі штрихкодами*************
    procedure BarcodesInit;
    procedure BarcodesApply;
    procedure BarcodesClear;

// ********Методи роботи з типами ПДВ ***************
    procedure TypePDVInit;
    procedure TypePDVClear;
  end;

function NomenDialog(var id: ZFuncArgs; var prm: ZVelesInfoRec): integer;

procedure ChengeBranchEv(var prm: TTreeParams);
procedure ShowHideEv(var prm: TTreeParams);

implementation

uses barcode;

{$R *.dfm}

function NomenDialog(var id: ZFuncArgs; var prm: ZVelesInfoRec): integer;
var
  dlg: Tfnomen;
  returned: integer;
begin
// Перевірка прав
  returned := 0;
  Result := -1;
  if not HasUserAccessEx(prm, ACCESS_TO_NOMEN_INS_UPD) then
      Exit;
try
// Створення та ініціалізація форми діалогу.
    dlg := Tfnomen.Create(Application);
    dlg.id := id;
    dlg.prm := prm;
    dlg.InitInfo;
// Візуалізація діалогу

    if (dlg.ShowModal = mrOk) then
    begin
      returned := dlg.resulted.nomen_id;
    end;
finally
  if dlg <> nil then dlg.Free;
end;
//    returned <= 0 - код помилки, або відмова;
//    returned > 0  - id результату;
  Result := returned;
end;

procedure ChengeBranchEv(var prm: TTreeParams);
var
  fnomen: Tfnomen;
begin
  fnomen := Tfnomen(prm.PrewForma);
  fnomen.resulted.grp_id := prm.ActiveNode.id;
  if prm.ActiveNode.id <= 0 then
    fnomen.ed_tree.Text := 'Не визначена група'
  else
    fnomen.ed_tree.Text := prm.ActiveNode.name;
end;
//------------------------------------------------------------------------------

procedure ShowHideEv(var prm: TTreeParams);
begin
end;

//------------------------------------------------------------------------------
//
//------------------------------------------------------------------------------
procedure TFnomen.InitInfo;
begin
  // Ініціалізація дерева
  if @tree_prm.OnChengeBranch = nil then
  begin
    tree_prm.sGen := prm;
    tree_prm.PrewForma := self;
    tree_prm.OnChengeBranch := @ChengeBranchEv;
    tree_prm.OnShowHide := @ShowHideEv;
    tree_prm.Visible := true;
    TreeCreate(tree_prm);
    ed_tree.PopupControl := tree_prm.Panel;
  end;

  conf_price_edit := not (GetConfig(prm.db_handle, 1, 'store_nomen') = 'no');
  if not conf_price_edit then
    ed_out_price.ReadOnly := True;

  if (not HasUserAccessEx(prm, ACCESS_TO_UPD_TYPE_NOMEN, false))//and (id > 0)
    then ed_type_nomen.Enabled := False;

  inherited InitInfo;

    // Перевірка можливості редагування властивостей товару
  if (GetConfig(prm.db_handle, 400, 'store_nomen') = 'yes') then
  begin
    ed_sg.Enabled          := False;
    ed_full_name.ReadOnly  := True;
    ed_short_name.ReadOnly := True;
    ed_typePDV.Enabled     := False;
    ed_maker.Enabled       := False;
    ed_si.Enabled          := False;
    ed_netto.ReadOnly      := True;
//    ed_min_rest.ReadOnly   := True;
    ed_is_dividend.Enabled := False;
//    ed_is_visible.Enabled  := False;
    ed_is_active.Enabled   := False;
    bt_ins_barcode.Visible := False;
    //bt_del_barcode.Visible := False
//    ed_type_nomen.Enabled  := False;
    ed_is_in_discount.Enabled := False;

    if trR.InTransaction then trR.Commit;
    trR.StartTransaction;
    qR.SQL.Text := 'select w3_nomen_id, is_markup_block, is_outprice_block from t_nomens where nomen_id =' + IntToStr(resulted.nomen_id);
    qR.ExecQuery;
    //Налаштування поля "видимість" в залежності від "зв'язаності" товару
    if resulted.is_visible = 1 then
    begin
      if qR.FieldByName('w3_nomen_id').IsNull then
        ed_is_visible.Enabled := True
      else
        ed_is_visible.Enabled := False;
    end;
    //Налаштування можливості редагування ціни
    if ((qR.FieldByName('is_markup_block').AsInteger = 1)or
        (qR.FieldByName('is_outprice_block').AsInteger = 1)) then
      ed_out_price.ReadOnly := True;

    if trR.InTransaction then trR.Commit;

  end;

  // Ініціалізація списків
  BarcodesInit;
  TypePDVInit;

  ListClear(ed_sg);
  ListInit(ed_sg, 'select sg_id as id, sg_name as name from T_SPEC_GROUPS sg');
  ListClear(ed_si);
  ListInit(ed_si, 'select si_id as id, si_name as name from T_SIS order by si_id');

end;

procedure TFnomen.InitINS;
begin
  Caption := 'Створення нового товару.';
  resulted.nomen_id      := 0;
  resulted.sg_id         := 0;
  resulted.si_id         := 1;
  resulted.grp_id        := StrToInt(id.id1);
  resulted.code          := '000000';
  ed_code.Enabled        := false;
  resulted.short_name    := '';
  resulted.full_name     := '';
  resulted.typepdv_id    := 3;
  resulted.is_dividend   := 0;
  resulted.netto         := 1;
  resulted.min_rest      := 10;
  resulted.is_visible    := 1;
  resulted.is_active     := 1;
  resulted.out_price     := 1.00;
  resulted.maker_id      := 0;
  resulted.type_nomen    := 0;
  resulted.is_in_discount:= 1;
  resulted.termin        := 30;
  resulted.src_client_id := 0;
  resulted.l0_point_id   := 0;
end;

procedure Tfnomen.InitUPD;
var tmp_int: integer;
begin
  Caption := 'Редагування товару.';
  if(trR.InTransaction)then trR.Commit;
  trR.StartTransaction;
   qR.SQL.Text := ' select nomen_id, grp_id, sg_id, si_id, nomen_code, nomen_name, '+
                        ' datex_name, typepdv_id, is_weight, brutto, minkilk, is_visible, '+
                        ' is_active, out_price, maker_id, type_nomen,'+
                        ' is_in_discount, termin, src_client_id, l0_point_id '+
                  ' from t_nomens '+
                  ' where nomen_id = :vnomen_id ';
   qR.ParamByName('vnomen_id').AsInteger := id.id;
   qR.ExecQuery;
   resulted.nomen_id     := qR.FieldByName('nomen_id').AsInteger;
   resulted.grp_id       := qR.FieldByName('grp_id').AsInteger;
 try
   resulted.code         := qR.FieldByName('nomen_code').AsString;
   tmp_int               := StrToInt(resulted.code);
 except
   resulted.code         := '000000';
 end;
   resulted.full_name       := qR.FieldByName('nomen_name').AsString;
   resulted.short_name      := qR.FieldByName('datex_name').AsString;
   resulted.sg_id           := qR.FieldByName('sg_id').AsInteger;
   resulted.si_id           := qR.FieldByName('si_id').AsInteger;
   resulted.typepdv_id      := qR.FieldByName('typepdv_id').AsInteger;
   resulted.is_dividend     := qR.FieldByName('is_weight').AsInteger;
   resulted.netto           := qR.FieldByName('brutto').AsCurrency;
   resulted.min_rest        := qR.FieldByName('minkilk').AsCurrency;
   resulted.is_visible      := qR.FieldByName('is_visible').AsInteger;
   resulted.is_active       := qR.FieldByName('is_active').AsInteger;
   resulted.out_price       := qR.FieldByName('out_price').AsCurrency;
   resulted.maker_id        := qR.FieldByName('maker_id').AsInteger;
   resulted.type_nomen      := qR.FieldByName('type_nomen').AsInteger;
   resulted.is_in_discount  := qR.FieldByName('is_in_discount').AsInteger;
   resulted.termin          := qR.FieldByName('termin').AsInteger;
   resulted.src_client_id   := qR.FieldByName('src_client_id').AsInteger;
   resulted.l0_point_id     := qR.FieldByName('l0_point_id').AsInteger;
  if(trR.InTransaction) then trR.Commit;
end;

procedure Tfnomen.masterMasterResult(Sender: TObject;
  MasterResult: ZMasterResult);
begin
if ((MasterResult = MasterResultCancel)and(resulted.full_name = '')) then
begin
  if trW.InTransaction then trW.Commit;
  trW.StartTransaction;
  qW.SQL.Text := 'delete from t_goods where nomen_id = :inomen_id ';
  qW.ParamByName('inomen_id').AsInteger    := resulted.nomen_id;
  qW.ExecQuery;
  qW.SQL.Text := 'select * from PS_NOMEN_DEL(:inomen_id) ';
  qW.ParamByName('inomen_id').AsInteger    := resulted.nomen_id;
  qW.ExecQuery;
  if trW.InTransaction then trW.Commit;
end;
  inherited;
end;

procedure Tfnomen.InitControls;
begin
  tree_prm.SetGrpId           := resulted.grp_id;
  TreeToGroup(tree_prm);
  ed_code.Text                := resulted.code;
  ed_full_name.Text           := resulted.full_name;
  ed_short_name.Text          := resulted.short_name;
  ed_sg.Text                  := IntToStr(resulted.sg_id);
  ed_si.Text                  := IntToStr(resulted.si_id);
  ed_type_nomen.Text          := IntToStr(resulted.type_nomen);
  ed_typePDV.Text             := IntToStr(resulted.typePDV_id);
  ed_is_dividend.Checked      := IntToBool(resulted.is_dividend);
  ed_netto.Text               := FloatToStr(resulted.netto);
  ed_min_rest.Text            := FloatToStr(resulted.min_rest);
  ed_is_visible.Checked       := IntToBool(resulted.is_visible);
  ed_is_active.Checked        := IntToBool(resulted.is_active);
  ed_is_in_discount.Checked   := IntToBool(resulted.is_in_discount);
  if conf_price_edit then
    ed_out_price.Text           := FloatToStr(resulted.out_price);
  ed_termin.Text              := IntToStr(resulted.termin);

  l0_point_popup_prm.ed_popup := ed_l0_point;
  L0PointPopupCreate(@l0_point_popup_prm, prm);
  l0_point_popup_prm.id := resulted.l0_point_id;
  L0PointPopupRefresh(@l0_point_popup_prm);

  maker_popup_prm.ed_popup := ed_maker;
  MakerPopupCreate(@maker_popup_prm, prm);
  maker_popup_prm.id := resulted.maker_id;
  MakerPopupRefresh(@maker_popup_prm);

  src_client_popup_prm.ed_popup := ed_src_client;
  ClientPopupCreate(@src_client_popup_prm, prm);
  src_client_popup_prm.id := resulted.src_client_id;
  ClientPopupRefresh(@src_client_popup_prm, 4);
end;

function TFnomen.AnalizChanges: integer;
var returned: integer;
    tmp_int: integer;
begin
  returned := 0;

 try
   tmp_int               := StrToInt(ed_code.Text);
 except
   ShowMessage('Недопустимий код товару.');
   master.PageIndex := 0;
   ed_code.SetFocus;
   returned := -1;
 end;

if (returned <> -1) then
  if (strlen(PChar(ed_code.Text)) <> 6) then
  begin
    ShowMessage('Довжина коду товару повинна бути рівна шести символам.');
    master.PageIndex := 0;
    ed_code.SetFocus;
    returned := -1;
  end else if (ed_code.Text = '') then
  begin
    ShowMessage('Не визначено код товару.');
    master.PageIndex := 0;
    ed_code.SetFocus;
    returned := -1;
  end else if(resulted.grp_id = 0)then
  begin
    ShowMessage('Не визначена група товару.');
    master.PageIndex := 0;
    ed_tree.SetFocus;
    returned := -1;
  end else if(ed_full_name.Text = '')then
  begin
    ShowMessage('Не вказано повну назву товару.');
    master.PageIndex := 0;
    ed_full_name.SetFocus;
    returned := -1;
  end else if(ed_short_name.Text = '')then
  begin
    ShowMessage('Не вказано коротку назву товару.');
    master.PageIndex := 0;
    ed_short_name.SetFocus;
    returned := -1;
  end else if not(ed_is_visible.Checked)then
  begin
    if trR.InTransaction then trR.Commit;
    trR.StartTransaction;
    qR.SQL.Text := 'select rest from T_RESTS '+
                    ' where nomen_id = :inomen_id';
    qR.ParamByName('inomen_id').AsInteger := resulted.nomen_id;
    qR.ExecQuery;
    if qR.FieldByName('rest').AsInteger <> 0 then
     begin
       ShowMessage('Не можна вказувати товар невидимим, якщо на нього є залишок.');
       master.PageIndex := 1;
       ed_is_visible.SetFocus;
       returned := -1;
     end;
    if trR.InTransaction then trR.Commit;
  end;
  if (returned <> -1) then
  begin
    if (id.id <= 0) then exit;

    if trR.InTransaction then trR.Commit;
    trR.StartTransaction;
     qR.SQL.Text := 'select count(nomen_id) as ocnt from t_nomens '+
                       ' where nomen_code=tosix(' + #39 + ed_code.Text + #39 + ') '+
                       '  and nomen_id<>:inomen_id';
     qR.ParamByName('inomen_id').AsInteger := resulted.nomen_id;
     qR.ExecQuery;
     if qR.FieldByName('ocnt').AsInteger > 0 then
     begin
       ShowMessage('Задубльовано код товару.');
       master.PageIndex := 0;
       ed_code.SetFocus;
       returned := -1;
     end;
    if trR.InTransaction then trR.Commit;
  end;

  AnalizChanges := returned;
end;

procedure TFnomen.ApplyChanges;
begin
  inherited ApplyChanges;

  BarcodesApply;
end;

procedure Tfnomen.ApplyControls;
begin
  // Підготовка даних
  resulted.code             := ed_code.Text;
  resulted.short_name       := ed_short_name.Text;
  resulted.full_name        := ed_full_name.Text;
  resulted.sg_id            := StrToInt(ed_sg.Text);
  resulted.si_id            := StrToInt(ed_si.Text);
  resulted.typepdv_id       := StrToInt(ed_typePDV.Text);
  resulted.is_dividend      := BoolToInt(ed_is_dividend.Checked);
  resulted.netto            := StrToFloat(ed_netto.Text);
  resulted.min_rest         := StrToFloat(ed_min_rest.Text);
  resulted.is_visible       := BoolToInt(ed_is_visible.Checked);
  resulted.is_active        := BoolToInt(ed_is_active.Checked);
  if conf_price_edit then
    resulted.out_price      := StrToFloat(ed_out_price.Text);
  resulted.maker_id         := maker_popup_prm.id;
  resulted.type_nomen       := StrToInt(ed_type_nomen.Text);
  resulted.is_in_discount   := BoolToInt(ed_is_in_discount.Checked);
  resulted.termin           := StrToInt(ed_termin.Text);
  resulted.src_client_id    := src_client_popup_prm.id;
  resulted.l0_point_id      := l0_point_popup_prm.id;
end;

procedure Tfnomen.ApplyINS;
var gen_nomen_id: integer;
begin
  gen_nomen_id := GetNextID('GEN_NOMEN_ID');

  qW.SQL.Text := 'insert into t_nomens (nomen_id, grp_id, sg_id, si_id, nomen_code, nomen_name, datex_name, ' +
                 ' typepdv_id, brutto, minkilk, is_weight, out_price, is_visible, is_active, ' +
                 ' maker_id, type_nomen, is_in_discount, termin, src_client_id, l0_point_id) ' +
    ' values (:inomen_id, :igrp_id, :isg_id, :isi_id, ''000000'', :ifull_name, :ishort_name, ' +
                 ' :itypepdv_id, :inetto, :imin_rest, :iis_dividend, 1.00, :iis_visible, :iis_active, ' +
                 ' :imaker_id, :itype_nomen, :iis_in_discount, :itermin, :isrc_client_id, :il0_point_id);';
  qW.ParamByName('inomen_id').AsInteger    := gen_nomen_id;
  qW.ParamByName('igrp_id').AsInteger      := resulted.grp_id;
  qW.ParamByName('isg_id').AsInteger       := resulted.sg_id;
  qW.ParamByName('isi_id').AsInteger       := resulted.si_id;
  qW.ParamByName('ifull_name').AsString    := resulted.full_name;
  qW.ParamByName('ishort_name').AsString   := resulted.short_name;
  qW.ParamByName('itypepdv_id').AsInteger  := resulted.typepdv_id;
  qW.ParamByName('iis_dividend').AsInteger := resulted.is_dividend;
  qW.ParamByName('inetto').AsCurrency      := resulted.netto;
  qW.ParamByName('imin_rest').AsCurrency   := resulted.min_rest;
  qW.ParamByName('iis_visible').AsInteger  := resulted.is_visible;
  qW.ParamByName('iis_active').AsInteger   := resulted.is_active;
  qW.ParamByName('imaker_id').AsInteger    := resulted.maker_id;
  qW.ParamByName('itype_nomen').AsInteger  := resulted.type_nomen;
  qW.ParamByName('iis_in_discount').AsInteger := resulted.is_in_discount;
  qW.ParamByName('itermin').AsInteger      := resulted.termin;
  qW.ParamByName('isrc_client_id').AsInteger := resulted.src_client_id;
  qW.ParamByName('il0_point_id').AsInteger := resulted.l0_point_id;
  qW.ExecQuery;
  resulted.nomen_id := gen_nomen_id;
end;

procedure Tfnomen.ApplyUPD;
begin
  qW.SQL.Text := 'update t_nomens set ' +
                     ' grp_id      = :igrp_id, ' +
                     ' sg_id       = :isg_id, ' +
                     ' si_id       = :isi_id, ' +
                     ' nomen_code  = :icode, ' +
                     ' nomen_name  = :ifull_name, ' +
                     ' datex_name  = :ishort_name, ' +
                     ' typepdv_id  = :itypepdv_id, ' +
                     ' brutto      = :inetto, ' +
                     ' minkilk     = :imin_rest, ' +
                     ' is_weight   = :iis_dividend, ' +
                     ' is_visible  = :iis_visible, ' +
                     ' is_active   = :iis_active, ' +
                     ' maker_id    = :imaker_id, ' +
                     ' type_nomen  = :itype_nomen, ' +
                     ' is_in_discount = :iis_in_discount, ' +
                     ' termin      = :itermin, ' +
                     ' src_client_id = :isrc_client_id, ' +
                     ' l0_point_id = :il0_point_id ' +
                ' where nomen_id = :inomen_id ';
  qW.ParamByName('inomen_id').AsInteger    := resulted.nomen_id;
  qW.ParamByName('icode').AsString         := resulted.code;
  qW.ParamByName('igrp_id').AsInteger      := resulted.grp_id;
  qW.ParamByName('isg_id').AsInteger       := resulted.sg_id;
  qW.ParamByName('isi_id').AsInteger       := resulted.si_id;
  qW.ParamByName('ifull_name').AsString    := resulted.full_name;
  qW.ParamByName('ishort_name').AsString   := resulted.short_name;
  qW.ParamByName('itypepdv_id').AsInteger  := resulted.typepdv_id;
  qW.ParamByName('iis_dividend').AsInteger := resulted.is_dividend;
  qW.ParamByName('inetto').AsCurrency      := resulted.netto;
  qW.ParamByName('imin_rest').AsCurrency   := resulted.min_rest;
  qW.ParamByName('iis_visible').AsInteger  := resulted.is_visible;
  qW.ParamByName('iis_active').AsInteger   := resulted.is_active;
  qW.ParamByName('imaker_id').AsInteger    := resulted.maker_id;
  qW.ParamByName('itype_nomen').AsInteger  := resulted.type_nomen;
  qW.ParamByName('iis_in_discount').AsInteger:= resulted.is_in_discount;
  qW.ParamByName('itermin').AsInteger      := resulted.termin;
  qW.ParamByName('isrc_client_id').AsInteger  := resulted.src_client_id;
  qW.ParamByName('il0_point_id').AsInteger := resulted.l0_point_id;
  qW.ExecQuery;
end;

procedure Tfnomen.ApplyDefault;
begin
  if conf_price_edit then
  begin
    qW.Close;
    qW.SQL.Text := ' update t_nomens set out_price = :iout_price where nomen_id = :inomen_id';
    qW.ParamByName('iout_price').AsCurrency := resulted.out_price;
    qW.ParamByName('inomen_id').AsInteger   := resulted.nomen_id;
    qW.ExecQuery;
  end
end;

// ********Методи роботи зі штрихкодами*************
procedure Tfnomen.BarcodesInit;
var p_barcode: ^ZBarcodeDialogResulted;
    mem: TRxMemoryData;
begin
  ed_barcodes.AddColumnVirt('obarcode', 'Штрихкод', 300);
  mem := ed_barcodes.MemoryData;
  mem.Open;

  if(trR.InTransaction)then trR.Commit;
  trR.StartTransaction;
   qR.SQL.Text := 'select obarcode_id, obarcode, oout_price, obarcode_type_id, otype_name ' +
                             ' from PS_BARCODES_VIEW (:inomen_id)';
   qR.ParamByName('inomen_id').AsInteger := id.id;
   qR.ExecQuery;
   while not qR.Eof do
   begin
     mem.Append;
     ed_barcodes.KeyValue := qR.FieldByName('obarcode_id').AsString;
     ed_barcodes.MemoryData.FieldByName('obarcode').AsString :=
                          qR.FieldByName('obarcode').AsString;
     mem.Post;
     qR.Next;
   end;
  if(trR.InTransaction) then trR.Commit;
end;

// Прийняти зміни штрихкодів у БД, що були зроблені в списку
procedure Tfnomen.BarcodesApply;
var p_barcode: ^ZBarcodeDialogResulted;
    i: integer;
    mem: TRxMemoryData;
    del_id: TStringList;
begin
  mem := ed_barcodes.MemoryData;
  del_id := ed_barcodes.DeletedIdList;

  // delete barcodes
  if(trW.InTransaction)then trW.Commit;
  trW.StartTransaction;
  for i := 0 to del_id.Count - 1 do
  begin
     qW.Close;
     qW.SQL.Text := 'delete from T_NOMEN_BARS where nomen_id = :inomen_id and barcode_id = :ibarcode_id';
     qW.ParamByName('inomen_id').AsInteger := resulted.nomen_id;
     qW.ParamByName('ibarcode_id').AsInteger := StrToInt(del_id[i]);
     qW.ExecQuery;
  end;
  if(trW.InTransaction)then trW.Commit;

  if(trW.InTransaction)then trW.Commit;
  trW.StartTransaction;
  mem.First;
  while not mem.Eof do
  begin
    if ed_barcodes.KeyValue = '' then
    begin
      qW.Close;
      qW.SQL.Text := 'select obarcode_id from PS_BARCODE_INS(:ibarcode, :inomen_id, :ibarcode_type_id, :iout_price)';
      qW.ParamByName('ibarcode').AsString := mem.FieldByName('obarcode').AsString;
      qW.ParamByName('inomen_id').AsInteger := resulted.nomen_id;
      //qW.ParamByName('ibarcode_type_id').AsInteger := p_barcode^.barcode_type_id;
      //qW.ParamByName('iout_price').AsCurrency := p_barcode^.out_price;
      qW.ExecQuery;
    end;
    mem.Next;
  end;
  if(trW.InTransaction)then trW.Commit;
end;

// Очистка списку штрихкодів
procedure Tfnomen.BarcodesClear;
var p_barcode: ^ZBarcodeDialogResulted;
    i: integer;
begin

end;

procedure Tfnomen.barcodeClick(Sender: TObject);
var snd: ZToolButton;
    barcode: ZBarcodeDialogResulted;
    i: integer;
    mem: TRxMemoryData;
begin
  mem := ed_barcodes.MemoryData;
  snd := ZToolButton(Sender);
  if (snd = bt_ins_barcode) then
  begin
    barcode.barcode_id := 0;
    if BarcodeDialog(0, @barcode, prm) <= 0 then
      Exit;

    if mem.Locate('obarcode', barcode.barcode, [loCaseInsensitive]) then
      Exit;

    mem.Insert;
    mem.FieldByName('obarcode').AsString := barcode.barcode;
    mem.Post;
  end
  else if (snd = bt_del_barcode) then
  begin
    if (mem.FieldByName('obarcode').IsNull) then
      exit;

    if (MessageBox(0, PAnsiChar('Видаляти штрихкод ' + mem.FieldByName('obarcode').AsString + '?'),
                         'Увага!',  MB_YESNO) = ID_NO) then
      exit;
    ed_barcodes.DelRecordVirt;
  end
end;

// ********Методи роботи з типами ПДВ *************
procedure Tfnomen.TypePDVInit;
begin
  TypePDVClear;

  if(trR.InTransaction)then trR.Commit;
  trR.StartTransaction;
   qR.SQL.Text := 'select tp.* from T_VAT_TYPES tp';
   qR.ExecQuery;
   while not qR.Eof do
   begin
     ed_typePDV.Descriptions.Add(Format('%s (%0.02f %%)',
                       [qR.FieldByName('typepdv_name').AsString,
                       qR.FieldByName('pdv').AsCurrency * 100]));
     ed_typePDV.Values.Add(qR.FieldByName('typepdv_id').AsString);
     qR.Next;
   end;
  if(trR.InTransaction) then trR.Commit;
end;

procedure Tfnomen.TypePDVClear;
begin
  ed_typePDV.Descriptions.Clear;
  ed_typePDV.Values.Clear;
end;

procedure Tfnomen.EditsKeyPress(Sender: TObject; var Key: Char);
var currWin: TWinControl;
begin
  currWin := TWinControl(Sender);

  inherited EditsKeyPress(Sender, Key);

  if (currWin = ed_code) then
  begin
    if (Key < '0') or (Key > '9') then
      Key := #0;
  end else if (currWin = ed_full_name) then
  begin
    if (Key = #39) then
      Key := '"';
  end else if (currWin = ed_short_name) then
  begin
    if (Key = #39) then
      Key := '"';
  end else if (currWin = ed_netto) then
  begin
    if ((Key = '.') or (Key = ',')) then
      Key := ','         
    else if (Key < '0') or (Key > '9') then
      Key := #0;
  end
  else if (currWin = ed_min_rest) then
  begin
    if ((Key = '.') or (Key = ',')) then
      Key := ','
    else if (Key < '0') or (Key > '9') then
      Key := #0;
  end
end;

procedure Tfnomen.FormDestroy(Sender: TObject);
begin
  TreeRelase(tree_prm);
  BarcodesClear;
  TypePDVClear;
  MakerPopupFree(@maker_popup_prm);
  ClientPopupFree(@src_client_popup_prm);
  L0PointPopupFree(@l0_point_popup_prm);
  inherited FormDestroy(Sender);
end;

end.
