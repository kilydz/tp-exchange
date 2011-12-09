library document;

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
  udocument in 'udocument.pas' {fdocument},
  eddocument in 'eddocument.pas' {feddocument},
  nomenlist in '..\editors\nomenlist.pas' {fnomenlist},
  etalon_dr in 'etalon_dr.pas' {fetalon_dr},
  docrec_dr1 in 'docrec_dr1.pas' {fdocrec_dr1},
  etalon_ed in '..\..\lib\etalons\etalon_ed.pas' {fetalon_ed};

{$R *.res}

exports DocumentDialog;
exports DocumentEditor;

exports DocrecDialogDR1;
{exports DocrecDialogDR2;
exports DocrecDialogDR2_v2;
exports DocrecDialogDR6;
exports DocrecDialogDR10;
exports DocrecDialogDR15;
exports DocrecDialogDR17;
exports DocrecDialogDR4;
exports DocrecDialogDR7;}
begin
end.
