unit unomens;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, etalon_dic, dxExEdtr, dxCntner, Menus, IBCustomDataSet,
  IBUpdateSQL, IBSQL, IBDatabase, DB, IBQuery, ImgList, ExtCtrls, {uXFilter,}
  dxTL, dxDBCtrl, dxDBGrid, ComCtrls, ToolWin, {uXToolBar, uXControlBar,} tree_h,
  {veles_h,} dxEdLib, dxEditor, nomen_h, Zutils_h, StdCtrls, genstor_h, dxDBTLCl,
  dxGrClms, {ib_h, store_h,} Buttons, kernel_h, uZToolBar, uZToolButton,
  uZControlBar, uZFilter, secure_h;

type
  Tfnomens = class(Tfetalon_dic)
    ed_grp_id: TdxPopupEdit;
    mi_like: TMenuItem;
    mi_prices: TMenuItem;
    mi_pricejournal: TMenuItem;
    mi_moving: TMenuItem;
    mi_nomen_prm: TMenuItem;
    mi_pricelist: TMenuItem;
    q_dicCODE_WARES: TIntegerField;
    q_dicCODE_GROUP: TIntegerField;
    q_dicNAME_WARES: TIBStringField;
    q_dicNAME_WARES_RECEIPT: TIBStringField;
    q_dicNAME_WARES_BRAND: TIBStringField;
    q_dicBASE_UNIT: TIBStringField;
    q_dicDEFAULT_UNIT: TIBStringField;
    q_dicVAT: TIBBCDField;
    q_dicEXCISE: TIBStringField;
    q_dicIS_SELL: TSmallintField;
    q_dicIS_PURCHASE: TSmallintField;
    q_dicDEFAULT_CODE_UNIT: TIntegerField;
    q_dicBARCODES: TIBStringField;
    q_dicPRICE_DEALER: TFloatField;
    q_dicBRAND_NAME: TIBStringField;
    g_dicCODE_WARES: TdxDBGridMaskColumn;
    g_dicCODE_GROUP: TdxDBGridMaskColumn;
    g_dicNAME_WARES: TdxDBGridMaskColumn;
    g_dicNAME_WARES_RECEIPT: TdxDBGridMaskColumn;
    g_dicNAME_WARES_BRAND: TdxDBGridMaskColumn;
    g_dicBASE_UNIT: TdxDBGridMaskColumn;
    g_dicDEFAULT_UNIT: TdxDBGridMaskColumn;
    g_dicVAT: TdxDBGridCurrencyColumn;
    g_dicEXCISE: TdxDBGridMaskColumn;
    g_dicBARCODES: TdxDBGridMaskColumn;
    g_dicPRICE_DEALER: TdxDBGridMaskColumn;
    g_dicBRAND_NAME: TdxDBGridMaskColumn;
    q_detaileNAME_UNIT: TIBStringField;
    q_detaileABR_UNIT: TIBStringField;
    q_detaileCOEFFICIENT: TFMTBCDField;
    q_detaileBAR_CODE: TIBStringField;
    g_detaileNAME_UNIT: TdxDBGridMaskColumn;
    g_detaileABR_UNIT: TdxDBGridMaskColumn;
    g_detaileCOEFFICIENT: TdxDBGridColumn;
    g_detaileBAR_CODE: TdxDBGridMaskColumn;
    q_detaileCODE_UNIT: TIntegerField;
    g_dicIS_SELL: TdxDBGridCheckColumn;
    g_dicIS_PURCHASE: TdxDBGridCheckColumn;
    procedure BSlivMinusClick(Sender: TObject);
    procedure filter_dicFilterResult(Sender: TObject;
      Result: ZFilterResult);
    procedure tool_buttonClick(Sender: TObject); override;
    procedure mi_Click(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure pg_pagesChange(Sender: TObject);
    procedure gridKeyPress(Sender: TObject; var Key: Char);
    procedure g_dicCustomDrawCell(Sender: TObject; ACanvas: TCanvas;
      ARect: TRect; ANode: TdxTreeListNode; AColumn: TdxTreeListColumn;
      ASelected, AFocused, ANewItemRow: Boolean; var AText: String;
      var AColor: TColor; AFont: TFont; var AAlignment: TAlignment;
      var ADone: Boolean);
    procedure ed_countExit(Sender: TObject);
    procedure q_dicCalcFields(DataSet: TDataSet);
    procedure ed_flagChange(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
    grp_id: integer;
    tree_prm: TTreeParams;

    perm_watch_markup: boolean;

    procedure InitInfo; override;
    procedure RefreshDic; override;
    procedure RefreshDetaile; override;
  end;

function ShowPage(var a_veles_info: ZVelesInfoRec): Longint; stdcall;
procedure FreePage(a_form_ref: Longint); stdcall;

procedure ChengeBranchEv(var prm: TTreeParams);
procedure ShowHideEv(var prm: TTreeParams);

var
  dlg: Tfnomens;
implementation

uses uZClasses;
{$R *.dfm}

procedure ChengeBranchEv(var prm: TTreeParams);
begin
  dlg.ed_grp_id.Text := prm.ActiveNode.name;
  dlg.grp_id := prm.ActiveNode.id;
  dlg.RefreshDic;
end;

procedure ShowHideEv(var prm: TTreeParams);
begin
end;

function ShowPage(var a_veles_info: ZVelesInfoRec): Longint;
begin
  if not HasUserAccessEx(a_veles_info, ACCESS_TO_NOMENS) then
    Exit;

  if dlg = nil then
  begin
    dlg := Tfnomens.Create(nil);
    dlg.prm := a_veles_info;
    dlg.InitInfo;
  end;
  dlg.panel.Visible := true;

  Result:=Longint(dlg);
end;

procedure FreePage(a_form_ref: Longint);
begin
  if (dlg <> nil) then dlg.Free;
end;

procedure Tfnomens.InitInfo;
begin
  sql_refresh_document  :=
  'select' + #13#10 +
    'w.CODE_WARES,           --Х     од товару;' + #13#10 +
    'w.CODE_GROUP,' + #13#10 +
    'w.NAME_WARES,           --Х    Ќазва товару;' + #13#10 +
    'w.NAME_WARES_RECEIPT,   --Х     оротка назва товару Ц дл€ ≈  ј;' + #13#10 +
    'w.NAME_WARES_BRAND,     --Х    Ќазва в≥д постачальника;' + #13#10 +
    'f.name_for_print as BRAND_NAME, -- ¬иробник' + #13#10 +
    'pd.price_dealer,        --Х    ÷≥на реал≥зац≥њ Ц ц≥на реал≥зац≥њ дл€ поточного  магазину' + #13#10 +
    'def_ud.NAME_UNIT as DEFAULT_UNIT,       --Х    ќдиниц€ ¬им≥ру;' + #13#10 +
    'def_ud.code_unit as DEFAULT_CODE_UNIT,' + #13#10 +
    'base_ud.NAME_UNIT as BASE_UNIT,      --Х    Ѕазова од. ¬им≥ру;' + #13#10 +
    'w.vat,                  --Х    —тавка ѕƒ¬ Цзначенн€  С0%Т або С20%Т ;' + #13#10 +
    'w.EXCISE,               --Х    јкциз Ц в≥дм≥тка чи Ї товар акцизним;' + #13#10 +
    'w.is_sell,              --Х    ƒозволено на продаж Ц в≥дм≥тка про блокуванн€ товару на продаж;' + #13#10 +
    'w.is_purchase,          --Х    ƒозволена на закупка Ц в≥дм≥тка про блокуванн€ закупки;' + #13#10 +
    'cast( (select count(au.bar_code)' + #13#10 +
        'from addition_unit au' + #13#10 +
        'where au.code_wares = w.code_wares' + #13#10 +
            'and au.CHECK_FIND_BAR_CODE = ''Y''' + #13#10 +
            'and au.bar_code is not null) as varchar(10))' + #13#10 +
    'as BARCODES             --Х     -ть штрихкод≥в Ц поле, дл€ ф≥льтру товар≥в по Ў ;' + #13#10 +
    'from WARES w' + #13#10 +
    'left join unit_dimension base_ud on (base_ud.code_unit = w.code_unit)' + #13#10 +
    'left join addition_unit def_au on (w.code_wares = def_au.code_wares and def_au.default_unit = ''Y'')' + #13#10 +
    'left join unit_dimension def_ud on (def_ud.code_unit = def_au.code_unit)' + #13#10 +
    'left join price_dealer pd on (pd.code_wares = w.code_wares and pd.code_dealer = :icode_dealer)' + #13#10 +
    'left join firms f on (w.code_brand = f.code_firm)' + #13#10 +
    'where w.code_wares = (:idocument_id)';
  sql_delete_document   :=  '';//'select * from PS_NOMEN_DEL(:idocument_id)';
//  sql_close_document    := 'update t_markups set is_fixed = 1 where markup_id = :idocument_id';
//  sql_block_document    :=
//  sql_unblock_document  := 'update t_markups set is_block = 0 where markup_id = :idocument_id';
//  sql_is_fixed_document := 'select is_fixed from t_markups where markup_id = :idocument_id';
//  sql_is_block_document := 'select is_block from t_markups where markup_id = :idocument_id';
  sql_record_info       := '';//'select odescript from PS_NOMEN_INFO(:idocument_id)';
  sql_unite_records     := '';//'select * from PS_NOMEN_UNITE(:idocument_id0, :idocument_id1)';

  access_to_del             :=  ACCESS_TO_NOMEN_DEL;
  access_to_export_dic      :=  ACCESS_TO_NOMENS_EXPORT;    // ≈кспорт дов≥дника
  access_to_unite_records   :=  ACCESS_TO_NOMEN_UNITE;      //ќб'Їднувати товари
  access_to_export_detaile  := 1;

  dic_refresh_enabled := false;

  if @tree_prm.OnChengeBranch = nil then
  begin
    tree_prm.sGen := prm;
    tree_prm.PrewForma := dlg;
    tree_prm.OnChengeBranch := @ChengeBranchEv;
    tree_prm.OnShowHide := @ShowHideEv;
    tree_prm.Visible := false;
    TreeCreate(tree_prm);
    ed_grp_id.PopupControl := tree_prm.Panel;
  end;
  grp_id := 0;

  is_new_project := true;
  ins_upd_func_name := 'NomenDialog';
  ins_upd_dll_name := 'nomen.dll';
  inherited InitInfo;

 // ListClear(g_dicOSG_ID);
//  ListInit(g_dicOSG_ID, 'select sg_id as id, sg_name as name from T_SPEC_GROUPS');

end;

procedure Tfnomens.RefreshDic;
begin
//  q_dic.ParamByName('iflag').AsInteger := StrToInt(ed_flag.Text);
  if q_dic.Params.FindParam('icode_group_wares') <> nil then
    q_dic.ParamByName('icode_group_wares').AsInteger := grp_id;
//  q_dic.ParamByName('icode_dealer').AsInteger := prm.custom_data.code_dealer;
  q_dic.ParamByName('icode_dealer').AsInteger := prm.custom_data.pcode_dealer^;
  inherited RefreshDic;
end;

procedure Tfnomens.RefreshDetaile;
begin
  //q_detaile.ParamByName('icount').AsInteger := round(ed_count.Value);
  inherited;
end;

procedure Tfnomens.filter_dicFilterResult(Sender: TObject;
  Result: ZFilterResult);
begin
//  inherited filter_dicFilterResult(Sender, Result);
{  if (Sender = filter_dic) then
  begin
    q_dic.SQL.Strings[1] := ' from ps_nomens_view_v1(:iflag, :igrp_id)';
    q_dic.SQL.Strings[3] := ' ';

    if (filter_dic.GetFieldName = 'OCODE') then
      q_dic.SQL.Strings[1] := ' from PS_NOMENS_VIEW_0_V1(:iflag, :igrp_id, ' +
             #39 + ZFilterResultText(Result).GetText + '%' + #39 + ')'
    else if (filter_dic.GetFieldName = 'OBARCODES_CNT') then
      q_dic.SQL.Strings[1] := ' from PS_NOMENS_VIEW_1_V1(:iflag, :igrp_id, ' +
             #39 + ZFilterResultText(Result).GetText + #39 + ')'
    else if (filter_dic.GetFieldName = 'OFULL_NAME') then
      q_dic.SQL.Strings[1] := ' from PS_NOMENS_VIEW_2_V1(:iflag, :igrp_id, ' +
             #39 + ZFilterResultText(Result).GetText + '%' + #39 + ')'
    else
      q_dic.SQL.Strings[3] := Result.DefaultFilter;
    RefreshDic;
  end}

  if (Sender = filter_dic) and (filter_dic.GetFieldName = 'BARCODES')
    and (Trim(Result.DefaultFilter) <> '') then
  begin
    q_dic.SQL.Text :=
      'select' + #13#10 +
      'w.CODE_WARES,           --Х     од товару;' + #13#10 +
      'w.CODE_GROUP,' + #13#10 +
      'w.NAME_WARES,           --Х    Ќазва товару;' + #13#10 +
      'w.NAME_WARES_RECEIPT,   --Х     оротка назва товару Ц дл€ ≈  ј;' + #13#10 +
      'w.NAME_WARES_BRAND,     --Х    Ќазва в≥д постачальника;' + #13#10 +
      'f.name_for_print as BRAND_NAME, -- ¬иробник' + #13#10 +
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
      'left join firms f on (w.code_brand = f.code_firm)' + #13#10 +
      '' + #13#10 +
      'where (w.code_wares = '+
          '(select first(1) CODE_WARES from ADDITION_UNIT where BAR_CODE = '''+
          Trim(ZFilterResultText(Result).GetText)+''')) ';
      grp_id := 0;

    RefreshDic;
  end
  else
    inherited;
end;

procedure Tfnomens.tool_buttonClick(Sender: TObject);
begin
  ins_upd_input.id1 := IntToStr(grp_id);
  inherited tool_buttonClick(Sender);
end;

procedure Tfnomens.mi_Click(Sender: TObject);
var item: TMenuItem;
    i: integer;
    nomen_id: integer;
    inomen_id: ZFuncArgs;
    price_sql: string;
    lpNomenDialog: function (var id: ZFuncArgs; var prm: ZVelesInfoRec): integer;
    lib_handle: THandle;
    lpPrices: procedure (id_list: AnsiString; prm: ZVelesInfoRec);
    lpPricesBySQL: procedure(sql: string; prm: ZVelesInfoRec);
    lpPriceList: procedure (prm: ZVelesInfoRec);
    lpPriceJournalShow: procedure(nomen_id: integer; var prm: ZVelesInfoRec);
    lpMovingByNomen: function (nomen_id: integer; var a_veles_info: ZVelesInfoRec): Longint;
    nomen_prm_resulted: ZNomenPrmRecords;
    lpNomenPrmDialog: function (resulted: lpZNomenPrmRecords; var prm: ZVelesInfoRec): integer;
begin
  item := TMenuItem(Sender);

  if item = mi_unite then
  begin
    if (GetConfig(prm.db_handle, 400, 'store_nomen') = 'yes') then
    begin
      if tr_R.InTransaction then tr_R.Commit;
      tr_R.StartTransaction;
      try
      q_R.SQL.Text := 'select w3_nomen_id from t_nomens where nomen_id in ('+
      id_list.GenerateList + ')';
      q_R.ExecQuery;
      nomen_id := q_R.FieldByName('w3_nomen_id').AsInteger;
      while not(q_R.Eof) do
      begin
        if nomen_id <> q_R.FieldByName('w3_nomen_id').AsInteger then
        begin
          GMessageBox('¬ибран≥ товари мають р≥зн≥ коди централ≥зац≥њ. ќб''Їднувати можна лише товари з однаковим кодом централ≥зац≥њ ', 'ƒобре');
          id_list.Clear;
          RefreshDic;
          exit;
        end;
        q_R.Next;
      end;
      finally
        if tr_R.InTransaction then tr_R.Commit;
      end;
    end;
  end;
  inherited mi_Click(Sender);

  if item = mi_like then
  begin
    if IsRecordNull then
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
  else if item = mi_prices then
  //----------ƒрук ц≥нник≥в-------------------
  begin
    if IsRecordNull then
      exit;

    @lpPricesBySQL := nil;
    lib_handle := LoadLibrary('pricelist.dll');
    if lib_handle >= 32 then
    begin
      @lpPricesBySQL := GetProcAddress(lib_handle, 'PricesBySQL');
      if @lpPricesBySQL <> nil then
      begin
//        price_sql := 'select n.nomen_id as onomen_id, n.nomen_code as onomen_code, ' +
//          ' n.nomen_name as onomen_name, n.out_price as ooutprice, '+
//          ' n.is_in_discount as ois_in_discount, 1 as oprint_it from t_nomens n ';
        price_sql := 'select w.code_wares as onomen_id, w.code_wares as onomen_code, ' +
          ' w.NAME_WARES_RECEIPT as onomen_name, pd.price_dealer as ooutprice, '+
          ' 0 ois_in_discount, 1 as oprint_it, 1 as oprint_cnt from wares w '+
          ' left join price_dealer pd on (pd.code_wares = w.code_wares and pd.code_dealer = '+IntToStr(prm.custom_data.pcode_dealer^)+')';
        if id_list.GenerateSpaceList = '  ' then
          lpPricesBySQL(price_sql + ' where w.code_wares = '+q_dic.FieldByName('code_wares').AsString, prm)
        else
          lpPricesBySQL(price_sql + ' where w.code_wares in ( '+id_list.GenerateList+' )', prm);
//          lpPricesBySQL(price_sql + ' where isinliststr('''+' '+id_list.GenerateSpaceList+' '+''', n.nomen_id) = 1 ', prm);
      end;
      FreeLibrary(lib_handle);
    end;
    id_list.Clear;
    g_dic.Repaint;
  end
  else if item = mi_pricelist then
  //----------ƒрук прайс-листа-------------------
  begin
    if IsRecordNull then
      exit;

    @lpPrices := nil;
    lib_handle := LoadLibrary('pricelist.dll');
    if lib_handle >= 32 then
    begin
      @lpPriceList := GetProcAddress(lib_handle, 'PricesPrint');
      if @lpPriceList <> nil then
      begin
        lpPriceList(prm);
      end;
     // FreeLibrary(lib_handle);
    end
  end
  else if item = mi_pricejournal then
  //----------∆урнал зм≥ни ц≥н-------------------
  begin
    if IsRecordNull then
      exit;

    @lpPriceJournalShow := nil;
    lib_handle := LoadLibrary('pricelist.dll');
    if lib_handle >= 32 then
    begin
      @lpPriceJournalShow := GetProcAddress(lib_handle, 'PriceJournalShow');
      if @lpPriceJournalShow <> nil then
        lpPriceJournalShow(q_dic.FieldByName('onomen_id').AsInteger, prm);
      FreeLibrary(lib_handle);
    end
  end
  else if item = mi_moving then
  //-------–ух документ≥в по товару-----------------
  begin
    if IsRecordNull then
      exit;

    @lpMovingByNomen := nil;
    lib_handle := LoadLibrary('moving.dll');
    if lib_handle >= 32 then
    begin
      @lpMovingByNomen := GetProcAddress(lib_handle, 'MovingByNomen');
      if @lpMovingByNomen <> nil then
        lpMovingByNomen(q_dic.FieldByName('onomen_id').AsInteger, prm);
      FreeLibrary(lib_handle);
    end;
  end
  else if item = mi_nomen_prm then
  begin
    if id_list.Count < 1 then
    begin
      ShowMessage('ѕотр≥бно пом≥тити принаймн≥ один запис.');
      exit;
    end;

    @lpNomenPrmDialog := nil;
    lib_handle := LoadLibrary('nomen.dll');
    if lib_handle >= 32 then
    begin
      @lpNomenPrmDialog := GetProcAddress(lib_handle, 'NomenPrmDialog');
      if @lpNomenPrmDialog <> nil then
      begin
        nomen_prm_resulted.id_list := id_list;
        lpNomenPrmDialog(@nomen_prm_resulted, prm);
        id_list.Clear;
        RefreshDic;
      end;
      //FreeLibrary(lib_handle);
    end;
  end
end;

procedure Tfnomens.FormDestroy(Sender: TObject);
begin
  inherited FormDestroy(Sender);
  TreeRelase(tree_prm);
end;

procedure Tfnomens.pg_pagesChange(Sender: TObject);
begin
  inherited pg_pagesChange(Sender);
end;

procedure Tfnomens.gridKeyPress(Sender: TObject; var Key: Char);
begin
  inherited gridKeyPress(Sender, Key);
end;

procedure Tfnomens.g_dicCustomDrawCell(Sender: TObject; ACanvas: TCanvas;
  ARect: TRect; ANode: TdxTreeListNode; AColumn: TdxTreeListColumn;
  ASelected, AFocused, ANewItemRow: Boolean; var AText: String;
  var AColor: TColor; AFont: TFont; var AAlignment: TAlignment;
  var ADone: Boolean);

var
 value,
 valueID: Variant;
begin
{  if not ASelected then
  begin
    Value := ANode.Values[g_dicOREST.Index];
    ValueID := ANode.Values[g_dicONOMEN_ID.Index];

    if not VarIsNull(Value) then
      if Value <= 0.000 then
        AColor := 14277119;
    if Value = 0.000 then
      AColor := 13434879;
  end;}

  inherited g_dicCustomDrawCell(Sender, ACanvas, ARect, ANode, AColumn,
        ASelected, AFocused, ANewItemRow, AText, AColor, AFont,
        AAlignment, ADone);
end;

procedure Tfnomens.BSlivMinusClick(Sender: TObject);
begin
  if tr_W.InTransaction then tr_W.Commit;
  tr_W.StartTransaction;
  q_W.SQL.Text := 'execute procedure TOOLS_SLIV_MINUSOV('+
    q_dic.FieldByName('onomen_id').AsString + ')';
  q_W.ExecQuery;
  if tr_W.InTransaction then tr_W.Commit;
  tr_W.StartTransaction;
  q_W.SQL.Text := 'execute procedure TOOLS_RECALC_RST('+
    q_dic.FieldByName('onomen_id').AsString + ')';
  q_W.ExecQuery;
  if tr_W.InTransaction then tr_W.Commit;
  RefreshDetaile;
end;

procedure Tfnomens.ed_countExit(Sender: TObject);
begin
  RefreshDetaile;
end;

procedure Tfnomens.q_dicCalcFields(DataSet: TDataSet);
begin
//
end;

procedure Tfnomens.ed_flagChange(Sender: TObject);
begin
  RefreshDic;
end;

end.
