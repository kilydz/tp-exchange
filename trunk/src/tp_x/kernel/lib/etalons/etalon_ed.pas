unit etalon_ed;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, dxExEdtr, ExtCtrls, dxDBGrid, dxTL, dxDBCtrl, dxCntner,
  ComCtrls, ToolWin, uZToolBar, uZControlBar, DB, IBCustomDataSet, IBQuery,
  IBDatabase, kernel_h, IBSQL, IBUpdateSQL, ImgList, IB, genstor_h,
  Menus, dxEditor, dxEdLib, uZClasses, nomenlist, Zutils_h, uZToolButton;

type
  Tfetalon_ed = class(TForm)
    ZControlBar2: ZControlBar;
    tool_bar: ZToolBar;
    g_dic: TdxDBGrid;
    Splitter1: TSplitter;
    p_choicer: TPanel;
    base: TIBDatabase;
    tr_dic: TIBTransaction;
    q_dic: TIBQuery;
    ds_dic: TDataSource;
    tr_R: TIBTransaction;
    q_R: TIBSQL;
    upd_dic: TIBUpdateSQL;
    tr_W: TIBTransaction;
    q_W: TIBSQL;
    images: TImageList;
    ToolButton1: TToolButton;
    export_dialog: TSaveDialog;
    popup_menu_dic: TPopupMenu;
    mi_export: TMenuItem;
    mi_export_excel: TMenuItem;
    mi_export_html: TMenuItem;
    mi_columns: TMenuItem;
    p_header: TPanel;
    m_header: TdxMemo;
    scStyle: TdxEditStyleController;
    Im_meny: TImageList;
    bt_upd: ZToolButton;
    bt_del: ZToolButton;
    bt_refresh: ZToolButton;
    bt_fetch: ZToolButton;
    bt_header: ZToolButton;
    procedure g_dicKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState); virtual;
    procedure g_dicKeyUp(Sender: TObject; var Key: Word;
      Shift: TShiftState); virtual;
    procedure bt_toolClick(Sender: TObject); virtual;
    procedure FormClose(Sender: TObject; var Action: TCloseAction); virtual;
    procedure FormShow(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure mi_Click(Sender: TObject);
    procedure FormCreate(Sender: TObject);
  private
    { Private declarations }

  public
    { Public declarations }
    nomen_list_descr: ZNomenListDescriptor;
    prm: ZVelesInfoRec;
    refresh_enabled: boolean;
    document_id: integer;           // ідентифікатор документу
    l_nomen_id: ZContainerDuplexId;  //Список nomen_id


    // тексти запросів
    // :іrecord_id - параметер, що ідентифікує запис
    sql_refresh_record:   AnsiString;   // обновлення запису
    sql_delete_record:    AnsiString;   // видалення запису

    // :іdocument_id - параметер, що ідентифікує документ
    sql_block_document:   string;   // блокування документа
    sql_unblock_document: string;   // розблокування документу
    sql_header_info:      string;   // Інформація про заголовок документа

    procedure InitInfo; virtual;    // Ініціалізація даних
    procedure RefreshDic; virtual;  // Обновлення списку
    procedure RefreshRecord;        // Обновлення запису
    function IsRecordNull: boolean;

    function FindRecordIdByNomenId(nomen_id_field: string;
                 nomen_id: integer): integer;  // пошук запису при дублюванні товару

    procedure OnAddRec(var nomen_id: integer; code_unit: integer); virtual;  // Добавлення запису
    procedure OnAddAllRec(var grp_id: integer;nl_q_dic: TIBQuery); virtual;  // Добавлення усіх записів
  end;

implementation

//uses nomenlist;

{$R *.dfm}

//------------------------------------------------------------------------------
//
//------------------------------------------------------------------------------
procedure Tfetalon_ed.InitInfo;
begin
  base.SetHandle(prm.db_handle);

  refresh_enabled := true;
  RefreshDic;

  // Ініціалізація довідника товарів
  nomen_list_descr.parent_panel := p_choicer;
  nomen_list_descr.mode := 0;
  nomen_list_descr.forma_prew := Self;
  NomenListCreate(nomen_list_descr, prm);
  Tfnomenlist(nomen_list_descr.forma).OnAddRec := OnAddRec;
  Tfnomenlist(nomen_list_descr.forma).OnAddAllRec := OnAddAllRec;

  if sql_header_info <> '' then
  begin
    bt_header.Visible := true;

    if tr_R.InTransaction then tr_R.Commit;
    tr_R.StartTransaction;
     q_R.SQL.Text := sql_header_info;
     q_R.ParamByName('idocument_id').AsInteger := document_id;
     q_R.ExecQuery;

     m_header.Clear;
     while not q_R.Eof do
     begin
       m_header.Lines.Add(q_R.FieldByName('odescript').AsString);
       q_R.Next;
     end;

    if tr_R.InTransaction then tr_R.Commit;
  end
end;

procedure Tfetalon_ed.RefreshDic;
var record_id: integer;
begin
  if refresh_enabled then
  begin
    Screen.Cursor := crSQLWait;
    record_id := q_dic.FieldByName(g_dic.KeyField).AsInteger;
    if tr_dic.InTransaction then tr_dic.Commit;
    tr_dic.StartTransaction;
     q_dic.Open;
    if tr_dic.InTransaction then tr_dic.CommitRetaining;

    q_dic.First;
    l_nomen_id.Clear;
    while not q_dic.Eof do
    begin
      l_nomen_id.Add(q_dic.FieldByName(g_dic.KeyField).AsInteger,q_dic.FieldByName('code_wares').AsInteger);
      q_dic.Next;
    end;

    if record_id <> 0 then
      q_dic.Locate(g_dic.KeyField, record_id, []);

    Screen.Cursor := crDefault;
  end
end;

procedure Tfetalon_ed.RefreshRecord;
var i: integer;
    field: string;
begin
  q_dic.Edit;
  if tr_R.InTransaction then tr_R.Commit;
  tr_R.StartTransaction;
   q_R.SQL.Text := sql_refresh_record;
   q_R.ParamByName('irecord_id').AsInteger :=
                         q_dic.FieldByName(g_dic.KeyField).AsInteger;
   q_R.ExecQuery;

   for i:=0 to q_R.FieldCount-1 do
   begin
     field := q_R.Fields[i].Name;
     q_dic.FieldByName(field).AsVariant := q_R.FieldByName(field).AsVariant;
   end;
  if tr_R.InTransaction then tr_R.Commit;
  q_dic.Post;
end;

// пошук запису при дублюванні товару та ініціювання редагування
function  Tfetalon_ed.FindRecordIdByNomenId(nomen_id_field: string; nomen_id: integer): integer;
var record_id: integer;
    choice: integer;
begin
  record_id:=l_nomen_id.FindId0ById1(nomen_id);

  if record_id <> -1 then
  begin
    choice := GMessageBox('На даний товар вже існує принаймні один запис.', 'Редагувати|Додати|Ігнорувати');
    if choice = 1 then
    begin
      q_dic.Locate(g_dic.KeyField, record_id, []);
      bt_toolClick(bt_upd);
    end
    else if choice = 2 then
      record_id := -1;
  end ;
  FindRecordIdByNomenId := record_id;
end;

// Перевірка, чи існує запис
function Tfetalon_ed.IsRecordNull: boolean;
var res: boolean;
begin
  res := q_dic.FieldByName(g_dic.KeyField).IsNull;
  if res then
    GMessageBox('Потрібно встановити курсор на запис.', 'Закрити');
  IsRecordNull := res;
end;

procedure Tfetalon_ed.g_dicKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if Key = VK_DELETE then
    bt_toolClick(bt_del)
  else if (((ssCtrl in Shift) and (Key = Ord('E'))) or (Key = 13)) then
    bt_toolClick(bt_upd);
end;

procedure Tfetalon_ed.g_dicKeyUp(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
//
end;

procedure Tfetalon_ed.bt_toolClick(Sender: TObject);
var old_cursor: TCursor;
    lpDeleteRecord: function(query: PChar; id: integer; for_upd: TIBQuery;
                                var prm: ZVelesInfoRec): integer;
    lib_handle: THandle;
    duplex: ZDuplexId;
begin
  if Sender = bt_refresh then
  begin
    RefreshDic;
  end;
  if Sender = bt_header then
  begin
    bt_header.Down := not bt_header.Down;
    p_header.Visible := bt_header.Down;
  end;
  if Sender = bt_fetch then
  begin
    bt_fetch.Down := not bt_fetch.Down;

    old_cursor := Screen.Cursor;
    Screen.Cursor := crSQLWait;
    g_dic.ShowSummaryFooter := bt_fetch.Down;
    if bt_fetch.Down then
      g_dic.OptionsDB := g_dic.OptionsDB + [edgoLoadAllRecords]
    else
      g_dic.OptionsDB := g_dic.OptionsDB - [edgoLoadAllRecords];
    Screen.Cursor := old_cursor;
  end;
  if Sender = bt_del then
  begin
    if IsRecordNull then
      exit;

    @lpDeleteRecord := nil;
    lib_handle := LoadLibrary('zutils.dll');
    if lib_handle >= 32 then
    begin
      @lpDeleteRecord := GetProcAddress(lib_handle, 'GDeleteRecord');
      if @lpDeleteRecord <> nil then
      begin
        duplex.id0:=q_dic.FieldByName(g_dic.KeyField).AsInteger;
        duplex.id1:=l_nomen_id.FindId1ById0(duplex.id0);
        if lpDeleteRecord(PChar(sql_delete_record),
                q_dic.FieldByName(g_dic.KeyField).AsInteger, q_dic, prm) >-1 then
        begin
          l_nomen_id.Delete(duplex);
        end;
      end;
      FreeLibrary(lib_handle);
    end;
  end
end;

procedure Tfetalon_ed.FormShow(Sender: TObject);
begin
  g_dic.LoadFromIniFile(prm.root_way + WAY_INI + ClassName + '.ini');
  bt_fetch.Down := false;
  g_dic.OptionsDB := g_dic.OptionsDB - [edgoLoadAllRecords];

  if sql_block_document <> '' then
    try
      if tr_W.InTransaction then tr_W.Commit;
       tr_W.StartTransaction;
       q_W.SQL.Text := sql_block_document;
       q_W.ParamByName('idocument_id').AsInteger := document_id;
       q_W.ExecQuery;
      if tr_W.InTransaction then tr_W.Commit;
    except
      on E: EIBInterbaseError do
      begin
        if tr_W.InTransaction then tr_W.Rollback;
        ShowMessage(Format('Відбувся збій: %s Повідомте розробників про помилку.', [#13 + E.Message + #13]));
      end;
    end;

  if p_choicer.Visible then
    Tfnomenlist(nomen_list_descr.forma).g_dic.SetFocus
  else
    g_dic.SetFocus;
end;

procedure Tfetalon_ed.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  if Action = caHide then
  begin
    if GMessageBox('Ви дійсно бажаєте завершити роботу з документом?', 'Так|Ні') <> 1 then
    begin
      Action := caNone;
      exit;
    end;

   if sql_unblock_document <> '' then
     try
      if tr_W.InTransaction then tr_W.Commit;
      tr_W.StartTransaction;
       q_W.SQL.Text := sql_unblock_document;
       q_W.ParamByName('idocument_id').AsInteger := document_id;
       q_W.ExecQuery;
      if tr_W.InTransaction then tr_W.Commit;
     except
        on E: EIBInterbaseError do
        begin
          if tr_W.InTransaction then tr_W.Rollback;
          ShowMessage(Format('Відбувся збій: %s Повідомте розробників про помилку.', [#13 + E.Message + #13]));
       end;
     end;

   g_dic.SaveToIniFile(prm.root_way + WAY_INI + ClassName + '.ini');
  end
end;

procedure Tfetalon_ed.OnAddRec(var nomen_id: integer; code_unit: integer);
begin
end;

procedure Tfetalon_ed.OnAddAllRec(var grp_id: integer;nl_q_dic: TIBQuery);
begin
end;

procedure Tfetalon_ed.FormDestroy(Sender: TObject);
begin
  NomenListFree(nomen_list_descr);
  l_nomen_id.Free;
end;

procedure Tfetalon_ed.mi_Click(Sender: TObject);
var item: TMenuItem;
begin
  item := TMenuItem(Sender);

// Для пунктів меню:
  // вибір колонок
  if item = mi_columns then
  begin
    g_dic.ColumnsCustomizing;
  end

  // експорт в Excel
  else if item = mi_export_excel then
  begin
    export_dialog.DefaultExt := '*.xls';
    export_dialog.Filter := 'Файли MS Excel |*.xls';
    export_dialog.Title := 'Експорт даних в Excel';
    if export_dialog.Execute then
      g_dic.SaveToXLS(export_dialog.FileName, True);
  end

  // експорт в HTML
  else if item = mi_export_html then
  begin
    export_dialog.DefaultExt := '*.html';
    export_dialog.Filter := 'Файли HTML |*.html';
    export_dialog.Title := 'Експорт даних в html';
    if export_dialog.Execute then
    begin
      g_dic.SaveToHTML(export_dialog.FileName, True);
    end;
  end
end;

procedure Tfetalon_ed.FormCreate(Sender: TObject);
begin
  l_nomen_id:=ZContainerDuplexId.Create;
end;

end.
