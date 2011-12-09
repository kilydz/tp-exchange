unit revision_h;

interface

uses kernel_h, Classes, IBQuery, uZClasses;

type
//    id <= 0 - створити новий запис;
//    id > 0  - редагувати запис з даним id;

  ZRevisionDialogResulted = record
     revision_id: integer;
     revision_date: TDateTime;
     token: string[20];
   end;
lpZRevisionDialogResulted = ^ZRevisionDialogResulted;

  ZRevisionRecordDialogResulted = record
     code: string[7];
     nomen_name: string[255];
     new_rest: real;
     old_rest: real;
   end;
lpZRevisionRecordDialogResulted = ^ZRevisionRecordDialogResulted;

function RevisionDialog(id: integer; resulted: lpZRevisionDialogResulted; var prm: ZVelesInfoRec): integer;
    external 'revision.dll' name 'RevisionDialog';

function RevisionRecordDialog(id: integer; resulted: lpZRevisionRecordDialogResulted; var prm: ZVelesInfoRec): integer;
    external 'revision.dll' name 'RevisionRecordDialog';

function RevisionRecordsEditor(var resulted: ZRevisionDialogResulted; var prm: ZVelesInfoRec): integer;
    external 'revision.dll' name 'RevisionRecordsEditor';

implementation

end.
