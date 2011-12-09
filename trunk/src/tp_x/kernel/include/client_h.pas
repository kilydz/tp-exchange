unit client_h;

interface

uses kernel_h, Classes, IBQuery, uZClasses;

type
//    id <= 0 - створити новий запис;
//    id > 0  - редагувати запис з даним id;

  ZAccountDialogResulted = record
     account_id: integer;
     client_id: integer;
     account_num: string;
     bank_name: string;
     mfo: string;
     bank_id: integer;

     ins, upd, del: boolean;
   end;
lpZAccountDialogResulted = ^ZAccountDialogResulted;

  ZClientTmpDialogResulted = record
     client_id: integer;
     typeclient_id: integer;
     name: string;
     zkpo: string;
     adress: string;
     is_pdv: integer;
     is_active: integer;
     note: string;
   end;
lpZClientTmpDialogResulted = ^ZClientTmpDialogResulted;


function AccountDialog(id: integer; resulted: lpZAccountDialogResulted; var prm: ZVelesInfoRec): integer;
    external 'client.dll' name 'AccountDialog';

function BankDialog(id: integer; var prm: ZVelesInfoRec): integer;
    external 'client.dll' name 'BankDialog';

implementation

end.
