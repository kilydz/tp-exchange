unit etalon_page;
//  Name: etalon_page.pas
//  Copyright: SoftWest group.
//  Author: Михалюк Максим
//  Date: 16.02.06
//  Description: шаблон довідника (лише одна вкладка)

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, dxExEdtr, StdCtrls, Buttons, dxDBGrid, dxTL, dxDBCtrl, dxCntner,
  DB, IBCustomDataSet, IBQuery, IBDatabase, veles_h, IBHeader,
  Placemnt, ComCtrls, ToolWin, uXToolBar, ExtCtrls, uXControlBar, ImgList,
  utils_h, Zutils_h, ib_h, IBUpdateSQL, IBSQL, Menus, uXFilter;

type
  //тип функції, яка використовується для виклику діалогів додавання та
  //редагування записів (див. bt_ins та bt_upd);
  //це є стандарт для діалогів додавання/редагування записів;
  //a_document_id - id запису, який треба відредагувати; якщо треба додати запис - 0;
  //вертає id запису, який був доданий або відредагований;
  //якщо якась помилка вбо користувач натиснув Відмінити вертає < 0;
  ZDlgFunc = function(a_document_id: Integer; var a_prm: ZVelesInfoRec): Integer;

  Tfetalon_page = class(TForm)
    g_page: TdxDBGrid;
    base: TIBDatabase;
    tr_default: TIBTransaction;
    q_page: TIBQuery;
    tr_page: TIBTransaction;
    ds_page: TDataSource;
    form_storage: TFormStorage;
    img_list_tool_bar: TImageList;
    p_top_control_bar: ZControlBar;
    p_main_tool_bar: ZToolBar;
    bt_ins: TToolButton;
    bt_upd: TToolButton;
    bt_del: TToolButton;
    ToolButton4: TToolButton;
    bt_refresh: TToolButton;
    bt_fetch: TToolButton;
    upd_page: TIBUpdateSQL;
    q_R: TIBSQL;
    tr_R: TIBTransaction;
    q_W: TIBSQL;
    tr_W: TIBTransaction;
    popup_menu_page: TPopupMenu;
    mi_columns: TMenuItem;
    filter_page: ZFilter;
    procedure g_pageKeyUp(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure tool_buttonClick(Sender: TObject); virtual;
    procedure g_pageKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure FormDestroy(Sender: TObject);
    procedure mi_columnsClick(Sender: TObject);
    procedure filter_pageFilterResult(Sender: TObject;
      Result: ZFilterResult);
    procedure g_pageKeyPress(Sender: TObject; var Key: Char);
  private
    { Private declarations }
    ctrl_pushed:  Boolean;//чи натиснута клавіша Ctrl
    lpDlgFunc: ZDlgFunc;//вказівник на функцію, яка показує діалог для додавання/редагування запису
  public
    { Public declarations }
    prm: ZVelesInfoRec;//в цьому параметрі зберігається важлива інформація (див. veles_h)

    //-------------------------------------
    //Усі ці змінні заповнюються в процедурі InitInfo
    sql_refresh_document: string;//запит використовується для оновлення одного запису
                                 //(див. RefreshRecord); Важливо! Усі поля запиту повинні
                                 //відповідати полям датасета q_page;
                                 //id запису, який треба оновити задається параметром :idocument_id
    sql_delete_document:  string;
    access_to_del_document: Integer;//якщо > 0 - буде здійснюватись перевірка права видалення
    dlg_dll_name: string;//ім'я дллки, яка містить діалог для додавання/редагування запису
    dlg_func_name: string;//ім'я функції, яка показує діалог для додавання/редагування запису
    //-------------------------------------

    dic_refresh_enabled: Boolean;
    procedure InitInfo; virtual;//тут відбувається ініціалізація
    procedure RefreshPage; virtual;//оновлення всього датасета
    procedure RefreshRecord; virtual;//оновлення одного записа

    function IsRecordNull: Boolean;
  end;

implementation

{$R *.dfm}

{ Tfetalon_page }

procedure Tfetalon_page.InitInfo;
begin
    base.SetHandle(prm.db_handle);  // передача хендла БД

    if sql_delete_document = '' then bt_del.Visible := false;

    // зчитування з ini-файлів інформації про стовпці таблиці
    g_page.LoadFromIniFile(prm.root_way + WAY_INI + self.ClassName + '_page.ini');

    // оновлення головного довідника
    dic_refresh_enabled:=true;
    RefreshPage;
end;

procedure Tfetalon_page.FormDestroy(Sender: TObject);
begin
    //збереження настроєк довідників
    g_page.SaveToIniFile(prm.root_way + WAY_INI + self.ClassName + '_page.ini');
end;

procedure Tfetalon_page.RefreshPage;
var
    document_id:        Integer;
    old_cursor:         TCursor;

begin
    if not dic_refresh_enabled then Exit;
    try
        if base.Connected then
        begin
            document_id:=q_page.FieldByName(g_page.KeyField).AsInteger;
            old_cursor:=Screen.Cursor;
            try
                Screen.Cursor:=crSQLWait;
                if tr_page.InTransaction then tr_page.Commit;
                tr_page.StartTransaction;
                if q_page.Active then q_page.Close;
                if not q_page.Prepared then q_page.Prepare;
                q_page.Open;
                tr_page.CommitRetaining;
                if document_id <> 0 then
                    q_page.Locate(g_page.KeyField, document_id, []);
//                if g_page.Visible and g_page.Enabled then g_page.SetFocus;
            finally
                Screen.Cursor:=old_cursor;
            end;
        end;
    except
        on E: Exception do
        begin
            if tr_page.InTransaction then tr_page.Rollback;
            ErrorDialog(E.Message, 'Tfetalon_page.RefreshPage');
        end;
    end;
end;

procedure Tfetalon_page.RefreshRecord;
var
    i:          Integer;
    field:      string;

begin
    q_page.Edit;
    if tr_R.InTransaction then tr_R.Commit;
    tr_R.StartTransaction;
    q_R.SQL.Text:=sql_refresh_document;
    q_R.ParamByName('idocument_id').AsInteger:=
                    q_page.FieldByName(g_page.KeyField).AsInteger;
    q_R.ExecQuery;
    for i:=0 to q_R.FieldCount-1 do
    begin
        field:=q_R.Fields[i].Name;
        q_page.FieldByName(field).AsVariant:=q_R.FieldByName(field).AsVariant;
    end;
    if tr_R.InTransaction then tr_R.Commit;
    q_page.Post;
end;

function Tfetalon_page.IsRecordNull: Boolean;
begin
    Result:=q_page.FieldByName(g_page.KeyField).IsNull;
    if Result then
        GMessageBox('Не вибрано жодного запису', 'OK');
end;

procedure Tfetalon_page.g_pageKeyUp(Sender: TObject;
  var Key: Word; Shift: TShiftState);
begin
    ctrl_pushed:=false;
end;

procedure Tfetalon_page.g_pageKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
    if (ssCtrl in Shift) then ctrl_pushed:=true;

    if ctrl_pushed and (Key = Ord('E')) then
        tool_buttonClick(bt_upd);
    if ctrl_pushed and (Key = Ord('N')) then
        tool_buttonClick(bt_ins);
    if ((ctrl_pushed and (Key = Ord('D'))) or (Key = VK_DELETE)) then
        tool_buttonClick(bt_del);
//    if Key = VK_ESCAPE then ModalResult:=mrCancel;
end;

procedure Tfetalon_page.filter_pageFilterResult(Sender: TObject;
  Result: ZFilterResult);
begin
    if Sender = filter_page then
    begin
        q_page.SQL.Strings[3]:=Result.DefaultFilter;
        RefreshPage;
    end;
end;

procedure Tfetalon_page.g_pageKeyPress(Sender: TObject; var Key: Char);
begin
    if not ctrl_pushed then
    begin
        if (Sender = g_page) then filter_page.ShowFilter(Key);
    end;
end;

procedure Tfetalon_page.tool_buttonClick(Sender: TObject);
var
    button:             TToolButton;
    old_cursor:         TCursor;
    lib_handle:         THandle;
    lpDeleteRecord:     function(query: PChar; id: integer; for_upd: TIBQuery;
                                var prm: ZVelesInfoRec): Integer;
    document_id:        Integer;

begin
    button:=TToolButton(Sender);
    if (button = bt_ins)or(button = bt_upd) then
    begin
        //не вказуючи імена дллки або функції можна визначати власну процедуру
        //додвання та оновлення запису
        if (dlg_dll_name = '')or(dlg_func_name = '') then Exit;

        if button = bt_ins then
        begin
            document_id:=0;
        end
        else begin
            document_id:=q_page.FieldByName(g_page.KeyField).AsInteger;
            if IsRecordNull then Exit;
        end;

        lib_handle:=LoadLibrary(PChar(dlg_dll_name));
        if lib_handle > 32 then
        begin
            @lpDlgFunc:=GetProcAddress(lib_handle, PChar(dlg_func_name));
            if @lpDlgFunc <> nil then
            begin
                document_id:=lpDlgFunc(document_id, prm);
                if document_id > 0 then
                begin
                    if button = bt_ins then q_page.Insert else q_page.Edit;
                    q_page.FieldByName(g_page.KeyField).AsInteger:=document_id;
                    q_page.Post;
                    RefreshRecord;
                end;
            end;
            FreeLibrary(lib_handle);
        end;
    end
    else if button = bt_del then
    begin
        if access_to_del_document > 0 then
        begin
            if not HasUserAccessEx(prm, access_to_del_document) then
                Exit;
        end;
        if IsRecordNull then Exit;

        lib_handle:=LoadLibrary('zutils.dll');
        if lib_handle >= 32 then
        begin
            @lpDeleteRecord:=GetProcAddress(lib_handle, 'GDeleteRecord');
            if @lpDeleteRecord <> nil then
            begin
               lpDeleteRecord(PChar(sql_delete_document),
                   q_page.FieldByName(g_page.KeyField).AsInteger, q_page, prm);
            end;
            FreeLibrary(lib_handle);
        end;
    end
    else if button = bt_refresh then
    begin
        RefreshPage;
    end
    else if button = bt_fetch then
    begin
        old_cursor:=Screen.Cursor;
        try
            Screen.Cursor:=crSQLWait;
            g_page.ShowSummaryFooter:=bt_fetch.Down;
            if bt_fetch.Down then
            begin
                g_page.OptionsDB:=g_page.OptionsDB + [edgoLoadAllRecords];
                g_page.Filter.Active:=true;
            end
            else begin
                g_page.OptionsDB:=g_page.OptionsDB - [edgoLoadAllRecords];
                g_page.Filter.Active:=false;
            end;
        finally
            Screen.Cursor:=old_cursor;
        end;
    end;
end;//Tfetalon_page.tool_buttonClick

procedure Tfetalon_page.mi_columnsClick(Sender: TObject);
begin
    if not (Sender is TMenuItem) then Exit;
    if (Sender as TMenuItem) = mi_columns then g_page.ColumnsCustomizing;
end;

end.
