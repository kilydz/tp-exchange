unit uabout;


interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, dxExEdtr, dxCntner, dxTL, dxDBCtrl, dxDBGrid, kernel_h,
  ExtCtrls, uZbutton;

type
  Tfabout = class(TForm)
    pnl_main: TPanel;
    lblProgName: TLabel;
    lblVertion: TLabel;
    lblCopyright: TLabel;
    lblSign: TLabel;
    lblYear: TLabel;
    lblAuthorName: TLabel;
    ZButton1: ZButton;
  private
    { Private declarations }
  public
    { Public declarations }
  end;

function ShowPlugin(var a_veles_info: ZVelesInfoRec): Longint; stdcall;

implementation

{$R *.dfm}

function ShowPlugin(var a_veles_info: ZVelesInfoRec): Longint; stdcall;
var
  about: Tfabout;

begin
    Result:=-1;
    about:=Tfabout.Create(nil);
    try
        about.Caption:='Про програму ' + a_veles_info.app_name;
        about.lblProgName.Caption:=a_veles_info.app_name;
        about.lblProgName.Left:=(about.pnl_main.Width - about.lblProgName.Width) div 2;
        about.lblVertion.Caption:='Версія ' + IntToStr(a_veles_info.version);
        if about.ShowModal = mrOk then
        begin
            Result:=0;
        end;
    finally
        about.Free;
    end;
end;

end.
