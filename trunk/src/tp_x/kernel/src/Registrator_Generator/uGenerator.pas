unit uGenerator;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, Buttons, ExtCtrls, Mask, ComCtrls, uAlgoritm;

type
  TForm2 = class(TForm)
    Label1: TLabel;
    Label2: TLabel;
    edDate: TDateTimePicker;
    GroupBox1: TGroupBox;
    edCode: TEdit;
    edShopCode: TMaskEdit;
    Panel1: TPanel;
    BitBtn1: TBitBtn;
    procedure FormCreate(Sender: TObject);
    procedure BitBtn1Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form2: TForm2;

implementation

{$R *.dfm}

procedure TForm2.BitBtn1Click(Sender: TObject);
var Code :string;
begin
	if (edShopCode.Text = '    -    -    -    -    ') then
  begin
		ShowMessage('Потрібно заповнити код надісланий від клієнта');
		edShopCode.SetFocus();
		Exit;
	end;
	Code := DEL_(edShopCode.Text);
	Code := Copy(Code, 1, 12);
	Code := Code + DEL_dot(DateToStr(edDate.Date));

	edCode.Text := AD_(WiginerCript(Code));
end;

procedure TForm2.FormCreate(Sender: TObject);
begin
	edDate.Date := Now;
	edShopCode.Text := '';
	edCode.Text := '';
end;

end.
