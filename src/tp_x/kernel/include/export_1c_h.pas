unit export_1c_h;

interface

uses kernel_h, Classes, IBQuery, uZClasses;

type
//    id <= 0 - створити новий запис;
//    id > 0  - редагувати запис з даним id;

  ZReestrDialogResulted = record
     reestr_id: integer;
     document_id: integer;

     number: string;
     date: string;

     sum: real;
     sum_with_vat: real;
   end;
lpZReestrDialogResulted = ^ZReestrDialogResulted;

  Z_X_SumDialogResulted = record
     document_id: integer;

     periodic_id: string;
     sum: real;
     date_final: string;
   end;
lpZ_X_SumDialogResulted = ^Z_X_SumDialogResulted;

function ReestrDialog(document_id: integer; resulted: lpZReestrDialogResulted; var prm: ZVelesInfoRec): integer;
    external 'export_1c.dll' name 'ReestrDialog';

function Z_SumDialog(periodic_id: string; resulted: lpZ_X_SumDialogResulted; var prm: ZVelesInfoRec): integer;
    external 'export_1c.dll' name 'Z_SumDialog';

implementation

end.
