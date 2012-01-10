unit main;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, Menus, ExtCtrls, dxsbar, ComCtrls, ImgList, Placemnt,
  utils_h, kernel_h, DB, IBDatabase, StdCtrls, IBSQL, uplugin_h,
  RXShell, dxCntner, dxEditor, dxEdLib, Buttons, Tabs, Zutils_h, HTMLLite,
  OleCtrls, SHDocVw{, urestore}, ActiveX, WinInet, shellapi, uAlgoritm;

type
  Tfmain = class(TForm)
    p_main: TPanel;
    StatusBar: TStatusBar;
    LargeImagesForSideBar: TImageList;
    FormStorage: TFormStorage;
    base: TIBDatabase;
    tr_default: TIBTransaction;
    qr_R: TIBSQL;
    splitterMain: TSplitter;
    tray_menu: TPopupMenu;
    pmi_exit: TMenuItem;
    pmi_restore: TMenuItem;
    N1: TMenuItem;
    tab_set: TTabSet;
    MainMenu: TMainMenu;
    SideBar_: TdxSideBar;
    trR: TIBTransaction;
    qR: TIBSQL;
    trW: TIBTransaction;
    qW: TIBSQL;
    tray_icon: TTrayIcon;
    mi_exit: TMenuItem;
    miMode: TMenuItem;
    miModeSet: TMenuItem;
    procedure miModeSetClick(Sender: TObject);
    procedure tab_setChange(Sender: TObject; NewTab: Integer;
      var AllowChange: Boolean);
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure SideBar_ItemClick(Sender: TObject; Item: TdxSideBarItem);
    procedure FormShow(Sender: TObject);
    procedure pmi_exitClick(Sender: TObject);
    procedure pmi_restoreClick(Sender: TObject);
    procedure tray_iconClick(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; Z, Y: Integer);
    procedure tray_iconMouseMove(Sender: TObject; Shift: TShiftState; Z,
      Y: Integer);
    procedure tray_iconDblClick(Sender: TObject);
    procedure FormCloseQuery(Sender: TObject; var CanClose: Boolean);
    procedure mi_exitClick(Sender: TObject);
    procedure htmlLite1HotSpotClick(Sender: TObject; const SRC: string;  var Handled: Boolean);
  private
    { Private declarations }
    function AppRestore: Integer;
    procedure AppMinimize(Sender: TObject);
    procedure AppTerminate;
    procedure FreePages;
    procedure HideControlsOnMainPanel;
    procedure OnPluginMenuClick(Sender: TObject);
    procedure PageHandler(a_tag_page_id: Integer);
    procedure PluginHandler(a_tag_plugin_id: Integer);
  public
    { Public declarations }
    module_manager:   ZModuleManager;
    web_splash, remote_splash: ThtmlLite;
    splash_splitter: TSplitter;

    function ShowHTML(const HTML: string): integer;
    procedure SetAppName;

  end;

var
    fmain:            Tfmain;
    veles_info:       ZVelesInfoRec;
    xml_file_name:    string;
    plugin_manager:   ZPluginManager;
    is_tray_used:     Integer;

implementation

uses utray;

{$R *.dfm}

var
    is_tray_pass_called: Boolean = false;

procedure Tfmain.FormCreate(Sender: TObject);
var
    i,j, res:           Integer;
    bitmap:             TBitmap;
    bitmap_index:       Integer;
    menu_item:          TMenuItem;
    sub_menu_item:      TMenuItem;
    new_group_index:    Integer;
    new_item_index:     Integer;
    skip_img_loading:   Boolean;
    strL:               TStringList;
    Code, EtalonCode, sDate :string;
  	dtDate              :TDateTime;

begin
    try//except

        Application.Title:=veles_info.app_name;

        //при створенні форми заповнюємо щоб потім передати в дллку (модуль)
        //інші поля заповнюються в Project Source
        veles_info.control_pointers.form:=Pointer(self);
        veles_info.control_pointers.panel_ptr:=Pointer(p_main);
        veles_info.control_pointers.menu_ptr:=Pointer(MainMenu);
        veles_info.control_pointers.side_bar_ptr:=nil;// Pointer(SideBar);
        veles_info.control_pointers.status_bar_ptr:=Pointer(StatusBar);
       // veles_info.control_pointers.caption_ptr := Pointer(pnlCaption);

        FormStorage.IniFileName:=ini_files_path + KERNEL_INI_FILE_NAME;

        //Провіряємо чи зареєстрована програма
        strL := TStringList.Create;
     { 	res := 0;
	      try
          strL.LoadFromFile('.\\licence.key');
          Code := Copy(strL.Text, 1, 24);
		      Code := WiginerUnCript(DEL_(Code));
		      sDate := Code;
		      Delete(sDate, 1, 12);
		      Insert('.', sDate, 3);
		      Insert('.', sDate, 6);
		      dtDate := StrToDate(sDate);     }
          veles_info.custom_data.DateOfDeath := StrToDate('01.02.2015');
		      res := 1;
      {  except
		      res := 0;
        end; 
	      Code := Copy(Code, 1, 12);
	      EtalonCode := MD5(GetHDDInfo);
	      EtalonCode := Copy(EtalonCode, 1, 12);
	      if ((res = 0)or((EtalonCode <> Code))) then
		      Close();    }

        //загружаємо інформацію про модулі, створюємо Groups та Items на SideBar,
        //MenuItems в MainMenu
        module_manager:=zModuleManager.Create;
        veles_info.control_pointers.module_manager := Pointer(module_manager);
        module_manager.LoadFromXML(xml_file_name);//xml_file_name заповнюється в Project Source
        bitmap:=TBitmap.Create;
        try//finally
                //перебираємо всі сторінки
                for j:=0 to module_manager.Modules[0].PageCount - 1 do
                begin
                    new_item_index := j;
                    tab_set.Tabs.Add(module_manager.Modules[0].Pages[j].page_name);
                end;

            plugin_manager:=zPluginManager.Create(xml_file_name, MainMenu, OnPluginMenuClick);
        finally
            bitmap.Free;
        end;
    except
        on E: Exception do
            HandleError('Збій в процедурі Tfmain.FormCreate. Текст повідомлення: ' + E.Message);
    end;
end;//Tfmain.FormCreate

procedure Tfmain.FormDestroy(Sender: TObject);
var i: integer;
begin
    try
        if module_manager <> nil then
            module_manager.Free;

        if plugin_manager <> nil then
            plugin_manager.Destroy;

        for i := 0 to base.TransactionCount - 1 do
          if base.Transactions[i].InTransaction then
            base.Transactions[i].Rollback;

        if web_splash <> nil then
          web_splash.Free;
    except
        on E: Exception do
            HandleError('Невідома помилка в процедурі FormDestroy. Текст повідомлення: ' + E.Message);
    end;
end;

procedure Tfmain.SetAppName;
begin
{ TODO 3 -cUSERS : USER LOGIN HANDLER }
 {try
  if trR.InTransaction then trR.Commit;
  trR.StartTransaction;
   qR.SQL.Text := 'select name from t_clients where clients_id = 1';
   qR.ExecQuery;
   Caption := 'ПК "Конкурент" - ' + qR.FieldByName('name').AsString;
   tray_icon.Hint:= Caption + Char(#13) + ' Користувач: ' + veles_info.user_name;
   qR.Close;
   qR.SQL.Text := 'select user_id from t_users where user_login = user';
   qR.ExecQuery;
   veles_info.user_id := qR.FieldByName('user_id').AsInteger;
  if trR.InTransaction then trR.Commit;
 except

 end;}
end;

function DownloadURL_NOCache(const aUrl: string; var  s: String): Boolean;
var
  hSession: HINTERNET;
  hService: HINTERNET;
  lpBuffer: array[0..1024 + 1] of Char;
  dwBytesRead: DWORD;
begin
  Result := False;
  s := '';
  hSession := InternetOpen('MyApp', INTERNET_OPEN_TYPE_PRECONFIG, nil, nil, 0);
try
  if Assigned(hSession) then
  begin
    hService := InternetOpenUrl(hSession, PChar(aUrl), nil, 0, INTERNET_FLAG_RELOAD, 0);
    if Assigned(hService) then
  try
    while True do
    begin
      dwBytesRead := 1024;
      InternetReadFile(hService, @lpBuffer, 1024, dwBytesRead);
      if dwBytesRead = 0 then break;
      lpBuffer[dwBytesRead] := #0;
      s := s + lpBuffer;
    end;
    Result := True;
  finally
    InternetCloseHandle(hService);
  end;
  end;
finally
  InternetCloseHandle(hSession);
end;
end;

procedure Tfmain.htmlLite1HotSpotClick(Sender: TObject; const SRC: string;
  var Handled: Boolean);
begin
   ShellExecute(handle, 'open', PAnsiChar(SRC), nil, nil, SW_SHOW);
end;

function Tfmain.ShowHTML(const HTML: string): integer;
var ss_splash: string;
    r_splash: string;
    splash_len: integer;
    in_str, cc_str: string;
    f: TextFile;
begin

  try
  r_splash := 'http://konkurrent.com.ua/splash.php';
  if DownloadURL_NOCache(r_splash, ss_splash) and false  then
  begin
    remote_splash := ThtmlLite.Create(p_main);
    remote_splash.Parent := p_main;
    remote_splash.Align := alRight;
    remote_splash.DefBackground := clWhite;
    remote_splash.CharSet := RUSSIAN_CHARSET;
    remote_splash.Width := 300;
    remote_splash.OnHotSpotClick := htmlLite1HotSpotClick;

    remote_splash.LoadFromString(ss_splash, '');
  end;

  splash_splitter := TSplitter.Create(p_main);
  splash_splitter.Parent := p_main;
  splash_splitter.Align := alRight;
except
  remote_splash.Free;
  remote_splash := nil;
end;

try
  web_splash := ThtmlLite.Create(p_main);
  web_splash.Parent := p_main;
  web_splash.Align := alClient;
  web_splash.DefBackground := clWhite;
  web_splash.CharSet := RUSSIAN_CHARSET;
  web_splash.OnHotSpotClick := htmlLite1HotSpotClick;
  delete(r_splash, 1, 25);
  delete(r_splash, 8, 10);
  web_splash.LoadFromFile(veles_info.root_way + 'tuning\' + r_splash + 'html');
except

end;
  AssignFile(f, veles_info.root_way + 'tuning\' + r_splash + 'html');
  Reset(f);
  cc_str := '';
  while not Eof(f) do
  begin
    Readln(f, in_str);
    cc_str := cc_str + MD5(in_str);
    cc_str := MD5(cc_str);
  end;
  CloseFile(f);

//  splash_len := web_splash.GetTextLen;
//  SetLength(splash_text, splash_len);
//  web_splash.GetTextBuf(@(splash_text[0]), splash_len);
  if cc_str = 'B6A4B9C1987C461E7FCCC682C7B0640A' then
    Result := 0
  else
  begin
    web_splash.Free;
    Result := -1;
  end;
end;

//загружає і показує сторінку (якщо вона ще не загружена) або просто показує
//сторінку (якщо вона вже загружена);
//параметр a_tag_page_id це унікальний ідентифікатор сторінки який генерується
//автоматично при зчитуванні даних про модулі з xml файла і заноситься в property
//Tag SideBar.Group[i].Item і MenuItem; відповідно він і передається процедурі при
//необхідності загрузити та/або показати ту чи іншу сторінку (див. процедуру
//SideBarItemClick і OnAddedMenuClick);
//якщо ідентифікатор недійсний (ID_NIL_VALUE) виводиться відповідне повідомлення;
procedure Tfmain.PageHandler(a_tag_page_id: Integer);
var
    page:               ZPageInfoRec;
    ShowPageFunc:       TShowPage;

begin
    try
        HideControlsOnMainPanel;//в будь-якому випадку спочатку ховаємо усі контроли
        page:=module_manager.PageByID[a_tag_page_id];
        if page.page_id <> ID_NIL_VALUE then//якщо ідентифікатор дійсний
        begin
            if page.dll_handle = 0 then//сторінка ще не загружалась
            begin
                page.dll_handle:=LoadLibrary(PChar(modules_path + page.dll_name));
                if page.dll_handle <> 0 then
                begin
                    module_manager.PageByID[a_tag_page_id]:=page;//зберігаємо хендл дллкі
                end
                else begin
                    HandleError('Неможливо загрузити компонент ' + page.page_name +
                        '. Перевірте наявність файла динамічної бібліотеки ' + page.dll_name);
                    exit;
                end;
            end;
            @ShowPageFunc:=GetProcAddress(page.dll_handle, SHOW_PAGE_FUNC_NAME);
            if @ShowPageFunc = nil then
            begin
                HandleError('Неможливо викликати процедуру ' + SHOW_PAGE_FUNC_NAME +
                    ' (процедура Tfmain.OnAddedMenuClick)');
                exit;
            end;
            page.page_form:=TForm(ShowPageFunc(veles_info));
            module_manager.PageByID[a_tag_page_id]:=page;//зберігаємо вказівик на форму
        end//if page.page_id <> ID_NIL_VALUE
        else begin
            HandleError('Некоректний ідентифікатор page.page_id (процедура Tfmain.PageHandler)');
        end;
    except
        on E: Exception do
            HandleError('Невідома помилка в процедурі Tfmain.PageHandler. Текст повідомлення: ' + E.Message);
    end;
end;//Tfmain.PageHandler

procedure Tfmain.SideBar_ItemClick(Sender: TObject; Item: TdxSideBarItem);
begin
    //передаємо ідентифікатор сторінки
    PageHandler(Item.Tag);
end;

procedure Tfmain.HideControlsOnMainPanel;
var i:              Integer;
begin
    for i:=0 to p_main.ControlCount - 1 do
    begin
        p_main.Controls[i].Visible:=false;
    end;
end;

procedure Tfmain.FormShow(Sender: TObject);
begin
    //обов'язково виводимо ім'я користувача при показі форми бо якщо,
    //при своренні змінна veles_info.user_name ще не заповнена
    if StatusBar.Panels.Count > 0 then
    begin
        StatusBar.Panels[0].Text:='Користувач: ' + veles_info.user_name;
    end;
end;

procedure Tfmain.OnPluginMenuClick(Sender: TObject);
begin
    if Sender is TMenuItem then
        PluginHandler((Sender as TMenuItem).Tag);
end;

procedure Tfmain.PluginHandler(a_tag_plugin_id: Integer);
var
    ShowPlugin:         ZShowPlugin;
    plugin:             ZPluginInfoRec;
    lib_handle:         THandle;
    OldErrMode:         Uint;
begin
    OldErrMode := SetErrorMode(0);
    plugin:=plugin_manager.PluginByID(a_tag_plugin_id);
    if plugin.plugin_id = ID_NIL_VALUE then
        Exit;
    lib_handle:=LoadLibrary(PChar(plugin.dll_name));
    if lib_handle > 32 then
    begin
        if plugin.func_name = '' then
            @ShowPlugin:=GetProcAddress(lib_handle, SHOW_PLUGIN_PROC_NAME)
        else//функція явно вказана
            @ShowPlugin:=GetProcAddress(lib_handle, PChar(plugin.func_name));

        if @ShowPlugin <> nil then
            ShowPlugin(veles_info);//показує модальну форму
        FreeLibrary(lib_handle);
    end;
    SetErrorMode(OldErrMode);
end;

procedure Tfmain.pmi_exitClick(Sender: TObject);
begin
//    if AppRestore = 0 then
        AppTerminate;
end;

procedure Tfmain.pmi_restoreClick(Sender: TObject);
begin
    AppRestore;
end;

procedure Tfmain.AppMinimize(Sender: TObject);
begin
    tray_icon.Visible := true;
    ShowWindow(Application.Handle, SW_HIDE);
    ShowWindow(Application.MainForm.Handle, SW_HIDE);    
end;

procedure Tfmain.tab_setChange(Sender: TObject; NewTab: Integer;
  var AllowChange: Boolean);
begin
  PageHandler(NewTab + 1);
end;

procedure Tfmain.tray_iconClick(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; Z, Y: Integer);
begin
    AppRestore;
end;

procedure Tfmain.tray_iconMouseMove(Sender: TObject; Shift: TShiftState; Z,
  Y: Integer);
begin
   // tray_icon.Hint:='Користувач: ' + veles_info.user_name;
end;

//функція виводить модальне вікно для введення пароля коли програму треба
//відновити з трея;
//вертає 0 якщо все нормально (тобто пароль правильний), -1 якщо користувач
//натиснув відмінити або просто закрив форму;
//якщо пароль неправильний вікно не закриється, а виведе відповідне повідомлення,
//тобто користувач мусить або ввести правильний пароль, або натиснути Відмінити;
//якщо пароль правильний відновить головне вікно програми, інакше ні;
function Tfmain.AppRestore: Integer;
begin
   Result:=-1;
{     if not is_tray_pass_called then//щоб не створювати кілька діалогів
    begin
        lib_handle:=LoadLibrary(PChar('tray.dll'));
        if lib_handle > 32 then
        begin
            @lpTrayPass:=GetProcAddress(lib_handle, 'TrayPass');
            if @lpTrayPass <> nil then
            begin
                is_tray_pass_called:=true;
                if lpTrayPass(veles_info) = 0 then
                begin }

                    if (CheckTray(tray_icon.Hint, veles_info) > 0) then
                    begin
                      Application.Restore;
                      ShowWindow(Application.MainForm.Handle, SW_SHOW);
                      SetForeGroundWindow(Application.MainForm.Handle);
                      tray_icon.Visible := false;
                      Result:=0;
                    end;
    {            end;
            end;
            FreeLibrary(lib_handle);
        end;
        is_tray_pass_called:=false;
    end;  }
end;

procedure Tfmain.tray_iconDblClick(Sender: TObject);
begin
  AppRestore;
end;

procedure Tfmain.FreePages;
var
    i,j:            Integer;
    FreePage:       TFreePage;
    page:           ZPageInfoRec;

begin
  try
    if module_manager <> nil then
    begin
      //закриваємо всі сторінки і вигружаємо дллкі
      for i:=0 to module_manager.ModuleCount - 1 do
      begin
        for j:=0 to module_manager.Modules[i].PageCount - 1 do
        begin
          page:=module_manager.Modules[i].Pages[j];
          if page.dll_handle <> 0 then//якщо дллка загружена
          begin
            @FreePage:=GetProcAddress(page.dll_handle, FREE_PAGE_PROC_NAME);
            if @FreePage = nil then
            begin
              //краще вивести повідомлення і не припиняти роботу програми
              HandleError('Неможливо викликати процедуру ' + FREE_PAGE_PROC_NAME +
                                '. (Процедура Tfmain.FreePage)');
            end
            else begin
          try
              FreePage(Longint(page.page_form));
          except
              //виводимо повідомлення і рухаємося далі
              HandleError('Помилка в процедурі ' + FREE_PAGE_PROC_NAME +
                    '. (Процедура Tfmain.FreePage)');
          end;
            end;
          try
              FreeLibrary(page.dll_handle);
          except
              //виводимо повідомлення і рухаємося далі
              HandleError('Неможливо вигрузити бібліотеку ' +
                     page.dll_name + '. (Процедура Tfmain.FreePage)');
          end;
        end;//if module_manager.Modules[i].Pages[j].dll_handle <> 0
      end;//for j:=0 to module_manager.Modules[i].PageCount - 1
    end;//for i:=0 to module_manager.ModuleCount - 1
  end;//if module_manager <> nil
  except
    on E: Exception do
            HandleError('Невідома помилка в процедурі Tfmain.FreePage. Текст повідомлення: ' + E.Message);
  end;
end;//Tfmain.FreePage

//УВАГА! Закривати сторінки (тобто викликати процедури FreePages, як зрештою і
//інші процедури із дллки) необхідно в OnClose а не OnDestroy;
//інакше буде Exception (не знаю чому);
procedure Tfmain.AppTerminate;
var answer: Integer;
begin
  FreePages;
  Application.Terminate;
end;

procedure Tfmain.FormCloseQuery(Sender: TObject; var CanClose: Boolean);
begin
  CanClose:=false;
  AppMinimize(Sender);
end;

procedure Tfmain.miModeSetClick(Sender: TObject);
var
  mode_name_new, mode_name: string;
  mes: PAnsiChar;
  mode_id, mode_id_new: Integer;
begin
  mode_id := -1;
  mode_name := 'Невизначено';
  try
    if trR.InTransaction then trR.Commit;
    trR.StartTransaction;
    qR.SQL.Text :=
      'select s.TP_MODE_ID, m.name' + #13#10 +
      'from T_TP_STATES s' + #13#10 +
        'left join ts_tp_modes m on m.tp_mode_id = s.tp_mode_id';
    qR.ExecQuery;
    if qR.RecordCount > 0 then
    begin
      mode_id := qR.FieldByName('TP_MODE_ID').AsInteger;
      mode_name := qR.FieldByName('name').AsString;
    end;
    qR.Close;
    if trR.InTransaction then trR.Commit;
  except
  end;

  if mode_id = 0 then
  begin
    mode_id_new := 2;
    mode_name_new := 'ВІДНОВЛЕННЯ';
  end
  else
  begin
    mode_id_new := 0;
    mode_name_new := 'АВАРІЙНИЙ';
  end;

  mes := PAnsiChar('Торгова площадка знаходиться в режимі "'+mode_name+'".'+#13#10#13#10+
  'Встановити режим "'+mode_name_new+'" ?');
  if GMessageBox(mes, 'Так|Ні') = 1 then
  begin
    if trW.InTransaction then trW.Commit;
    trW.StartTransaction;
    if mode_id_new = 2 then
      qW.SQL.Text := ' update T_TP_STATES set TP_MODE_ID = 2 where TP_MODE_ID = 0'
    else
      qW.SQL.Text := ' update T_TP_STATES set TP_MODE_ID = 0 where TP_MODE_ID <> 0';
    qW.ExecQuery;
    if trW.InTransaction then trW.Commit;
  end;
end;

procedure Tfmain.mi_exitClick(Sender: TObject);
begin
  AppTerminate;
end;


end.
