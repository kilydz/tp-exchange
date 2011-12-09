library libra_sync;

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
  ulibra_sync in 'ulibra_sync.pas' {fnomen},
  DIGI_SP in 'DIGI_SP.pas',
  scale in 'scale.pas' {fscale},
  shtrih_print in 'shtrih_print.pas',
  etalon_dlg in '..\..\lib\etalons\etalon_dlg.pas' {fetalon_dlg};

{$R *.res}

exports LibraSyncDialog;
exports ScaleDialog;

begin
end.
