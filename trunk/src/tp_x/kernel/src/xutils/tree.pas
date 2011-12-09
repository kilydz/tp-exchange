unit tree;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, dxExEdtr, dxTL, dxCntner, ImgList, IBSQL, IBDatabase, DB, Menus,
  ExtCtrls, StdCtrls, kernel_h, zutils_h, uZbutton;

type
  Tftree = class(TForm)
    panel: TPanel;
    ed_tree_list: TdxTreeList;
    trWColumn1: TdxTreeListColumn;
    Base: TIBDatabase;
    tr: TIBTransaction;
    q: TIBSQL;
    Panel2: TPanel;
    PopupMenu1: TPopupMenu;
    bt_ok: ZButton;
    procedure bt_okClick(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure ed_tree_listChangeNode(Sender: TObject; OldNode,
      Node: TdxTreeListNode);
  private
    { Private declarations }
  public
    { Public declarations }
    sql: string;     // select ogrp_id, oprew_grp_id, oname from PU_****
    tree_prm: lpZTreeParams;
    prm: ZVelesInfoRec;

    dt: TList;

    procedure InitInfo;
    procedure FillTree;
    procedure FocusBranch(var node0: TdxTreeListNode; grp_id: integer);
    procedure IntoGrp(grp_id: integer);
    procedure AddNode(var per: TdxTreeListNode; prew_id: integer);
    procedure ClearNodes;
  end;

procedure GTreeCreate(sql: string; tree_prm: lpZTreeParams; prm: ZVelesInfoRec);
function GTreeResult(tree_prm: lpZTreeParams): lpZGroupTreeNode;
procedure GTreeToGroup(tree_prm: lpZTreeParams; grp_id: integer);
procedure GTreeFree(tree_prm: lpZTreeParams);

implementation

{$R *.dfm}

procedure GTreeCreate(sql: string; tree_prm: lpZTreeParams; prm: ZVelesInfoRec);
var dlg: Tftree;
begin
  dlg := Tftree.Create(TComponent(tree_prm.owner));

  dlg.sql := sql;
  dlg.tree_prm := tree_prm;
  dlg.prm := prm;

  dlg.InitInfo;

//  tree_prm := dlg.tree_prm;
end;

function GTreeResult(tree_prm: lpZTreeParams): lpZGroupTreeNode;
var dlg: Tftree;
  //  ptree_prm: ZTreeParams;
begin
//  ptree_prm := ^tree_prm;
  dlg := Tftree(tree_prm.ftree);
  GTreeResult := dlg.tree_prm.active_node;
end;

procedure GTreeToGroup(tree_prm: lpZTreeParams; grp_id: integer);
begin
  TfTree(tree_prm.ftree).IntoGrp(grp_id);
end;

procedure GTreeFree(tree_prm: lpZTreeParams);
begin
  Tftree(tree_prm.ftree).Free;
end;

procedure Tftree.InitInfo;  // заповнення фільтра
begin
  base.SetHandle(prm.db_handle);
  tree_prm.ftree := self;
  dt := TList.Create;

  FillTree;

  tree_prm.ed_popup.PopupControl := panel;
end;

procedure Tftree.FillTree;
var nd: ^ZGroupTreeNode;
    home: TdxTreeListNode;
begin
  ClearNodes;
  New(nd);
  nd^.id := 0;
  nd^.name := 'Всі групи';
//  tree_prm.ed_popup.Text := nd^.name;
  nd^.prew_id := -1;
  dt.Add(nd);

  if tr.InTransaction then tr.Commit;
  tr.StartTransaction;
   q.Close;
   q.SQL.Text := sql;
   q.ExecQuery;
   while not q.Eof do
   begin
     New(nd);
     nd^.id := q.FieldByName('ogrp_id').AsInteger;
     nd^.name := q.FieldByName('oname').AsString;
     if q.FieldByName('oprew_grp_id').IsNull then
       nd^.prew_id := 0
     else
       nd^.prew_id := q.FieldByName('oprew_grp_id').AsInteger;
     dt.Add(nd);
     q.Next();
   end;
  if tr.InTransaction then tr.Commit;

   home := ed_tree_list.Add;
   home.Values[trWColumn1.Index] := 'Всі групи';
   home.Data := dt.Items[0];
//   home.SelectedIndex := 5;
   AddNode(home, 0);
   ed_tree_list.Options := ed_tree_list.Options + [aoAutoSort];
   trWColumn1.Sorted := csUp;
end;

procedure TfTree.FocusBranch(var node0: TdxTreeListNode; grp_id: integer);
var nd: lpZGroupTreeNode;
    i: integer;
    node: TdxTreeListNode;
begin
  for i := 0 to node0.Count - 1 do
  begin
    node := node0.Items[i];
    FocusBranch(node, grp_id);
    nd := node0.Items[i].Data;
    if nd^.id = grp_id then
    begin
      node0.Items[i].Focused := true;
      node0.Items[i].Selected := true;
    end
  end;
end;

procedure Tftree.IntoGrp(grp_id: integer);
var node: TdxTreeListNode;
begin
  node := ed_tree_list.Items[0];

  if grp_id = 0 then
    ed_tree_listChangeNode(nil, node, node)
  else
    FocusBranch(node, grp_id);
end;

procedure Tftree.AddNode(var per: TdxTreeListNode; prew_id: integer);
var  cur: TdxTreeListNode;
     dt_i: ^ZGroupTreeNode;
     i: integer;
begin
  for i := 0 to dt.Count-1 do
  begin
    dt_i := dt.Items[i];
    if dt_i^.prew_id = prew_id then
    begin
      cur := per.AddChild;
      cur.Values[trWColumn1.Index] := string(dt_i^.name);
      cur.SelectedIndex := 5;
      cur.Data := dt_i;
      AddNode(cur, dt_i^.id);
    end;
  end;
end;

procedure Tftree.ClearNodes;
begin
  while dt.Count > 0 do
  begin
    Dispose(dt.Last);
    dt.Delete(dt.Count - 1);
  end;
  ed_tree_list.ClearNodes;
end;

procedure Tftree.bt_okClick(Sender: TObject);
begin
  (panel.Parent as TdxPopupEditForm).ModalResult := mrOk;
end;

procedure Tftree.FormDestroy(Sender: TObject);
begin
  ClearNodes;
  dt.Free;
end;

procedure Tftree.ed_tree_listChangeNode(Sender: TObject; OldNode,
  Node: TdxTreeListNode);
begin
  tree_prm.active_node := Node.Data;
  tree_prm.ed_popup.Text := tree_prm.active_node^.name;
end;

end.
