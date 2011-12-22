unit umain;

interface

uses
  Variants, ComObj, Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, ExtCtrls, Menus, IniFiles, DB, IBDatabase, IBSQL, global_h,
  ImgList;

type

  Tflog = class(TForm)
    ed_log: TMemo;
    tt_sync: TTimer;
    tray_icon: TTrayIcon;
    tray_menu: TPopupMenu;
    mi_open: TMenuItem;
    N1: TMenuItem;
    mi_sync: TMenuItem;
    base: TIBDatabase;
    trR: TIBTransaction;
    trW: TIBTransaction;
    qR: TIBSQL;
    qW: TIBSQL;
    tray_images: TImageList;
    procedure FormCloseQuery(Sender: TObject; var CanClose: Boolean);
    procedure tray_iconDblClick(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure tt_syncTimer(Sender: TObject);
    procedure FormCreate(Sender: TObject);
  private
    { Private declarations }
  public
    procedure InitInfo;   // Ініціалізація даних
    procedure SaveToLog(msg: string);   // Запис повідомлення в лог

    function ConnectTP: integer;   // Підключення до ТП
    function DisconnectTP: integer;  // Відключення від ТП
    function Connect1C: integer;     // Підключення до 1C
    function GetKnot: olevariant;   // Отримати вузол обміну
    function Disconnect1C: integer;  // Відключення від 1C
    function RefreshTPMode: integer;  // Отримати поточний режим роботи ТП

    function StepsFill: integer;
    procedure StepsClear;

    function AppRestore: Integer;
    procedure AppMinimize;
  end;

var
  prm: TParametersTP1C;
  flog: Tflog;

implementation

uses ustep;

{$R *.dfm}


procedure Tflog.InitInfo;
var f: TIniFile;
    step: TSyncStep;
begin
  prm.AppWay := ExtractFilePath(Application.ExeName);
  f := TIniFile.Create(prm.AppWay+ini_file_name);
  prm.BaseTP_host := f.ReadString('BaseTP','host','127.0.0.1');
  prm.BaseTP_base := f.ReadString('BaseTP','base','/BASE/TP.GDB');
  prm.BaseTP_base_way := prm.BaseTP_host+':'+prm.BaseTP_base;
  prm.BaseTP_SYSDBApassword := f.ReadString('BaseTP','SYSDBApassword','masterkey');

  prm.Base1C_ole_name := f.ReadString('Base1C','ole_name','V82.Application');
  prm.Base1C_host := Trim(f.ReadString('Base1C','host',''));
  prm.Base1C_base := Trim(f.ReadString('Base1C','base',''));
  prm.Base1C_user := Trim(f.ReadString('Base1C','user',''));
  prm.Base1C_password := Trim(f.ReadString('Base1C','password',''));

  tt_sync.Interval := f.ReadInteger('Sync','tt_sync',300000);
  f.Free;

  prm.lsteps := TList.Create;
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

procedure Tflog.FormDestroy(Sender: TObject);
begin
  StepsClear;
  prm.lsteps.Free;

  Disconnect1C;
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

function Tflog.RefreshTPMode: integer;
begin
  if not base.Connected then
  begin
    Result := -1;
    prm.modeTP := tpmError;
    exit;
  end;

try
  prm.modeTP := tpmCrash;
  if trR.InTransaction then trR.Commit;
  trR.StartTransaction;
  qR.SQL.Text := 'select first(1) tp_mode_id from t_tp_states';
  qR.ExecQuery;
  prm.modeTP := TTPMode(qR.FieldByName('tp_mode_id').AsInteger);
  Result := integer(prm.modeTP);
  if trR.InTransaction then trR.Commit;
except      
  on E: Exception do
  begin
    SaveToLog('Не вдалось визначити режим: ' + E.Message);
    Result := -1;
    prm.modeTP := tpmError;
    if trR.InTransaction then trR.Rollback;
  end
end;

end;

function Tflog.ConnectTP: integer;
begin
  Result := 0;
try
  if base.Connected then base.Close;
  base.DatabaseName:=prm.BaseTP_base_way;
  base.Params.Clear;
  base.Params.Add('user_name=SYSDBA');
  base.Params.Add('password=' + prm.BaseTP_SYSDBApassword);
  base.Params.Add('lc_ctype=WIN1251');
  base.Open;
  prm.sTP_base := base;
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

function Tflog.StepsFill: integer;
var step: TSyncStep;
begin
  // Наповнюємо список кроків поточного режиму
  StepsClear;

try
  if trR.InTransaction then trR.Commit;
  trR.StartTransaction;
  qR.SQL.Text := 'select ss.name, ss.direction, ss.query_tp, ss.query_1c, ss.query_tp_confirm, ' +
        ' ss.query_tp_records, ss.query_tp_record_confirm ' +
        ' from t_1c_sync_steps ss join t_tp_states ts on ss.tp_mode_id = ts.tp_mode_id ' +
        ' where ss.is_active = 1 order by ss.weight';
  qR.ExecQuery;
  while not qR.Eof do
  begin
    step := TSyncStep.Create(@prm,
                qR.FieldByName('name').AsString,
                TStepDirection(qR.FieldByName('direction').AsInteger),
                qR.FieldByName('query_tp').AsString,
                qR.FieldByName('query_1c').AsString,
                qR.FieldByName('query_tp_confirm').AsString,
                qR.FieldByName('query_tp_records').AsString,
                qR.FieldByName('query_tp_record_confirm').AsString);
    qR.Next;
  end;
  if trR.InTransaction then trR.Commit;
except
  on E: Exception do
  begin
    SaveToLog('Не вдалось одержати скрипт синхронізації: ' + E.Message);
    Result := -1;
    prm.modeTP := tpmError;
    if trR.InTransaction then trR.Rollback;
  end
end;

  Result := 0;
end;

procedure Tflog.StepsClear;
var i: integer;
    step: TSyncStep;
begin
  // чистимо кроки синхронізації
  for i := 0 to prm.lsteps.Count - 1 do
  begin
    step := prm.lsteps.Items[i];
    step.Free;
  end;
  prm.lsteps.Clear;
end;

function Tflog.Connect1C: integer;
var  line_conn_1C82: string;
begin
    prm.s1C82_ole :=UnAssigned;
    prm.s1C82_ole := CreateOleObject(prm.Base1C_ole_name);

    if not VarIsEmpty(prm.s1C82_ole) then
    begin
      flog.SaveToLog('1С Connection Created...');
      if prm.Base1C_host = '' then
        line_conn_1C82 := 'File="'+prm.Base1C_base+'"; Usr="'+prm.Base1C_user+
              '"; Pwd="'+prm.Base1C_password+'";'
      else
        line_conn_1C82 := 'Srvr="'+prm.Base1C_host+'"; Ref="'+prm.Base1C_base+
              '"; Usr="'+prm.Base1C_user+'"; Pwd="'+prm.Base1C_password+'";';

      prm.s1C82_ole.Connect(line_conn_1C82);
    end
    else begin
      flog.SaveToLog('Ошибка');
    end;
end;

function Tflog.GetKnot(): olevariant;
var lknots: olevariant;
begin
  lknots :=  prm.s1C82_ole.ExchangePlans.TP_SYNC.Select();
  while lknots.Next() do
  begin
    if lknots.GetObject().Description = 'TP' then
    begin
      prm.s1C82_knot := lknots.GetObject();
    end;
  end;
  GetKnot := prm.s1C82_knot;
end;

function Tflog.Disconnect1C: integer;
begin
 //   if prm.s1C82_ole <> UnAssigned then
 //   begin
      prm.s1C82_ole.Exit(false);
      prm.s1C82_ole := UnAssigned;
 //   end;
    flog.SaveToLog('Disconnect from TP...');
end;

procedure Tflog.tray_iconDblClick(Sender: TObject);
begin
  AppRestore;
end;

procedure Tflog.tt_syncTimer(Sender: TObject);
var step: TSyncStep;
    i: integer;
    dataset_ole: olevariant;
begin
  if prm.is_in_sync then exit; // зараз проходить синхронізація
  prm.is_in_sync := true;
  ConnectTP;
  RefreshTPMode;
  tray_icon.IconIndex := Integer(prm.modeTP) + 1;

  if ((prm.modeTP <> tpmError) and (prm.modeTP <> tpmCrash)) then
  begin
   try
    Connect1C;
    StepsFill;

    for i := 0 to prm.lsteps.Count - 1 do
    begin
      step := prm.lsteps.Items[i];
      step.DoStep;
      // якщо режим > tpmNormal то спробувати перейти в tpmNormal
    end;

    StepsClear;
    Disconnect1C;
   except
    on E: Exception do
    begin
      SaveToLog('Збій процесу синхронізації: ' + E.Message);
      prm.modeTP := tpmError;
    end
   end;
  end;
  DisconnectTP;
  tray_icon.IconIndex := Integer(prm.modeTP) + 1;
  prm.is_in_sync := false;
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
