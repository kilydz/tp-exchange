unit uOLAP;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, cxDBPivotGrid, DB, IBSQL, IBDatabase, IBCustomDataSet, IBQuery, reports_h, udialogformreport,
  dxPSGlbl, dxPSUtl, dxPSEngn, dxPrnPg, dxBkgnd, dxWrap, dxPrnDev, ComCtrls,
  ToolWin, uZToolBar, dxPSCore, dxPgsDlg, dxPrnDlg;

type
  TfOLAP = class(TForm)
    base: TIBDatabase;
    q_dic: TIBQuery;
    tr_dic: TIBTransaction;
    tr: TIBTransaction;
    q: TIBSQL;
    ds_dic: TDataSource;
    ZToolBar1: ZToolBar;
    bt_print: TToolButton;
    pr_print_style_mgr: TdxPrintStyleManager;
    pr_component: TdxComponentPrinter;
    pr_dialog: TdxPrintDialog;
    pr_page_setup: TdxPageSetupDialog;
    pr_engine: TdxPSEngineController;
    bt_total_sum: TToolButton;
    procedure ToolButtonClick(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
  private
    { Private declarations }
    g_dic: TcxDBPivotGrid;
  public
    { Public declarations }
    { Public declarations }
    prm: ZReports;
    report_dialog_form: Treport_dialog_form;
    display_label: array [0..50] of shortstring;
    display_label_count: integer;
    footer_op: array [0..50] of string[3];
    display_description: array [0..50] of shortstring;

    procedure InitInfo;
    procedure DisplayLabel;
    procedure ParamQuerySet;
  end;

procedure DoOLAPReport(report_dialog_form: TForm; prm: ZReports);

implementation

{$R *.dfm}

procedure DoOLAPReport(report_dialog_form: TForm; prm: ZReports);
var dlg: TfOLAP;
begin
 try
  dlg := TfOLAP.Create(Application);
  dlg.prm := prm;
  dlg.report_dialog_form := Treport_dialog_form(report_dialog_form);
  dlg.InitInfo;

//  dlg.ShowModal;
 finally
  dlg.Free;
 end;
end;

procedure TfOLAP.FormDestroy(Sender: TObject);
begin
  g_dic.Free;
end;

procedure TfOLAP.InitInfo;
var
 OldCursor: TCursor;
 i:integer;
begin
  base.SetHandle(prm.prm.db_handle);
  OldCursor := Screen.Cursor;

  DisplayLabel;
 try
  Screen.Cursor := crSQLWait;

  q_dic.SQL.Text := report_dialog_form.query_string;
  if tr_dic.InTransaction then tr_dic.Commit;
   ParamQuerySet;
   tr_dic.StartTransaction;
   q_dic.Open;
   tr_dic.CommitRetaining;

   for i:=0 to display_label_count - 1 do
   begin
     q_dic.FieldList.Fields[i].DisplayLabel := display_label[i];
   end;
 {
   g_dic.CreateDefaultColumns(q_dic, g_dic);
   g_dic.KeyField := q_dic.FieldList.Fields[0].FieldName;
   g_dic.OptionsDB := g_dic.OptionsDB + [edgoLoadAllRecords];
   g_dic.ShowSummaryFooter := true;
   g_dic.OptionsDB := g_dic.OptionsDB + [edgoLoadAllRecords];
   g_dic.Columns[0].Sorted := csUp;

   for i:=0 to display_label_count - 1 do
   begin
     g_dic.Columns[i].SummaryFooterType := cstNone;
     if footer_op[i] = 'sum' then
     begin
       g_dic.Columns[i].SummaryFooterType := cstSum;
     end;
     if footer_op[i] = 'min' then
       g_dic.Columns[i].SummaryFooterType := cstMin;
     if footer_op[i] = 'max' then
       g_dic.Columns[i].SummaryFooterType := cstMax;
     if  footer_op[i] = 'cou' then
     begin
       g_dic.Columns[i].SummaryFooterType := cstCount;
     end;
     if footer_op[i] = 'avg' then
       g_dic.Columns[i].SummaryFooterType := cstAvg;
   end;

   g_dic.Columns[0].SummaryFooterType := cstCount;
   g_dic.RefreshGroupColumns;
                                                                   }
   if Screen.Cursor = crSQLWait then Screen.Cursor := OldCursor;

   g_dic := TcxDBPivotGrid.Create(self);
   g_dic.Parent := self;
   g_dic.Align :=alClient;
   g_dic.DataSource :=ds_dic;
   g_dic.CreateAllFields;

   g_dic.OptionsCustomize.Filtering := true;
   g_dic.OptionsCustomize.Sorting := true;
   g_dic.OptionsView.TotalsForSingleValues := true;
  // g_dic.

   ShowModal;
 finally
   if tr_dic.InTransaction then tr_dic.Commit;
              //if form_show_reports <> nil then form_show_reports.Free;
   if Screen.Cursor = crSQLWait then Screen.Cursor := OldCursor;
 end;
end;

//------------------------------------------------------------------------------
procedure TfOLAP.DisplayLabel;
var i: integer;
begin
   q.SQL.Text:='select rc.CAPTION, rc.DESCRIPTION, rc.FOOTER_OP '
                + ' from T_reportcaptions rc where rc.report_id = ' + inttostr(prm.report_id)
                + ' order by rc.CAPTIONPOSITION';
   if q.Transaction.InTransaction then q.Transaction.Commit;
   q.Transaction.StartTransaction;
   q.ExecQuery;
   i:=0;
   while not(q.eof) do
   begin
       display_label[i] := q.fieldbyname('CAPTION').AsString;
       display_description[i] := q.fieldbyname('DESCRIPTION').AsString;
       footer_op[i]:=q.fieldbyname('FOOTER_OP').AsString;
       q.Next;
       inc(i);
   end;
   q.Transaction.Commit;
   display_label_count := i;
end;

procedure TfOLAP.ParamQuerySet;
var i:integer;
begin
  for i:=0 to report_dialog_form.param_query_count - 1 do
  begin
    if report_dialog_form.param_query[i].sql_type = 'TREE' then
      q_dic.ParamByName(report_dialog_form.param_query[i].param_name).AsInteger :=
                 StrToInt(report_dialog_form.param_query[i].frame.Text)
    else
      q_dic.ParamByName(report_dialog_form.param_query[i].param_name).AsString :=
                 report_dialog_form.param_query[i].frame.Text;
  end;
end;


 procedure TfOLAP.ToolButtonClick(Sender: TObject);
begin
  if Sender = bt_total_sum then
  begin
    g_dic.OptionsView.TotalsForSingleValues := bt_total_sum.Down;
  end;

 // pr_component.Preview();
 // print_sistem.
 // g_dic
end;

{
procedure Treport_form.ToolButton4Click(Sender: TObject);
begin
  g_dic.ColumnsCustomizing;
end;

procedure Treport_form.ToolButton6Click(Sender: TObject);
begin
 if edgoAutoWidth in g_dic.OptionsView then
   g_dic.OptionsView := g_dic.OptionsView - [edgoAutoWidth]
   else g_dic.OptionsView := g_dic.OptionsView + [edgoAutoWidth]
end;

procedure Treport_form.ToolButton3Click(Sender: TObject);
begin
 dlgSave.DefaultExt := '*.htm';
 dlgSave.Filter := 'HTML файли |*.htm';
 dlgSave.Title := 'Експорт даних в HTML файл';
 if dlgSave.Execute then
 g_dic.SaveToHTML(dlgSave.FileName, True);
end;

procedure Treport_form.ToolButton2Click(Sender: TObject);
begin
 dlgSave.DefaultExt := '*.xls';
 dlgSave.Filter := 'Файли MS Excel |*.xls';
 dlgSave.Title := 'Експорт даних в Excel';
 if dlgSave.Execute then
   g_dic.SaveToXLS(dlgSave.FileName, True);
end;

procedure Treport_form.ToolButton1Click(Sender: TObject);
begin
 dlgSave.DefaultExt := '*.txt';
 dlgSave.Filter := 'Текстові файли |*.txt';
 dlgSave.Title := 'Експорт даних в текстовий файл';
 if dlgSave.Execute then
   g_dic.SaveAllToTextFile(dlgSave.FileName);
end;

procedure Treport_form.ToolButton5Click(Sender: TObject);
begin
  dxComponentPrinter1.Preview();
end;

procedure Treport_form.FormShow(Sender: TObject);
begin
  g_dic.IniFileName := report_dialog_form.header.prm.root_way + 'tuning\ini\dxReports.ini';
  g_dic.IniSectionName := 'ini_report_id' + inttostr(report_dialog_form.header.report_id);
  g_dic.LoadFromIniFile(report_dialog_form.header.prm.root_way + 'tuning\ini\dxReports.ini');
end;

procedure Treport_form.FormHide(Sender: TObject);
begin
  g_dic.IniFileName := report_dialog_form.header.prm.root_way + 'tuning\ini\dxReports.ini';
  g_dic.IniSectionName := 'ini_report_id' + inttostr(report_dialog_form.header.report_id);
  g_dic.SaveToIniFile(report_dialog_form.header.prm.root_way + 'tuning\ini\dxReports.ini');
end;
}
end.
