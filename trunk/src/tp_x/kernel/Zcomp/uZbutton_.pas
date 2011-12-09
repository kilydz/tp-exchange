unit uZbutton;


{$S-,W-,R-,H+,X+}
{$C PRELOAD}

interface

uses Windows, Messages, Classes, Controls, Forms, Graphics, StdCtrls,
  ExtCtrls, CommCtrl, ImgList;

const BT_HEIGHT = 24;

type

  ZButtonState = (bzsUp, bzsDisabled, bzsDown, bzsExclusive);
  ZButtonLayout = (blGlyphLeft, blGlyphRight, blGlyphTop, blGlyphBottom);
  ZButtonStyle = (bzsAutoDetect, bzsWin31, bzsNew);
  ZNumGlyphs = 1..4;

  ZButton = class;

  TBitBtnActionLink = class(TControlActionLink)
  protected
    FClient: ZButton;
    FImageIndex: Integer;
    procedure AssignClient(AClient: TObject); override;
    function IsImageIndexLinked: Boolean; override;
    procedure SetImageIndex(Value: Integer); override;
  public
    constructor Create(AClient: TObject); override;
  end;


  ZButton = class(TButton)
  private

    zb_left, zb_right, zb_center: TBitmap;
    zb_left_f, zb_right_f, zb_center_f: TBitmap;
    bmp: TBitmap;


    FCanvas: TCanvas;
    FGlyph: TObject;
    FStyle: ZButtonStyle;
    FLayout: ZButtonLayout;
    FSpacing: Integer;
    FMargin: Integer;
    IsFocused: Boolean;
    FModifiedGlyph: Boolean;
    FMouseInControl: Boolean;
    procedure DrawItem(const DrawItemStruct: TDrawItemStruct);
    procedure SetGlyph(Value: TBitmap);
    function IsCustomCaption: Boolean;
    procedure SetStyle(Value: ZButtonStyle);
    procedure SetLayout(Value: ZButtonLayout);
    procedure SetSpacing(Value: Integer);
    procedure SetMargin(Value: Integer);
    procedure CNMeasureItem(var Message: TWMMeasureItem); message CN_MEASUREITEM;
    procedure CNDrawItem(var Message: TWMDrawItem); message CN_DRAWITEM;
    procedure CMFontChanged(var Message: TMessage); message CM_FONTCHANGED;
    procedure CMEnabledChanged(var Message: TMessage); message CM_ENABLEDCHANGED;
    procedure CMMouseEnter(var Message: TMessage); message CM_MOUSEENTER;
    procedure CMMouseLeave(var Message: TMessage); message CM_MOUSELEAVE;
    procedure WMLButtonDblClk(var Message: TWMLButtonDblClk);
      message WM_LBUTTONDBLCLK;
  protected
    procedure ActionChange(Sender: TObject; CheckDefaults: Boolean); override;
    procedure CreateHandle; override;
    procedure CreateParams(var Params: TCreateParams); override;
    function GetActionLinkClass: TControlActionLinkClass; override;
    procedure SetButtonStyle(ADefault: Boolean); override;
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    procedure Click; override;
  published
    property Action;
    property Align;
    property Anchors;
    property BiDiMode;
    property Caption stored IsCustomCaption;
    property Constraints;
    property Enabled;
    property Layout: ZButtonLayout read FLayout write SetLayout default blGlyphLeft;
    property Margin: Integer read FMargin write SetMargin default -1;
    property ModalResult;
    property ParentShowHint;
    property ParentBiDiMode;
    property ShowHint;
    property Style: ZButtonStyle read FStyle write SetStyle default bzsAutoDetect;
    property Spacing: Integer read FSpacing write SetSpacing default 4;
    property TabOrder;
    property TabStop;
    property Visible;
    property OnEnter;
    property OnExit;
  end;

{function DrawButtonFace(Canvas: TCanvas; const Client: TRect;
  BevelWidth: Integer; Style: ZButtonStyle; IsRounded, IsDown,
  IsFocused: Boolean): TRect;
 }
procedure Register;

implementation

{$R ZButton.dcr}

uses Consts, SysUtils, ActnList, Themes;

procedure Register;
begin
  RegisterComponents('Freedom', [ZButton]);
end;


var
  BitBtnModalResults: array[0..10] of TModalResult = (
    0, mrOk, mrCancel, 0, mrYes, mrNo, 0, mrAbort, mrRetry, mrIgnore,
    mrAll);

{type

function TButtonGlyph.CreateButtonGlyph(State: ZButtonState): Integer;
const
  ROP_DSPDxax = $00E20746;
var
  TmpImage, DDB, MonoBmp: TBitmap;
  IWidth, IHeight: Integer;
  IRect, ORect: TRect;
  I: ZButtonState;
  DestDC: HDC;
begin
  if (State = bzsDown) and (NumGlyphs < 3) then State := bzsUp;
  Result := FIndexs[State];
  if Result <> -1 then Exit;
  if (FOriginal.Width or FOriginal.Height) = 0 then Exit;
  IWidth := FOriginal.Width div FNumGlyphs;
  IHeight := FOriginal.Height;
  if FGlyphList = nil then
  begin
    if GlyphCache = nil then GlyphCache := TGlyphCache.Create;
    FGlyphList := GlyphCache.GetList(IWidth, IHeight);
  end;
  TmpImage := TBitmap.Create;
  try
    TmpImage.Width := IWidth;
    TmpImage.Height := IHeight;
    IRect := Rect(0, 0, IWidth, IHeight);
    TmpImage.Canvas.Brush.Color := clBtnFace;
    TmpImage.Palette := CopyPalette(FOriginal.Palette);
    I := State;
    if Ord(I) >= NumGlyphs then I := bzsUp;
    ORect := Rect(Ord(I) * IWidth, 0, (Ord(I) + 1) * IWidth, IHeight);
    case State of
      bzsUp, bzsDown,
      bzsExclusive:
        begin
          TmpImage.Canvas.CopyRect(IRect, FOriginal.Canvas, ORect);
          if FOriginal.TransparentMode = tmFixed then
            FIndexs[State] := FGlyphList.AddMasked(TmpImage, FTransparentColor)
          else
            FIndexs[State] := FGlyphList.AddMasked(TmpImage, clDefault);
        end;
      bzsDisabled:
        begin
          MonoBmp := nil;
          DDB := nil;
          try
            MonoBmp := TBitmap.Create;
            DDB := TBitmap.Create;
            DDB.Assign(FOriginal);
            DDB.HandleType := bmDDB;
            if NumGlyphs > 1 then
            with TmpImage.Canvas do
            begin
              CopyRect(IRect, DDB.Canvas, ORect);
              MonoBmp.Monochrome := True;
              MonoBmp.Width := IWidth;
              MonoBmp.Height := IHeight;


              DDB.Canvas.Brush.Color := clWhite;
              MonoBmp.Canvas.CopyRect(IRect, DDB.Canvas, ORect);
              Brush.Color := clBtnHighlight;
              DestDC := Handle;
              SetTextColor(DestDC, clBlack);
              SetBkColor(DestDC, clWhite);
              BitBlt(DestDC, 0, 0, IWidth, IHeight,
                     MonoBmp.Canvas.Handle, 0, 0, ROP_DSPDxax);


              DDB.Canvas.Brush.Color := clGray;
              MonoBmp.Canvas.CopyRect(IRect, DDB.Canvas, ORect);
              Brush.Color := clBtnShadow;
              DestDC := Handle;
              SetTextColor(DestDC, clBlack);
              SetBkColor(DestDC, clWhite);
              BitBlt(DestDC, 0, 0, IWidth, IHeight,
                     MonoBmp.Canvas.Handle, 0, 0, ROP_DSPDxax);


              DDB.Canvas.Brush.Color := ColorToRGB(FTransparentColor);
              MonoBmp.Canvas.CopyRect(IRect, DDB.Canvas, ORect);
              Brush.Color := clBtnFace;
              DestDC := Handle;
              SetTextColor(DestDC, clBlack);
              SetBkColor(DestDC, clWhite);
              BitBlt(DestDC, 0, 0, IWidth, IHeight,
                     MonoBmp.Canvas.Handle, 0, 0, ROP_DSPDxax);
            end
            else
            begin

              with MonoBmp do
              begin
                Assign(FOriginal);
                HandleType := bmDDB;
                Canvas.Brush.Color := clBlack;
                Width := IWidth;
                if Monochrome then
                begin
                  Canvas.Font.Color := clWhite;
                  Monochrome := False;
                  Canvas.Brush.Color := clWhite;
                end;
                Monochrome := True;
              end;
              with TmpImage.Canvas do
              begin
                Brush.Color := clBtnFace;
                FillRect(IRect);
                Brush.Color := clBtnHighlight;
                SetTextColor(Handle, clBlack);
                SetBkColor(Handle, clWhite);
                BitBlt(Handle, 1, 1, IWidth, IHeight,
                  MonoBmp.Canvas.Handle, 0, 0, ROP_DSPDxax);
                Brush.Color := clBtnShadow;
                SetTextColor(Handle, clBlack);
                SetBkColor(Handle, clWhite);
                BitBlt(Handle, 0, 0, IWidth, IHeight,
                  MonoBmp.Canvas.Handle, 0, 0, ROP_DSPDxax);
              end;
            end;
          finally
            DDB.Free;
            MonoBmp.Free;
          end;
          FIndexs[State] := FGlyphList.AddMasked(TmpImage, clDefault);
        end;
    end;
  finally
    TmpImage.Free;
  end;
  Result := FIndexs[State];
  FOriginal.Dormant;
end;

procedure TButtonGlyph.DrawButtonGlyph(Canvas: TCanvas; const GlyphPos: TPoint;
  State: ZButtonState; Transparent: Boolean);
var
  Index: Integer;
  Details: TThemedElementDetails;
  R: TRect;
  Button: TThemedButton;
begin
  if FOriginal = nil then Exit;
  if (FOriginal.Width = 0) or (FOriginal.Height = 0) then Exit;
  Index := CreateButtonGlyph(State);
  with GlyphPos do
  begin
    if ThemeServices.ThemesEnabled then
    begin
      R.TopLeft := GlyphPos;
      R.Right := R.Left + FOriginal.Width div FNumGlyphs;
      R.Bottom := R.Top + FOriginal.Height;
      case State of
        bzsDisabled:
          Button := tbPushButtonDisabled;
        bzsDown,
        bzsExclusive:
          Button := tbPushButtonPressed;
      else
        // bsUp
        Button := tbPushButtonNormal;
      end;
      Details := ThemeServices.GetElementDetails(Button);
      ThemeServices.DrawIcon(Canvas.Handle, Details, R, FGlyphList.Handle, Index);
    end
    else
      if Transparent or (State = bzsExclusive) then
      begin
        ImageList_DrawEx(FGlyphList.Handle, Index, Canvas.Handle, Z, Y, 0, 0,
          clNone, clNone, ILD_Transparent)
      end
      else
        ImageList_DrawEx(FGlyphList.Handle, Index, Canvas.Handle, Z, Y, 0, 0,
          ColorToRGB(clBtnFace), clNone, ILD_Normal);
  end;
end;

procedure TButtonGlyph.DrawButtonText(Canvas: TCanvas; const Caption: string;
  TextBounds: TRect; State: ZButtonState; BiDiFlags: LongInt);
begin
  with Canvas do
  begin
    Brush.Style := bsClear;
    if State = bzsDisabled then
    begin
      OffsetRect(TextBounds, 1, 1);
      Font.Color := clBtnHighlight;
      DrawText(Handle, PChar(Caption), Length(Caption), TextBounds,
        DT_CENTER or DT_VCENTER or BiDiFlags);
      OffsetRect(TextBounds, -1, -1);
      Font.Color := clBtnShadow;
      DrawText(Handle, PChar(Caption), Length(Caption), TextBounds,
        DT_CENTER or DT_VCENTER or BiDiFlags);
    end else
      DrawText(Handle, PChar(Caption), Length(Caption), TextBounds,
        DT_CENTER or DT_VCENTER or BiDiFlags);
  end;
end;
 }

constructor ZButton.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  Font.Height := 18;

  zb_left := TBitmap.Create;
  zb_left.Handle := LoadBitmap(hInstance, 'ZBT_LEFT');
  zb_left.Transparent := true;
  zb_left.TransparentColor := clWhite;
  zb_right := TBitmap.Create;
  zb_right.Handle := LoadBitmap(hInstance, 'ZBT_RIGHT');
  zb_right.Transparent := true;
  zb_right.TransparentColor := clWhite;
  zb_center := TBitmap.Create;
  zb_center.Handle := LoadBitmap(hInstance, 'ZBT_CENTER');
  zb_center.Transparent := true;
  zb_center.TransparentColor := clWhite;

  zb_left_f := TBitmap.Create;
  zb_left_f.Handle := LoadBitmap(hInstance, 'ZBT_LEFT_F');
  zb_left_f.Transparent := true;
  zb_left_f.TransparentColor := clWhite;
  zb_right_f := TBitmap.Create;
  zb_right_f.Handle := LoadBitmap(hInstance, 'ZBT_RIGHT_F');
  zb_right_f.Transparent := true;
  zb_right_f.TransparentColor := clWhite;
  zb_center_f := TBitmap.Create;
  zb_center_f.Handle := LoadBitmap(hInstance, 'ZBT_CENTER_F');
  zb_center_f.Transparent := true;
  zb_center_f.TransparentColor := clWhite;

  bmp := TBitmap.Create;
  bmp.Canvas.Rectangle(self.ClientRect);

  FCanvas := TCanvas.Create;
  FStyle := bzsAutoDetect;
  FLayout := blGlyphLeft;
  FSpacing := 4;
  FMargin := -1;
  ControlStyle := ControlStyle + [csReflector];
  DoubleBuffered := True;
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
    
procedure ZButton.CreateHandle;
var
  State: ZButtonState;
begin
  if Enabled then
    State := bzsUp
  else
    State := bzsDisabled;
  inherited CreateHandle;
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
    
procedure ZButton.Click;
var
  Form: TCustomForm;
  Control: TWinControl;
begin
  inherited Click;
end;
    
procedure ZButton.CNMeasureItem(var Message: TWMMeasureItem);
begin
  with Message.MeasureItemStruct^ do
  begin
    itemWidth := Width;
    itemHeight := Height;
  end;
end;

procedure ZButton.CNDrawItem(var Message: TWMDrawItem);
begin
  DrawItem(Message.DrawItemStruct^);
end;
    
procedure ZButton.DrawItem(const DrawItemStruct: TDrawItemStruct);
var
  rect_center, rect_left, rect_right: TRect;
  IsDown, IsDefault: Boolean;
  State: ZButtonState;
  R: TRect;
  Flags: Longint;
  Details: TThemedElementDetails;
  Button: TThemedButton;
  Offset: TPoint;
begin
  FCanvas.Handle := DrawItemStruct.hDC;
  R := ClientRect;

  with DrawItemStruct do
  begin
    FCanvas.Handle := hDC;
    FCanvas.Font := Self.Font;
    IsDown := itemState and ODS_SELECTED <> 0;
    IsDefault := itemState and ODS_FOCUS <> 0;

    if not Enabled then State := bzsDisabled
    else if IsDown then State := bzsDown
    else State := bzsUp;
  end;

    R := ClientRect;

    Flags := DFCS_BUTTONPUSH or DFCS_ADJUSTRECT;
    if IsDown then Flags := Flags or DFCS_PUSHED;
    if DrawItemStruct.itemState and ODS_DISABLED <> 0 then
      Flags := Flags or DFCS_INACTIVE;


  rect_left.Top := 0;
  rect_left.Left := 0;
  rect_left.Bottom := Height;
  rect_left.Right := 8;
  rect_center := self.ClientRect;
  rect_center.Left := 8;
  rect_center.Right := rect_center.Right - 8;
  rect_right := self.ClientRect;
  rect_right.Left := rect_right.Right - 8;

  bmp.Width := Width;
  bmp.Height := Height;

  if IsFocused {or (is_down and (f_style = xbsCheck))} then
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
  SetBkMode(bmp.Canvas.Handle, TRANSPARENT);
  bmp.Canvas.TextOut(9, 2, Caption);
  FCanvas.Draw(0, 0, bmp);

    { DrawFrameControl doesn't allow for drawing a button as the
        default button, so it must be done here.
    if IsFocused or IsDefault then
    begin
      FCanvas.Pen.Color := clWindowFrame;
      FCanvas.Pen.Width := 1;
      FCanvas.Brush.Style := bsClear;
      FCanvas.Rectangle(R.Left, R.Top, R.Right, R.Bottom);
      InflateRect(R, -1, -1);
    end;

   if IsDown then
    begin
      FCanvas.Pen.Color := clBtnShadow;
      FCanvas.Pen.Width := 1;
      FCanvas.Brush.Color := clBtnFace;
      FCanvas.Rectangle(R.Left, R.Top, R.Right, R.Bottom);
      InflateRect(R, -1, -1);
    end
    else
      DrawFrameControl(DrawItemStruct.hDC, R, DFC_BUTTON, Flags);

    if IsFocused then
    begin
      R := ClientRect;
      InflateRect(R, -1, -1);
    end;

    FCanvas.Font := Self.Font;
    if IsDown then
      OffsetRect(R, 1, 1);
    TButtonGlyph(FGlyph).Draw(FCanvas, R, Point(0,0), Caption, FLayout, FMargin,
      FSpacing, State, False, DrawTextBiDiModeFlags(0));
      }
    if IsFocused and IsDefault then
    begin
      R := ClientRect;
      InflateRect(R, -4, -4);
      FCanvas.Pen.Color := clWindowFrame;
      FCanvas.Brush.Color := clBtnFace;
      DrawFocusRect(FCanvas.Handle, R);
    end;

  FCanvas.Handle := 0;
end;

procedure ZButton.CMFontChanged(var Message: TMessage);
begin
  inherited;
  Invalidate;
end;

procedure ZButton.CMEnabledChanged(var Message: TMessage);
begin
  inherited;
  Invalidate;
end;
    
procedure ZButton.WMLButtonDblClk(var Message: TWMLButtonDblClk);
begin
  Perform(WM_LBUTTONDOWN, Message.Keys, Longint(Message.Pos));
end;

procedure ZButton.SetGlyph(Value: TBitmap);
begin
  FModifiedGlyph := True;
  Invalidate;
end;

procedure ZButton.SetStyle(Value: ZButtonStyle);
begin
  if Value <> FStyle then
  begin
    FStyle := Value;
    Invalidate;
  end;
end;

function ZButton.IsCustomCaption: Boolean;
begin
  Result := AnsiCompareStr(Caption, Caption) <> 0;
end;

procedure ZButton.SetLayout(Value: ZButtonLayout);
begin
  if FLayout <> Value then
  begin
    FLayout := Value;
    Invalidate;
  end;
end;

procedure ZButton.SetSpacing(Value: Integer);
begin
  if FSpacing <> Value then
  begin
    FSpacing := Value;
    Invalidate;
  end;
end;

procedure ZButton.SetMargin(Value: Integer);
begin
  if (Value <> FMargin) and (Value >= - 1) then
  begin
    FMargin := Value;
    Invalidate;
  end;
end;

procedure ZButton.ActionChange(Sender: TObject; CheckDefaults: Boolean);
begin
  inherited ActionChange(Sender, CheckDefaults);
  if Sender is TCustomAction then
    with TCustomAction(Sender) do
    begin
      if CheckDefaults or (TBitBtnActionLink(ActionLink).FImageIndex <> -1) or
         (TBitBtnActionLink(ActionLink).FImageIndex <> ImageIndex) then
      begin
        TBitBtnActionLink(ActionLink).FImageIndex := ImageIndex;
      end;
    end;
end;

procedure ZButton.CMMouseEnter(var Message: TMessage);
begin
  inherited;
  if ThemeServices.ThemesEnabled and not FMouseInControl and not (csDesigning in ComponentState) then
  begin
    FMouseInControl := True;
    Repaint;
  end;
end;

procedure ZButton.CMMouseLeave(var Message: TMessage);
begin
  inherited;
  if ThemeServices.ThemesEnabled and FMouseInControl then
  begin
    FMouseInControl := False;
    Repaint;
  end;
end;

function ZButton.GetActionLinkClass: TControlActionLinkClass;
begin
  Result := TBitBtnActionLink;
end;

{ TBitBtnActionLink }

procedure TBitBtnActionLink.AssignClient(AClient: TObject);
begin
  inherited AssignClient(AClient);
  FClient := AClient as ZButton;
end;

constructor TBitBtnActionLink.Create(AClient: TObject);
begin
  inherited;
  FImageIndex := -1;
end;

function TBitBtnActionLink.IsImageIndexLinked: Boolean;
begin
  Result := inherited IsImageIndexLinked and
    (FImageIndex = (Action as TCustomAction).ImageIndex);
end;

procedure TBitBtnActionLink.SetImageIndex(Value: Integer);
begin
  if IsImageIndexLinked then
  begin
    FImageIndex := Value;
  end;
end;


end.
