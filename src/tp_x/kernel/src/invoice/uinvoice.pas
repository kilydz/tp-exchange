unit uinvoice;

interface

uses  genstor_h, invoice_h,
  Forms,
  SysUtils, Classes, FR_Class, DB, IBCustomDataSet, IBQuery, IBDatabase,
  FR_DCtrl, FR_Desgn, IBSQL, FR_DSet, FR_DBSet, FR_Shape, FR_Rich;

type
  TDM = class(TDataModule)
    Designer: TfrDesigner;
    frDialogControls: TfrDialogControls;
    tr: TIBTransaction;
    Base: TIBDatabase;
    q: TIBQuery;
    qTitle: TIBQuery;
    q_upd: TIBQuery;
    tr_upd: TIBTransaction;
    Report: TfrReport;
    qe_upd: TIBSQL;
    frDS: TfrDBDataSet;
    frShapeObject1: TfrShapeObject;
    frRichObject1: TfrRichObject;
    procedure ReportPrintReport;
    procedure ReportGetValue(const ParName: String; var ParValue: Variant);
    procedure ReportUserFunction(const Name: String; p1, p2, p3: Variant;
      var Val: Variant);
  private
    { Private declarations }
    document_id: integer;
    doc_type   : integer;
    frf_name   : string;

    dscr: ZInvoiceDescr;
  public
    { Public declarations }
  end;

procedure InvoicePrint(dscr: ZInvoiceDescr);

var
  DM: TDM;

implementation

{$R *.dfm}

procedure InvoicePrint(dscr: ZInvoiceDescr);
// функція експортується
begin
 DM := TDM.Create(Application);
 DM.dscr := dscr;
 DM.Base.SetHandle(dscr.prm.db_handle);
 DM.document_id := dscr.document_id;
// DM.doc_type  := dscr.doc_type;
 DM.frf_name := dscr.frf_name;

 DM.qTitle.SQL.Text   := dscr.inv.q_header;
 DM.q.SQL.Text        := dscr.inv.q_records;
 DM.qe_upd.SQL.Text   := dscr.inv.q_upd_after;

 DM.q.ParamByName('DOCUMENT_ID').AsInteger := dscr.document_id;
 if (dscr.use_date) then
 begin
   DM.q.ParamByName('DATE0').AsString := dscr.date0;
   DM.q.ParamByName('DATE1').AsString := dscr.date1;
 end;

 if dscr.inv.q_header <>'' then
   begin
     DM.qTitle.ParamByName('document_id').AsInteger := dscr.document_id;
     if (dscr.use_date) then
     begin
       DM.qTitle.ParamByName('DATE0').AsString := dscr.date0;
       DM.qTitle.ParamByName('DATE1').AsString := dscr.date1;
     end;
   end;

try
  //Form_P.IBQuery1.ParamByName('DOCUMENT_ID').AsInteger:= prm.DOCUMENT_ID;
  if DM.tr.InTransaction then DM.tr.Commit;
  DM.tr.StartTransaction;
   DM.q.Open;

   if dscr.inv.q_header <>'' then  DM.qTitle.Open;

  DM.tr.CommitRetaining;
  DM.Report.LoadFromFile(dscr.prm.root_way + 'tuning\print\invoice\' + dM.frf_name);
  DM.Report.ShowReport;

finally
  DM.tr.Commit;
  DM.Free;
end;

end;

procedure TDM.ReportPrintReport;
begin
  if dscr.inv.q_upd_after <> '' then
  begin
    try
       if tr_upd.InTransaction then tr_upd.Commit;
       tr_upd.StartTransaction;
        qe_upd.ParamByName('document_id').AsInteger := document_id;
        qe_upd.ExecQuery;
    finally
        qe_upd.Close;
       if tr_upd.InTransaction then tr_upd.Commit;
    end;
  end;
end;

procedure TDM.ReportGetValue(const ParName: String;
  var ParValue: Variant);
var
    dst: Array[0..1000] of Char;
    d1: String;
//    temp: extended;
    IntPart: integer;
begin
 if ParName='OUT_SUMPDV' then
  begin
    dst[0]:=#0;
    IntPart := trunc(qTitle.FieldByName('OUT_SUMPDV').AsFloat);
    d1:= gdConvertToText(dst, IntPart ,0 );
    ParValue:= d1;
  end;
end;


procedure TDM.ReportUserFunction(const Name: String; p1, p2,
  p3: Variant; var Val: Variant);
var
    dst: Array[0..1000] of Char;
    d1: String;
    temp: extended;
    IntPart: integer;
begin
  if AnsiCompareText('PROPUS', Name) = 0 then
  begin
    dst[0]:=#0;
    temp:=frParser.Calc(p1);
    IntPart := trunc(temp);
    d1:= gdConvertToText(dst, IntPart ,0);
    Val:= d1;
  end;
end;

end.
