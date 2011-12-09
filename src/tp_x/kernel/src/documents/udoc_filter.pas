unit udoc_filter;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, CheckLst, ExtCtrls, uZClasses, kernel_h, IBDatabase, DB,
  IBSQL, dxCntner, dxEditor, dxExEdtr, dxEdLib, uZFilterCombo;

type
  Tfdoc_filter = class(TForm)
    panel: TGroupBox;
    Panel1: TPanel;
    bt_ok: TButton;
    base: TIBDatabase;
    tr: TIBTransaction;
    q: TIBSQL;
    Splitter1: TSplitter;
    GroupBox1: TGroupBox;
    GroupBox2: TGroupBox;

    Splitter2: TSplitter;
    GroupBox3: TGroupBox;
    ed_typedoc: ZFilterCombo;
    ed_typepay: ZFilterCombo;
    ed_oplata_state: ZFilterCombo;
    procedure FormDestroy(Sender: TObject);
    procedure bt_okClick(Sender: TObject);
    procedure ed_typedocClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
    prm: ZVelesInfoRec;
    ed_popup: TdxPopupEdit;

    was_changed: boolean;

    zn_typedoc: boolean;
    zn_typepay: boolean;
    zn_oplata_state: boolean;

    procedure InitInfo;
    procedure FillFilterList(ed: ZFilterCombo; sql: string); // наповнення окремої секції
  end;

procedure DocumentsFilterCreate(var filter: Tfdoc_filter; prm: ZVelesInfoRec; ed_popup: TdxPopupEdit);
procedure DocumentsFilterFree(var filter: Tfdoc_filter);

implementation

{$R *.dfm}

procedure DocumentsFilterCreate(var filter: Tfdoc_filter; prm: ZVelesInfoRec; ed_popup: TdxPopupEdit);
begin
  filter := Tfdoc_filter.Create(nil);
  filter.ed_popup := ed_popup;
  filter.prm := prm;

  filter.InitInfo;
end;

procedure DocumentsFilterFree(var filter: Tfdoc_filter);
begin
  filter.Free;
end;

procedure Tfdoc_filter.InitInfo;  // заповнення фільтра
begin
  base.SetHandle(prm.db_handle);

  ed_typedoc.FillFromSQL('select typedoc_id as id, typedoc_name as name from T_DOCUMENT_TYPES  where typedoc_id not in (12, 16)', prm.db_handle);
  ed_typepay.FillFromSQL('select typepay_id as id, typepay_name as name from T_PAY_TYPES', prm.db_handle);
  ed_oplata_state.InitFilter;
  ed_oplata_state.AddLine('Без проплати', 0);
  ed_oplata_state.AddLine('Часткова', 1);
  ed_oplata_state.AddLine('Повна', 2);
  ed_oplata_state.AddLine('Переплата', 3);

  ed_typedoc.LoadFromIni(prm.root_way + 'tuning\ini\combofilter.ini', 'typedoc');
  ed_typepay.LoadFromIni(prm.root_way + 'tuning\ini\combofilter.ini', 'typepay');
  ed_oplata_state.LoadFromIni(prm.root_way + 'tuning\ini\combofilter.ini', 'oplata_state');
  was_changed := true;

  ed_popup.PopupControl := panel;
end;

procedure Tfdoc_filter.FillFilterList(ed: ZFilterCombo; sql: string); // наповнення окремої секції
begin
  ed.Clear;

  if tr.InTransaction then tr.Commit;
  tr.StartTransaction;
   q.SQL.Text := sql;
   q.ExecQuery;
   while not q.Eof do
   begin
     ed.AddLine(q.FieldByName('name').AsString, q.FieldByName('id').AsInteger);
     q.Next;
   end;
  if tr.InTransaction then tr.Commit;
end;

procedure Tfdoc_filter.FormDestroy(Sender: TObject);
begin
  ed_typedoc.SaveToIni(prm.root_way + 'tuning\ini\combofilter.ini', 'typedoc');
  ed_typepay.SaveToIni(prm.root_way + 'tuning\ini\combofilter.ini', 'typepay');
  ed_oplata_state.SaveToIni(prm.root_way + 'tuning\ini\combofilter.ini', 'oplata_state');
end;

procedure Tfdoc_filter.bt_okClick(Sender: TObject);
begin
  (panel.Parent as TdxPopupEditForm).ModalResult := mrOk;
end;

procedure Tfdoc_filter.ed_typedocClick(Sender: TObject);
begin
  was_changed := true;
end;

end.
