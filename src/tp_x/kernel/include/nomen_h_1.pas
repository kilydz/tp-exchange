unit nomen_h;

interface

uses kernel_h, Classes, IBQuery, Controls, Forms, uZClasses;

type
//    id <= 0 - створити новий запис;
//    id > 0  - редагувати запис з даним id;

//  ZBarcodeDialogResulted = record
//     barcode_id: integer;
//     nomen_id: integer;
//     barcode_type_id: integer;
//     barcode: string;
//     out_price: real;
//
//     ins, upd, del: boolean;
//
//     type_name: string;
//   end;
//lpZBarcodeDialogResulted = ^ZBarcodeDialogResulted;
//
//  ZNomenDialogResulted = record
//     nomen_id: integer;
//     grp_id: integer;
//     sg_id: integer;
//     si_id: integer;
//     typepdv_id: integer;
//     is_dividend: integer;
//     code: string;
//     full_name: string;
//     short_name: string;
//     netto: real;
//     min_rest: real;
//     is_visible: integer;
//     is_active: integer;
//     out_price: real;
//     maker_id: integer;
//     decr_id: integer;
//     type_nomen: integer;
//     is_in_discount: integer;
//   end;
//lpZNomenDialogResulted = ^ZNomenDialogResulted;

  ZTmpNomenDialogResulted = record
     nomen_id: integer;
     code: string;
     full_name: string;
     short_name: string;
     description: string;
     maker_name: string;
     trademark: string;
     grp_id: integer;
     sg_id: integer;
     si_id: integer;
     typepdv_id: integer;
     is_divided: integer;
  end;
  lpZTmpNomenDialogResulted = ^ZTmpNomenDialogResulted;

  ZNomenPrmRecords = record
     id_list: ZContainerId;

     grp_id: integer;
     sg_id: integer;
     si_id: integer;
     typepdv_id: integer;
     is_dividend: integer;
     netto: real;
     min_rest: real;
     is_visible: integer;
     is_active: integer;
     type_nomen: integer;
     is_in_discount: integer;
   end;
  lpZNomenPrmRecords = ^ZNomenPrmRecords;

//function BarcodeDialog(id: integer; resulted: lpZBarcodeDialogResulted; var prm: ZKernelRec): integer;
//    external 'nomen.dll' name 'BarcodeDialog';
//
//function NomenDialog(id: integer; grp_id: integer; resulted: lpZNomenDialogResulted; var prm: ZKernelRec): integer;
//    external 'nomen.dll' name 'NomenDialog';
//
//function TmpNomenDialog(id: integer; resulted: lpZTmpNomenDialogResulted; var prm: ZKernelRec): integer;
//    external 'tmp_nomen.dll' name 'TmpNomenDialog';
//
//function NomenPrmDialog(resulted: lpZNomenPrmRecords; var prm: ZKernelRec): integer;
//    external 'nomen.dll' name 'NomenPrmDialog';

implementation

end.
