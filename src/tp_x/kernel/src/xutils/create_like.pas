unit create_like;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, IBSQL, IBDatabase, DB, dxCntner, dxEditor, dxExEdtr, dxEdLib,
  StdCtrls, Buttons, ExtCtrls, Zutils_h, kernel_h, uZbutton;

type
  Tfcreate_like = class(TForm)
    ed_info_0: TdxMemo;
    scStyle: TdxEditStyleController;
    base: TIBDatabase;
    tr_R: TIBTransaction;
    q_R: TIBSQL;
    q_W: TIBSQL;
    tr_W: TIBTransaction;
    Panel1: TPanel;
    ed_types_convert: TdxImageEdit;
    bt_ok: ZButton;
    bt_cancel: ZButton;
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
  private
    { Private declarations }
  public
    { Public declarations }
    create_like_prm: lpZCreateLike;
    id: integer;
    prm: ZVelesInfoRec;

    procedure InitInfo;
  end;

function GCreateLike(id: integer; create_like_prm: lpZCreateLike; var a_prm: ZVelesInfoRec): integer;

implementation

{$R *.dfm}

function GCreateLike(id: integer; create_like_prm: lpZCreateLike; var a_prm: ZVelesInfoRec): integer;
var dlg: Tfcreate_like;
    res: integer;
begin
  res := -1;
  dlg := Tfcreate_like.Create(Application);
  dlg.prm := a_prm;
  dlg.id := id;
  dlg.create_like_prm := create_like_prm;
  dlg.InitInfo;

  if dlg.ShowModal = mrOK then
  begin
    res := dlg.create_like_prm.id;
  end;

  dlg.Free;
  Result := res;
end;

procedure Tfcreate_like.InitInfo;
begin
  base.SetHandle(prm.db_handle);

  ed_info_0.Clear;

  if tr_R.InTransaction then tr_R.Commit;
  tr_R.StartTransaction;
   q_R.SQL.Text := create_like_prm.sql_info;
   q_R.ParamByName('idocument_id').AsInteger := id;
   q_R.ExecQuery;
   while not q_R.Eof do
   begin
     ed_info_0.Lines.Add(q_R.FieldByName('odescript').AsString);
     q_R.Next;
   end;

   q_R.Close;
   q_R.SQL.Text := create_like_prm.sql_types_convert;
   q_R.ExecQuery;
   ed_types_convert.Descriptions.Clear;
   ed_types_convert.Values.Clear;
   while not q_R.Eof do
   begin
     ed_types_convert.Descriptions.Add(q_R.FieldByName('oname').AsString);
     ed_types_convert.Values.Add(q_R.FieldByName('oid').AsString);
     ed_types_convert.Text := q_R.FieldByName('oid').AsString;
     q_R.Next;
   end;
  if tr_R.InTransaction then tr_R.Commit;
end;

procedure Tfcreate_like.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  if ModalResult = mrOk then
  begin
    if tr_W.InTransaction then tr_W.Commit;
    tr_W.StartTransaction;
     q_W.SQL.Text := create_like_prm.sql_create;
     q_W.ParamByName('idocument_id').AsInteger := id;
     q_W.ParamByName('itype_convert').AsInteger := StrToInt(ed_types_convert.Text);
     q_W.ExecQuery;
     create_like_prm.id := q_W.FieldByName('odocument_id').AsInteger;
     if q_W.FieldByName('oenabled').AsInteger = 0 then
     begin
       ShowMessage(q_W.FieldByName('omessage').AsString);
       Action := caNone;
     end;
    if tr_W.InTransaction then tr_W.Commit;
  end;
end;

end.
