unit uTreeGrpFormLC;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ImgList, IBSQL, IBDatabase, DB, Menus, ComCtrls, ToolWin,
  StdCtrls, ExtCtrls, tree_h, dxCntner, dxTL, genstor_h, dxTLClms,
  dxExEdtr, uZControlBar, dxEditor, dxEdLib;

type
  TfTreeLC = class(TForm)
    Panel1: TPanel;
    PopupMenu: TPopupMenu;
    N1: TMenuItem;
    N2: TMenuItem;
    N5: TMenuItem;
    N4: TMenuItem;
    N3: TMenuItem;
    Base: TIBDatabase;
    tr: TIBTransaction;
    q: TIBSQL;
    ImageList1: TImageList;
    trW: TdxTreeList;
    trWColumn1: TdxTreeListColumn;
    ZControlBar1: ZControlBar;
    ToolBar2: TToolBar;
    ToolButton5: TToolButton;
    ToolButton2: TToolButton;
    ToolButton6: TToolButton;
    ToolButton1: TToolButton;
    ToolButton8: TToolButton;
    procedure trWChange(Sender: TObject; Node: TTreeNode);
    procedure FormDestroy(Sender: TObject);
    procedure ToolButton1Click(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure PanelResize(Sender: TObject);
    procedure eGropNameKeyPress(Sender: TObject; var Key: Char);
    procedure ToolButton3Click(Sender: TObject);
    procedure ToolButton2Click(Sender: TObject);
    procedure ToolButton4Click(Sender: TObject);
    procedure FormHide(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure eGroupCodeKeyPress(Sender: TObject; var Key: Char);
    procedure trWChangeNode(Sender: TObject; OldNode,
      Node: TdxTreeListNode);
    procedure eGropNameKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure eShelfKeyPress(Sender: TObject; var Key: Char);
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

function TreeCreateLC(var prm: TTreeParams): integer;
function TreeRefreshLC(var prm: TTreeParams): integer;
function TreeSelectionsLC(var prm: TTreeParams): integer;
function TreeSelectionsSpaceLC(var prm: TTreeParams): integer;
function TreeToGroupLC(var prm: TTreeParams): integer;
function TreeHideShowLC(var prm: TTreeParams): integer;
function TreeRelaseLC(var prm: TTreeParams): integer;

implementation

{$R *.dfm}
//---------------------------------------------------------------------------
// Створює дерево
function TreeCreateLC(var prm: TTreeParams): integer;
var rpt: TfTreeLC;
begin
    rpt := TfTreeLC.Create(nil);

    rpt.Base.SetHandle(prm.sGen.db_handle);
    rpt.dt := TList.Create;
    rpt.prm := prm;
    prm.Panel := rpt.Panel1;
    prm.Forma := rpt;

    rpt.InitTreeData();

    TreeCreateLC := 1;
end;

//---------------------------------------------------------------------------
// Рефрешить дерево
function TreeRefreshLC(var prm: TTreeParams): integer;
var rpt: TfTreeLC;
begin
    rpt := TfTreeLC(prm.Forma);
    rpt.InitTreeData();
    TreeRefreshLC := 1;
end;

//---------------------------------------------------------------------------
function TreeToGroupLC(var prm: TTreeParams): integer;
begin
  TfTreeLC(prm.Forma).IntoGrp(prm.SetGrpId);
  result := 1;
end;

//---------------------------------------------------------------------------
function TreeSelectionsLC(var prm: TTreeParams): integer;
var rpt: TfTreeLC;
    nd: ^TGroupTreeNode;
    i: integer;
    n: integer;
begin
  rpt := TfTreeLC(prm.Forma);
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
function TreeSelectionsSpaceLC(var prm: TTreeParams): integer;
var rpt: TfTreeLC;
    nd: ^TGroupTreeNode;
    i: integer;
begin
  rpt := TfTreeLC(prm.Forma);
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
function TreeHideShowLC(var prm: TTreeParams): integer;
begin
  if prm.Visible then
    prm.Forma.Show
  else
    prm.Forma.Hide;
  result := 1;
end;

//---------------------------------------------------------------------------
// Очистка пам'яті після закінчення роботи з деревом
function TreeRelaseLC(var prm: TTreeParams): integer;
begin
  prm.Forma.Free;
  result := 1;
end;
//---------------------------------------------------------------------------
//---------------------------------------------------------------------------

procedure TfTreeLC.ClearNodes;
begin
  while dt.Count > 0 do
  begin
    Dispose(dt.Last);
    dt.Delete(dt.Count - 1);
  end;
  trW.ClearNodes;
end;
//---------------------------------------------------------------------------

procedure TfTreeLC.FocusBranch(var nod: TdxTreeListNode; ind: integer);
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

procedure TfTreeLC.IntoGrp(ind: integer);
var node: TdxTreeListNode;
begin
  node := trW.Items[0];
  FocusBranch(node, ind);
end;
//---------------------------------------------------------------------------

procedure TfTreeLC.InitTreeData;
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
  q.SQL.Text := 'select g.* from t_grps_sync g';
  q.ExecQuery;
  while not q.Eof do
  begin
    New(nd);
    nd^.id := q.FieldByName('grp_id').AsInteger;
    nd.name := q.FieldByName('grp_name').AsString;
    if q.FieldByName('prew_grp_id').IsNull then
      nd^.prew_id := 0
    else
      nd^.prew_id := q.FieldByName('prew_grp_id').AsInteger;
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

procedure TfTreeLC.AddNode(var per: TdxTreeListNode; prew_id: integer);
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
      cur.SelectedIndex := 5;
      cur.Data := dt_i;
      AddNode(cur, dt_i^.id);
    end;
  end;
end;
//---------------------------------------------------------------------------

procedure TfTreeLC.trWChange(Sender: TObject; Node: TTreeNode);
begin
    prm.ActiveNode := Node.Data;
    prm.OnChengeBranch(prm);
end;
//---------------------------------------------------------------------------

procedure TfTreeLC.FormDestroy(Sender: TObject);
begin
  ClearNodes;
  dt.Free;
end;
//---------------------------------------------------------------------------

procedure TfTreeLC.ToolButton1Click(Sender: TObject);
var tn: PTGroupTreeNode;
    node, n_node: TdxTreeListNode;
    prew_id: integer;
begin  //Додати Гілку
  node := trW.FocusedNode;
  tn := node.Data;

  prew_id := tn^.id;
  New(tn);

  if BranchDialog(0, prew_id, tn, prm.sGen) > 0 then
  begin
    dt.Add(tn);
    n_node := node.AddChild;
    n_node.Values[trWColumn1.Index] := tn^.name;
    n_node.Data := tn;
    n_node.SelectedIndex := 5;
  end
  else
    Dispose(tn);

end;
//---------------------------------------------------------------------------

procedure TfTreeLC.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  Action := caHide;
end;
//---------------------------------------------------------------------------

procedure TfTreeLC.PanelResize(Sender: TObject);
begin

end;
//---------------------------------------------------------------------------

procedure TfTreeLC.eGropNameKeyPress(Sender: TObject; var Key: Char);
begin
  if (Key = #13) or (Key = #27) then
    eShelfKeyPress(Sender, Key);
  Key := gdStrKey(Key);
end;
//---------------------------------------------------------------------------

procedure TfTreeLC.ToolButton3Click(Sender: TObject);
begin  // Refresh
  InitTreeData();
end;
//---------------------------------------------------------------------------

procedure TfTreeLC.ToolButton2Click(Sender: TObject);
var tn: PTGroupTreeNode;
    node: TdxTreeListNode;
    prew_id: integer;
begin //Rename
  node := trW.FocusedNode;
  tn := node.Data;

  if tn^.id <> 0 then
  begin
    if BranchDialog(tn.id, 0, tn, prm.sGen) > 0 then
    begin
      node.Values[trWColumn1.Index] := tn.name;
    end  
  end
end;
//---------------------------------------------------------------------------

procedure TfTreeLC.ToolButton4Click(Sender: TObject);
var tn: ^TGroupTreeNode;
    node: TdxTreeListNode;
    res: integer;
begin
  node := trW.FocusedNode;
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
  end;
end;
//---------------------------------------------------------------------------

procedure TfTreeLC.FormHide(Sender: TObject);
begin
  prm.Visible := false;
  prm.OnShowHide(prm);
end;

procedure TfTreeLC.FormShow(Sender: TObject);
begin
  prm.Visible := true;
  prm.OnShowHide(prm);
end;

procedure TfTreeLC.eGroupCodeKeyPress(Sender: TObject; var Key: Char);
begin
  if Key = #27 then
    eGropNameKeyPress(Sender, Key);
  Key := gdIntKey(Key);
end;

procedure TfTreeLC.trWChangeNode(Sender: TObject; OldNode,
  Node: TdxTreeListNode);
begin
  prm.ActiveNode := Node.Data;
  prm.OnChengeBranch(prm);
end;

procedure TfTreeLC.eGropNameKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if Key = VK_ESCAPE then
  begin
    trW.Enabled := true;
    ToolBar2.Visible := true;
    trW.SetFocus;
  end
end;

procedure TfTreeLC.eShelfKeyPress(Sender: TObject; var Key: Char);
begin

end;

end.
