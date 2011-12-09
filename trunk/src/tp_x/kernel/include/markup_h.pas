unit markup_h;

interface

uses kernel_h, Classes, IBQuery, uZClasses;

type
//    id <= 0 - створити новий запис;
//    id > 0  - редагувати запис з даним id;

  ZMarkupDialogResulted = record
     markup_id: integer;
     markup_around_id: integer;

     markup: real;
     token: string;
   end;
lpZMarkupDialogResulted = ^ZMarkupDialogResulted;

ZMarkupDocDialogResulted = ZMarkupDialogResulted;
lpZMarkupDocDialogResulted = ^ZMarkupDocDialogResulted;

  ZMarkupRecordDialogResulted = record
     markup_record_id:  integer;
     nomen_id:          integer;
     in_price:          real;
     out_price:         real;
     markup_around_id:  integer;
     markup:            real;
     recom_markup:      real;
     is_markup_block:   integer; {0 - "No", 1 - "Yes"}
     is_outprice_block: integer; {0 - "No", 1 - "Yes"}
   end;
lpZMarkupRecordDialogResulted = ^ZMarkupRecordDialogResulted;

function MarkupDialog(id: integer; editor: boolean; resulted: lpZMarkupDocDialogResulted; var prm: ZVelesInfoRec): integer;
    external 'markup.dll' name 'MarkupDialog';

function MarkupDocDialog(id: integer; document_id: integer; resulted: lpZMarkupDocDialogResulted; var prm: ZVelesInfoRec): integer;
    external 'markup.dll' name 'MarkupDocDialog';

function MarkupRecordDialog(id: integer; resulted: lpZMarkupRecordDialogResulted; var prm: ZVelesInfoRec): integer;
    external 'markup.dll' name 'MarkupRecordDialog';

implementation

end.
