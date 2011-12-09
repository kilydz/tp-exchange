unit utils_h;

interface

uses Forms, Windows, Classes, Dialogs, kernel_h, Zutils_h;

const
    ID_NIL_VALUE = -1;//������������� �� ����������

    MODULES_MENU_NAME = '��������';

 //   MODULES_SUBDIR   = 'veles\';
 //   LOGS_SUBDIR      = 'common\log\';
 //   INI_FILES_SUBDIR = 'common\ini\';

    KERNEL_INI_FILE_NAME             = 'kernel.ini';
    DEFAULT_SIDEBAR_BITMAP_FILE_NAME = 'default.bmp';
    DEFAULT_SMALL_SBAR_BITMAP_FNAME  = 'default_small.bmp';    
    ERRORS_LOG_FILE_NAME             = 'kern_err.log';

type
    //�����² ����������!

 //����, ���� ������ �������������� (���� Integer) � ������ ������;
    TIDManager = class(TObject)
    private
        data: array of Integer;
        fIsIDsUnique: Boolean;
        function GetItem(idIndex: Integer): Integer;
    public
        constructor Create(const aIsIDsUnique: Boolean);
        destructor Destroy; override;
        function Add(const addedID: Integer): Integer;
        function Count: Integer;
        function Delete(const deletingID: Integer): Integer;
        function GetListAsString: string;
        function GetIDIndex(const findingID: Integer): Integer;
        function GetMaxID: Integer;
        function GetMinID: Integer;
        procedure Clear;
        property Items[idIndex: Integer]: Integer read GetItem; default;
    end;

    //������ (module) ������ ����� ������� (pages); ������ ����� �� ���� �������;
    //����� �� ����� �����;
    //�� SideBar �� ������� ���� ����� ���������� ������ (Groups),
    //� ������� - ������ (Items);
    //���� ����������� ���� ����������� �� �� ���� �����;

    //���������� ��� �������
    ZPageInfoRec = record
        page_id:         Integer;
        page_name:       string;
        dll_name:        string;
        page_icon_name:  string;
        dll_handle:      THandle;
        page_form:       TForm;
    end;

    TPageInfoRecArray = array of ZPageInfoRec;

    //���� �� �������� ����� ������� (�������� �� ������� ������ ���. �����)
    //������ � ��� ����� TPageInfoRecArray, ����� ���� ������ ������ � ���
    //����� �������, ������ �� ���� ����� �������� ����� ���������� Pages
    //(Module.Pages[0].dllName);
    ZModule = class(TObject)
    private
        FModuleID:   Integer;
        FModuleName: string;
        pages_array: TPageInfoRecArray;
        many_pages:  Integer;
        function GetModuleID: Integer;
        function GetModuleName: string;
        function GetPage(page_index: Integer): ZPageInfoRec;
        procedure SetModuleID(const value: Integer);
        procedure SetModuleName(const value: string);
        procedure SetPage(page_index: Integer; const value: ZPageInfoRec);
    public
        constructor Create();
        destructor Destroy(); override;
        function PageCount(): Integer;
        procedure AddPage(const new_page: ZPageInfoRec);
        procedure DropAllPages();
        property ModuleID: Integer read GetModuleID write SetModuleID default 0;
        property ModuleName: string read GetModuleName write SetModuleName;
        property Pages[page_index: Integer]: ZPageInfoRec read GetPage write SetPage;
    end;

    //���� �� �������� ���� �������� �� ��������� (�������� �� ������� ������ ���. �����)
    //������ � ��� ����� ������ ������ �� ���� ����� �������� ����� ���������� Modules;
    //ModuleManager.Modules[0].Pages[0].dllName);
    ZModuleManager = class(TObject)
    private
        modules_array:    array of ZModule;
        many_modules:     Integer;
        function GetModule(module_index: Integer): ZModule;
        procedure SetModule(module_index: Integer; const value: ZModule);
        function GetPageByID(a_page_id: Integer): ZPageInfoRec;
        procedure SetPageByID(a_page_id: Integer; const value: ZPageInfoRec);
    public
        constructor Create;
        destructor Destroy; override;
        function ModuleByID(const a_module_id: Integer): ZModule;
        function ModuleCount(): Integer;
        procedure AddModule(const new_module: ZModule);
        procedure DropAllModules();
        procedure LoadFromXML(const a_XML_file_name: string);
        property Modules[module_index: Integer]: ZModule read GetModule write SetModule;
        property PageByID[a_page_id: Integer]: ZPageInfoRec read GetPageByID write SetPageByID;
    end;

//�������� ���. �����
procedure HandleError(const error_message: string);

//�������� ���. �����
function PasswordCryptor(password: string; crypt: Boolean): string;

//function GMessageBox(msg, buttons: PChar): Integer; stdcall;

procedure ErrorDialog(const err_mess: string; const proc_name: string = '');
function IsEngStr(const s: string): boolean;
function IsEngChar(const c: char): boolean;

var
    images_path:         string;
    modules_path:        string;
    logs_path:           string;
    ini_files_path:      string;

implementation

uses SysUtils, ECXMLParser;//, crypt_h;

//function GMessageBox(msg, buttons: PChar): Integer;
//   stdcall; external 'genstor.dll' name 'GMessageBox';


var
    id_count:            Integer = 0;

//������ ������� �������������� �� 1 �� 2147483647, �� �������������
//������� �� �������� ��� ��������� xml (������� ��� ���� ���� �������);
function GetID(): Integer;
begin
    id_count:=id_count + 1;
    Result:=id_count;
end;

//�������� ����������� ��� ������� �� ������ � ���� LOGS_DIRECTORY +
//ERRORS_LOG_FILE_NAME ����, ��� �� ����� �������, �� ��������� �� ��� ������
//�������� (����);
//��������� ������ � ���� ����������� ����� ���� ���� LOGS_DIRECTORY +
//ERRORS_LOG_FILE_NAME ����;
//���� �� ��� ��������� ��������� ��������� ������� (�� �����������) ��������
//������� � �� ����������� � ���"�� (���� �� ��������� ����������� � ������
//try ... except (�� ������� ����������));
procedure HandleError(const error_message: string);
var
    f:      TextFile;

begin
//    Application.MessageBox(PChar(error_message),
//        PChar('�������'), MB_ICONERROR);
    GMessageBox(PChar(error_message), 'OK');
    try
        if FileExists(logs_path + ERRORS_LOG_FILE_NAME) then
        begin
            AssignFile(f, logs_path + ERRORS_LOG_FILE_NAME);
            try            
                Append(f);
                Writeln(f, DateTimeToStr(Now) + ' ' + error_message);
                Writeln(f);
            finally
                CloseFile(f);
            end;
        end;
    except
//        Application.MessageBox(PChar('������� �� ��� ������ � ���� ' +
//            ERRORS_LOG_FILE_NAME + '. (��������� HandleError)'),
//            PChar('�������'), MB_ICONERROR);
        GMessageBox(PChar('������� �� ��� ������ � ���� ' +
            ERRORS_LOG_FILE_NAME + '. (��������� HandleError)'),
            'OK');
    end;
end;//HandleError


//---------------------------------- ZModule -----------------------------------
//----------------------------------- begin ------------------------------------
//���� ������������� � ������ �� ����� ���� ������;
//���� aIsIDsUnique ��� �������� true � ������������ ��� � � ������ ����� -1;
function TIDManager.Add(const addedID: Integer): Integer;
begin
    if fIsIDsUnique then
    begin
        Result:=GetIDIndex(addedID);
        if Result < 0 then//�������������� ���� � ������
        begin
            Result:=Length(data);
            SetLength(data, Length(data) + 1);
            data[Length(data) - 1]:=addedID;
        end
        else begin
            Result:=-1;
        end;
    end
    else begin
        Result:=Length(data);
        SetLength(data, Length(data) + 1);
        data[Length(data) - 1]:=addedID;
    end;
end;

function PasswordCryptor(password: string; crypt: Boolean): string;
var
    i:      Integer;
begin
    if crypt then
    begin
        for i:=1 to Length(password) do
        begin
            password[i]:=chr(ord(password[i]) + 3);
        end;
    end
    else begin
        for i:=1 to Length(password) do
        begin
            password[i]:=chr(ord(password[i]) - 3);
        end;
    end;
    Result:=password;
end;//PasswordCryptor

procedure TIDManager.Clear;
begin
    data:=nil;
end;

function TIDManager.Count: Integer;
begin
    Result:=Length(data);
end;

//�������� aIsIDsUnique ����� �� � ������ ������ ���������� ������� �������������;
constructor TIDManager.Create(const aIsIDsUnique: Boolean);
begin
    inherited Create;
    data:=nil;
    fIsIDsUnique:=aIsIDsUnique;
end;

//������� ������������� �� ����� ���� ������;
//���� � ����� ���������� �������������� ������� ������ � ���;
//���� ������������� ���� � ������, �� ����� -1;
function TIDManager.Delete(const deletingID: Integer): Integer;
var
    i:          Integer;

begin
    Result:=GetIDIndex(deletingID);
    if Result >= 0 then//������ �� ������
    begin
        if Result <> pred(Length(data)) then//���� �� ������� �������
        begin
            for i:=(Result + 1) to pred(Length(data)) do
            begin
                data[i - 1]:=data[i];
            end;
        end;
        SetLength(data, pred(Length(data)));
    end;
end;

destructor TIDManager.Destroy;
begin
    data:=nil;
    inherited;
end;

//����� ������ ��������������; ���� ������������� �� ��������� ����� -1;
//���� � ����� ��������� �������������� �� ����� ���� ������ �������;
function TIDManager.GetIDIndex(const findingID: Integer): Integer;
var
    i:          Integer;

begin
    Result:=-1;
    i:=0;
    while (Result < 0)and(i < Length(data)) do
    begin
        if findingID = data[i] then
        begin
            Result:=i;
        end
        else begin
            Inc(i);
        end;
    end;
end;

function TIDManager.GetItem(idIndex: Integer): Integer;
begin
    if (idIndex >= 0)and(idIndex < Length(data)) then
    begin
        Result:=data[idIndex];
    end
    else begin
        raise Exception.Create('����� �� ��� ������ TIDManager');
    end;
end;

//����� ������ �������������� � ������ ������ ���� ��������� ������
//�������: '1,2,7,15';
function TIDManager.GetListAsString: string;
var
    i:          Integer;

begin
    Result:='';
    for i:=0 to pred(Length(data)) do
    begin
        Result:=Result + IntToStr(data[i]);
        if i < pred(Length(data)) then//���� �� �� ������� ������ ������ ����
        begin
            Result:=Result + ',';
        end;
    end;
end;

//����� ������������� �������������; ���� ������ ������ ����� -1;
function TIDManager.GetMaxID: Integer;
var
    i:          Integer;
    temp:       Integer;

begin
    if Length(data) = 0 then
    begin
        Result:=-1;
    end
    else begin
        Result:=data[0];
        for i:=1 to pred(Length(data)) do
        begin
            temp:=data[i];
            if temp > Result then
            begin
                Result:=temp;
            end;
        end;
    end;
end;

//����� ��������� �������������; ���� ������ ������ ����� -1;
function TIDManager.GetMinID: Integer;
var
    i:          Integer;
    temp:       Integer;

begin
    if Length(data) = 0 then
    begin
        Result:=-1;
    end
    else begin
        Result:=data[0];
        for i:=1 to pred(Length(data)) do
        begin
            temp:=data[i];
            if temp < Result then
            begin
                Result:=temp;
            end;
        end;
    end;
end;

//---------------------------------- ZModule -----------------------------------
//----------------------------------- begin ------------------------------------
//���� ������� � ����� ������;
procedure ZModule.AddPage(const new_page: ZPageInfoRec);
begin
    many_pages:=many_pages + 1;
    SetLength(pages_array, many_pages);
    pages_array[many_pages - 1]:=new_page;
end;

constructor ZModule.Create;
begin
    inherited Create;
    FModuleID:=ID_NIL_VALUE;
    FModuleName:='';
    pages_array:=nil;
    many_pages:=0;
end;

//�� �������� ²���²�Ͳ �����!
destructor ZModule.Destroy;
begin
    FModuleID:=ID_NIL_VALUE;
    FModuleName:='';
    pages_array:=nil;
    many_pages:=0;
    inherited;
end;

//����� �� �������, ����� ���������� ��� ��� (�� �������� ²���²�Ͳ �����);
procedure ZModule.DropAllPages;
begin
    pages_array:=nil;
    many_pages:=0;
end;

function ZModule.GetModuleID: Integer;
begin
    Result:=FModuleID;
end;

function ZModule.GetModuleName: string;
begin
    Result:=FModuleName;
end;

//����� �������, ��� ������� page_index;
//���� page_index �������� �� ��� ������ ���������� Exception;
function ZModule.GetPage(page_index: Integer): ZPageInfoRec;
begin
    if (page_index > (many_pages - 1))or(page_index < 0) then
    begin
        raise Exception.Create('����� �� ������� ������ (������� ZModule.GetPage)');
    end
    else begin
        Result:=pages_array[page_index];
    end;
end;

//����� ������� �������, �� �������� � ������ �����;
function ZModule.PageCount: Integer;
begin
    Result:=many_pages;
end;

//�������! �� ������� ������ ������������� ������; �� ���� ��������� ��
//���������� ������ ��������; �������������� ��� ������ �������������� �����������;
procedure ZModule.SetModuleID(const value: Integer);
begin
    FModuleID:=value;
end;

procedure ZModule.SetModuleName(const value: string);
begin
    FModuleName:=value;
end;

//���������� ���� ������� �� ���� �� �� ������� page_index;
//���� page_index �������� �� ��� ������ ���������� Exception;
procedure ZModule.SetPage(page_index: Integer; const value: ZPageInfoRec);
begin
    if (page_index > (many_pages - 1))or(page_index < 0) then
    begin
        raise Exception.Create('����� �� ������� ������ (������� ZModule.SetPage)');
    end
    else begin
        pages_array[page_index]:=value;
    end;
end;
//---------------------------------- ZModule -----------------------------------
//------------------------------------ end -------------------------------------



//------------------------------ ZModuleManager --------------------------------
//----------------------------------- begin ------------------------------------
//���� ������ � ����� ������;
procedure ZModuleManager.AddModule(const new_module: ZModule);
begin
    many_modules:=many_modules + 1;
    SetLength(modules_array, many_modules);
    modules_array[many_modules - 1]:=new_module;
end;

constructor ZModuleManager.Create;
begin
    inherited Create;
    many_modules:=0;
    modules_array:=nil;
end;

//�� �������� ²���²�Ͳ �����!
destructor ZModuleManager.Destroy;
var
    i:          Integer;

begin
    for i:=0 to many_modules - 1 do
    begin
        modules_array[i].Destroy;
    end;
    many_modules:=0;
    inherited;
end;

//����� �� �����, ����� ���������� ��� ��� (�� �������� ²���²�Ͳ �����);
procedure ZModuleManager.DropAllModules;
var
    i:          Integer;

begin
    for i:=0 to many_modules - 1 do
    begin
        modules_array[i].Destroy;
    end;
    many_modules:=0;
end;

//����� ������, ���� ������� module_index;
//���� module_index �������� �� ��� ������ ���������� Exception;
function ZModuleManager.GetModule(module_index: Integer): ZModule;
begin
    if (module_index > (many_modules - 1))or(module_index < 0) then
    begin
        raise Exception.Create('����� �� ������� ������ (������� ZModuleManager.GetModule)');
    end
    else begin
        Result:=modules_array[module_index];
    end;
end;

//����� ������� ��� ������� �������������� a_page_id; ����� �������� � ��� �������,
//�� ������������� ���������� ��� ��������������;
//���� �� �������� �������, ��� ������� a_page_id ��������� ����� �������, ��:
//
//        page_id:=ID_NIL_VALUE;
//        page_name:='';
//        dll_name:='';
//        page_icon_name:='';
//        dll_handle:=0;
//        page_form:=nil;
//
function ZModuleManager.GetPageByID(a_page_id: Integer): ZPageInfoRec;
var
    i,j:            Integer;

begin
    with Result do//���� ����� �� �������� ������� ���� ��������
    begin
        page_id:=ID_NIL_VALUE;
        page_name:='';
        dll_name:='';
        page_icon_name:='';
        dll_handle:=0;
        page_form:=nil;
    end;
    for i:=0 to many_modules - 1 do
    begin
        for j:=0 to modules_array[i].PageCount - 1 do
        begin
            if modules_array[i].Pages[j].page_id = a_page_id then
            begin
                Result:=modules_array[i].Pages[j];
                exit;
            end;
        end;
    end;
end;

//������� � xml ����� ���������� ��� ����� �� �������, � ����� �����������
//�������� ��� ������� �� �������� ������� ��������������;
//XML ���� ������� ��������� ����������� ��������; ��� �������:
//
//<?xml version="1.0" encoding="WINDOWS-1251" standalone="yes"?>
//<VelesAppInfo>
//	  <StartWork>
//		  <dllName>StoreSt.dll</dllName>
//		  <functionName>GetPassword</functionName>
//	      <appIconName>app_defa.ico</appIconName>
//	  </StartWork>
//    <ListOfModules>
//        <module>
//	        <name>������</name>
//	    	<page>
//	    		<name>�����������</name>
//	    		<dllName>Users.dll</dllName>
//	    		<iconName>Users.bmp</iconName>
//	    	</page>
//	    	<page>
//	    		<name>����� ������������</name>
//	    		<dllName>Groups.dll</dllName>
//	    		<iconName>Groups.bmp</iconName>
//	    	</page>
//	    	<page>
//	    		<name>��������</name>
//	    		<dllName>AdmHelp.dll</dllName>
//	    		<iconName>AdmHelp.bmp</iconName>
//	    	</page>
//        </module>
//    </ListOfModules>
//</VelesAppInfo>
//
//���������� ��� ����� �������� � ������� <ListOfModules>...</ListOfModules>,
//� ����: ��"� ������ � ������ �������;
//� ���� ����� ������� <page>...</page> ������ ��"� �������, ��"� ����� �����,
//� ��� �������� ������� � ��"� ���������� �����, ���� ���������� ��� ��������
//�� ����, �� ������� ���� �������;
//
//����� a_XML_file_name ���� ���� ������������ ������ ������������ (���� �
//����������� .xcr);
//���� �������������� � ��������� �� ��������� xml ���� (��������� ���.
//������ xml_cript.exe);
procedure ZModuleManager.LoadFromXML(const a_XML_file_name: string);
var
    xml_parser:     TECXMLParser;
    i, j:           Integer;
    module:         ZModule;
    page:           ZPageInfoRec;
    file_ext:       string;
//    str_stream:     TStringStream;
    temp_file:      string;

begin
    xml_parser:=TECXMLParser.Create(nil);
    try
        file_ext:=ExtractFileExt(a_XML_file_name);
        if UpperCase(file_ext) = xml_EXTENTION then
        begin
            xml_parser.LoadFromFile(a_XML_file_name);
        end
//        else if UpperCase(file_ext) = CRYPT_EXTENTION then
//        begin
{
            str_stream:=TStringStream.Create('');
            try
                LoadCryptedFileToStream(a_XML_file_name, str_stream);
                xml_parser.LoadFromStream(str_stream);//�� ����ު - �� ���� ����
            finally
                str_stream.Free;
            end;
}
//            try
//                temp_file:=UncryptFile(a_XML_file_name);
//                xml_parser.LoadFromFile(temp_file);
//            finally
//                DeleteFile(temp_file);
//            end;
//        end
        else begin
            raise Exception.Create('����������� ���������� ����� (ZModuleManager.LoadFromXML)');
        end;

        with xml_parser.Root.NamedItem['listOfPages'] do
        begin
                module:=zModule.Create;
                module.ModuleID:=1;
                module.ModuleName:='root';
            for i:=0 to Count - 1 do
            begin
                    //���������� �� �� SubItems[j] ��"�, ���� ��� �� �� <page>
                 //   if SubItems[i].NamedItem['page'].Text <> '' then
                    // <module>    <page>      <name>
                 //   begin
                       page.page_id := GetID;
                       page.page_name := SubItems[i].NamedItem['name'].Text;
                       page.dll_name := SubItems[i].NamedItem['dllName'].Text;
                    //   page.page_icon_name := SubItems[i].SubItems[j].NamedItem['iconName'].Text;
                       page.dll_handle:=0;
                       page.page_form:=nil;
                       module.AddPage(page);
                  //  end;
            //    end;

            end;//for i:=0 to Count - 1
            AddModule(module);
        end;//with xml_parser.Root.NamedItem['ListOfPages']
    finally
        xml_parser.Free;
    end;
end;

//����� ������, ���� ������� �������������� a_module_id;
//���� ����� �� �������� ����� nil;
function ZModuleManager.ModuleByID(const a_module_id: Integer): ZModule;
var
    i:          Integer;

begin
    Result:=nil;
    for i:=0 to many_modules - 1 do
    begin
        if modules_array[i].ModuleID = a_module_id then
        begin
            Result:=modules_array[i];
            exit;
        end;
    end;
end;

//����� ������� ������;
function ZModuleManager.ModuleCount: Integer;
begin
    Result:=many_modules;
end;

//���������� ����� ������ �� ���� module_index;
//���� module_index �������� �� ��� ������ ���������� Exception;
procedure ZModuleManager.SetModule(module_index: Integer;
  const value: ZModule);
var
    temp:           ZModule;

begin
    if (module_index > (many_modules - 1))or(module_index < 0) then
    begin
        raise Exception.Create('����� �� ������� ������ (������� ZModuleManager.SetModule)');
    end
    else begin
        temp:=modules_array[module_index];
        modules_array[module_index]:=value;
        temp.Destroy;
    end;
end;

//���������� ���� ������� ��� ���� ��, �� ������� a_page_id;
//���� �� �������� �������, ��� ������� a_page_id ����� �� ����������;
procedure ZModuleManager.SetPageByID(a_page_id: Integer;
  const value: ZPageInfoRec);
var
    i,j:            Integer;

begin
    for i:=0 to many_modules - 1 do
    begin
        for j:=0 to modules_array[i].PageCount - 1 do
        begin
            if modules_array[i].Pages[j].page_id = a_page_id then
            begin
                modules_array[i].Pages[j]:=value;
                exit;
            end;
        end;
    end;
end;
//------------------------------ ZModuleManager --------------------------------
//------------------------------------ end -------------------------------------

procedure ErrorDialog(const err_mess: string; const proc_name: string = '');
begin
    //MessageBeep(MB_ICONEXCLAMATION);
    if proc_name = '' then
    begin
        GMessageBox(PChar('� ����� �������� ������� �������. ����� �����������: ' +
            err_mess), 'OK')
//        Application.MessageBox(PChar('� ����� �������� ������� �������. ����� �����������: ' +
//            err_mess), '�����', MB_ICONERROR or MB_OK);
    end
    else
    begin
        GMessageBox(PChar('� ����� �������� ������� �������. ����� �����������: ' +
            err_mess + '. ��''� ����������: ' + proc_name), 'OK');
//        Application.MessageBox(PChar('� ����� �������� ������� �������. ����� �����������: ' +
//            err_mess + '. ��''� ����������: ' + proc_name),
//            '�����', MB_ICONERROR or MB_OK);
    end;
end;

function IsEngStr(const s: string): boolean;
var
    i:          Integer;

begin
    Result:=true;
    for i:=1 to Length(s) do
    begin
        if not IsEngChar(s[i]) then
        begin
            Result:=false;
            exit;
        end;
    end;
end;

function IsEngChar(const c: char): boolean;
const
    ENG_CHARS = 'ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789_';
var
    i:          Integer;

begin
    Result:=false;
    {if Pos(c, ENG_CHARS) > 0 then
    begin
        Result:=true;
    end;}
    //��� ������ � 5 ���� ������
    for i:=1 to Length(ENG_CHARS) do
    begin
        if ENG_CHARS[i] = c then
        begin
            Result:=true;
            Exit;
        end;
    end;
end;

end.
