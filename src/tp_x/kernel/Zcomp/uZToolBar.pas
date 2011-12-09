unit uZToolBar;

interface

uses
  Windows, Messages, SysUtils, Classes, Controls, ToolWin, ComCtrls, Graphics;

type
  ZToolBar = class(TToolBar)
  private
    { Private declarations }
    bmp: TBitmap;
    procedure AdvancedCustomDrawButton(Sender: TToolBar;
  Button: TToolButton; State: TCustomDrawState; Stage: TCustomDrawStage;
  var Flags: TTBCustomDrawFlags; var DefaultDraw: Boolean);
  protected
    { Protected declarations }
  public
    { Public declarations }
    constructor Create(AOwner:TComponent); override;
    destructor Destroy; override;
  published
    { Published declarations }
    property Images;
  end;

procedure Register;

implementation
{$R ZToolBar.dcr}

procedure Register;
begin
  RegisterComponents('Freedom', [ZToolBar]);
end;

constructor ZToolBar.Create(AOwner:TComponent);
begin
  inherited Create(AOwner);

  bmp := TBitmap.Create;
  bmp.Handle := LoadBitmap(hInstance, 'XHOT');
  bmp.Transparent := true;
  bmp.TransparentColor := clFuchsia;
  bmp.Height := 22;
  bmp.Width := 22;

  Visible := true;
  EdgeBorders := [];
  EdgeInner := esNone;
  EdgeOuter := esNone;
  Flat := true;
  AutoSize := true;
  OnAdvancedCustomDrawButton := AdvancedCustomDrawButton;
end;

destructor ZToolBar.Destroy;
begin
  inherited Destroy;
  bmp.Free;
end;

procedure ZToolBar.AdvancedCustomDrawButton(Sender: TToolBar;
  Button: TToolButton; State: TCustomDrawState; Stage: TCustomDrawStage;
  var Flags: TTBCustomDrawFlags; var DefaultDraw: Boolean);
begin
  if ((Stage = cdPrePaint)	and (cdsHot in State)) then
    Canvas.Draw(Button.Left, Button.Top, bmp);
end;



end.
