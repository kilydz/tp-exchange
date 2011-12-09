program Generator;

uses
  Forms,
  uGenerator in 'uGenerator.pas' {Form2},
  uAlgoritm in 'uAlgoritm.pas';

{$R *.res}

begin
  Application.Initialize;
  Application.Title := 'Konkurent-L Store Generator';
  Application.CreateForm(TForm2, Form2);
  Application.Run;
end.
