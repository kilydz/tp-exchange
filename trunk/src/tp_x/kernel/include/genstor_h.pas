unit genstor_h;

interface
uses Windows, IBExternals, Zutils_h;

type
  PVoid = ^Pointer;
  LPVoid = ^PVoid;

const
  prOk = 10;
  prCancel = 23;
  prError = 12;

  ACCESS_TO_STORE                 = 2;    // 001 ������ �� ������ "�����"

// ������ �� �������� "���������" ---------------------------------------------
  ACCESS_TO_DIC_DOCUMENTS         = 1100; // 002 ������� "���������"

// ������ �� �������� ��������
  ACCESS_TO_DOC1                  = 1110; // 003 ������ (����-���) � ��������� ���������
  ACCESS_TO_VIEW_DET_DOC1         = 1111; // 004 ��������� �������� �������� ��������
  ACCESS_TO_EXPORT_DOC1           = 1112; // 005 ������� �������� ��������
  ACCESS_TO_DISPLAY_EXTRA_DOC1    = 1113; // 006 ³��������� ������� �� �� � �������� ��������
  ACCESS_TO_SET_EXTRA_DOC1        = 1114; // 007 ������������� % ������� �� �� �� �������� ��������
  ACCESS_TO_CREATE_DOC1           = 1115; // 008 �������� �������� ��������
  ACCESS_TO_EDIT_DOC1             = 1116; // 009 ���������� �������� ��������
  ACCESS_TO_DELETE_DOC1           = 1117; // 010 �������� �������� ��������
  ACCESS_TO_LOCK_DOC1             = 1118; // 011 ����������� �������� ��������
  ACCESS_TO_UNLOCK_DOC1           = 1119; // 012 ������������ �������� ��������
  ACCESS_TO_SHIP_DOC1             = 1120; // 013 ³���������� �������� ��������
  ACCESS_TO_UNSHIP_DOC1           = 1121; // 014 ����� ������������ � �������� ��������

// ������ �� �������� �������� -----------------------------------------------
  ACCESS_TO_DOC2                  = 1130; // 015 ������ (����-���) � ��������� ���������
  ACCESS_TO_VIEW_DET_DOC2         = 1131; // 016 ��������� �������� �������� ��������
  ACCESS_TO_EXPORT_DOC2           = 1132; // 017 ������� �������� ��������
  ACCESS_TO_DISPLAY_EXTRA_DOC2    = 1133; // 018 ³��������� ������� �� �� � �������� ��������
  ACCESS_TO_CONVERT_DOC2_DOC11       = 1134; // 019 ������������ �������� �������� � ���
  ACCESS_TO_CREATE_DOC2           = 1135; // 020 �������� �������� ��������
  ACCESS_TO_EDIT_DOC2             = 1136; // 021 ���������� �������� ��������
  ACCESS_TO_DELETE_DOC2           = 1137; // 022 �������� �������� ��������
  ACCESS_TO_LOCK_DOC2             = 1138; // 023 ����������� �������� ��������
  ACCESS_TO_UNLOCK_DOC2           = 1139; // 024 ������������ �������� ��������
  ACCESS_TO_SHIP_DOC2             = 1140; // 025 ³���������� �������� ��������
  ACCESS_TO_UNSHIP_DOC2              = 1141; // 026 ����� ������������ � �������� ��������

// ������ �� ���������� �� ������� --------------------------------------------
  ACCESS_TO_DOC4                  = 1150; // 027 ������ (����-���) � ����������� �� �������
  ACCESS_TO_VIEW_DET_DOC4         = 1151; // 028 ��������� �������� ���������� �� �������
  ACCESS_TO_EXPORT_DOC4           = 1152; // 029 ������� ���������� �� �������
  ACCESS_TO_DISPLAY_EXTRA_DOC4    = 1153; // 030 ³��������� ������� �� �� � ��������� �� �������

// ������ �� ����������� ��������� -------------------------------------------
  ACCESS_TO_DOC6                  = 1170; // 031 ������ (����-���) ��� �������� �����������
  ACCESS_TO_VIEW_DET_DOC6         = 1171; // 032 ��������� �������� ����������� ����������
  ACCESS_TO_EXPORT_DOC6           = 1172; // 033 ������� ����������� ����������
  ACCESS_TO_DISPLAY_EXTRA_DOC6    = 1173; // 034 ³��������� ������� �� �� � ����������� ����������
  ACCESS_TO_CREATE_DOC6           = 1174; // 035 �������� ������� ����������
  ACCESS_TO_EDIT_DOC6             = 1175; // 036 ���������� ������� ����������
  ACCESS_TO_DELETE_DOC6           = 1176; // 037 �������� ������� ����������
  ACCESS_TO_LOCK_DOC6             = 1177; // 038 ����������� ������� ����������
  ACCESS_TO_UNLOCK_DOC6           = 1178; // 039 ������������ ������� ����������
  ACCESS_TO_SHIP_DOC6             = 1179; // 040 ³���������� ������� ����������
  ACCESS_TO_UNSHIP_DOC6           = 1180; // 041 ����� ������������ � ������������ ����������

// ������ �� ���� --------------------------------------------------------------
  ACCESS_TO_DOC11                 = 1190; // 042 ������ (����-���) � �����
  ACCESS_TO_VIEW_DET_DOC11        = 1191; // 043 ��������� �������� ����
  ACCESS_TO_EXPORT_DOC11          = 1192; // 044 ������� ����
  ACCESS_TO_DISPLAY_EXTRA_DOC11   = 1193; // 045 ³��������� ������� �� �� � �����
  ACCESS_TO_CONVERT_DOC11_DOC2    = 1194; // 046 ������������ � ��� � �������� ��������

// ������ �� ��������� �� ���糿 ---------------------------------------------
  ACCESS_TO_DOC14                 = 1210; // 047 ������ (����-���) � ���������� �� ���糿
  ACCESS_TO_VIEW_DET_DOC14        = 1211; // 048 ��������� �������� ��������� �� ���糿
  ACCESS_TO_EXPORT_DOC14          = 1212; // 049 ������� ��������� �� ���糿
  ACCESS_TO_DISPLAY_EXPORT_DOC14  = 1213; // 050 ³��������� ������� �� �� � ���������� �� ���糿

// ������ �� ���� �������� -----------------------------------------------------
  ACCESS_TO_DOC15                 = 1230; // 051 ������ (����-���) � ����� ��������
  ACCESS_TO_VIEW_DET_DOC15        = 1231; // 052 ��������� �������� ���� ��������
  ACCESS_TO_EXPORT_DOC15          = 1232; // 053 ������� ���� ��������
  ACCESS_TO_CREATE_DOC15          = 1233; // 054 �������� ��� ��������
  ACCESS_TO_EDIT_DOC15            = 1234; // 055 ���������� ��� ��������
  ACCESS_TO_DELETE_DOC15          = 1235; // 056 �������� ��� �������
  ACCESS_TO_LOCK_DOC15            = 1236; // 057 ����������� ��� �������
  ACCESS_TO_UNLOCK_DOC15          = 1237; // 058 ������������ ��� �������
  ACCESS_TO_SHIP_DOC15            = 1238; // 059 ³���������� ��� �������
  ACCESS_TO_UNSHIP_DOC15          = 1239; // 060 ����� ������������ � ���� �������

// ������ �� ���������� �������������� ----------------------------------------
  ACCESS_TO_DOC17                 = 1250; // 061 ������ (����-���) ��� ������������ ��������������
  ACCESS_TO_VIEW_DET_DOC17        = 1251; // 062 ��������� �������� ���������� ��������������
  ACCESS_TO_EXPORT_DOC17          = 1252; // 063 ������� ��������� ��������������
  ACCESS_TO_CREATE_DOC17          = 1253; // 064 �������� ���������� ��������������
  ACCESS_TO_EDIT_DOC17            = 1254; // 065 ���������� ���������� ��������������
  ACCESS_TO_DELETE_DOC17          = 1255; // 066 �������� ���������� ��������������
  ACCESS_TO_LOCK_DOC17            = 1256; // 067 ����������� ���������� ��������������
  ACCESS_TO_UNLOCK_DOC17          = 1257; // 068 ������������ ���������� ��������������
  ACCESS_TO_SHIP_DOC17            = 1258; // 069 ³���������� ���������� ��������������
  ACCESS_TO_UNSHIP_DOC17          = 1259; // 070 ����� ������������ � ���������� ��������������

// ������ �� ����� ��������� ---------------------------------------------------
  ACCESS_TO_ALL_INVOICE           = 1270; // 071 ���� ����-���� ���������
  ACCESS_TO_CREDIT_INVOICE        = 1271; // 072 ���� ��������� ��������
  ACCESS_TO_TAX_INVOICE           = 1272; // 073 ���� �������� ��������
  ACCESS_TO_INVOICE               = 1273; // 074 ���� �������-�������
  ACCESS_TO_DEB_INVOICE_OUT_PRICE = 1274; // 075 ���� �������� �������� �� ��
  ACCESS_TO_DEB_INVOICE_IN_PRICE  = 1275; // 076 ���� �������� �������� �� ��
  ACCESS_TO_PAYOFF_ACT            = 1276; // 077 ���� ���� ��������
  ACCESS_TO_ACT_OF_EXEC           = 1277; // 078 ���� ���� ��������� ����

// ������ �� ������� -----------------------------------------------------------
  ACCESS_TO_PAY                   = 1280; // 079 ������ (����-���) ��� ����������
  ACCESS_TO_CREATE_PAY_CASH       = 1281; // 080 ����������� �����. "������"
  ACCESS_TO_DELETE_PAY_CASH       = 1282; // 081 ��������� �����. "������"
  ACCESS_TO_CREATE_PAY_SETTLE     = 1283; // 082 ������������ �����. "�����������"
  ACCESS_TO_DELETE_PAY_SETTLE     = 1284; // 083 ��������� �����. "�����������"
  ACCESS_TO_CREATE_PAY_BARTER     = 1285; // 084 ������������ �����. "���������"
  ACCESS_TO_DELETE_PAY_BARTER     = 1286; // 085 ��������� �����. "���������"

// ���� ������� �� �������� ��������� ----------------------------------------
  ACCESS_TO_EXPORT_DIC_DOC        = 1291; // 086 ������� �������� ���������
  ACCESS_TO_DISPLAY_EXTRA_DIC_DOC  = 1292; // 087 ³��������� ������� �� �� � ��������� ���������
  ACCESS_TO_PRINT_PRICES_DOC      = 1293; // 089 ���� ������� �� ���������
  ACCESS_TO_NOTARIZATION_DOC     = 1294; // 090 ϳ������������ ��������� ���������
  ACCESS_TO_CHENG_DATE_DOC         = 1295; // 091 �������� ���� � ����������

// ������ �� �������� "������������" ------------------------------------------
  ACCESS_TO_DIC_NOMEN             = 1400; // 092 ������� "������������"
  ACCESS_TO_DET_VIEW_NOMEN        = 1401; // 093 ��������� �������� ������������
  ACCESS_TO_DISPLAY_NOMEN_EXTRA   = 1402; // 094 ³��������� ������� �� �� � ��������� ������������
  ACCESS_TO_CREATE_NOMEN          = 1403; // 095 ���������� ������������
  ACCESS_TO_EDIT_NOMEN            = 1404; // 096 ���������� ������������
  ACCESS_TO_DELETE_NOMEN          = 1405; // 097 �������� ������������
  ACCESS_TO_EDIT_OUT_PRICE        = 1406; // 098 ����������� �� ������������
  ACCESS_TO_MOVE_NOMEN_IN_GRP     = 1407; // 099 ����������� ������������ � ���� �����
  ACCESS_TO_UNIT_NOMEN            = 1408; // 100 ��"������� ������������
  ACCESS_TO_EXPORT_DIC_NOMEN      = 1409; // 101 ������� ������������
  ACCESS_TO_PRINT_PRICES          = 1410; // 102 ���� ������� � ������������
  ACCESS_TO_JOURANL_PRICES        = 1411; // 103 ������ ���� �� ������
  ACCESS_TO_PRICE_LIST            = 1412; // 104 �����-���� ������
  ACCESS_TO_MOVING_DOCS_OF_NOMEN  = 1413; // 105 ��� ��������� �� �����������
  ACCESS_TO_VIEW_GOODS            = 1414; // 106 �������� ���������� ������
  ACCESS_TO_EXPORT_GOODS          = 1415; // 107 ������� ���������� ������

// ������ �� �������� "�볺���" -----------------------------------------------
  ACCESS_TO_DIC_CLIENTS           = 1500; // 108 ������� "�볺���"
  ACCESS_TO_DET_VIEW_CLIENT       = 1501; // 109 ��������� �������� �볺���
  ACCESS_TO_CREATE_CLIENT         = 1502; // 110 ���������� �볺���
  ACCESS_TO_EDIT_CLIENT           = 1503; // 111 ���������� �볺���
  ACCESS_TO_DELETE_CLIENT         = 1504; // 112 �������� �볺���
  ACCESS_TO_MOVE_CLIENT_IN_GRP    = 1505; // 113 ����������� �볺��� � ���� �����
  ACCESS_TO_UNIT_CLIENTS          = 1506; // 114 ��"������� �볺���
  ACCESS_TO_EXPORT_DIC_CLIENTS    = 1507; // 115 ������� �볺���
  ACCESS_TO_MOVING_DOCS_OF_CLIENT = 1508; // 116 ��� ��������� �� �볺���
  ACCESS_TO_VIEW_REQ_CLIENT       = 1509; // 117 �������� �������� �볺���
  ACCESS_TO_EXPORT_REQ_CLIENT     = 1510; // 118 ������� �������� �볺���
  ACCESS_TO_EDIT_DISCONT          = 1511; // 119 ����������� ���������� ������

// ������ �� �������� "��������������" ----------------------------------------
  ACCESS_TO_DIC_REVISION          = 1600; // 120 ������� "��������������"
  ACCESS_TO_DET_VIEW_REVISION     = 1601; // 121 ��������� �������� ���� ��������������
  ACCESS_TO_CREATE_REVISION       = 1602; // 122 ���������� ��� ��������������
  ACCESS_TO_EDIT_REVISION         = 1603; // 123 ���������� ��� ��������������
  ACCESS_TO_DELETE_REVISION       = 1604; // 124 �������� ��� �������������
  ACCESS_TO_LOCK_REVISION         = 1605; // 125 ������������� ��� ��������������
  ACCESS_TO_EXPORT_DIC_REVISION   = 1606; // 126 ������� �������� ��������������
  ACCESS_TO_EXPORT_DET_REVISION   = 1607; // 127 ������� ���� ��������������

// ������ �� �������� "���������� ������" -------------------------------------
  ACCESS_TO_DIC_AUTOORDER         = 1700; // 128 ������� "���������� ������"
  ACCESS_TO_DET_VIEW_AUTOORDER    = 1701; // 129 ��������� �������� ���������� ������
  ACCESS_TO_CREATE_AUTOORDER      = 1702; // 130 ���������� ���������� ������
  ACCESS_TO_EDIT_AUTOORDER        = 1703; // 131 ���������� ���������� ������
  ACCESS_TO_DELETE_AUTOORDER      = 1704; // 132 �������� ���������� ������
  ACCESS_TO_LOCK_AUTOORDER        = 1705; // 133 ������������� ���������� ������
  ACCESS_TO_UNLOCK_AUTOORDER      = 1706; // 134 �������������� ���������� ������
  ACCESS_TO_SHIP_AUTOORDER        = 1707; // 135 ³������������ ���������� ������
  ACCESS_TO_UNSHIP_AUTOORDER      = 1708; // 136 ������ ������������ � ���������� ������
  ACCESS_TO_EXPORT_DIC_AUTOORDER  = 1709; // 137 ������� �������� ���������� ������
  ACCESS_TO_EXPORT_DET_AUTOORDER  = 1710; // 138 ������� ���������� ������

// ������ �� ���� ------------------------------------------------------------
  ACCESS_TO_REPORTS               = 1900; // 139 ����
  ACCESS_TO_REPDOCS               = 1910; // 140 ���� �� ����������
  ACCESS_TO_REPROLLDOCS           = 1911; // 141 ��� "����� �� ����������"
  ACCESS_TO_REPROLLTAX            = 1912; // 142 ��� "������ ����������"
  ACCESS_TO_REPMOVEGOODS          = 1930; // 143 ���� �� ���� ������
  ACCESS_TO_REPSALDO              = 1931; // 144 ��� "������"
  ACCESS_TO_REPTYPEVAT            = 1932; // 145 ��� "�� ���� ���"
  ACCESS_TO_REPKRZ                = 1933; // 146 ��� "������. �������"
  ACCESS_TO_REPKRP                = 1934; // 147 ��� "������. �����"
  ACCESS_TO_REPOBOROTREST         = 1935; // 148 ��� "������� �������"
  ACCESS_TO_REPSPECGROUP          = 1936; // 149 ��� "������ ����. ����"
  ACCESS_TO_REPCLIENTS            = 1950; // 150 ���� �� �볺����
  ACCESS_TO_REPREALCLIENTS        = 1951; // 151 ��� "��������� �� �볺����"
  ACCESS_TO_REPCREDCLIENTS        = 1952; // 152 ��� "������������ �������������"
  ACCESS_TO_REPFIN                = 1970; // 153 ���� �� ��������

    ACCESS_TO_PRINT             = 100000;    // ����
    ACCESS_TO_PRINT_PRICES_SQL  = 100100;    // ���� ������� �� sql �������
    ACCESS_TO_PRINT_INVOICE     = 100110;    // ���� ���������

    ACCESS_TO_DOCUMENTS         = 100200;    // ������� "���������"
    ACCESS_TO_NOMENS            = 100300;    // ������� "������"
    ACCESS_TO_CLIENTS           = 100400;    // ������� "�볺���"
    ACCESS_TO_MARKUPS           = 100500;    // ������� "���� ����������"
    ACCESS_TO_KARDS             = 100600;    // ������� "�������"
    ACCESS_TO_REVISIONS         = 100700;    // ������� "���糿"
    ACCESS_TO_AUTOORDERS        = 100800;    // ������� "��������������"

function gdHasAsses(dbH: Pointer; asses_id: integer; users_id: integer): integer;
   stdcall; external 'genstor.dll' name 'gdHasAsses';

function gdGateDialog(ubase, uname, upass: PChar; dbH :LPVoid): Integer;
   stdcall; external 'genstor.dll' name 'gdGateDialog';

//function GMessageBox(msg, buttons: PChar): Integer;
//   stdcall; external 'genstor.dll' name 'GMessageBox';

function gdConvertToText(dst: PChar; src, isthouth: integer): PChar;
   stdcall; external 'genstor.dll' name 'gdConvertToText';

function gdIntKey(k: char): char;
   stdcall; external 'genstor.dll' name 'gdIntKey';
function gdFloatKey(k: char): char;
   stdcall; external 'genstor.dll' name 'gdFloatKey';
function gdStrKey(k: char):char;
   stdcall; external 'genstor.dll' name 'gdStrKey';

implementation

end.
