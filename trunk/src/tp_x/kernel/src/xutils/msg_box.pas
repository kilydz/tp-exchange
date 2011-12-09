unit msg_box;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, Zutils_h, ExtCtrls, StdCtrls, uZButton;

type
  Tfmessage = class(TForm)
    p_left: TPanel;
    p_buttons: TPanel;
    ed_message: TMemo;
    procedure FormShow(Sender: TObject);
    procedure ButtonClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
    msg, buttons: string;
    resulted: integer;

    procedure InitInfo;

  end;

var
  fmessage: Tfmessage;

function GMessageBox(msg, buttons: string): Integer;

implementation

{$R *.dfm}

function GMessageBox(msg, buttons: string): Integer;
var dlg: Tfmessage;
    resulted: integer;
begin
    dlg := Tfmessage.Create(Application);
    dlg.msg := msg;
    dlg.buttons := buttons;

    dlg.InitInfo;

    dlg.ShowModal();

    resulted := dlg.resulted;
    dlg.Free();

    GMessageBox := resulted;
end;

procedure Tfmessage.FormCreate(Sender: TObject);
begin
  resulted := 0;
end;

procedure Tfmessage.FormShow(Sender: TObject);
begin
  ZButton(p_buttons.Components[0]).SetFocus;
end;

procedure Tfmessage.InitInfo;
var btn: ZButton;
    btn_top: integer;
    bt0, bt1: PAnsiChar;
    i: integer;
begin
    bt0 := PAnsiChar(buttons);
    bt1 := PAnsiChar(buttons);

    btn_top := 8;

    // Парсер написів на кнопках
    while (StrComp(bt0, '') <> 0) do
    begin
        btn := ZButton.Create(p_buttons);
        btn.Parent := p_buttons;
        btn.Top := btn_top;
        btn_top := btn_top + 33;
        btn.Left := 8;
        btn.Width := p_buttons.Width - 16;
        btn.OnClick := ButtonClick;

        bt1 := StrScan(bt0, '|');
        if bt1 = nil then
        begin
          bt1 := StrScan(bt0, chr(0));
          btn.Caption := bt0;
          bt0 := bt1;
        end
        else
        begin
            bt1[0] := chr(0);
            btn.Caption := bt0;
            bt0 := bt1 + 1;
            bt1 := bt0;
        end
    end;

    ed_message.Lines.Text := msg;
end;

procedure Tfmessage.ButtonClick(Sender: TObject);
var btn: TButton;
begin
    btn := TButton(Sender);
    resulted := btn.TabOrder + 1;
    ModalResult := mrOk;
end;

end.
