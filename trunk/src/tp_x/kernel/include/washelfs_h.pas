unit washelfs_h;

interface

uses veles_h, Classes, IBQuery, uXClasses, uXRow;

type

  ZRowDialogResulted = record
     row_id: integer;
     object_id: integer;
     num: string;
     description: AnsiString;
   end;
lpZRowDialogResulted = ^ZRowDialogResulted;

function RowDialog(id: integer; resulted: lpZRowDialogResulted; var prm: ZVelesInfoRec): integer;
    external 'washelfs.dll' name 'RowDialog';

function ShelfGrpDialog(id: integer; q_free: real; var item_rec: ZItemRec; var prm: ZVelesInfoRec): integer;
    external 'washelfs.dll' name 'ShelfGrpDialog';

implementation

end.
