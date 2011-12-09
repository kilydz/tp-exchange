unit uZSwitcher;

interface

uses
  Windows, SysUtils, Classes, Controls, ExtCtrls, Graphics;

type
  ZBTN = record
    rect: TRect;
    pos: integer;
    is_focused: boolean;
  end;
  lpZBTN = ^ZBTN;

  ZSwitcher = class(TPaintBox)
  private
    { Private declarations }

    bmp: TBitmap;
    focused_btn: integer;
    BTNs: TList;
  protected
    { Protected declarations }
    procedure ZClick(Sender: TObject);
    procedure ZPaint(Sender: TObject);
    procedure ZMouseEnter(Sender: TObject);
    procedure ZMouseLeave(Sender: TObject);
    procedure ZMouseMove(Sender: TObject; Shift: TShiftState; Z, Y: Integer);
  public
    { Public declarations }
    constructor Create(AOwner:TComponent); override;
    destructor Destroy; override;

    function Add(): integer;
    function GetFocused: lpZBTN;
  published
    { Published declarations }
  end;

procedure Register;

implementation

procedure Register;
begin
  RegisterComponents('Freedom', [ZSwitcher]);
end;

constructor ZSwitcher.Create(AOwner:TComponent);
begin
  inherited Create(AOwner);

  BTNs := TList.Create;

  Visible := true;
  Align := alTop;
  focused_btn := -1;

  bmp := TBitmap.Create;
  bmp.Canvas.Rectangle(self.ClientRect);

  OnPaint := ZPaint;
  OnMouseEnter := ZMouseEnter;
  OnMouseLeave := ZMouseLeave;
  OnMouseMove := ZMouseMove;
  OnClick := ZClick;
end;


destructor ZSwitcher.Destroy;
var i: integer;
    btn: lpZBTN;
begin
  inherited Destroy;

  for i := 0 to BTNs.Count - 1 do
  begin
    btn := BTNs[i];

    Dispose(btn);
  end;
  BTNs.Free;

  bmp.Free;

{  f_font.Destroy;

  zb_left.Free;
  zb_right.Free;
  zb_center.Free;
  zb_left_f.Free;
  zb_right_f.Free;
  zb_center_f.Free;
  bmp.Free;     }
end;

function ZSwitcher.Add(): integer;
var btn: lpZBTN;
begin
  New(btn);
  BTNs.Add(btn);

  btn.pos := BTNs.Count - 1;
  btn.rect.Left := 10;
  btn.rect.Top := 10 + btn.pos * 68;
  btn.rect.Right := 58;
  btn.rect.Bottom := 58 + btn.pos * 68;

  btn.is_focused := false;

  Paint;
end;

function ZSwitcher.GetFocused: lpZBTN;
begin
  result := BTNs[focused_btn];
end;

procedure ZSwitcher.ZPaint(Sender: TObject);
var rect_center, rect_left, rect_right: TRect;
    i: integer;
    btn: lpZBTN;
begin
  for i := 0 to BTNs.Count - 1 do
  begin
    btn := BTNs[i];
    bmp.Canvas.Pen.Color := clBlack;
    if btn.is_focused then
      bmp.Canvas.Brush.Color := clYellow
    else
      bmp.Canvas.Brush.Color := clWhite;

    bmp.Canvas.Rectangle(btn.rect);
  end;
  bmp.Canvas.Brush.Color := clWhite;

  bmp.Width := Width;
  bmp.Height := Height;

{
  rect_left.Top := 0;
  rect_left.Left := 0;
  rect_left.Bottom := Height;
  rect_left.Right := 8;
  rect_center := self.ClientRect;
  rect_center.Left := 8;
  rect_center.Right := rect_center.Right - 8;
  rect_right := self.ClientRect;
  rect_right.Left := rect_right.Right - 8;

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

  bmp.Canvas.Font := f_font;
  SetBkMode(bmp.Canvas.Handle, TRANSPARENT);
  bmp.Canvas.TextOut(9, 2, f_caption);  }
  Canvas.Draw(0, 0, bmp);
end;

procedure ZSwitcher.ZClick(Sender: TObject);
var i: integer;
    pmod: lpZBTN;
begin
  Paint;
end;

procedure ZSwitcher.ZMouseEnter(Sender: TObject);
begin
 // is_focused := true;
  Paint;
end;

procedure ZSwitcher.ZMouseLeave(Sender: TObject);
begin
//  is_focused := false;
  Paint;
end;

procedure ZSwitcher.ZMouseMove(Sender: TObject; Shift: TShiftState; Z,
  Y: Integer);
var i: integer;
    pmod: lpZBTN;
begin
  focused_btn := -1;

  for i := 0 to BTNs.Count - 1 do
  begin
    pmod := BTNs[i];
    pmod.is_focused := ((Z >= pmod.rect.Left) and
                        (Z <= pmod.rect.Right) and
                        (Y >= pmod.rect.Top) and
                        (Y <= pmod.rect.Bottom));
    if pmod.is_focused then focused_btn := i;

  end;
  Paint;
end;

end.
