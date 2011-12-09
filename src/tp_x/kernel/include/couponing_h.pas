//  File name:      couponing_h.pas.
//  File content:   заголовок (header).
//  Project:        Купонінг.
//  Copyright:      Softwest.
//  Author:         Максим Михалюк.
//  Date:           21 квітня 2008 р.
//  Description:    константи, типи даних для проекта купонінг.

unit couponing_h;

interface

uses Controls, SysUtils;

const
    PROP_TAG                     = 'prop';
    PROP_COUPON_EAN_ID_TAG       = 'coupon_ean_id';
    PROP_START_DATE_TAG          = 'start_date';
    PROP_END_DATE_TAG            = 'end_date';
    PROP_DISCOUNT_ID_TAG         = 'discount_id';

    ARTICLE_TAG                  = 'article';
	ART_COUPON_EAN_ID_TAG        = 'coupon_ean_id';
    ART_DISCOUNT_VALUE_TAG       = 'discount_value';
    ART_SKU_NAME_TAG             = 'sku_name';
	ART_SKU_EAN_ID_TAG           = 'sku_ean_id';
    ART_SKU_QUANTITY_TAG         = 'sku_quantity';
    ART_PRODUSER_TAG             = 'producer';
    ART_PRODUSER_OKPO            = 'producer_okpo';
    ART_TRADE_MARK_TAG           = 'trade_mark';
    ART_UNIT_ID_TAG              = 'unit_id';

    DISCOUNT_TAG                 = 'discount';
    DIS_ID_TAG                   = 'id';
    DIS_DISCOUNT_DESCRIPTION_TAG = 'discount_description';

    UNITS_TAG                    = 'units';
    UNI_ID_TAG                   = 'id';
    UNI_UNIT_DESCRIPTION_TAG     = 'unit_description';

    SALES_REPORT_FILE_NAME       = 'sales_report.xml';

    SALES_XML_VER                = '<?xml version="1.0" encoding="utf-8" ?>';
    SALES_XDS_URL                = 'xmlns="http://couponing.prospects.com.ua/sales_report.xsd"';
    SALES_REPORT_TAG             = 'sales_report';

    SHOPS_TAG                    = 'shops';
    SHO_ID_TAG                   = 'id';
    SHO_SHOP_NAME_TAG            = 'shop_name';
    SHO_SHOP_ADDRESS_TAG         = 'shop_address';
    SHO_SHOP_DESCRIPTION_TAG     = 'shop_description';
    SHO_NETWORK_ID_TAG               = 'network_id';

    SALES_TAG                    = 'sales';
    SAL_ID_TAG                   = 'id';
    SAL_PURCHASE_DATE_TAG        = 'purchase_date';
    SAL_CHECK_NUMBER_TAG         = 'check_number';
    SAL_POS_ID_TAG               = 'pos_id';
    SAL_SHOP_ID_TAG              = 'shop_id';
    SAL_SKU_EAN_ID_TAG           = 'sku_ean_id';
    SAL_SKU_QUANTITY_TAG         = 'sku_quantity';
    SAL_SKU_START_PRICE_TAG      = 'sku_start_price';
    SAL_SKU_SALE_PRICE_TAG       = 'sku_sale_price';
    SAL_COUPON_EAN_ID_TAG        = 'coupon_ean_id';

type
    ZCouponPropRec = record
      coupon_ean_id: Int64;
      start_date: TDate;
      end_date: TDate;
      discount_id: Integer;
    end;
    PCouponPropRec = ^ZCouponPropRec;

    ZArticleRec = record
      coupon_ean_id: Int64;
      discount_value: Double;
      sku_ean_id: Int64;
      sku_name: WideString;
      sku_quantity: Integer;
      producer: string;
      producer_okpo: string;
      trade_mark: string;
      unit_id: Integer;
      nomen_id: Integer;
      nomen_name: string;
      row: Integer;
    end;
    PArticleRec = ^ZArticleRec;
    
    ZDiscountRec = record
      id: Integer;
      description: string;
    end;
    PDiscountRec = ^ZDiscountRec;

    ZUnitsRec = record
      id: Integer;
      description: string;
    end;
    PUnitsRec = ^ZUnitsRec;

function UTFToDate(const str: string): TDate;
function DateToUTF(const dt: TDate): string;

implementation

//тупо, але працює
function UTFToDate(const str: string): TDate;
var
    s:            string;

begin
    Result:=0.0;
    s:=UpperCase(str);//на всяк випадок
    s:=Copy(str, 1, Pos('T', str) - 1);//копіюємо саму дату
    Result:=EncodeDate(StrToInt(Copy(s, 1, 4)), StrToInt(Copy(s, 6, 2)), StrToInt(Copy(s, 9, 2)));
end;

function DateToUTF(const dt: TDate): string;
begin
    Result:=FormatDateTime('yyy-mm-dd', dt) + 'T00:00:00.0000000+03:00';;
end;

end.
