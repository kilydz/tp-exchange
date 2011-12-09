unit u_groups;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, etalon_dic, dxExEdtr, dxCntner, Menus, IBCustomDataSet,
  IBUpdateSQL, IBSQL, IBDatabase, DB, IBQuery, ImgList, ExtCtrls, uXFilter,
  dxTL, dxDBCtrl, dxDBGrid, ComCtrls, ToolWin, uXToolBar, uXControlBar, veles_h,
  utils_h, dxDBTLCl, dxGrClms, ib_h, dxEditor, dxEdLib, StdCtrls, dxDBTL,
  ActnList, Placemnt;

const
    UNGRAND_ALL_IMAGE_INDEX =15;
    GRAND_ALL_IMAGE_INDEX =17;
    UNGRAND_ONE_IMAGE_INDEX = 14;
    GRAND_ONE_IMAGE_INDEX = 16;

    SQL_INSERT_RIGHTS_GRP = 'INSERT INTO t_rights_grp(name) VALUES(:name)';
    SQL_UPDATE_RIGHTS_GRP = 'UPDATE t_rights_grp SET name = :name WHERE right_grp_id = :right_grp_id';
    SQL_USER_IN_GEST_GROUP = 'UPDATE t_users SET rights_grp_id = 1 WHERE rights_grp_id = :rights_grp_id';
    SQL_UNGRAND_GROUP = 'DELETE FROM t_rights WHERE rights_grp_id = :rights_grp_id';
    SQL_DELETE_RIGHTS_GRP = 'DELETE FROM t_rights_grp WHERE right_grp_id = :right_grp_id';
    SQL_IS_ACCESS_GRANDED = 'SELECT o_result FROM p_is_access_granded(:access_id, :rights_grp_id)';
    SQL_DELETE_RIGHTS = 'DELETE FROM t_rights WHERE ' +
                             'access_id = :access_id AND rights_grp_id = :rights_grp_id';
    SQL_INSERT_RIGHTS = 'INSERT INTO t_rights(access_id, rights_grp_id) ' +
                             ' VALUES(:access_id, :rights_grp_id)';
    SQL_GET_USER_GROUP_ID = 'SELECT rights_grp_id FROM t_users WHERE user_id = :user_id';
    SQL_SELECT_ACCESS = 'SELECT access_id, parent FROM t_access ORDER BY access_id';
    SQL_GROUPS_COUNT = 'SELECT COUNT(*) AS groups_count FROM t_rights_grp';
    SQL_ACCESSES_COUNT = 'SELECT COUNT(*) AS accesses_count FROM t_access';

type
  Tfgroups = class(Tfetalon_dic)
    q_dicNAME: TIBStringField;
    q_dicRIGHT_GRP_ID: TIntegerField;
    g_dicNAME: TdxDBGridMaskColumn;
    g_dicRIGHT_GRP_ID: TdxDBGridMaskColumn;
    tree_access: TdxDBTreeList;
    Splitter2: TSplitter;
    dt_access: TDataSource;
    q_access: TIBQuery;
    tr_access: TIBTransaction;
    q_accessO_ACCESS_ID: TIntegerField;
    q_accessO_NAME: TIBStringField;
    q_accessO_PARENT: TIntegerField;
    q_accessO_IMAGE_INDEX: TIntegerField;
    tree_images: TImageList;
    tree_accessO_NAME: TdxDBTreeListMaskColumn;
    action_list: TActionList;
    act_grand_one: TAction;
    act_grand_all: TAction;
    popup_menu_access: TPopupMenu;
    menu_item_grand_one: TMenuItem;
    menu_item_grand_all: TMenuItem;
    upd_access: TIBUpdateSQL;
    popup_menu_groups: TPopupMenu;
    act_del: TAction;
    act_refresh: TAction;
    act_expand: TAction;
    act_collapse: TAction;
    pnl_caption: TPanel;
    menu_item_new: TMenuItem;
    menu_item_edit: TMenuItem;
    menu_item_del: TMenuItem;
    menu_item_refresh_groups: TMenuItem;
    smenu_item_expand: TMenuItem;
    menu_item_collapse: TMenuItem;
    menu_item_refresh_access: TMenuItem;
    ZToolBar1: ZToolBar;
    bt_access_one: TToolButton;
    bt_access_all: TToolButton;
    ToolButton14: TToolButton;
    bt_expand: TToolButton;
    bt_collapse: TToolButton;
    procedure tool_buttonClick(Sender: TObject); override;
    procedure q_dicAfterScroll(DataSet: TDataSet);
    procedure FormShow(Sender: TObject);
    procedure act_grand_oneExecute(Sender: TObject);
    procedure act_grand_allExecute(Sender: TObject);
    procedure popup_menu_accessPopup(Sender: TObject);
    procedure tree_accessChangeNode(Sender: TObject; OldNode,
      Node: TdxTreeListNode);
    procedure FormCreate(Sender: TObject);
    procedure act_newExecute(Sender: TObject);
    procedure act_editExecute(Sender: TObject);
    procedure act_delExecute(Sender: TObject);
    procedure act_refreshExecute(Sender: TObject);
    procedure act_expandExecute(Sender: TObject);
    procedure act_collapseExecute(Sender: TObject);
    procedure bt_refreshClick(Sender: TObject);
  private
    { Private declarations }
    access_id_array:      array of Integer;
    parent_id_array:      array of Integer;
    function GetUserGroupID(const a_user_id: Integer): Integer;
    function InvertNum(const number: Integer): Integer;
    function IsAccessGranded(const a_access_id, a_rights_grp_id: Integer): Boolean;
    procedure FillArrays;    
    procedure HandleBtnImages(Node: TdxTreeListNode);
    procedure HandleOneAccess(const a_access_id, a_rights_grp_id: Integer);
    procedure HandleAllAccess(const grand: Boolean);
  public
    { Public declarations }
    function GetGroupsCount: Integer;
    function GetAccessesCount: Integer;
    procedure InitInfo; override;
    procedure RefreshAccess(const rights_grp_id: Integer);
    procedure RefreshDetaile; override;
    procedure RefreshDic; override;
  end;

var
  fgroups: Tfgroups;

function ShowPage(var a_veles_info: ZVelesInfoRec): Longint; stdcall;
procedure FreePage(a_form_ref: Longint); stdcall;

implementation
uses u_group_dlg;

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
  if not IB_HasUserAccess(a_veles_info.db_handle, a_veles_info.user_id, ACCESS_TO_GROUPS_DIC) then
  begin
      GMessageBox('Ви не маєте права доступу до довідника ''Групи користувачів''', 'OK');
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
    inherited;

end;

procedure Tfgroups.RefreshDetaile;
begin
    inherited;

end;

procedure Tfgroups.HandleBtnImages(Node: TdxTreeListNode);
begin
    if Node <> nil then
    begin
        if Node.HasChildren then
        begin
            act_grand_all.Enabled:=true;
            menu_item_grand_all.Enabled:=true;//інакше чомусь не хоче (мало би
                                              //робитися все в попередньому рядку)
            if Node.ImageIndex = 0 then//ungrand
            begin
                act_grand_all.ImageIndex:=GRAND_ALL_IMAGE_INDEX;
                act_grand_all.Caption:='Надати усі права';
                act_grand_all.Hint:='Надати усі права';
            end
            else begin//if Node.ImageIndex = 1 //grand
                act_grand_all.ImageIndex:=UNGRAND_ALL_IMAGE_INDEX;
                act_grand_all.Caption:='Забрати усі права';
                act_grand_all.Hint:='Забрати усі права';                
            end;
        end
        else begin//if not Node.HasChildren
            act_grand_all.Enabled:=false;
            menu_item_grand_all.Enabled:=false;
            if Node.ImageIndex = 0 then//ungrand
            begin
                act_grand_all.ImageIndex:=GRAND_ALL_IMAGE_INDEX;
                act_grand_all.Caption:='Надати усі права';
                act_grand_all.Hint:='Надати усі права';                
            end
            else begin//if Node.ImageIndex = 1 //grand
                act_grand_all.ImageIndex:=UNGRAND_ALL_IMAGE_INDEX;
                act_grand_all.Caption:='Забрати усі права';
                act_grand_all.Hint:='Забрати усі права';                
            end;
        end;
        if Node.ImageIndex = 0 then//ungrand
        begin
            act_grand_one.ImageIndex:=GRAND_ONE_IMAGE_INDEX;
            act_grand_one.Caption:='Надати право';
            act_grand_one.Hint:='Надати право';            
        end
        else begin//if Node.ImageIndex = 1 //grand
            act_grand_one.ImageIndex:=UNGRAND_ONE_IMAGE_INDEX;
            act_grand_one.Caption:='Забрати право';
            act_grand_one.Hint:='Забрати право';            
        end;
    end;//if Node <> nil
end;//Tfgroups.HandleBtnImages

procedure Tfgroups.RefreshAccess(const rights_grp_id: Integer);
begin
    if base.Connected then
    begin
        if tr_access.InTransaction then tr_access.Commit;
        tr_access.StartTransaction;
        if q_access.Active then q_access.Close;
        q_access.ParamByName('i_rights_grp_id').AsInteger:=rights_grp_id;
        q_access.Open;
        tr_access.CommitRetaining;
    end;
end;

procedure Tfgroups.q_dicAfterScroll(DataSet: TDataSet);
begin
    inherited;
    if (not q_dic.IsEmpty)and(not q_dic.FieldByName('right_grp_id').IsNull) then
    begin
        RefreshAccess(q_dic.FieldByName('right_grp_id').AsInteger);
        tree_access.FullExpand;
        HandleBtnImages(tree_access.FocusedNode);
    end;
end;

procedure Tfgroups.FormShow(Sender: TObject);
begin
    inherited;
    HandleBtnImages(tree_access.FocusedNode);
end;

procedure Tfgroups.popup_menu_accessPopup(Sender: TObject);
begin
    inherited;
    //HandleBtnImages(tree_access.FocusedNode);
end;

//кожен раз коли змінюється виділене право необхідно змінити малюнок на кнопках,
//які надають або забирають права;
procedure Tfgroups.tree_accessChangeNode(Sender: TObject; OldNode,
  Node: TdxTreeListNode);
begin
    inherited;
    HandleBtnImages(Node);
end;

procedure Tfgroups.tool_buttonClick(Sender: TObject);
begin
    inherited;
    if (Sender as TToolButton) = bt_del then
    begin
        act_delExecute(Sender);
    end;
end;

//вертає true якщо право a_access_id надане групі a_rights_grp_id, інакше false;
function Tfgroups.IsAccessGranded(const a_access_id,
  a_rights_grp_id: Integer): Boolean;
begin
    Result:=false;
    try
        if tr_R.InTransaction then tr_R.Commit;
        tr_R.StartTransaction;
        q_R.SQL.Text:=SQL_IS_ACCESS_GRANDED;
        q_R.ParamByName('access_id').AsInteger:=a_access_id;
        q_R.ParamByName('rights_grp_id').AsInteger:=a_rights_grp_id;
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

//якщо number 1 вертоє 0; якщо number 0 вертає 1;
//використовується в процедурі HandleOneAccess;
function Tfgroups.InvertNum(const number: Integer): Integer;
begin
    if number = 0 then
        Result:=1
    else
        Result:=0
end;

//вертає ідентифікатор групи до якої належить a_user_id;
//якщо a_user_id невідомий (тобто не належить до жодної групи) вертає -1;
function Tfgroups.GetUserGroupID(const a_user_id: Integer): Integer;
begin
    Result:=-1;
    try
        if tr_R.InTransaction then tr_R.Commit;
        tr_R.StartTransaction;
        q_R.SQL.Text:=SQL_GET_USER_GROUP_ID;
        q_R.ParamByName('user_id').AsInteger:=a_user_id;
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

procedure Tfgroups.HandleOneAccess(const a_access_id,
  a_rights_grp_id: Integer);
//var
//    answer:         Integer;

begin
    try
        if tr_W.InTransaction then tr_W.Commit;
        tr_W.StartTransaction;
        //можна було б і так: if q_dic.FieldByName('o_image_index').AsInteger = 1
        //але так надійніше
        if IsAccessGranded(a_access_id, a_rights_grp_id) then//якщо право надане
        begin
            if a_rights_grp_id = ADMIN_GROUP_ID then
            begin
                GMessageBox('Не можна забирати права в групи ''Адміністратори''', 'OK');
                if tr_W.InTransaction then tr_W.Rollback;
                Exit;
            end;
            {if a_rights_grp_id = GUEST_GROUP_ID then
            begin
                answer:=GMessageBox('Ви впенені що хочете забрати права у групи  ''Гості''? Потім додати їх буде неможливо!',
                    'Так|Ні');
                if answer = 1 then//Так
                begin
                    if tr_W.InTransaction then tr_W.Rollback;
                    Exit;
                end;
            end;}
            q_W.SQL.Text:=SQL_DELETE_RIGHTS;
        end
        else begin//якщо право не надане
            {if a_rights_grp_id = GUEST_GROUP_ID then
            begin
                GMessageBox('Не можна додавати права групі ''Гості''', 'OK');
                if tr_W.InTransaction then tr_W.Rollback;
                Exit;
            end;}
            q_W.SQL.Text:=SQL_INSERT_RIGHTS;
        end;
        q_W.ParamByName('access_id').AsInteger:=a_access_id;
        q_W.ParamByName('rights_grp_id').AsInteger:=a_rights_grp_id;
        q_W.ExecQuery;
        tr_W.Commit;

        //замість RefreshAccess(a_rights_grp_id) використовуємо TIBUpdateObject
        //інакше дерево прав буде згортатися (це дуже незручно)
        q_access.Edit;
        q_access.FieldByName('o_image_index').AsInteger:=InvertNum(q_access.FieldByName('o_image_index').AsInteger);
        q_access.Post;
        //RefreshDic;
        //tree_access.FullExpand;
    except
        on E: Exception do
        begin
            if tr_W.InTransaction then tr_W.Rollback;
            ErrorDialog(E.Message, 'Tfgroups.HandleOneRight');
        end;
    end;
end;//Tfgroups.HandleOneRight

procedure Tfgroups.act_grand_oneExecute(Sender: TObject);
begin
    inherited;
    try//except
        if GetUserGroupID(prm.user_id) <> ADMIN_GROUP_ID then
        begin
            GMessageBox('Надавати або забирати права можуть тільки адміністратори', 'OK');
            Exit;
        end;
        if (q_dic.FieldByName('right_grp_id').IsNull)or
           (q_access.FieldByName('o_access_id').IsNull) then
        begin
            Exit;
        end;
        HandleOneAccess(q_access.FieldByName('o_access_id').AsInteger,
                        q_dic.FieldByName('right_grp_id').AsInteger);
        HandleBtnImages(tree_access.FocusedNode);
    except
        on E: Exception do
        begin
            ErrorDialog(E.Message, 'Tfgroups.act_grand_oneExecute');
        end;
    end;
end;

//заповнює масиви access_id_array та parent_id_array відповідно полями access_id та
//parent; використовується в процедурі HandleAllRights;
procedure Tfgroups.FillArrays;
var
    i:          Integer;

begin
    try
        if tr_R.InTransaction then tr_R.Commit;
        tr_R.StartTransaction;
        q_R.SQL.Text:=SQL_SELECT_ACCESS;
        q_R.ExecQuery;
        i:=0;
        while not q_R.Eof do
        begin
            SetLength(access_id_array, Length(access_id_array) + 1);
            SetLength(parent_id_array, Length(parent_id_array) + 1);
            access_id_array[i]:=q_R.FieldByName('access_id').AsInteger;
            parent_id_array[i]:=q_R.FieldByName('parent').AsInteger;
            i:=i + 1;
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
end;

//проедура використовується в обробнику Tfgroups.act_grand_allExecute;
//параметр grand вказує чи необхідно надати усі права чи забрати (true і false відповідно);
//ВАЖЛИВО! Перед викликом процедури необхідно перевірити чи можна поточній групі
//користувачів додавати чи забирати права;
//коректно обробить вузол без дітей (потомків);)
procedure Tfgroups.HandleAllAccess(const grand: Boolean);

//рекурсивна процедура, яка вносить у список a_childs_list усіх дітей (потомків)
//права (вузла) з ідентфікатором a_cur_access_id;
//параметри a_access_id та a_parent_id це одинакові, за кількістю елементів,
//динамічні масиви, які містять (див. проц. FillArrays) відповідні поля з
//таблиці t_access (масиви використовуються для зручності);
procedure GetAllChilds(a_cur_access_id: Integer; a_access_id_array,
    a_parent_id_array: array of Integer; a_childs_list: TIDManager);
var
    i:          Integer;

begin
    for i:=0 to Length(a_access_id_array) - 1 do
    begin
        if a_parent_id_array[i] = a_cur_access_id then
        begin
            a_childs_list.Add(a_access_id_array[i]);
            GetAllChilds(a_access_id_array[i], a_access_id_array, a_parent_id_array, a_childs_list);
        end;
    end;
end;

var
    i:              Integer;
    childs_list:    TIDManager;
    cur_access_id:  Integer;
    exists_access:  Boolean;

begin
    try//except
        cur_access_id:=q_access.FieldByName('o_access_id').AsInteger;
        childs_list:=TIDManager.Create(true);//в цьому списку будуть зберігатись усі діти (потомки)
        //права (вузла) з ідентифікатором cur_access_id (тобто тим яке обробляється)
        try
            FillArrays;

            GetAllChilds(cur_access_id, access_id_array, parent_id_array, childs_list);

            //перебираємо усіх дітей (потомків) права (вузла) cur_access_id
            //якщо дітей у вузла немає ця частина будле пропущена - отже вузол
            //без дітй буде оброблений коректно
            for i:=0 to childs_list.Count - 1 do
            begin
                exists_access:=false;
                if IsAccessGranded(childs_list[i], q_dic.FieldByName('right_grp_id').AsInteger) then
                begin
                    exists_access:=true;
                end;
                if grand then//якщо необхідно надати усі права
                begin
                    if not exists_access then
                    begin
                        try
                            if tr_W.InTransaction then tr_W.Commit;
                            tr_W.StartTransaction;
                            q_W.SQL.Text:=SQL_INSERT_RIGHTS;
                            q_W.ParamByName('access_id').AsInteger:=childs_list[i];
                            q_W.ParamByName('rights_grp_id').AsInteger:=q_dic.FieldByName('right_grp_id').AsInteger;
                            q_W.ExecQuery;
                            tr_W.Commit;
                            if q_access.Locate('o_access_id', childs_list[i], []) then
                            begin
                                //замість RefreshAccess використовуємо TIBUpdateObject
                                //інакше дерево прав буде згортатися (це дуже незручно)
                                q_access.Edit;
                                q_access.FieldByName('o_image_index').AsInteger:=InvertNum(q_access.FieldByName('o_image_index').AsInteger);
                                q_access.Post;
                            end;
                        except
                            on E: Exception do
                            begin
                                if tr_W.InTransaction then tr_W.Rollback;
                                ErrorDialog(E.Message, 'Tfgroups.HandleAllAccess');
                            end;
                        end;
                    end;//if not exists_access
                end
                else begin//if grand = false //якщо необхідно забрати усі права
                    if exists_access then
                    begin
                        try
                            if tr_W.InTransaction then tr_W.Commit;
                            tr_W.StartTransaction;
                            q_W.SQL.Text:=SQL_DELETE_RIGHTS;
                            q_W.ParamByName('access_id').AsInteger:=childs_list[i];
                            q_W.ParamByName('rights_grp_id').AsInteger:=q_dic.FieldByName('right_grp_id').AsInteger;
                            q_W.ExecQuery;
                            tr_W.Commit;
                            if q_access.Locate('o_access_id', childs_list[i], []) then
                            begin
                                //замість RefreshAccess використовуємо TIBUpdateObject
                                //інакше дерево прав буде згортатися (це дуже незручно)
                                q_access.Edit;
                                q_access.FieldByName('o_image_index').AsInteger:=InvertNum(q_access.FieldByName('o_image_index').AsInteger);
                                q_access.Post;
                            end;
                        except
                            on E: Exception do
                            begin
                                if tr_W.InTransaction then tr_W.Rollback;
                                ErrorDialog(E.Message, 'Tfgroups.HandleAllAccess');
                            end;
                        end;
                    end;//if exists_access
                end;
            end;//for

            //обов'язково необхідно повернутись в початкову позицію
            //інакше помилково оновиться не вузол, а один з його потомків
            q_access.Locate('o_access_id', cur_access_id, []);
            //тут обробляємо сам вузол (усі його діти (потомки) оброблені вище)
            HandleOneAccess(cur_access_id,
                         q_dic.FieldByName('right_grp_id').AsInteger);
        finally
            access_id_array:=nil;
            parent_id_array:=nil;
            childs_list.Destroy;
        end;
    except
        on E: Exception do ErrorDialog(E.Message, 'Tfgroups.HandleAllAccess');
    end;
end;//Tfgroups.HandleAllAccess

procedure Tfgroups.act_grand_allExecute(Sender: TObject);
//var
//    answer:         Integer;

begin
    inherited;
    try//except
        if GetUserGroupID(prm.user_id) <> ADMIN_GROUP_ID then
        begin
            GMessageBox('Надавати або забирати права можуть тільки адміністратори', 'OK');
            Exit;
        end;
        if (q_dic.FieldByName('right_grp_id').IsNull)or
           (q_access.FieldByName('o_access_id').IsNull) then
        begin
            Exit;
        end;
        //можна було б і так: if q_dic.FieldByName('o_image_index').AsInteger = 1
        //але так надійніше
        if IsAccessGranded(q_access.FieldByName('o_access_id').AsInteger, 
                            q_dic.FieldByName('right_grp_id').AsInteger) then
        begin//право надане - отже забираємо
            if q_dic.FieldByName('right_grp_id').AsInteger = ADMIN_GROUP_ID then
            begin
                GMessageBox('Не можна забирати права в групи ''Адміністратори''', 'OK');
                Exit;
            end;
            {if q_dic.FieldByName('right_grp_id').AsInteger = GUEST_GROUP_ID then
            begin
                answer:=GMessageBox('Ви впенені що хочете забрати права у групи  ''Гості''? Потім додати їх буде неможливо!',
                            'Так|Ні');
                if answer = 2 then//Ні
                begin
                    Exit;
                end;
            end;}
            HandleAllAccess(false);
        end//if IsAccessGranded
        else begin//право ненадане - отже надаємо
            {if q_dic.FieldByName('right_grp_id').AsInteger = GUEST_GROUP_ID then
            begin
                GMessageBox('Не можна додавати права групі ''Гості''', 'OK');
                Exit;
            end;}
            HandleAllAccess(true);
        end;
        HandleBtnImages(tree_access.FocusedNode);
    except
        on E: Exception do
        begin
            ErrorDialog(E.Message, 'Tfgroups.act_grand_allExecute');
        end;
    end;
end;//Tfgroups.act_grand_allExecute

procedure Tfgroups.FormCreate(Sender: TObject);
begin
    inherited;
    Splitter1.Visible:=false;
    g_detaile.Visible:=false;
end;

procedure Tfgroups.act_newExecute(Sender: TObject);
begin
    inherited;
    if not IB_HasUserAccess(prm.db_handle, prm.user_id, ACCESS_TO_ADD_GROUP) then
    begin
        GMessageBox('Ви не маєте права додавати новоу групу', 'OK');
        Exit;
    end;
    try//except
        fgroup_dlg:=Tfgroup_dlg.Create(Application);
        try//finally
            fgroup_dlg.Caption:=' Нова група';
            fgroup_dlg.l_prompt.Caption:='Введіть назву нової групи:';
            if fgroup_dlg.ShowModal = mrOk then
            begin
                if fgroup_dlg.ed_input.Text <> '' then
                begin
                    try
                        if tr_W.InTransaction then tr_W.Commit;
                        tr_W.StartTransaction;
                        q_W.SQL.Text:=SQL_INSERT_RIGHTS_GRP;
                        q_W.ParamByName('name').AsString:=fgroup_dlg.ed_input.Text;
                        q_W.ExecQuery;
                        tr_W.Commit;
                    except
                        on E: Exception do
                        begin
                            if tr_W.InTransaction then tr_W.Rollback;
                            ErrorDialog(E.Message, 'Tfgroups.act_newExecute');
                        end;
                    end;
                    RefreshDic;
                end;
            end;//if fgroup_dlg.ShowModal = mrOk
        finally
            fgroup_dlg.Free;
        end;
    except
        on E: Exception do ErrorDialog(E.Message, 'Tfgroups.act_newExecute');
    end;
end;//Tfgroups.act_newExecute

procedure Tfgroups.act_editExecute(Sender: TObject);
begin
    inherited;
    if not IB_HasUserAccess(prm.db_handle, prm.user_id, ACCESS_TO_EDIT_GROUP) then
    begin
        GMessageBox('Ви не маєте права редагувати групу', 'OK');
        Exit;
    end;
    try//except
        if q_dic.FieldByName('right_grp_id').IsNull then
        begin
            Exit;
        end;
        if q_dic.FieldByName('right_grp_id').AsInteger < SYSTEM_GROUPS_LIMIT then
        begin
            GMessageBox('Не можна редагувати службову групу', 'OK');
            Exit;
        end;
        fgroup_dlg:=Tfgroup_dlg.Create(Application);
        try//finally
            fgroup_dlg.Caption:=' Редагування групи';
            fgroup_dlg.l_prompt.Caption:='Введіть нову назву групи:';
            fgroup_dlg.ed_input.Text:=q_dic.FieldByName('name').AsString;
            if fgroup_dlg.ShowModal = mrOk then
            begin
                if fgroup_dlg.ed_input.Text <> q_dic.FieldByName('name').AsString then
                begin
                    try
                        if tr_W.InTransaction then tr_W.Commit;
                        tr_W.StartTransaction;
                        q_W.SQL.Text:=SQL_UPDATE_RIGHTS_GRP;
                        q_W.ParamByName('name').AsString:=fgroup_dlg.ed_input.Text;
                        q_W.ParamByName('right_grp_id').AsInteger:=q_dic.FieldByName('right_grp_id').AsInteger;
                        q_W.ExecQuery;
                        tr_W.Commit;
                    except
                        on E: Exception do
                        begin
                            if tr_W.InTransaction then tr_W.Rollback;
                            ErrorDialog(E.Message, 'Tfgroups.act_editExecute');
                        end;
                    end;
                    RefreshDic;
                end;
            end;//if fgroup_dlg.ShowModal = mrOk
        finally
            fgroup_dlg.Free;
        end;
    except
        on E: Exception do
        begin
            ErrorDialog(E.Message, 'Tfgroups.act_editExecute');
        end;
    end;
end;//Tfgroups.act_editExecute

procedure Tfgroups.act_delExecute(Sender: TObject);
var
    answer:         Integer;

begin
    inherited;
    if not IB_HasUserAccess(prm.db_handle, prm.user_id, ACCESS_TO_DEL_GROUP) then
    begin
        GMessageBox('Ви не маєте права видаляти групу', 'OK');
        Exit;
    end;
    try//except
        if q_dic.FieldByName('right_grp_id').IsNull then
        begin
            Exit;
        end;
        if q_dic.FieldByName('right_grp_id').AsInteger < SYSTEM_GROUPS_LIMIT then
        begin
            GMessageBox('Не можна видаляти службову групу', 'OK');
            Exit;
        end;
        answer:=GMessageBox(PChar('Ви впевнені що хочете видалити групу ' +
            q_dic.FieldByName('name').AsString +
            '? Усі користувачі даної групи попадуть в групу ''Гості'' та втратять усі свої права'),
            'Так|Ні');
        if answer = 1 then//Так
        begin
            try
                //переносимо усіх користувачів даної групи в групу гості
                if tr_W.InTransaction then tr_W.Commit;
                tr_W.StartTransaction;
                q_W.SQL.Text:=SQL_USER_IN_GEST_GROUP;
                q_W.ParamByName('rights_grp_id').AsInteger:=q_dic.FieldByName('right_grp_id').AsInteger;
                q_W.ExecQuery;
                tr_W.Commit;
            except
                on E: Exception do
                begin
                    if tr_W.InTransaction then tr_W.Rollback;
                    ErrorDialog(E.Message, 'Tfgroups.act_delExecute');
                end;
            end;
            try
                //видаляємо усі права, які було надано цій групі
                if tr_W.InTransaction then tr_W.Commit;
                tr_W.StartTransaction;
                q_W.SQL.Text:=SQL_UNGRAND_GROUP;
                q_W.ParamByName('rights_grp_id').AsInteger:=q_dic.FieldByName('right_grp_id').AsInteger;
                q_W.ExecQuery;
                tr_W.Commit;
            except
                on E: Exception do
                begin
                    if tr_W.InTransaction then tr_W.Rollback;
                    ErrorDialog(E.Message, 'Tfgroups.act_delExecute');
                end;
            end;
            try
                //видаляємо саму групу
                if tr_W.InTransaction then tr_W.Commit;
                tr_W.StartTransaction;
                q_W.SQL.Text:=SQL_DELETE_RIGHTS_GRP;
                q_W.ParamByName('right_grp_id').AsInteger:=q_dic.FieldByName('right_grp_id').AsInteger;
                q_W.ExecQuery;
                tr_W.Commit;
            except
                on E: Exception do
                begin
                    if tr_W.InTransaction then tr_W.Rollback;
                    ErrorDialog(E.Message, 'Tfgroups.act_delExecute');
                end;
            end;
            RefreshDic;
        end;//if answer = 1 then//Так
    except
        on E: Exception do
        begin
            ErrorDialog(E.Message, 'Tfgroups.act_delExecute');
        end;
    end;
end;//Tfgroups.act_delExecute

procedure Tfgroups.act_refreshExecute(Sender: TObject);
begin
   inherited;
   RefreshDic;
end;

procedure Tfgroups.RefreshDic;
begin
    inherited;
end;


function Tfgroups.GetAccessesCount: Integer;
begin
    Result:=0;
    try
        if tr_R.InTransaction then tr_R.Commit;
        tr_R.StartTransaction;
        q_R.SQL.Text:=SQL_ACCESSES_COUNT;
        q_R.ExecQuery;
        Result:=q_R.FieldByName('accesses_count').AsInteger;
        tr_R.Commit;
    except
        on E: Exception do
        begin
            ErrorDialog(E.Message, 'Tfgroups.GetAccessesCount');
        end;
    end;
end;

function Tfgroups.GetGroupsCount: Integer;
begin
    Result:=0;
    try
        if tr_R.InTransaction then tr_R.Commit;
        tr_R.StartTransaction;
        q_R.SQL.Text:=SQL_GROUPS_COUNT;
        q_R.ExecQuery;
        Result:=q_R.FieldByName('groups_count').AsInteger;
        tr_R.Commit;
    except
        on E: Exception do
        begin
            ErrorDialog(E.Message, 'Tfgroups.GetGroupsCount');
        end;
    end;
end;

procedure Tfgroups.act_expandExecute(Sender: TObject);
begin
    inherited;
    tree_access.FullExpand;
end;

procedure Tfgroups.act_collapseExecute(Sender: TObject);
begin
    inherited;
    tree_access.FullCollapse;
end;

procedure Tfgroups.bt_refreshClick(Sender: TObject);
begin
    inherited;
    act_refreshExecute(Sender);
end;

end.
