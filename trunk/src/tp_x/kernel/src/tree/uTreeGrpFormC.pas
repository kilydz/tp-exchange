unit uTreeGrpFormC;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ImgList, IBSQL, IBDatabase, DB, Menus, ComCtrls, ToolWin,
  StdCtrls, ExtCtrls, tree_h, dxTL, dxCntner, genstor_h, dxExEdtr, uZToolButton,
  uZToolBar;

type
  TfTreeC = class(TForm)
    Panel1: TPanel;
    ToolBar2: ZToolBar;
    bt_new: ZToolButton;
    bt_edit: ZToolButton;
    bt_del: ZToolButton;
    ToolButton1: TToolButton;
    bt_refresh: ZToolButton;
    PopupMenu: TPopupMenu;
    N1: TMenuItem;
    N2: TMenuItem;
    N5: TMenuItem;
    N4: TMenuItem;
    N3: TMenuItem;
    Base: TIBDatabase;
    tr: TIBTransaction;
    q: TIBSQL;
    trW: TdxTreeList;
    dxColumn1: TdxTreeListColumn;
    ImageList1: TImageList;
    procedure trWChange(Sender: TObject; Node: TTreeNode);
    procedure FormDestroy(Sender: TObject);
    procedure ToolButton1Click(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure PanelResize(Sender: TObject);
    procedure eGropNameKeyPress(Sender: TObject; var Key: Char);
    procedure ToolButton3Click(Sender: TObject);
    procedure bt_editClick(Sender: TObject);
    procedure ToolButton4Click(Sender: TObject);
    procedure FormHide(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure FormDockDrop(Sender: TObject; Source: TDragDockObject; Z,
      Y: Integer);
    procedure trWChangeNode(Sender: TObject; OldNode,
      Node: TdxTreeListNode);
  private
    { Private declarations }
  public
    { Public declarations }
    dt: TList;
    mode: integer; // 0 - Rename, 1 - Add;
    prm: TTreeParams;

    procedure ClearNodes;
    procedure InitTreeData;
    procedure AddNode(var per: TdxTreeListNode; prew_id: integer);
    procedure FocusBranch(var nod: TdxTreeListNode; ind: integer);
    procedure IntoGrp(ind: integer);
  end;

function TreeCreateC(var prm: TTreeParams): integer;
function TreeRefreshC(var prm: TTreeParams): integer;
function TreeSelectionsC(var prm: TTreeParams): integer;
function TreeSelectionsSpaceC(var prm: TTreeParams): integer;
function TreeToGroupC(var prm: TTreeParams): integer;
function TreeHideShowC(var prm: TTreeParams): integer;
function TreeRelaseC(var prm: TTreeParams): integer;

implementation

{$R *.dfm}
//---------------------------------------------------------------------------
// Створює дерево
function TreeCreateC(var prm: TTreeParams): integer;
var rpt: TfTreeC;
begin
    rpt := TfTreeC.Create(nil);

    rpt.Base.SetHandle(prm.sGen.db_handle);
    rpt.dt := TList.Create;
    rpt.prm := prm;
    prm.Panel := rpt.Panel1;
    prm.Forma := rpt;

    rpt.InitTreeData();

    TreeCreateC := 1;
end;

//---------------------------------------------------------------------------
// Рефрешить дерево
function TreeRefreshC(var prm: TTreeParams): integer;
var rpt: TfTreeC;
begin
    rpt := TfTreeC(prm.Forma);
    rpt.InitTreeData();
    TreeRefreshC := 1;
end;

//---------------------------------------------------------------------------
function TreeToGroupC(var prm: TTreeParams): integer;
begin
  TfTreeC(prm.Forma).IntoGrp(prm.SetGrpId);
  result := 1;
end;

//---------------------------------------------------------------------------
function TreeSelectionsC(var prm: TTreeParams): integer;
var rpt: TfTreeC;
    nd: ^TGroupTreeNode;
    i: integer;
begin
  rpt := TfTreeC(prm.Forma);
  prm.grp_list := '';
  for i := 0 to rpt.trW.SelectedCount-1 do
  begin
    nd := rpt.trW.SelectedNodes[i].Data;
    if prm.grp_list <> '' then
      prm.grp_list := prm.grp_list + ',';
    prm.grp_list := prm.grp_list + IntToStr(nd^.id);
  end;
  if prm.grp_list = '' then prm.grp_list := '0';
  TreeSelectionsC := 1;
end;

//---------------------------------------------------------------------------
function TreeSelectionsSpaceC(var prm: TTreeParams): integer;
var rpt: TfTreeC;
    nd: ^TGroupTreeNode;
    i: integer;
begin
  rpt := TfTreeC(prm.Forma);
  prm.grp_list := ' ';
  for i := 0 to rpt.trW.SelectedCount-1 do
  begin
    nd := rpt.trW.SelectedNodes[i].Data;
    prm.grp_list := prm.grp_list + IntToStr(nd^.id) + ' ';
  end;
  if prm.grp_list = ' ' then prm.grp_list := ' 0 ';
  result := 1;
end;

//---------------------------------------------------------------------------
// Показує (prm.Visible = true), або ховає (prm.Visible = false) дерево
function TreeHideShowC(var prm: TTreeParams): integer;
begin
  if prm.Visible then
    prm.Forma.Show
  else
    prm.Forma.Hide;
  TreeHideShowC := 1;
end;

//---------------------------------------------------------------------------
// Очистка пам'яті після закінчення роботи з деревом
function TreeRelaseC(var prm: TTreeParams): integer;
var dlg: TfTreeC;
begin
  dlg := TfTreeC(prm.Forma);
  dlg.Free;
  result := 1;
end;
//---------------------------------------------------------------------------
//---------------------------------------------------------------------------

procedure TfTreeC.ClearNodes;
begin
  while dt.Count > 0 do
  begin
    Dispose(dt.Last);
    dt.Delete(dt.Count - 1);
  end;
  trW.ClearNodes;
end;
//---------------------------------------------------------------------------

procedure TfTreeC.FocusBranch(var nod: TdxTreeListNode; ind: integer);
var nd: ^TGroupTreeNode;
    i: integer;
    node: TdxTreeListNode;
begin
  for i := 0 to nod.Count - 1 do
  begin
    node := nod.Items[i];
    FocusBranch(node, ind);
    nd := nod.Items[i].Data;
    if nd^.id = ind then
      nod.Items[i].Focused := true;
  end;
end;
//---------------------------------------------------------------------------

procedure TfTreeC.IntoGrp(ind: integer);
var node: TdxTreeListNode;
begin
  node := trW.Items[0];
  FocusBranch(node, ind);
end;
//---------------------------------------------------------------------------

procedure TfTreeC.InitTreeData;
var nd: ^TGroupTreeNode;
    home: TdxTreeListNode;
begin
 { if prm.MultiSelect = 0 then
    trW.MultiSelect := false
  else
    trW.MultiSelect := true;}

  ClearNodes;
  New(nd);
  nd^.id := 0;
  nd.name := 'Всі групи';
  nd^.prew_id := -1;
  dt.Add(nd);

  if tr.InTransaction then tr.Commit;
  tr.StartTransaction;
  q.Close;
  q.SQL.Text := 'select * from T_CLIENT_GROUPS';
  q.ExecQuery;
  while not q.Eof do
  begin
    New(nd);
    nd^.id := q.FieldByName('grpc_id').AsInteger;
    nd^.code := q.FieldByName('grpc_code').AsInteger;
    nd.name := q.FieldByName('grpc_name').AsString;
    if q.FieldByName('prew_grpc_id').IsNull then
      nd^.prew_id := 0
    else
      nd^.prew_id := q.FieldByName('prew_grpc_id').AsInteger;
    dt.Add(nd);
    q.Next();
  end;
  if tr.InTransaction then tr.Commit;

  home := trW.Add;
  home.Values[dxColumn1.Index] := 'Всі групи';
  home.Data := dt.Items[0];
  home.SelectedIndex := 5;
  AddNode(home, 0);
end;
//---------------------------------------------------------------------------

procedure TfTreeC.AddNode(var per: TdxTreeListNode; prew_id: integer);
var  cur: TdxTreeListNode;
     dt_i: ^TGroupTreeNode;
     i: integer;
begin

  for i := 0 to dt.Count-1 do
  begin
    dt_i := dt.Items[i];
    if dt_i^.prew_id = prew_id then
    begin
      cur := per.AddChild;
      cur.Values[dxColumn1.Index] := string(dt_i^.name);
      cur.SelectedIndex := 5;
      cur.Data := dt_i;
      AddNode(cur, dt_i^.id);
    end;
  end;
end;
//---------------------------------------------------------------------------

procedure TfTreeC.trWChange(Sender: TObject; Node: TTreeNode);
begin
    prm.ActiveNode := Node.Data;
    prm.OnChengeBranch(prm.ActiveNode^);
end;
//---------------------------------------------------------------------------

procedure TfTreeC.FormDestroy(Sender: TObject);
begin
  ClearNodes;
  dt.Free;
end;
//---------------------------------------------------------------------------

procedure TfTreeC.ToolButton1Click(Sender: TObject);
var tn: PTGroupTreeNode;
    node, n_node: TdxTreeListNode;
    prew_id: integer;
begin  //Додати Гілку
  node := trW.FocusedNode;
  tn := node.Data;

  prew_id := tn^.id;
  New(tn);

  if BranchCDialog(0, prew_id, tn, prm.sGen) > 0 then
  begin
    dt.Add(tn);
    n_node := node.AddChild;
    n_node.Values[dxColumn1.Index] := tn^.name;
    n_node.Data := tn;
    n_node.SelectedIndex := 5;
  end
  else
    Dispose(tn);
end;
//---------------------------------------------------------------------------

procedure TfTreeC.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  Action := caHide;
end;
//---------------------------------------------------------------------------

procedure TfTreeC.PanelResize(Sender: TObject);
begin

end;
//---------------------------------------------------------------------------

procedure TfTreeC.eGropNameKeyPress(Sender: TObject; var Key: Char);
begin
end;
//---------------------------------------------------------------------------

procedure TfTreeC.ToolButton3Click(Sender: TObject);
begin  // Refresh
  InitTreeData();
end;
//---------------------------------------------------------------------------

procedure TfTreeC.bt_editClick(Sender: TObject);
var tn: PTGroupTreeNode;
    node: TdxTreeListNode;
    prew_id: integer;
begin //Rename
  node := trW.FocusedNode;
  tn := node.Data;

  if tn^.id <> 0 then
  begin
    if BranchCDialog(tn.id, 0, tn, prm.sGen) > 0 then
    begin
      node.Values[dxColumn1.Index] := tn.name;
    end  
  end
end;
//---------------------------------------------------------------------------

procedure TfTreeC.ToolButton4Click(Sender: TObject);
var tn: ^TGroupTreeNode;
    node: TdxTreeListNode;
    res: integer;
begin
  node := trW.FocusedNode;
  tn := node.Data;
  if tn^.id > 0 then
  begin
    tr.StartTransaction;
    q.SQL.Text := 'select * from T_GRPC_DELETE(' + IntToStr(tn^.id) + ')';
    q.ExecQuery;
    res := q.FieldByName('RSUCS').AsInteger;
    tr.Commit;
    if res = 0 then
      MessageBox(0, 'Неможливо видалити непорожню групу', 'Увага', MB_OK)
    else
    begin
      dt.Delete(dt.IndexOf(tn));
      node.Destroy;
    end;
  end;
end;
//---------------------------------------------------------------------------

procedure TfTreeC.FormHide(Sender: TObject);
begin
  prm.Visible := false;
  prm.OnShowHide(prm);
end;

procedure TfTreeC.FormShow(Sender: TObject);
begin
  prm.Visible := true;
  prm.OnShowHide(prm);
end;

procedure TfTreeC.FormDockDrop(Sender: TObject; Source: TDragDockObject; Z,
  Y: Integer);
begin
//  Panel.Visible := false;
end;

procedure TfTreeC.trWChangeNode(Sender: TObject; OldNode,
  Node: TdxTreeListNode);
begin
    prm.ActiveNode := Node.Data;
    prm.OnChengeBranch(prm);
end;

end.
