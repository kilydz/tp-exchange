unit w_nomen_h;

interface

uses veles_h, Classes, IBQuery, uXClasses;

type
//    id <= 0 - створити новий запис;
//    id > 0  - редагувати запис з даним id;

  ZWNomenDialogResulted = record
     w_nomen_id: integer;
     nomen_id: integer;

     descript: string;
     maker_id: integer;
   end;
lpZWNomenDialogResulted = ^ZWNomenDialogResulted;

function WNomenDialog(id: integer; nomen_id: integer; resulted: lpZWNomenDialogResulted; var prm: ZVelesInfoRec): integer;
    external 'w_nomen.dll' name 'WNomenDialog';

implementation

end.
