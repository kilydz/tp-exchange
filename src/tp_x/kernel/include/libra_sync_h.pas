unit libra_sync_h;

interface

type
  ZScaleDialogResulted = record
     scale_id: integer;
     name: string;
     IP: string;
     type_scale: integer;
   end;
lpZScaleDialogResulted = ^ZScaleDialogResulted;

function LibraConnect(iport: integer; ispeed: integer; ilibra_num: byte): integer;   stdcall
    external 'libra.dll' name 'LibraConnect';

function LibraSWAdaptor: integer; stdcall
    external 'libra.dll' name 'LibraSWAdaptor';

function LibraProgrammingTovar(nomen_num: integer; name: PChar; price: real): integer;  stdcall
    external 'libra.dll' name 'LibraProgrammingTovar';

function LibraDisconnect(): integer;    stdcall
    external 'libra.dll' name 'LibraDisconnect';

implementation


end.
