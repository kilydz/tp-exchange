unit uZToolButton;

interface

uses
  Windows, SysUtils, Classes, Controls, ExtCtrls, Graphics, uZToolBar;

const BT_HEIGHT = 24;

type

ZToolButtonStyle = (xbsButton, xbsCheck, xbsSeparator);

  ZToolButton = class(TPaintBox)
  private
    { Private declarations }
    f_style: ZToolButtonStyle;
    f_caption: AnsiString;
    f_font: TFont;

    is_focused: boolean;
    is_down: boolean;

    zb_left, zb_right, zb_center: TBitmap;
    zb_left_f, zb_right_f, zb_center_f: TBitmap;
    bmp: TBitmap;
    image_index: Integer;

    procedure ZClick(Sender: TObject);
    procedure ZPaint(Sender: TObject);
    procedure ZMouseEnter(Sender: TObject);
    procedure ZMouseLeave(Sender: TObject);
    procedure ZMouseMove(Sender: TObject; Shift: TShiftState; Z, Y: Integer);

    procedure SetDown(a_is_down: boolean);
  protected
    { Protected declarations }
  public
    { Public declarations }
    constructor Create(AOwner:TComponent); override;
    destructor Destroy; override;
  published
    { Published declarations }
    property Caption: AnsiString read f_caption write f_caption;
    property Font: TFont read f_font write f_font;
    property Style: ZToolButtonStyle read f_style write f_style;
    property Down: Boolean read is_down write SetDown;
    property ImageIndex: Integer read image_index write image_index;
  end;

procedure Register;

implementation
{$R ZToolButton.res}

procedure Register;
begin
  RegisterComponents('Freedom', [ZToolButton]);
end;

constructor ZToolButton.Create(AOwner:TComponent);
begin
  inherited Create(AOwner);

  zb_left := TBitmap.Create;
  zb_left.Handle := LoadBitmap(hInstance, 'ZB_LEFT');
  zb_left.Transparent := true;
  zb_left.TransparentColor := clWhite;
  zb_right := TBitmap.Create;
  zb_right.Handle := LoadBitmap(hInstance, 'ZB_RIGHT');
  zb_right.Transparent := true;
  zb_right.TransparentColor := clWhite;
  zb_center := TBitmap.Create;
  zb_center.Handle := LoadBitmap(hInstance, 'ZB_CENTER');
  zb_center.Transparent := true;
  zb_center.TransparentColor := clWhite;

  zb_left_f := TBitmap.Create;
  zb_left_f.Handle := LoadBitmap(hInstance, 'ZB_LEFT_F');
  zb_left_f.Transparent := true;
  zb_left_f.TransparentColor := clWhite;
  zb_right_f := TBitmap.Create;
  zb_right_f.Handle := LoadBitmap(hInstance, 'ZB_RIGHT_F');
  zb_right_f.Transparent := true;
  zb_right_f.TransparentColor := clWhite;
  zb_center_f := TBitmap.Create;
  zb_center_f.Handle := LoadBitmap(hInstance, 'ZB_CENTER_F');
  zb_center_f.Transparent := true;
  zb_center_f.TransparentColor := clWhite;

  Height := BT_HEIGHT;

  Visible := true;
  Align := alTop;

  bmp := TBitmap.Create;

  bmp.Canvas.Rectangle(self.ClientRect);

  f_style := xbsButton;

  f_font := TFont.Create;
  f_font.Height := 18;

  is_focused := false;
  Canvas.Brush.Color := clWhite;
  Canvas.TextFlags := Canvas.TextFlags and (not ETO_OPAQUE);

  OnPaint := ZPaint;
  OnMouseEnter := ZMouseEnter;
  OnMouseLeave := ZMouseLeave;
  OnMouseMove := ZMouseMove;
  OnClick := ZClick;
end;

destructor ZToolButton.Destroy;
begin
  inherited Destroy;

  f_font.Destroy;

  zb_left.Free;
  zb_right.Free;
  zb_center.Free;
  zb_left_f.Free;
  zb_right_f.Free;
  zb_center_f.Free;
  bmp.Free;
end;

procedure ZToolButton.ZPaint(Sender: TObject);
var rect_center, rect_left, rect_right: TRect;
    tool_bar: ZToolBar;
    images: TImageList;
    dx: integer;
begin
  if f_style = xbsSeparator then
    exit;

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

  if is_focused or (is_down and (f_style = xbsCheck)) then
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

  SetBkMode(bmp.Canvas.Handle, TRANSPARENT);

  try
    tool_bar := ZToolBar(parent);
    images := TImageList(tool_bar.Images);
    images.Draw(bmp.Canvas, 3, 3, ImageIndex);
  except
    bmp.Canvas.Font := f_font;
    bmp.Canvas.TextOut(9, 2, f_caption);
  end;

  Canvas.Draw(0, 0, bmp);
end;

procedure ZToolButton.ZClick(Sender: TObject);
begin
  if f_style = xbsCheck then
    is_down := not is_down;

  Paint;
end;

procedure ZToolButton.ZMouseEnter(Sender: TObject);
begin
  is_focused := true;
  Paint;
end;

procedure ZToolButton.ZMouseLeave(Sender: TObject);
begin
  is_focused := false;
  Paint;
end;

procedure ZToolButton.ZMouseMove(Sender: TObject; Shift: TShiftState; Z,
  Y: Integer);
begin

end;

procedure ZToolButton.SetDown(a_is_down: boolean);
begin
  if is_down <> a_is_down then
     is_down := a_is_down;
  Paint;
end;

end.
