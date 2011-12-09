unit user_h;
//  Name: user_h.pas
//  Copyright: SoftWest group.
//  Author: Михалюк Максим
//  Date: 15.12.05
//  Description: заголовок для діалогу користувач (довідник Користувачі)

interface

uses kernel_h;

type
    ZUserDlgResulted = record
        id: integer;
        nick: string;
        login: string;
        keyword: string;
        //confirm: string;
        signature: string;
        surname: string;
        first_name: string;
        second_name: string;
        rights_grp_id: Integer;
        state: Integer;//активований або деактивований (передається в дллку з програми)
    end;

    lpZUserDlgResulted = ^ZUserDlgResulted;

    ZUserDialogFunc = function(id: Integer; resulted: lpZUserDlgResulted;
        var prm: ZVelesInfoRec): Integer;

implementation

end.
