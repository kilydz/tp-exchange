program veles_conf;

uses
  Forms,
  uveles_conf in 'uveles_conf.pas' {fveles_conf},
  utils_h in '..\..\include\utils_h.pas';

{$R *.res}

begin
  Application.Initialize;
  Application.CreateForm(Tfveles_conf, fveles_conf);
  Application.Run;
end.
