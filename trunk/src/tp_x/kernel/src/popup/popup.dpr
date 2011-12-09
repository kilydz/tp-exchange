library popup;

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
  discount in 'discount.pas' {fdiscount},
  umaker in 'umaker.pas' {fmaker},
  etalon_dlg in '..\..\lib\etalons\etalon_dlg.pas' {fetalon_dlg},
  upoint in 'upoint.pas' {ed_points},
  upoint_l3 in 'upoint_l3.pas' {fpoint_l3},
  upoint_l1 in 'upoint_l1.pas' {fpoint_l1},
  upoint_l2 in 'upoint_l2.pas' {fpoint_l2},
  uliable in 'uliable.pas' {fliable},
  umanager in 'umanager.pas' {fmanager},
  upoint_l0 in 'upoint_l0.pas' {fpoint_l0};

{$R *.res}

exports MakerDialog;
exports LiableDialog;
exports DiscountDialog;
exports PointDialog;
exports L0PointDialog;
exports ManagerDialog;

begin
end.
