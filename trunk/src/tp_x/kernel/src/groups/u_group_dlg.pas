unit u_group_dlg;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, dxCntner, dxEditor, dxEdLib;

type
  Tfgroup_dlg = class(TForm)
    ed_input: TdxEdit;
    l_prompt: TLabel;
    btn_ok: TButton;
    btn_cancel: TButton;
    procedure btn_okClick(Sender: TObject);
  private
    { Private declarations }
    procedure CMDialogKey(var Msg:TWMKey); message CM_DIALOGKEY;    
  public
    { Public declarations }
  end;

var
  fgroup_dlg: Tfgroup_dlg;

implementation
uses utils_h;

{$R *.dfm}

//Enter заміняємо на Tab;
procedure Tfgroup_dlg.CMDialogKey(Var Msg: TWMKey);
begin
    if not (ActiveControl is TButton) then
    begin
        if Msg.Charcode = 13 then
            Msg.CharCode:= 9;
    end;
    Msg.Result:=0;

    inherited;
end;

procedure Tfgroup_dlg.btn_okClick(Sender: TObject);
begin
    if ed_input.Text = '' then
    begin
        GMessageBox('Не введена назва нової групи. Спробуйте ще раз', 'OK');
        ModalResult:=mrNone;
        ed_input.SetFocus;
    end;
end;

end.
