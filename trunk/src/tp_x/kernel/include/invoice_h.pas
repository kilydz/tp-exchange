unit invoice_h;
interface
uses kernel_h;

const
    ACCESS_TO_PRINT          = 100000;
    ACCESS_TO_PRINT_INVOICE  = 100110;

type
  ZInvoice = record
     invoice_id:      integer;
     q_header:        string;
     q_records:       string;
     q_upd_after:     string;
     frf_filter:      string;
     frf_descriptor:  string;
  end;
  lpZInvoice = ^ZInvoice;

  ZInvoiceDescr = record
     document_id: integer;
     inv: lpZInvoice;
     frf_name : string;

     use_date: boolean;
     date0,
     date1: string;

     prm: ZVelesInfoRec;
  end;

procedure InvoicePrint(prm: ZInvoiceDescr);
   external 'invoice.dll' name 'InvoicePrint';

implementation

end.
