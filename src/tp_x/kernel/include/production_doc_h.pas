unit production_doc_h;

interface

uses veles_h, Classes, IBQuery;

type
//    id <= 0 - створити новий запис;
//    id > 0  - редагувати запис з даним id;

  ZProduction_docDialogResulted = record
     production_doc_id: integer;
     typedoc_id:        integer;         
     note:              string;
     doc_date:          string;
   end;
lpZProduction_docDialogResulted = ^ZProduction_docDialogResulted;

  ZRecFillingDialogResulted = record
    rec_filling_id: Integer;
    production_rec_id: Integer;
    nomen_id: Integer;
    nomen_name: String;
    count: real;
  end;
  lpZRecFillingDialogResulted = ^ZRecFillingDialogResulted;

  ZProductionRecDialogResulted = record
    production_rec_id: Integer;
    production_doc_id: Integer;
    nomen_id: Integer;
    nomen_name: String;
    count: real;
  end;
  lpZProductionRecDialogResulted = ^ZProductionRecDialogResulted;

  ZDoc_recDialogResulted = record
     production_doc: lpZproduction_docDialogResulted;
     docrec_id: integer;
     typepdv_id: integer;
     nomen: record
       nomen_id: integer;
       typepdv_id: integer;
       out_price: real;
     end;  
     kilk: real;
     price_pdv: real;
     price: real;
     sum_pdv: real;
     sum: real;
     discount: real;

     nomen_name: string;
   end;
lpZDoc_recDialogResulted = ^ZDoc_recDialogResulted;

function production_docDialog(id: integer; resulted: lpZproduction_docDialogResulted; var prm: ZVelesInfoRec): integer;
    external 'production_doc.dll' name 'production_docDialog';

function production_docEditor(resulted: lpZproduction_docDialogResulted; var prm: ZVelesInfoRec): integer;
    external 'production_doc.dll' name 'production_docEditor';

implementation

end.
