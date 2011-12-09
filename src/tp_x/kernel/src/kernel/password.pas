//  Name: password.pas
//  Copyright: SoftWest group.
//  Author: Maxim Mihaluk
//  Date: 27.12.05
//  Description: ядро програми Veles.exe (форма аутентифікації);
//               (нова версія - з динамічно формованими меню для плагінів та
//                трейем).

unit password;


interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, ExtCtrls, Buttons, dxCntner, dxEditor, dxEdLib, uZbutton,
  ComCtrls, kernel_h;

type
  Tfpassword = class(TForm)
    ed_base_way: TdxEdit;
    ed_user_name: TdxEdit;
    ed_password: TdxEdit;
    luser_name: TLabel;
    lpassword: TLabel;
    bt_ok: ZButton;
    ZButton1: ZButton;
    l_anime: TAnimate;
    procedure FormShow(Sender: TObject);
    procedure FormHide(Sender: TObject);
    procedure bokClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
  private
    { Private declarations }
    procedure CMDialogKey(var Msg:TWMKey); message CM_DIALOGKEY;
  public
    { Public declarations }
    current, latin: HKL;
  end;

var
  fpassword: Tfpassword;

implementation

uses main;

{$R *.dfm}

//Tab заміняємо на Enter;
procedure Tfpassword.CMDialogKey(Var Msg: TWMKey);
begin
    if not (ActiveControl is TButton) then
    begin
        if Msg.Charcode = 13 then
        begin
            if ActiveControl is TdxEdit then
                if (ActiveControl as TdxEdit).Name = 'ed_password' then
                    bokClick(nil);
            Msg.CharCode:= 9;
        end;
    end;
    Msg.Result:=0;

    inherited;
end;

procedure Tfpassword.bokClick(Sender: TObject);
begin
    ModalResult:=mrOk;
    if ed_user_name.Text = '' then
    begin
        Application.MessageBox(PChar('Введіть і''мя користувача'),
            PChar('УВАГА'), MB_ICONINFORMATION);
        ed_user_name.SetFocus;
        ModalResult:=mrNone;
    end
    else if ed_password.Text = '' then
    begin
        Application.MessageBox(PChar('Введіть пароль'),
            PChar('УВАГА'), MB_ICONINFORMATION);
        ed_password.SetFocus;
        ModalResult:=mrNone;
    end;
end;

procedure Tfpassword.FormCreate(Sender: TObject);
begin
  current := GetKeyboardLayout(0);
  latin := LoadKeyboardLayout('00000409', 0);
  ActivateKeyboardLayout(latin, 0);

  l_anime.FileName := veles_info.root_way + WAY_IMAGES + 'key.avi';
end;

procedure Tfpassword.FormHide(Sender: TObject);
begin
  l_anime.Active := false;
end;

procedure Tfpassword.FormShow(Sender: TObject);
begin
  l_anime.Active := true;
end;

procedure Tfpassword.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  ActivateKeyboardLayout(LoadKeyboardLayout('00000422', 0), 0);
  //ActivateKeyboardLayout(LoadKeyboardLayout('00000423', 0), 0);
end;

end.
