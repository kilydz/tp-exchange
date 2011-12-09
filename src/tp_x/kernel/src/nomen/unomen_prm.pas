unit unomen_prm;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, dxExEdtr, dxEdLib, dxCntner, dxEditor, StdCtrls, ExtCtrls, {ib_h,}
  ComCtrls, ImgList, IBSQL, IBDatabase, DB, nomen_h, tree_h, ib,
  kernel_h, uZMaster, secure_h, popups_h;

type
  Tfnomen_prm = class(TForm)
    master: ZMaster;
    base: TIBDatabase;
    trR: TIBTransaction;
    qR: TIBSQL;
    scStyle: TdxEditStyleController;
    ImageList1: TImageList;
    qW: TIBSQL;
    trW: TIBTransaction;
    p_pages: TPageControl;
    TabSheet1: TTabSheet;
    pStage0: TPanel;
    Label1: TLabel;
    Label8: TLabel;
    ed_tree: TdxPopupEdit;
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
    Label2: TLabel;
    ed_type_nomen: TdxImageEdit;
    ed_is_in_discount: TdxCheckEdit;
    Label15: TLabel;
    ed_termin: TdxSpinEdit;
    Label16: TLabel;
    Label13: TLabel;
    ed_src_client: TdxPopupEdit;
    Label17: TLabel;
    ed_l0_point: TdxPopupEdit;
    procedure FormDestroy(Sender: TObject);
    procedure masterMasterResult(Sender: TObject;
      MasterResult: ZMasterResult);
    procedure ed_check_hange(Sender: TObject);
    procedure FormShow(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
    prm: ZVelesInfoRec;
    resulted: lpZNomenPrmRecords;
    tree_prm: TTreeParams;

    src_client_popup_prm: ZPopupParams;
    l0_point_popup_prm: ZPopupParams;

    procedure InitInfo;

    procedure ApplyChanges;
    procedure ApplyControls;

// ********Методи роботи з одиницями ***************
    procedure SiInit;
    procedure SiClear;

// ********Методи роботи зі спец. групами **********
    procedure SGInit;
    procedure SGClear;

// ********Методи роботи з типами ПДВ ***************
    procedure TypePDVInit;
    procedure TypePDVClear;

  end;

function NomenPrmDialog(resulted: lpZNomenPrmRecords; var prm: ZVelesInfoRec): integer;

procedure ChengeBranchEv(var prm: TTreeParams);
procedure ShowHideEv(var prm: TTreeParams);

implementation

{$R *.dfm}

function NomenPrmDialog(resulted: lpZNomenPrmRecords; var prm: ZVelesInfoRec): integer;
var
  dlg: Tfnomen_prm;
  returned: integer;
begin
// Перевірка прав
  returned := 0;
  Result := -1;
  if not HasUserAccessEx(prm, ACCESS_TO_NOMEN_INS_UPD) then
      Exit;
try
// Створення та ініціалізація форми діалогу.
    dlg := Tfnomen_prm.Create(Application);

    dlg.prm := prm;
    dlg.resulted := resulted;
    dlg.InitInfo;
// Візуалізація діалогу

    dlg.ShowModal;

finally
  if dlg <> nil then dlg.Free;
end;
//    returned <= 0 - код помилки, або відмова;
//    returned > 0  - id результату;
  Result := returned;
end;

procedure ChengeBranchEv(var prm: TTreeParams);
var
  fnomen: Tfnomen_prm;
begin
  fnomen := Tfnomen_prm(prm.PrewForma);
  fnomen.resulted.grp_id := prm.ActiveNode.id;
  if prm.ActiveNode.id <= 0 then
    fnomen.ed_tree.Text := ''
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
procedure Tfnomen_prm.InitInfo;
var i: integer;
    panel: TPanel;
begin
   // Перевірка можливості редагування властивостей товару
  if (GetConfig(prm.db_handle, 400, 'store_nomen') = 'yes') then
  begin
    ed_sg.Enabled         := False;
    ed_typePDV.Enabled    := False;
    ed_netto.Enabled      := False;
    ed_si.Enabled         := False;
    ed_min_rest.Enabled   := False;
    ed_is_dividend.Enabled := False;
    ed_is_active.Enabled  := False;
  //  ed_type_nomen.Enabled := False;
    ed_is_in_discount.Enabled := False;
    ed_src_client.Enabled := False;
  end;

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

  base.SetHandle(prm.db_handle);

  //Якщо хоч один товар невидимий, або залишок != 0 то заборона на зміну видимості
  for i := 0 to resulted.id_list.Count - 1 do
  begin
    if trR.InTransaction then trR.Commit;
    trR.StartTransaction;

    qR.SQL.Text := 'select n.is_visible, r.rest from t_nomens n'+
                   '                       left join t_rests r on n.nomen_id = r.nomen_id '+
                   ' where n.nomen_id = '+
                    IntToStr(resulted.id_list.FindId(i));
    qR.ExecQuery;
    if (qR.FieldByName('is_visible').AsInteger = 0)or
       ((qR.FieldByName('rest').AsFloat < -0.001)or(qR.FieldByName('rest').AsFloat > 0.001))  then
  end;
  if trR.InTransaction then trR.Commit;

  for i:=0 to p_pages.PageCount - 1 do
  begin
    panel := TPanel(p_pages.Pages[i].Controls[0]);
    master.PageAdd(p_pages.Pages[i].Caption, panel);
  end;

  AutoSize := true;
  Position := poScreenCenter;

  resulted.grp_id       := -1;
  resulted.is_active    := -1;
  resulted.is_dividend  := -1;
  resulted.is_visible   := -1;
  resulted.min_rest     := -1;
  resulted.netto        := -1;
  resulted.sg_id        := -1;
  resulted.si_id        := -1;
  resulted.typepdv_id   := -1;
  resulted.type_nomen   := -1;
  resulted.is_in_discount:= -1;
  resulted.termin       := -1;
  resulted.src_client_id  := -1;
  resulted.l0_point_id  := -1;

  ed_min_rest.Text   := FloatToStr(resulted.min_rest);
  ed_netto.Text      := FloatToStr(resulted.netto);
  ed_sg.Text         := IntToStr(resulted.sg_id);
  ed_si.Text         := IntToStr(resulted.si_id);
  ed_typepdv.Text    := IntToStr(resulted.typepdv_id);
  ed_type_nomen.Text := IntToStr(resulted.type_nomen);
  ed_termin.Text     := FloatToStr(resulted.termin);

  l0_point_popup_prm.ed_popup := ed_l0_point;
  L0PointPopupCreate(@l0_point_popup_prm, prm);
  l0_point_popup_prm.id := resulted.l0_point_id;
  L0PointPopupRefresh(@l0_point_popup_prm);

  src_client_popup_prm.ed_popup := ed_src_client;
  ClientPopupCreate(@src_client_popup_prm, prm);
  src_client_popup_prm.id := resulted.src_client_id;
  ClientPopupRefresh(@src_client_popup_prm, 4);

  // Ініціалізація списків
  TypePDVInit;
  SGInit;
  SiInit;
end;

procedure Tfnomen_prm.ApplyChanges;
var i: integer;
begin
  // Підготовка даних
  ApplyControls;

  for i := 0 to resulted.id_list.Count - 1 do
  begin

 try
    if(trW.InTransaction)then trW.Commit;
    trW.StartTransaction;

     qW.SQL.Text := 'update t_nomens set nomen_code = nomen_code';
     if (resulted.grp_id > 0) then
       qW.SQL.Text := qW.SQL.Text + ', grp_id = :igrp_id';
     if (resulted.sg_id > -1) then
       qW.SQL.Text := qW.SQL.Text + ', sg_id = :isg_id';
     if (resulted.si_id > -1) then
       qW.SQL.Text := qW.SQL.Text + ', si_id = :isi_id';
     if (resulted.type_nomen > -1) then
       qW.SQL.Text := qW.SQL.Text + ', type_nomen = :itype_nomen';
     if (resulted.typepdv_id > -1) then
       qW.SQL.Text := qW.SQL.Text + ', typepdv_id = :itypepdv_id';
     if (resulted.is_active > -1) then
       qW.SQL.Text := qW.SQL.Text + ', is_active = :iis_active';
     if (resulted.is_dividend > -1) then
       qW.SQL.Text := qW.SQL.Text + ', is_weight = :iis_dividend';
     if (resulted.is_visible > -1) then
       qW.SQL.Text := qW.SQL.Text + ', is_visible = :iis_visible';
     if (resulted.min_rest >= 0.00) then
       qW.SQL.Text := qW.SQL.Text + ', minkilk = :imin_rest';
     if (resulted.netto >= 0.00) then
       qW.SQL.Text := qW.SQL.Text + ', brutto = :inetto';
     if (resulted.termin >= 0.00) then
       qW.SQL.Text := qW.SQL.Text + ', termin = :itermin';
     if (resulted.is_in_discount > -1) then
       qW.SQL.Text := qW.SQL.Text + ', is_in_discount = :iis_in_discount';
     if (resulted.src_client_id > -1) then
       qW.SQL.Text := qW.SQL.Text + ', src_client_id = :isrc_client_id';
     if (resulted.l0_point_id > -1) then
       qW.SQL.Text := qW.SQL.Text + ', l0_point_id = :il0_point_id';
     qW.SQL.Text := qW.SQL.Text + ' where nomen_id = :inomen_id';

     if (resulted.grp_id > 0) then
       qW.ParamByName('igrp_id').AsInteger := resulted.grp_id;
     if (resulted.sg_id > -1) then
       qW.ParamByName('isg_id').AsInteger := resulted.sg_id;
     if (resulted.si_id > -1) then
       qW.ParamByName('isi_id').AsInteger := resulted.si_id;
     if (resulted.type_nomen > -1) then
       qW.ParamByName('itype_nomen').AsInteger := resulted.type_nomen;
     if (resulted.typepdv_id > -1) then
       qW.ParamByName('itypepdv_id').AsInteger := resulted.typepdv_id;
     if (resulted.is_active > -1) then
       qW.ParamByName('iis_active').AsInteger := resulted.is_active;
     if (resulted.is_dividend > -1) then
       qW.ParamByName('iis_dividend').AsInteger := resulted.is_dividend;
     if (resulted.is_visible > -1) then
       qW.ParamByName('iis_visible').AsInteger := resulted.is_visible;
     if (resulted.min_rest >= 0.00) then
       qW.ParamByName('imin_rest').AsCurrency := resulted.min_rest;
     if (resulted.netto >= 0.00) then
       qW.ParamByName('inetto').AsCurrency := resulted.netto;
     if (resulted.termin >= 0.00) then
       qW.ParamByName('itermin').AsCurrency := resulted.termin;
     if (resulted.is_in_discount > -1) then
       qW.ParamByName('iis_in_discount').AsInteger := resulted.is_in_discount;
     if (resulted.src_client_id > -1) then
       qW.ParamByName('isrc_client_id').AsInteger := resulted.src_client_id;
     if (resulted.l0_point_id > -1) then
       qW.ParamByName('il0_point_id').AsInteger := resulted.l0_point_id;

     qW.ParamByName('inomen_id').AsInteger := resulted.id_list.FindId(i);
     qW.ExecQuery;
    if(trW.InTransaction) then trW.Commit;

 except

  on E: EIBInterbaseError do
  begin
    if trW.InTransaction then trW.Rollback;
    ShowMessage(Format('Відбувся збій: %s Повідомте розробників про помилку.', [#13 + E.Message + #13]));
  end;
 end;

  end;  // end for
end;

procedure Tfnomen_prm.ApplyControls;
begin
  resulted.min_rest      := StrToFloat(ed_min_rest.Text);
  resulted.netto         := StrToFloat(ed_netto.Text);
  resulted.termin        := StrToFloat(ed_termin.Text);
  resulted.sg_id         := StrToInt(ed_sg.Text);
  resulted.si_id         := StrToInt(ed_si.Text);
  resulted.typepdv_id    := StrToInt(ed_typepdv.Text);
  resulted.type_nomen    := StrToInt(ed_type_nomen.Text);
  resulted.src_client_id := src_client_popup_prm.id;
  resulted.l0_point_id := l0_point_popup_prm.id;
end;

// ********Методи роботи з одиницями *************
procedure Tfnomen_prm.SiInit;
begin
  SiClear;

  ed_si.Descriptions.Add('');
  ed_si.Values.Add('-1');

  if(trR.InTransaction)then trR.Commit;
  trR.StartTransaction;
   qR.SQL.Text := 'select si_id, si_name from T_SIS order by si_id';
   qR.ExecQuery;
   while not qR.Eof do
   begin
     ed_si.Descriptions.Add(qR.FieldByName('si_name').AsString);
     ed_si.Values.Add(qR.FieldByName('si_id').AsString);
     qR.Next;
   end;
  if(trR.InTransaction) then trR.Commit;
end;

procedure Tfnomen_prm.SiClear;
begin
  ed_si.Descriptions.Clear;
  ed_si.Values.Clear;
end;

// ********Методи роботи зі спец. групами **********
procedure Tfnomen_prm.SGInit;
begin
  sgClear;

  ed_sg.Descriptions.Add('');
  ed_sg.Values.Add('-1');

  if(trR.InTransaction)then trR.Commit;
  trR.StartTransaction;
   qR.SQL.Text := 'select sg.* from T_SPEC_GROUPS sg';
   qR.ExecQuery;
   while not qR.Eof do
   begin
     ed_sg.Descriptions.Add(qR.FieldByName('sg_name').AsString);
     ed_sg.Values.Add(qR.FieldByName('sg_id').AsString);
     qR.Next;
   end;
  if(trR.InTransaction) then trR.Commit;
end;

procedure Tfnomen_prm.SGClear;
begin
  ed_sg.Descriptions.Clear;
  ed_sg.Values.Clear;
end;

// ********Методи роботи з типами ПДВ *************
procedure Tfnomen_prm.TypePDVInit;
begin
  TypePDVClear;

  ed_typePDV.Descriptions.Add('');
  ed_typePDV.Values.Add('-1');

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

procedure Tfnomen_prm.TypePDVClear;
begin
  ed_typePDV.Descriptions.Clear;
  ed_typePDV.Values.Clear;
end;

procedure Tfnomen_prm.masterMasterResult(Sender: TObject;
  MasterResult: ZMasterResult);
begin
  if MasterResult = MasterResultOk then
  begin
    ModalResult := mrOk;
    ApplyChanges;
  end
  else if MasterResult = MasterResultCancel then
    ModalResult := mrCancel;
end;

procedure Tfnomen_prm.ed_check_hange(Sender: TObject);
var ch_box: TdxCheckEdit;
begin
  ch_box := TdxCheckEdit(Sender);
  if (ch_box = ed_is_dividend) then
    if (ch_box.Checked) then
      resulted.is_dividend := 1
    else
      resulted.is_dividend := 0;

  if (ch_box = ed_is_visible) then
    if (ch_box.Checked) then
      resulted.is_visible := 1
    else
      resulted.is_visible := 0;

  if (ch_box = ed_is_active) then
    if (ch_box.Checked) then
      resulted.is_active := 1
    else
      resulted.is_active := 0;

  if (ch_box = ed_is_in_discount) then
    if (ch_box.Checked) then
      resulted.is_in_discount := 1
    else
      resulted.is_in_discount := 0;
end;

procedure Tfnomen_prm.FormDestroy(Sender: TObject);
begin
  ClientPopupFree(@src_client_popup_prm);
  L0PointPopupFree(@l0_point_popup_prm);
end;

procedure Tfnomen_prm.FormShow(Sender: TObject);
begin
  master.PageIndex := 0;
end;

end.
