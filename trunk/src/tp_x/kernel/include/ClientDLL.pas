unit ClientDll;

interface
uses Forms, Controls, veles_h;

type
  TOnScrollClient = procedure(var TParamClient); //  Тип ф-ї реакції на рух по
                                                      // таблиці клієнтів
  TParamClient = record
    sGen: ZVelesInfoRec;
    Parent: TWinControl;
    ParentTool: TWinControl;
    Form: TForm;
    OnScrollClient: TOnScrollClient;
    mode: integer;  // 0 - Створення, 1 - Зміна

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

// Список клієнтів
function DicClient(var prm: TParamClient): integer;
         external 'Client.dll' name 'DicClient';

// Список клієнтів
function DicClientShow(var prm: TParamClient): integer;
         external 'Client.dll' name 'DicClientShow';

// Редагування та заведення нового клієнта
function ClientEditor(var prm: TParamClient): integer;
         external 'Client.dll' name 'ClientEditor';

// Рух документів по клієнту
function ClientDocList(var prm: TParamClient): integer;
         external 'Client.dll' name 'ClientDocList';

// Очистка пам"яті після використання списку клієнтів (виконується, якщо Parent <> nil
//   тобто, якщо використовується панель - власник
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
