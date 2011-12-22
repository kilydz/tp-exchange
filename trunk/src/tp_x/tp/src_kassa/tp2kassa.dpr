program tp2kassa;

uses
  Forms,
  umain in 'umain.pas' {flog},
  global_h in 'global_h.pas';

{$R *.res}

begin
  Application.Initialize;
  Application.CreateForm(Tflog, flog);
  Application.Run;
end.
