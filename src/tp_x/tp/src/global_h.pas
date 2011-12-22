unit global_h;

interface

uses Variants, ComObj, Classes, IBHeader, IBDatabase, Forms;

const
    ini_file_name = 'tp21c.ini';
    log_file_name = 'tp21c.log';

type

TTPMode = (tpmError=-1, tpmCrash=0, tpmNormal=1, tpmRecovery=2, tplInit=3);

TParametersTP1C=record
  App: TApplication;
  AppWay: string;
  BaseTP_host: string;
  BaseTP_base: string;
  BaseTP_base_way: string;
  BaseTP_SYSDBApassword: string;

  Base1C_ole_name: string;
  Base1C_host: string;
  Base1C_base: string;
  Base1C_user: string;
  Base1C_password: string;

  modeTP: TTPMode;
  is_in_sync: boolean;

  sTP_base: TIBDatabase;
  s1C82_ole: olevariant;
  s1C82_knot: olevariant;

  lsteps: TList;
end;
lpTParametersTP1C = ^TParametersTP1C;



implementation

end.
