unit autoorder_h;

interface

uses kernel_h, Classes, IBQuery, uZClasses;

type
//    id <= 0 - створити новий запис;
//    id > 0  - редагувати запис з даним id;

  ZAutoorderDialogResulted = record
     autoorder_id: integer;
     client_id: integer;
     liable_id: integer;

     token: string;
     analysed: integer;
     ordered: integer;

     use_period :Boolean;
     date0, date1, date_in : TdateTime;
   end;
lpZAutoorderDialogResulted = ^ZAutoorderDialogResulted;

  ZAORecordDialogResulted = record
     ao_record_id: integer;
     rec_order: real;
     ordered: real;
   end;
lpZAORecordDialogResulted = ^ZAORecordDialogResulted;

function AutoorderDialog(id: integer; resulted: lpZAutoorderDialogResulted; var prm: ZVelesInfoRec): integer;
    external 'autoorder.dll' name 'AutoorderDialog';

function AutoorderEditor(resulted: lpZAutoorderDialogResulted; var prm: ZVelesInfoRec): integer;
    external 'autoorder.dll' name 'AutoorderEditor';

function AORecordDialog(id: integer; resulted: lpZAORecordDialogResulted; var prm: ZVelesInfoRec): integer;
    external 'autoorder.dll' name 'AORecordDialog';

implementation

end.
