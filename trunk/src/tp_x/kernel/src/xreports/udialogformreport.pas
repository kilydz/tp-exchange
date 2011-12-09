unit udialogformreport;

interface

uses reports_h, kernel_h,
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, DB, IBDatabase, Buttons, ExtCtrls,
  IBCustomDataSet, IBQuery, dxExEdtr, dxCntner, dxInspct, dxInspRw,
  dxEditor, dxEdLib, ZReportFrame, dxTL, dxTLClms, dxDBGrid, dxDBCtrl,
  dxDBTLCl, dxGrClms, IBSQL, uZbutton;

type
  ZParamQuery = record
    param_type:integer; //id of type in Table T_TYPEREPORTS
    param_name:string;
    sql_type:string; //type of sql or our definition type
    caption:string;
    query_param:string;
    frame: Zframe;
    top:integer; // висота даного фрейма на формі
  end;
  Treport_dialog_form = class(TForm)
    base: TIBDatabase;
    tr: TIBTransaction;
    Panel1: TPanel;
    pTop: TPanel;
    DialogPanel: TPanel;
    q: TIBSQL;
    ch_OLAP: TdxCheckEdit;
    bt_cancel: ZButton;
    bt_ok: ZButton;
    procedure btnCancelClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormDestroy(Sender: TObject);


  public
    { Public declarations }
    header: Zreports;
    query_string:Ansistring;
    caption_string:string[255]; //??????? парситься для вигрібання заголовків колонок розділовий - @
    param_query: array [0..50] of ZParamQuery;
    param_query_count:integer;

    //str_tree_selection:string;
  private
    top:integer;
    procedure VisibleFrame;
  end;

//  form_show_reports: Treport_form;

procedure ReportShow(prm: ZReports);

implementation
uses CheckedList, ureportform, uOLAP;//, ureportform;//, udialogformreport;//, udialogformreport;

{$R *.dfm}

//------------------------------------------------------------------------------
procedure ReportShow(prm: ZReports);
var report_dialog_form: Treport_dialog_form;
begin
 report_dialog_form := Treport_dialog_form.Create(Application);
 report_dialog_form.base.SetHandle(Prm.prm.db_handle);

   with report_dialog_form do
   begin
       header:=prm;
       if tr.InTransaction then tr.Commit;
       tr.StartTransaction;
        q.SQL.Text:=' select NAME, QUERY from T_REPORTS  where report_id = ' + inttostr(prm.report_id);
        q.ExecQuery;
       if tr.InTransaction then tr.CommitRetaining;

       pTop.Caption := q.Fieldbyname('NAME').AsString;
       query_string:=q.Fieldbyname('QUERY').AsString;
       caption_string := pTop.Caption;
       q.Transaction.Commit;

       VisibleFrame;
       showmodal;
       //tree.GetCheckedId;
       //FormClose(report_dialog_form, tion);
   end;
  report_dialog_form.Free;
end;

//------------------------------------------------------------------------------
procedure Treport_dialog_form.VisibleFrame;
var i:integer;
begin
   q.SQL.Text:='select NAME, TYPENAME, LABEL, DESCRIPTION, SUMMATION, QUERY '
                + 'from T_reportfields rf where rf.report_id = ' + inttostr(header.report_id)
                + 'order by rf.fieldposition';
   if q.Transaction.InTransaction then q.Transaction.Commit;
   q.Transaction.StartTransaction;
   q.ExecQuery;
   i:=0;

   while not(q.eof) do
   begin
       param_query[i].param_name  := q.fieldbyname('NAME').AsString;
       param_query[i].query_param := q.fieldbyname('QUERY').AsString;
       param_query[i].caption     := q.fieldbyname('LABEL').AsString;
       param_query[i].sql_type    := q.fieldbyname('TYPENAME').AsString;
       q.Next;
       inc(i);
   end;
   param_query_count := i;
   q.Transaction.Commit;
   self.top := 0;

   for i :=0 to param_query_count - 1 do
   begin
        if param_query[i].sql_type = 'DATE' then
           param_query[i].frame := ZFrameDate.Create(self);

        if param_query[i].sql_type = 'LIST' then
            begin
              param_query[i].frame := ZFrameList.Create(self);
              q.SQL.Text:=param_query[i].query_param;
              if q.Transaction.InTransaction then q.Transaction.Commit;
              q.Transaction.StartTransaction;
              q.ExecQuery;
              while (not (q.Eof)) do
              begin
                  param_query[i].frame.AddString(q.Fields[0].AsString);
                  q.Next;
              end;
              q.Transaction.Commit;
            end;

        if param_query[i].sql_type = 'IDLIST' then
            begin
              param_query[i].frame := ZFrameIdList.Create(self);
              q.SQL.Text:=param_query[i].query_param;
              if q.Transaction.InTransaction then q.Transaction.Commit;
              q.Transaction.StartTransaction;
              q.ExecQuery;
              while (not (q.Eof)) do
              begin
                  ZFrameIdList(param_query[i].frame).AddString(q.FieldByName('id').AsInteger,
                                        q.FieldByName('name').AsString);
                  q.Next;
              end;
              q.Transaction.Commit;
            end;

         if param_query[i].sql_type = 'CHECKLIST' then
            begin
                    param_query[i].frame := ZFrameCheckList.create(self, param_query[i].query_param, header.prm);
                    param_query[i].frame.Parent := DialogPanel;
                    param_query[i].frame.Visible := true;
            end;


         if param_query[i].sql_type = 'TREE' then
         begin
             param_query[i].frame := ZFrameTree.Create(self, param_query[i].query_param, header.prm);
         end;

         if param_query[i].sql_type = 'INT' then
         begin
             param_query[i].frame := ZFrameInt.Create(self);
         end;

         if param_query[i].frame <> nil then
         begin

           param_query[i].frame.Parent := DialogPanel;
           param_query[i].frame.Top := top;
           param_query[i].top := top;
           top := top + param_query[i].frame.height;
           param_query[i].frame.caption := param_query[i].caption;
           param_query[i].frame.Init('');
           param_query[i].frame.Show(dialogpanel.Width);

         end;
   end;

   self.Height := top +  Panel1.Height + ptop.Height  + 30  ;
end;


//----------------------------------------------------------
procedure Treport_dialog_form.btnCancelClick(Sender: TObject);
begin
  close();
end;

procedure Treport_dialog_form.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  if ModalResult = mrOk then
  begin
    if ch_olap.Checked then
      DoOLAPReport(self, header)
    else
      DoReport(self, header);


    Action := caNone;
  end;

  if ModalResult = mrCancel then   Action := caHide;
end;


procedure Treport_dialog_form.FormDestroy(Sender: TObject);
var i: integer;
begin
  for i:=0 to param_query_count - 1 do
  begin

try
   // if (param_query[i].frame <> nil) and (param_query[i].sql_type = 'TREE') then
   //   param_query[i].frame.Free;
except

end;

  end;
end;

end.
