library scales;

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
  SysUtils,
  Classes,
  uscales in 'uscales.pas' {fscales},
  uscale in 'uscale.pas' {fscale},
  etalon_dlg in '..\..\lib\etalons\etalon_dlg.pas' {fetalon_dlg},
  uscale_params in 'uscale_params.pas' {Form2},
  usync_log in 'usync_log.pas' {fsync_log};

{$R *.res}
exports ScalesListDialog;
begin
end.
