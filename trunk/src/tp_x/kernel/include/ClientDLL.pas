unit ClientDll;

interface
uses Forms, Controls, veles_h;

type
  TOnScrollClient = procedure(var TParamClient); //  ��� �-� ������� �� ��� ��
                                                      // ������� �볺���
  TParamClient = record
    sGen: ZVelesInfoRec;
    Parent: TWinControl;
    ParentTool: TWinControl;
    Form: TForm;
    OnScrollClient: TOnScrollClient;
    mode: integer;  // 0 - ���������, 1 - ����

    ClientID: integer;
    ClientName: array[0..63] of Char;
    Phone: array[0..24] of Char;
    ClientType: integer;
    IsPDV: integer;
    Flag: word;
    GrpC_id, State: integer;
    PropType: integer;
   end;

  TParamPerenosC = record
   sGen: ZVelesInfoRec;
   nid: AnsiString;
   GrpId: integer;
  end;

  TUnitClients = record
   sGen: ZVelesInfoRec;

   ClientId_0, ClientId_1: integer;
   ClientName_0, ClientName_1: string;
  end;

  TDelClient = record
   sGen: ZVelesInfoRec;

   ClientId: integer;
  end;

// ������ �볺���
function DicClient(var prm: TParamClient): integer;
         external 'Client.dll' name 'DicClient';

// ������ �볺���
function DicClientShow(var prm: TParamClient): integer;
         external 'Client.dll' name 'DicClientShow';

// ����������� �� ��������� ������ �볺���
function ClientEditor(var prm: TParamClient): integer;
         external 'Client.dll' name 'ClientEditor';

// ��� ��������� �� �볺���
function ClientDocList(var prm: TParamClient): integer;
         external 'Client.dll' name 'ClientDocList';

// ������� ���"�� ���� ������������ ������ �볺��� (����������, ���� Parent <> nil
//   �����, ���� ��������������� ������ - �������
function RalaseDicClient(var prm: TParamClient): integer;
         external 'Client.dll' name 'RalaseDicClient';

procedure ClientPerenos(var prm: TParamPerenosC);
         external 'Client.dll' name 'ClientPerenos';

procedure UnitClients(var prm: TUnitClients);
         external 'Client.dll' name 'UnitClients';

procedure DelClient(var prm: TDelClient);
         external 'Client.dll' name 'DelClient';

implementation

end.
