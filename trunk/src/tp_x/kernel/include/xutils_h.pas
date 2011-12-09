unit xutils_h;

interface
uses Forms, kernel_h, dxEdLib, IBQuery, uZClasses;

type
  XGroupTreeNode = record  // Містить дані про окрему гілку
    id: integer;
    prew_id: integer;
    name: string;
   end;
  lpXGroupTreeNode = ^XGroupTreeNode;

  XTreeParams = record // Mусить бути описана глобально, так як форма немодальна
    ed_popup: ^TdxPopupEdit;
    active_node: lpXGroupTreeNode; // Покажчик на активну гілку
    ftree: TForm;
    owner: TObject;
   end;
  lpXTreeParams = ^XTreeParams;

  XUniteRecords = record
     id_list: ZContainerId;
     sql_unite: string;
     sql_info: string;
   end;
  lpXUniteRecords = ^XUniteRecords;


  XCreateLike = record
     id: integer;
     sql_types_convert: string;
     sql_create: string;
     sql_info: string;
   end;
  lpXCreateLike = ^XCreateLike;

procedure GTreeCreate(sql: string; tree_prm: lpXTreeParams; prm: ZVelesInfoRec);
    external 'xutils.dll' name 'GTreeCreate';

function GTreeResult(tree_prm: lpXTreeParams): lpXGroupTreeNode;
    external 'xutils.dll' name 'GTreeResult';

procedure GTreeToGroup(tree_prm: lpXTreeParams; grp_id: integer);
    external 'xutils.dll' name 'GTreeToGroup';

procedure GTreeFree(tree_prm: lpXTreeParams);
    external 'xutils.dll' name 'GTreeFree';

function PasswordCryptor(password: string; crypt: Boolean): string;
    external 'xutils.dll' name 'PasswordCryptor';

function GDeleteRecord(query: PChar; id: integer; for_upd: TIBQuery; var prm: ZVelesInfoRec): integer;
    external 'xutils.dll' name 'GDeleteRecord';

function GMessageBox(msg, buttons: string): Integer;
    external 'xutils.dll' name 'GMessageBox';

//function GMessageBox(msg, buttons: string): Integer;
//    external 'xutils.dll' name 'GMessageBox';

implementation

end.
