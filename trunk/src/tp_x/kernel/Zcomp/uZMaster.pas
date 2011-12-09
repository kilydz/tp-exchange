unit uZMaster;

interface
uses
  Windows, Messages, SysUtils, Classes, Controls, Tabs, ExtCtrls, TypInfo,
  uZButton, Graphics, dxEditor, dxExEdtr, dxEdLib, dxCntner, StdCtrls;

type
  ZMasterResult = (MasterResultOk=idOk,
                   MasterResultCancel = idCancel,
                   MasterResultNext = idYes,
                   MasterResultBack = idRetry);

  ZMasterResultEvent = procedure (Sender: TObject; MasterResult: ZMasterResult) of object;

  ZPanel = record
    caption: string;
    panel: TPanel;
  end;

  ZMaster = class(TWinControl)
  private
    { Private declarations }
    panels: TList;
    tab_set: TTabSet;

    top_panel: TPanel;

    bottom_panel: TPanel;
    bt_cancel: ZButton;
    bt_back: ZButton;
    bt_next: ZButton;
    bt_ok: ZButton;

    master_result: ZMasterResultEvent;
    page_change: TTabChangeEvent;

    function Get(index: integer): ZPanel;
    function GetPageIndex: integer;
    procedure SetPageIndex(tab: integer);
    function IsThisControlEdit(tab, control_idx: integer): boolean;

    procedure panelResize(Sender: TObject);
    procedure bt_nextClick(Sender: TObject);
    procedure bt_backClick(Sender: TObject);
    procedure bt_cancelClick(Sender: TObject);
    procedure bt_okClick(Sender: TObject);
    procedure tab_setChange(Sender: TObject; NewTab: Integer;
                 var AllowChange: Boolean);

  protected
    { Protected declarations }
  public
    { Public declarations }
    constructor Create(AOwner:TComponent); override;
    destructor Destroy; override;

    procedure PagesClear;
    function  PagesCount: integer;
    property  Pages[index: integer]: ZPanel read Get; default;
    function  PageAdd(caption: string; var panel: TPanel): integer;
    property  PageIndex: integer read GetPageIndex write SetPageIndex;

    procedure SetFocusAtFirstEdit(tab: integer);
    procedure SetFocusAtNextEdit(var control: TControl);
  published
    { Published declarations }
    property Align;
    property Visible;
    property Autosize;
    property Anchors;
    property Constraints;

    property OnMasterResult: ZMasterResultEvent
                  read master_result write master_result;
    property OnPageChange: TTabChangeEvent
                  read page_change write page_change;
  end;

procedure Register;

implementation

procedure Register;
begin
  RegisterComponents('Freedom', [ZMaster]);
end;

constructor ZMaster.Create(AOwner:TComponent);
begin
  inherited Create(AOwner);

  Width := 360;
  Height := 225;

  panels := TList.Create;

  // Ініціалізація верхньої панелі
  top_panel := TPanel.Create(Self);
  top_panel.Parent := Self;
  top_panel.Visible := true;
  top_panel.Align := alTop;
  top_panel.Color := clBtnFace;
  top_panel.Height := 34;
  top_panel.Font.Height := 18;
  top_panel.Font.Style := [fsBold];
  top_panel.Font.Color := clDkGray;
{
  bt_next := ZButton.Create(top_panel);
  bt_next.Parent := top_panel;
  bt_next.Visible := true;
  bt_next.OnClick := bt_nextClick;
  bt_next.Caption := '>>';//'Прийняти';
  bt_next.Height := 25;
  bt_next.Width := 30;
  bt_next.Top := 4;
  bt_next.Hint := 'Наступна вкладка';
  bt_next.ShowHint := true;
  bt_next.Blink := true;

  bt_back := ZButton.Create(top_panel);
  bt_back.Parent := top_panel;
  bt_back.Visible := false;
  bt_back.OnClick := bt_backClick;
  bt_back.Caption := '<<'; //'Назад';
  bt_back.Left := 4;
  bt_back.Height := 25;
  bt_back.Width := 30;
  bt_back.Top := 4;
  bt_back.Hint := 'Попередня вкладка';
  bt_back.ShowHint := true;
}
  // Ініціалізація нижньої панелі з кнопками
  bottom_panel := TPanel.Create(Self);
  bottom_panel.Parent := Self;
  bottom_panel.Visible := true;
  bottom_panel.Align := alBottom;
  bottom_panel.Height := 32;
  bottom_panel.OnResize := panelResize;

  bt_ok := ZButton.Create(bottom_panel);
  bt_ok.Parent := bottom_panel;
  bt_ok.Visible := true;
  bt_ok.OnClick := bt_okClick;
  bt_ok.Caption := 'Прийняти';
  bt_ok.Height := 25;
  bt_ok.Width := 105;
  bt_ok.Top := 4;
  bt_ok.Hint := 'Прийняти зміни ' + #13 + '(Ctrl+Enter)';
  bt_ok.ShowHint := true;

  bt_next := ZButton.Create(bottom_panel);
  bt_next.Parent := bottom_panel;
  bt_next.Visible := true;
  bt_next.OnClick := bt_nextClick;
  bt_next.Caption := 'Далі >>';//'Далі';
  bt_next.Height := 25;
  bt_next.Width := 70;
  bt_next.Top := 4;
  bt_next.Hint := 'Наступна вкладка';
  bt_next.ShowHint := true;
  bt_next.Blink := true;

  bt_back := ZButton.Create(bottom_panel);
  bt_back.Parent := bottom_panel;
  bt_back.Visible := false;
  bt_back.OnClick := bt_backClick;
  bt_back.Caption := '<< Назад'; //'Назад';
  bt_back.Left := 84;
  bt_back.Height := 25;
  bt_back.Width := 75;
  bt_back.Top := 4;
  bt_back.Hint := 'Попередня вкладка';
  bt_back.ShowHint := true;
{
  bt_back := ZButton.Create(bottom_panel);
  bt_back.Parent := bottom_panel;
  bt_back.Visible := false;
  bt_back.OnClick := bt_backClick;
  bt_back.Caption := '<< Назад'; //'Назад';
  bt_back.Left := 280;
  bt_back.Height := 25;
  bt_back.Width := 70;
  bt_back.Top := 4;
  bt_back.Hint := 'Попередня вкладка';
  bt_back.ShowHint := true;
 }
  bt_cancel := ZButton.Create(bottom_panel);
  bt_cancel.Parent := bottom_panel;
  bt_cancel.Visible := true;
  bt_cancel.OnClick := bt_cancelClick;
  bt_cancel.Caption := 'Відмова';
  bt_cancel.Height := 25;
  bt_cancel.Width := 75;
  bt_cancel.Top := 4;
  bt_cancel.Left := 4;
  bt_cancel.Hint := 'Відкинути зміни ' + #13 + '(Alt+F4)';
  bt_cancel.ShowHint := true;

  // Ініціалізація закладок панелі
  tab_set := TTabSet.Create(Self);
  tab_set.Parent := Self;
  tab_set.Visible := false;
  tab_set.Align := alBottom;
  tab_set.OnChange := tab_setChange;
end;

destructor ZMaster.Destroy;
begin
  inherited Destroy;
  PagesClear;
  if panels <> nil then panels.Free;
end;

procedure ZMaster.PagesClear;
var i: integer;
    lp_panel: ^ZPanel;
begin
  if panels = nil then
    exit;

  for i := 0 to panels.Count - 1 do
  begin
    lp_panel := panels.Items[i];
    Dispose(lp_panel);
  end;
  panels.Clear;
end;

function ZMaster.PagesCount: integer;
begin
  PagesCount := panels.Count;
end;

function ZMaster.PageAdd(caption: string; var panel: TPanel): integer;
var lp_panel: ^ZPanel;
    i: integer;
begin
  New(lp_panel);
  lp_panel^.caption := caption;
  lp_panel^.panel   := panel;
  lp_panel.panel.Parent := self;
  lp_panel.panel.Visible := (panels.Count = 0);
  lp_panel.panel.Align := alClient;
  PageAdd := panels.Count - 1;

  panels.Add(lp_panel);
  tab_set.Tabs.Add(caption);
  top_panel.Caption := caption;

  bt_next.Visible := panels.Count > 1;
end;

function ZMaster.Get(index: integer): ZPanel;
var lp_panel: ^ZPanel;
begin
  lp_panel := panels.Items[index];
  Get := lp_panel^;
end;

function ZMaster.GetPageIndex: integer;
begin
  GetPageIndex := tab_set.TabIndex;
end;

procedure ZMaster.SetPageIndex(tab: integer);
begin
  tab_set.TabIndex := tab;
end;

// перевірка, чи є контрол едітом
function ZMaster.IsThisControlEdit(tab, control_idx: integer): boolean;
begin
  IsThisControlEdit :=
           GetPropInfo(TObject(Pages[tab].panel.Controls[control_idx]),
           'TabOrder') <> nil;
end;

// установка фокусу на перший контрол сторінки
procedure ZMaster.SetFocusAtFirstEdit(tab: integer);
var i: integer;
    curr_panel: TPanel;
    min_tab_index: integer;
begin
  if (not Pages[tab].panel.Visible)
    then exit;

  curr_panel := Pages[tab].panel;
  // пошук першого активного елемента для встановлення фокусу вводу
  i := 0;
  min_tab_index := -1;
  while (i < curr_panel.ControlCount) do
  begin
    if IsThisControlEdit(tab, i) and curr_panel.Controls[i].Enabled then
    begin
      if min_tab_index = -1 then
        min_tab_index := i;
      if (TWinControl(curr_panel.Controls[min_tab_index]).TabOrder >
          TWinControl(curr_panel.Controls[i]).TabOrder) then
        min_tab_index := i;
    end;
    i := i + 1;
  end;
  TWinControl(curr_panel.Controls[min_tab_index]).SetFocus;
end;

// установка фокусу на наступний контрол сторінки
procedure ZMaster.SetFocusAtNextEdit(var control: TControl);
var i: integer;
    is_not_edit: boolean;
    next_tab_order: integer;
begin
  i := 0;
  while ((i < Pages[tab_set.TabIndex].panel.ControlCount) and
         (Pages[tab_set.TabIndex].panel.Controls[i] <> control)) do
  begin
    i := i + 1;
  end;

  is_not_edit := true;
  next_tab_order := TWincontrol(control).TabOrder + 1;
  i := 0;
  while (i < Pages[tab_set.TabIndex].panel.ControlCount) and is_not_edit do
  begin
    if IsThisControlEdit(tab_set.TabIndex, i) then
    begin
//  try
      if TWinControl(Pages[tab_set.TabIndex].panel.Controls[i]).TabOrder = next_tab_order then
        if  Pages[tab_set.TabIndex].panel.Controls[i].Enabled and
            Pages[tab_set.TabIndex].panel.Controls[i].Visible and
            TWinControl(Pages[tab_set.TabIndex].panel.Controls[i]).TabStop and
            not TCustomEdit(Pages[tab_set.TabIndex].panel.Controls[i]).ReadOnly
        then
        begin
          TWinControl(Pages[tab_set.TabIndex].panel.Controls[i]).SetFocus;
          is_not_edit := false;
        end
        else
        begin
          next_tab_order := next_tab_order + 1;
          i := 0;
        end;
 // except

 // end;
    end;
    i := i + 1;
  end;

  if (tab_set.TabIndex < tab_set.Tabs.Count - 1) and is_not_edit  then
    tab_set.TabIndex := tab_set.TabIndex + 1
  else
    if is_not_edit then
      bt_ok.SetFocus;
end;

procedure ZMaster.panelResize(Sender: TObject);
begin
//  bt_back.Left := 4;
  bt_next.Left := bottom_panel.Width - bt_next.Width - 115;
  bt_ok.Left := bottom_panel.Width - bt_ok.Width - 4;
end;

procedure ZMaster.bt_nextClick(Sender: TObject);
begin
    PageIndex := PageIndex + 1;
        if @master_result <> nil then
      master_result(Self, MasterResultNext);

 // else if (PageIndex = (PagesCount - 1)) then
 //   if @master_result <> nil then
 //     master_result(Self, MasterResultOk);
end;

procedure ZMaster.bt_okClick(Sender: TObject);
begin
//  if (PageIndex < (PagesCount - 1)) then
//  begin
//    PageIndex := PageIndex + 1;
//        if @master_result <> nil then
//      master_result(Self, MasterResultNext);
//  end
//  else
//   if (PageIndex = (PagesCount - 1)) then
    if @master_result <> nil then
      master_result(Self, MasterResultOk);
end;

procedure ZMaster.bt_backClick(Sender: TObject);
begin
  if (PageIndex > 0) then
  begin
    PageIndex := PageIndex - 1;
    if @master_result <> nil then
      master_result(Self, MasterResultBack);
  end
end;

procedure ZMaster.bt_cancelClick(Sender: TObject);
begin
  if @master_result <> nil then
    master_result(Self, MasterResultCancel);
end;

procedure ZMaster.tab_setChange(Sender: TObject; NewTab: Integer;
  var AllowChange: Boolean);
begin
  if tab_set.TabIndex >= 0 then
    Pages[tab_set.TabIndex].panel.Visible := false;
  Pages[NewTab].panel.Visible := true;

  if (NewTab < (panels.Count - 1)) then
  begin
    bt_next.Hint := 'Наступна вкладка ''' + tab_set.Tabs[NewTab + 1] + '''';
    bt_next.Visible := true;
    bt_ok.Blink := false;
  end else
  begin
   // bt_next.Blink := false;
    bt_next.Visible := false;
    bt_ok.Blink := true;
  end;

  if (NewTab <> 0) then
  begin
    bt_back.Hint := 'Попередня вкладка ''' + tab_set.Tabs[NewTab + -1] + '''';
    bt_back.Visible := true;
  end else
    bt_back.Visible := false;

  SetFocusAtFirstEdit(NewTab);

  top_panel.Caption := tab_set.Tabs[NewTab] + ' (' + IntToStr(NewTab + 1) +
        '/' + IntToStr(panels.Count) + ')'; // lp_panel^.caption;

  if @page_change <> nil then
    page_change(Self, NewTab, AllowChange);
end;

end.
