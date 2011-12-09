program base_config;

uses
  Forms,
  ubase_conf in 'ubase_conf.pas' {fveles_conf};

{$R *.res}

begin
  Application.Initialize;
  Application.CreateForm(Tfveles_conf, fveles_conf);
  Application.Run;
end.
