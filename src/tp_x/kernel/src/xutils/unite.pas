unit unite;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, Buttons, ExtCtrls, dxCntner, dxEditor, dxExEdtr,
  dxEdLib, IBSQL, IBDatabase, DB, kernel_h, Zutils_h, uZbutton;

type
  Tfunite = class(TForm)
    Panel1: TPanel;
    scStyle: TdxEditStyleController;
    base: TIBDatabase;
    tr_W: TIBTransaction;
    q_W: TIBSQL;
    tr_R: TIBTransaction;
    q_R: TIBSQL;
    ZButton1: ZButton;
    ZButton2: ZButton;
    ed_info_0: TdxMemo;
    Panel2: TPanel;
    ed_info_1: TdxMemo;
    bt_change: ZButton;
    procedure bt_changeClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
  private
    { Private declarations }
  public
    { Public declarations }
    prm: ZVelesInfoRec;
    unite_prm: lpZUniteRecords;
    id_0, id_1: integer;
    current_pos: integer;

    procedure InitInfo;
    procedure FillInfo(id: integer; var ed_memo: TdxMemo);
  end;

function GUniteRecords(unite_prm: lpZUniteRecords; var a_veles_info: ZVelesInfoRec): integer;

implementation

{$R *.dfm}

function GUniteRecords(unite_prm: lpZUniteRecords; var a_veles_info: ZVelesInfoRec): integer;
var dlg: Tfunite;
begin
  dlg := Tfunite.Create(Application);
  dlg.prm := a_veles_info;
  dlg.unite_prm := unite_prm;
  dlg.InitInfo;

  dlg.ShowModal;

  dlg.Free;

  GUniteRecords := 0;
end;

procedure Tfunite.InitInfo;
begin
  base.SetHandle(prm.db_handle);
  id_0 := unite_prm.id_list.FindId(0);
  id_1 := unite_prm.id_list.FindId(1);
  current_pos := 2;

  FillInfo(id_0, ed_info_0);
  FillInfo(id_1, ed_info_1);

end;

procedure Tfunite.FillInfo(id: integer; var ed_memo: TdxMemo);
begin
  ed_memo.Clear;

  if tr_R.InTransaction then tr_R.Commit;
  tr_R.StartTransaction;
   q_R.SQL.Text := unite_prm.sql_info;
   q_R.ParamByName('idocument_id').AsInteger := id;
   q_R.ExecQuery;
   while not q_R.Eof do
   begin
     ed_memo.Lines.Add(q_R.FieldByName('odescript').AsString);
     q_R.Next;
   end;
  if tr_R.InTransaction then tr_R.Commit;
end;

procedure Tfunite.bt_changeClick(Sender: TObject);
var tmp_memo: AnsiString;
    tmp_id: integer;
begin
  tmp_memo := ed_info_0.Text;
  tmp_id := id_0;

  ed_info_0.Text := ed_info_1.Text;
  id_0 := id_1;

  ed_info_1.Text := tmp_memo;
  id_1 := tmp_id;
end;

procedure Tfunite.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  if ModalResult = mrOk then
  begin
    if tr_W.InTransaction then tr_W.Commit;
    tr_W.StartTransaction;
     q_W.SQL.Text := unite_prm.sql_unite;
     q_W.ParamByName('idocument_id0').AsInteger := id_0;
     q_W.ParamByName('idocument_id1').AsInteger := id_1;
     q_W.ExecQuery;
     if q_W.FieldByName('oenabled').AsInteger = 0 then
     begin
       ShowMessage(q_W.FieldByName('omessage').AsString);
       Action := caNone;
     end;

    if tr_W.InTransaction then tr_W.Commit;
  end;

  if Action <> caNone then
  begin
    if current_pos < unite_prm.id_list.Count then
    begin
      id_1 := unite_prm.id_list.FindId(current_pos);
      FillInfo(id_1, ed_info_1);
      current_pos := current_pos + 1;
      Action := caNone;
    end
  end
end;

end.
