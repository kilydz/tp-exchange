library popups;

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
  maker_popup in 'maker_popup.pas' {fmaker_popup},
  liable_popup in 'liable_popup.pas' {fliable_popup},
  client_popup in 'client_popup.pas' {fclient_popup},
  document_popup in 'document_popup.pas' {fdocument_popup},
  etalon_popup in '..\..\lib\etalons\etalon_popup.pas' {fetalon_popup},
  bank_popup in 'bank_popup.pas' {fbank_popup},
  point_popup in 'point_popup.pas' {fpoint_popup},
  discount_popup in 'discount_popup.pas' {fdiscount_popup},
  manager_popup in 'manager_popup.pas' {fmanager_popup},
  point_l0_popup in 'point_l0_popup.pas' {fpoint_l0_popup};

{$R *.res}

exports ClientPopupCreate;
exports ClientPopupRefresh;
exports ClientPopupFree;

exports LiablePopupCreate;
exports LiablePopupRefresh;
exports LiablePopupFree;

exports MakerPopupCreate;
exports MakerPopupRefresh;
exports MakerPopupFree;

exports DocumentPopupCreate;
exports DocumentPopupRefresh;
exports DocumentPopupFree;

exports BankPopupCreate;
exports BankPopupRefresh;
exports BankPopupFree;

exports PointPopupCreate;
exports PointPopupRefresh;
exports PointPopupFree;

exports L0PointPopupCreate;
exports L0PointPopupRefresh;
exports L0PointPopupFree;

exports DiscountPopupCreate;
exports DiscountPopupRefresh;
exports DiscountPopupFree;

exports ManagerPopupCreate;
exports ManagerPopupRefresh;
exports ManagerPopupFree;

begin
end.
