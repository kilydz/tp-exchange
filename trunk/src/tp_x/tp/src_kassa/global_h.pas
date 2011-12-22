unit global_h;

interface

uses Variants, ComObj, Classes, IBHeader, IBDatabase, Forms;

const
    ini_file_name = 'tp2kassa.ini';
    log_file_name = 'tp2kassa.log';

type

TParametersTPKassa=record
  App: TApplication;
  AppWay: string;

  BaseL_base: string;
  BaseL_base_way: string;
  BaseL_SYSDBApassword: string;

  is_in_sync: boolean;

  sL_base: TIBDatabase;
end;
lpTParametersTPKassa = ^TParametersTPKassa;



implementation

end.
