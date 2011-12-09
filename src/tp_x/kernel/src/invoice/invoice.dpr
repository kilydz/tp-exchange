library invoice;

uses
  FastShareMem,
  SysUtils,
  Classes,
  uinvoice in 'uinvoice.pas' {DM: TDataModule},
  uinvoice_dlg in 'uinvoice_dlg.pas' {finvoice_dlg};

{$R *.res}

exports InvoicePrint,
        InvoiceDialog,
        InvoiceDialogDate;
begin
end.
