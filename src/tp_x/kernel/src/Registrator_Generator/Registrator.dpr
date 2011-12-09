program Registrator;

uses
  Forms,
  uRegistrator in 'uRegistrator.pas' {Form1},
  uAlgoritm in 'uAlgoritm.pas';

{$R *.res}

begin
  Application.Initialize;
  Application.Title := 'Konkurent-L Store Registrator';
  Application.CreateForm(TForm1, Form1);
  Application.Run;
end.
