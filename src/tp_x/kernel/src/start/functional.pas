unit functional;

interface

uses IBHeader, SysUtils, veles_h, IBSQL, IBDatabase, DB, Forms, utils_h;

procedure RunTD10Correct(var adm_veles_info: ZVelesInfoRec);

implementation

procedure RunTD10Correct(var adm_veles_info: ZVelesInfoRec);
var
    base:           TIBDatabase;
    qr_R:           TIBSQL;
    tr_default:     TIBTransaction;
    dlg_mess:       string;

begin
    base:=TIBDatabase.Create(Application);
    qr_R:=TIBSQL.Create(Application);
    tr_default:=TIBTransaction.Create(Application);
    try
        try
            base.DefaultTransaction:=tr_default;
            tr_default.DefaultDatabase := base;
            qr_R.Database := base;
            qr_R.Transaction:=tr_default;
            base.SetHandle(adm_veles_info.db_handle);
            if tr_default.InTransaction then tr_default.Commit;
            tr_default.StartTransaction;
            qr_R.SQL.Text:='execute procedure PS_TD10_CORRECT';
            qr_R.ExecQuery;
            tr_default.Commit;
        except
            on E: Exception do
            begin
                if tr_default.InTransaction then tr_default.Rollback;
                ErrorDialog(E.Message, 'RunTD10Correct');
            end;
        end;
    finally
        base.Free;
        qr_R.Free;
        tr_default.Free;
    end;
end;

end.
