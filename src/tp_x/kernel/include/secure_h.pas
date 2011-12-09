unit secure_h;

interface
uses kernel_h, IBExternals, IBHeader, IBSQL, IBDatabase, SysUtils, Forms,
zutils_h, utils_h;


const

ACCESS_TO_KERNEL                = 1;    // 001 Доступ до модуля

ACCESS_TO_USERS_DIC             = 30000;     // Доступ до довідника Користувачі
ACCESS_TO_ADD_USER              = 30001;     // Додавання нового користувача
ACCESS_TO_EDIT_USER             = 30002;     // Редагування користувача
ACCESS_TO_DEL_USER              = 30003;     // Видалення користувача
ACCESS_TO_ACTIVATE_USER         = 30004;     // Активація користувачів
ACCESS_TO_DEACTIVATE_USER       = 30005;     // Деактивація користувачів
ACCESS_TO_MODIFY_PASSWORDS      = 30006;     // Зміна паролів
ACCESS_TO_EXPORT_USERS          = 30007;     // Експорт даних довідника "Користувачі"

ACCESS_TO_ROLES_DIC             = 40000;     // Доступ до довідника Ролей
ACCESS_TO_ADD_ROLE              = 40001;     // Створення нової ролі
ACCESS_TO_EDIT_ROLE             = 40002;     // Редагування ролі
ACCESS_TO_DEL_ROLE              = 40003;     // Видалення ролі

ACCESS_TO_REPORTS_DIC           = 60000;     // Доступ до довідника Звіти


    ACCESS_TO_PRINT             = 100000;    // Друк
    ACCESS_TO_PRINT_PRICES_SQL  = 100100;    // Друк цінників по sql запросу
    ACCESS_TO_PRINT_INVOICE     = 100110;    // Друк накладних

    ACCESS_TO_DOCUMENTS         = 100200;    // Довідник "Документи"
    ACCESS_TO_DOCUMENT_INS_UPD  = 100201;    // Створення та редагування
    ACCESS_TO_DOCUMENT_DEL      = 100202;    // Видалення документа
    ACCESS_TO_DOCUMENTS_EXPORT  = 100208;    // Експорт довідника
    ACCESS_TO_DOCUMENT_EXPORT   = 100209;    // Експорт документа
    ACCESS_TO_DOCUMENT_FIX      = 100210;    // Фіксування документа
    ACCESS_TO_DOCUMENT_UNFIX    = 100211;    // Розфіксування документа
    ACCESS_TO_DOCUMENT_CLOUSE   = 100212;    // Відвантаження документа
    ACCESS_TO_DOCUMENT_UNCLOUSE = 100213;    // Зняття відвантаження
    ACCESS_TO_DOCUMENT_NOTARIZATION = 100214;   //Підтвердження істиності

    ACCESS_TO_NOMENS              = 100300;    // Довідник "Товари"
    ACCESS_TO_NOMEN_INS_UPD       = 100301;    // Створення та редагування товару
    ACCESS_TO_NOMEN_DEL           = 100302;    // Видалення товару
    ACCESS_TO_NOMEN_WATCH_MARKUP  = 100310;    // Бачити націнку в довіднику
    ACCESS_TO_NOMEN_WATCH_CZ_SZ   = 100311;    // Бачтит ЦЗ і СЗ
    ACCESS_TO_NOMENS_EXPORT       = 100312;    // Експорт довідника
    ACCESS_TO_NOMEN_WATCH_NOVISIBLE = 100313;  // Бачити "невидимий" товар
    ACCESS_TO_UPD_TYPE_NOMEN      = 100314;    // Редагувати тип товару
    ACCESS_TO_NOMEN_UNITE         = 100315;    //Об'єднувати товари

    ACCESS_TO_CLIENTS             = 100400;    // Довідник "Клієнти"
    ACCESS_TO_CLIENT_INS_UPD      = 100401;    // Створення та редагування клієнта
    ACCESS_TO_CLIENT_DEL          = 100402;    // Видалення клієнта
    ACCESS_TO_CLIENT_UNITE        = 120004;    // Об'єднання клієнтів

    ACCESS_TO_MARKUPS             = 100500;    // Довідник "Акти переоцінки"
    ACCESS_TO_MARKUP_DEL          = 100502;    // Видалення акту переоцынок

    ACCESS_TO_KARDS               = 100600;    // Довідник "Дисконт"
    ACCESS_TO_KARD_DEL            = 100602;    // Видалення дисконтних карток

    ACCESS_TO_REVISIONS           = 100700;    // Довідник "Ревізії"
    ACCESS_TO_REVISION_DEL        = 100702;    // Видалення ревізії
    ACCESS_TO_REVISION_EXPORT     = 100710;    // Експорт документа

    ACCESS_TO_AUTOORDERS          = 100800;    // Довідник "Автозамовлення"
    ACCESS_TO_AUTOORDER_DEL       = 100802;    // Видалення автозамовлення
    ACCESS_TO_AUTOORDER_EXPORT    = 100810;    // Експорт документа

    ACCESS_TO_PRODUCTION_DOCS             = 100900;    // Довідник "Документи виробництва"
    ACCESS_TO_PRODUCTION_DOC_INS_UPD      = 100901;    // Створення та редагування
    ACCESS_TO_PRODUCTION_DOC_DEL          = 100902;    // Видалення документа
    ACCESS_TO_PRODUCTION_DOCS_EXPORT      = 100908;    // Експорт довідника
    ACCESS_TO_PRODUCTION_DOC_EXPORT       = 100909;    // Експорт документа
    ACCESS_TO_PRODUCTION_DOC_FIX          = 100910;    // Фіксування документа
    ACCESS_TO_PRODUCTION_DOC_UNFIX        = 100911;    // Розфіксування документа
    ACCESS_TO_PRODUCTION_DOC_CLOUSE       = 100912;    // Відвантаження документа
    ACCESS_TO_PRODUCTION_DOC_UNCLOUSE     = 100913;    // Зняття відвантаження
    ACCESS_TO_PRODUCTION_DOC_NOTARIZATION = 100914;    //Підтвердження істиності

    ACCESS_TO_1C_EXPORT           = 900000;    // Експорт в 1С
    ACCESS_TO_1C_FINAL_EXPORT     = 900100;    // Робити кінцеву вигрузку
    ACCESS_TO_1C_SHOW_PERIODICS   = 900110;    // Бачити довідник періодів

    ACCESS_TO_NOMENS_OPTIMIZATION = 1001;     //Оптимізація асортименту

GUEST_GROUP_ID = 1;
ADMIN_GROUP_ID = 2;


    IBaseDLL = 'gds32.dll';

    sec_uid_spec =           $01;
    sec_gid_spec =           $02;
    sec_server_spec =        $04;
    sec_password_spec =      $08;
    sec_group_name_spec =    $10;
    sec_first_name_spec =    $20;
    sec_middle_name_spec =   $40;
    sec_last_name_spec =     $80;
    sec_dba_user_name_spec = $100;
    sec_dba_password_spec =  $200;

    sec_protocol_tcpip =     1;
    sec_protocol_netbeui =   2;
    sec_protocol_spx =       3;
    sec_protocol_local =     4;

type
    ISC_STATUS      = longint;
    LPISC_STATUS    = array[0..19] of ISC_STATUS;

    USER_SEC_DATA = record
        sec_flags: Smallint;	     { which fields are specified }
        uid: integer;       	     { the user's id }
        gid: integer;		         { the user's group id }
        protocol: integer;	         { protocol to use for connection }
        server: PChar;               { server to administer }
        user_name: PChar;            { the user's name }
        password: PChar;             { the user's password }
        group_name: PChar;           { the group name }
        first_name: PChar;   	     { the user's first name }
        middle_name: PChar;          { the user's middle name }
        last_name: PChar;    	     { the user's last name }
        dba_user_name: PChar;        { the dba user name }
        dba_password: PChar;         { the dba password }
    end;
    LPUSER_SEC_DATA = ^USER_SEC_DATA;

function isc_add_user(var status: LPISC_STATUS; var user_descr: USER_SEC_DATA): integer; stdcall;
function isc_delete_user(var status: LPISC_STATUS; var user_descr: USER_SEC_DATA): integer; stdcall;
function isc_modify_user(var status: LPISC_STATUS; var user_descr: USER_SEC_DATA): integer; stdcall;

function IB_AddUser(var adm_veles_info: ZVelesInfoRec; const user: string; const password: string): Longint;
function IB_ModifyUser(var adm_veles_info: ZVelesInfoRec; const user: string; const password: string): Longint;
function IB_DeleteUser(var adm_veles_info: ZVelesInfoRec; const user: string; const password: string): Longint;


function HasUserAccessEx(var a_prm: ZVelesInfoRec; const access_id: Integer; const showMessage: Boolean = true): Boolean;

function GetConfig(db_handle: TISC_DB_HANDLE; const a_config_id: integer; const a_module: string): string;

implementation


function isc_add_user; external IBaseDLL;
function isc_modify_user; external IBaseDLL;
function isc_delete_user; external IBaseDLL;


function HasUserAccessEx(var a_prm: ZVelesInfoRec; const access_id: Integer; const showMessage: Boolean = true): Boolean;
var
    base:           TIBDatabase;
    qr_R:           TIBSQL;
    tr_default:     TIBTransaction;
    dlg_mess:       string;
begin
  Result := True;
  Exit;
//  Result:=false;

  {$IFDEF NOACCESS}
    Result := true;
    exit;
  {$ENDIF}

    if (UpperCase(a_prm.user_name) = 'SYSDBA') then
    begin
        Result := true;
        exit;
    end;
    base:=TIBDatabase.Create(Application);
    qr_R:=TIBSQL.Create(Application);
    tr_default:=TIBTransaction.Create(Application);
    try
        try
            base.DefaultTransaction:=tr_default;
            tr_default.DefaultDatabase := base;
            qr_R.Database := base;
            qr_R.Transaction:=tr_default;
            base.SetHandle(a_prm.db_handle);
            if tr_default.InTransaction then tr_default.Commit;
            tr_default.StartTransaction;
            qr_R.SQL.Text:='select oresult, oaccess_name from PA_HAS_USER_ACCESS(:iuser_id, :iaccess_id)';
            qr_R.ParamByName('iuser_id').AsInteger := a_prm.user_id;
            qr_R.ParamByName('iaccess_id').AsInteger := access_id;
            qr_R.ExecQuery;

            if qr_R.FieldByName('oresult').AsInteger > 0 then
                Result:=true
            else
              if showMessage then
                GMessageBox(PChar('У Вас відсутнє право на: '+qr_R.FieldByName('oaccess_name').AsString), 'OK');

            tr_default.Commit;
        except
            on E: Exception do
            begin
                if tr_default.InTransaction then tr_default.Rollback;
                ErrorDialog(E.Message, 'IB_HasUserRight');
            end;
        end;
    finally
        base.Free;
        qr_R.Free;
        tr_default.Free;
    end;
end;//HasUserAccessEx


function IB_AddUser(var adm_veles_info: ZVelesInfoRec; const user: string; const password: string): Longint;
var
    status:         LPISC_STATUS;
    user_descr:     USER_SEC_DATA;

begin
    user_descr.dba_user_name := 'SYSDBA';
    user_descr.dba_password := adm_veles_info.SYSDBA_password;
    //!!! ОТУТ ТРЕБА ЗНАТИ ЯКИЙ ПРОТОКОЛ - ТРЕБА ПРОСТО ВКАЗУВАТИ В ІНІ ФАЙЛІ ServerIP=127.0.0.1
    user_descr.protocol := sec_protocol_tcpip;
    //user_descr.protocol := sec_protocol_local;
    user_descr.server := adm_veles_info.server_ip;
    user_descr.sec_flags := sec_password_spec + sec_dba_user_name_spec +
          sec_dba_password_spec;
    user_descr.user_name := PChar(user);
    user_descr.password := PChar(password);
    isc_add_user(status, user_descr);
    if (status[0] = 1) and (status[1] <> 0) then
    begin
        raise Exception.Create(Format('Помилка роботи функції isc_add_user %d',
                         [status[1]]));
    end;
    Result:=0;
end;

function IB_ModifyUser(var adm_veles_info: ZVelesInfoRec; const user: string; const password: string): Longint;
var
    status:         LPISC_STATUS;
    user_descr:     USER_SEC_DATA;

begin
    user_descr.dba_user_name := 'SYSDBA';
    user_descr.dba_password := adm_veles_info.SYSDBA_password;
    //!!! ОТУТ ТРЕБА ЗНАТИ ЯКИЙ ПРОТОКОЛ - ТРЕБА ПРОСТО ВКАЗУВАТИ В ІНІ ФАЙЛІ ServerIP=127.0.0.1
    user_descr.protocol := sec_protocol_tcpip;
    //user_descr.protocol := sec_protocol_local;
    user_descr.server := adm_veles_info.server_ip;
    user_descr.sec_flags := sec_password_spec + sec_dba_user_name_spec +
          sec_dba_password_spec;
    user_descr.user_name := PChar(user);
    user_descr.password := PChar(password);
    isc_modify_user(status, user_descr);
    if (status[0] = 1) and (status[1] <> 0) then
    begin
        raise Exception.Create(Format('Помилка роботи функції isc_modify_user %d',
                         [status[1]]));
    end;
    Result:=0;
end;

function IB_DeleteUser(var adm_veles_info: ZVelesInfoRec; const user: string; const password: string): Longint;
var
    status:         LPISC_STATUS;
    user_descr:     USER_SEC_DATA;

begin
    user_descr.dba_user_name := 'SYSDBA';
    user_descr.dba_password := adm_veles_info.SYSDBA_password;
    //!!! ОТУТ ТРЕБА ЗНАТИ ЯКИЙ ПРОТОКОЛ - ТРЕБА ПРОСТО ВКАЗУВАТИ В ІНІ ФАЙЛІ ServerIP=127.0.0.1 
    user_descr.protocol := sec_protocol_tcpip;
    //user_descr.protocol := sec_protocol_local;
    user_descr.server := adm_veles_info.server_ip;
    user_descr.sec_flags := sec_password_spec + sec_dba_user_name_spec +
          sec_dba_password_spec;
    user_descr.user_name := PChar(user);
    user_descr.password := PChar(password);
    isc_delete_user(status, user_descr);
    if (status[0] = 1) and (status[1] <> 0) then
    begin
        raise Exception.Create(Format('Помилка роботи функції isc_delete_user %d',
                         [status[1]]));
    end;
    Result:=0;
end;

function GetConfig(db_handle: TISC_DB_HANDLE; const a_config_id: integer; const a_module: string): string;
var
    base:           TIBDatabase;
    qr_R:           TIBSQL;
    tr_default:     TIBTransaction;

begin
    Result := '';
    base:=TIBDatabase.Create(Application);
    qr_R:=TIBSQL.Create(Application);
    tr_default:=TIBTransaction.Create(Application);
    try
        try
            base.DefaultTransaction:=tr_default;
            tr_default.DefaultDatabase:=base;
            qr_R.Database:=base;
            qr_R.Transaction:=tr_default;
            base.SetHandle(db_handle);
            if tr_default.InTransaction then tr_default.Commit;
            tr_default.StartTransaction;
            qr_R.SQL.Text:='SELECT marker FROM t_configs WHERE config_id = :iconfig_id and module = :imodule';
            qr_R.ParamByName('iconfig_id').AsInteger := a_config_id;
            qr_R.ParamByName('imodule').AsString := a_module;
            qr_R.ExecQuery;
            Result := qr_R.FieldByName('marker').AsString;
            tr_default.Commit;
        except
            on E: Exception do
            begin
                if tr_default.InTransaction then tr_default.Rollback;
                ErrorDialog(E.Message, 'GetConfig');
            end;
        end;
    finally
        base.Free;
        qr_R.Free;
        tr_default.Free;
    end;
end;//GetConfig

end.