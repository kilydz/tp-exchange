unit reports_h;

interface
uses kernel_h;

type
  ZReports  = record
    prm: ZVelesInfoRec;
    report_id: integer; // id звіту в таблиці T_REPORTS 
   end;

function ReportShow(prm: ZReports): integer;
         external 'reports.dll' name 'ReportShow';

implementation

end.
