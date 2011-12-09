unit popups_h;

interface

uses kernel_h, Forms, dxEdLib;

type
  ZPopupParams = record
    id: integer;
    form, prew_form: TForm;
    ed_popup: TdxPopupEdit;
   end;
lpZPopupParams = ^ZPopupParams;

procedure ClientPopupCreate(popup_prm: lpZPopupParams; prm: ZVelesInfoRec);
    external 'popups.dll' name 'ClientPopupCreate';

procedure ClientPopupRefresh(popup_prm: lpZPopupParams; flag: integer);
    external 'popups.dll' name 'ClientPopupRefresh';

procedure ClientPopupFree(popup_prm: lpZPopupParams);
    external 'popups.dll' name 'ClientPopupFree';


procedure LiablePopupCreate(popup_prm: lpZPopupParams; prm: ZVelesInfoRec);
    external 'popups.dll' name 'LiablePopupCreate';

procedure LiablePopupRefresh(popup_prm: lpZPopupParams);
    external 'popups.dll' name 'LiablePopupRefresh';

procedure LiablePopupFree(popup_prm: lpZPopupParams);
    external 'popups.dll' name 'LiablePopupFree';
    

procedure MakerPopupCreate(popup_prm: lpZPopupParams; prm: ZVelesInfoRec);
    external 'popups.dll' name 'MakerPopupCreate';

procedure MakerPopupRefresh(popup_prm: lpZPopupParams);
    external 'popups.dll' name 'MakerPopupRefresh';

procedure MakerPopupFree(popup_prm: lpZPopupParams);
    external 'popups.dll' name 'MakerPopupFree';

    
procedure DocumentPopupCreate(popup_prm: lpZPopupParams; prm: ZVelesInfoRec);
    external 'popups.dll' name 'DocumentPopupCreate';

procedure DocumentPopupRefresh(popup_prm: lpZPopupParams; type_docs: string);
    external 'popups.dll' name 'DocumentPopupRefresh';

procedure DocumentPopupFree(popup_prm: lpZPopupParams);
    external 'popups.dll' name 'DocumentPopupFree';


procedure BankPopupCreate(popup_prm: lpZPopupParams; prm: ZVelesInfoRec);
    external 'popups.dll' name 'BankPopupCreate';

procedure BankPopupRefresh(popup_prm: lpZPopupParams);
    external 'popups.dll' name 'BankPopupRefresh';

procedure BankPopupFree(popup_prm: lpZPopupParams);
    external 'popups.dll' name 'BankPopupFree';


procedure PointPopupCreate(popup_prm: lpZPopupParams; prm: ZVelesInfoRec);
    external 'popups.dll' name 'PointPopupCreate';

procedure PointPopupRefresh(popup_prm: lpZPopupParams);
    external 'popups.dll' name 'PointPopupRefresh';

procedure PointPopupFree(popup_prm: lpZPopupParams);
    external 'popups.dll' name 'PointPopupFree';


procedure L0PointPopupCreate(popup_prm: lpZPopupParams; prm: ZVelesInfoRec);
    external 'popups.dll' name 'L0PointPopupCreate';

procedure L0PointPopupRefresh(popup_prm: lpZPopupParams);
    external 'popups.dll' name 'L0PointPopupRefresh';

procedure L0PointPopupFree(popup_prm: lpZPopupParams);
    external 'popups.dll' name 'L0PointPopupFree';


procedure DiscountPopupCreate(popup_prm: lpZPopupParams; prm: ZVelesInfoRec);
    external 'popups.dll' name 'DiscountPopupCreate';

procedure DiscountPopupRefresh(popup_prm: lpZPopupParams);
    external 'popups.dll' name 'DiscountPopupRefresh';

procedure DiscountPopupFree(popup_prm: lpZPopupParams);
    external 'popups.dll' name 'DiscountPopupFree';


procedure ManagerPopupCreate(popup_prm: lpZPopupParams; prm: ZVelesInfoRec);
    external 'popups.dll' name 'ManagerPopupCreate';

procedure ManagerPopupRefresh(popup_prm: lpZPopupParams);
    external 'popups.dll' name 'ManagerPopupRefresh';

procedure ManagerPopupFree(popup_prm: lpZPopupParams);
    external 'popups.dll' name 'ManagerPopupFree';

implementation

end.
