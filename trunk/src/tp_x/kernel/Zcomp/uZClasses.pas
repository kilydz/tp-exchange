unit uZClasses;

interface
uses Classes, Dialogs, SysUtils;

type

  ZContainerId = class
  private
     id_list: TList;
  public
     constructor Create;
     destructor Destroy; override;

     procedure Add(id: integer);
     procedure Delete(id: integer);
     function Count: integer;
     function FindIdx(id: integer): integer;
     function FindId(idx: integer): integer;
     function GenerateList: AnsiString;
     function GenerateSpaceList: AnsiString;
     procedure Clear;
   end;

  ZDuplexId = record
     id0, id1: integer;
  end;

  ZContainerDuplexId = class
  private
     id_list: TList;
  public
     constructor Create;
     destructor Destroy; override;

     procedure Add(id0: integer; id1: integer);
     procedure Delete(id: ZDuplexId);
     function Count: integer;
     function FindIdx(id: ZDuplexId): integer;
     function FindId0ById1(id1: integer): integer;
     function FindId1ById0(id0: integer): integer;
     function FindId(idx: integer): ZDuplexId;
     procedure Clear;
   end;
implementation

//-------------------------------------------------------------------
constructor ZContainerId.Create;
begin
  id_list := TList.Create;
end;

destructor ZContainerId.Destroy;
begin
  Clear;
  id_list.Free;
  inherited Destroy;
end;

procedure ZContainerId.Add(id: integer);
var lp_id: ^integer;
begin
  New(lp_id);
  lp_id^ := id;
  id_list.Add(lp_id);
end;

procedure ZContainerId.Delete(id: integer);
var i: integer;
    lp_id: ^integer;
begin
  i := FindIdx(id);
  if (i >= 0) then
  begin
    lp_id := id_list.Items[i];
    Dispose(lp_id);
    id_list.Delete(i);
  end;
end;

function ZContainerId.Count: integer;
begin
  Count := id_list.Count;
end;

function ZContainerId.FindIdx(id: integer): integer;
var i: integer;
    rez: integer;
    lp_id: ^integer;
begin
  rez := -1;
  i := 0;
  while (rez < 0) and (i < id_list.Count) do
  begin
    lp_id := id_list.Items[i];
    if (lp_id <> nil) and (lp_id^ = id) then
      rez := i
    else
      i := i + 1;
  end;
  FindIdx := rez;
end;

function ZContainerId.FindId(idx: integer): integer;
var lp_id: ^integer;
begin
  lp_id := id_list.Items[idx];
  FindId := lp_id^;
end;

function ZContainerId.GenerateList: AnsiString;
var rez: AnsiString;
    i: integer;
    lp_id: ^integer;
begin
  rez := '0';
  i := 0;
  while (i < id_list.Count) do
  begin
    lp_id := id_list.Items[i];
    rez := rez + ',' + IntToStr(lp_id^);
    i := i + 1;
  end;

  GenerateList := rez;
end;

function ZContainerId.GenerateSpaceList: AnsiString;
var rez: AnsiString;
    i: integer;
    lp_id: ^integer;
begin
  rez := ' ';
  i := 0;
  while (i < id_list.Count) do
  begin
    lp_id := id_list.Items[i];
    rez := rez + ' ' + IntToStr(lp_id^);
    i := i + 1;
  end;
  rez := rez + ' ';

  GenerateSpaceList := rez;
end;

procedure ZContainerId.Clear;
var i: integer;
    lp_id: ^integer;
begin
  for i := 0 to id_list.Count - 1 do
  begin
    lp_id := id_list.Items[i];
    if lp_id <> nil then
      Dispose(lp_id);
  end;
  id_list.Clear;
end;

//------------------------------------------------------------------------------
constructor ZContainerDuplexId.Create;
begin
  id_list := TList.Create;
end;

destructor ZContainerDuplexId.Destroy;
begin
  Clear;
  id_list.Free;
  inherited Destroy;
end;

procedure ZContainerDuplexId.Add(id0, id1: integer);
var lp_id: ^ZDuplexId;
begin
  New(lp_id);
  lp_id^.id0 := id0;
  lp_id^.id1 := id1;
  id_list.Add(lp_id);
end;

procedure ZContainerDuplexId.Delete(id: ZDuplexId);
var i: integer;
    lp_id: ^ZDuplexId;
begin
  i := FindIdx(id);
  if (i >= 0) then
  begin
    lp_id := id_list.Items[i];
    Dispose(lp_id);
    id_list.Delete(i);
  end;
end;

function ZContainerDuplexId.Count: integer;
begin
  Count := id_list.Count;
end;

function ZContainerDuplexId.FindIdx(id: ZDuplexId): integer;
var i: integer;
    rez: integer;
    lp_id: ^ZDuplexId;
begin
  rez := -1;
  i := 0;
  while (rez < 0) and (i < id_list.Count) do
  begin
    lp_id := id_list.Items[i];
    if (lp_id <> nil) and (lp_id^.id0 = id.id0) and (lp_id^.id1 = id.id1) then
      rez := i
    else
      i := i + 1;
  end;
  FindIdx := rez;
end;

function ZContainerDuplexId.FindId0ById1(id1: integer): integer;
var i: integer;
    rez: integer;
    lp_id: ^ZDuplexId;
begin
  rez := -1;
  i := 0;
  while (rez < 0) and (i < id_list.Count) do
  begin
    lp_id := id_list.Items[i];
    if (lp_id <> nil) and (lp_id^.id1 = id1) then
      rez := lp_id^.id0
    else
      i := i + 1;
  end;
  Result := rez;
end;

function ZContainerDuplexId.FindId1ById0(id0: integer): integer;
var i: integer;
    rez: integer;
    lp_id: ^ZDuplexId;
begin
  rez := -1;
  i := 0;
  while (rez < 0) and (i < id_list.Count) do
  begin
    lp_id := id_list.Items[i];
    if (lp_id <> nil) and (lp_id^.id0 = id0) then
      rez := lp_id^.id1
    else
      i := i + 1;
  end;
  Result := rez;
end;


function ZContainerDuplexId.FindId(idx: integer): ZDuplexId;
var lp_id: ^ZDuplexId;
begin
  lp_id := id_list.Items[idx];
  FindId := lp_id^;
end;

procedure ZContainerDuplexId.Clear;
var i: integer;
    lp_id: ^ZDuplexId;
begin
  for i := 0 to id_list.Count - 1 do
  begin
    lp_id := id_list.Items[i];
    if lp_id <> nil then
      Dispose(lp_id);
  end;
  id_list.Clear;
end;

end.
