unit pay_h;
//  Name: pay_h.pas
//  Copyright: SoftWest group.
//  Author: Михалюк Максим
//  Date: 10.01.06
//  Description: заголовок для діалогу проплата

interface

uses kernel_h;

type
    ZPayDlgResulted = record
        id: integer;
        pay_type_id: Integer;
        pay_type_name: string;
        document_id: Integer;
        sum: Currency;
        date: string;
    end;

    lpZPayDlgResulted = ^ZPayDlgResulted;

    ZPaysDialog = function(var a_veles_info: ZVelesInfoRec;
        adocument_id: Integer): Integer;

    ZPayDialogFunc = function(id: Integer; resulted: lpZPayDlgResulted;
        var prm: ZVelesInfoRec): Integer;

implementation

end. 
