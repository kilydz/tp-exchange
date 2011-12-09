unit uplugin_h;
//  Name: uplugin_h.pas
//  Copyright: SoftWest group.
//  Author: Maxim Mihaluk
//  Date: 27.12.05
//  Description: ядро програми Veles.exe (заголовок для плагінів);
//               (нова версія - з динамічно формованими меню для плагінів та
//                трейем).

interface

uses
    Menus,          //TMainMenu, TMenuItem
    ECXMLParser,    //TECXMLParser
    Classes,        //TNotifyEvent
    Graphics,       //TBitmap
//    Dialogs,        //ShowMessage
    kernel_h,        //WAY_IMAGES
    utils_h,        //ID_NIL_VALUE
    SysUtils;       //ExtractFileExt

type
    //інформація про плагін
    ZPluginInfoRec = record
        plugin_id:      Integer;
        plugin_name:    string;
        dll_name:       string;
        func_name:      string;
    end;

    //мінімальний набір методів для роботи з плагінами (при потребі можна додати інші)
    ZPluginManager = class(TObject)
    private
        f_menu:         TMainMenu;
        f_on_click:     TNotifyEvent;
        f_XML_parser:   TECXMLParser;
        plugins:        array of ZPluginInfoRec;
        procedure fAdd(const new_plugin: ZPluginInfoRec);
        procedure fCreateMenus(a_XML_item: TXMLItem; a_menu_item: TMenuItem);//рекурсивна процедура
        procedure fLoadMenuIcon(a_menu_item: TMenuItem; const a_bmp_file_name: string);
    public
        constructor Create(const a_XML_file_name: string; a_menu: TMainMenu;
            on_click_handler: TNotifyEvent);
        destructor Destroy; override;
        function Count: Integer;
        function PluginByID(const a_plugin_id: Integer): ZPluginInfoRec;
    end;

implementation
uses main, crypt_h;//veles_info;

var
    id_count:            Integer = 0;

//генерує унікальні ідентифікатори від 1 до 2147483647, які призначаються
//плагінам при зчитуванні xml (головне щоб вони були унікальні);
function GetID(): Integer;
begin
    id_count:=id_count + 1;
    Result:=id_count;
end;

{ ZPluginManager }

function ZPluginManager.Count: Integer;
begin
    Result:=Length(plugins);
end;

procedure ZPluginManager.fAdd(const new_plugin: ZPluginInfoRec);
begin
    SetLength(plugins, Length(plugins) + 1);
    plugins[Length(plugins) - 1]:=new_plugin;
end;

//конструктор створює об'єкт, а також, загружає із xml-файла дані про пункти
//меню і створює їх; on_click_handler - обробник події OnClick;
//також a_XML_file_name може бути зашифрованим файлом конфігурації (файл з
//розширенням .xcr);
//файл розшифровується і зчитується як звичайний xml файл (докладніше див.
//проект xml_cript.exe);
constructor ZPluginManager.Create(const a_XML_file_name: string;
  a_menu: TMainMenu; on_click_handler: TNotifyEvent);
var
    i:              Integer;
    menu_item:      TMenuItem;
    file_ext:       string;
//    str_stream:     TStringStream;
    temp_file:      string;

begin
    f_on_click:=on_click_handler;
    f_menu:=a_menu;
    f_XML_parser:=TECXMLParser.Create(nil);
    try
        file_ext:=ExtractFileExt(a_XML_file_name);
        if UpperCase(file_ext) = xml_EXTENTION then
        begin
            f_XML_parser.LoadFromFile(a_XML_file_name);
        end
        else if UpperCase(file_ext) = CRYPT_EXTENTION then
        begin
{
            str_stream:=TStringStream.Create('');
            try
                LoadCryptedFileToStream(a_XML_file_name, str_stream);
                f_XML_parser.LoadFromStream(str_stream);//НЕ ПРАЦЮЄ - НЕ ЗНАЮ ЧОМУ
            finally
                str_stream.Free;
            end;
}
            try
                temp_file:=UncryptFile(a_XML_file_name);
                f_XML_parser.LoadFromFile(temp_file);
            finally
                DeleteFile(temp_file);
            end;
        end
        else begin
            raise Exception.Create('Неправильне розширення файла (ZPluginManager.Create)');
        end;

        with f_XML_parser.Root.NamedItem['listOfMenus'] do
        begin
            for i:=0 to Count - 1 do//перебираємо кореневі пункти меню (такі як Довідники)
            begin
                menu_item:=TMenuItem.Create(f_menu);
                menu_item.Caption:=SubItems[i].NamedItem['name'].Text;
                f_menu.Items.Add(menu_item);
                fCreateMenus(SubItems[i], menu_item);
            end;
        end;
    finally
        f_XML_parser.Free;
    end;
end;

destructor ZPluginManager.Destroy;
begin
    plugins:=nil;
    inherited;
end;

procedure ZPluginManager.fCreateMenus(a_XML_item: TXMLItem; a_menu_item: TMenuItem);
var
    i:          Integer;
    menu_item:  TMenuItem;
    plugin:     ZPluginInfoRec;

begin
    for i:=0 to a_XML_item.Count - 1 do
    begin
        if a_XML_item.SubItems[i].Name = 'menuItem' then
        begin
            menu_item:=TMenuItem.Create(f_menu);
            menu_item.Caption:=a_XML_item.SubItems[i].NamedItem['name'].Text;
            a_menu_item.Add(menu_item);
            if a_XML_item.SubItems[i].NamedItem['dllName'].Text <> '' then
            begin//якщо пункт меню кінцевий додаємо в список плагін
                plugin.plugin_id:=GetID;
                plugin.plugin_name:=a_XML_item.SubItems[i].NamedItem['name'].Text;
                plugin.dll_name:=a_XML_item.SubItems[i].NamedItem['dllName'].Text;
                plugin.func_name:=a_XML_item.SubItems[i].NamedItem['funcName'].Text;
                fAdd(plugin);
                menu_item.OnClick:=f_on_click;
                menu_item.Tag:=plugin.plugin_id;
                fLoadMenuIcon(menu_item, a_XML_item.SubItems[i].NamedItem['iconName'].Text);
            end
            else begin//якщо пунут меню проміжний ідемо далі
                fCreateMenus(a_XML_item.SubItems[i], menu_item);
            end;
        end;
    end;//for
end;

function ZPluginManager.PluginByID(const a_plugin_id: Integer): ZPluginInfoRec;
var
    i:  Integer;

begin
    //якщо нічого не знайдено вертає nil результат
    Result.plugin_id:=ID_NIL_VALUE;
    Result.plugin_name:='';
    Result.dll_name:='';
    Result.func_name:='';

    for i:=0 to Length(plugins) - 1 do
    begin
        if plugins[i].plugin_id = a_plugin_id then
            Result:=plugins[i];
    end;
end;

procedure ZPluginManager.fLoadMenuIcon(a_menu_item: TMenuItem;
  const a_bmp_file_name: string);
var
    bitmap:             TBitmap;
    skip_img_adding:    Boolean;

begin
    bitmap:=TBitmap.Create;
    try
        skip_img_adding:=false;
        try
            bitmap.LoadFromFile(veles_info.root_way + WAY_IMAGES + a_bmp_file_name);
        except
            //якщо якась проблема просто не буде іконки у пункта меню
            skip_img_adding:=true;
        end;
        if not skip_img_adding then
            a_menu_item.ImageIndex:=f_menu.Images.Add(bitmap, bitmap);
    finally
        bitmap.Free;
    end;
end;

end.
