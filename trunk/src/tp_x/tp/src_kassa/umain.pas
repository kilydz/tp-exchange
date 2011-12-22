unit umain;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, Menus, ExtCtrls, ImgList, IBSQL, IBDatabase, DB, IniFiles,
  global_h;

type
  Tflog = class(TForm)
    base: TIBDatabase;
    trR: TIBTransaction;
    qR: TIBSQL;
    trW: TIBTransaction;
    qW: TIBSQL;
    tt_sync: TTimer;
    tray_images: TImageList;
    tray_icon: TTrayIcon;
    tray_menu: TPopupMenu;
    mi_open: TMenuItem;
    N1: TMenuItem;
    mi_sync: TMenuItem;
    ed_log: TMemo;
    procedure tt_syncTimer(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormCloseQuery(Sender: TObject; var CanClose: Boolean);
  private
    { Private declarations }
  public
    procedure InitInfo;   // Ініціалізація даних
    procedure SaveToLog(msg: string);   // Запис повідомлення в лог

    function ConnectTP: integer;   // Підключення до ТП
    function DisconnectTP: integer;  // Відключення від ТП

    function AppRestore: Integer;
    procedure AppMinimize;
  end;

var
  prm: TParametersTPKassa;
  flog: Tflog;

implementation

{$R *.dfm}

procedure Tflog.InitInfo;
var f: TIniFile;
begin
  prm.AppWay := ExtractFilePath(Application.ExeName);
  f := TIniFile.Create(prm.AppWay+ini_file_name);

  prm.BaseL_base := f.ReadString('BaseTP','base','/BASE/FB_KASSA.GDB');
  prm.BaseL_base_way := '192.168.133.55:'+prm.BaseL_base;
  prm.BaseL_SYSDBApassword := f.ReadString('BaseTP','SYSDBApassword','masterkey');

  tt_sync.Interval := f.ReadInteger('Sync','tt_sync',3000);
  f.Free;

  tray_icon.IconIndex := 0;

  prm.is_in_sync := false;
  tt_sync.Enabled := true;
end;

procedure Tflog.FormCloseQuery(Sender: TObject; var CanClose: Boolean);
begin
  CanClose:=false;
  AppMinimize;
end;

procedure Tflog.FormCreate(Sender: TObject);
begin
  InitInfo;
end;

procedure Tflog.SaveToLog(msg: string);
var tf: TextFile;
begin
  AssignFile(tf, prm.AppWay+log_file_name);
  if FileExists(prm.AppWay+log_file_name) then
    Append(tf)
  else
    ReWrite(tf);
  writeln(tf, msg);
  CloseFile(tf);
  ed_log.Lines.Add(msg);
end;

procedure Tflog.tt_syncTimer(Sender: TObject);
begin
  if prm.is_in_sync then exit; // зараз проходить синхронізація
  prm.is_in_sync := true;
  ConnectTP;
   try
    if trW.InTransaction then trW.Commit;
    trW.StartTransaction;
     qW.SQL.Text := 'select omsg from PS_FR_SYNC(NULL, NULL, NULL, NULL)';
     qW.ExecQuery;
     while (not qW.Eof) do
     begin
       SaveToLog(qW.FieldByName('OMSG').AsString);
       qW.Next;
     end;
    if trW.InTransaction then trW.Commit;
   except
    on E: Exception do
    begin
      flog.SaveToLog('' + E.Message);
      if trW.InTransaction then trW.Rollback;
    end;
   end;
  DisconnectTP;
  tray_icon.IconIndex := 1;
  prm.is_in_sync := false;
end;

function Tflog.ConnectTP: integer;
begin
  Result := 0;
try
  if base.Connected then base.Close;
  base.DatabaseName:=prm.BaseL_base_way;
  base.Params.Clear;
  base.Params.Add('user_name=SYSDBA');
  base.Params.Add('password=' + prm.BaseL_SYSDBApassword);
  base.Params.Add('lc_ctype=WIN1251');
  base.Open;
  prm.sL_base := base;
  flog.SaveToLog('TP Connection Created...');
except
  on E: Exception do
  begin
    SaveToLog('Не вдалося з''єднатися: ' + E.Message);
    Result := -1;
  end
end;

end;

function Tflog.DisconnectTP: integer;
begin
  if base.Connected then base.Close;
  flog.SaveToLog('Disconnect from TP...');
end;

procedure Tflog.AppMinimize;
begin
    tray_icon.Visible := true;
    ShowWindow(Application.Handle, SW_HIDE);
    ShowWindow(Application.MainForm.Handle, SW_HIDE);    
end;

function Tflog.AppRestore: Integer;
begin
   Result:=-1;

   Application.Restore;
   ShowWindow(Application.MainForm.Handle, SW_SHOW);
   SetForeGroundWindow(Application.MainForm.Handle);
   //tray_icon.Visible := false;
   Result:=0;
end;

end.
