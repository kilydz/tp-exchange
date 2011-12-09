unit Zutils_h;

interface
uses Forms, kernel_h, dxEdLib, IBQuery, uZClasses;

type
  ZGroupTreeNode = record  // ̳����� ��� ��� ������ ����
    id: integer;
    prew_id: integer;
    name: string;
   end;
  lpZGroupTreeNode = ^ZGroupTreeNode;

  ZTreeParams = record // M����� ���� ������� ���������, ��� �� ����� ����������
    ed_popup: ^TdxPopupEdit;
    active_node: lpZGroupTreeNode; // �������� �� ������� ����
    ftree: TForm;
    owner: TObject;
   end;
  lpZTreeParams = ^ZTreeParams;

  ZUniteRecords = record
     id_list: ZContainerId;
     sql_unite: string;
     sql_info: string;
   end;
  lpZUniteRecords = ^ZUniteRecords;


  ZCreateLike = record
     id: integer;
     sql_types_convert: string;
     sql_create: string;
     sql_info: string;
   end;
  lpZCreateLike = ^ZCreateLike;

procedure GTreeCreate(sql: string; tree_prm: lpZTreeParams; prm: ZVelesInfoRec);
    external 'zutils.dll' name 'GTreeCreate';

function GTreeResult(tree_prm: lpZTreeParams): lpZGroupTreeNode;
    external 'zutils.dll' name 'GTreeResult';

procedure GTreeToGroup(tree_prm: lpZTreeParams; grp_id: integer);
    external 'zutils.dll' name 'GTreeToGroup';

procedure GTreeFree(tree_prm: lpZTreeParams);
    external 'zutils.dll' name 'GTreeFree';

function PasswordCryptor(password: string; crypt: Boolean): string;
    external 'zutils.dll' name 'PasswordCryptor';

function GDeleteRecord(query: PChar; id: integer; for_upd: TIBQuery; var prm: ZVelesInfoRec): integer;
    external 'zutils.dll' name 'GDeleteRecord';

function GMessageBox(msg, buttons: string): Integer;
    external 'zutils.dll' name 'GMessageBox';

//function GMessageBox(msg, buttons: string): Integer;
//    external 'zutils.dll' name 'GMessageBox';

implementation

end.
