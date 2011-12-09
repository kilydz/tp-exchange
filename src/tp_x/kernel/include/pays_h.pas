unit pays_h;

interface

uses etalon_dic, kernel_h, forms, uZToolButton;

procedure PayFormCreate(var fPays: TForm; var ibt_pays: ZToolButton; var idoc_form: TFetalon_dic; var iprm: ZVelesInfoRec);// stdcall;
    external 'pays.dll' name 'PayFormCreate';

procedure PayFormVisible(var fPays: TForm);// stdcall;
    external 'pays.dll' name 'PayFormVisible';

procedure PayFormRefresh(var fPays: TForm; idocument_id: integer);// stdcall;
    external 'pays.dll' name 'PayFormRefresh';

procedure PayFormFree(var fPays: TForm);// stdcall;
    external 'pays.dll' name 'PayFormFree';

implementation

end.
