
unit delete;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, Buttons, IBSQL, IBDatabase, DB, kernel_h,
  IBCustomDataSet, IBQuery, Zutils_h, IB, secure_h, uZbutton;

type
  Tfdelete = class(TForm)
    ed_status: TMemo;
    base: TIBDatabase;
    tr_W: TIBTransaction;
    q_W: TIBSQL;
    bt_close: ZButton;
  private
    { Private declarations }
  public
    { Public declarations }
    prm: ZVelesInfoRec;
    query: string;
    for_upd: TIBQuery;
    document_id: integer;

    procedure InitInfo;
    function DeleteRecord: integer;
  end;

function GDeleteRecord(query: PChar; document_id: integer; for_upd: TIBQuery; var prm: ZVelesInfoRec): integer;

implementation

{$R *.dfm}

function GDeleteRecord(query: PChar; document_id: integer; for_upd: TIBQuery; var prm: ZVelesInfoRec): integer;
var dlg: Tfdelete;
    res: integer;
begin
  res := -1;
  if GMessageBox('Ви впевнені, що потрібно видалити запис?', 'Так|Відмова') = 1 then
  begin
   try
    dlg := Tfdelete.Create(Application);
    dlg.prm := prm;
    dlg.document_id := document_id;
    dlg.query := query;
    dlg.for_upd := for_upd;
    dlg.InitInfo;
    res := dlg.DeleteRecord;
   finally
    dlg.Free;
   end
  end;
  GDeleteRecord := res;
end;

procedure Tfdelete.InitInfo;
begin
  base.SetHandle(prm.db_handle);
end;

function Tfdelete.DeleteRecord: integer;
var depend_count: integer;
begin
  ed_status.Clear;
  ed_status.Lines.Add('Не можливо видалити запис,');
  ed_status.Lines.Add('оскільки існують такі залежності:');

  depend_count := 0;

 try

  if tr_W.InTransaction then tr_W.Commit;
  tr_W.StartTransaction;
   q_W.SQL.Text := query;
   q_W.ParamByName('idocument_id').AsInteger := document_id;
   q_W.ExecQuery;

   while not q_W.Eof do
   begin
     ed_status.Lines.Add('  - ' + q_W.FieldByName('ocaption').AsString +
                         '    ' + q_W.FieldByName('ocount').AsString);
     depend_count := depend_count + q_W.FieldByName('ocount').AsInteger;
     q_W.Next;
   end;
  if tr_W.InTransaction then tr_W.Commit;

 except
  on E: EIBInterbaseError do
  begin
      GMessageBox('Помилка при видаленні запису: ' + E.Message, 'Закрити');
      if tr_W.InTransaction then tr_W.Rollback;
      depend_count := -1;
  end;
 end;

  if depend_count > 0 then
    ShowModal
  else
    if (for_upd <> nil) and (depend_count <> -1) then
      for_upd.Delete;
 
  DeleteRecord := depend_count;
end;

end.
