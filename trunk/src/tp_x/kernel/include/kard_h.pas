unit kard_h;

interface

uses kernel_h, Classes, IBQuery, uZClasses;

type
//    id <= 0 - створити новий запис;
//    id > 0  - редагувати запис з даним id;

  ZKardDialogResulted = record
     kard_id: integer;
     discont_id: integer;
     client_id: integer;

     kardcode: string;
     kard_name: string;
     is_block: integer;
   end;
lpZKardDialogResulted = ^ZKardDialogResulted;

function KardDialog(id: integer; resulted: lpZKardDialogResulted; var prm: ZVelesInfoRec): integer;
    external 'kard.dll' name 'KardDialog';

implementation

end.
