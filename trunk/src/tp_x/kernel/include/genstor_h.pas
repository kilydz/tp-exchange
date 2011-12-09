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

  ACCESS_TO_STORE                 = 2;    // 001 Доступ до модуля "Склад"

// Доступ до довідника "Документи" ---------------------------------------------
  ACCESS_TO_DIC_DOCUMENTS         = 1100; // 002 Довідник "Документи"

// Доступ до прихідної накладної
  ACCESS_TO_DOC1                  = 1110; // 003 Робота (будь-яка) з прихідною накладною
  ACCESS_TO_VIEW_DET_DOC1         = 1111; // 004 Детальний перегляд прихідної накладної
  ACCESS_TO_EXPORT_DOC1           = 1112; // 005 Експорт прихідної накладної
  ACCESS_TO_DISPLAY_EXTRA_DOC1    = 1113; // 006 Відображати націнку та ЦР в прихідній накладній
  ACCESS_TO_SET_EXTRA_DOC1        = 1114; // 007 Встановлювати % нацЁнки на ЦР по прихідній накладній
  ACCESS_TO_CREATE_DOC1           = 1115; // 008 Створити прихідну накладну
  ACCESS_TO_EDIT_DOC1             = 1116; // 009 Редагувати прихідну накладну
  ACCESS_TO_DELETE_DOC1           = 1117; // 010 Видалити прихідну накладну
  ACCESS_TO_LOCK_DOC1             = 1118; // 011 Зафіксувати прихідну накладну
  ACCESS_TO_UNLOCK_DOC1           = 1119; // 012 Розфіксувати прихідну накладну
  ACCESS_TO_SHIP_DOC1             = 1120; // 013 Відвантажити прихідну накладну
  ACCESS_TO_UNSHIP_DOC1           = 1121; // 014 Зняти відвантаження з прихідної накладної

// Доступ до розхідної накладної -----------------------------------------------
  ACCESS_TO_DOC2                  = 1130; // 015 Робота (будь-яка) з розхідною накладною
  ACCESS_TO_VIEW_DET_DOC2         = 1131; // 016 Детальний перегляд розхідної накладної
  ACCESS_TO_EXPORT_DOC2           = 1132; // 017 Експорт розхідної накладної
  ACCESS_TO_DISPLAY_EXTRA_DOC2    = 1133; // 018 Відображати націнку та ЦЗ в розхідній накладній
  ACCESS_TO_CONVERT_DOC2_DOC11       = 1134; // 019 Конвертувати розхідну накладну в чек
  ACCESS_TO_CREATE_DOC2           = 1135; // 020 Створити розхідну накладну
  ACCESS_TO_EDIT_DOC2             = 1136; // 021 Редагувати розхідну накладну
  ACCESS_TO_DELETE_DOC2           = 1137; // 022 Видалити розхідну накладну
  ACCESS_TO_LOCK_DOC2             = 1138; // 023 Зафіксувати розхідну накладну
  ACCESS_TO_UNLOCK_DOC2           = 1139; // 024 Розфіксувати розхідну накладну
  ACCESS_TO_SHIP_DOC2             = 1140; // 025 Відвантажити розхідну накладну
  ACCESS_TO_UNSHIP_DOC2              = 1141; // 026 Зняти відвантаження з розхідної накладної

// Доступ до повернення від покупця --------------------------------------------
  ACCESS_TO_DOC4                  = 1150; // 027 Робота (будь-яка) з поверненням від покупця
  ACCESS_TO_VIEW_DET_DOC4         = 1151; // 028 Детальний перегляд повернення від покупця
  ACCESS_TO_EXPORT_DOC4           = 1152; // 029 Експорт повернення від покупця
  ACCESS_TO_DISPLAY_EXTRA_DOC4    = 1153; // 030 Відображати націнку та ЦЗ в поверненні від покупця

// Доступ до внутрішнього преміщення -------------------------------------------
  ACCESS_TO_DOC6                  = 1170; // 031 Робота (будь-яка) над внутрішнім переміщенням
  ACCESS_TO_VIEW_DET_DOC6         = 1171; // 032 Детальний перегляд внутрішнього перемЁщення
  ACCESS_TO_EXPORT_DOC6           = 1172; // 033 Експорт внутрішнього переміщення
  ACCESS_TO_DISPLAY_EXTRA_DOC6    = 1173; // 034 Відображати націнку та ЦЗ в внутрішньому переміщенню
  ACCESS_TO_CREATE_DOC6           = 1174; // 035 Створити внутрішнє переміщення
  ACCESS_TO_EDIT_DOC6             = 1175; // 036 Редагувати внутрішнє переміщення
  ACCESS_TO_DELETE_DOC6           = 1176; // 037 Видалити внутрішнє переміщення
  ACCESS_TO_LOCK_DOC6             = 1177; // 038 Зафіксувати внутрішнє переміщення
  ACCESS_TO_UNLOCK_DOC6           = 1178; // 039 Розфіксувати внутрішнє переміщення
  ACCESS_TO_SHIP_DOC6             = 1179; // 040 Відвантажити внутрішнє переміщення
  ACCESS_TO_UNSHIP_DOC6           = 1180; // 041 Зняти відвантаження з внутрішньгого переміщення

// Доступ до чека --------------------------------------------------------------
  ACCESS_TO_DOC11                 = 1190; // 042 Робота (будь-яка) з чеком
  ACCESS_TO_VIEW_DET_DOC11        = 1191; // 043 Детальний перегляд чеку
  ACCESS_TO_EXPORT_DOC11          = 1192; // 044 Експорт чеку
  ACCESS_TO_DISPLAY_EXTRA_DOC11   = 1193; // 045 Відображати націнку та ЦЗ в чекові
  ACCESS_TO_CONVERT_DOC11_DOC2    = 1194; // 046 Конвертувати в чек в розхідну накладну

// Доступ до корегуючої по ревізії ---------------------------------------------
  ACCESS_TO_DOC14                 = 1210; // 047 Робота (будь-яка) з корегуючою по ревізії
  ACCESS_TO_VIEW_DET_DOC14        = 1211; // 048 Детальний перегляд корегуючої по ревізії
  ACCESS_TO_EXPORT_DOC14          = 1212; // 049 Експорт корегуючої по ревізії
  ACCESS_TO_DISPLAY_EXPORT_DOC14  = 1213; // 050 Відображати націнку та ЦЗ в корегуючій по ревізії

// Доступ до акту списання -----------------------------------------------------
  ACCESS_TO_DOC15                 = 1230; // 051 Робота (будь-яка) з актом списання
  ACCESS_TO_VIEW_DET_DOC15        = 1231; // 052 Детальний перегляд акту списання
  ACCESS_TO_EXPORT_DOC15          = 1232; // 053 Експорт акта списання
  ACCESS_TO_CREATE_DOC15          = 1233; // 054 Створити акт списання
  ACCESS_TO_EDIT_DOC15            = 1234; // 055 Редагувати акт списання
  ACCESS_TO_DELETE_DOC15          = 1235; // 056 Видалити акт спиання
  ACCESS_TO_LOCK_DOC15            = 1236; // 057 Зафіксувати акт спиання
  ACCESS_TO_UNLOCK_DOC15          = 1237; // 058 Розфіксувати акт спиання
  ACCESS_TO_SHIP_DOC15            = 1238; // 059 Відвантажити акт спиання
  ACCESS_TO_UNSHIP_DOC15          = 1239; // 060 Зняти відвантаження з акту спиання

// Доступ до повернення постачальникові ----------------------------------------
  ACCESS_TO_DOC17                 = 1250; // 061 Робота (будь-яка) над поверененням постачальникові
  ACCESS_TO_VIEW_DET_DOC17        = 1251; // 062 Детальний перегляд повернення постачальникові
  ACCESS_TO_EXPORT_DOC17          = 1252; // 063 Експорт поверненя постачальникові
  ACCESS_TO_CREATE_DOC17          = 1253; // 064 Створити повернення постачальникові
  ACCESS_TO_EDIT_DOC17            = 1254; // 065 Редагувати повернення постачальникові
  ACCESS_TO_DELETE_DOC17          = 1255; // 066 Видалити повернення постачальникові
  ACCESS_TO_LOCK_DOC17            = 1256; // 067 Зафіксувати повернення постачальникові
  ACCESS_TO_UNLOCK_DOC17          = 1257; // 068 Розфіксувати повернення постачальникові
  ACCESS_TO_SHIP_DOC17            = 1258; // 069 Відвантажити повернення постачальникові
  ACCESS_TO_UNSHIP_DOC17          = 1259; // 070 Зняти відвантаження з повернення постачальникові

// Доступ до друку накладних ---------------------------------------------------
  ACCESS_TO_ALL_INVOICE           = 1270; // 071 Друк будь-яких накладних
  ACCESS_TO_CREDIT_INVOICE        = 1271; // 072 Друк видаткової накладної
  ACCESS_TO_TAX_INVOICE           = 1272; // 073 Друк прихідної накладної
  ACCESS_TO_INVOICE               = 1273; // 074 Друк рахунок-фактури
  ACCESS_TO_DEB_INVOICE_OUT_PRICE = 1274; // 075 Друк прихідної накладної по ЦР
  ACCESS_TO_DEB_INVOICE_IN_PRICE  = 1275; // 076 Друк прихідної накладної по ЦЗ
  ACCESS_TO_PAYOFF_ACT            = 1276; // 077 Друк акта списання
  ACCESS_TO_ACT_OF_EXEC           = 1277; // 078 Друк акта виконаних робіт

// Доступ до проплат -----------------------------------------------------------
  ACCESS_TO_PAY                   = 1280; // 079 Робота (будь-яка) над проплатами
  ACCESS_TO_CREATE_PAY_CASH       = 1281; // 080 Встновлення пропл. "Готівка"
  ACCESS_TO_DELETE_PAY_CASH       = 1282; // 081 Видалення пропл. "Готівка"
  ACCESS_TO_CREATE_PAY_SETTLE     = 1283; // 082 Встановлення пропл. "Перерахунок"
  ACCESS_TO_DELETE_PAY_SETTLE     = 1284; // 083 Видалення пропл. "Перерахунок"
  ACCESS_TO_CREATE_PAY_BARTER     = 1285; // 084 Встановлення пропл. "Взаємозалік"
  ACCESS_TO_DELETE_PAY_BARTER     = 1286; // 085 Видалення пропл. "Взаємозалік"

// Інші доступи до довідника документів ----------------------------------------
  ACCESS_TO_EXPORT_DIC_DOC        = 1291; // 086 Експорт довідника документів
  ACCESS_TO_DISPLAY_EXTRA_DIC_DOC  = 1292; // 087 Відображати націнку та ЦЗ в довідникові документів
  ACCESS_TO_PRINT_PRICES_DOC      = 1293; // 089 Друк цінників по документу
  ACCESS_TO_NOTARIZATION_DOC     = 1294; // 090 Підтверджувати істинність документів
  ACCESS_TO_CHENG_DATE_DOC         = 1295; // 091 Змінювати дату в документах

// Доступ до довідника "Номенклатура" ------------------------------------------
  ACCESS_TO_DIC_NOMEN             = 1400; // 092 Довідник "Номенклатура"
  ACCESS_TO_DET_VIEW_NOMEN        = 1401; // 093 Детальний перегляд номенклатури
  ACCESS_TO_DISPLAY_NOMEN_EXTRA   = 1402; // 094 Відображати націнку та ЦЗ в довідникові номенклатури
  ACCESS_TO_CREATE_NOMEN          = 1403; // 095 Створювати номенклатуру
  ACCESS_TO_EDIT_NOMEN            = 1404; // 096 Редагувати номенклатуру
  ACCESS_TO_DELETE_NOMEN          = 1405; // 097 Видаляти номенклатуру
  ACCESS_TO_EDIT_OUT_PRICE        = 1406; // 098 Редагування ЦР номенклатури
  ACCESS_TO_MOVE_NOMEN_IN_GRP     = 1407; // 099 Перенесення номенклатури в іншу групу
  ACCESS_TO_UNIT_NOMEN            = 1408; // 100 Об"єднання номенклатури
  ACCESS_TO_EXPORT_DIC_NOMEN      = 1409; // 101 Експорт номенклатури
  ACCESS_TO_PRINT_PRICES          = 1410; // 102 Друк цінників з номенклатури
  ACCESS_TO_JOURANL_PRICES        = 1411; // 103 Журнал зміни ЦР товару
  ACCESS_TO_PRICE_LIST            = 1412; // 104 Прайс-лист товару
  ACCESS_TO_MOVING_DOCS_OF_NOMEN  = 1413; // 105 Рух документів по номенклатурі
  ACCESS_TO_VIEW_GOODS            = 1414; // 106 Перегляд аналітичних карток
  ACCESS_TO_EXPORT_GOODS          = 1415; // 107 Експорт аналітичних карток

// Доступ до довідника "Клієнти" -----------------------------------------------
  ACCESS_TO_DIC_CLIENTS           = 1500; // 108 Довідник "Клієнти"
  ACCESS_TO_DET_VIEW_CLIENT       = 1501; // 109 Детальний перегляд клієнтів
  ACCESS_TO_CREATE_CLIENT         = 1502; // 110 Створювати клієнта
  ACCESS_TO_EDIT_CLIENT           = 1503; // 111 Редагувати клієнта
  ACCESS_TO_DELETE_CLIENT         = 1504; // 112 Видаляти клієнта
  ACCESS_TO_MOVE_CLIENT_IN_GRP    = 1505; // 113 Перенесення клієнта в іншу групу
  ACCESS_TO_UNIT_CLIENTS          = 1506; // 114 Об"єднання клієнтів
  ACCESS_TO_EXPORT_DIC_CLIENTS    = 1507; // 115 Експорт клієнтів
  ACCESS_TO_MOVING_DOCS_OF_CLIENT = 1508; // 116 Рух документів по клієнту
  ACCESS_TO_VIEW_REQ_CLIENT       = 1509; // 117 Перегляд реквізитів клієнта
  ACCESS_TO_EXPORT_REQ_CLIENT     = 1510; // 118 Експорт реквізитів клієнта
  ACCESS_TO_EDIT_DISCONT          = 1511; // 119 Редагування дисконтних карток

// Доступ до довідника "Інвентаризація" ----------------------------------------
  ACCESS_TO_DIC_REVISION          = 1600; // 120 Довідник "Інвентаризація"
  ACCESS_TO_DET_VIEW_REVISION     = 1601; // 121 Детальний перегляд акта інвентаризації
  ACCESS_TO_CREATE_REVISION       = 1602; // 122 Створювати акт інвентаризації
  ACCESS_TO_EDIT_REVISION         = 1603; // 123 Редагувати акт інвентаризації
  ACCESS_TO_DELETE_REVISION       = 1604; // 124 Видаляти акт івентаризації
  ACCESS_TO_LOCK_REVISION         = 1605; // 125 Зафіксовувати акт інвентаризації
  ACCESS_TO_EXPORT_DIC_REVISION   = 1606; // 126 Експорт довідника Ёнвентаризації
  ACCESS_TO_EXPORT_DET_REVISION   = 1607; // 127 Експорт акта інвентаризації

// Доступ до довідника "Замовлення товару" -------------------------------------
  ACCESS_TO_DIC_AUTOORDER         = 1700; // 128 Довідник "Замовлення товару"
  ACCESS_TO_DET_VIEW_AUTOORDER    = 1701; // 129 Детальний перегляд замовлення товару
  ACCESS_TO_CREATE_AUTOORDER      = 1702; // 130 Створювати замовлення товару
  ACCESS_TO_EDIT_AUTOORDER        = 1703; // 131 Редагувати замовлення товару
  ACCESS_TO_DELETE_AUTOORDER      = 1704; // 132 Видаляти замовлення товару
  ACCESS_TO_LOCK_AUTOORDER        = 1705; // 133 Зафіксовувати замовлення товару
  ACCESS_TO_UNLOCK_AUTOORDER      = 1706; // 134 Розфіксовувати замовлення товару
  ACCESS_TO_SHIP_AUTOORDER        = 1707; // 135 Відвантажувати замовлення товару
  ACCESS_TO_UNSHIP_AUTOORDER      = 1708; // 136 Знімати відвантаження з замовлення товару
  ACCESS_TO_EXPORT_DIC_AUTOORDER  = 1709; // 137 Експорт довідника замовлення товару
  ACCESS_TO_EXPORT_DET_AUTOORDER  = 1710; // 138 Експорт замовлення товару

// Доступ до звітів ------------------------------------------------------------
  ACCESS_TO_REPORTS               = 1900; // 139 Звіти
  ACCESS_TO_REPDOCS               = 1910; // 140 Звіти по документах
  ACCESS_TO_REPROLLDOCS           = 1911; // 141 Звіт "Реєстр по документах"
  ACCESS_TO_REPROLLTAX            = 1912; // 142 Звіт "Реєестр податкових"
  ACCESS_TO_REPMOVEGOODS          = 1930; // 143 Звіти по руху товару
  ACCESS_TO_REPSALDO              = 1931; // 144 Звіт "Сальдо"
  ACCESS_TO_REPTYPEVAT            = 1932; // 145 Звіт "По типу ПДВ"
  ACCESS_TO_REPKRZ                = 1933; // 146 Звіт "Рентаб. залишків"
  ACCESS_TO_REPKRP                = 1934; // 147 Звіт "Рентаб. площі"
  ACCESS_TO_REPOBOROTREST         = 1935; // 148 Звіт "Оборотні залишки"
  ACCESS_TO_REPSPECGROUP          = 1936; // 149 Звіт "Сальдо спец. груп"
  ACCESS_TO_REPCLIENTS            = 1950; // 150 Звіти по клієнтах
  ACCESS_TO_REPREALCLIENTS        = 1951; // 151 Звіт "Реалізація по клієнтах"
  ACCESS_TO_REPCREDCLIENTS        = 1952; // 152 Звіт "Кредиторська заборгованість"
  ACCESS_TO_REPFIN                = 1970; // 153 Звіти по фінансах

    ACCESS_TO_PRINT             = 100000;    // Друк
    ACCESS_TO_PRINT_PRICES_SQL  = 100100;    // Друк цінників по sql запросу
    ACCESS_TO_PRINT_INVOICE     = 100110;    // Друк накладних

    ACCESS_TO_DOCUMENTS         = 100200;    // Довідник "Документи"
    ACCESS_TO_NOMENS            = 100300;    // Довідник "Товари"
    ACCESS_TO_CLIENTS           = 100400;    // Довідник "Клієнти"
    ACCESS_TO_MARKUPS           = 100500;    // Довідник "Акти переоцінки"
    ACCESS_TO_KARDS             = 100600;    // Довідник "Дисконт"
    ACCESS_TO_REVISIONS         = 100700;    // Довідник "Ревізії"
    ACCESS_TO_AUTOORDERS        = 100800;    // Довідник "Автозамовлення"

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
