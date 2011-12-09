unit store_h;

interface

const
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


implementation

end.
