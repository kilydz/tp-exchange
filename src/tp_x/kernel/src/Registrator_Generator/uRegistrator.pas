unit uRegistrator;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, Buttons, ExtCtrls, Mask, uAlgoritm, HTMLLite, shellapi,
  uZbutton;

type
  TForm1 = class(TForm)
    Label2: TLabel;
    edShopCode: TMaskEdit;
    GroupBox1: TGroupBox;
    edCode: TMaskEdit;
    Panel1: TPanel;
    ed_contact: ThtmlLite;
    ZButton1: ZButton;
    procedure ed_contactHotSpotClick(Sender: TObject; const SRC: string;
      var Handled: Boolean);
    procedure BitBtn1Click(Sender: TObject);
    procedure FormCreate(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form1: TForm1;

implementation

{$R *.dfm}

procedure TForm1.BitBtn1Click(Sender: TObject);
var Code, EtalonCode, sDate :string;
    dtDate :TDateTime;
    res :Integer;
    strL :TStringList;
begin
	if (edCode.Text = '    -    -    -    -    ') then
  begin
		ShowMessage('Потрібно ввести реєстраційний код');
		edShopCode.SetFocus();
		Exit;
	end;

	Code := WiginerUnCript(DEL_(edCode.Text));
	sDate := Code;
	Delete(sDate ,1, 12);
	try
		Insert('.', sDate, 3);
		Insert('.', sDate, 6);
		dtDate := StrToDate(sDate);
		res := 1;
  except
		res := 0;
  end;
	Code := Copy(Code, 1, 12);
	EtalonCode := DEL_(edShopCode.Text);
	EtalonCode := Copy(EtalonCode, 1, 12);

	if ((res > 0)and(EtalonCode = Code)) then
  begin
		strL := TStringList.Create;
		strL.Text := edCode.Text;
		strL.SaveToFile('.\\licence.key');
		strL.Free;
		ShowMessage('Вітаємо! Програму успішно зареєстровано');
	end else begin
    ShowMessage('Помилка! Реєстраційний код не вірний!');
  end;
end;

procedure TForm1.ed_contactHotSpotClick(Sender: TObject; const SRC: string;
  var Handled: Boolean);
begin
   ShellExecute(handle, 'open', PAnsiChar(SRC), nil, nil, SW_SHOW);
end;

procedure TForm1.FormCreate(Sender: TObject);
var  ss_splash: String;
begin
	edShopCode.Text := AD_(MD5(GetHDDInfo));
	edCode.Text := '';

  ss_splash := '<h4>Отримати реєстраційний ключ можна звернувшись:</h4>' +
'<b>E-mail: </b><a href="mailto:info@konkurrent.com.ua">info@konkurrent.com.ua</a><br>' +
'<b>Тел./факс: </b>+38(0332)283988<br>' +
'<b>Skype: </b><a href="skype:Konkurent-L">Konkurent-L</a><br>' +
'<b>ICQ: </b>562439980<br>';
  ed_contact.LoadFromString(ss_splash, '');

end;

end.
