unit uinvoice_dlg;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, dxEditor, dxExEdtr, dxEdLib, dxCntner, StdCtrls, ExtCtrls, Zutils_h,
  ComCtrls, IBSQL, IBDatabase, DB, uZMaster, kernel_h, invoice_h, secure_h, genstor_h;

type
  Tfinvoice_dlg = class(TForm)
    master: ZMaster;
    base: TIBDatabase;
    trR: TIBTransaction;
    qR: TIBSQL;
    qW: TIBSQL;
    trW: TIBTransaction;
    pPages: TPageControl;
    TabSheet1: TTabSheet;
    pStage0: TPanel;
    scStyle: TdxEditStyleController;
    p_main: TPanel;
    Label2: TLabel;
    ed_type_invoice: TdxImageEdit;
    Label1: TLabel;
    ed_version: TdxImageEdit;
    p_period: TPanel;
    Label3: TLabel;
    ed_date0: TdxDateEdit;
    Label4: TLabel;
    ed_date1: TdxDateEdit;
    procedure ed_type_invoiceChange(Sender: TObject);
    procedure masterMasterResult(Sender: TObject;
      MasterResult: ZMasterResult);
    procedure FormShow(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
    list_id,  //Рядок із списком ID - іх записів таблиці t_invoices
    id_select //Рядок ініціалізації випадаючого списку (select повинен вертати стовпці id та name)
              : string;
    document_id: integer;
    l_invoice: TList;

    type_invoice: integer;
    prm: ZVelesInfoRec;

    procedure InitInfo;
  end;

{const invoice_types: array [0..9] of string =
     ('tax*.frf', 'given*.frf', 'moving*.frf', 'return*.frf',
      'chargeoff*.frf', 'faktura*.frf', 'receipt*.frf', 'receiptin*.frf',
      'certificate*.frf', 'akt*.frf');
}
procedure InvoiceDialog(document_id: integer; list_id: string; var prm: ZVelesInfoRec);
procedure InvoiceDialogDate(document_id: integer; list_id: string; var prm: ZVelesInfoRec);

implementation

{$R *.dfm}

procedure InvoiceDialog(document_id: integer; list_id: string; var prm: ZVelesInfoRec);
var
  dlg: Tfinvoice_dlg;
begin
  if not HasUserAccessEx(prm, ACCESS_TO_PRINT) then
  begin
      GMessageBox('Ви не маєте прав на друк!', 'OK');
      Exit;
  end;
  if not HasUserAccessEx(prm, ACCESS_TO_PRINT_INVOICE) then
  begin
      GMessageBox('Ви не маєте прав на друк накладних!', 'OK');
      Exit;
  end;

try
// Створення та ініціалізація форми діалогу.
    dlg := Tfinvoice_dlg.Create(Application);
    dlg.list_id := list_id;
    dlg.document_id := document_id;
    dlg.prm := prm;
    dlg.p_period.Visible := false;

    dlg.InitInfo;

// Візуалізація діалогу
    if (dlg.ShowModal = mrOk) then
    begin

    end;
finally
  dlg.Free;
end;
end;

procedure InvoiceDialogDate(document_id: integer; list_id: string; var prm: ZVelesInfoRec);
var
  dlg: Tfinvoice_dlg;
begin
  if not HasUserAccessEx(prm, ACCESS_TO_PRINT) then
  begin
      GMessageBox('Ви не маєте прав на друк!', 'OK');
      Exit;
  end;
  if not HasUserAccessEx(prm, ACCESS_TO_PRINT_INVOICE) then
  begin
      GMessageBox('Ви не маєте прав на друк накладних!', 'OK');
      Exit;
  end;

try
// Створення та ініціалізація форми діалогу.
    dlg := Tfinvoice_dlg.Create(Application);
    dlg.list_id := list_id;
    dlg.document_id := document_id;
    dlg.prm := prm;
    dlg.p_period.Visible := true;

    dlg.InitInfo;

// Візуалізація діалогу
    if (dlg.ShowModal = mrOk) then
    begin

    end;
finally
  dlg.Free;
end;
end;

procedure Tfinvoice_dlg.InitInfo;
var inv: lpZInvoice;
begin
  base.SetHandle(prm.db_handle);

  // Ініціалізація майстра
  master.PageAdd('Основні',   pStage0);

  l_invoice := TList.Create;
  ed_type_invoice.Values.Clear;
  ed_type_invoice.Descriptions.Clear;

  if trR.InTransaction then trR.Commit;
  trR.StartTransaction;
   qR.SQL.Text := 'select * from P_INVOICES_LIST(:ilist_id)';
   qR.ParamByName('ilist_id').AsString := list_id;
   qR.ExecQuery;
   while not qR.Eof do
   begin
     New(inv);
     l_invoice.Add(inv);
     inv^.invoice_id       := qR.FieldByName('oinvoice_id').AsInteger;
     inv^.q_header         := qR.FieldByName('oq_header').AsString;
     inv^.q_records        := qR.FieldByName('oq_records').AsString;
     inv^.q_upd_after      := qR.FieldByName('oq_upd_after').AsString;
     inv^.frf_filter       := qR.FieldByName('ofrf_filter').AsString;
     inv^.frf_descriptor   := qR.FieldByName('ofrf_descriptor').AsString;

     ed_type_invoice.Values.Add(IntToStr(inv^.invoice_id));
     ed_type_invoice.Descriptions.Add(inv^.frf_descriptor);

     qR.Next;
   end;
  if trR.InTransaction then trR.Commit;

  if l_invoice.Count = 0 then
  begin
    masterMasterResult(master, MasterResultCancel);
    Exit;
  end;

  // Ініціалізація контроллерів
  inv := l_invoice.Items[0];
  ed_type_invoice.Text    := IntToStr(inv.invoice_id);

  ed_date0.Text := DateToStr(Date);
  ed_date1.Text := DateToStr(Date);

  Autosize := true;
  Position := poDesktopCenter;
end;

procedure Tfinvoice_dlg.ed_type_invoiceChange(Sender: TObject);
var sr: TSearchRec;
    max_name, max_id: string;
    inv: lpZInvoice;
begin
  type_invoice := StrToInt(ed_type_invoice.Text);
  ed_version.Values.Clear;
  ed_version.Descriptions.Clear;

  inv := l_invoice.Items[ed_type_invoice.Values.IndexOf(IntToStr(type_invoice))];
  if FindFirst(prm.root_way + 'tuning\print\invoice\' + inv.frf_filter,
                        faAnyFile, sr) = 0 then
  begin
    max_name := sr.Name;  max_id := '0';
    repeat
      ed_version.Values.Add(IntToStr(ed_version.Values.Count));
      ed_version.Descriptions.Add(sr.Name);
      if max_name <= sr.Name then
      begin
        max_id := IntToStr(ed_version.Values.Count - 1);
        max_name := sr.Name;
      end;
    until FindNext(sr) <> 0;
    FindClose(sr);
  end;
  ed_version.Text := max_name;
  ed_version.Text := max_id;

  ed_version.Visible := (ed_version.Values.Count > 1);
  Label1.Visible := ed_version.Visible;
end;

procedure Tfinvoice_dlg.FormShow(Sender: TObject);
begin
  master.PageIndex := 0;
end;

procedure Tfinvoice_dlg.masterMasterResult(Sender: TObject;
  MasterResult: ZMasterResult);
var dscr: ZInvoiceDescr;
begin
  if MasterResult = MasterResultOk then
  begin
    dscr.document_id := document_id;
    dscr.prm := prm;
    dscr.inv := l_invoice.Items[ed_type_invoice.Values.IndexOf(IntToStr(type_invoice))];
    dscr.frf_name := ed_version.Descriptions[ed_version.Values.IndexOf(ed_version.Text)];
    dscr.use_date := p_period.Visible;
    dscr.date0 := ed_date0.Text;
    dscr.date1 := ed_date1.Text;
    InvoicePrint(dscr);
    ModalResult := mrOk;
  end
  else if MasterResult = MasterResultCancel then
    ModalResult := mrCancel;
end;

procedure Tfinvoice_dlg.FormDestroy(Sender: TObject);
var i: integer;
    inv: lpZInvoice;
begin
  for i := 0 to l_invoice.Count - 1 do
  begin
    inv := l_invoice.Items[i];
    dispose(inv);
  end;
  l_invoice.Free;
end;

end.
