unit uDM;

interface

uses
  SysUtils, Classes, IBSQL, IBDatabase, DB;

type
  TDataModule1 = class(TDataModule)
    IBDatabase1: TIBDatabase;
    IBTransaction1: TIBTransaction;
    IBSQL1: TIBSQL;
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  DM: TDataModule1;

implementation

{$R *.dfm}

end.
