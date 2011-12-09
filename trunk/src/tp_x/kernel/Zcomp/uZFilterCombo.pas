unit uZFilterCombo;

interface

uses
  Windows, Messages, SysUtils, Classes, Controls, StdCtrls, CheckLst, uZClasses,
  IniFiles, IB, IBHeader, IBDataBase, IBSQL, Dialogs;

type
  ZFilterCombo = class(TCheckListBox)

  private
    { Private declarations }
    list: ZContainerId;
    was_all_checked: boolean;

  protected
    { Protected declarations }
    procedure ClickCheck(Sender: TObject);
  public
    { Public declarations }
    procedure Clear; override;
  published
    { Published declarations }
    procedure InitFilter;
    procedure AddLine(txt: string; id: integer);
    procedure FillFromSQL(sql: string; db_handle: TISC_DB_HANDLE);
    procedure FillFromSQLChecked(sql: string; db_handle: TISC_DB_HANDLE);

    procedure SaveToIni(file_name: string; section: string);
    procedure LoadFromIni(file_name: string; section: string);
    function GenerateList: AnsiString;
    function GenerateSpaceList: AnsiString;
    function GetCheckedCount: integer;
    function PosToId(pos: integer): integer;

    constructor Create(AOwner:TComponent); override;

    destructor Destroy; override;
  end;

procedure Register;

implementation

procedure Register;
begin
  RegisterComponents('Freedom', [ZFilterCombo]);
end;

constructor ZFilterCombo.Create(AOwner:TComponent);
begin
  inherited Create(AOwner);
//  Parent := TWinControl(AOwner);
  Visible := true;


  self.ParentColor := false;
  self.ParentCtl3D := false;
  self.ParentFont := false;
  self.ParentShowHint := false;
  BevelInner := bvNone;
  BevelKind := bkNone;
  BevelOuter := bvLowered;
  OnClickCheck := ClickCheck;

  list := ZContainerId.Create;

  was_all_checked := false;
end;

destructor ZFilterCombo.Destroy;
begin
  inherited Destroy;
  list.Destroy;
end;

procedure ZFilterCombo.InitFilter;
begin
  Clear;
end;

procedure ZFilterCombo.AddLine(txt: string; id: integer);
begin
  list.Add(id);
  Self.Items.Add(txt);
end;

procedure ZFilterCombo.FillFromSQL(sql: string; db_handle: TISC_DB_HANDLE);
var tr: TIBTransaction;
    q: TIBSQL;
    base: TIBDatabase;
begin
  Clear;

  base := TIBDatabase.Create(nil);
  tr := TIBTransaction.Create(nil);
  q := TIBSQL.Create(nil);
 try
  base.SetHandle(db_handle);
  base.DefaultTransaction := tr;
  tr.DefaultDatabase := base;
  q.Transaction := tr;

  if tr.InTransaction then tr.Commit;
  tr.StartTransaction;
   q.SQL.Text := sql;
   q.ExecQuery;
   while not q.Eof do
   begin
     AddLine(q.FieldByName('name').AsString, q.FieldByName('id').AsInteger);
     q.Next;
   end;
  if tr.InTransaction then tr.Commit;
 finally
   if tr.InTransaction then tr.Rollback;
   q.Free;
   tr.Free;
   base.Free;
 end;

end;

procedure ZFilterCombo.FillFromSQLChecked(sql: string; db_handle: TISC_DB_HANDLE);
var tr: TIBTransaction;
    q: TIBSQL;
    base: TIBDatabase;
begin
  Clear;

  base := TIBDatabase.Create(nil);
  tr := TIBTransaction.Create(nil);
  q := TIBSQL.Create(nil);
 try
  base.SetHandle(db_handle);
  base.DefaultTransaction := tr;
  tr.DefaultDatabase := base;
  q.Transaction := tr;

  if tr.InTransaction then tr.Commit;
  tr.StartTransaction;
   q.SQL.Text := sql;
   q.ExecQuery;
   while not q.Eof do
   begin
     AddLine(q.FieldByName('name').AsString, q.FieldByName('id').AsInteger);
     Self.Checked[Self.Count - 1] := (q.FieldByName('is_checked').AsInteger > 0);
     q.Next;
   end;
  if tr.InTransaction then tr.Commit;
 finally
   if tr.InTransaction then tr.Rollback;
   q.Free;
   tr.Free;
   base.Free;
 end;

end;

procedure ZFilterCombo.SaveToIni(file_name: string; section: string);
var f: TIniFile;
    i: integer;
    rec_name: string;
begin
  f := TIniFile.Create(file_name);
  for i := 1 to Items.Count - 1 do
  begin
   rec_name := section + IntToStr(list.FindId(i - 1));
   f.WriteBool(section, rec_name, Self.Checked[i]);
  end;
  f.Destroy;
end;

procedure ZFilterCombo.LoadFromIni(file_name: string; section: string);
var f: TIniFile;
    i: integer;
    rec_name: string;
begin
  f := TIniFile.Create(file_name);
  for i := 1 to Items.Count - 1 do
  begin
   rec_name := section + IntToStr(list.FindId(i - 1));
   Self.Checked[i] := f.ReadBool(section, rec_name, true);
  end;
  f.Destroy;
end;

function ZFilterCombo.GenerateList: AnsiString;
var check_list: ZContainerId;
    i: integer;
begin
  check_list := ZContainerId.Create;
  for i := 1 to Items.Count - 1 do
  begin
   if Checked[i] then
     check_list.Add(list.FindId(i - 1));
  end;
  GenerateList := check_list.GenerateList;
  check_list.Destroy;
end;

function ZFilterCombo.GenerateSpaceList: AnsiString;
var check_list: ZContainerId;
    i: integer;
begin
  check_list := ZContainerId.Create;
  for i := 1 to Items.Count - 1 do
  begin
   if Checked[i] then
     check_list.Add(list.FindId(i - 1));
  end;
  GenerateSpaceList := check_list.GenerateSpaceList;
  check_list.Destroy;
end;

function ZFilterCombo.GetCheckedCount: integer;
var checked_count: integer;
    i: integer;
begin
  checked_count := 0;
  for i := 1 to Items.Count - 1 do
  begin
   if Checked[i] then
     checked_count := checked_count + 1;
  end;
  GetCheckedCount := checked_count;
end;

procedure ZFilterCombo.Clear;
begin
  inherited Clear;
  Items.Add('Óñå');
  list.Clear;
end;

function ZFilterCombo.PosToId(pos: integer): integer;
begin
  PosToId := list.FindId(pos - 1);
end;

procedure ZFilterCombo.ClickCheck(Sender: TObject);
var i: integer;
begin
  if (was_all_checked <> Self.Checked[0]) then
  begin
    for i := 1 to Items.Count - 1 do
    begin
      Checked[i] := Checked[0];
    end;
    was_all_checked := Checked[0];
  end;

  for i := 1 to Items.Count - 1 do
  begin
    if not Checked[i] then
    begin
      Checked[0] := false;
      was_all_checked := false;
    end
  end;
end;

end.
