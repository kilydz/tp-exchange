unit store_h;

interface

const
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


implementation

end.
