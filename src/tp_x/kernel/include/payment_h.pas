unit payment_h;

interface

uses veles_h, Classes, IBQuery, uXClasses;

type
//    id <= 0 - створити новий запис;
//    id > 0  - редагувати запис з даним id;

  ZPaymentDialogResulted = record
     payment_id: integer;
     clients_id,
     staff_id:integer;
     pay_date: TDateTime;
   end;
lpZPaymentDialogResulted = ^ZPaymentDialogResulted;

  ZPaymentRecordDialogResulted = record
     payment_rec_id,
     payment_id,
     clients_id: integer;
     category,
     note,
     foundation: string;
     suma:       real;
     doc_date:   TDateTime;
   end;
lpZpaymentRecordDialogResulted = ^ZpaymentRecordDialogResulted;

function PaymentDialog(id: integer; resulted: lpZpaymentDialogResulted; var prm: ZVelesInfoRec): integer;
    external 'payment.dll' name 'PaymentDialog';

function PaymentEditor(resulted: lpZpaymentDialogResulted; var prm: ZVelesInfoRec): integer;
    external 'payment.dll' name 'PaymentEditor';

function PaymentRecordDialog(id: integer; resulted: lpZpaymentRecordDialogResulted; var prm: ZVelesInfoRec): integer;
    external 'payment.dll' name 'PaymentRecordDialog';

implementation

end.
