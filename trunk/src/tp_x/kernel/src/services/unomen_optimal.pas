unit unomen_optimal;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, dxCntner, dxEditor, dxExEdtr, dxEdLib, IBSQL, IBDatabase,
  DB, uZbutton, ExtCtrls, ComCtrls, kernel_h, uZClasses, secure_h, IB;

type
  Tfnomen_optimal = class(TForm)
    Label1: TLabel;
    base: TIBDatabase;
    trR: TIBTransaction;
    trW: TIBTransaction;
    qW: TIBSQL;
    qR: TIBSQL;
    scStyle: TdxEditStyleController;
    ed_termin: TdxSpinEdit;
    ed_log: TdxMemo;
    Panel1: TPanel;
    ZButton1: ZButton;
    bt_optimization: ZButton;
    progress: TProgressBar;
    Label2: TLabel;
    ed_mode: TdxImageEdit;
    procedure bt_optimizationClick(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
  private
    { Private declarations }
  public
    prm: ZVelesInfoRec;
    id_list_mode_0: ZContainerId;
    id_list_mode_1: ZContainerId;

    procedure InitInfo;
    procedure SaveToLog(msg: string);

    function Optimization(id_list: ZContainerId): integer;
  end;


function NomenOptimalDialog(var prm: ZVelesInfoRec): Longint; stdcall;

implementation

{$R *.dfm}

function NomenOptimalDialog(var prm: ZVelesInfoRec): Longint; stdcall;
var
  dlg: Tfnomen_optimal;
begin
  // �������� ����
  if not HasUserAccessEx(prm, ACCESS_TO_NOMENS_OPTIMIZATION) then
    Exit;

  // ��������� �� ����������� ����� ������.
  try
    dlg := Tfnomen_optimal.Create(Application);
    dlg.prm := prm;

    dlg.InitInfo;

// ³��������� ������
   dlg.ShowModal;
  finally
   if dlg <> nil then
     dlg.Free;
  end;
  NomenOptimalDialog := 0;
end;

//------------------------------------------------------------------------------
//
//------------------------------------------------------------------------------
procedure Tfnomen_optimal.FormDestroy(Sender: TObject);
begin
  id_list_mode_0.Free;
  id_list_mode_1.Free;
end;

procedure Tfnomen_optimal.InitInfo;
begin
  base.SetHandle(prm.db_handle);

  ed_log.Clear;
  ed_log.Lines.Add('���� ������:');
  ed_log.Lines.Add('ϳ��� ���������� �� ������ "����������� ����������", '+
' � ���������� �� ������, ������ ������� ������� 䳿:');
  ed_log.Lines.Add(' - "������� (���� ������� = 0)" - �� ����� ������ ������, ' +
' � �������� ��������, �� ���� �� ���� ���� ������� ���� ' +
' ������� ������� ��� ������ ������ �� ������� � ����������� �����������.');
  ed_log.Lines.Add(' - "�������� (���� ������� > 0)" - �� ����� � ������ ������ ������, ' +
' � ������� (�-�� > 0) ��������, �� ���� �� ���� ���� ������� ���� ' +
' ������� ������� ��� ������ ������ �� ��������. �� �� ����� ��������� ' +
' ������, ��� ����� ������� � ���');

  id_list_mode_0 := ZContainerId.Create;     // ��������� ���������� ������ ����
  if trR.InTransaction then trR.Commit;
  trR.StartTransaction;
   qR.Close;

   // ����������� ������ ���� ������
   qR.SQL.Text := 'select n.nomen_id from t_nomens n, t_rests r ' +
' where n.nomen_id = r.nomen_id and r.objects_id = 1 and ' +
' n.is_visible = 1 and  absrizn(r.rest, 0.0) < 0.001';
   qR.ExecQuery;
   while not qR.Eof do
   begin
     id_list_mode_0.Add(qR.FieldByName('nomen_id').AsInteger);
     qR.Next;
   end;
  if trR.InTransaction then trR.Commit;
  progress.Max := id_list_mode_0.Count;
  ed_log.Lines.Add('');
  ed_log.Lines.Add(' - � ����� "������� (���� ������� = 0)" ���� ��������� ' +
IntToStr(id_list_mode_0.Count) + ' ������.');


  id_list_mode_1 := ZContainerId.Create;     // ��������� ���������� ������ ����
  if trR.InTransaction then trR.Commit;
  trR.StartTransaction;
   qR.Close;

   // ����������� ������ ���� ������
   qR.SQL.Text := 'select n.nomen_id from t_nomens n, t_rests r ' +
' where n.nomen_id = r.nomen_id and r.objects_id = 1 and ' +
' n.is_visible = 1 and n.is_active = 1 and r.rest > 0.001';
   qR.ExecQuery;
   while not qR.Eof do
   begin
     id_list_mode_1.Add(qR.FieldByName('nomen_id').AsInteger);
     qR.Next;
   end;
  if trR.InTransaction then trR.Commit;
  progress.Max := id_list_mode_1.Count;
  ed_log.Lines.Add(' - � ����� "�������� (���� ������� > 0)" ���� ��������� ' +
IntToStr(id_list_mode_1.Count) + ' ������.');

end;

procedure Tfnomen_optimal.SaveToLog(msg: string);
begin
  msg := DateToStr(Date) + ' ' + TimeToStr(Now) + ' ' + msg;
  ed_log.Lines.Add(msg);
end;

procedure Tfnomen_optimal.bt_optimizationClick(Sender: TObject);
var i: integer;
    changed: integer;
begin
  ed_log.Lines.Add('');
  if (ed_mode.Text = '0') then
    ed_log.Lines.Add(' - �������� ���������� ' + IntToStr(Optimization(id_list_mode_0)) + ' ������.')
  else
    ed_log.Lines.Add(' - �������� ����������� ' + IntToStr(Optimization(id_list_mode_1)) + ' ������.');
end;

function Tfnomen_optimal.Optimization(id_list: ZContainerId): integer;
var i: integer;
    changed: integer;
begin
 try
  progress.Position := 0;
  changed := 0;
  for i := 0 to id_list.Count - 1 do
  begin
    if trW.InTransaction then trW.Commit;
    trW.StartTransaction;
     qW.SQL.Text := 'select ochange from PS_NOMEN_OPTIMIZER_V1(:inomen_id, :idays, :imode)';
     qW.ParamByName('inomen_id').AsInteger := id_list.FindId(i);
     qW.ParamByName('idays').AsInteger := StrToInt(ed_termin.Text);
     qW.ParamByName('imode').AsInteger := StrToInt(ed_mode.Text);
     qW.ExecQuery;
     changed := changed + qW.FieldByName('ochange').AsInteger;
    if trW.InTransaction then trW.Commit;
    progress.Position := i;
  end;
  progress.Position := 0;
 except
  on E: EIBInterbaseError do
  begin
    if trW.InTransaction then trW.Rollback;
    SaveToLog('���: ' + #13 + E.Message + #13);
  end;
 end;
  Result := changed;
end;

end.
