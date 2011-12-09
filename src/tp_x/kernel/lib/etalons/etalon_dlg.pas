unit etalon_dlg;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, dxCntner, IBSQL, IBDatabase, DB, uZMaster, ExtCtrls, ComCtrls,
  kernel_h, IB, dxEditor, dxExEdtr, dxEdLib, secure_h;

type
  Tfetalon_dlg = class(TForm)
    base: TIBDatabase;
    trR: TIBTransaction;
    qR: TIBSQL;
    qW: TIBSQL;
    trW: TIBTransaction;
    scStyle: TdxEditStyleController;
    master: ZMaster;
    p_pages: TPageControl;
    procedure masterMasterResult(Sender: TObject;
      MasterResult: ZMasterResult); virtual;

    procedure EditsKeyDown(Sender: TObject; var Key: Word;
                        Shift: TShiftState); virtual;
    procedure EditsKeyPress(Sender: TObject; var Key: Char); virtual;
    procedure EditsKeyUp(Sender: TObject; var Key: Word;
                        Shift: TShiftState); virtual;
    procedure FormShow(Sender: TObject);
    procedure FormDestroy(Sender: TObject); virtual;
  private
    { Private declarations }
  public
    id: ZFuncArgs;
    prm: ZVelesInfoRec;

    procedure InitInfo; virtual;
    procedure InitINS; virtual;
    procedure InitUPD; virtual;
    procedure InitControls; virtual;

    function  AnalizChanges: integer; virtual;

    procedure ApplyChanges; virtual;
    procedure ApplyControls; virtual;
    procedure ApplyINS; virtual;
    procedure ApplyUPD; virtual;
    procedure ApplyDefault; virtual;

    procedure ListInit(ed_list: TdxImageEdit; sql_fill: string);
    procedure ListClear(ed_list: TdxImageEdit);

    function GetNextID(gen_name: string): integer;
  end;

function IntToBool(ival: integer): boolean;
function BoolToInt(bval: boolean): integer;

var
  fetalon_dlg: Tfetalon_dlg;

implementation

{$R *.dfm}

procedure Tfetalon_dlg.InitInfo;
var i: integer;
    panel: TPanel;
begin
  base.SetHandle(prm.db_handle);
  for i:=0 to p_pages.PageCount - 1 do
  begin
    panel := TPanel(p_pages.Pages[i].Controls[0]);
    master.PageAdd(p_pages.Pages[i].Caption, panel);
  end;

  if (id.id <= 0) then
    InitINS
  else
    InitUPD;
  InitControls;

  AutoSize := true;
  Position := poScreenCenter;
end;

procedure Tfetalon_dlg.InitINS;
begin

end;

procedure Tfetalon_dlg.InitUPD;
begin

end;

procedure Tfetalon_dlg.InitControls;
begin

end;

function  Tfetalon_dlg.AnalizChanges: integer;
begin
  AnalizChanges := 0;
end;

procedure Tfetalon_dlg.ApplyChanges;
begin
  // Підготовка даних
  ApplyControls;

 try
  if(trW.InTransaction)then trW.Commit;
  trW.StartTransaction;
   if id.id <= 0 then
   begin
     ApplyINS;
   end
   else if id.id > 0 then
   begin
     ApplyUPD;
   end;
   ApplyDefault;
  if(trW.InTransaction) then trW.Commit;

 except
 
  on E: EIBInterbaseError do
  begin
    if trW.InTransaction then trW.Rollback;
    ShowMessage(Format('Відбувся збій: %s Повідомте розробників про помилку.', [#13 + E.Message + #13]));
    ModalResult := mrNone;
  end;
 end;

end;

procedure Tfetalon_dlg.ApplyControls;
begin
end;

procedure Tfetalon_dlg.ApplyINS;
begin
end;

procedure Tfetalon_dlg.ApplyUPD;
begin
end;

procedure Tfetalon_dlg.ApplyDefault;
begin
end;

procedure Tfetalon_dlg.EditsKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if ((ssCtrl	in Shift) and (Key = 13)) then
    masterMasterResult(master, MasterResultOk);

  if ((ssCtrl	in Shift) and (Key = VK_LEFT)) then
  begin
    if master.PageIndex > 0 then
      master.PageIndex := master.PageIndex - 1;
  end;

  if ((ssCtrl	in Shift) and (Key = VK_RIGHT)) then
  begin
    if master.PageIndex < master.PagesCount - 1 then
      master.PageIndex := master.PageIndex + 1;
  end;

  if (Key = VK_ESCAPE) then
    masterMasterResult(master, MasterResultCancel);
end;

procedure Tfetalon_dlg.EditsKeyPress(Sender: TObject; var Key: Char);
var currWin: TWinControl;
begin
  currWin := TWinControl(Sender);

  if (Key = Char(13)) then
    master.SetFocusAtNextEdit(TControl(currWin));

  if (Sender.ClassName = 'TdxCalcEdit') then
  begin
    if ((Key = '.') or (Key = ',')) then
      Key := ','
    else if (Key < '0') or (Key > '9') then
      Key := #0;
  end
end;

procedure Tfetalon_dlg.EditsKeyUp(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
//
end;

procedure Tfetalon_dlg.masterMasterResult(Sender: TObject;
  MasterResult: ZMasterResult);
begin
  if MasterResult = MasterResultOk then
  begin
    if AnalizChanges = 0 then
    begin
      ModalResult := mrOk;
      ApplyChanges;
    end
    else
      ModalResult := mrNone;
  end
  else if MasterResult = MasterResultCancel then
    ModalResult := mrCancel;
end;

procedure Tfetalon_dlg.FormShow(Sender: TObject);
begin
  master.PageIndex := 0;
end;

procedure Tfetalon_dlg.FormDestroy(Sender: TObject);
begin
//
end;

// Процедура заповнення випадаючого списку з запроса
procedure Tfetalon_dlg.ListInit(ed_list: TdxImageEdit; sql_fill: string);
begin
  if(trR.InTransaction)then trR.Commit;
  trR.StartTransaction;
   qR.SQL.Text := sql_fill;
   qR.ExecQuery;
   while not qR.Eof do
   begin
     ed_list.Descriptions.Add(qR.FieldByName('name').AsString);
     ed_list.Values.Add(qR.FieldByName('id').AsString);
     qR.Next;
   end;
  if(trR.InTransaction) then trR.Commit;
end;

procedure Tfetalon_dlg.ListClear(ed_list: TdxImageEdit);
begin
  ed_list.Descriptions.Clear;
  ed_list.Values.Clear;
end;

// Генерація id для gen_name генератора
function Tfetalon_dlg.GetNextID(gen_name: string): integer;
var new_id: Integer;
begin
  if(trR.InTransaction)then trR.Commit;
  trR.StartTransaction;
   qR.SQL.Text := 'select GEN_ID(' + gen_name + ',1) as oid from RDB$DATABASE';
   qR.ExecQuery;
   new_id := qR.FieldByName('oid').AsInteger;
  if(trR.InTransaction)then trR.Commit;

   Result := new_id;
end;

function IntToBool(ival: integer): boolean;
begin
  IntToBool := (ival <> 0);
end;

function BoolToInt(bval: boolean): integer;
begin
  if bval then
    BoolToInt   := 1
  else
    BoolToInt   := 0;
end;

end.
