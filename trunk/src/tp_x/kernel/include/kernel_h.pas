unit kernel_h;

interface

uses IBHeader, Controls, uZClasses, Messages;

const
    UM_REFRESH_DIC = WM_USER + 1;
    // ���������, � ���� ������� ������ ����� �� �������� �����;
    WAY_INI     = 'tuning\ini\';
    WAY_IMAGES  = 'tuning\images\';
    WAY_LOG     = 'tuning\log\';
    WAY_FRF     = 'tuning\print\';

    WAY_BIN     = 'veles\';


    //���� ��� ����� ��������� ������ ������������� � ������ (�����)
    //���������� (���.�����), ������ ���� �������;
    FREE_PAGE_PROC_NAME = 'FreePage';
    SHOW_PAGE_FUNC_NAME = 'ShowPage';

    SHOW_PLUGIN_PROC_NAME = 'ShowPlugin';

    //�������� �� ����� ������� TGetStartResult (���. �����)
    RESULT_OK = 0;
    RESULT_FAIL = 1;
    RESULT_CANCEL = 2;

    xml_EXTENTION = '.XML';
    CRYPT_EXTENTION = '.XCR';

    //������ ����
    ACCESS_TO_PROGRAM           = 1;         //���� � ��������

    GUEST_GROUP_ID              = 1;         //��������������� � Tfuser.InitInfo
    SYSTEM_GROUPS_LIMIT         = 100;       //��������������� � ����� �����������
    ADMIN_GROUP_ID              = 2;         //��������������� � �������� ����� ������������

    ACCESS_TO_USERS_DIC         = 30000;     //������ �� �������� �����������
    ACCESS_TO_ADD_USER          = 30001;     //��������� ������ �����������
    ACCESS_TO_EDIT_USER         = 30002;     //����������� �����������
    ACCESS_TO_DEL_USER          = 30003;     //��������� �����������
    ACCESS_TO_ACTIVATE_USER     = 30004;     //��������� �����������
    ACCESS_TO_DEACTIVATE_USER   = 30005;     //����������� �����������
    ACCESS_TO_MODIFY_PASSWORDS  = 30006;     //���� ������
    ACCESS_TO_EXPORT_USERS      = 30007;     //������� ����� �������� "�����������"

    ACCESS_TO_GROUPS_DIC        = 40000;     //������ �� �������� ����� ������������
    ACCESS_TO_ADD_GROUP         = 40001;     //��������� ���� �����
    ACCESS_TO_EDIT_GROUP        = 40002;     //����������� �����
    ACCESS_TO_DEL_GROUP         = 40003;     //��������� �����

    ACCESS_TO_BACKUP_DIC        = 50000;     //������ �� �������� ���������
    ACCESS_TO_ADD_BACKUP        = 50001;     //����� ���������� ������ ���������
    ACCESS_TO_EDIT_BACKUP       = 50004;     //����� ���������� ������ ���������
    ACCESS_TO_DEL_BACKUP        = 50002;     //����� �������� ������ ���������
    ACCESS_TO_EXPORT_BACKUPS    = 50003;     //������� ����� �������� "���������"
    ACCESS_TO_MAKE_BACKUPS      = 50005;     //����� ���������� ���������

    ACCESS_TO_REPORTS_DIC       = 60000;     //������ �� �������� ����

    ACCESS_TO_UNBLOCK           = 1000001;   // ������� "��������������"

    ACCESS_TO_CONFIGS_DIC       = 70000;     //������ �� �������� "������������"
    ACCESS_TO_ADD_CONFIG        = 70001;     //��������� ���� ������������
    ACCESS_TO_EDIT_CONFIG       = 70002;     //����������� ������������
    ACCESS_TO_DEL_CONFIG        = 70003;     //��������� ������������

    ACCESS_TO_PRINT             = 100000;    // ����
    ACCESS_TO_PRINT_PRICES_SQL  = 100100;    // ���� ������� �� sql �������
    ACCESS_TO_PRINT_INVOICE     = 100110;    // ���� ���������

    ACCESS_TO_DOCUMENTS         = 100200;    // ������� "���������"
    ACCESS_TO_DOCUMENT_INS_UPD  = 100201;    // ��������� �� �����������
    ACCESS_TO_DOCUMENT_DEL      = 100202;    // ��������� ���������
    ACCESS_TO_DOCUMENTS_EXPORT  = 100208;    // ������� ��������
    ACCESS_TO_DOCUMENT_EXPORT   = 100209;    // ������� ���������
    ACCESS_TO_DOCUMENT_FIX      = 100210;    // Գ�������� ���������
    ACCESS_TO_DOCUMENT_UNFIX    = 100211;    // ������������� ���������
    ACCESS_TO_DOCUMENT_CLOUSE   = 100212;    // ³����������� ���������
    ACCESS_TO_DOCUMENT_UNCLOUSE = 100213;    // ������ ������������
    ACCESS_TO_DOCUMENT_NOTARIZATION = 100214;   //ϳ����������� ��������

    ACCESS_TO_NOMENS              = 100300;    // ������� "������"
    ACCESS_TO_NOMEN_INS_UPD       = 100301;    // ��������� �� ����������� ������
    ACCESS_TO_NOMEN_DEL           = 100302;    // ��������� ������
    ACCESS_TO_NOMEN_WATCH_MARKUP  = 100310;    // ������ ������� � ��������
    ACCESS_TO_NOMEN_WATCH_CZ_SZ   = 100311;    // ������ �� � ��
    ACCESS_TO_NOMENS_EXPORT       = 100312;    // ������� ��������
    ACCESS_TO_NOMEN_WATCH_NOVISIBLE = 100313;  // ������ "���������" �����
    ACCESS_TO_UPD_TYPE_NOMEN      = 100314;    // ���������� ��� ������
    ACCESS_TO_NOMEN_UNITE         = 100315;    //��'�������� ������

    ACCESS_TO_CLIENTS             = 100400;    // ������� "�볺���"
    ACCESS_TO_CLIENT_INS_UPD      = 100401;    // ��������� �� ����������� �볺���
    ACCESS_TO_CLIENT_DEL          = 100402;    // ��������� �볺���
    ACCESS_TO_CLIENT_UNITE        = 120004;    // ��'������� �볺���

    ACCESS_TO_MARKUPS             = 100500;    // ������� "���� ����������"
    ACCESS_TO_MARKUP_DEL          = 100502;    // ��������� ���� ����������

    ACCESS_TO_KARDS               = 100600;    // ������� "�������"
    ACCESS_TO_KARD_DEL            = 100602;    // ��������� ���������� ������

    ACCESS_TO_REVISIONS           = 100700;    // ������� "���糿"
    ACCESS_TO_REVISION_DEL        = 100702;    // ��������� ���糿
    ACCESS_TO_REVISION_EXPORT     = 100710;    // ������� ���������

    ACCESS_TO_AUTOORDERS          = 100800;    // ������� "��������������"
    ACCESS_TO_AUTOORDER_DEL       = 100802;    // ��������� ��������������
    ACCESS_TO_AUTOORDER_EXPORT    = 100810;    // ������� ���������

    ACCESS_TO_PRODUCTION_DOCS             = 100900;    // ������� "��������� �����������"
    ACCESS_TO_PRODUCTION_DOC_INS_UPD      = 100901;    // ��������� �� �����������
    ACCESS_TO_PRODUCTION_DOC_DEL          = 100902;    // ��������� ���������
    ACCESS_TO_PRODUCTION_DOCS_EXPORT      = 100908;    // ������� ��������
    ACCESS_TO_PRODUCTION_DOC_EXPORT       = 100909;    // ������� ���������
    ACCESS_TO_PRODUCTION_DOC_FIX          = 100910;    // Գ�������� ���������
    ACCESS_TO_PRODUCTION_DOC_UNFIX        = 100911;    // ������������� ���������
    ACCESS_TO_PRODUCTION_DOC_CLOUSE       = 100912;    // ³����������� ���������
    ACCESS_TO_PRODUCTION_DOC_UNCLOUSE     = 100913;    // ������ ������������
    ACCESS_TO_PRODUCTION_DOC_NOTARIZATION = 100914;    //ϳ����������� ��������

    ACCESS_TO_1C_EXPORT           = 900000;    // ������� � 1�
    ACCESS_TO_1C_FINAL_EXPORT     = 900100;    // ������ ������ ��������
    ACCESS_TO_1C_SHOW_PERIODICS   = 900110;    // ������ ������� ������

type
    //ZContainerId = class(ZContainerId)
    //end;
    // ���������, �� ���������� � ������� ����������� ������.
    // ���� id <= 0 �� ����� �����������, ������ ����������.
    // ���� �������������� ������ ����������������� � ���������
    // ��������
    ZFuncArgs = record
        id: integer;
        id1: string;
        id2: string;
        id3: string;
        id4: string;
    end;

    //��������� �� ���������� ������� ����� �������� (����);
    //���������������� � ��������� � �������� TShowPage;
    ZControlPointers = record
        form,                         //TForm
        panel_ptr,                    //TPanel
        menu_ptr,                     //TMainMenu
        side_bar_ptr,                 //TdxSideBar
        status_bar_ptr,               //TStatusBar
        caption_ptr,                  //TPanel
        module_manager:       Pointer;//XModuleManager
    end;

    //���������, ����� ������ ��������� ����������
    ZCustom_data = record
        DateLife:     TDateTime;        //��� �� ��������
        DateOfDeath : TDateTime;        //���� ���������� ����糿
//        code_dealer: Integer;
        pcode_dealer: ^Integer;
    end;

    //���������, �� ������ ���������� ��� ��������, ��� ���������� �������
    //�� �������� ������� TShowPage; ����� �� ���� ������������ � ���;
    //���� � �������� TGetFuncResult;
    ZVelesInfoRec = record
        custom_data:      ZCustom_data;
        // ������ �����
        prog_way,
        root_way,
        server_ip,
        base_way,
        security_way:     array[0..255] of char;
        //reports_way,
        ini_way:          array[0..255] of char;

        //������ ������������
        version:     Integer;
        app_name:    array[0..255] of char;
        app_handle:  THandle;
        base:        Pointer;//TIBDatabase
        db_handle:   TISC_DB_HANDLE;

        // ����� �����������
        user_id:          Integer;
        user_name,
        user_password,
        SYSDBA_password:  array[0..255] of char;

        control_pointers: ZControlPointers;
    end;

//*******************************procedures*************************************
    //��������� �� ����� ���� ������������, ��������� �� ���������� � �������
    //(������) � �� ��������� ���� ����������� ��������� �� �������� �������
    //(������ ������� ������� (pages � ������� ����)), � ����� �� �������� ��
    //�� ����� �� ������� ����

    //�������� a_prm ������ ���������� ��� �������� (���. ����);
    //�������� ������������ � ��� - ����� � ����� (� ��� ������������ ���� �������);
    //�������� ��� ��������� �� ��������� ������ �����, ����� ���� ��� ���������
    //RESULT_OK, ����������� ��� ������� - RESULT_FAIL, ����� - RESULT_CANCEL;
    //�������� �� ���������� ������� �������� ����������� ��� ��������� ���
    //���������;
    //��"� ������� (����� �� ���� ������ ���� ����������� � �����) ��������
    //� xml ���� (<VelesAppInfo> -> <StartWork> -> <FunctionName>)
    TGetStartResult = function(var a_prm: ZVelesInfoRec): Integer; stdcall;

    //�������� a_prm ������ ���������� ��� �������� (���. ����);
    //���� app_handle, control_pointers ���������������� ��� ��������� �����
    //������ �� ����"���� �� ������� ����� ��������;
    //�������� ��� ��������� �� ������������ � Longint �������� �� �����
    //������;
    //���� ������� �� �� ��������� �� ������� (���������� ��������� ��) ��
    //������; ���� ������� ��� ��������� ������ ������ ��;
    TShowPage = function(var a_prm: ZVelesInfoRec): Longint; stdcall;

    //����� ����� ������; �������� a_form_ref �� �������� �� ����� ������
    //��������� ���������� TShowPage; ���� �������� ����� ������ ���������
    //��������� ����� (����, ��������, �� ����"������);
    TFreePage = procedure(a_form_ref: Longint); stdcall;

    //������ ����� �� �������� �����;
    ZShowPlugin = function(var a_prm: ZVelesInfoRec): Longint; stdcall;

    // ���������� ��������� ���������/����������� ������
    ZRecordDialogFunc = function (var id: ZFuncArgs; var prm: ZVelesInfoRec): Integer;

//var
//  code_dealer: Integer;

//*******************************procedures*************************************

// ������� ���������, �� ��������� ������ ��� ���������


implementation


end.
