unit etalon_dic;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, uZHandBook, ExtCtrls, ComCtrls, ToolWin, dxExEdtr, dxCntner,
  dxTL, dxDBCtrl, dxDBGrid, StdCtrls,
  kernel_h, ImgList, DB, IBCustomDataSet, IBQuery,
  IBDatabase, Grids, dxDBTLCl, dxGrClms, dxEditor, dxEdLib,
  RXCtrls, IBSQL, IBUpdateSQL, Menus, IB,
  HTMLLite, uZClasses, secure_h, Zutils_h, uZFilter, uZControlBar, uZToolBar,
  uZToolButton, shellapi;

//const
//    UM_REFRESH_DIC = WM_USER + 1;

type

  Tfetalon_dic = class(TForm)
    panel: TPanel;

    images: TImageList;
    base: TIBDatabase;

    tr_dic: TIBTransaction;
    q_dic: TIBQuery;
    ds_dic: TDataSource;
    upd_dic: TIBUpdateSQL;
    dic_images: TImageList;
    tr_detaile: TIBTransaction;
    q_detaile: TIBQuery;
    ds_detaile: TDataSource;

    q_R: TIBSQL;
    tr_R: TIBTransaction;
    q_W: TIBSQL;
    tr_W: TIBTransaction;
    popup_menu_dic: TPopupMenu;

    scStyle: TdxEditStyleController;

    N1: TMenuItem;
    N2: TMenuItem;

    export_dialog: TSaveDialog;
    ImageList1: TImageList;

    mi_fix: TMenuItem;
    mi_columns: TMenuItem;
    mi_unblock: TMenuItem;
    mi_select: TMenuItem;
    mi_select_clear: TMenuItem;
    mi_select_all: TMenuItem;
    mi_select_items: TMenuItem;
    mi_select_filter: TMenuItem;
    mi_export_excel: TMenuItem;
    mi_unite: TMenuItem;
    p_dic: TPanel;
    g_dic: TdxDBGrid;
    s_v_splitter: TSplitter;
    p_detaile: TPanel;
    s_h_splitter: TSplitter;
    g_detaile: TdxDBGrid;
    filter_dic: ZFilter;
    filter_detile: ZFilter;
    Panel1: TPanel;
    bt_ins: ZToolButton;
    bt_upd: ZToolButton;
    bt_del: ZToolButton;
    bt_refresh: ZToolButton;
    bt_fetch: ZToolButton;
    bt_help: ZToolButton;
    separator_1: ZToolButton;
    p_description: TPanel;
    ed_description: TdxMemo;
    p_top_control_bar: ZControlBar;
    p_main_tool_bar: ZToolBar;
    ToolBar1: TToolBar;
    tt_dic_scroll: TTimer;
    pg_pages: TPageControl;
    TabSheet2: TTabSheet;
    TabSheet1: TTabSheet;
    procedure tt_dic_scrollTimer(Sender: TObject);
    procedure p_panelsCanResize(Sender: TObject; var NewWidth,
      NewHeight: Integer; var Resize: Boolean);
    procedure s_v_splitterMoved(Sender: TObject);
    procedure gridContextPopup(Sender: TObject; MousePos: TPoint;
      var Handled: Boolean);
    procedure q_dicAfterScroll(DataSet: TDataSet);

    //Для сумісництва
    procedure pg_pagesChange(Sender: TObject);

    procedure tool_buttonClick(Sender: TObject); virtual;
    procedure gridKeyPress(Sender: TObject; var Key: Char);
    procedure filter_dicFilterResult(Sender: TObject; Result: ZFilterResult);
    procedure mi_Click(Sender: TObject);
    procedure FormDestroy(Sender: TObject); //virtual;
    procedure g_dicCustomDrawCell(Sender: TObject; ACanvas: TCanvas;
      ARect: TRect; ANode: TdxTreeListNode; AColumn: TdxTreeListColumn;
      ASelected, AFocused, ANewItemRow: Boolean; var AText: String;
      var AColor: TColor; AFont: TFont; var AAlignment: TAlignment;
      var ADone: Boolean);
    procedure g_dicKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure g_dicKeyUp(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure FormCreate(Sender: TObject);
  private
    { Private declarations }
    html_lite: ThtmlLite;
    ctrl_push: boolean;
    procedure UMRefreshDic(var aMessage: TMessage); message UM_REFRESH_DIC;
  public
    { Public declarations }
    prm: ZVelesInfoRec;

    dic_refresh_enabled: boolean;
    detail_refresh_enabled: boolean;

    detail_forced_refresh_enabled: boolean;
    description_forced_refresh_enabled: boolean;

    id_list: ZContainerId;

    context_sender: TObject;

    // тексти запросів
    // :іdocument_id - параметер, що ідентифікує документ

    // призначені для встановлення після зняття фільтрів
    // автоматично заповнюються з відповідних компонентів при створенні форми
    sql_auto_dic:           string;   // оригінальний запит без застосування фільтрації
    sql_auto_detaile:       string;   // оригінальний запит без застосування фільтрації

    //прописуються вручну
    sql_refresh_document:   string;   // обновлення запису
    sql_delete_document:    string;   // видалення запису
    sql_close_document:     string;   // фіксування документу
    sql_unclose_document:   string;   // розфіксовування документу
    sql_block_document:     string;   // блокування документа
    sql_unblock_document:   string;   // розблокування документу
    sql_is_fixed_document:  string;   // чи зафіксований документ.
                                      // Результуюче поле is_fixed = 0 або не 0;
    sql_is_block_document:  string;   // чи заблокований документ.
                                      // Результуюче поле is_block = 0 або не 0;
    sql_record_info:        string;   // Інформація про запс (використовується
                                      // При об'єднанні та трансформації записв
                                      // а також при детальному описі)
    sql_unite_records:      string;   // Об'єднання двох записів idocument_id0 i idocument_id1

    access_to_del:              integer;  // access_id на видалення
    access_to_export_dic:       integer;  // access_id на експорт даних з довідника
    access_to_export_detaile:   integer;  // access_id на експорт даних з детального перегляду
    access_to_unite_records:    integer;  // access_id на Об'єднання двох записів
    access_to_unblock:          integer;
    access_to_fix:              integer;
    access_to_unfix:            integer;

    ins_upd_func_name:      string;       // Назва функції редагування запису в dll
    ins_upd_dll_name:       string;       // Назва dll з функцією редагування запису
    ins_upd_input:          ZFuncArgs;    // Аргумент, що передається в
                                          // процедуру редагування запису
    is_new_project: boolean;              // Вмикає функції створення та редагування нового зразку

    procedure InitInfo; virtual;
    procedure RefreshDic; virtual;
    procedure RefreshDetaile; virtual;
    procedure RefreshRecord;

    function IsRecordFixed: boolean;
    function IsRecordBlocked: boolean;
    function IsRecordNull: boolean;

    procedure ListInit(ed_list: TdxDBGridImageColumn; sql_fill: string);
    procedure ListClear(ed_list: TdxDBGridImageColumn);
  end;

implementation
{$R *.dfm}

// Дана процедура викликається при ініціалізації.
procedure Tfetalon_dic.InitInfo;
var lp_panel: TPanel;
    col_num: integer;
begin
  detail_forced_refresh_enabled := false;
  description_forced_refresh_enabled := false;

  panel.Visible := false;
  base.SetHandle(prm.db_handle);  // передача хендла БД
  id_list := ZContainerId.Create;     // створення порожнього списку айдіх
  ctrl_push := false;          // true якщо натиснуто Ctrl

  // формування контекстного меню
  if (sql_delete_document = '') then
    bt_del.Visible := false;
  if sql_close_document = '' then
    mi_fix.Visible := false;
  if sql_unblock_document = '' then
    mi_unblock.Visible := false;
  if (sql_record_info = '') or (sql_unite_records = '') then
    mi_unite.Visible := false;
  if (sql_record_info = '') then
  begin
    p_description.Visible := false;
    s_v_splitter.Visible := false;
  end;
  p_detaile.Visible := (q_detaile.SQL.Text <> '');

  if ((is_new_project)and((ins_upd_func_name = '') or (ins_upd_dll_name = ''))) then
  begin
    bt_ins.Visible := false;
    bt_upd.Visible := false;
  end;

  separator_1.Visible := (bt_ins.Visible or bt_upd.Visible or bt_del.Visible);

  mi_export_excel.Visible := HasUserAccessEx(prm, access_to_export_dic, false);

  // зчитування з ini-файлів інформації про стовпці таблиці
  g_dic.LoadFromIniFile(prm.root_way + WAY_INI + self.ClassName + '_dic.ini');
  g_detaile.LoadFromIniFile(prm.root_way + WAY_INI + self.ClassName + '_detaile.ini');

  // обновлення головного довідника
  dic_refresh_enabled := true;
  RefreshDic;

  if prm.control_pointers.panel_ptr <> nil then
  begin
    lp_panel := TPanel(prm.control_pointers.panel_ptr);
    panel.Parent := TWinControl(lp_panel);
  end;

  // зміна назв полів у датасеті відповідно до назв в гріді (потрібно для OLAP)
  for col_num := 0 to g_dic.ColumnCount - 1 do
  begin
    q_dic.FieldByName(g_dic.Columns[col_num].FieldName).DisplayLabel :=
             g_dic.Columns[col_num].Caption;
  end;
end;

procedure Tfetalon_dic.pg_pagesChange(Sender: TObject);
begin
  //Процедура створена лише для сумісності
end;
// Обновлення головного довідника
procedure Tfetalon_dic.RefreshDic;
var document_id: integer;
    old_cursor: TCursor;
begin
  if dic_refresh_enabled then
  begin
    document_id := q_dic.FieldByName(g_dic.KeyField).AsInteger;
    old_cursor := Screen.Cursor;
   try
    Screen.Cursor := crSQLWait;
    detail_refresh_enabled := false;
    if tr_dic.InTransaction then tr_dic.Commit;
    tr_dic.StartTransaction;
     q_dic.Open;
    if tr_dic.InTransaction then tr_dic.CommitRetaining;

    if document_id <> 0 then
      q_dic.Locate(g_dic.KeyField, document_id, []);

    detail_refresh_enabled := true;
    RefreshDetaile;

    if Visible and (panel.Parent <> self) then
      g_dic.SetFocus;

   finally
    Screen.Cursor := old_cursor;
   end;
  end
end;

// Обновлення детального довідника
procedure Tfetalon_dic.RefreshDetaile;
begin
  if (q_dic.FieldByName(g_dic.KeyField).AsInteger = 0) then
    ed_description.Clear
  else if detail_refresh_enabled then
  begin
    if p_description.Visible and (p_description.Width <> 0) or
          description_forced_refresh_enabled then
    begin
      ed_description.Clear;

     try
      if tr_R.InTransaction then tr_R.Commit;
      tr_R.StartTransaction;
       q_R.SQL.Text := sql_record_info;
       q_R.ParamByName('idocument_id').AsInteger :=
                      q_dic.FieldByName(g_dic.KeyField).AsInteger;
       q_R.ExecQuery;
       while not q_R.Eof do
       begin
         ed_description.Lines.Add(q_R.FieldByName('odescript').AsString);
         q_R.Next;
       end;
      if tr_R.InTransaction then tr_R.Commit;
     except
        on E: EIBInterbaseError do
        begin
          if tr_W.InTransaction then tr_W.Rollback;
          ShowMessage(Format('Відбувся збій %s.', [#13 + E.Message + #13]));
        end;
     end;

     description_forced_refresh_enabled := false;
    end;

    if p_detaile.Visible and (p_detaile.Height <> 0) or
               detail_forced_refresh_enabled then
    begin
      q_detaile.Close;
      if tr_detaile.InTransaction then tr_detaile.Commit;
      tr_detaile.StartTransaction;
       q_detaile.ParamByName('idocument_id').AsInteger :=
                    q_dic.FieldByName(g_dic.KeyField).AsInteger;
       q_detaile.Open;
      if tr_detaile.InTransaction then tr_detaile.CommitRetaining;

      detail_forced_refresh_enabled := false;
    end;
  end;
end;

// Обновлення біжучого запису в головному довідеику
procedure Tfetalon_dic.RefreshRecord;
var i: integer;
    field: string;
begin
  q_dic.Edit;
  if tr_R.InTransaction then tr_R.Commit;
  tr_R.StartTransaction;
   q_R.SQL.Text := sql_refresh_document;
   q_R.ParamByName('idocument_id').AsInteger :=
                    q_dic.FieldByName(g_dic.KeyField).AsInteger;
   q_R.ExecQuery;

   for i:=0 to q_R.FieldCount-1 do
   begin
     field := q_R.Fields[i].Name;
     q_dic.FieldByName(field).AsVariant  := q_R.FieldByName(field).AsVariant;
   end;
  if tr_R.InTransaction then tr_R.Commit;

  q_dic.Post;

  RefreshDetaile;
end;

procedure Tfetalon_dic.s_v_splitterMoved(Sender: TObject);
begin

end;

// Перевірка, чи фіксований даний запис
function Tfetalon_dic.IsRecordFixed: boolean;
var res: smallint;
begin
  res := 0;
  if sql_is_fixed_document <> '' then
  begin
    if tr_R.InTransaction then tr_R.Commit;
    tr_R.StartTransaction;
     q_R.SQL.Text := sql_is_fixed_document;
     q_R.ParamByName('idocument_id').AsInteger :=
                    q_dic.FieldByName(g_dic.KeyField).AsInteger;
     q_R.ExecQuery;
     res := q_R.FieldByName('is_fixed').AsInteger;
    if tr_R.InTransaction then tr_R.Commit;

    if (res <> 0) then
      ShowMessage('Не можна вносити зміни в зафіксований документ.');
  end;

  IsRecordFixed := (res <> 0);
end;

// Перевірка, чи заблокований даний запис
function Tfetalon_dic.IsRecordBlocked: boolean;
var res: smallint;
begin
  res := 0;
  if sql_is_block_document <> '' then
  begin
    if tr_R.InTransaction then tr_R.Commit;
    tr_R.StartTransaction;
     q_R.SQL.Text := sql_is_block_document;
     q_R.ParamByName('idocument_id').AsInteger :=
                      q_dic.FieldByName(g_dic.KeyField).AsInteger;
     q_R.ExecQuery;
     res := q_R.FieldByName('is_block').AsShort;
    if tr_R.InTransaction then tr_R.Commit;

    if (res <> 0) then
      ShowMessage('Документ заблоковано. Можливо із ним працює інший користувач.');
  end;

  IsRecordBlocked := (res <> 0);
end;

// Перевірка, чи існує запис
function Tfetalon_dic.IsRecordNull: boolean;
var res: boolean;
begin
  res := q_dic.FieldByName(g_dic.KeyField).IsNull;
  if res then
    GMessageBox('Потрібно встановити курсор на запис.', 'Закрити');
  IsRecordNull := res;
end;

// викликається при натисненні кнопок на тулбарі
procedure Tfetalon_dic.tool_buttonClick(Sender: TObject);
var button: ZToolButton;
    old_cursor: TCursor;
    lpDeleteRecord: function(query: PChar; id: integer; for_upd: TIBQuery;
                                var prm: ZVelesInfoRec): integer;
    lib_handle: THandle;
    lpInsUpdDialod: ZRecordDialogFunc;
    ins_upd_result: integer;
begin
  button := ZToolButton(Sender);

  // Створення запису
  if (is_new_project) then begin   
  if button = bt_ins then
  begin
    @lpInsUpdDialod := nil;
    lib_handle := LoadLibrary(PAnsiChar(ins_upd_dll_name));
    if lib_handle >= 32 then
    begin
      @lpInsUpdDialod := GetProcAddress(lib_handle, PAnsiChar(ins_upd_func_name));
      if @lpInsUpdDialod <> nil then
      begin
        ins_upd_input.id := 0;
        ins_upd_result := lpInsUpdDialod(ins_upd_input, prm);
        if ins_upd_result > 0 then
        begin
          q_dic.Insert;
          q_dic.FieldByName(g_dic.KeyField).AsInteger := ins_upd_result;
          q_dic.Post;
          RefreshRecord;
        end;
      end;
      FreeLibrary(lib_handle);
    end;
  end
  // Редагування запису
  else if button = bt_upd then
  begin
    if IsRecordNull then
      exit;

    @lpInsUpdDialod := nil;
    lib_handle := LoadLibrary(PAnsiChar(ins_upd_dll_name));
    if lib_handle >= 32 then
    begin
      @lpInsUpdDialod := GetProcAddress(lib_handle, PAnsiChar(ins_upd_func_name));
      if @lpInsUpdDialod <> nil then
      begin
        ins_upd_input.id := q_dic.FieldByName(g_dic.KeyField).AsInteger;
        ins_upd_result := lpInsUpdDialod(ins_upd_input, prm);
        if ins_upd_result > 0 then
        begin
          RefreshRecord;
        end;
      end;
      FreeLibrary(lib_handle);
    end;
  end
  end;
  // обновлення довідника
  if button = bt_refresh then
  begin
    RefreshDic;
  end
  // кешування даних
  else if button = bt_fetch then
  begin
    button.Down := not button.Down;

    old_cursor := Screen.Cursor;
    try
    Screen.Cursor := crSQLWait;
    g_dic.ShowSummaryFooter := bt_fetch.Down;
    if bt_fetch.Down then
    begin
      g_dic.OptionsDB := g_dic.OptionsDB + [edgoLoadAllRecords];
      g_dic.Filter.Active := true;
    end
    else
    begin
      g_dic.OptionsDB := g_dic.OptionsDB - [edgoLoadAllRecords];
      g_dic.Filter.Active := false;
    end;
    finally
    Screen.Cursor := old_cursor;
    end;
  end
  // видалення елемента
  else if button = bt_del then
  begin
    if IsRecordNull then
      exit;

    if not HasUserAccessEx(prm, access_to_del) then
      Exit;

    @lpDeleteRecord := nil;
    lib_handle := LoadLibrary('zutils.dll');
    if lib_handle >= 32 then
    begin
      @lpDeleteRecord := GetProcAddress(lib_handle, 'GDeleteRecord');
      if @lpDeleteRecord <> nil then
      begin
        lpDeleteRecord(PChar(sql_delete_document),
                        q_dic.FieldByName(g_dic.KeyField).AsInteger, q_dic, prm);
      end;
      FreeLibrary(lib_handle);
    end;
  end
  else if button = bt_help then
  begin
    ShellExecute(Handle, PAnsiChar('open'),
             'hh.exe', PAnsiChar(prm.root_way + WAY_BIN + 'help.chm::/' + self.ClassName + '.html'),
             nil, SW_SHOWNORMAL)
  end;
end;


procedure Tfetalon_dic.g_dicKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if (ssCtrl in Shift) then
    ctrl_push := true;

  if ((ctrl_push and (Key = Ord('E'))) or (Key = 13)) then
    tool_buttonClick(bt_upd);
  if (ctrl_push and (Key = Ord('N'))) then
    tool_buttonClick(bt_ins);
  if ((ctrl_push and (Key = Ord('D'))) or (Key = VK_DELETE)) then
    tool_buttonClick(bt_del);
  if ((ctrl_push and (Key = Ord('R')))) then
    tool_buttonClick(bt_refresh);
  if ((ctrl_push and (Key = Ord('W')))) then
    tool_buttonClick(bt_fetch);

 end;

procedure Tfetalon_dic.gridKeyPress(Sender: TObject; var Key: Char);
begin
  if not ctrl_push then
    if (Sender = g_dic) then
      filter_dic.ShowFilter(Key)
    else if (Sender = g_detaile) then
      filter_detile.ShowFilter(Key);
end;

procedure Tfetalon_dic.g_dicKeyUp(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  ctrl_push := false;
end;

procedure Tfetalon_dic.filter_dicFilterResult(Sender: TObject;
  Result: ZFilterResult);
begin
  if (Sender = filter_dic) then
  begin
    //q_dic.SQL.Strings[3] := Result.DefaultFilter;
    if Trim(Result.DefaultFilter) = '' then
      q_dic.SQL.Text := sql_auto_dic
    else
      q_dic.SQL.Text := 'select * from ('+ sql_auto_dic+') '+Result.DefaultFilter;
    RefreshDic;
  end
  else if (Sender = filter_detile) then
  begin
    //q_detaile.SQL.Strings[3] := Result.DefaultFilter;
    if Trim(Result.DefaultFilter) = '' then
      q_detaile.SQL.Text := sql_auto_detaile
    else
      q_detaile.SQL.Text := 'select * from ('+ sql_auto_detaile+') '+Result.DefaultFilter;
    RefreshDetaile;
  end
end;

procedure Tfetalon_dic.mi_Click(Sender: TObject);
var item: TMenuItem;
    unite_prm: ZUniteRecords;
    lib_handle: THandle;
    lpUniteRecords: function(unite_prm: lpZUniteRecords; var a_veles_info: ZVelesInfoRec): integer;
begin
  item := TMenuItem(Sender);

// Для пунктів меню:
  // фіксування документу
  if item = mi_fix then
  begin
    if IsRecordNull then
      exit;

    if GMessageBox('Ви дійсно бажаєте закрити документ?', 'Так|Ні') <> 1 then
     exit;

   try
    if tr_W.InTransaction then tr_W.Commit;
    tr_W.StartTransaction;
     q_W.SQL.Text := sql_close_document;
     q_W.ParamByName('idocument_id').AsInteger :=
                      q_dic.FieldByName(g_dic.KeyField).AsInteger;
     q_W.ExecQuery;
    if tr_W.InTransaction then tr_W.Commit;
   except
      on E: EIBInterbaseError do
      begin
        if tr_W.InTransaction then tr_W.Rollback;
        ShowMessage(Format('Відбувся збій при закритті документа %s.', [#13 + E.Message + #13]));
      end;
   end;

    RefreshRecord;
  end

  // розблокування документу
  else if item = mi_unblock then
  begin
    if IsRecordNull then
      exit;

    if not HasUserAccessEx(prm, access_to_unblock) then
      Exit;

    if GMessageBox('Ви дійсно бажаєте розблокувати документ?' + #13 +
          'Можливо з ним працює інший користувач.', 'Так|Ні') <> 1 then
      exit;
   try
    if tr_W.InTransaction then tr_W.Commit;
    tr_W.StartTransaction;
     q_W.SQL.Text := sql_unblock_document;
     q_W.ParamByName('idocument_id').AsInteger :=
                      q_dic.FieldByName(g_dic.KeyField).AsInteger;
     q_W.ExecQuery;
    if tr_W.InTransaction then tr_W.Commit;

   except
      on E: EIBInterbaseError do
      begin
        if tr_W.InTransaction then tr_W.Rollback;
        ShowMessage(Format('Відбувся збій при розблокуванні документа %s.', [#13 + E.Message + #13]));
      end;
   end;
  end

  // вибір колонок
  else if item = mi_columns then
  begin
    if context_sender = g_dic then
      g_dic.ColumnsCustomizing
    else if context_sender = g_detaile then
      g_detaile.ColumnsCustomizing;
  end

  // помітити запис
  else if item = mi_select then
  begin
    if IsRecordNull then
      exit;

    if id_list.FindIdx(q_dic.FieldByName(g_dic.KeyField).AsInteger) < 0 then
      id_list.Add(q_dic.FieldByName(g_dic.KeyField).AsInteger)
    else
      id_list.Delete(q_dic.FieldByName(g_dic.KeyField).AsInteger);
    g_dic.GotoNext(true);
//    g_dic.Repaint;
  end

  // помітити усі записи
  else if item = mi_select_all then
  begin
    detail_refresh_enabled := false;
    q_dic.First;
    while not q_dic.Eof do
    begin
      if id_list.FindIdx(q_dic.FieldByName(g_dic.KeyField).AsInteger) < 0 then
        id_list.Add(q_dic.FieldByName(g_dic.KeyField).AsInteger);
      q_dic.Next;
    end;
    g_dic.Repaint;
    detail_refresh_enabled := true;
    RefreshDetaile();
  end

  // зняти помітки
  else if item = mi_select_clear then
  begin
    id_list.Clear;
    g_dic.Repaint;
  end

  // фільтр по поміткам
  else if item = mi_select_filter then
  begin
    q_dic.SQL.Strings[3] := 'where ' + g_dic.KeyField + ' in (' +
                                       id_list.GenerateList + ')';
    RefreshDic;
  end

  // експорт в Excel
  else if item = mi_export_excel then
  begin
    if ((context_sender = g_dic)and(not HasUserAccessEx(prm, access_to_export_dic)))
      or((context_sender = g_detaile)and(not HasUserAccessEx(prm, access_to_export_detaile)))
      then Exit;

    export_dialog.DefaultExt := '*.xls';
    export_dialog.Filter := 'Файли MS Excel |*.xls';
    export_dialog.Title := 'Експорт даних в Excel';
    if export_dialog.Execute then
    begin
      if context_sender = g_dic then
        g_dic.SaveToXLS(export_dialog.FileName, True)
      else if context_sender = g_detaile then
        g_detaile.SaveToXLS(export_dialog.FileName, True);
    end;
  end

  //  Об'єднати записи
  else if item = mi_unite then
  begin
    if id_list.Count < 2 then
    begin
      ShowMessage('Потрібно помітити принаймні два записи.');
      exit;
    end;

    if (not HasUserAccessEx(prm, access_to_unite_records)) then
      Exit;

    @lpUniteRecords := nil;
    lib_handle := LoadLibrary('zutils.dll');
    if lib_handle >= 32 then
    begin
      @lpUniteRecords := GetProcAddress(lib_handle, 'GUniteRecords');
      if @lpUniteRecords <> nil then
      begin
        unite_prm.id_list := id_list;
        unite_prm.sql_info := sql_record_info;
        unite_prm.sql_unite := sql_unite_records;
        lpUniteRecords(@unite_prm, prm);
        RefreshDic;
      end;
      FreeLibrary(lib_handle);
    end
  end
end;


procedure Tfetalon_dic.p_panelsCanResize(Sender: TObject; var NewWidth,
  NewHeight: Integer; var Resize: Boolean);
var panel: TPanel;
begin
  panel := TPanel(Sender);

  // Потрібно зробити оновлення детальної інформації якщо
  // таблиця відкривається рісля того, як була прихована
  if ((panel = p_description) and (panel.Width = 0) and (NewWidth <> 0)) then
    description_forced_refresh_enabled := true;
  if ((panel = p_detaile) and (panel.Height = 0) and (NewHeight <> 0))then
     detail_forced_refresh_enabled := true;
  if description_forced_refresh_enabled or detail_forced_refresh_enabled then
    RefreshDetaile;
end;

procedure Tfetalon_dic.q_dicAfterScroll(DataSet: TDataSet);
begin
  tt_dic_scroll.Enabled := false;
  tt_dic_scroll.Enabled := true;
end;

procedure Tfetalon_dic.tt_dic_scrollTimer(Sender: TObject);
begin
  RefreshDetaile;
  tt_dic_scroll.Enabled := false;
end;

procedure Tfetalon_dic.FormDestroy(Sender: TObject);
begin
  // Збереження настроєк довідників
  g_dic.SaveToIniFile(prm.root_way + WAY_INI + self.ClassName + '_dic.ini');
  g_detaile.SaveToIniFile(prm.root_way + WAY_INI + self.ClassName + '_detaile.ini');
  // Очистка списку айдіх
  id_list.Free;

  base.SetHandle(nil);
end;

procedure Tfetalon_dic.gridContextPopup(Sender: TObject; MousePos: TPoint;
  var Handled: Boolean);
begin
  context_sender := Sender;
end;

procedure Tfetalon_dic.g_dicCustomDrawCell(Sender: TObject;
  ACanvas: TCanvas; ARect: TRect; ANode: TdxTreeListNode;
  AColumn: TdxTreeListColumn; ASelected, AFocused, ANewItemRow: Boolean;
  var AText: String; var AColor: TColor; AFont: TFont;
  var AAlignment: TAlignment; var ADone: Boolean);
var id: Variant;
begin
  if not ASelected then
  begin
    id := ANode.Values[g_dic.ColumnByFieldName(g_dic.KeyField).Index];

    if not VarIsNull(id) then
      if id_list.FindIdx(id) >= 0 then
      begin
        AColor := 11579568;
        AFont.Color := clWhite;
      end;
  end;
end;

procedure Tfetalon_dic.FormCreate(Sender: TObject);
begin
  access_to_del := 0;
  access_to_export_dic := 0;
  access_to_export_detaile := 0;
  access_to_unite_records := 0;
  access_to_unblock := 0;

  sql_auto_dic      := q_dic.SQL.Text;
  sql_auto_detaile  := q_detaile.SQL.Text;
end;

procedure Tfetalon_dic.UMRefreshDic(var aMessage: TMessage);
begin
//    ShowMessage(self.ClassName + ': Tfetalon_dic.UMRefreshDic');
    RefreshDic;
end;

// Процедура заповнення випадаючого списку з запроса
procedure Tfetalon_dic.ListInit(ed_list: TdxDBGridImageColumn; sql_fill: string);
begin
  if(tr_R.InTransaction)then tr_R.Commit;
  tr_R.StartTransaction;
   q_R.SQL.Text := sql_fill;
   q_R.ExecQuery;
   while not q_R.Eof do
   begin
     ed_list.Descriptions.Add(q_R.FieldByName('name').AsString);
     ed_list.Values.Add(q_R.FieldByName('id').AsString);
     q_R.Next;
   end;
  if(tr_R.InTransaction) then tr_R.Commit;
end;

procedure Tfetalon_dic.ListClear(ed_list: TdxDBGridImageColumn);
begin
  ed_list.Descriptions.Clear;
  ed_list.Values.Clear;
end;

end.
