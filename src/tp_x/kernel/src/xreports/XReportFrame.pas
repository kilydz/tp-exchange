(*
*  модуль містить дерево класів фреймів для введення інформації  в звітах
*
*)
unit XReportFrame;

interface
uses xutils_h, kernel_h, checkedlist, Windows,
    ExtCtrls,Classes, Dialogs, dxEditor, dxEdLib, Controls, SysUtils, dxTL, dxTLClms,
    uZFilterCombo;

type
//------------------------------------------------------------------------------
  XFrame = class(TPanel) //батько для всіх фреймів
  protected
    panel_caption:Tpanel;
    panel_component:Tpanel;
    procedure   SetCaption(const s:string);
    function    GetCaption:string;
    procedure   SetText(const s:string); virtual; abstract;
    function    GetText:string; virtual; abstract;
  public
    constructor Create(Aowner:TComponent); override;
    destructor  Free; virtual;
    procedure   Show(const width:integer);   virtual;
    procedure   AddString(const s:string); virtual; abstract;
    procedure   Init (const s:string); virtual; abstract;
    property Text:string read GetText write SetText;
    property Caption:string read GetCaption write SetCaption;
  end;
//------------------------------------------------------------------------------
  XFrameDate = class(XFrame)
  protected
    date_component:TdxDateEdit;
    procedure   SetText(const s:string); override;
    function   GetText:string; override;

  public
    constructor Create(Aowner:TComponent);   override;
    destructor  Free;   override;
    procedure   Show(const width:integer);   override;
    procedure   Init (const s:string); override;
    property Text:string read GetText write SetText;
  end;
//------------------------------------------------------------------------------
  XFrameInt = class(XFrame)
  protected
    int_component: TdxSpinEdit;
    procedure   SetText(const s:string); override;
    function   GetText:string; override;

  public
    constructor Create(Aowner:TComponent);   override;
    destructor  Free;   override;
    procedure   Show(const width:integer);   override;
    procedure   Init (const s:string); override;
    property Text:string read GetText write SetText;
  end;

//------------------------------------------------------------------------------
  XFrameList = class(XFrame)
  protected
    list_component:TdxPickEdit;
    procedure  SetText(const s:string); override;
    function   GetText:string; override;
  public
    constructor Create(Aowner:TComponent); override;
    destructor  Free;   override;
    procedure   Show(const width:integer);   override;
    procedure   Init (const s:string); override;
    procedure   AddString(const s:string); override;
    property Text:string read GetText write SetText;
  end;

//------------------------------------------------------------------------------
  XFrameIdList = class(XFrame)
  protected
    list_component:TdxImageEdit;
    procedure  SetText(const s:string); override;
    function   GetText:string; override;
  public
    constructor Create(Aowner:TComponent);   override;
    destructor  Free;   override;
    procedure   Show(const width:integer);   override;
    procedure   Init (const s:string); override;
    procedure   AddString(const id: integer; const s:string);
//    procedure   AddString(const s:string); override;
    property Text:string read GetText write SetText;
  end;

//------------------------------------------------------------------------------
  XFrameCheckList = class(XFrame)
  protected
    popup_component: TdxPopupEdit;
    check_list_component: XFilterCombo;
    unvisible_panel: TPanel;

    procedure  SetText(const s:string); override;
    function   GetText:string; override;
    procedure PopupCloseUp(Sender: TObject;
                   var Text: String; var Accept: Boolean);
    procedure FillText();
  public
    constructor Create(Aowner:TComponent; sql: string; isGen:XVelesInfoRec);
    destructor  Free;   override;
    procedure   Show(const width:integer);   override;
    procedure   Init (const s:string); override;
//    procedure   AddString(const s:string); override;
    property Text:string read GetText write SetText;
  end;

//------------------------------------------------------------------------------
  XFrameTree = class(XFrame)
  protected
    tree_component:TdxPopupEdit;
    tree_prm: XTreeParams;
    procedure  SetText(const s:string); override;
    function   GetText:string; override;
  public
    constructor Create(Aowner:TComponent; sql: string; isGen:XVelesInfoRec);
    destructor  Free;   override;
    procedure   Show(const width:integer);   override;
    procedure   Init (const s:string); override;
    property Text:string read GetText write SetText;
  end;

//------------------------------------------------------------------------------
  XFrameDxTree = class(XFrame)
  protected
    //tree_component:TdxPopupEdit;
    ftext:string;
    procedure  SetText(const s:string); override;
    function   GetText:string; override;

  public
    dxTree:XCheckedList;
    constructor Create(Aowner:TComponent);override;
    destructor  Free;   override;
    procedure   Init (const s:string); override;
    procedure   Show(const width:integer);   override;
    property Text:string read GetText write SetText;
    procedure  AddRecord(const s1,s2,s3:string);
//    procedure  dxTreeKeyUp(Sender: TObject; var Key: Word; Shift: TShiftState);
  end;

//function ChengeBranchEv(var prm: TTreeParams): integer;
//function ShowHideEv(var prm: TTreeParams): integer;

implementation

uses udialogformreport;

//------------------------------------------------------------------------------
//XFrame
//------------------------------------------------------------------------------

constructor XFrame.create(Aowner:TComponent);
begin
    inherited create(AOwner);
    self.Height:=21;
    //self.parent := AOwner as Twincontrol;
    panel_caption := tpanel.create(AOwner);
    panel_caption.parent := self;
    panel_component := tpanel.create(AOwner);
    panel_component.parent := self;
end;
//------------------------------------------------------------------------------
destructor  XFrame.free;
begin
//  inherited free;
end;

//------------------------------------------------------------------------------
procedure XFrame.Show(const width:integer);
begin
   self.Width := width;
   with panel_caption do
    begin
      BevelInner := bvNone;
      BevelOuter := bvNone;
      left:=0;
      top:=0;
      width:= self.Width div 2;
      height := self.Height;
    end;

    with panel_component do
    begin
      BevelInner := bvNone;
      BevelOuter := bvNone;
      left:=panel_caption.width;
      top:=0;
      width:= self.Width - panel_caption.width;
      height := self.height;
    end;
    self.Visible := true;
end;

//------------------------------------------------------------------------------
procedure XFrame.SetCaption(const s:string);
begin
   panel_caption.Caption := s;
end;
function XFrame.GetCaption;
begin
   GetCaption := panel_caption.Caption;
end;

//------------------------------------------------------------------------------
//XFrameDate
//------------------------------------------------------------------------------
constructor XFrameDate.Create(Aowner:TComponent);
begin
    inherited create(AOwner);
    date_component := TdxDateEdit.create(AOwner);
    date_component.parent := self.panel_component;
end;
//------------------------------------------------------------------------------
destructor  XFrameDate.Free;
begin
  ShowMessage('Tree destructor');
  inherited free;
end;
//------------------------------------------------------------------------------
procedure   XFrameDate.Show(const width:integer);
begin
    inherited Show(width);
    with date_component do
    begin
      {
      left:=panel_caption.width;
      top:=0;
      width:= self.Width - panel_caption.width;
      height := self.height;
      }
      width:= self.panel_component.Width;
    end;

    date_component.Visible := true;
end;
//------------------------------------------------------------------------------
procedure   XFrameDate.SetText(const s:string);
begin
   date_component.Text := s;
end;
//------------------------------------------------------------------------------
function   XFrameDate.GetText:string;
begin
   GetText:=date_component.Text;
end;

procedure   XFrameDate.Init (const s:string);
begin
   self.Text := dateToStr(date);
end;

//------------------------------------------------------------------------------
//XFrameInt
//------------------------------------------------------------------------------
constructor XFrameInt.Create(Aowner:TComponent);
begin
    inherited create(AOwner);
    int_component := TdxSpinEdit.create(AOwner);
    int_component.parent := self.panel_component;
end;
//------------------------------------------------------------------------------
destructor  XFrameInt.Free;
begin
  inherited free;
end;
//------------------------------------------------------------------------------
procedure   XFrameInt.Show(const width:integer);
begin
    inherited Show(width);
    with int_component do
    begin
      {
      left:=panel_caption.width;
      top:=0;
      width:= self.Width - panel_caption.width;
      height := self.height;
      }
      width:= self.panel_component.Width;
    end;

    int_component.Visible := true;
end;
//------------------------------------------------------------------------------
procedure   XFrameInt.SetText(const s:string);
begin
   int_component.Text := s;
end;
//------------------------------------------------------------------------------
function   XFrameInt.GetText:string;
begin
   GetText:=int_component.Text;
end;

procedure   XFrameInt.Init (const s:string);
begin
   self.Text := '1';
end;

//------------------------------------------------------------------------------
//XFrameList
//------------------------------------------------------------------------------
constructor XFrameList.Create(Aowner:TComponent);
begin
    inherited create(AOwner);
    list_component := TdxPickEdit.create(self.panel_component);
    list_component.parent := self.panel_component;
end;
//------------------------------------------------------------------------------
destructor  XFrameList.Free;
begin
  inherited free;
end;
//------------------------------------------------------------------------------
procedure   XFrameList.Show(const width:integer);
begin
   inherited Show(width);
   with list_component do
    begin
    {
      left:=panel_caption.width;
      top:=0;
      width:= self.Width - panel_caption.width;
      height := self.height;
      }
      width:= self.panel_component.Width;
    end;

   list_component.Visible := true;
end;
//------------------------------------------------------------------------------
procedure   XFrameList.SetText(const s:string);
begin
   list_component.Text := s;
end;
//------------------------------------------------------------------------------
function   XFrameList.GetText:string;
begin
   GetText:=list_component.Text;
end;

procedure  XFrameList.AddString(const s:string);
begin
   list_component.Items.add(s);
end;

procedure   XFrameList.Init (const s:string);
begin
   self.Text := s;
end;

//------------------------------------------------------------------------------
//XFrameIdList
//------------------------------------------------------------------------------
constructor XFrameIdList.Create(Aowner:TComponent);
begin
    inherited create(AOwner);
    list_component := TdxImageEdit.create(self.panel_component);
    list_component.parent := self.panel_component;
end;
//------------------------------------------------------------------------------
destructor  XFrameIdList.Free;
begin
  inherited free;
end;
//------------------------------------------------------------------------------
procedure   XFrameIdList.Show(const width:integer);
begin
   inherited Show(width);
   with list_component do
    begin
    {
      left:=panel_caption.width;
      top:=0;
      width:= self.Width - panel_caption.width;
      height := self.height;
      }
      width:= self.panel_component.Width;
    end;

   list_component.Visible := true;
end;
//------------------------------------------------------------------------------
procedure   XFrameIdList.SetText(const s:string);
begin
   list_component.Text := s;
end;
//------------------------------------------------------------------------------
function   XFrameIdList.GetText:string;
begin
   GetText:=list_component.Text;
end;

procedure  XFrameIdList.AddString(const id: integer; const s:string);
begin
   list_component.Values.Add(IntToStr(id));
   list_component.Descriptions.Add(s);
end;

procedure   XFrameIdList.Init (const s:string);
begin
   self.Text := s;
end;

//------------------------------------------------------------------------------
//XFrameCheckList
//------------------------------------------------------------------------------
constructor XFrameCheckList.Create(Aowner:TComponent; sql: string; isGen:XVelesInfoRec);
begin
    inherited create(AOwner);

    popup_component := TdxPopupEdit.Create(AOwner);
    popup_component.parent := self.panel_component;
    popup_component.OnCloseUp := PopupCloseUp;
    popup_component.Align := alClient;

    unvisible_panel := TPanel.Create(AOwner);
    unvisible_panel.Width := 200;
    unvisible_panel.Height := 200;
    unvisible_panel.Visible := false;
    unvisible_panel.Parent := TWinControl(AOwner);

    popup_component.PopupControl := unvisible_panel;

    check_list_component := XFilterCombo.create(unvisible_panel);
    check_list_component.Parent := unvisible_panel;
    check_list_component.Align := alClient;
    check_list_component.FillFromSQL(sql, isGen.db_handle);
end;
//------------------------------------------------------------------------------
destructor  XFrameCheckList.Free;
begin
  inherited free;
end;
//------------------------------------------------------------------------------
procedure   XFrameCheckList.Show(const width:integer);
begin
   inherited Show(width);
   with check_list_component do
    begin
      {
      left:=panel_caption.width;
      top:=0;
      width:= self.Width - panel_caption.width;
      height := self.height;
      }
      width:= self.panel_component.Width;
    end;

   check_list_component.Visible := true;
end;
//------------------------------------------------------------------------------
procedure   XFrameCheckList.SetText(const s:string);
begin
  // check_list_component.Text := s;
end;
//------------------------------------------------------------------------------
function   XFrameCheckList.GetText:string;
begin

   GetText := check_list_component.GenerateSpaceList;
   //showmessage(TreePrm.grp_list);
end;
//------------------------------------------------------------------------------
procedure XFrameCheckList.Init (const s:string);
begin
   self.Text := s;
   FillText;
end;

procedure XFrameCheckList.FillText;
var cnt: integer;
begin
  cnt := check_list_component.GetCheckedCount;
  popup_component.Text := 'Виділено ' + IntToStr(cnt) + ' елементів.';
end;

procedure XFrameCheckList.PopupCloseUp(Sender: TObject; var Text: String; var Accept: Boolean);
begin
  FillText();
end;

//------------------------------------------------------------------------------
//XFrameTree
//------------------------------------------------------------------------------
constructor XFrameTree.Create(Aowner:TComponent; sql: string; isGen:XVelesInfoRec);
begin
    inherited create(AOwner);
    tree_component := TdxPopupEdit.create(AOwner);
    tree_component.parent := self.panel_component;
    tree_prm.ed_popup := @tree_component;
    tree_prm.owner := Aowner;
    GTreeCreate(sql, @tree_prm, isGen);
end;
//------------------------------------------------------------------------------
destructor  XFrameTree.Free;
begin
  if tree_prm.ftree <> nil then GTreeFree(@tree_prm);
  inherited free;
end;
//------------------------------------------------------------------------------
procedure   XFrameTree.Show(const width:integer);
begin
   inherited Show(width);
   with tree_component do
    begin
      {
      left:=panel_caption.width;
      top:=0;
      width:= self.Width - panel_caption.width;
      height := self.height;
      }
      width:= self.panel_component.Width;
    end;

   tree_component.Visible := true;
   GTreeToGroup(@tree_prm, 0);
end;
//------------------------------------------------------------------------------
procedure   XFrameTree.SetText(const s:string);
begin
   tree_component.Text := s;
end;
//------------------------------------------------------------------------------
function   XFrameTree.GetText:string;
begin
   GetText:=IntToStr(GTreeResult(@tree_prm).id);
end;
//------------------------------------------------------------------------------
procedure   XFrameTree.Init (const s:string);
begin
   self.Text := s;
end;

//------------------------------------------------------------------------------
//XFrameDxTree
//------------------------------------------------------------------------------
constructor XFrameDxTree.Create(Aowner:TComponent);
//var NewCol:TdxTreeListColumn;
begin
    inherited create(AOwner);
    //tree_component := TdxPopupEdit.create(self.panel_component);
    //tree_component.parent := self.panel_component;
    self.height := 100;
    dxTree := XCheckedList.create(self);
    dxTree.parent := Aowner as TWinControl;
    dxTree.Width := self.Width;
    self.panel_caption.Height := 21;
    self.panel_component.Height := 21;
    self.height := self.height - SELF.panel_caption.Height;
end;
//------------------------------------------------------------------------------
destructor  XFrameDxTree.Free;
begin
  inherited free;
  if dxTree <> nil then dxTree.Destroy;
end;
//------------------------------------------------------------------------------
procedure   XFrameDxTree.Show(const width: integer);
begin
   inherited Show(width);
   with panel_caption do
    begin
       height := 21;
    end;

    with panel_component do
    begin
      height := 21;
    end;
    dxTree.Width:=self.Width;
    dxTree.Top := self.panel_caption.Height;
    dxTree.Parent := self;
    self.dxTree.Visible := true;
   //tree_component.width:= self.panel_component.Width;
   //tree_component.Visible := true;
end;
//------------------------------------------------------------------------------
procedure   XFrameDxTree.SetText(const s:string);
begin
   //tree_component.Text := s;
   //ftext := s;
   // через кому всі відмічені позиції, щоб позначалися TODO поки мабуть не треба
   showmessage('dont todo');
end;
//------------------------------------------------------------------------------
function   XFrameDxTree.GetText:string;
begin
  // GetText:=tree_component.Text;
   // через кому всі відмічені позиції TODO
   result := dxtree.GetCheckedId;
end;
//------------------------------------------------------------------------------
procedure   XFrameDxTree.Init (const s:string);
begin
   self.Text := s;
end;
//------------------------------------------------------------------------------
procedure  XFrameDxTree.AddRecord(const s1,s2,s3:string);
//var Node: TdxTreeListNode;
begin
   {Node := dxTree.Add;
   Node.Values[0] := s1;
   Node.Values[1] := s2;
   Node.Values[2] := s3;}
   dxtree.AddRecord(s1,s2,s3);

end;


end.
