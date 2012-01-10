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

//����� ��������� ������� ��������;
function GetRootPath(const a_exe_path: string): string;
var
    exe_path:       string;
    i:              Integer;
    slesh_pos:      Integer;

begin
    if a_exe_path = '' then raise Exception.Create('����� ������ a_exe_path');
    //�������� ������� ����
    exe_path:=Copy(a_exe_path, 1, Length(a_exe_path) - 1);
    slesh_pos:=0;
    for i:=1 to length(exe_path) do//��������� ������� ����
    begin
        if exe_path[i] = '\' then slesh_pos:=i;
    end;
    if slesh_pos = 0 then//���� ���� ������ ���� ���� (��������� C:)
    begin
        Result:=exe_path + '\';//������ ���� �� ����� ��������
    end
    else begin//��� ������ ���� (��������� �:\bin\veles)
        //������� ����� � ������� ������ (����� �:\bin\)
        Result:=Copy(exe_path, 1, slesh_pos);
    end;
end;

//���������� ����� �� ��-����� �� ��., � ����:
//    images_path
//    modules_path
//    logs_path
//    ini_files_path
//�� ��'����� � unit utils_h;
procedure SetPaths(const a_exe_path: string);
var
    root_path:       string;

begin
    root_path:=GetRootPath(a_exe_path);
    //�� ���� �� ��������� ��'����� � unit utils_h
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
        //ErrorDialog('����', '��������');
        HandleError('�� ��������� �������� �������');
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
            if (ParamCount > 0)and(ParamStr(1) <> '') then//�� � ����������� ��� ���������
            begin
                xml_file_name:=ParamStr(1);//xml_file_name ������������� � ����� main.pas
                if not FileExists(xml_file_name) then
                    raise Exception.Create('���� ' + xml_file_name + ' �������. �������� �������� ��� ���������� ��������');
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

                    //veles_info ������������� � ����� main.pas
                    veles_info.version:=ini_file.ReadInteger('version', 'ver', 1);
                    veles_info.app_handle:=Application.Handle;
                    StrPCopy(veles_info.server_ip, ini_file.ReadString('BaseOptions', 'ServerIP', '127.0.0.1'));
                    StrPCopy(veles_info.base_way, ini_file.ReadString('BaseOptions', 'BaseWay', 'D:\BASE\SHOP.GDB'));
//                    StrPCopy(veles_info.security_way, ini_file.ReadString('BaseOptions', 'Security', '/usr/local/firebird/security.fdb'));
                    StrPCopy(veles_info.SYSDBA_password, PasswordCryptor(ini_file.ReadString('BaseOptions', 'SYSDBAPassword', 'masterkey'), false));
                    veles_info.control_pointers.form:=nil;//�� ���� ������� ��������� �����
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
                    //����� �� ������ - ����������� ���������� ������
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
                            on E: Exception do HandleError('�� ������� �''��������: ' + E.Message);
                        end;
                        if fmain.Base.Connected then
                        begin
                            //���� ���� �� ����������� �� ���� ���������� �����,
                            //��'� ����� �� �������� ���� �������������
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
                                        //���� ��������� ����������� �������� ����� �� ��������� ��������
                                        Application.MainForm.Visible:=true;
                                        InitObject(veles_info);
                                        Application.Run;
                                    end
                                    else if start_func_result = RESULT_CANCEL then
                                    begin
                                        //"³������" - ����� �� ������
                                    end
                                    else if start_func_result = RESULT_FAIL then
                                    begin
                                        HandleError(start_func_name + ' = RESULT_FAIL');
                                    end
                                    else begin
                                        HandleError('������� �������� ������� ' + start_func_name + '. (Project Source ��������)');
                                    end;
                                end//if @GetStartResult <> nil
                                else begin
                                    HandleError('��������� ��������� ������� ' + start_func_name + '. (Project Source ��������)');
                                end;
                            end//if start_dll_handle <> 0
                            else begin
                                HandleError('��������� ��������� �������� �������� ' + start_dll_name + '. �������� �������� ��� ���������� ��������. (Project Source ��������)');
                            end;


                        end;//if fmain.Base.Connected then
                    end;//if fpassword.ShowModal then
                finally
                    //���� ������� �������� ����� ���� � ����� finally
                    //������ ���� �������� ���� ������ �������
                    CoUninitialize;

                    fpassword.Free;
                    fmain.Free;//������ ���� �������� ������� �� ��������
                    //���� �����, ��� ��� ���� ������ Free �� �������� �� �������
                end;
            end//if (ParamCount > 0)and(ParamStr(1) <> '')
            else begin
                HandleError('������������ ������ �������� Veles.exe. �� �������� xml ����. (Project Source ��������)');
            end;
        except
            on E: Exception do
                HandleError('������� ������� � Project Source ��������. ����� �����������: ' + E.Message);
        end;
    finally
        if start_dll_handle <> 0 then
        begin
            //����� ���� � ��������� � �����, ��� ������� ����������� �� ��� ������
            FreeLibrary(start_dll_handle);
        end;
    end;
    dispose(veles_info.custom_data.pcode_dealer);
end.

