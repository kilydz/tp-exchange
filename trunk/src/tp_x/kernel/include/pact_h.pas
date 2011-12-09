unit pact_h;

interface

uses veles_h, Classes, IBQuery, uXClasses;

type
//    id <= 0 - створити новий запис;
//    id > 0  - редагувати запис з даним id;

  ZPactDialogResulted = record
     pact_id: integer;
     client_id: integer;
     token: string;

     date_begin: string;
     date_end: string;
     pact_sum: real;
     pact_sum_pdv: real;
   end;
lpZPactDialogResulted = ^ZPactDialogResulted;

function PactDialog(id: integer; resulted: lpZPactDialogResulted; var prm: ZVelesInfoRec): integer;
    external 'pact.dll' name 'PactDialog';

implementation

end.
