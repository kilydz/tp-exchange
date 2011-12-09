unit tree_h;

interface
uses Forms, Controls, IBDatabase, kernel_h;

type
  TGroupTreeNode = record  // ̳����� ��� ��� ������ ����
    id: integer;
    prew_id: integer;
    code: integer;
    name: string;
    maker_id: integer;
    maker_name: string;
   end;
  PTGroupTreeNode = ^TGroupTreeNode;
  TOnChengeBranch = procedure(var TTreeParams); //  ��� �-� ������� �� ���� ������� ����
  TOnShowHide = procedure(var TTreeParams); //  ��� �-� ������� �� �����/����������� ������

  TTreeParams = record // M����� ���� ������� ���������, ��� �� ����� ����������
    sGen: ZVelesInfoRec;

    OnChengeBranch: TOnChengeBranch; //  ������� �� ���� ������� ����
    OnShowHide: TOnShowHide; //  ������� �� �����/����������� ������
    Visible: boolean;
    ActiveNode: PTGroupTreeNode; // �������� �� ������� ����
    SetGrpId: integer;
    Forma: TForm;
    Panel: TWinControl;
    grp_list: AnsiString;
    MultiSelect: integer;
    PrewForma: TForm;
   end;

// ������� ������
function TreeCreate(var prm: TTreeParams): integer;
         external 'Tree.dll' name 'TreeCreate';

// ��������� ������
function TreeRefresh(var prm: TTreeParams): integer;
         external 'Tree.dll' name 'TreeRefresh';

// �������� ������ �������� 'b0,b1,b2,b3,.....,bn'
function TreeSelections(var prm: TTreeParams): integer;
         external 'Tree.dll' name 'TreeSelections';

// �������� ������ �������� ' b0 b1 b2 b3 ..... bn '
function TreeSelectionsSpace(var prm: TTreeParams): integer;
         external 'Tree.dll' name 'TreeSelectionsSpace';

// ������� �� ���� � SetGrpId
function TreeToGroup(var prm: TTreeParams): integer;
         external 'Tree.dll' name 'TreeToGroup';

// ������ (prm.Visible = true), ��� ���� (prm.Visible = false) ������
function TreeHideShow(var prm: TTreeParams): integer;
         external 'Tree.dll' name 'TreeHideShow';

// ������� ���'�� ���� ��������� ������ � �������
function TreeRelase(var prm: TTreeParams): integer;
         external 'Tree.dll' name 'TreeRelase';


function BranchDialog(grp_id: integer; prew_grp_id: integer;  resulted: PTGroupTreeNode; var prm: ZVelesInfoRec): integer;
         external 'tree.dll' name 'BranchDialog';
//------------------------------------------------------------
// ������� ������
function TreeCreateC(var prm: TTreeParams): integer;
         external 'Tree.dll' name 'TreeCreateC';

// ��������� ������
function TreeRefreshC(var prm: TTreeParams): integer;
         external 'Tree.dll' name 'TreeRefreshC';

// �������� ������ �������� 'b0,b1,b2,b3,.....,bn'
function TreeSelectionsC(var prm: TTreeParams): integer;
         external 'Tree.dll' name 'TreeSelectionsC';

// �������� ������ �������� ' b0 b1 b2 b3 ..... bn '
function TreeSelectionsSpaceC(var prm: TTreeParams): integer;
         external 'Tree.dll' name 'TreeSelectionsSpaceC';

// ������� �� ���� � SetGrpId
function TreeToGroupC(var prm: TTreeParams): integer;
         external 'Tree.dll' name 'TreeToGroupC';

// ������ (prm.Visible = true), ��� ���� (prm.Visible = false) ������
function TreeHideShowC(var prm: TTreeParams): integer;
         external 'Tree.dll' name 'TreeHideShowC';

// ������� ���'�� ���� ��������� ������ � �������
function TreeRelaseC(var prm: TTreeParams): integer;
         external 'Tree.dll' name 'TreeRelaseC';

function BranchCDialog(grp_id: integer; prew_grp_id: integer;  resulted: PTGroupTreeNode; var prm: ZVelesInfoRec): integer;
         external 'tree.dll' name 'BranchCDialog';
//------------------------------------------------------------
// ������� ������
function TreeCreateLC(var prm: TTreeParams): integer;
         external 'Tree.dll' name 'TreeCreateLC';

// ��������� ������
function TreeRefreshLC(var prm: TTreeParams): integer;
         external 'Tree.dll' name 'TreeRefreshLC';

// �������� ������ �������� 'b0,b1,b2,b3,.....,bn'
function TreeSelectionsLC(var prm: TTreeParams): integer;
         external 'Tree.dll' name 'TreeSelectionsLC';

// �������� ������ �������� ' b0 b1 b2 b3 ..... bn '
function TreeSelectionsSpaceLC(var prm: TTreeParams): integer;
         external 'Tree.dll' name 'TreeSelectionsSpaceLC';

// ������� �� ���� � SetGrpId
function TreeToGroupLC(var prm: TTreeParams): integer;
         external 'Tree.dll' name 'TreeToGroupLC';

// ������ (prm.Visible = true), ��� ���� (prm.Visible = false) ������
function TreeHideShowLC(var prm: TTreeParams): integer;
         external 'Tree.dll' name 'TreeHideShowLC';

// ������� ���'�� ���� ��������� ������ � �������
function TreeRelaseLC(var prm: TTreeParams): integer;
         external 'Tree.dll' name 'TreeRelaseLC';

implementation

end.
