unit checkedlist;
interface
uses SysUtils, Dialogs, Windows, dxTL, dxTLClms, Classes, ExtCtrls;

type ZCheckedList = class (TdxTreeList)

//  procedure
  procedure  AddRecord(const s1,s2,s3:string);
  constructor Create(Aowner:TComponent);  override;
  procedure KeyDown(Sender: TObject; var Key: Word; Shift: TShiftState); //override; //OnKeyDown
  procedure MouseDblClick(Sender: TObject);
  function GetCheckedId: string;
end;


implementation

//------------------------------------------------------------------------------
//XCheckedList
//------------------------------------------------------------------------------
constructor ZCheckedList.Create(Aowner:TComponent);
var NewCol:TdxTreeListColumn;
begin
    inherited create(AOwner);


    //self.parent:=panel;

    self.Visible := false;
    self.ShowLines := false;
    self.ShowHeader := false;


    NewCol := TdxTreeListCheckColumn.Create(self);
    NewCol.Index := self.ColumnCount;
    NewCol.Width := 40;
    NewCol.TreeList := self;

    NewCol := TdxTreeListColumn.Create(self);
    NewCol.Index := self.ColumnCount;
    NewCol.Visible := false;
    NewCol.TreeList := self;

    NewCol := TdxTreeListColumn.Create(self);
    NewCol.Index := self.ColumnCount;
    NewCol.Width := 200;
    NewCol.TreeList := self;
    OnKeyDown := KeyDown;
    OnDblClick := MouseDblClick; 
end;
//--------------------------------------------------------------------------------
procedure ZCheckedList.KeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
  if Key = VK_SPACE then
  begin
    MouseDblClick(Sender);
    Shift := [];
    Key := 0;
  end;
end;

//--------------------------------------------------------------------------------
procedure ZCheckedList.AddRecord(const s1,s2,s3:string);
var Node: TdxTreeListNode;
begin
   Node := self.Add;
   Node.Values[0] := s1;
   Node.Values[1] := s2;
   Node.Values[2] := s3;
end;
//--------------------------------------------------------------------------------
procedure ZCheckedList.MouseDblClick(Sender: TObject);
begin
  if (sender as TdxTreeList).FocusedNode.Values[0] = 'true' then (sender as TdxTreeList).FocusedNode.Values[0] := 'false'
       else (sender as TdxTreeList).FocusedNode.Values[0] := 'true';
end;

//--------------------------------------------------------------------------------
function ZCheckedList.GetCheckedId: string;
    var i:integer;
begin
    result := '';
    for i:= 0 to self.Count - 1 do
        if self.Items[i].Values[0] = 'true' then
        begin
            if  result <>'' then result := result + ', ' +inttostr(self.Items[i].Values[1])
                else  result := inttostr(self.Items[i].Values[1]);
        end;
//    showmessage(result);
end;

end.
