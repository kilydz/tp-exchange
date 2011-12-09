unit ubase_conf;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, dxCntner, dxEditor, dxEdLib, StdCtrls, ExtCtrls, uZMaster, IniFiles,
  DB, IBDatabase, ComObj, Animate, ComCtrls;

type
  Tfveles_conf = class(TForm)
    master: ZMaster;
    dxEditStyleController: TdxEditStyleController;
    pStage0: TPanel;
    Label1: TLabel;
    Label2: TLabel;
    Label4: TLabel;
    ed_ServerIP: TdxEdit;
    ed_BaseWay: TdxEdit;
    ed_SYSDBAPassword: TdxEdit;
    base: TIBDatabase;
    Label3: TLabel;
    l_process: TAnimate;
    l_progress: TLabel;
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
  end;

  try
    if base.Connected then base.Close;
    base.DatabaseName := ed_ServerIP.Text + ':' + ed_BaseWay.Text;
    base.Params.Clear;
    base.Params.Add('user_name=SYSDBA');
    base.Params.Add('password=' + ed_SYSDBAPassword.Text);
    base.Params.Add('lc_ctype=WIN1251');
    base.Open;
    ShowMessage('Така база даних вже існує. Вкажіть інший шлях.');
    master.PageIndex := 0;
    ed_BaseWay.SetFocus;
    returned := -1;
  except
  end;

  AnalizChanges := returned;
end;

procedure Tfveles_conf.ApplyChanges;
var
str: string;
  WshShell:variant;
  f:TextFile;
begin
  try
    str := ExtractFilePath(ed_BaseWay.Text);
    MkDir(str);
  except
  end;

    WshShell := CreateOleObject('WScript.Shell');

    AssignFile(f, 'base_cr.sql');
    Rewrite(f);
    WriteLn(f,'SET SQL DIALECT 3;');
    WriteLn(f,'SET NAMES WIN1251;');
    WriteLn(f,'CREATE DATABASE ''' + base.DatabaseName +
       ''' USER ''SYSDBA'' PASSWORD ''' + ed_SYSDBAPassword.Text +
       ''' PAGE_SIZE 16384 DEFAULT CHARACTER SET WIN1251;');
    CloseFile(f);

    str := 'isql -i base_cr.sql';
    WshShell.Run(str, 0, true);
   try
      if base.Connected then base.Close;
      base.DatabaseName := ed_ServerIP.Text + ':' + ed_BaseWay.Text;
      base.Params.Clear;
      base.Params.Add('user_name=SYSDBA');
      base.Params.Add('password=' + ed_SYSDBAPassword.Text);
      base.Params.Add('lc_ctype=WIN1251');
      base.Open;
      base.Close;

      l_process.FileName := 'process.avi';
      l_process.Active := true;
      l_process.Visible := true;
      Label3.Visible := true;
      l_progress.Visible := true;

      l_progress.Caption := '- скрипт метаданих';
      str := 'isql ' + base.DatabaseName + ' -i MD.sql -u SYSDBA -p ' + ed_SYSDBAPassword.Text;
      WshShell.Run(str, 0, true);
      l_progress.Caption := '- скрипт ініціалізації даних';
      str := 'isql ' + base.DatabaseName + ' -i data_init.sql -u SYSDBA -p ' + ed_SYSDBAPassword.Text;
      WshShell.Run(str, 0, true);
      l_progress.Caption := '- скрипт ініціалізації адрес';
      str := 'isql ' + base.DatabaseName + ' -i points_init.sql -u SYSDBA -p ' + ed_SYSDBAPassword.Text;
      WshShell.Run(str, 0, true);

      l_process.Active := false;
      l_process.Visible := false;
      Label3.Visible := false;
      l_progress.Visible := false;
      ShowMessage('Створення бази даних завершено. Можна розпочинати встановлення додаткового ПЗ');
   except
      ShowMessage('Не вдалось виконати скрипти генерації бази даних. Зверніться до сервісних інженерів.');
   end;
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
    Close;
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
