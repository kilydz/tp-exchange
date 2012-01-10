unit document_h;

interface

uses kernel_h, Classes, IBQuery;

type
//    id <= 0 - створити новий запис;
//    id > 0  - редагувати запис з даним id;

  ZDocumentDialogResulted = record
     document_id:   integer;
     doc_date:      string;
     doc_num:       string;
     edrpou:        string;
     name_firm:     string;
   end;
  lpZDocumentDialogResulted = ^ZDocumentDialogResulted;

  ZDocrecDialogResulted = record
     document: lpZDocumentDialogResulted;
     docrec_id: integer;
     nomen: record
       code_wares: integer;
       name_wares: string;
       name_wares_brand: string;
     end;
     code_unit: Integer;
     abr_unit: string;
     kilk: real;
     price_pdv: real;
     vat: Real;
     price: real;
     sum_pdv: real;
     sum: real;
   end;
  lpZDocrecDialogResulted = ^ZDocrecDialogResulted;

function DocumentDialog(id: integer; resulted: lpZDocumentDialogResulted; var prm: ZVelesInfoRec): integer;
    external 'document.dll' name 'DocumentDialog';

function DocumentEditor(resulted: lpZDocumentDialogResulted; var prm: ZVelesInfoRec): integer;
    external 'document.dll' name 'DocumentEditor';

function DocrecDialogDR1(id: integer; nomen_id: integer; code_unit: Integer; resulted: lpZDocrecDialogResulted; var prm: ZVelesInfoRec): integer;
    external 'document.dll' name 'DocrecDialogDR1';

function DocrecDialogDR2(id: integer; nomen_id: integer; resulted: lpZDocrecDialogResulted; var prm: ZVelesInfoRec): integer;
    external 'document.dll' name 'DocrecDialogDR2';

function DocrecDialogDR2_v2(type_markup:integer; markup_value:real; id: integer; nomen_id: integer; resulted: lpZDocrecDialogResulted; var prm: ZVelesInfoRec): integer;
    external 'document.dll' name 'DocrecDialogDR2_v2';

function DocrecDialogDR10(id: integer; nomen_id: integer; resulted: lpZDocrecDialogResulted; var prm: ZVelesInfoRec): integer;
    external 'document.dll' name 'DocrecDialogDR10';

function DocrecDialogDR15(id: integer; nomen_id: integer; resulted: lpZDocrecDialogResulted; var prm: ZVelesInfoRec): integer;
    external 'document.dll' name 'DocrecDialogDR15';

function DocrecDialogDR17(id: integer; nomen_id: integer; resulted: lpZDocrecDialogResulted; var prm: ZVelesInfoRec): integer;
    external 'document.dll' name 'DocrecDialogDR17';

function DocrecDialogDR6(id: integer; nomen_id: integer; resulted: lpZDocrecDialogResulted; var prm: ZVelesInfoRec): integer;
    external 'document.dll' name 'DocrecDialogDR6';

function DocrecDialogDR4(id: integer; nomen_id: integer; resulted: lpZDocrecDialogResulted; var prm: ZVelesInfoRec): integer;
    external 'document.dll' name 'DocrecDialogDR4';

function DocrecDialogDR7(id: integer; nomen_id: integer; resulted: lpZDocrecDialogResulted; var prm: ZVelesInfoRec): integer;
    external 'document.dll' name 'DocrecDialogDR7';

implementation

end.
