unit popup_h;

interface

uses kernel_h, Classes, IBQuery, uZClasses;

type
//    id <= 0 - створити новий запис;
//    id > 0  - редагувати запис з даним id;

  ZMakerDialogResulted = record
     maker_id: integer;
     maker_name: string;
   end;
lpZMakerDialogResulted = ^ZMakerDialogResulted;

  ZLiableDialogResulted = record
     liable_id: integer;
     surname: string;
     name: string;
     patronymic: string;
     is_responsible: integer;
   end;
lpZLiableDialogResulted = ^ZLiableDialogResulted;

  ZDecreaseDialogResulted = record
     decr_id:      integer;
     decr_name:    string;
     decr_value:   real;
     decr_value1:  real;
     decr_type_id: integer;
   end;
lpZDecreaseDialogResulted = ^ZDecreaseDialogResulted;

function MakerDialog(id: integer; resulted: lpZMakerDialogResulted; var prm: ZVelesInfoRec): integer;
    external 'popup.dll' name 'MakerDialog';

function LiableDialog(id: integer; resulted: lpZLiableDialogResulted; var prm: ZVelesInfoRec): integer;
    external 'popup.dll' name 'LiableDialog';

function DecreaseDialog(id: integer; resulted: lpZDecreaseDialogResulted; var prm: ZVelesInfoRec): integer;
    external 'popup.dll' name 'DecreaseDialog';    

implementation

end.
