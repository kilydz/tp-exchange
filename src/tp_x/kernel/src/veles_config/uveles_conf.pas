unit uveles_conf;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, dxCntner, dxEditor, dxEdLib, StdCtrls, ExtCtrls, uZMaster, IniFiles, utils_h;

type
  Tfveles_conf = class(TForm)
    pStage0: TPanel;
    Label1: TLabel;
    ed_ServerIP: TdxEdit;
    ed_BaseWay: TdxEdit;
    ed_SYSDBAPassword: TdxEdit;
    ed_SYSDBAPassword_confirm: TdxEdit;
    master: ZMaster;
    dxEditStyleController: TdxEditStyleController;
    Label2: TLabel;
    Label4: TLabel;
    Label5: TLabel;
    procedure FormCreate(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure masterMasterResult(Sender: TObject;
      MasterResult: ZMasterResult);
    procedure EditsKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure EditsKeyPress(Sender: TObject; var Key: Char);
    procedure EditsKeyUp(Sender: TObject; var Key: Word;
      Shift: TShiftState);
  private
    { Private declarations }
  public
    { Public declarations }
    ini_file: string;

    procedure InitInfo;
    function  AnalizChanges: integer;
    procedure ApplyChanges;
  end;

var
  fveles_conf: Tfveles_conf;

implementation

{$R *.dfm}

//------------------------------------------------------------------------------
//
//------------------------------------------------------------------------------
procedure Tfveles_conf.InitInfo;
var f: TIniFile;
begin
  ini_file := GetCurrentDir + '\kernel.ini';
  f := TIniFile.Create(ini_file);
   ed_ServerIP.Text       := f.ReadString('BaseOptions', 'ServerIP', '127.0.0.1');
   ed_BaseWay.Text        := f.ReadString('BaseOptions', 'BaseWay', 'D:/BASE/SHOP.GDB');
   ed_SYSDBAPassword.Text :=
PasswordCryptor(f.ReadString('BaseOptions', 'SYSDBAPassword', 'pdvwhunh|'),
                   false);
   ed_SYSDBAPassword_confirm.Text := ed_SYSDBAPassword.Text;
  f.Free;

  // Ініціалізація майстра
  master.PageAdd('Основні',             pStage0);

  AutoSize := true;
  Position := poDesktopCenter;
end;

function Tfveles_conf.AnalizChanges: integer;
var returned: integer;
begin
  returned := 0;

  if(ed_ServerIP.Text = '')then
  begin
    ShowMessage('Не вказано адресу сервера.');
    master.PageIndex := 0;
    ed_ServerIP.SetFocus;
    returned := -1;
  end
  else if(ed_BaseWay.Text = '')then
  begin
    ShowMessage('Не вказано шлях до БД.');
    master.PageIndex := 0;
    ed_BaseWay.SetFocus;
    returned := -1;
  end else if(ed_SYSDBAPassword.Text = '')then
  begin
    ShowMessage('Не вказано пароль SYSDBA');
    master.PageIndex := 0;
    ed_SYSDBAPassword.SetFocus;
    returned := -1;
  end else if(ed_SYSDBAPassword.Text <> ed_SYSDBAPassword_confirm.Text)then
  begin
    ShowMessage('Не не співпадають паролі.');
    master.PageIndex := 0;
    ed_SYSDBAPassword.SetFocus;
    returned := -1;
  end;

  AnalizChanges := returned;
end;

procedure Tfveles_conf.ApplyChanges;
var f: TIniFile;
begin
  f := TIniFile.Create(ini_file);
   f.WriteString('BaseOptions', 'ServerIP', ed_ServerIP.Text);
   f.WriteString('BaseOptions', 'BaseWay', ed_BaseWay.Text);
   f.WriteString('BaseOptions', 'SYSDBAPassword', PasswordCryptor(ed_SYSDBAPassword.Text, true));
  f.Free;
end;

procedure Tfveles_conf.FormCreate(Sender: TObject);
begin
  InitInfo;
end;

procedure Tfveles_conf.FormShow(Sender: TObject);
begin
  master.PageIndex := 0;
end;

procedure Tfveles_conf.masterMasterResult(Sender: TObject;
  MasterResult: ZMasterResult);
begin
  if MasterResult = MasterResultOk then
  begin
    if AnalizChanges = 0 then
    begin
      ApplyChanges;
      Close;
    end
    else
      ModalResult := mrNone;
  end
  else if MasterResult = MasterResultCancel then
  begin
    if not FileExists(ini_file) then
      ApplyChanges;
    Close;
  end;
end;

procedure Tfveles_conf.EditsKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if ((ssCtrl in Shift) and (Key = 13)) then
    masterMasterResult(master, MasterResultOk);
end;

procedure Tfveles_conf.EditsKeyPress(Sender: TObject; var Key: Char);
var currWin: TWinControl;
begin
  currWin := TWinControl(Sender);

  if (Key = Char(13)) then
    master.SetFocusAtNextEdit(TControl(currWin));
end;

procedure Tfveles_conf.EditsKeyUp(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
//
end;

end.
