library Zreports;

{ Important note about DLL memory management: ShareMem must be the
  first unit in your library's USES clause AND your project's (select
  Project-View Source) USES clause if your DLL exports any procedures or
  functions that pass strings as parameters or function results. This
  applies to all strings passed to and from your DLL--even those that
  are nested in records and classes. ShareMem is the interface unit to
  the BORLNDMM.DLL shared memory manager, which must be deployed along
  with your DLL. To avoid using BORLNDMM.DLL, pass string information
  using PChar or ShortString parameters. }

uses
  FastShareMem,
  SysUtils,
  Classes,
  udialogformreport in 'udialogformreport.pas' {report_dialog_form},
  ZReportFrame in 'ZReportFrame.pas',
  ureportform in 'ureportform.pas' {report_form},
  ureportlist in 'ureportlist.pas' {freportlist},
  uOLAP in 'uOLAP.pas' {fOLAP},
  etalon_dic in '..\..\lib\etalons\etalon_dic.pas' {fetalon_dic};

{$R *.res}
exports ReportShow;
exports ShowPage;
exports FreePage;
begin
end.
