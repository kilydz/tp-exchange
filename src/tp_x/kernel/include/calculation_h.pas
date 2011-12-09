unit calculation_h;

interface

uses veles_h;

type
//    id <= 0 - створити новий запис;
//    id > 0  - редагувати запис з даним id;

  ZCalculationDialogResulted = record
    calculation_id: Integer;
    nomen_id: Integer;
    nomen_name: String;
    output_quantity: Double;
  end;
  lpZCalculationDialogResulted = ^ZCalculationDialogResulted;

  ZCalculationDialog = function (id: Integer; resulted: lpZCalculationDialogResulted; var prm: ZVelesInfoRec): Integer;

  ZCalcRecordDialogResulted = record
    calc_record_id: Integer;
    calculation_id: Integer;
    nomen_id: Integer;
    input_quantity: Double;
    netto: Double;
  end;
  lpZCalcRecordDialogResulted = ^ZCalcRecordDialogResulted;

function CalcRecordDialog(calc_record_id: Integer; resulted: lpZCalcRecordDialogResulted; var prm: ZVelesInfoRec): Integer;
    external 'calculation.dll' name 'CalcRecordDialog';

function CalculationEditor(resulted: lpZCalculationDialogResulted; var prm: ZVelesInfoRec): integer;
    external 'calculation.dll' name 'CalculationEditor';

implementation

end.
