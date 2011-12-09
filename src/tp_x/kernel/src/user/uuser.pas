unit uuser;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, etalon_dlg, dxCntner, IBSQL, IBDatabase, DB, ComCtrls, uZMaster,
  secure_h, kernel_h, utils_h, ExtCtrls, StdCtrls, dxEditor, dxEdLib,
  dxExEdtr, user_h, genstor_h, IBServices, Zutils_h;

const
    GUEST_GRP_ID_STR = '1';

type
  Tfuser = class(Tfetalon_dlg)
    tab_sheet_0: TTabSheet;
    tab_sheet_1: TTabSheet;
    tab_sheet_2: TTabSheet;
    page_1: TPanel;
    ed_rights_grp: TdxImageEdit;
    Label3: TLabel;
    secure_service: TIBSecurityService;
    page_2: TPanel;
    Label7: TLabel;
    Label8: TLabel;
    Label9: TLabel;
    Label4: TLabel;
    Label5: TLabel;
    ed_login: TdxEdit;
    ed_keyword: TdxEdit;
    ed_confirm: TdxEdit;
    ed_signature: TdxEdit;
    ed_signature_confirm: TdxEdit;
    ed_nick: TdxEdit;
    Label6: TLabel;
    page_0: TPanel;
    Label1: TLabel;
    Label2: TLabel;
    Label10: TLabel;
    ed_surname: TdxEdit;
    ed_first_name: TdxEdit;
    ed_second_name: TdxEdit;
  private
    { Private declarations }
    function IsUserLoginUnique(const a_user_login: string): Boolean;
    function IsUserNickUnique(const a_user_nick: string): Boolean;
    function IsUserSignatureUnique(const a_user_signature: string): Boolean;
    procedure RightsGrpClear;
    procedure RightsGrpInit;
  public
    { Public declarations }
    resulted: ZUserDlgResulted;

    procedure InitINS; override;
    procedure InitUPD; override;
    procedure InitControls; override;

    function  AnalizChanges: Integer; override;

    procedure ApplyChanges; override;
    procedure ApplyControls; override;
    procedure ApplyINS; override;
    procedure ApplyUPD; override;
  end;

function UserDialog(id: Integer; resulted: lpZUserDlgResulted;
    var prm: ZVelesInfoRec): Integer;

implementation

{$R *.dfm}

function UserDialog(id: Integer; resulted: lpZUserDlgResulted;
    var prm: ZVelesInfoRec): Integer;
var
  dlg: Tfuser;

begin
    Result:=0;
    if id > 0 then
    begin
        if not HasUserAccessEx(prm, ACCESS_TO_EDIT_USER) then
            Exit;
    end
    else begin
        if not HasUserAccessEx(prm, ACCESS_TO_ADD_USER) then
            Exit;
    end;

    // Створення та ініціалізація форми діалогу.
    dlg := Tfuser.Create(Application);
    try
        dlg.id.id := id;
        dlg.prm := prm;
        dlg.resulted := resulted^;
        dlg.InitInfo;
        // Візуалізація діалогу

        if dlg.ShowModal = mrOk then
        begin
            resulted^ := dlg.resulted;
            Result := dlg.resulted.id;
        end;
    finally
        dlg.Free;
    end;
    //    returned <= 0 - код помилки, або відмова;
    //    returned > 0  - id результату;
end;

{ Tfuser }

function Tfuser.AnalizChanges: Integer;
begin
    Result:=0;
    if ed_surname.Text = '' then
    begin
        GMessageBox('Не введено прізвище користувача', 'OK');
        master.PageIndex:=2;
        ed_surname.SetFocus;
        Result:=-1;
    end
    else if ed_nick.Text = '' then
    begin
        GMessageBox('Не введено нік користувача', 'OK');
        master.PageIndex:=0;
        ed_nick.SetFocus;
        Result:=-1;
    end
    else if not IsUserNickUnique(ed_nick.Text) then
    begin
        GMessageBox(PChar('Користувач з ніком ' + ed_nick.Text +
            ' вже існує. Введіть інший нік'), 'OK');
        master.PageIndex:=0;
        ed_nick.SetFocus;
        Result:=-1;
    end
    else if ed_login.Text = '' then
    begin
        GMessageBox('Не введено логін користувача', 'OK');
        master.PageIndex:=0;
        ed_login.SetFocus;
        Result:=-1;
    end
    else if not IsEngStr(ed_login.Text) then
    begin
        GMessageBox('Логін повинен містити лише англійські літери', 'OK');
        master.PageIndex:=0;
        ed_login.SetFocus;
        Result:=-1;
    end
    else if ed_keyword.Text = '' then
    begin
        GMessageBox('Не введено пароль користувача', 'OK');
        master.PageIndex:=0;
        ed_keyword.SetFocus;
        Result:=-1;
    end
    else if not IsEngStr(ed_keyword.Text) then
    begin
        GMessageBox('Пароль повинен містити лише англійські літери', 'OK');
        master.PageIndex:=0;
        ed_keyword.SetFocus;
        Result:=-1;
    end
    else if ed_confirm.Text = '' then
    begin
        GMessageBox('Не введено підтвердження пароля', 'OK');
        master.PageIndex:=0;
        ed_confirm.SetFocus;
        Result:=-1;
    end
    else if not IsEngStr(ed_confirm.Text) then
    begin
        GMessageBox('Підтвердження пароля повинно містити лише англійські літери', 'OK');
        master.PageIndex:=0;
        ed_confirm.SetFocus;
        Result:=-1;
    end
    else if ed_keyword.Text <> ed_confirm.Text then
    begin
        GMessageBox('Підтвердження пароля не відповідає паролю', 'OK');
        master.PageIndex:=0;
        ed_confirm.SetFocus;
        Result:=-1;
    end
    else if (resulted.id <= 0)and(not IsUserLoginUnique(ed_login.Text)) then
    begin
        GMessageBox(PChar('Користувач з логіном ' + ed_login.Text +
            ' вже існує. Введіть інший логін'), 'OK');
        master.PageIndex:=0;
        ed_login.SetFocus;
        Result:=-1;
    end
    // Перевірка цифрового підпису
    else if (ed_signature_confirm.Text = '')and(ed_signature.Text <> '') then
    begin
        GMessageBox('Не введено підтвердження цифрового підпису', 'OK');
        master.PageIndex:=0;
        ed_signature_confirm.SetFocus;
        Result:=-1;
    end
    else if ed_signature.Text <> ed_signature_confirm.Text then
    begin
        GMessageBox('Підтвердження цифрового підпису не відповідає цифровому підпису', 'OK');
        master.PageIndex:=0;
        ed_signature_confirm.SetFocus;
        Result:=-1;
    end
    else if (ed_signature.Text <> '')and(not IsUserSignatureUnique(ed_signature.Text)) then
    begin
        GMessageBox(PChar('Користувач з введеним числовим підписом вже існує. Введіть інший цифровий підпис'), 'OK');
        master.PageIndex:=0;
        ed_signature.SetFocus;
        Result:=-1;
    end;
end;//Tfuser.AnalizChanges

procedure Tfuser.ApplyChanges;
begin
    inherited;
    //нічого не робимо - немає потреби
end;

procedure Tfuser.ApplyControls;
begin
    inherited;
    resulted.nick         :=  ed_nick.Text;
    resulted.login        :=  ed_login.Text;
    resulted.keyword      :=  ed_keyword.Text;
    resulted.signature    :=  ed_signature.Text;
    resulted.surname      :=  ed_surname.Text;
    resulted.first_name   :=  ed_first_name.Text;
    resulted.second_name  :=  ed_second_name.Text;
    resulted.rights_grp_id:=  StrToInt(ed_rights_grp.Text);
end;

procedure Tfuser.ApplyINS;
begin
    inherited;
    try
        if trW.InTransaction then trW.Commit;
        trW.StartTransaction;
        qW.SQL.Text:='SELECT oid FROM pa_user_ins_v1(:ilogin, :ikeyword, ' +
            ':irights_grp_id, :isurname, :ifirst_name, :isecond_name, :inick, :isignature)';
        qW.ParamByName('ilogin').AsString           := resulted.login;
        qW.ParamByName('ikeyword').AsString         := resulted.keyword;
        qW.ParamByName('irights_grp_id').AsInteger  := resulted.rights_grp_id;
        qW.ParamByName('isurname').AsString         := resulted.surname;
        qW.ParamByName('ifirst_name').AsString      := resulted.first_name;
        qW.ParamByName('isecond_name').AsString     := resulted.second_name;
        qW.ParamByName('inick').AsString            := resulted.nick;
        qW.ParamByName('isignature').AsString       := resulted.signature;
        qW.ExecQuery;
        resulted.id   := qW.FieldByName('oid').AsInteger;
        trW.Commit;
    except
        on E: Exception do
        begin
            if trW.InTransaction then trW.Rollback;
            ErrorDialog(E.Message, 'Tfuser.ApplyINS');
        end;
    end;
end;

procedure Tfuser.ApplyUPD;
begin
    inherited;
    try
        if trW.InTransaction then trW.Commit;
        trW.StartTransaction;
        qW.SQL.Text:= '  update t_users u '+
                      '     set u.user_login        = :ilogin, '+
                      '         u.user_keyword      = :ikeyword, '+
                      '         u.rights_grp_id     = :irights_grp_id, '+
                      '         u.user_surname      = :isurname, '+
                      '         u.user_first_name   = :ifirst_name, '+
                      '         u.user_second_name  = :isecond_name, '+
                      '         u.nick              = :inick, '+
                      '         u.signature         = :isignature '+
                      '   where u.user_id           = :iid';
        qW.ParamByName('iid').AsInteger             := resulted.id;
        qW.ParamByName('ilogin').AsString           := resulted.login;
        qW.ParamByName('ikeyword').AsString         := resulted.keyword;
        qW.ParamByName('irights_grp_id').AsInteger  := resulted.rights_grp_id;
        qW.ParamByName('isurname').AsString         := resulted.surname;
        qW.ParamByName('ifirst_name').AsString      := resulted.first_name;
        qW.ParamByName('isecond_name').AsString     := resulted.second_name;
        qW.ParamByName('inick').AsString            := resulted.nick;
        qW.ParamByName('isignature').AsString       := resulted.signature;
        qW.ExecQuery;
        trW.Commit;
        //якщо користувач немає права змінювати паролі, то нема що і модифікувати
        if (resulted.id > 0)and(ed_keyword.Enabled)and(resulted.state = 1) then
        begin
          secure_service.ServerName := prm.server_ip;
          secure_service.Protocol := TProtocol(TCP);
          secure_service.Params.Clear;
          secure_service.Params.Values['user_name'] := 'SYSDBA';
          secure_service.Params.Values['password'] := prm.SYSDBA_password;
          secure_service.Active := true;
          secure_service.UserName := resulted.login;
          secure_service.Password := resulted.keyword;
          secure_service.FirstName := '';
          secure_service.MiddleName := '';
          secure_service.LastName := '';
          secure_service.SecurityAction := ActionAddUser;
          secure_service.ModifyUser;
          secure_service.Active := false;
        end;
        //якщо не перевірити чи активований користувач (тобто resulted.state = 1)
        //буде помилка
    except
        on E: Exception do
        begin
            if trW.InTransaction then trW.Rollback;
            ErrorDialog(E.Message, 'Tfuser.ApplyUPD');
        end;
    end;
end;

procedure Tfuser.InitControls;
begin
    inherited;
    RightsGrpInit;
    if id.id > 0 then//редагування користувача
    begin
        ed_surname.Text     := resulted.surname;
        ed_first_name.Text  := resulted.first_name;
        ed_second_name.Text := resulted.second_name;
        ed_rights_grp.Text  := IntToStr(resulted.rights_grp_id);
        ed_nick.Text        := resulted.nick;
        ed_login.Text       := resulted.login;
        ed_signature.Text   := resulted.signature;
        ed_signature_confirm.Text := resulted.signature;
        //ed_login.Enabled:=false;
        ed_login.ReadOnly   := true;
        ed_keyword.Text     := resulted.keyword;
        ed_confirm.Text     := resulted.keyword;
        if not HasUserAccessEx(prm, ACCESS_TO_MODIFY_PASSWORDS) then
        begin
            //ed_keyword.Enabled:=false;
            //ed_confirm.Enabled:=false;
            ed_keyword.ReadOnly:=true;
            ed_confirm.ReadOnly:=true;
        end;
    end
    else begin//новий користувача
        ed_rights_grp.Text:=GUEST_GRP_ID_STR;
    end;
end;

procedure Tfuser.InitINS;
begin
    inherited;
    Caption:=' Новий користувач';
    resulted.id:=-1;
end;

procedure Tfuser.InitUPD;
begin
    inherited;
    Caption:=' Редагування користувача';
    try
        if trR.InTransaction then trR.Commit;
        trR.StartTransaction;
        qR.SQL.Text:='SELECT p.oid, p.osurname, p.ofirst_name, p.osecond_name, ' +
                     '       p.ologin, p.okeyword, p.orights_grp_id, p.onick, u.signature '+
                     '  FROM pa_user_view(:iuser_id) p left join t_users u on p.oid = u.user_id';
        qR.ParamByName('iuser_id').AsInteger:=id.id;
        qR.ExecQuery;
        resulted.id           := qR.FieldByName('oid').AsInteger;
        resulted.surname      := qR.FieldByName('osurname').AsString;
        resulted.first_name   := qR.FieldByName('ofirst_name').AsString;
        resulted.second_name  := qR.FieldByName('osecond_name').AsString;
        resulted.rights_grp_id:= qR.FieldByName('orights_grp_id').AsInteger;
        resulted.nick         := qR.FieldByName('onick').AsString;
        resulted.login        := qR.FieldByName('ologin').AsString;
        resulted.keyword      := qR.FieldByName('okeyword').AsString;
        resulted.signature    := qR.FieldByName('signature').AsString;
        trR.Commit;
    except
        on E: Exception do
        begin
            if trR.InTransaction then trR.Rollback;
            ErrorDialog(E.Message, 'Tfuser.InitUPD');
        end;
    end;
end;//Tfuser.InitUPD

procedure Tfuser.RightsGrpClear;
begin
    ed_rights_grp.Descriptions.Clear;
    ed_rights_grp.Values.Clear;    
end;

procedure Tfuser.RightsGrpInit;
begin
    try
        RightsGrpClear;

        if trR.InTransaction then trR.Commit;
        trR.StartTransaction;
        qR.SQL.Text:='SELECT right_grp_id, name FROM t_rights_grp ORDER BY right_grp_id';
        qR.ExecQuery;
        while not qR.Eof do
        begin
            ed_rights_grp.Descriptions.Add(qR.FieldByName('name').AsString);
            ed_rights_grp.Values.Add(qR.FieldByName('right_grp_id').AsString);
            qR.Next;
        end;
        if trR.InTransaction then trR.Commit;
    except
        on E: Exception do
        begin
            if trR.InTransaction then trR.Rollback;
            ErrorDialog(E.Message, 'Tfuser.RightsGrpInit');
        end;
    end;
end;

//вертає true якщо користувач a_user_login вже існує, інакше вертає false;
function Tfuser.IsUserLoginUnique(const a_user_login: string): Boolean;
begin
    Result:=false;
    try
        if trR.InTransaction then trR.Commit;
        trR.StartTransaction;
        qR.SQL.Text:='SELECT user_id FROM t_users WHERE user_login = :user_login';
        qR.ParamByName('user_login').AsString:=a_user_login;
        qR.ExecQuery;
        if qR.RecordCount = 0 then
        begin
            Result:=true;
        end;
        if trR.InTransaction then trR.Commit;
    except
        on E: Exception do
        begin
            if trR.InTransaction then trR.Rollback;
            ErrorDialog(E.Message, 'Tfuser.IsUserLoginUnique');
        end;
    end;
end;

//вертає true якщо користувач з цифровим підписом a_user_signature вже існує, інакше вертає false;
function Tfuser.IsUserSignatureUnique(const a_user_signature: string): Boolean;
begin
 // Result:=true;
    Result:=false;
    try
        if trR.InTransaction then trR.Commit;
        trR.StartTransaction;
        qR.SQL.Text:='SELECT user_id FROM t_users WHERE signature = :isignature '+
                     ' and user_id !='+IntToStr(resulted.id);;
        qR.ParamByName('isignature').AsString:=a_user_signature;
        qR.ExecQuery;
        if qR.RecordCount = 0 then
        begin
            Result:=true;
        end;
        if trR.InTransaction then trR.Commit;
    except
        on E: Exception do
        begin
            if trR.InTransaction then trR.Rollback;
            ErrorDialog(E.Message, 'Tfuser.IsUserSignatureUnique');
        end;
    end;
end;

//вертає true якщо користувач з ніком a_user_nick вже існує, інакше вертає false;
function Tfuser.IsUserNickUnique(const a_user_nick: string): Boolean;
begin
    Result:=false;
    try
        if trR.InTransaction then trR.Commit;
        trR.StartTransaction;
        qR.SQL.Text:='SELECT user_id FROM t_users WHERE nick = :inick '+
                        ' and user_id !='+IntToStr(resulted.id);
        qR.ParamByName('inick').AsString:=a_user_nick;
        qR.ExecQuery;
        if qR.RecordCount = 0 then
        begin
            Result:=true;
        end;
        if trR.InTransaction then trR.Commit;
    except
        on E: Exception do
        begin
            if trR.InTransaction then trR.Rollback;
            ErrorDialog(E.Message, 'Tfuser.IsUserNickUnique');
        end;
    end;
end;

end.
