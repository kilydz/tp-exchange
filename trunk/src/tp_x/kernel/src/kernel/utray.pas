unit utray;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, uZbutton, dxCntner, dxEditor, dxEdLib, kernel_h, zutils_h;

type
  Tftray = class(TForm)
    l_info: TStaticText;
    lpassword: TLabel;
    ed_password: TdxEdit;
    bt_ok: ZButton;
    ZButton1: ZButton;
    procedure ed_passwordKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure bt_okClick(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
  private
    { Private declarations }
  public
    prm: ZVelesInfoRec;
    current, latin: HKL;

    procedure InitInfo;
    procedure SetInfoCaption(caption: string);
  end;

function CheckTray(caption: string; var prm: ZVelesInfoRec): Integer;

implementation

{$R *.dfm}

function CheckTray(caption: string; var prm: ZVelesInfoRec): Integer;
var dlg: Tftray;
  res: Integer;
begin
  res := 0;
try
  Application.CreateForm(Tftray, dlg);
  dlg.prm := prm;
  dlg.SetInfoCaption(caption);
  dlg.InitInfo;

  if dlg.ShowModal = mrOk then
  begin
    res := 1;
  end;
finally
  dlg.Free;
end;
  Result := res;
end;

procedure Tftray.bt_okClick(Sender: TObject);
begin
  if ed_password.Text = prm.user_password then
    ModalResult:=mrOk
  else
  begin
    GMessageBox('¬ведений пароль не в≥дпов≥даЇ тому, п≥д €ким працював користувач ' + prm.user_name, 'OK');
    ed_password.SetFocus;
    ed_password.SelectAll;
  end;
end;

procedure Tftray.ed_passwordKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if (Key = VK_RETURN) then
  begin
    bt_okClick(Sender);
  end;
end;

procedure Tftray.FormDestroy(Sender: TObject);
begin
  ActivateKeyboardLayout(current, 0);
end;

procedure Tftray.InitInfo;
begin
  current := GetKeyboardLayout(0);
  latin := LoadKeyboardLayout('00000409', 0);
  ActivateKeyboardLayout(latin, 0);

  
end;

procedure Tftray.SetInfoCaption(caption: string);
begin
  l_info.Caption := caption;
end;

end.
