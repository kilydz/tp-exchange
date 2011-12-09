unit utils_h;

interface

uses Forms, Windows, Classes, Dialogs, kernel_h, Zutils_h;

const
    ID_NIL_VALUE = -1;//ідентифікатор не визначений

    MODULES_MENU_NAME = 'Довідники';

 //   MODULES_SUBDIR   = 'veles\';
 //   LOGS_SUBDIR      = 'common\log\';
 //   INI_FILES_SUBDIR = 'common\ini\';

    KERNEL_INI_FILE_NAME             = 'kernel.ini';
    DEFAULT_SIDEBAR_BITMAP_FILE_NAME = 'default.bmp';
    DEFAULT_SMALL_SBAR_BITMAP_FNAME  = 'default_small.bmp';    
    ERRORS_LOG_FILE_NAME             = 'kern_err.log';

type
    //ВАЖЛИВІ ВИЗНАЧЕННЯ!

 //клас, який містить ідентифікатори (типу Integer) у вигляді списку;
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

    //модуль (module) містить кілька сторінок (pages); власне дллки це лише сторінки;
    //модулі не мають дллок;
    //на SideBar на головній формі модулі відповідають групам (Groups),
    //а сторінки - ітемам (Items);
    //лише натистнувши ітем загружається та чи інша дллка;

    //інформація про сторінку
    ZPageInfoRec = record
        page_id:         Integer;
        page_name:       string;
        dll_name:        string;
        page_icon_name:  string;
        dll_handle:      THandle;
        page_form:       TForm;
    end;

    TPageInfoRecArray = array of ZPageInfoRec;

    //клас що управляє одним модулем (коментарії до окремих методів див. нижче)
    //містить в собі масив TPageInfoRecArray, тобто один модуль містить в собі
    //кілька сторінок, доступ до яких можна отримати через властивість Pages
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

    //клас що управляє усіма модулями та сторінками (коментарії до окремих методів див. нижче)
    //містить в собі масив модулів доступ до яких можна отримати через властивість Modules;
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

//коментарі див. нижче
procedure HandleError(const error_message: string);

//коментарі див. нижче
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

//генерує унікальні ідентифікатори від 1 до 2147483647, які призначаються
//модулям та сторінкам при зчитуванні xml (головне щоб вони були унікальні);
function GetID(): Integer;
begin
    id_count:=id_count + 1;
    Result:=id_count;
end;

//виводить повідомлення про помилку та записує в файл LOGS_DIRECTORY +
//ERRORS_LOG_FILE_NAME дату, час та текст помилки, що трапилась під час роботи
//програии (ядра);
//процедура запише в файл повідомлення тільки якщо файл LOGS_DIRECTORY +
//ERRORS_LOG_FILE_NAME існує;
//якщо під час виконання процедури трапиться помилка (що малоймовірно) програма
//зависне і не вигрузиться з пам"яті (тому що процедура викликається в блоках
//try ... except (за деякими вийнятками));
procedure HandleError(const error_message: string);
var
    f:      TextFile;

begin
//    Application.MessageBox(PChar(error_message),
//        PChar('ПОМИЛКА'), MB_ICONERROR);
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
//        Application.MessageBox(PChar('Помилка під час запису в файл ' +
//            ERRORS_LOG_FILE_NAME + '. (Процедура HandleError)'),
//            PChar('ПОМИЛКА'), MB_ICONERROR);
        GMessageBox(PChar('Помилка під час запису в файл ' +
            ERRORS_LOG_FILE_NAME + '. (Процедура HandleError)'),
            'OK');
    end;
end;//HandleError


//---------------------------------- ZModule -----------------------------------
//----------------------------------- begin ------------------------------------
//додає ідентифікатор в список та вертає його індекс;
//якщо aIsIDsUnique при створенні true і іденифікатор вже є у списку вертає -1;
function TIDManager.Add(const addedID: Integer): Integer;
begin
    if fIsIDsUnique then
    begin
        Result:=GetIDIndex(addedID);
        if Result < 0 then//ідентифікатора немає в списку
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

//параметр aIsIDsUnique вказує чи в списку будуть зберігатись унікальні ідентфікатори;
constructor TIDManager.Create(const aIsIDsUnique: Boolean);
begin
    inherited Create;
    data:=nil;
    fIsIDsUnique:=aIsIDsUnique;
end;

//видаляє ідентифікатор та вертає його індекс;
//якщо є кілька одинакових ідентифікаторів видаляє перший з них;
//якщо ідентфікатора немає в списку, то вертає -1;
function TIDManager.Delete(const deletingID: Integer): Integer;
var
    i:          Integer;

begin
    Result:=GetIDIndex(deletingID);
    if Result >= 0 then//список не пустий
    begin
        if Result <> pred(Length(data)) then//якщо не останній елемент
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

//вертає індекс ідентифікатора; якщо ідентифікатор не знайдений вертає -1;
//якщо є кілька однакових ідентифікаторів то вертає лише індекс першого;
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
        raise Exception.Create('Вихід за межі списку TIDManager');
    end;
end;

//вертає список ідентифікаторів у вигляді строки цифр розділених комами
//приклад: '1,2,7,15';
function TIDManager.GetListAsString: string;
var
    i:          Integer;

begin
    Result:='';
    for i:=0 to pred(Length(data)) do
    begin
        Result:=Result + IntToStr(data[i]);
        if i < pred(Length(data)) then//якщо це не останній символ додаємо кому
        begin
            Result:=Result + ',';
        end;
    end;
end;

//вертає максимаальний ідентифікатор; якщо список пустий вертає -1;
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

//вертає мінімальний ідентифікатор; якщо список пустий вертає -1;
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
//додає сторінку в кінець списку;
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

//НЕ ВИГРУЖАЄ ВІДПОВІДНІ ДЛЛКИ!
destructor ZModule.Destroy;
begin
    FModuleID:=ID_NIL_VALUE;
    FModuleName:='';
    pages_array:=nil;
    many_pages:=0;
    inherited;
end;

//знищує усі сторінки, тобто інформацію про них (НЕ ВИГРУЖАЄ ВІДПОВІДНІ ДЛЛКИ);
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

//вертає сторінку, яка відповідає page_index;
//якщо page_index виходить за межі списку генерується Exception;
function ZModule.GetPage(page_index: Integer): ZPageInfoRec;
begin
    if (page_index > (many_pages - 1))or(page_index < 0) then
    begin
        raise Exception.Create('Вихід за границю списку (функція ZModule.GetPage)');
    end
    else begin
        Result:=pages_array[page_index];
    end;
end;

//вертає кількість сторінок, що міститься в даному модулі;
function ZModule.PageCount: Integer;
begin
    Result:=many_pages;
end;

//ВАЖЛИВО! Не змінюйте вручну ідентифікатор модуля; це може призвести до
//некоректної роботи програми; ідентифікатори усіх модулів встановлюються автоматично;
procedure ZModule.SetModuleID(const value: Integer);
begin
    FModuleID:=value;
end;

procedure ZModule.SetModuleName(const value: string);
begin
    FModuleName:=value;
end;

//встановлює нову сторінку на місце тої що відповідає page_index;
//якщо page_index виходить за межі списку генерується Exception;
procedure ZModule.SetPage(page_index: Integer; const value: ZPageInfoRec);
begin
    if (page_index > (many_pages - 1))or(page_index < 0) then
    begin
        raise Exception.Create('Вихід за границю списку (функція ZModule.SetPage)');
    end
    else begin
        pages_array[page_index]:=value;
    end;
end;
//---------------------------------- ZModule -----------------------------------
//------------------------------------ end -------------------------------------



//------------------------------ ZModuleManager --------------------------------
//----------------------------------- begin ------------------------------------
//додає модуль в кінець списку;
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

//НЕ ВИГРУЖАЄ ВІДПОВІДНІ ДЛЛКИ!
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

//знищує усі модулі, тобто інформацію про них (НЕ ВИГРУЖАЄ ВІДПОВІДНІ ДЛЛКИ);
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

//вертає модуль, який відповідає module_index;
//якщо module_index виходить за межі списку генерується Exception;
function ZModuleManager.GetModule(module_index: Integer): ZModule;
begin
    if (module_index > (many_modules - 1))or(module_index < 0) then
    begin
        raise Exception.Create('Вихід за границю списку (функція ZModuleManager.GetModule)');
    end
    else begin
        Result:=modules_array[module_index];
    end;
end;

//вертає сторінку яка відповідає ідентифікатору a_page_id; пошук ведеться у всіх модулях,
//що забезпечується унікальністю усіх ідентифікаторів;
//якщо не знайдено сторінки, яка відповідоє a_page_id вертається пуста сторінка, де:
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
    with Result do//якщо нічого не знайдено вертаємо пусті значення
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

//загружає з xml файла інформацію про модулі та сторінки, а також автоматично
//присвоює усім модулям та сторінкам унікальні ідентифікатори;
//XML файл повинен відповідати встановленій структурі; ось приклад:
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
//	        <name>Адмінка</name>
//	    	<page>
//	    		<name>Користувачі</name>
//	    		<dllName>Users.dll</dllName>
//	    		<iconName>Users.bmp</iconName>
//	    	</page>
//	    	<page>
//	    		<name>Групи користувачів</name>
//	    		<dllName>Groups.dll</dllName>
//	    		<iconName>Groups.bmp</iconName>
//	    	</page>
//	    	<page>
//	    		<name>Допомога</name>
//	    		<dllName>AdmHelp.dll</dllName>
//	    		<iconName>AdmHelp.bmp</iconName>
//	    	</page>
//        </module>
//    </ListOfModules>
//</VelesAppInfo>
//
//інформація про модулі міститься в підрозділі <ListOfModules>...</ListOfModules>,
//а саме: ім"я модуля і список сторінок;
//в свою чергу підрозділ <page>...</page> містить ім"я сторінки, ім"я файла дллки,
//в якій міститься сторінка і ім"я графічного файла, який виводиться при загрузці
//на ітем, що відповідає даній сторінці;
//
//також a_XML_file_name може бути зашифрованим файлом конфігурації (файл з
//розширенням .xcr);
//файл розшифровується і зчитується як звичайний xml файл (докладніше див.
//проект xml_cript.exe);
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
                xml_parser.LoadFromStream(str_stream);//НЕ ПРАЦЮЄ - НЕ ЗНАЮ ЧОМУ
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
            raise Exception.Create('Неправильне розширення файла (ZModuleManager.LoadFromXML)');
        end;

        with xml_parser.Root.NamedItem['listOfPages'] do
        begin
                module:=zModule.Create;
                module.ModuleID:=1;
                module.ModuleName:='root';
            for i:=0 to Count - 1 do
            begin
                    //перевіряємо чи має SubItems[j] ім"я, якщо так то це <page>
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

//вертає модуль, який відповідає ідентифікатору a_module_id;
//якщо нічого не знайдено вертає nil;
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

//вертає кількість модулів;
function ZModuleManager.ModuleCount: Integer;
begin
    Result:=many_modules;
end;

//встановлює новий модуль на місце module_index;
//якщо module_index виходить за межі списку генерується Exception;
procedure ZModuleManager.SetModule(module_index: Integer;
  const value: ZModule);
var
    temp:           ZModule;

begin
    if (module_index > (many_modules - 1))or(module_index < 0) then
    begin
        raise Exception.Create('Вихід за границю списку (функція ZModuleManager.SetModule)');
    end
    else begin
        temp:=modules_array[module_index];
        modules_array[module_index]:=value;
        temp.Destroy;
    end;
end;

//встановлює нову сторінку нам місце тої, що відповідає a_page_id;
//якщо не знайдено сторінки, яка відповідоє a_page_id нічого не відбувається;
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
        GMessageBox(PChar('В роботі програми сталася помилка. Текст повідомлення: ' +
            err_mess), 'OK')
//        Application.MessageBox(PChar('В роботі програми сталася помилка. Текст повідомлення: ' +
//            err_mess), 'УВАГА', MB_ICONERROR or MB_OK);
    end
    else
    begin
        GMessageBox(PChar('В роботі програми сталася помилка. Текст повідомлення: ' +
            err_mess + '. Ім''я підпрограми: ' + proc_name), 'OK');
//        Application.MessageBox(PChar('В роботі програми сталася помилка. Текст повідомлення: ' +
//            err_mess + '. Ім''я підпрограми: ' + proc_name),
//            'УВАГА', MB_ICONERROR or MB_OK);
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
    //цей варіант в 5 разів швидше
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
