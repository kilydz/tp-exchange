unit uTreeGrpForm;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ImgList, IBSQL, IBDatabase, DB, Menus, ComCtrls, ToolWin,
  StdCtrls, ExtCtrls, tree_h, dxCntner, dxTL, genstor_h, dxTLClms,
  dxExEdtr, uZControlBar, dxEditor, dxEdLib, kernel_h, uZToolButton;

type
  TfTree = class(TForm)
    Panel1: TPanel;
    Base: TIBDatabase;
    tr: TIBTransaction;
    q: TIBSQL;
    ImageList1: TImageList;
    trW: TdxTreeList;
    trWColumn1: TdxTreeListColumn;
    trWColumn2: TdxTreeListColumn;
    trWColumn3: TdxTreeListColumn;
    ToolBar1: TToolBar;
    bt_refresh: ZToolButton;
    bt_del: ZToolButton;
    bt_edit: ZToolButton;
    bt_ins: ZToolButton;
    ToolButton1: TToolButton;
    procedure bt_insPaint(Sender: TObject);
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
    procedure eGroupCodeKeyPress(Sender: TObject; var Key: Char);
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

function TreeCreate(var prm: TTreeParams): integer;
function TreeRefresh(var prm: TTreeParams): integer;
function TreeSelections(var prm: TTreeParams): integer;
function TreeSelectionsSpace(var prm: TTreeParams): integer;
function TreeToGroup(var prm: TTreeParams): integer;
function TreeHideShow(var prm: TTreeParams): integer;
function TreeRelase(var prm: TTreeParams): integer;

implementation

{$R *.dfm}
//---------------------------------------------------------------------------
// Створює дерево
function TreeCreate(var prm: TTreeParams): integer;
var rpt: TfTree;
begin
    rpt := TfTree.Create(nil);

    rpt.Base.SetHandle(prm.sGen.db_handle);
    rpt.dt := TList.Create;
    rpt.prm := prm;
    prm.Panel := rpt.Panel1;
    prm.Forma := rpt;

    rpt.InitTreeData();

    TreeCreate := 1;
end;

//---------------------------------------------------------------------------
// Рефрешить дерево
function TreeRefresh(var prm: TTreeParams): integer;
var rpt: TfTree;
begin
    rpt := TfTree(prm.Forma);
    rpt.InitTreeData();
    TreeRefresh := 1;
end;

//---------------------------------------------------------------------------
function TreeToGroup(var prm: TTreeParams): integer;
begin
  TfTree(prm.Forma).IntoGrp(prm.SetGrpId);
  result := 1;
end;

//---------------------------------------------------------------------------
function TreeSelections(var prm: TTreeParams): integer;
var rpt: TfTree;
    nd: ^TGroupTreeNode;
    i: integer;
    n: integer;
begin
  rpt := TfTree(prm.Forma);
  prm.grp_list := '';
  n := rpt.trW.SelectedCount-1;
  for i := 0 to n do
  begin
    nd := rpt.trW.SelectedNodes[i].Data;
    if prm.grp_list <> '' then
      prm.grp_list := prm.grp_list + ',';
    prm.grp_list := prm.grp_list + IntToStr(nd^.id);
  end;
  if prm.grp_list = '' then prm.grp_list := '0';
  result := 1;
end;

//---------------------------------------------------------------------------
function TreeSelectionsSpace(var prm: TTreeParams): integer;
var rpt: TfTree;
    nd: ^TGroupTreeNode;
    i: integer;
begin
  rpt := TfTree(prm.Forma);
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
function TreeHideShow(var prm: TTreeParams): integer;
begin
  if prm.Visible then
    prm.Forma.Show
  else
    prm.Forma.Hide;
  result := 1;
end;

//---------------------------------------------------------------------------
// Очистка пам'яті після закінчення роботи з деревом
function TreeRelase(var prm: TTreeParams): integer;
begin
  prm.Forma.Free;
  result := 1;
end;
//---------------------------------------------------------------------------
//---------------------------------------------------------------------------

procedure TfTree.ClearNodes;
begin
  while dt.Count > 0 do
  begin
    Dispose(dt.Last);
    dt.Delete(dt.Count - 1);
  end;
  trW.ClearNodes;
end;
//---------------------------------------------------------------------------

procedure TfTree.FocusBranch(var nod: TdxTreeListNode; ind: integer);
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

procedure TfTree.IntoGrp(ind: integer);
var node: TdxTreeListNode;
begin
  node := trW.Items[0];
  FocusBranch(node, ind);
end;
//---------------------------------------------------------------------------

procedure TfTree.InitTreeData;
var nd: ^TGroupTreeNode;
    home: TdxTreeListNode;
begin
  if prm.MultiSelect = 0 then
    trW.Options := [aoColumnSizing,aoColumnMoving,aoEditing,aoTabThrough, aoRowSelect, {aoAutoSort,} aoAutoWidth]
  else
    trW.options := [aoColumnSizing,aoColumnMoving,aoEditing,aoTabThrough, aoRowSelect, {aoAutoSort,} aoAutoWidth, aoMultiSelect, aoExtMultiSelect];

  ClearNodes;
  New(nd);
  nd^.id := 0;
  nd^.name := 'Всі групи';
  nd^.prew_id := -1;
  dt.Add(nd);

  if tr.InTransaction then tr.Commit;
  tr.StartTransaction;
  q.Close;
  q.SQL.Text := ' select CODE_GROUP_WARES, CODE_PARENT_GROUP_WARES, NAME '+
    '  from GROUP_WARES';
//  q.SQL.Text := 'select g.*, '' '' as maker_name from T_NOMEN_GROUPS g';
  q.ExecQuery;
  while not q.Eof do
  begin
    New(nd);
    nd^.id := q.FieldByName('CODE_GROUP_WARES').AsInteger;
    nd^.code := q.FieldByName('CODE_GROUP_WARES').AsInteger;
    nd.name := q.FieldByName('NAME').AsString;
    nd.maker_name := '';//q.FieldByName('maker_name').AsString;
    if q.FieldByName('CODE_PARENT_GROUP_WARES').IsNull then
      nd^.prew_id := 0
    else
      nd^.prew_id := q.FieldByName('CODE_PARENT_GROUP_WARES').AsInteger;
    dt.Add(nd);
    q.Next();
  end;
  if tr.InTransaction then tr.Commit;

  home := trW.Add;
  home.Values[trWColumn1.Index] := 'Всі групи';
  home.Data := dt.Items[0];
  home.SelectedIndex := 5;
  AddNode(home, 0);
  trW.Options := trW.Options + [aoAutoSort];
  trWColumn1.Sorted := csUp;
end;
//---------------------------------------------------------------------------

procedure TfTree.AddNode(var per: TdxTreeListNode; prew_id: integer);
var  cur: TdxTreeListNode;
     dt_i: ^TGroupTreeNode;
     i, count: integer;
begin
  count := dt.Count-1;
  for i := 0 to Count do
  begin
    dt_i := dt.Items[i];
    if dt_i^.prew_id = prew_id then
    begin
      cur := per.AddChild;
      cur.Values[trWColumn1.Index] := string(dt_i^.name);
      cur.Values[trWColumn2.Index] := IntToStr(dt_i^.code);
      cur.Values[trWColumn3.Index] := dt_i^.maker_name;

      cur.SelectedIndex := 5;
      cur.Data := dt_i;
      AddNode(cur, dt_i^.id);
    end;
  end;
end;
//---------------------------------------------------------------------------

procedure TfTree.trWChange(Sender: TObject; Node: TTreeNode);
begin
    prm.ActiveNode := Node.Data;
    prm.OnChengeBranch(prm);
end;
//---------------------------------------------------------------------------

procedure TfTree.FormDestroy(Sender: TObject);
begin
  ClearNodes;
  dt.Free;
end;
//---------------------------------------------------------------------------

procedure TfTree.ToolButton1Click(Sender: TObject);
var tn: PTGroupTreeNode;
    node, n_node: TdxTreeListNode;
    prew_id: integer;
begin  //Додати Гілку
{  node := trW.FocusedNode;
  tn := node.Data;

  prew_id := tn^.id;
  New(tn);

  if BranchDialog(0, prew_id, tn, prm.sGen) > 0 then
  begin
    dt.Add(tn);
    n_node := node.AddChild;
    n_node.Values[trWColumn1.Index] := tn^.name;
    n_node.Values[trWColumn2.Index] := IntToStr(tn^.code);
    n_node.Values[trWColumn3.Index] := tn.maker_name;
    n_node.Data := tn;
    n_node.SelectedIndex := 5;
  end
  else
    Dispose(tn);
 }
end;
//---------------------------------------------------------------------------

procedure TfTree.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  Action := caHide;
end;
//---------------------------------------------------------------------------

procedure TfTree.PanelResize(Sender: TObject);
begin

end;
//---------------------------------------------------------------------------

procedure TfTree.eGropNameKeyPress(Sender: TObject; var Key: Char);
begin

end;
//---------------------------------------------------------------------------

procedure TfTree.ToolButton3Click(Sender: TObject);
begin  // Refresh
  InitTreeData();
end;
//---------------------------------------------------------------------------

procedure TfTree.bt_editClick(Sender: TObject);
var tn: PTGroupTreeNode;
    node: TdxTreeListNode;
    prew_id: integer;
begin //Rename
{  node := trW.FocusedNode;
  tn := node.Data;

  if tn^.id <> 0 then
  begin
    if BranchDialog(tn.id, 0, tn, prm.sGen) > 0 then
    begin
      node.Values[trWColumn1.Index] := tn.name;
      node.Values[trWColumn2.Index] := IntToStr(tn.code);
      node.Values[trWColumn3.Index] := tn.maker_name;
    end
  end}
end;

procedure TfTree.bt_insPaint(Sender: TObject);
begin

end;

//---------------------------------------------------------------------------

procedure TfTree.ToolButton4Click(Sender: TObject);
var tn: ^TGroupTreeNode;
    node: TdxTreeListNode;
    res: integer;
begin
{  node := trW.FocusedNode;
  tn := node.Data;
  if tn^.id > 0 then
  begin
    tr.StartTransaction;
    q.SQL.Text := 'select * from T_GRP_DELETE(' + IntToStr(tn^.id) + ')';
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
  end;}
end;
//---------------------------------------------------------------------------

procedure TfTree.FormHide(Sender: TObject);
begin
  prm.Visible := false;
  prm.OnShowHide(prm);
end;

procedure TfTree.FormShow(Sender: TObject);
begin
  prm.Visible := true;
  prm.OnShowHide(prm);
end;

procedure TfTree.eGroupCodeKeyPress(Sender: TObject; var Key: Char);
begin
  if Key = #27 then
    eGropNameKeyPress(Sender, Key);
  Key := gdIntKey(Key);
end;

procedure TfTree.trWChangeNode(Sender: TObject; OldNode,
  Node: TdxTreeListNode);
begin
  prm.ActiveNode := Node.Data;
  prm.OnChengeBranch(prm);
end;

end.
