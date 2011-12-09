library Tree;

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
  uTreeGrpForm in 'uTreeGrpForm.pas' {fTree},
  uTreeGrpFormC in 'uTreeGrpFormC.pas' {fTreeC},
  ubranchC in 'ubranchC.pas' {fbranchC},
  uTreeGrpFormLC in 'uTreeGrpFormLC.pas' {fTreeLC},
  etalon_dlg in '..\..\lib\etalons\etalon_dlg.pas' {fetalon_dlg},
  ubranch in 'ubranch.pas' {fbranch};

{$R *.res}

exports TreeCreate;
exports TreeRefresh;
exports TreeSelections;
exports TreeSelectionsSpace;
exports TreeToGroup;
exports TreeHideShow;
exports TreeRelase;

exports BranchDialog;

exports TreeCreateC;
exports TreeRefreshC;
exports TreeSelectionsC;
exports TreeToGroupC;
exports TreeHideShowC;
exports TreeRelaseC;

exports BranchCDialog;

exports TreeCreateLC;
exports TreeRefreshLC;
exports TreeSelectionsLC;
exports TreeToGroupLC;
exports TreeHideShowLC;
exports TreeRelaseLC;
end.
