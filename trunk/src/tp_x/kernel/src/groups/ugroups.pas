unit ugroups;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, dxExEdtr, dxCntner, Menus, IBCustomDataSet, IBUpdateSQL, IBSQL,
  IBDatabase, DB, IBQuery, ImgList, ExtCtrls, dxTL, dxDBCtrl,
  dxDBGrid, ComCtrls, ToolWin, uZToolBar, uZControlBar, secure_h,
  kernel_h, utils_h, StdCtrls, dxEditor, dxEdLib, etalon_dic, dxDBTL,
  group_h, uZToolButton, uZFilter, genstor_h, zutils_h;

type
  Tfgroups = class(Tfetalon_dic)
    g_dicOID: TdxDBGridMaskColumn;
    g_dicONAME: TdxDBGridMaskColumn;
    up_access: TIBUpdateSQL;
    ds_access: TDataSource;
    q_access: TIBQuery;
    tr_access: TIBTransaction;
    q_accessO_ACCESS_ID: TIntegerField;
    q_accessO_NAME: TIBStringField;
    q_accessO_PARENT: TIntegerField;
    q_accessO_IMAGE_INDEX: TIntegerField;
    q_dicOID: TIntegerField;
    q_dicONAME: TIBStringField;
    img_list_tree: TImageList;
    popup_menu_access: TPopupMenu;
    mi_access_one: TMenuItem;
    mi_access_all: TMenuItem;
    N3: TMenuItem;
    mi_expand: TMenuItem;
    mi_collapse: TMenuItem;
    st_id: TStaticText;
    Label1: TLabel;
    Label2: TLabel;
    st_name: TStaticText;
    Label3: TLabel;
    q_detaileOID: TIntegerField;
    q_detaileOFULL_NAME: TIBStringField;
    q_detaileOLOGIN: TIBStringField;
    q_detaileORIGHTS_GRP_NAME: TIBStringField;
    q_detaileONICK: TIBStringField;
    g_detaileOID: TdxDBGridMaskColumn;
    g_detaileOFULL_NAME: TdxDBGridMaskColumn;
    g_detaileOLOGIN: TdxDBGridMaskColumn;
    g_detaileORIGHTS_GRP_NAME: TdxDBGridMaskColumn;
    g_detaileONICK: TdxDBGridMaskColumn;
    Splitter2: TSplitter;
    tree_list_access: TdxDBTreeList;
    tree_list_accessO_NAME: TdxDBTreeListMaskColumn;
    procedure FormCreate(Sender: TObject);
    procedure tool_buttonClick(Sender: TObject); override;
    procedure q_dicAfterScroll(DataSet: TDataSet);
    procedure popup_menu_accessPopup(Sender: TObject);
    procedure mi_Click(Sender: TObject);
    procedure tree_list_accessClick(Sender: TObject);
    procedure tree_list_accessDblClick(Sender: TObject);
    procedure tree_list_accessKeyPress(Sender: TObject; var Key: Char);
  private
    { Private declarations }
    access_id: array of Integer;
    parent_id: array of Integer;
    function GetUserGroupID(const a_user_id: Integer): Integer;
    function IsAccessGranded(const a_access_id, a_rights_grp_id: Integer): Boolean;
    function AllowModifyAccess: Boolean;
    procedure FillArrays;
    procedure HandleAllAccess(const a_access_id, a_rights_grp_id: Integer);
    procedure HandleChildAccess(const parent_is_granded: Boolean; const a_child_id: Integer);
    procedure HandleOneAccess(const a_access_id, a_rights_grp_id: Integer);
  public
    { Public declarations }
    procedure InitInfo; override;
    procedure RefreshAccess(const right_grp_id: Integer);
    procedure RefreshDic; override;
    procedure RefreshDetaile; override;
    procedure RefreshUsers(const right_grp_id: Integer);
  end;

var
  fgroups: Tfgroups;

function ShowPage(var a_veles_info: ZVelesInfoRec): Longint; stdcall;
procedure FreePage(a_form_ref: Longint); stdcall;

implementation

{$R *.dfm}

//параметр a_veles_info містить інформацію про програму (див. veles_h.pas);
//поля app_handle, control_pointers використовуються для створення форми
//модуля та прив"язки до головної форми програми;
//значення яке вертається це перетворений в Longint вказівник на форму
//модуля;
//якщо сторінка ще не загружена то загружає (попередньо створивши її) та
//показує; якщо сторінка вже загружена просто показує її;
function ShowPage(var a_veles_info: ZVelesInfoRec): Longint; stdcall;
begin
    Result:=Longint(fgroups);
    if not HasUserAccessEx(a_veles_info, ACCESS_TO_GROUPS_DIC) then
    begin
        TPanel(a_veles_info.control_pointers.caption_ptr).Visible:=true;
        Exit;
    end;

    if fgroups = nil then
    begin
        fgroups := Tfgroups.Create(nil);
        fgroups.prm := a_veles_info;
        fgroups.InitInfo;
    end;
    fgroups.panel.Visible := true;
end;//ShowPage

//знищує форму модуля; параметр a_form_ref це вказівник на форму модуля
//отриманий процедурою TShowPage; після знищення форми модуля необхідно
//вигрузити дллку (хоча, звичайно, не обов"язково);
procedure FreePage(a_form_ref: Longint); stdcall;
begin
    if fgroups <> nil then
    begin
        fgroups.Free;
    end;
end;

{ Tfgroups }

procedure Tfgroups.InitInfo;
begin
    sql_refresh_document:='SELECT oid, oname FROM pa_group_view(:idocument_id)';
    sql_delete_document:='SELECT ocount, ocaption FROM pa_group_del(:idocument_id)';
    is_new_project := False;
    inherited;
end;

procedure Tfgroups.RefreshAccess(const right_grp_id: Integer);
begin
    try
        if base.Connected then
        begin
            if tr_access.InTransaction then tr_access.Commit;
            tr_access.StartTransaction;
            if q_access.Active then q_access.Close;
            q_access.ParamByName('i_rights_grp_id').AsInteger:=right_grp_id;
            q_access.Open;
            tr_access.CommitRetaining;
        end;
    except
        on E: Exception do
        begin
            if tr_access.InTransaction then tr_access.Rollback;
            ErrorDialog(E.Message, 'Tfgroups.RefreshAccess');
        end;
    end;
end;

procedure Tfgroups.q_dicAfterScroll(DataSet: TDataSet);
begin
    inherited;
    RefreshAccess(q_dic.FieldByName(g_dic.KeyField).AsInteger);
    if tree_list_access.TopNode <> nil then
    begin
        tree_list_access.TopNode.Expand(false);
    end;
end;

procedure Tfgroups.RefreshDic;
begin
    inherited;
    RefreshAccess(q_dic.FieldByName(g_dic.KeyField).AsInteger);
    if tree_list_access.TopNode <> nil then
    begin
        tree_list_access.TopNode.Expand(false);
    end;
end;

procedure Tfgroups.FormCreate(Sender: TObject);
begin
    inherited;
    //ці контроли не використовуються
    //Splitter1.Visible:=false;
end;

procedure Tfgroups.tool_buttonClick(Sender: TObject);
var
    button:           ZToolButton;
    resulted:         ZGroupDlgResulted;
    lpGroupDialog:    ZGroupDialogFunc;
    lib_handle:       THandle;
    group_id:         Integer;

begin
    button:=zToolButton(Sender);

    if button = bt_del then
        if not HasUserAccessEx(prm, ACCESS_TO_DEL_GROUP) then
            Exit;

    inherited tool_buttonClick(Sender);

    if (button = bt_upd)and(q_dic.FieldByName(g_dic.KeyField).AsInteger < SYSTEM_GROUPS_LIMIT) then
    begin//перевірка на видалення службової групи здійснюється в базі (pa_group_del)
        GMessageBox('Не можна редагувати службову групу', 'OK');
        Exit;
    end;

    if (button = bt_ins)or(button = bt_upd) then
    begin
        lib_handle:=LoadLibrary('group.dll');
        if lib_handle > 32 then
        begin
            @lpGroupDialog:=GetProcAddress(lib_handle, 'GroupDialog');
            if @lpGroupDialog <> nil then
            begin
                if button = bt_ins then
                    group_id:=0
                else
                    group_id:=q_dic.FieldByName(g_dic.KeyField).AsInteger;
                if lpGroupDialog(group_id, @resulted, prm) > 0 then
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
end;//Tfgroups.tool_buttonClick

procedure Tfgroups.popup_menu_accessPopup(Sender: TObject);
var
    node:       TdxTreeListNode;

begin
    inherited;
    node:=tree_list_access.FocusedNode;
    if node.HasChildren then
        mi_access_all.Enabled:=true
    else
        mi_access_all.Enabled:=false;
    if node.ImageIndex = 0 then
    begin
        mi_access_all.ImageIndex:=17;
        mi_access_one.ImageIndex:=15;
        mi_access_one.Caption:='Надати право';
        mi_access_all.Caption:='Надати усі права';
    end
    else begin
        mi_access_all.ImageIndex:=16;
        mi_access_one.ImageIndex:=14;
        mi_access_one.Caption:='Забрати право';
        mi_access_all.Caption:='Забрати усі права';
    end;
end;

procedure Tfgroups.mi_Click(Sender: TObject);
var
    menu_item:          TMenuItem;

begin
    inherited;
    menu_item:=TMenuItem(Sender);

    if (menu_item = mi_access_one)or(menu_item = mi_access_all) then
    begin
        if GetUserGroupID(prm.user_id) <> ADMIN_GROUP_ID then
        begin
            GMessageBox('Надавати або забирати права можуть тільки адміністратори', 'OK');
            Exit;
        end;
        if not AllowModifyAccess then Exit;
    end;

    if menu_item = mi_access_one then
    begin
        HandleOneAccess(q_access.FieldByName(tree_list_access.KeyField).AsInteger,
            q_dic.FieldByName(g_dic.KeyField).AsInteger);
    end
    else if menu_item = mi_access_all then
    begin
        HandleAllAccess(q_access.FieldByName(tree_list_access.KeyField).AsInteger,
            q_dic.FieldByName(g_dic.KeyField).AsInteger);
    end
    else if menu_item = mi_collapse then
    begin
        tree_list_access.FullCollapse;
    end
    else if menu_item = mi_expand then
    begin
        tree_list_access.FullExpand;
    end;
end;

//вертає ідентифікатор групи до якої належить user_id;
//якщо user_id невідомий (тобто не належить до жодної групи) вертає -1;
function Tfgroups.GetUserGroupID(const a_user_id: Integer): Integer;
begin
    Result:=-1;
    try
        if tr_R.InTransaction then tr_R.Commit;
        tr_R.StartTransaction;
        q_R.SQL.Text:='SELECT rights_grp_id FROM t_users WHERE user_id = :iuser_id';
        q_R.ParamByName('iuser_id').AsInteger:=a_user_id;
        q_R.ExecQuery;
        if not q_R.FieldByName('rights_grp_id').IsNull then
        begin
            Result:=q_R.FieldByName('rights_grp_id').AsInteger;
        end;
        tr_R.Commit;
    except
        on E: Exception do
        begin
            if tr_R.InTransaction then tr_R.Rollback;
            ErrorDialog(E.Message, 'Tfgroups.GetUserGroupID');
        end;
    end;
end;

//надає (якщо його не було надано) чи забирає (якщо воно було надано
//раніше) право у групи користувачів;
//ВАЖЛИВО! Процедура не перевіряє чи можна тій чи іншій групі надавати або
//забирати права (тобто Гостям і Адміністраторам відповідно);
procedure Tfgroups.HandleOneAccess(const a_access_id, a_rights_grp_id: Integer);
begin
    try
        if tr_W.InTransaction then tr_W.Commit;
        tr_W.StartTransaction;
        if IsAccessGranded(a_access_id, a_rights_grp_id) then
        begin
            q_W.SQL.Text:='DELETE FROM t_rights WHERE rights_grp_id = :irights_grp_id' +
                ' AND access_id = :iaccess_id';
        end
        else begin
            q_W.SQL.Text:='INSERT INTO t_rights(access_id, rights_grp_id)' +
                                   ' VALUES(:iaccess_id, :irights_grp_id)';
        end;
        q_W.ParamByName('iaccess_id').AsInteger:=a_access_id;
        q_W.ParamByName('irights_grp_id').AsInteger:=a_rights_grp_id;
        q_W.ExecQuery;
        tr_W.Commit;

        q_access.Edit;
        q_access.FieldByName('o_image_index').AsInteger:=abs(q_access.FieldByName('o_image_index').AsInteger - 1);
        q_access.Post;
    except
        on E: Exception do
        begin
            if tr_W.InTransaction then tr_W.Rollback;
            ErrorDialog(E.Message, 'Tfgroups.HandleOneAccess');
        end;
    end;
end;//Tfgroups.HandleOneAccess

//true якщо право a_access_id надане групі a_rights_grp_id, інакше false;
//можна було б наявність права перевіряти і так:
//    if q_access.FieldByName('o_image_index').AsInteger = 1 then ...
//але функцією надійніше (дані вигрібаються з бази)
function Tfgroups.IsAccessGranded(const a_access_id,
  a_rights_grp_id: Integer): Boolean;
begin
    Result:=false;
    try
        if tr_R.InTransaction then tr_R.Commit;
        tr_R.StartTransaction;
        q_R.SQL.Text:='SELECT o_result FROM p_is_access_granded(:iaccess_id, :irights_grp_id)';
        q_R.ParamByName('iaccess_id').AsInteger:=a_access_id;
        q_R.ParamByName('irights_grp_id').AsInteger:=a_rights_grp_id;
        q_R.ExecQuery;
        if q_R.FieldByName('o_result').AsInteger > 0 then
        begin
            Result:=true;
        end;
        tr_R.Commit;
    except
        on E: Exception do
        begin
            if tr_R.InTransaction then tr_R.Rollback;
            ErrorDialog(E.Message, 'Tfgroups.IsAccessGranded');
        end;
    end;
end;

//функція перевіряє чи можна у поточної групи забрати або надати право
//(Адміністратори та Гості відповідно);
//вертає true якщо право можна надавати або забирати, інакше false;
//також виводить відповідне повідомлення;
function Tfgroups.AllowModifyAccess: Boolean;
var
    answer:         Integer;
    rights_grp_id:  Integer;

begin
    Result:=true;
    rights_grp_id:=q_dic.FieldByName(g_dic.KeyField).AsInteger;
    if IsAccessGranded(q_access.FieldByName(tree_list_access.KeyField).AsInteger,
        rights_grp_id)
    then
    begin
        if rights_grp_id = ADMIN_GROUP_ID then
        begin
            GMessageBox('Не можна забирати права в групи Адміністратори', 'OK');
            Result:=false;
        end
        else if rights_grp_id = GUEST_GROUP_ID then
        begin
            answer:=GMessageBox(PChar('Ви впенені що хочете забрати права у групи Гості?' +
                #13 + 'Потім додати їх буде неможливо'), 'Так|Ні');
            if answer = 2 then Result:=false;
        end;
    end
    else begin
        if rights_grp_id = GUEST_GROUP_ID then
        begin
            GMessageBox('Не можна додавати права групі Гості', 'OK');
            Result:=false;
        end;
    end;
end;//Tfgroups.AllowModifyAccess

//процедура надає або забирає усі права кореневого вузла та його нащадків
//залежно від того чи надане право кореневому вузлу, тобто якщо вузлу надане
//право забере у всіх, ненадане - дасть усім;
//ВАЖЛИВО! Процедура не перевіряє чи можна тій чи іншій групі надавати або
//забирати права (тобто Гостям і Адміністраторам відповідно);
procedure Tfgroups.HandleAllAccess(const a_access_id,
  a_rights_grp_id: Integer);

//рекурсивна процедура, яка вносить у список a_childs усіх дітей (потомків)
//права (вузла) з ідентфікатором a_cur_access_id;
//параметри a_access_id та a_parent_id це одинакові, за кількістю елементів,
//динамічні масиви, які містять (див. проц. FillArrays) відповідні поля з
//таблиці T_ACCESS (масиви використовуються для зручності);
procedure GetAllChilds(a_cur_access_id: Integer; a_access_id, a_parent_id: array of Integer;
                       a_childs: TIDManager);
var
    i:          Integer;

begin
    for i:=0 to Length(a_access_id) - 1 do
    begin
        if a_parent_id[i] = a_cur_access_id then
        begin
            a_childs.Add(a_access_id[i]);
            GetAllChilds(a_access_id[i], a_access_id, a_parent_id, a_childs);
        end;
    end;
end;

var
    is_granded:         Boolean;
    i:                  Integer;
    childs:             TIDManager;
    cur_access_id:      Integer;

begin
    is_granded:=IsAccessGranded(a_access_id, a_rights_grp_id);

    //обробляємо кореневий вузол
    HandleOneAccess(q_access.FieldByName(tree_list_access.KeyField).AsInteger,
        q_dic.FieldByName(g_dic.KeyField).AsInteger);

    cur_access_id:=q_access.FieldByName('o_access_id').AsInteger;//для зручності
    childs:=TIDManager.Create(true);//в цьому списку будуть зберігатись усі діти (потомки)
    //права (вузла) з ідентифікатором cur_access_id (тобто тим яке обробляється)
    try
        FillArrays;
        GetAllChilds(cur_access_id, access_id, parent_id, childs);

        //перебираємо усіх дітей (потомків) права (вузла) cur_access_id
        for i:=0 to childs.Count - 1 do
        begin
            HandleChildAccess(is_granded, childs[i]);
        end;

        q_access.Locate(tree_list_access.KeyField, cur_access_id, [])
    finally
        access_id:=nil;
        parent_id:=nil;
        childs.Destroy;
    end;
end;//Tfgroups.HandleAllAccess

//заповнює масиви access_id та parent_id відповідно полями access_id та
//parent; використовується в процедурі HandleAllAccess;
procedure Tfgroups.FillArrays;
var
    i:          Integer;

begin
    try
        if tr_R.InTransaction then tr_R.Commit;
        tr_R.StartTransaction;
        q_R.SQL.Text:='SELECT access_id, parent FROM t_access ORDER BY access_id';
        q_R.ExecQuery;
        i:=0;
        while not q_R.Eof do
        begin
            //SetLength(access_id, Length(access_id) + 1);
            //SetLength(parent_id, Length(parent_id) + 1);
            SetLength(access_id, i + 1);
            SetLength(parent_id, i + 1);
            access_id[i]:=q_R.FieldByName('access_id').AsInteger;
            parent_id[i]:=q_R.FieldByName('parent').AsInteger;
            //i:=i + 1;
            Inc(i);
            q_R.Next;
        end;
        tr_R.Commit;
    except
        on E: Exception do
        begin
            if tr_R.InTransaction then tr_R.Rollback;
            ErrorDialog(E.Message, 'Tfgroups.FillArrays');
        end;
    end;
end;//Tfgroups.FillArrays

//процедура обробляє (надає чи забирає) право-нащадок певного кореневого права;
//використовується у процедурі HandleAllAccess;
procedure Tfgroups.HandleChildAccess(const parent_is_granded: Boolean;
    const a_child_id: Integer);
var
    child_is_granded:   Boolean;
    query:              string;

begin
    child_is_granded:=IsAccessGranded(a_child_id, q_dic.FieldByName(g_dic.KeyField).AsInteger);

    if parent_is_granded then//треба забрати право
    begin
        if child_is_granded then
            query:='DELETE FROM t_rights WHERE rights_grp_id = :irights_grp_id' +
                ' AND access_id = :iaccess_id'
        else
            Exit;//право ненадане - нема потреби його забирати
    end
    else begin//треба надати право
        if not child_is_granded then
            query:='INSERT INTO t_rights(access_id, rights_grp_id)' +
                                   ' VALUES(:iaccess_id, :irights_grp_id)'
        else
            Exit;//право надане - нема потреби його надавати
    end;
    try
        if tr_W.InTransaction then tr_W.Commit;
        tr_W.StartTransaction;
        q_W.SQL.Text:=query;
        q_W.ParamByName('iaccess_id').AsInteger:=a_child_id;
        q_W.ParamByName('irights_grp_id').AsInteger:=q_dic.FieldByName(g_dic.KeyField).AsInteger;
        q_W.ExecQuery;
        tr_W.Commit;
        if q_access.Locate(tree_list_access.KeyField, a_child_id, []) then
        begin
            q_access.Edit;
            q_access.FieldByName('o_image_index').AsInteger:=abs(q_access.FieldByName('o_image_index').AsInteger - 1);
            q_access.Post;
        end;
    except
        on E: Exception do
        begin
            if tr_W.InTransaction then tr_W.Rollback;
            ErrorDialog(E.Message, 'Tfgroups.HandleChildAccess');
        end;
    end;
end;//Tfgroups.HandleChildAccess

procedure Tfgroups.RefreshDetaile;
begin
    inherited;
    if base.Connected then
    begin
        st_id.Caption:=q_dic.FieldByName('oid').AsString;
        st_name.Caption:=q_dic.FieldByName('oname').AsString;
        RefreshUsers(q_dic.FieldByName('oid').AsInteger);
    end;
end;

procedure Tfgroups.RefreshUsers(const right_grp_id: Integer);
begin
    try
        if base.Connected then
        begin
            if tr_detaile.InTransaction then tr_detaile.Commit;
            tr_detaile.StartTransaction;
            if q_detaile.Active then q_detaile.Close;
            q_detaile.ParamByName('idocument_id').AsInteger:=right_grp_id;
            q_detaile.Open;
            tr_detaile.CommitRetaining;
        end;
    except
        on E: Exception do
        begin
            if tr_detaile.InTransaction then tr_detaile.Rollback;
            ErrorDialog(E.Message, 'Tfgroups.RefreshUsers');
        end;
    end;
end;

procedure Tfgroups.tree_list_accessClick(Sender: TObject);
begin
    inherited;
    mi_Click(mi_access_one);
end;

procedure Tfgroups.tree_list_accessDblClick(Sender: TObject);
begin
    inherited;
//    if tree_list_access.FocusedNode <> nil then
//    begin
//        if tree_list_access.FocusedNode.HasChildren then
//        begin
//            mi_Click(mi_access_all);
//        end;
//    end;
end;

procedure Tfgroups.tree_list_accessKeyPress(Sender: TObject;
  var Key: Char);
begin
    inherited;
    if Key = ' ' then//пробіл
    begin
        mi_Click(mi_access_one);
    end;
end;

end.
