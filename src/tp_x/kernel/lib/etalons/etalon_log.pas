unit etalon_log;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ComCtrls, StdCtrls, uZbutton, ExtCtrls, dxCntner, dxEditor, dxExEdtr,
  dxEdLib, kernel_h, IBSQL, IBDatabase, DB;

type
  TStepFunction = procedure() of object; 

  TStep = record
    func: TStepFunction;
  end;
  lpStep = ^TStep;

  Tfetalon_log = class(TForm)
    ed_log: TdxMemo;
    Panel1: TPanel;
    bt_cancel: ZButton;
    l_pos: TProgressBar;
    t_start: TTimer;
    base: TIBDatabase;
    trR: TIBTransaction;
    qR: TIBSQL;
    trW: TIBTransaction;
    qW: TIBSQL;
    procedure FormDestroy(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure t_startTimer(Sender: TObject);
  private
    { Private declarations }
  public
    prm: ZVelesInfoRec;
    steps: TList;

    procedure InitInfo(); virtual; 
    procedure AddStep(var ifunc: TStepFunction);
    procedure AddToLog(str: string);
  end;


implementation

{$R *.dfm}


procedure Tfetalon_log.FormCreate(Sender: TObject);
begin
  steps := TList.Create;
end;

procedure Tfetalon_log.FormDestroy(Sender: TObject);
var i: integer;
    step: lpStep;
begin
  for i := 0 to steps.Count - 1 do
  begin
    step := steps.Items[i];
    Dispose(step);
  end;
  steps.Free;
end;

procedure Tfetalon_log.InitInfo();
begin
  base.SetHandle(prm.db_handle);
end;

procedure Tfetalon_log.AddToLog(str: string);
begin
  ed_log.Lines.Add(str);
  ed_log.Refresh;
end;

procedure Tfetalon_log.AddStep(var ifunc: TStepFunction);
var step: lpStep;
begin
  New(step);
  step.func := ifunc;
  steps.Add(step);
end;

procedure Tfetalon_log.t_startTimer(Sender: TObject);
var i: integer;
    step: lpStep;
begin
  t_start.Enabled := false;
  l_pos.Position := 0;
  bt_cancel.Enabled := false;

  for i := 0 to steps.Count - 1 do
  begin
    step := steps.Items[i];
    step.func;
  end;

  l_pos.Position := 0;
  bt_cancel.Enabled := true;
end;

end.
