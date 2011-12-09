unit uZControlBar;

interface

uses
  Windows, Messages, SysUtils, Classes, Controls, ExtCtrls, Graphics;

type
  ZControlBar = class(TControlBar)
  private
    { Private declarations }
    bmp: TBitmap;
    procedure BandPaint(Sender: TObject;
        Control: TControl; Canvas: TCanvas; var ARect: TRect;
        var Options: TBandPaintOptions);
  protected
    { Protected declarations }
  public
    { Public declarations }
  published
    { Published declarations }
    constructor Create(AOwner:TComponent); override;
    destructor Destroy; override;
  end;

procedure Register;

implementation
{$R ZControlBar.res}

procedure Register;
begin
  RegisterComponents('Freedom', [ZControlBar]);
end;

constructor ZControlBar.Create(AOwner:TComponent);
begin

  inherited Create(AOwner);
  Visible := true;
  Align := alTop;
  BevelInner := bvNone;
  BevelKind := bkFlat;
  BevelOuter := bvRaised;
  OnBandPaint := BandPaint;

  bmp := TBitmap.Create;
  bmp.Handle := LoadBitmap(hInstance, 'ZGRABBER');
  bmp.Transparent := true;
 // bmp.TransparentColor := $00ff00ff; //clFuchsia;
  bmp.Height := 22;
  bmp.Width := 9;
end;

destructor ZControlBar.Destroy;
begin
  inherited Destroy;
  bmp.Free;
end;

procedure ZControlBar.BandPaint(Sender: TObject;
  Control: TControl; Canvas: TCanvas; var ARect: TRect;
  var Options: TBandPaintOptions);
begin
  Options := [{bpoFrame}];
  Canvas.Draw(ARect.Left, Round((ARect.Bottom - ARect.Top - bmp.Height) / 2) + ARect.Top, bmp);
end;

end.
