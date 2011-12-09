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

//�������� a_veles_info ������ ���������� ��� �������� (���. veles_h.pas);
//���� app_handle, control_pointers ���������������� ��� ��������� �����
//������ �� ����"���� �� ������� ����� ��������;
//�������� ��� ��������� �� ������������ � Longint �������� �� �����
//������;
//���� ������� �� �� ��������� �� ������� (���������� ��������� ��) ��
//������; ���� ������� ��� ��������� ������ ������ ��;
function ShowPage(var a_veles_info: ZVelesInfoRec): Longint; stdcall;
begin
  Result:=Longint(fgroups);
  if not IB_HasUserAccess(a_veles_info.db_handle, a_veles_info.user_id, ACCESS_TO_GROUPS_DIC) then
  begin
      GMessageBox('�� �� ���� ����� ������� �� �������� ''����� ������������''', 'OK');
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

//����� ����� ������; �������� a_form_ref �� �������� �� ����� ������
//��������� ���������� TShowPage; ���� �������� ����� ������ ���������
//��������� ����� (����, ��������, �� ����"������);
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
            menu_item_grand_all.Enabled:=true;//������ ������ �� ���� (���� ��
                                              //�������� ��� � ������������ �����)
            if Node.ImageIndex = 0 then//ungrand
            begin
                act_grand_all.ImageIndex:=GRAND_ALL_IMAGE_INDEX;
                act_grand_all.Caption:='������ �� �����';
                act_grand_all.Hint:='������ �� �����';
            end
            else begin//if Node.ImageIndex = 1 //grand
                act_grand_all.ImageIndex:=UNGRAND_ALL_IMAGE_INDEX;
                act_grand_all.Caption:='������� �� �����';
                act_grand_all.Hint:='������� �� �����';                
            end;
        end
        else begin//if not Node.HasChildren
            act_grand_all.Enabled:=false;
            menu_item_grand_all.Enabled:=false;
            if Node.ImageIndex = 0 then//ungrand
            begin
                act_grand_all.ImageIndex:=GRAND_ALL_IMAGE_INDEX;
                act_grand_all.Caption:='������ �� �����';
                act_grand_all.Hint:='������ �� �����';                
            end
            else begin//if Node.ImageIndex = 1 //grand
                act_grand_all.ImageIndex:=UNGRAND_ALL_IMAGE_INDEX;
                act_grand_all.Caption:='������� �� �����';
                act_grand_all.Hint:='������� �� �����';                
            end;
        end;
        if Node.ImageIndex = 0 then//ungrand
        begin
            act_grand_one.ImageIndex:=GRAND_ONE_IMAGE_INDEX;
            act_grand_one.Caption:='������ �����';
            act_grand_one.Hint:='������ �����';            
        end
        else begin//if Node.ImageIndex = 1 //grand
            act_grand_one.ImageIndex:=UNGRAND_ONE_IMAGE_INDEX;
            act_grand_one.Caption:='������� �����';
            act_grand_one.Hint:='������� �����';            
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

//����� ��� ���� ��������� ������� ����� ��������� ������ ������� �� �������,
//�� ������� ��� ��������� �����;
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

//����� true ���� ����� a_access_id ������ ���� a_rights_grp_id, ������ false;
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

//���� number 1 ����� 0; ���� number 0 ����� 1;
//��������������� � �������� HandleOneAccess;
function Tfgroups.InvertNum(const number: Integer): Integer;
begin
    if number = 0 then
        Result:=1
    else
        Result:=0
end;

//����� ������������� ����� �� ��� �������� a_user_id;
//���� a_user_id �������� (����� �� �������� �� ����� �����) ����� -1;
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
        //����� ���� � � ���: if q_dic.FieldByName('o_image_index').AsInteger = 1
        //��� ��� �������
        if IsAccessGranded(a_access_id, a_rights_grp_id) then//���� ����� ������
        begin
            if a_rights_grp_id = ADMIN_GROUP_ID then
            begin
                GMessageBox('�� ����� �������� ����� � ����� ''������������''', 'OK');
                if tr_W.InTransaction then tr_W.Rollback;
                Exit;
            end;
            {if a_rights_grp_id = GUEST_GROUP_ID then
            begin
                answer:=GMessageBox('�� ������ �� ������ ������� ����� � �����  ''����''? ���� ������ �� ���� ���������!',
                    '���|ͳ');
                if answer = 1 then//���
                begin
                    if tr_W.InTransaction then tr_W.Rollback;
                    Exit;
                end;
            end;}
            q_W.SQL.Text:=SQL_DELETE_RIGHTS;
        end
        else begin//���� ����� �� ������
            {if a_rights_grp_id = GUEST_GROUP_ID then
            begin
                GMessageBox('�� ����� �������� ����� ���� ''����''', 'OK');
                if tr_W.InTransaction then tr_W.Rollback;
                Exit;
            end;}
            q_W.SQL.Text:=SQL_INSERT_RIGHTS;
        end;
        q_W.ParamByName('access_id').AsInteger:=a_access_id;
        q_W.ParamByName('rights_grp_id').AsInteger:=a_rights_grp_id;
        q_W.ExecQuery;
        tr_W.Commit;

        //������ RefreshAccess(a_rights_grp_id) ������������� TIBUpdateObject
        //������ ������ ���� ���� ���������� (�� ���� ��������)
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
            GMessageBox('�������� ��� �������� ����� ������ ����� ������������', 'OK');
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

//�������� ������ access_id_array �� parent_id_array �������� ������ access_id ��
//parent; ��������������� � �������� HandleAllRights;
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

//�������� ��������������� � ��������� Tfgroups.act_grand_allExecute;
//�������� grand ����� �� ��������� ������ �� ����� �� ������� (true � false ��������);
//�������! ����� �������� ��������� ��������� ��������� �� ����� ������� ����
//������������ �������� �� �������� �����;
//�������� �������� ����� ��� ���� (�������);)
procedure Tfgroups.HandleAllAccess(const grand: Boolean);

//���������� ���������, ��� ������� � ������ a_childs_list ��� ���� (�������)
//����� (�����) � �������������� a_cur_access_id;
//��������� a_access_id �� a_parent_id �� ��������, �� ������� ��������,
//������� ������, �� ������ (���. ����. FillArrays) ������� ���� �
//������� t_access (������ ���������������� ��� ��������);
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
        childs_list:=TIDManager.Create(true);//� ����� ������ ������ ���������� �� ��� (�������)
        //����� (�����) � ��������������� cur_access_id (����� ��� ��� ������������)
        try
            FillArrays;

            GetAllChilds(cur_access_id, access_id_array, parent_id_array, childs_list);

            //���������� ��� ���� (�������) ����� (�����) cur_access_id
            //���� ���� � ����� ���� �� ������� ����� ��������� - ���� �����
            //��� ��� ���� ���������� ��������
            for i:=0 to childs_list.Count - 1 do
            begin
                exists_access:=false;
                if IsAccessGranded(childs_list[i], q_dic.FieldByName('right_grp_id').AsInteger) then
                begin
                    exists_access:=true;
                end;
                if grand then//���� ��������� ������ �� �����
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
                                //������ RefreshAccess ������������� TIBUpdateObject
                                //������ ������ ���� ���� ���������� (�� ���� ��������)
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
                else begin//if grand = false //���� ��������� ������� �� �����
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
                                //������ RefreshAccess ������������� TIBUpdateObject
                                //������ ������ ���� ���� ���������� (�� ���� ��������)
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

            //����'������ ��������� ����������� � ��������� �������
            //������ ��������� ��������� �� �����, � ���� � ���� �������
            q_access.Locate('o_access_id', cur_access_id, []);
            //��� ���������� ��� ����� (�� ���� ��� (�������) �������� ����)
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
            GMessageBox('�������� ��� �������� ����� ������ ����� ������������', 'OK');
            Exit;
        end;
        if (q_dic.FieldByName('right_grp_id').IsNull)or
           (q_access.FieldByName('o_access_id').IsNull) then
        begin
            Exit;
        end;
        //����� ���� � � ���: if q_dic.FieldByName('o_image_index').AsInteger = 1
        //��� ��� �������
        if IsAccessGranded(q_access.FieldByName('o_access_id').AsInteger, 
                            q_dic.FieldByName('right_grp_id').AsInteger) then
        begin//����� ������ - ���� ��������
            if q_dic.FieldByName('right_grp_id').AsInteger = ADMIN_GROUP_ID then
            begin
                GMessageBox('�� ����� �������� ����� � ����� ''������������''', 'OK');
                Exit;
            end;
            {if q_dic.FieldByName('right_grp_id').AsInteger = GUEST_GROUP_ID then
            begin
                answer:=GMessageBox('�� ������ �� ������ ������� ����� � �����  ''����''? ���� ������ �� ���� ���������!',
                            '���|ͳ');
                if answer = 2 then//ͳ
                begin
                    Exit;
                end;
            end;}
            HandleAllAccess(false);
        end//if IsAccessGranded
        else begin//����� �������� - ���� ������
            {if q_dic.FieldByName('right_grp_id').AsInteger = GUEST_GROUP_ID then
            begin
                GMessageBox('�� ����� �������� ����� ���� ''����''', 'OK');
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
        GMessageBox('�� �� ���� ����� �������� ����� �����', 'OK');
        Exit;
    end;
    try//except
        fgroup_dlg:=Tfgroup_dlg.Create(Application);
        try//finally
            fgroup_dlg.Caption:=' ���� �����';
            fgroup_dlg.l_prompt.Caption:='������ ����� ���� �����:';
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
        GMessageBox('�� �� ���� ����� ���������� �����', 'OK');
        Exit;
    end;
    try//except
        if q_dic.FieldByName('right_grp_id').IsNull then
        begin
            Exit;
        end;
        if q_dic.FieldByName('right_grp_id').AsInteger < SYSTEM_GROUPS_LIMIT then
        begin
            GMessageBox('�� ����� ���������� �������� �����', 'OK');
            Exit;
        end;
        fgroup_dlg:=Tfgroup_dlg.Create(Application);
        try//finally
            fgroup_dlg.Caption:=' ����������� �����';
            fgroup_dlg.l_prompt.Caption:='������ ���� ����� �����:';
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
        GMessageBox('�� �� ���� ����� �������� �����', 'OK');
        Exit;
    end;
    try//except
        if q_dic.FieldByName('right_grp_id').IsNull then
        begin
            Exit;
        end;
        if q_dic.FieldByName('right_grp_id').AsInteger < SYSTEM_GROUPS_LIMIT then
        begin
            GMessageBox('�� ����� �������� �������� �����', 'OK');
            Exit;
        end;
        answer:=GMessageBox(PChar('�� ������� �� ������ �������� ����� ' +
            q_dic.FieldByName('name').AsString +
            '? �� ����������� ���� ����� �������� � ����� ''����'' �� �������� �� ��� �����'),
            '���|ͳ');
        if answer = 1 then//���
        begin
            try
                //���������� ��� ������������ ���� ����� � ����� ����
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
                //��������� �� �����, �� ���� ������ ��� ����
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
                //��������� ���� �����
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
        end;//if answer = 1 then//���
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
