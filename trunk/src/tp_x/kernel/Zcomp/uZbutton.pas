unit uZbutton;

interface
uses  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, Buttons, ExtCtrls;

type
  TDrawButtonEvent = procedure(Control: TWinControl; 
    Rect: TRect; State: TOwnerDrawState) of object; 


  ZButton = class(TButton)
  private
    { Private declarations }
    zb_left, zb_right, zb_center: TBitmap;
    zb_left_f, zb_right_f, zb_center_f: TBitmap;
    bmp: TBitmap;

    FBlinked: Boolean;
    FBlink_light: Boolean;
    FTimer: TTimer;

    FCanvas: TCanvas;
    IsFocused: Boolean;
    FOnDrawButton: TDrawButtonEvent;
    
    procedure CreateParams(var Params: TCreateParams); override;
    procedure SetButtonStyle(ADefault: Boolean); override;
    procedure CNMeasureItem(var Message: TWMMeasureItem); message CN_MEASUREITEM; 
    procedure DrawButton(Rect: TRect; State: UINT);
    procedure CNDrawItem(var Message: TWMDrawItem); message CN_DRAWITEM;
    procedure CMEnabledChanged(var Message: TMessage); message CM_ENABLEDCHANGED; 
    procedure CMFontChanged(var Message: TMessage); message CM_FONTCHANGED;
    procedure WMLButtonDblClk(var Message: TWMLButtonDblClk); message WM_LBUTTONDBLCLK;

    procedure SetBlinked(iblinked: boolean);
    procedure DoBlink(Sender: TObject);
  protected
    { Protected declarations }
  public
    { Public declarations }
    constructor Create(AOwner:TComponent); override;
    destructor Destroy; override;
  published
    property Action;
    property Align;
    property Anchors;
    property BiDiMode;
    property Caption;
    property Constraints;
    property Enabled;
    property ModalResult;
    property ParentShowHint;
    property ParentBiDiMode;
    property ShowHint;
    property TabOrder;
    property TabStop;
    property Visible;
    property OnEnter;
    property OnExit;
    property Blink: Boolean read FBlinked write SetBlinked default false;
  end;

procedure Register;

implementation
{$R ZButton.dcr}

procedure Register;
begin
  RegisterComponents('Freedom', [ZButton]);
end;


constructor ZButton.Create(AOwner:TComponent);
begin
  inherited Create(AOwner);

  FBlink_light := false;

  zb_left := TBitmap.Create;
  zb_left.Handle := LoadBitmap(hInstance, 'ZBT_LEFT');
  zb_right := TBitmap.Create;
  zb_right.Handle := LoadBitmap(hInstance, 'ZBT_RIGHT');
  zb_center := TBitmap.Create;
  zb_center.Handle := LoadBitmap(hInstance, 'ZBT_CENTER');

  zb_left_f := TBitmap.Create;
  zb_left_f.Handle := LoadBitmap(hInstance, 'ZBT_LEFT_F');
  zb_right_f := TBitmap.Create;
  zb_right_f.Handle := LoadBitmap(hInstance, 'ZBT_RIGHT_F');
  zb_center_f := TBitmap.Create;
  zb_center_f.Handle := LoadBitmap(hInstance, 'ZBT_CENTER_F');

  bmp := TBitmap.Create;
  bmp.PixelFormat := pf32bit;
  bmp.Transparent := true;
  bmp.TransparentColor := clWhite;

  Font.Height := 18;
  FCanvas := TCanvas.Create;
end;

destructor ZButton.Destroy;
begin
  inherited Destroy;
  FCanvas.Free;

  zb_left.Free;
  zb_right.Free;
  zb_center.Free;
  zb_left_f.Free;
  zb_right_f.Free;
  zb_center_f.Free;
  bmp.Free;
end;

procedure ZButton.CreateParams(var Params: TCreateParams);
begin
  inherited CreateParams(Params);
  with Params do Style := Style or BS_OWNERDRAW;
end; 

procedure ZButton.SetButtonStyle(ADefault: Boolean);
begin 
  if ADefault <> IsFocused then
  begin 
    IsFocused := ADefault; 
    Refresh; 
  end; 
end; 

procedure ZButton.CNMeasureItem(var Message: TWMMeasureItem);
begin 
  with Message.MeasureItemStruct^ do 
  begin 
    itemWidth  := Width; 
    itemHeight := Height; 
  end; 
end; 

procedure ZButton.CNDrawItem(var Message: TWMDrawItem);
var 
  SaveIndex: Integer; 
begin 
  with Message.DrawItemStruct^ do 
  begin 
    SaveIndex := SaveDC(hDC); 
    FCanvas.Lock; 
    try 
      FCanvas.Handle := hDC; 
      FCanvas.Font := Font; 
      FCanvas.Brush := Brush; 
      DrawButton(rcItem, itemState);
    finally 
      FCanvas.Handle := 0; 
      FCanvas.Unlock; 
      RestoreDC(hDC, SaveIndex); 
    end; 
  end; 
  Message.Result := 1; 
end; 

procedure ZButton.CMEnabledChanged(var Message: TMessage);
begin 
  inherited; 
  Invalidate; 
end; 

procedure ZButton.CMFontChanged(var Message: TMessage);
begin 
  inherited; 
  Invalidate; 
end; 

procedure ZButton.WMLButtonDblClk(var Message: TWMLButtonDblClk);
begin 
  Perform(WM_LBUTTONDOWN, Message.Keys, Longint(Message.Pos)); 
end; 

procedure ZButton.DrawButton(Rect: TRect; State: UINT);
var 
  rect_center, rect_left, rect_right: TRect;
  Flags, OldMode: Longint;
  IsDown, IsDefault, IsDisabled: Boolean; 
  OldColor: TColor; 
  OrgRect: TRect; 
begin 
  OrgRect := Rect; 
  Flags := DFCS_BUTTONPUSH or DFCS_ADJUSTRECT; 
  IsDown := State and ODS_SELECTED <> 0; 
  IsDefault := State and ODS_FOCUS <> 0; 
  IsDisabled := State and ODS_DISABLED <> 0; 

  if IsDown then Flags := Flags or DFCS_PUSHED; 
  if IsDisabled then Flags := Flags or DFCS_INACTIVE; 

  bmp.Width := Width;
  bmp.Height := Height;
  bmp.Canvas.Rectangle(self.ClientRect);
  bmp.PixelFormat := pf32bit;

  rect_left.Top := 0;
  rect_left.Left := 0;
  rect_left.Bottom := Height;
  rect_left.Right := 8;
  rect_center := self.ClientRect;
  rect_center.Left := 8;
  rect_center.Right := rect_center.Right - 8;
  rect_right := self.ClientRect;
  rect_right.Left := rect_right.Right - 8;

  if IsFocused or FBlink_light then
  begin
    bmp.Canvas.StretchDraw(rect_left, zb_left_f);
    bmp.Canvas.StretchDraw(rect_center, zb_center_f);
    bmp.Canvas.StretchDraw(rect_right, zb_right_f);
  end
  else
  begin
    bmp.Canvas.StretchDraw(rect_left, zb_left);
    bmp.Canvas.StretchDraw(rect_center, zb_center);
    bmp.Canvas.StretchDraw(rect_right, zb_right);
  end;

  bmp.Canvas.Font := Font;
  if Enabled then
    bmp.Canvas.Font.Color := clBlack
  else
    bmp.Canvas.Font.Color := clGray;
  SetBkMode(bmp.Canvas.Handle, TRANSPARENT);
  bmp.Canvas.TextOut(round((Width - bmp.Canvas.TextWidth(Caption))/2), 2, Caption);
  FCanvas.Draw(0, 0, bmp);

  if IsFocused and IsDefault then
  begin
    Rect := OrgRect;
    InflateRect(Rect, - 4, - 4);
    FCanvas.Pen.Color := clWindowFrame;
    FCanvas.Brush.Color := clBtnFace;
    DrawFocusRect(FCanvas.Handle, Rect);
  end;
end;

procedure ZButton.SetBlinked(iblinked: boolean);
begin
  if (not FBlinked) and iblinked and (FTimer = nil) then
  begin
    FTimer := TTimer.Create(self);
    FTimer.OnTimer := DoBlink;
    FTimer.Interval := 600;
    FTimer.Enabled := true;
    FBlinked := true;
  end;
  if FBlinked and (not iblinked) then
  begin
    if (FTimer <> nil) then
    begin
      FTimer.Free;
      FTimer := nil;
      FBlink_light := false;
    end;
    FBlinked := false;
  end
end;

procedure ZButton.DoBlink(Sender: TObject);
begin
  FBlink_light := not FBlink_light;
  Repaint;
end;

end.
