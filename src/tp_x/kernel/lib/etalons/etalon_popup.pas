unit etalon_popup;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ComCtrls, ToolWin, ExtCtrls, dxCntner,
  ImgList, IBSQL, Menus, IBCustomDataSet, IBUpdateSQL, DB, IBQuery,
  IBDatabase, dxExEdtr, dxTL, dxDBCtrl, dxDBGrid, dxEdLib, kernel_h,
  StdCtrls, popups_h, uZFilter, uZToolBar, uZControlBar, uZToolButton, uZbutton,
  Zutils_h;

type
  Tfetalon_popup = class(TForm)
    base: TIBDatabase;
    tr_dic: TIBTransaction;
    q_dic: TIBQuery;
    ds_dic: TDataSource;
    upd_dic: TIBUpdateSQL;
    tr_R: TIBTransaction;
    q_R: TIBSQL;
    tr_W: TIBTransaction;
    q_W: TIBSQL;
    export_dialog: TSaveDialog;
    dic_images: TImageList;
    images: TImageList;
    scStyle: TdxEditStyleController;
    panel: TPanel;
    p_top_control_bar: ZControlBar;
    p_main_tool_bar: ZToolBar;
    g_dic: TdxDBGrid;
    filter_dic: ZFilter;
    Panel1: TPanel;
    popup_menu_dic: TPopupMenu;
    mi_export: TMenuItem;
    mi_export_excel: TMenuItem;
    mi_export_html: TMenuItem;
    bt_ins: ZToolButton;
    bt_upd: ZToolButton;
    bt_refresh: ZToolButton;
    bt_fetch: ZToolButton;
    ToolButton1: TToolButton;
    bt_ok: ZButton;
    procedure tool_buttonClick(Sender: TObject);
    procedure filter_dicFilterResult(Sender: TObject;
      Result: ZFilterResult);
    procedure bt_okClick(Sender: TObject); virtual;
    procedure g_dicKeyPress(Sender: TObject; var Key: Char);
    procedure g_dicKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure FormDestroy(Sender: TObject);
    procedure mi_Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
    prm: ZVelesInfoRec;
    popup_prm: lpZPopupParams;
    
    dic_refresh_enabled: boolean;

    // тексти запросів
    // :іdocument_id - параметер, що ідентифікує документ
    sql_refresh_document:   string;   // обновлення запису
    sql_fill_popup_edit:    string;    // заповнення вікна контрола

    is_new_project: boolean;

    ins_upd_func_name:      string;       // Назва функції редагування запису в dll
    ins_upd_dll_name:       string;       // Назва dll з функцією редагування запису
    ins_upd_input:          ZFuncArgs;    // Аргумент, що передається в
                                          // процедуру редагування запису

    procedure InitInfo; virtual;
    procedure RefreshDic; virtual;
    procedure RefreshRecord;

    procedure FillPopupEdit; virtual;
    function IsRecordNull: boolean;
  end;

var
  fetalon_popup: Tfetalon_popup;

implementation

{$R *.dfm}

// Дана процедура викликається при ініціалізації.
procedure Tfetalon_popup.InitInfo;
begin
  panel.Visible := false;
  base.SetHandle(prm.db_handle);  // передача хендла БД

  // зчитування з ini-файлів інформації про стовпці таблиці
  g_dic.LoadFromIniFile(prm.root_way + 'tuning\ini\' + self.ClassName + '_dic.ini');

  popup_prm.ed_popup.PopupControl := panel;
  dic_refresh_enabled := true;
end;

// Обновлення головного довідника
procedure Tfetalon_popup.RefreshDic;
var document_id: integer;
    old_cursor: TCursor;
begin
  if dic_refresh_enabled then
  begin
    document_id := q_dic.FieldByName(g_dic.KeyField).AsInteger;
    old_cursor := Screen.Cursor;
    Screen.Cursor := crSQLWait;
    if tr_dic.InTransaction then tr_dic.Commit;
    tr_dic.StartTransaction;
     q_dic.Open;
    if tr_dic.InTransaction then tr_dic.CommitRetaining;

    // створюємо порожній запис, якщо його немає
    if not q_dic.Locate(g_dic.KeyField, VarArrayOf([integer(0)]), [loPartialKey]) then
    begin
      q_dic.Insert;
      q_dic.FieldByName(g_dic.KeyField).AsInteger := 0;
      q_dic.Post;
    end;

    // знаходимо поточний запис і додаємо
    if popup_prm.id <> 0 then
      if not q_dic.Locate(g_dic.KeyField, VarArrayOf([integer(popup_prm.id)]), [loPartialKey]) then
      begin
        q_dic.Insert;
        q_dic.FieldByName(g_dic.KeyField).AsInteger := popup_prm.id;
        q_dic.Post;
        RefreshRecord;
      end;

    if panel.Parent <> self then
      g_dic.SetFocus;
    Screen.Cursor := old_cursor;

    FillPopupEdit;
  end
end;

// Обновлення біжучого запису в головному довідеику
procedure Tfetalon_popup.RefreshRecord;
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
end;

procedure Tfetalon_popup.tool_buttonClick(Sender: TObject);
var button: ZToolButton;
    old_cursor: TCursor;
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
    bt_fetch.Down := not bt_fetch.Down; 
    old_cursor := Screen.Cursor;
    Screen.Cursor := crSQLWait;
    g_dic.ShowSummaryFooter := bt_fetch.Down;
    if bt_fetch.Down then
      g_dic.OptionsDB := g_dic.OptionsDB + [edgoLoadAllRecords]
    else
      g_dic.OptionsDB := g_dic.OptionsDB - [edgoLoadAllRecords];
    Screen.Cursor := old_cursor;
  end
end;

procedure Tfetalon_popup.filter_dicFilterResult(Sender: TObject;
  Result: ZFilterResult);
begin
  q_dic.SQL.Strings[3] := Result.DefaultFilter;
  RefreshDic;
end;

procedure Tfetalon_popup.bt_okClick(Sender: TObject);
begin
  popup_prm.id := q_dic.FieldByName(g_dic.KeyField).AsInteger;
  (panel.Parent as TdxPopupEditForm).ModalResult := mrOk;
  FillPopupEdit;
end;

procedure Tfetalon_popup.g_dicKeyPress(Sender: TObject; var Key: Char);
begin
  filter_dic.ShowFilter(Key);
end;

procedure Tfetalon_popup.g_dicKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if Key = 13 then
    bt_okClick(bt_ok);
end;

procedure Tfetalon_popup.FillPopupEdit;
begin
  if sql_fill_popup_edit = '' then
    exit;

  if tr_R.InTransaction then tr_R.Commit;
  tr_R.StartTransaction;
   q_R.SQL.Text := sql_fill_popup_edit;
   q_R.ParamByName('idocument_id').AsInteger :=
                    popup_prm.id;
   q_R.ExecQuery;
   popup_prm.ed_popup.Text := q_R.FieldByName('fill_line').AsString;
  if tr_R.InTransaction then tr_R.Commit;
end;

procedure Tfetalon_popup.FormDestroy(Sender: TObject);
begin
  // запис в ini-файлів інформації про стовпці таблиці
  g_dic.SaveToIniFile(prm.root_way + 'tuning\ini\' + self.ClassName + '_dic.ini');
end;

procedure Tfetalon_popup.mi_Click(Sender: TObject);
var item: TMenuItem;
    lib_handle: THandle;
begin
  item := TMenuItem(Sender);

// Для пунктів меню:
  // експорт в Excel
  if item = mi_export_excel then
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
    export_dialog.Filter := 'Файли MS Excel |*.html';
    export_dialog.Title := 'Експорт даних в html';
    if export_dialog.Execute then
      g_dic.SaveToHTML(export_dialog.FileName, True);
  end
end;

// Перевірка, чи існує запис
function Tfetalon_popup.IsRecordNull: boolean;
var res: boolean;
begin
  res := q_dic.FieldByName(g_dic.KeyField).IsNull;
  if res then
    GMessageBox('Потрібно встановити курсор на запис.', 'Закрити');
  IsRecordNull := res;
end;

end.
