program kernel;



uses
  FastShareMem,
  Windows,
  SysUtils,
  Dialogs,
  Forms,
  Classes,
  Controls,
  ECXMLParser,
  IniFiles,
  kernel_h,
  utils_h,
  crypt_h,
  SHDocVw,
  ActiveX,
  Variants,
  MSHTML,
  main in 'main.pas' {fmain},
  password in 'password.pas' {fpassword},
  uAlgoritm in '..\Registrator_Generator\uAlgoritm.pas',
  utray in 'utray.pas' {ftray};

{$R *.res}
var
    xml_parser:             TECXMLParser;
    start_dll_handle:       THandle;
    start_dll_name:         string;
    start_func_name:        string;
    app_default_icon_name:  string;
    GetStartResult:         TGetStartResult;
    start_func_result:      Integer;
    ini_file:               TIniFile;
    temp_file:              string;
    file_ext:               string;

//вертає кореневий каталог програми;
function GetRootPath(const a_exe_path: string): string;
var
    exe_path:       string;
    i:              Integer;
    slesh_pos:      Integer;

begin
    if a_exe_path = '' then raise Exception.Create('Пуста строка a_exe_path');
    //відкидаємо останній слеш
    exe_path:=Copy(a_exe_path, 1, Length(a_exe_path) - 1);
    slesh_pos:=0;
    for i:=1 to length(exe_path) do//знаходимо останній слеш
    begin
        if exe_path[i] = '\' then slesh_pos:=i;
    end;
    if slesh_pos = 0 then//весь шлях включає лише диск (наприклад C:)
    begin
        Result:=exe_path + '\';//додаємо слеш бо раніше відкинули
    end
    else begin//тут повний шлях (наприклад С:\bin\veles)
        //копіюємо разом з останнім слешем (тобто С:\bin\)
        Result:=Copy(exe_path, 1, slesh_pos);
    end;
end;

//встановлює шляхи до іні-файлів та ін., а саме:
//    images_path
//    modules_path
//    logs_path
//    ini_files_path
//які об'явлені в unit utils_h;
procedure SetPaths(const a_exe_path: string);
var
    root_path:       string;

begin
    root_path:=GetRootPath(a_exe_path);
    //всі змінні та константи об'явлені в unit utils_h
    images_path:=root_path + WAY_IMAGES;
    modules_path:=root_path + WAY_BIN;
    logs_path:=root_path + WAY_LOG;
    ini_files_path:=root_path + WAY_INI;
end;

procedure InitObject(var a_veles_info: ZVelesInfoRec);
var
  libHandle: THandle;
  ObjectSetLast: function (var prm: ZVelesInfoRec): boolean;
begin
  a_veles_info.custom_data.pcode_dealer^ := -1;

  libHandle := LoadLibrary('objects.dll');
  if libHandle >= 32 then
  begin
    @ObjectSetLast := nil;
    @ObjectSetLast := GetProcAddress(libHandle, 'ObjectSetLast');
    if (@ObjectSetLast = nil) or
       (not ObjectSetLast(a_veles_info)) then
        //ErrorDialog('Жопа', 'дінозавра');
        HandleError('Не визначено активний магазин');
    FreeLibrary(libHandle);
  end;
end;


begin
    Application.Initialize;
    if Application.Handle = 0 then Application.CreateHandle;

    New(veles_info.custom_data.pcode_dealer);
    veles_info.custom_data.pcode_dealer^ := -1;

    start_dll_handle:=0;
    try
        try
            if (ParamCount > 0)and(ParamStr(1) <> '') then//чи з параметрами все нормально
            begin
                xml_file_name:=ParamStr(1);//xml_file_name задекларована в модулі main.pas
                if not FileExists(xml_file_name) then
                    raise Exception.Create('Файл ' + xml_file_name + ' відсутній. Перевірте наявність усіх компонентів програми');
                xml_parser:=TECXMLParser.Create(nil);

                StrPCopy(veles_info.prog_way, ExtractFilePath(Application.ExeName));
                StrPCopy(veles_info.root_way, GetRootPath(veles_info.prog_way));
                SetPaths(AnsiString(veles_info.prog_way));

                ini_file:=TIniFile.Create(ini_files_path + KERNEL_INI_FILE_NAME);
                try
                    xml_parser.LoadFromFile(xml_file_name);

                    start_dll_name:=xml_parser.Root.NamedItem['startWork'].NamedItem['dllName'].Text;
                    start_func_name:=xml_parser.Root.NamedItem['startWork'].NamedItem['functionName'].Text;
                    app_default_icon_name:=xml_parser.Root.NamedItem['startWork'].NamedItem['appIconName'].Text;

                    StrPCopy(veles_info.app_name, xml_parser.Root.NamedItem['startWork'].NamedItem['appName'].Text);

                 //   is_tray_used:=ini_file.ReadInteger('Other', 'UseTray', 1);
                    is_tray_used := 0;

                    //veles_info задекларована в модулі main.pas
                    veles_info.version:=ini_file.ReadInteger('version', 'ver', 1);
                    veles_info.app_handle:=Application.Handle;
                    StrPCopy(veles_info.server_ip, ini_file.ReadString('BaseOptions', 'ServerIP', '127.0.0.1'));
                    StrPCopy(veles_info.base_way, ini_file.ReadString('BaseOptions', 'BaseWay', 'D:\BASE\SHOP.GDB'));
//                    StrPCopy(veles_info.security_way, ini_file.ReadString('BaseOptions', 'Security', '/usr/local/firebird/security.fdb'));
                    StrPCopy(veles_info.SYSDBA_password, PasswordCryptor(ini_file.ReadString('BaseOptions', 'SYSDBAPassword', 'masterkey'), false));
                    veles_info.control_pointers.form:=nil;//на всяк випадок ініціалізую нілами
                    veles_info.control_pointers.panel_ptr:=nil;
                    veles_info.control_pointers.menu_ptr:=nil;
                    veles_info.control_pointers.side_bar_ptr:=nil;
                    veles_info.control_pointers.status_bar_ptr:=nil;
                    veles_info.control_pointers.module_manager := nil;
                    veles_info.base:=nil;
                finally
                    xml_parser.Free;
                    ini_file.Free;
                end;

                try
                    Application.Icon.LoadFromFile(images_path + app_default_icon_name);
                except
                    //нічого не робимо - загрузиться стандартна іконка
                end;
                CoInitialize(nil);

                fpassword:=Tfpassword.Create(Application);
                Application.CreateForm(Tfmain, fmain);

                fmain.Caption:=veles_info.app_name;

                try
                    veles_info.base:=Pointer(fmain.Base);

                 //   if AnsiString(veles_info.server_ip) <> '' then
                 //   begin
                        fpassword.ed_base_way.Text:=AnsiString(veles_info.server_ip) +
                            ':' + AnsiString(veles_info.base_way);
                 //   end
                 //   else begin
                 //       fpassword.ed_base_way.Text:=AnsiString(veles_info.base_way);
                 //   end;

                    fmain.ShowHTML('<head></head><body><h1></h1></body>');
                  //  splash_text.
                  //  web_splash.GetTextBuf(,web_splash.GetTextLen);

                    if fpassword.ShowModal = mrOk then
                    begin
                        try               // fpassword.ed_user_name.Text := 'SYSDBA';
                                           // fpassword.ed_password.Text := 'masterkey';
                            if fmain.Base.Connected then fmain.Base.Close;
                            fmain.Base.DatabaseName:=fpassword.ed_base_way.Text;
                            fmain.Base.Params.Clear;
                            fmain.Base.Params.Add('user_name=' + fpassword.ed_user_name.Text);
                            fmain.Base.Params.Add('password=' + fpassword.ed_password.Text);
                            fmain.Base.Params.Add('lc_ctype=WIN1251');
                            fmain.Base.Open;
                        except
                            on E: Exception do HandleError('Не вдалося з''єднатися: ' + E.Message);
                        end;
                        if fmain.Base.Connected then
                        begin
                            //після того як підключились до бази присвоюємо хандл,
                            //ім'я юзера та отримуємо його ідентифікатор
                            veles_info.db_handle:=fmain.Base.Handle;
                            StrPCopy(veles_info.user_name, fpassword.ed_user_name.Text);
                            StrPCopy(veles_info.user_password, fpassword.ed_password.Text);
                            fmain.SetAppName;
                            start_dll_handle:=LoadLibrary(PChar(modules_path + start_dll_name));
                            if start_dll_handle <> 0 then
                            begin
                                @GetStartResult:=GetProcAddress(start_dll_handle, PChar(start_func_name));
                                if @GetStartResult <> nil then
                                begin
                                    start_func_result:= RESULT_OK; //GetStartResult(veles_info);
                                    if start_func_result = RESULT_OK then
                                    begin
                                        //якщо нормально підключились показуємо форму та запускаємо програму
                                        Application.MainForm.Visible:=true;
                                        InitObject(veles_info);
                                        Application.Run;
                                    end
                                    else if start_func_result = RESULT_CANCEL then
                                    begin
                                        //"Відмінити" - нічого не робимо
                                    end
                                    else if start_func_result = RESULT_FAIL then
                                    begin
                                        HandleError(start_func_name + ' = RESULT_FAIL');
                                    end
                                    else begin
                                        HandleError('Невідоме значення функції ' + start_func_name + '. (Project Source програми)');
                                    end;
                                end//if @GetStartResult <> nil
                                else begin
                                    HandleError('Неможливо викликати функцію ' + start_func_name + '. (Project Source програми)');
                                end;
                            end//if start_dll_handle <> 0
                            else begin
                                HandleError('Неможливо загрузити динамічну бібліотеку ' + start_dll_name + '. Перевірте наявність усіх компонентів програми. (Project Source програми)');
                            end;


                        end;//if fmain.Base.Connected then
                    end;//if fpassword.ShowModal then
                finally
                    //дуже важливо звільнити форми саме в блоці finally
                    //інакше буде виникати дуже багато помилок
                    CoUninitialize;

                    fpassword.Free;
                    fmain.Free;//власне сама програма відповідає за знищення
                    //цієї форми, але все одно виклик Free не призведе до помилок
                end;
            end//if (ParamCount > 0)and(ParamStr(1) <> '')
            else begin
                HandleError('Неправильний запуск програми Veles.exe. Не вказаний xml файл. (Project Source програми)');
            end;
        except
            on E: Exception do
                HandleError('Невідома помилка в Project Source програми. Текст повідомлення: ' + E.Message);
        end;
    finally
        if start_dll_handle <> 0 then
        begin
            //можна було б вигрузити і раніше, але можливо знадобиться під час роботи
            FreeLibrary(start_dll_handle);
        end;
    end;
    dispose(veles_info.custom_data.pcode_dealer);
end.

