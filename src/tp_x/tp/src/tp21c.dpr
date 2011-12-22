program tp21c;

uses
  Forms,
  Windows,
  umain in 'umain.pas' {flog},
  ustep in 'ustep.pas',
  global_h in 'global_h.pas';

var
  Semaphore: integer;
  SemaphoreName: array[0..511] of AnsiChar;

{$R *.res}

// Перевірка унікальності запущеної програми
function StopLoading(): boolean;
var l: integer;
    i: integer;
begin
    l := GetModuleFileName(MainInstance, SemaphoreName, sizeof(SemaphoreName));
    for i := 0 to l-1 do
        if(SemaphoreName[i] = '\') then
            SemaphoreName[i] := '/';
    Semaphore := CreateSemaphore(nil, 1, 1, SemaphoreName);
    StopLoading := (WaitForSingleObject(Semaphore, 50) <> WAIT_OBJECT_0);
end;

begin
  Application.Initialize;

  if (StopLoading()) then Exit;

  Application.CreateForm(Tflog, flog);
  Application.Run;
end.
