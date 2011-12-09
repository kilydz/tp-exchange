unit zvit_h;

interface
uses kernel_h;

type
  sManagerZvit = record
    sGen: ZVelesInfoRec;

    date1, date2: array [0..24] of Char;

   end;

  sClientZvit = record
//    sGen: ZVelesInfoRec;

    date1, date2: array [0..24] of Char;
    group_id: integer;
    groupC_id: integer;

    Client: boolean;
    ClientAll: boolean;
    ClientList: PChar;
   end;

  sPDVZvit = record
//    sGen: ZVelesInfoRec;

    date1, date2: array [0..24] of Char;
    group_id: integer;
   end;

  TMoveGoodsPrm = record
   sGen: ZVelesInfoRec;
  end;

function DoClientZvit(var prm: sClientZvit): integer;
          external 'ClientZvit.dll' name 'DoClientZvit';

function DoPDVZvit(var prm: sPDVZvit): integer;
          external 'PDVZvit.dll' name 'DoPDVZvit';

implementation

end.
