unit uusers;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, dxExEdtr, dxCntner, Menus, IBCustomDataSet, IBUpdateSQL, IBSQL,
  IBDatabase, DB, IBQuery, ImgList, ExtCtrls, uZFilter, dxTL, dxDBCtrl,
  dxDBGrid, ComCtrls, ToolWin, uZToolBar, uZControlBar, secure_h,
  kernel_h, utils_h, StdCtrls, dxEditor, dxEdLib, etalon_dic,
  dxDBTLCl, dxGrClms, user_h, uZToolButton, genstor_h, IBServices,
  Zutils_h;

type
  Tfusers = class(Tfetalon_dic)
    q_detaileDESCRIPTION: TMemoField;
    q_detaileID: TIntegerField;
    q_detaileNAME: TIBStringField;
    q_detailePRICE: TFloatField;
    Label1: TLabel;
    st_full_name: TStaticText;
    Label2: TLabel;
    st_login: TStaticText;
    Label3: TLabel;
    st_id: TStaticText;
    q_dicOID: TIntegerField;
    q_dicOFULL_NAME: TIBStringField;
    q_dicOLOGIN: TIBStringField;
    q_dicOKEYWORD: TIBStringField;
    q_dicORIGHTS_GRP_ID: TIntegerField;
    q_dicORIGHTS_GRP_NAME: TIBStringField;
    q_dicONICK: TIBStringField;
    g_dicOID: TdxDBGridMaskColumn;
    g_dicOFULL_NAME: TdxDBGridMaskColumn;
    g_dicOLOGIN: TdxDBGridMaskColumn;
    g_dicORIGHTS_GRP_NAME: TdxDBGridMaskColumn;
    g_dicONICK: TdxDBGridMaskColumn;
    q_dicOUSER_STATE: TIntegerField;
    st_nick: TStaticText;
    Label4: TLabel;
    st_state: TStaticText;
    Label5: TLabel;
    img_state: TImage;
    secure_service: TIBSecurityService;
    mi_activate: TMenuItem;
    img_grid: TImageList;
    g_dicOUSER_STATE: TdxDBGridCheckColumn;
    procedure FormDestroy(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure tool_buttonClick(Sender: TObject); override;
    procedure mi_Click(Sender: TObject);
    procedure q_dicCalcFields(DataSet: TDataSet);
    procedure popup_menu_dicPopup(Sender: TObject);
  private
    { Private declarations }
  public
    users: TStringList;


    procedure InitInfo; override;
    procedure RefreshDetaile; override;
    procedure RefreshDic; override;
  end;

var
  fusers: Tfusers;

function ShowPage(var a_veles_info: ZVelesInfoRec): Longint; stdcall;
procedure FreePage(a_form_ref: Longint); stdcall;

implementation

{$R *.dfm}
{$R users_bitmaps.res} //тут малюнки (активований, деактивований),
                       //які підгружаються на вкладку Детально

//параметр a_veles_info містить інформацію про програму (див. veles_h.pas);
//поля app_handle, control_pointers використовуються для створення форми
//модуля та прив"язки до головної форми програми;
//значення яке вертається це перетворений в Longint вказівник на форму
//модуля;
//якщо сторінка ще не загружена то загружає (попередньо створивши її) та
//показує; якщо сторінка вже загружена просто показує її;
function ShowPage(var a_veles_info: ZVelesInfoRec): Longint; stdcall;
begin
    Result:=Longint(fusers);
    if not HasUserAccessEx(a_veles_info, ACCESS_TO_USERS_DIC) then
    begin
        TPanel(a_veles_info.control_pointers.caption_ptr).Visible:=true;
        Exit;
    end;

    if fusers = nil then
    begin
        fusers := Tfusers.Create(nil);
        fusers.prm := a_veles_info;
        fusers.InitInfo;
    end;
    fusers.panel.Visible := true;
end;//ShowPage

//знищує форму модуля; параметр a_form_ref це вказівник на форму модуля
//отриманий процедурою TShowPage; після знищення форми модуля необхідно
//вигрузити дллку (хоча, звичайно, не обов"язково);
procedure FreePage(a_form_ref: Longint); stdcall;
begin
    if fusers <> nil then
    begin
        fusers.Free;
    end;
end;

{ Tfusers }

procedure Tfusers.InitInfo;
begin
    users := TStringList.Create;

    secure_service.ServerName := prm.server_ip;
    secure_service.Protocol := TProtocol(TCP);
    secure_service.Params.Clear;
    secure_service.Params.Values['user_name'] := 'SYSDBA';
    secure_service.Params.Values['password'] := prm.SYSDBA_password;

    sql_refresh_document:='SELECT oid, ofull_name, ologin, ' +
        'orights_grp_name, onick FROM pa_user_view(:idocument_id)';
    sql_delete_document:='SELECT ocount, ocaption FROM pa_user_del(:idocument_id)';

    inherited;
end;

procedure Tfusers.FormDestroy(Sender: TObject);
begin
  inherited;
  if users <> nil then
    users.Free;
end;

procedure Tfusers.q_dicCalcFields(DataSet: TDataSet);
var i: integer;
begin
    inherited;

    i := users.IndexOf(q_dic.FieldByName('ologin').AsString);
    if i < 0 then
      q_dic.FieldByName('ouser_state').AsInteger := 0
    else
      q_dic.FieldByName('ouser_state').AsInteger := 1;
end;

procedure Tfusers.RefreshDic;
var i: integer;
begin

    secure_service.Active := true;
    secure_service.DisplayUsers();
    users.Clear;
    for i := 0 to secure_service.UserInfoCount - 1 do
      users.Add(secure_service.UserInfo[i].UserName);
    secure_service.Active := false;

    inherited;

end;

procedure Tfusers.RefreshDetaile;
begin
    inherited;
    if base.Connected and (not q_dic.IsEmpty) then
    begin
        st_id.Caption:=q_dic.FieldByName('oid').AsString;
        st_full_name.Caption:=q_dic.FieldByName('ofull_name').AsString;
        st_login.Caption:=q_dic.FieldByName('ologin').AsString;
        st_nick.Caption:=q_dic.FieldByName('onick').AsString;
        if q_dic.FieldByName('ouser_state').AsInteger = 1 then
            st_state.Caption:='Активований'
        else
            st_state.Caption:='Деактивований';
        if q_dic.FieldByName('ouser_state').AsInteger = 0 then
            img_state.Picture.Bitmap.LoadFromResourceName(HInstance, 'DEACTIVATE')
        else
            img_state.Picture.Bitmap.LoadFromResourceName(HInstance, 'ACTIVATE')
    end;
end;

procedure Tfusers.FormCreate(Sender: TObject);
begin
    inherited;
    //ці контроли не використовуються
    //Splitter1.Visible:=false;
    g_detaile.Visible:=false;
end;

procedure Tfusers.tool_buttonClick(Sender: TObject);
var
    button:           ZToolButton;
    resulted:         ZUserDlgResulted;
    lpUserDialog:     ZUserDialogFunc;
    lib_handle:       THandle;
    user_id:          Integer;

begin
    button:=zToolButton(Sender);

    if button = bt_del then
    begin
        if not HasUserAccessEx(prm, ACCESS_TO_DEL_USER) then
            Exit;

        if q_dic.FieldByName('ouser_state').AsInteger = 1 then
        begin
            GMessageBox('Спочатку необхідно деактивувати користувача', 'OK');
            Exit;
        end;
    end;

    inherited tool_buttonClick(Sender);

    if (button = bt_ins)or(button = bt_upd) then
    begin
        lib_handle:=LoadLibrary('user.dll');
        if lib_handle > 32 then
        begin
            @lpUserDialog:=GetProcAddress(lib_handle, 'UserDialog');
            if @lpUserDialog <> nil then
            begin
                if button = bt_ins then
                    user_id:=0
                else
                    user_id:=q_dic.FieldByName(g_dic.KeyField).AsInteger;
                //по цьому полю в діалозі буде визначатись необхідність модифікації
                //користувача в базі isc
                resulted.state:=q_dic.FieldByName('ouser_state').AsInteger;
                if lpUserDialog(user_id, @resulted, prm) > 0 then
                begin
                    if button = bt_ins then q_dic.Insert else q_dic.Edit;
                    q_dic.FieldByName(g_dic.KeyField).AsInteger:=resulted.id;
                    q_dic.Post;
                    RefreshRecord;
                end;
            end;
            FreeLibrary(lib_handle);
        end;
    end;//if (button = bt_ins)or(button = bt_upd)
end;//Tfusers.tool_buttonClick

procedure Tfusers.mi_Click(Sender: TObject);
var
    menu_item:          TMenuItem;

begin
    menu_item:=TMenuItem(Sender);
    if (menu_item = mi_export_excel) then
    begin
        if not HasUserAccessEx(prm, ACCESS_TO_EXPORT_USERS) then
            Exit;
    end;
    inherited;
    if menu_item = mi_activate then
    begin
        if q_dic.FieldByName('ouser_state').AsInteger = 1 then//юзер активований
        begin
            if not HasUserAccessEx(prm, ACCESS_TO_DEACTIVATE_USER) then
                Exit;
            if (q_dic.FieldByName('oid').AsInteger < 100)or
               (q_dic.FieldByName('ologin').AsString = 'SYSDBA') then
            begin
                GMessageBox('Не можна деактивувати службового користувача', 'OK');
                Exit;
            end;
            secure_service.Active := true;
            secure_service.UserName := q_dic.FieldByName('ologin').AsString;
            secure_service.DeleteUser;
            secure_service.Active := false;
            users.Delete(users.IndexOf(q_dic.FieldByName('ologin').AsString));
        end
        else begin//юзер деактивований
            if not HasUserAccessEx(prm, ACCESS_TO_ACTIVATE_USER) then
                Exit;
            secure_service.Active := true;
            secure_service.UserName := q_dic.FieldByName('ologin').AsString;
            secure_service.Password := q_dic.FieldByName('okeyword').AsString;
            secure_service.FirstName := '';
            secure_service.MiddleName := '';
            secure_service.LastName := '';
            secure_service.SecurityAction := ActionAddUser;
            secure_service.AddUser;
            secure_service.Active := false;
            users.Add(q_dic.FieldByName('ologin').AsString);
        end;
        RefreshRecord;
    end;//if menu_item = mi_activate
end;

procedure Tfusers.popup_menu_dicPopup(Sender: TObject);
begin
    inherited;
    if q_dic.FieldByName('ouser_state').AsInteger = 1 then
    begin
    //    mi_activate.ImageIndex:=15;
        mi_activate.Caption:='Деактивувати користувача';
    end
    else begin
     //   mi_activate.ImageIndex:=14;
        mi_activate.Caption:='Активувати користувача';
    end;
end;

end.
