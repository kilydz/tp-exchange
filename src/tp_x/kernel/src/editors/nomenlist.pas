unit nomenlist;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, dxExEdtr, ComCtrls, ToolWin, uZToolBar, ExtCtrls, uZControlBar,
  dxTL, dxDBCtrl, dxDBGrid, dxCntner, ImgList, DB, IBCustomDataSet,
  IBQuery, IBDatabase, dxDBTLCl, dxGrClms, Buttons, uZFilter, 
  kernel_h, IBUpdateSQL, IBSQL, nomen_h, tree_h, secure_h, Menus, genstor_h,
  dxEditor, dxEdLib, StdCtrls, document_h, zutils_h, uZToolButton;

type
  TAddRecordEvent    = procedure (var nomen_id: integer; code_unit: integer) of object;
  TAddAllRecordEvent = procedure (var grp_id: integer; nl_q_dic: TIBQuery) of object;

  ZNomenListDescriptor = record
     parent_panel: TWinControl;
     mode: integer;

     forma: TForm;
     forma_prew: TForm;

     resulted: lpZDocumentDialogResulted;
   end;
   lpZNomenListDescriptor = ^ZNomenListDescriptor;

  Tfnomenlist = class(TForm)
    p_main: TPanel;
    Splitter2: TSplitter;
    p_tree: TPanel;
    p_nomen: TPanel;
    g_dic: TdxDBGrid;
    ZControlBar1: ZControlBar;
    ZToolBar1: ZToolBar;
    ToolButton4: TToolButton;
    ZToolBar2: ZToolBar;
    images: TImageList;
    filter: ZFilter;
    base: TIBDatabase;
    tr_dic: TIBTransaction;
    q_dic: TIBQuery;
    ds_dic: TDataSource;
    tr_R: TIBTransaction;
    q_R: TIBSQL;
    upd_dic: TIBUpdateSQL;
    popup_menu_dic: TPopupMenu;
    mi_export: TMenuItem;
    mi_export_excel: TMenuItem;
    mi_export_html: TMenuItem;
    mi_columns: TMenuItem;
    export_dialog: TSaveDialog;
    mi_like: TMenuItem;
    tr_W: TIBTransaction;
    q_W: TIBSQL;
    Im_meny: TImageList;
    p_markup: TPanel;
    is_markups: TCheckBox;
    ed_markup: TdxSpinEdit;
    ed_type_discount: TdxImageEdit;
    p_is_aut: TPanel;
    edOut: TSpeedButton;
    bt_ins: ZToolButton;
    bt_upd: ZToolButton;
    bt_del: ZToolButton;
    bt_refresh: ZToolButton;
    bt_fetch: ZToolButton;
    bt_add_rec: ZToolButton;
    bt_add_all: ZToolButton;
    q_dicCODE_WARES: TIntegerField;
    q_dicCODE_GROUP: TIntegerField;
    q_dicNAME_WARES: TIBStringField;
    q_dicNAME_WARES_RECEIPT: TIBStringField;
    q_dicNAME_WARES_BRAND: TIBStringField;
    q_dicVAT: TIBBCDField;
    q_dicEXCISE: TIBStringField;
    q_dicIS_SELL: TSmallintField;
    q_dicIS_PURCHASE: TSmallintField;
    q_dicDEFAULT_UNIT: TIBStringField;
    q_dicBASE_UNIT: TIBStringField;
    g_dicCODE_WARES: TdxDBGridMaskColumn;
    g_dicCODE_GROUP: TdxDBGridMaskColumn;
    g_dicNAME_WARES: TdxDBGridMaskColumn;
    g_dicNAME_WARES_RECEIPT: TdxDBGridMaskColumn;
    g_dicNAME_WARES_BRAND: TdxDBGridMaskColumn;
    g_dicBASE_UNIT: TdxDBGridMaskColumn;
    g_dicDEFAULT_UNIT: TdxDBGridMaskColumn;
    g_dicVAT: TdxDBGridCurrencyColumn;
    g_dicEXCISE: TdxDBGridMaskColumn;
    g_dicIS_SELL: TdxDBGridCheckColumn;
    g_dicIS_PURCHASE: TdxDBGridCheckColumn;
    q_dicDEFAULT_CODE_UNIT: TIntegerField;
    q_dicBARCODES: TIBStringField;
    g_dicBARCODES: TdxDBGridMaskColumn;
    q_dicPRICE_DEALER: TFloatField;
    g_dicPRICE_DEALER: TdxDBGridMaskColumn;
    procedure FormCreate(Sender: TObject);

    procedure tool_buttonClick(Sender: TObject);
    procedure g_dicKeyPress(Sender: TObject; var Key: Char);
    procedure filterFilterResult(Sender: TObject; Result: ZFilterResult);
    procedure g_dicKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure g_dicDblClick(Sender: TObject);
    procedure mi_Click(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure is_markupsClick(Sender: TObject);
    procedure g_dicCustomDrawCell(Sender: TObject; ACanvas: TCanvas;
      ARect: TRect; ANode: TdxTreeListNode; AColumn: TdxTreeListColumn;
      ASelected, AFocused, ANewItemRow: Boolean; var AText: string;
      var AColor: TColor; AFont: TFont; var AAlignment: TAlignment;
      var ADone: Boolean);
    procedure edOutClick(Sender: TObject);
  private
    sql_auto_dic: string;
    { Private declarations }
    AddRec: TAddRecordEvent;
    AddAll: TAddRecordEvent;
    AddAllRec: TAddAllRecordEvent;
  public
    { Public declarations }
    prm: ZVelesInfoRec;
    descr: ^ZNomenListDescriptor;

    grp_id: integer;
    refresh_enabled: boolean;
    detail_refresh_enabled: boolean;

    tree_prm: TTreeParams;

//    has_autoorder: Boolean;

    procedure InitInfo;
    procedure RefreshDic;
    procedure RefreshRecord;

    property OnAddRec: TAddRecordEvent read AddRec write AddRec;
    property OnAddAll: TAddRecordEvent read AddAll write AddAll;
    property OnAddAllRec: TAddAllRecordEvent read AddAllRec write AddAllRec;
  end;

function NomenListCreate(var descr: ZNomenListDescriptor; var prm: ZVelesInfoRec): integer;
procedure NomenListFree(var descr: ZNomenListDescriptor);

procedure ChengeBranchEv(var prm: TTreeParams);
procedure ShowHideEv(var prm: TTreeParams);

implementation
uses eddocument;

{$R *.dfm}

function NomenListCreate(var descr: ZNomenListDescriptor; var prm: ZVelesInfoRec): integer;
var
  dlg: Tfnomenlist;
  returned: integer;
begin
// ѕерев≥рка прав
  returned := 0;
 // —творенн€ та ≥н≥ц≥ал≥зац≥€ форми д≥алогу.
    dlg := Tfnomenlist.Create(Application);
    dlg.descr := @descr;
    dlg.descr.forma := dlg;
    dlg.prm := prm;
    dlg.InitInfo;

//    returned <= 0 - код помилки, або в≥дмова;
//    returned > 0  - id результату;
  NomenListCreate := returned;
end;

procedure NomenListFree(var descr: ZNomenListDescriptor);
begin
  TreeRelase((descr.forma as Tfnomenlist).tree_prm);
  if (descr.forma <> nil)then descr.forma.Free;
end;

procedure ChengeBranchEv(var prm: TTreeParams);
var
  fnomen: Tfnomenlist;
begin
  fnomen := Tfnomenlist(prm.PrewForma);
  fnomen.grp_id := prm.ActiveNode.id;

  fnomen.RefreshDic;
end;
//------------------------------------------------------------------------------

procedure ShowHideEv(var prm: TTreeParams);
begin
end;

//------------------------------------------------------------------------------
//
//------------------------------------------------------------------------------
procedure Tfnomenlist.InitInfo;
begin
  refresh_enabled := false;
  base.SetHandle(prm.db_handle);

  // зчитуванн€ з ini-файл≥в ≥нформац≥њ про стовпц≥ таблиц≥
  g_dic.LoadFromIniFile(prm.root_way + WAY_INI + self.ClassName + '_nomlist.ini');

  // ≤н≥ц≥ал≥зац≥€ дерева
  if @tree_prm.OnChengeBranch = nil then
  begin
    tree_prm.sGen := prm;
    tree_prm.PrewForma := self;
    tree_prm.OnChengeBranch := @ChengeBranchEv;
    tree_prm.OnShowHide := @ShowHideEv;
    tree_prm.Visible := true;
    TreeCreate(tree_prm);
    tree_prm.Panel.Parent := p_tree;
  end;

  p_main.Parent := descr.parent_panel;
  refresh_enabled := true;

{  if (GetConfig(prm.db_handle, 400, 'store_nomen') = 'yes') then
  begin
    bt_ins.Visible  := False;
    bt_del.Visible  := False;
    ZToolBar1.Width := ZToolBar1.Width - 46;
    mi_like.Visible := False;
  end;}

  RefreshDic;
end;

procedure Tfnomenlist.is_markupsClick(Sender: TObject);
begin
//
end;

procedure Tfnomenlist.RefreshDic;
var nomen_id: integer;
    old_cursor: TCursor;
begin
  if refresh_enabled then
  begin
    old_cursor := Screen.Cursor;
    Screen.Cursor := crSQLWait;
    detail_refresh_enabled := false;
//    // якщо Tag=0 то в≥дображаЇтьс€ весь товар, €кщо 1 то лише видимий
//       /*
//    mode = 0 - весь звичайний товар кр≥м неактивного
//    mode = 1 - лише видимий товар та продукц≥€ (активн≥сть не беретьс€ до уваги)
//    mode = 2 - лише видим≥ сировина ≥ продукц≥€ (активн≥сть не беретьс€ до уваги)
//    mode = 3 - лише видима продукц≥€ (активн≥сть не беретьс€ до уваги)
//    mode = 4 - лише продукц≥€ з калькул€ц≥€ми (≥нш≥ властивост≥ не берутьс€ до уваги)
//    mode = 5 - весь товар кр≥м неактивного
//    mode is null - вс≥ товари  (Tag = -1)
//  */
    descr.mode:=self.descr.forma_prew.Tag;
    nomen_id := q_dic.FieldByName('code_wares').AsInteger;
    if tr_dic.InTransaction then tr_dic.Commit;
    tr_dic.StartTransaction;

    if q_dic.Params.FindParam('icode_group_wares') <> nil then
      q_dic.ParamByName('icode_group_wares').AsInteger := grp_id;
    q_dic.ParamByName('icode_dealer').AsInteger := prm.custom_data.code_dealer;
{     if (descr.mode = 20) then
     begin
       q_dic.ParamByName('igrp_id').AsInteger := (self.descr.forma_prew as Tfeddocument).document_id;
     end;
     if descr.mode = -1 then
        q_dic.ParamByName('imode').IsNull
     else
        q_dic.ParamByName('imode').AsInteger := descr.mode;}
     q_dic.Open;
    if tr_dic.InTransaction then tr_dic.CommitRetaining;

    if nomen_id <> 0 then
      q_dic.Locate('code_wares', nomen_id, []);
    Screen.Cursor := old_cursor;
  end
end;

procedure Tfnomenlist.RefreshRecord;
var i: integer;
    field: string;
begin
  q_dic.Edit;
  if tr_R.InTransaction then tr_R.Commit;
  tr_R.StartTransaction;
  q_R.SQL.Text :=
  'select' + #13#10 +
    'w.CODE_WARES,           --Х     од товару;' + #13#10 +
    'w.CODE_GROUP,' + #13#10 +
    'w.NAME_WARES,           --Х    Ќазва товару;' + #13#10 +
    'w.NAME_WARES_RECEIPT,   --Х     оротка назва товару Ц дл€ ≈  ј;' + #13#10 +
    'w.NAME_WARES_BRAND,     --Х    Ќазва в≥д постачальника;' + #13#10 +
    'pd.price_dealer,        --Х    ÷≥на реал≥зац≥њ Ц ц≥на реал≥зац≥њ дл€ поточного  магазину' + #13#10 +
    'def_ud.NAME_UNIT as DEFAULT_UNIT,       --Х    ќдиниц€ ¬им≥ру;' + #13#10 +
    'def_ud.CODE_UNIT as DEFAULT_CODE_UNIT,       --Х    ќдиниц€ ¬им≥ру;' + #13#10 +
    'base_ud.NAME_UNIT as BASE_UNIT,      --Х    Ѕазова од. ¬им≥ру;' + #13#10 +
    'w.vat,                  --Х    —тавка ѕƒ¬ Цзначенн€  С0%Т або С20%Т ;' + #13#10 +
    'w.EXCISE,               --Х    јкциз Ц в≥дм≥тка чи Ї товар акцизним;' + #13#10 +
    'w.is_sell,              --Х    ƒозволено на продаж Ц в≥дм≥тка про блокуванн€ товару на продаж;' + #13#10 +
    'w.is_purchase,          --Х    ƒозволена на закупка Ц в≥дм≥тка про блокуванн€ закупки;' + #13#10 +
    'cast((select count(au.bar_code)' + #13#10 +
        'from addition_unit au' + #13#10 +
        'where au.code_wares = w.code_wares' + #13#10 +
            'and au.CHECK_FIND_BAR_CODE = ''Y''' + #13#10 +
            'and au.bar_code is not null) as varchar(10))' + #13#10 +
    'as BARCODES             --Х     -ть штрихкод≥в Ц поле, дл€ ф≥льтру товар≥в по Ў ;' + #13#10 +
    'from WARES w' + #13#10 +
    'left join unit_dimension base_ud on (base_ud.code_unit = w.code_unit)' + #13#10 +
    'left join addition_unit def_au on (w.code_wares = def_au.code_wares and def_au.default_unit = ''Y'')' + #13#10 +
    'left join unit_dimension def_ud on (def_ud.code_unit = def_au.code_unit)' + #13#10 +
    'left join price_dealer pd on (pd.code_wares = w.code_wares and pd.code_dealer = :icode_dealer)'+
    '' + #13#10 +
    'where (w.CODE_WARES = :iCODE_WARES) ';

   q_R.ParamByName('iCODE_WARES').AsInteger := q_dic.FieldByName('onomen_id').AsInteger;
   q_R.ParamByName('icode_dealer').AsInteger := prm.custom_data.code_dealer;//0;//descr.mode;
   q_R.ExecQuery;

   for i:=0 to q_R.FieldCount-1 do
   begin
     field := q_R.Fields[i].Name;
     q_dic.FieldByName(field).AsVariant  := q_R.FieldByName(field).AsVariant;
   end;
  if tr_R.InTransaction then tr_R.Commit;
  q_dic.Post;
end;

procedure Tfnomenlist.tool_buttonClick(Sender: TObject);
var button: ZToolButton;
    inomen_id: ZFuncArgs;
    onomen_id: integer;
    lpNomenDialog: function (var id: ZFuncArgs; var prm: ZVelesInfoRec): integer;
    lib_handle: THandle;
    i: integer;
    code_unit: Integer;
begin
  button := ZToolButton(Sender);
  if button = bt_ins then
  begin
    @lpNomenDialog := nil;
    lib_handle := LoadLibrary('nomen.dll');
    if lib_handle >= 32 then
    begin
      @lpNomenDialog := GetProcAddress(lib_handle, 'NomenDialog');
      if @lpNomenDialog <> nil then
      begin
        inomen_id.id := 0;
        inomen_id.id1 := IntToStr(grp_id);
        onomen_id := lpNomenDialog(inomen_id, prm);
        if onomen_id > 0 then
        begin
          q_dic.Insert;
          q_dic.FieldByName('onomen_id').AsInteger := onomen_id;
          q_dic.Post;
          RefreshRecord;
        end;
      end;
      FreeLibrary(lib_handle);
    end;
  end
  else if button = bt_upd then
  begin
    if q_dic.FieldByName('onomen_id').AsInteger <= 0 then
    begin
      ShowMessage('Ќе вибрано запису дл€ редагуванн€.');
      exit;
    end;

    @lpNomenDialog := nil;
    lib_handle := LoadLibrary('nomen.dll');
    if lib_handle >= 32 then
    begin
      @lpNomenDialog := GetProcAddress(lib_handle, 'NomenDialog');
      if @lpNomenDialog <> nil then
      begin
        inomen_id.id := q_dic.FieldByName('onomen_id').AsInteger;
        inomen_id.id1 := IntToStr(grp_id);
        onomen_id := lpNomenDialog(inomen_id, prm);
        if onomen_id > 0 then
        begin
          RefreshRecord;
        end;
      end;
      FreeLibrary(lib_handle);
    end;
  end
  else if button = bt_del then
  begin

  end
  else if button = bt_refresh then
  begin
    RefreshDic;
  end
  else if button = bt_fetch then
  begin
    bt_fetch.Down := not bt_fetch.Down;
    Screen.Cursor := crSQLWait;
    g_dic.ShowSummaryFooter := bt_fetch.Down;
    if bt_fetch.Down then
      g_dic.OptionsDB := g_dic.OptionsDB + [edgoLoadAllRecords]
    else
      g_dic.OptionsDB := g_dic.OptionsDB - [edgoLoadAllRecords];
    Screen.Cursor := crDefault;
  end
  else if button = bt_add_rec then
  //----------«акиданн€ вибраного товару-----------------------------
  begin
    if @AddRec = nil then exit;
    onomen_id := q_dic.FieldByname('code_wares').AsInteger;
    code_unit := q_dic.FieldByname('DEFAULT_CODE_UNIT').AsInteger;
    AddRec(onomen_id, code_unit);
  end
  else if button = bt_add_all then
  //----------«акиданн€ товару з вибраних груп-----------------------
  begin
    if @AddRec = nil then exit;
    if @AddAllRec = nil then exit;

    if ((grp_id <= 0)and(self.descr.forma_prew.Hint <> 'autoorder')and(self.descr.forma_prew.Tag <> 20)) then
    begin
      ShowMessage('Ќе можна вносити в документ вс≥ групи товар≥в.');
      exit;
    end;

   if ({(self.descr.forma_prew.Hint = 'autoorder')
      or} (self.descr.forma_prew.Hint = 'revision') or
       (self.descr.forma_prew.Tag = 20))
      then
   //-----«акиданн€ вибраноњ групи товар≥в в автозамовленн≥----------------
   begin
     try
        AddAllRec(grp_id, q_dic);
      except
      end;
     exit;
   end;

   try
    q_dic.First;
    i := 0;
    while (not q_dic.Eof)and(i<200) do
    begin
      onomen_id := q_dic.FieldByname('onomen_id').AsInteger;
      code_unit := q_dic.FieldByname('code_unit').AsInteger;
      try
        AddRec(onomen_id, code_unit);
      except
      end;
      q_dic.Next;
      if (self.descr.forma_prew.Hint = 'autoorder') then i := i + 1;
    end;
   finally
   end;
  end;
end;

procedure Tfnomenlist.g_dicKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if (Key = 13) then
    tool_buttonClick(bt_add_rec)
end;

procedure Tfnomenlist.g_dicCustomDrawCell(Sender: TObject; ACanvas: TCanvas;
  ARect: TRect; ANode: TdxTreeListNode; AColumn: TdxTreeListColumn; ASelected,
  AFocused, ANewItemRow: Boolean; var AText: string; var AColor: TColor;
  AFont: TFont; var AAlignment: TAlignment; var ADone: Boolean);
var
 value,
 valueID: Variant;
begin
 {try
  if not ASelected then
  begin
    Value := ANode.Values[g_dicIS_MARKUP_BLOCK.Index];
    ValueID := ANode.Values[g_dicONOMEN_ID.Index];

    if Value = 1 then
      AColor := 13434879;
  end;

 except
 end;       }
  inherited;
end;

procedure Tfnomenlist.g_dicDblClick(Sender: TObject);
begin
  tool_buttonClick(bt_add_rec);
end;

procedure Tfnomenlist.g_dicKeyPress(Sender: TObject; var Key: Char);
begin
  filter.ShowFilter(key);
end;

procedure Tfnomenlist.edOutClick(Sender: TObject);
begin
{  if edOut.Down then
  begin
    self.descr.forma_prew.Tag := 6;
    p_tree.Visible := True;
    g_dicOREST.Caption := '«алишок';
  end else
  begin
    self.descr.forma_prew.Tag := 20;
    p_tree.Visible := False;
    g_dicOREST.Caption := ' ≥льк≥сть';
  end;}
  RefreshDic;
end;

procedure Tfnomenlist.filterFilterResult(Sender: TObject;
  Result: ZFilterResult);
var
  code_wares, code_unit: Integer;
begin
  {q_dic.SQL.Strings[1] := 'from PS_NOMEN_LIST_VIEW(:igrp_id, :imode)';
  q_dic.SQL.Strings[3] := ' ';

  if (filter.GetFieldName = 'OCODE') then
    q_dic.SQL.Strings[1] := ' from PS_NOMEN_LIST_VIEW_0(:igrp_id, :imode, ' +
             #39 + ZFilterResultText(Result).GetText + '%' + #39 + ')'
  else if (filter.GetFieldName = 'OBARCODES_CNT') then
    q_dic.SQL.Strings[1] := ' from PS_NOMEN_LIST_VIEW_1(:igrp_id, :imode, ' +
             #39 + ZFilterResultText(Result).GetText + #39 + ')'
  else if (filter.GetFieldName = 'OFULL_NAME') then
    q_dic.SQL.Strings[1] := ' from PS_NOMEN_LIST_VIEW_2(:igrp_id, :imode, ' +
             #39 + ZFilterResultText(Result).GetText + '%' + #39 + ')'
  else

    q_dic.SQL.Strings[3] := Result.DefaultFilter;}

  if filter.GetFieldName = 'BARCODES' then
  begin
    if Trim(Result.DefaultFilter) = '' then
      q_dic.SQL.Text := sql_auto_dic
    else
    begin
      q_dic.SQL.Text :=
      'select' + #13#10 +
      'w.CODE_WARES,           --Х     од товару;' + #13#10 +
      'w.CODE_GROUP,' + #13#10 +
      'w.NAME_WARES,           --Х    Ќазва товару;' + #13#10 +
      'w.NAME_WARES_RECEIPT,   --Х     оротка назва товару Ц дл€ ≈  ј;' + #13#10 +
      'w.NAME_WARES_BRAND,     --Х    Ќазва в≥д постачальника;' + #13#10 +
      'pd.price_dealer,        --Х    ÷≥на реал≥зац≥њ Ц ц≥на реал≥зац≥њ дл€ поточного  магазину' + #13#10 +
      'def_ud.NAME_UNIT as DEFAULT_UNIT,       --Х    ќдиниц€ ¬им≥ру;' + #13#10 +
      'def_ud.CODE_UNIT as DEFAULT_CODE_UNIT,       --Х    ќдиниц€ ¬им≥ру;' + #13#10 +
      'base_ud.NAME_UNIT as BASE_UNIT,      --Х    Ѕазова од. ¬им≥ру;' + #13#10 +
      'w.vat,                  --Х    —тавка ѕƒ¬ Цзначенн€  С0%Т або С20%Т ;' + #13#10 +
      'w.EXCISE,               --Х    јкциз Ц в≥дм≥тка чи Ї товар акцизним;' + #13#10 +
      'w.is_sell,              --Х    ƒозволено на продаж Ц в≥дм≥тка про блокуванн€ товару на продаж;' + #13#10 +
      'w.is_purchase,          --Х    ƒозволена на закупка Ц в≥дм≥тка про блокуванн€ закупки;' + #13#10 +
      'cast((select count(au.bar_code)' + #13#10 +
          'from addition_unit au' + #13#10 +
          'where au.code_wares = w.code_wares' + #13#10 +
              'and au.CHECK_FIND_BAR_CODE = ''Y''' + #13#10 +
              'and au.bar_code is not null) as varchar(10))' + #13#10 +
      'as BARCODES             --Х     -ть штрихкод≥в Ц поле, дл€ ф≥льтру товар≥в по Ў ;' + #13#10 +
      'from WARES w' + #13#10 +
      'left join unit_dimension base_ud on (base_ud.code_unit = w.code_unit)' + #13#10 +
      'left join addition_unit def_au on (w.code_wares = def_au.code_wares and def_au.default_unit = ''Y'')' + #13#10 +
      'left join unit_dimension def_ud on (def_ud.code_unit = def_au.code_unit)' + #13#10 +
      'left join price_dealer pd on (pd.code_wares = w.code_wares and pd.code_dealer = :icode_dealer)'+
      '' + #13#10 +
      'where (w.code_wares = '+
          '(select first (1) CODE_WARES from ADDITION_UNIT where BAR_CODE = '''+
          Trim(ZFilterResultText(Result).GetText)+''')) ';
      grp_id := 0;
    end;
  end
  else
  begin
    if Trim(Result.DefaultFilter) = '' then
      q_dic.SQL.Text := sql_auto_dic
    else
      q_dic.SQL.Text := 'select * from ('+sql_auto_dic+') '+Result.DefaultFilter;
  end;

  RefreshDic;
  if (filter.GetFieldName = 'BARCODES') and (q_dic.RecordCount = 1) and (@AddRec <> nil) then
  begin
    code_wares := q_dic.FieldByName('code_wares').AsInteger;
    code_unit := q_dic.FieldByName('default_code_unit').AsInteger;
    AddRec(code_wares, code_unit);
  end;
end;

procedure Tfnomenlist.mi_Click(Sender: TObject);
var item: TMenuItem;
    nomen_id: integer;
    inomen_id: ZFuncArgs;
    lpNomenDialog: function (var id: ZFuncArgs; var prm: ZVelesInfoRec): integer;
    lib_handle: THandle;
begin
  item := TMenuItem(Sender);

// ƒл€ пункт≥в меню:
  if item = mi_like then
  begin
    if q_dic.FieldByName('onomen_id').IsNull then
      exit;

    if GMessageBox('¬и справд≥ бажаЇте створити под≥бну картку?', 'Ќ≥|“ак') <> 2 then
      exit;

    if tr_W.InTransaction then tr_W.Commit;
    tr_W.StartTransaction;
     q_W.SQL.Text := 'select onomen_id from PS_NOMEN_LIKE_INS(:inomen_id)';
     q_W.ParamByName('inomen_id').AsInteger := q_dic.FieldByName('onomen_id').AsInteger;
     q_W.ExecQuery;
     nomen_id := q_W.FieldByName('onomen_id').AsInteger;
    if tr_W.InTransaction then tr_W.Commit;

    q_dic.Insert;
    q_dic.FieldByName('onomen_id').AsInteger := nomen_id;
    q_dic.Post;

    @lpNomenDialog := nil;
    lib_handle := LoadLibrary('nomen.dll');
    if lib_handle >= 32 then
    begin
      @lpNomenDialog := GetProcAddress(lib_handle, 'NomenDialog');
      if @lpNomenDialog <> nil then
      begin
        inomen_id.id := nomen_id;
        inomen_id.id1 := IntToStr(grp_id);
        if lpNomenDialog(inomen_id, prm) > 0 then
          RefreshRecord;
      end;
      FreeLibrary(lib_handle);
    end;
  end

  // виб≥р колонок
  else if item = mi_columns then
  begin
    g_dic.ColumnsCustomizing;
  end

  // експорт в Excel
  else if item = mi_export_excel then
  begin
    export_dialog.DefaultExt := '*.xls';
    export_dialog.Filter := '‘айли MS Excel |*.xls';
    export_dialog.Title := '≈кспорт даних в Excel';
    if export_dialog.Execute then
      g_dic.SaveToXLS(export_dialog.FileName, True);
  end

  // експорт в HTML
  else if item = mi_export_html then
  begin
    export_dialog.DefaultExt := '*.html';
    export_dialog.Filter := '‘айли MS Excel |*.html';
    export_dialog.Title := '≈кспорт даних в html';
    if export_dialog.Execute then
    begin
      g_dic.SaveToHTML(export_dialog.FileName, True);
    end;
  end
end;

procedure Tfnomenlist.FormCreate(Sender: TObject);
begin
  sql_auto_dic := q_dic.SQL.Text;
end;

procedure Tfnomenlist.FormDestroy(Sender: TObject);
begin
  // «береженн€ настроЇк дов≥дник≥в
  g_dic.SaveToIniFile(prm.root_way + WAY_INI + self.ClassName + '_nomlist.ini');
  if True then
  
end;

end.
