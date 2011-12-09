unit tree_h;

interface
uses Forms, Controls, IBDatabase, kernel_h;

type
  TGroupTreeNode = record  // Містить дані про окрему гілку
    id: integer;
    prew_id: integer;
    code: integer;
    name: string;
    maker_id: integer;
    maker_name: string;
   end;
  PTGroupTreeNode = ^TGroupTreeNode;
  TOnChengeBranch = procedure(var TTreeParams); //  Тип ф-ї реакції на зміну активної гілки
  TOnShowHide = procedure(var TTreeParams); //  Тип ф-ї реакції на Показ/Приховівання дерева

  TTreeParams = record // Mусить бути описана глобально, так як форма немодальна
    sGen: ZVelesInfoRec;

    OnChengeBranch: TOnChengeBranch; //  Реакція на зміну активної гілки
    OnShowHide: TOnShowHide; //  Реакція на Показ/Приховівання дерева
    Visible: boolean;
    ActiveNode: PTGroupTreeNode; // Покажчик на активну гілку
    SetGrpId: integer;
    Forma: TForm;
    Panel: TWinControl;
    grp_list: AnsiString;
    MultiSelect: integer;
    PrewForma: TForm;
   end;

// Створює дерево
function TreeCreate(var prm: TTreeParams): integer;
         external 'Tree.dll' name 'TreeCreate';

// Рефрешить дерево
function TreeRefresh(var prm: TTreeParams): integer;
         external 'Tree.dll' name 'TreeRefresh';

// Заповнює строку виділення 'b0,b1,b2,b3,.....,bn'
function TreeSelections(var prm: TTreeParams): integer;
         external 'Tree.dll' name 'TreeSelections';

// Заповнює строку виділення ' b0 b1 b2 b3 ..... bn '
function TreeSelectionsSpace(var prm: TTreeParams): integer;
         external 'Tree.dll' name 'TreeSelectionsSpace';

// Перехід на гілку з SetGrpId
function TreeToGroup(var prm: TTreeParams): integer;
         external 'Tree.dll' name 'TreeToGroup';

// Показує (prm.Visible = true), або ховає (prm.Visible = false) дерево
function TreeHideShow(var prm: TTreeParams): integer;
         external 'Tree.dll' name 'TreeHideShow';

// Очистка пам'яті після закінчення роботи з деревом
function TreeRelase(var prm: TTreeParams): integer;
         external 'Tree.dll' name 'TreeRelase';


function BranchDialog(grp_id: integer; prew_grp_id: integer;  resulted: PTGroupTreeNode; var prm: ZVelesInfoRec): integer;
         external 'tree.dll' name 'BranchDialog';
//------------------------------------------------------------
// Створює дерево
function TreeCreateC(var prm: TTreeParams): integer;
         external 'Tree.dll' name 'TreeCreateC';

// Рефрешить дерево
function TreeRefreshC(var prm: TTreeParams): integer;
         external 'Tree.dll' name 'TreeRefreshC';

// Заповнює строку виділення 'b0,b1,b2,b3,.....,bn'
function TreeSelectionsC(var prm: TTreeParams): integer;
         external 'Tree.dll' name 'TreeSelectionsC';

// Заповнює строку виділення ' b0 b1 b2 b3 ..... bn '
function TreeSelectionsSpaceC(var prm: TTreeParams): integer;
         external 'Tree.dll' name 'TreeSelectionsSpaceC';

// Перехід на гілку з SetGrpId
function TreeToGroupC(var prm: TTreeParams): integer;
         external 'Tree.dll' name 'TreeToGroupC';

// Показує (prm.Visible = true), або ховає (prm.Visible = false) дерево
function TreeHideShowC(var prm: TTreeParams): integer;
         external 'Tree.dll' name 'TreeHideShowC';

// Очистка пам'яті після закінчення роботи з деревом
function TreeRelaseC(var prm: TTreeParams): integer;
         external 'Tree.dll' name 'TreeRelaseC';

function BranchCDialog(grp_id: integer; prew_grp_id: integer;  resulted: PTGroupTreeNode; var prm: ZVelesInfoRec): integer;
         external 'tree.dll' name 'BranchCDialog';
//------------------------------------------------------------
// Створює дерево
function TreeCreateLC(var prm: TTreeParams): integer;
         external 'Tree.dll' name 'TreeCreateLC';

// Рефрешить дерево
function TreeRefreshLC(var prm: TTreeParams): integer;
         external 'Tree.dll' name 'TreeRefreshLC';

// Заповнює строку виділення 'b0,b1,b2,b3,.....,bn'
function TreeSelectionsLC(var prm: TTreeParams): integer;
         external 'Tree.dll' name 'TreeSelectionsLC';

// Заповнює строку виділення ' b0 b1 b2 b3 ..... bn '
function TreeSelectionsSpaceLC(var prm: TTreeParams): integer;
         external 'Tree.dll' name 'TreeSelectionsSpaceLC';

// Перехід на гілку з SetGrpId
function TreeToGroupLC(var prm: TTreeParams): integer;
         external 'Tree.dll' name 'TreeToGroupLC';

// Показує (prm.Visible = true), або ховає (prm.Visible = false) дерево
function TreeHideShowLC(var prm: TTreeParams): integer;
         external 'Tree.dll' name 'TreeHideShowLC';

// Очистка пам'яті після закінчення роботи з деревом
function TreeRelaseLC(var prm: TTreeParams): integer;
         external 'Tree.dll' name 'TreeRelaseLC';

implementation

end.
