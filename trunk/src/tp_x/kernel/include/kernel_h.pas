unit kernel_h;

interface

uses IBHeader, Controls, uZClasses, Messages;

const
    UM_REFRESH_DIC = WM_USER + 1;
    // константи, у яких вказано відносні шляхи до основних файлів;
    WAY_INI     = 'tuning\ini\';
    WAY_IMAGES  = 'tuning\images\';
    WAY_LOG     = 'tuning\log\';
    WAY_FRF     = 'tuning\print\';

    WAY_BIN     = 'veles\';


    //саме такі імена необхідно давати експортованим з модулів (дллок)
    //процедурам (див.нижче), інакше буде помилка;
    FREE_PAGE_PROC_NAME = 'FreePage';
    SHOW_PAGE_FUNC_NAME = 'ShowPage';

    SHOW_PLUGIN_PROC_NAME = 'ShowPlugin';

    //значення які вертає функція TGetStartResult (див. нижче)
    RESULT_OK = 0;
    RESULT_FAIL = 1;
    RESULT_CANCEL = 2;

    xml_EXTENTION = '.XML';
    CRYPT_EXTENTION = '.XCR';

    //Перелік прав
    ACCESS_TO_PROGRAM           = 1;         //Вхід в програму

    GUEST_GROUP_ID              = 1;         //Використовується в Tfuser.InitInfo
    SYSTEM_GROUPS_LIMIT         = 100;       //Використовується в модулі Адміністратор
    ADMIN_GROUP_ID              = 2;         //використовується в довіднику Групи користувачів

    ACCESS_TO_USERS_DIC         = 30000;     //Доступ до довідника Користувачі
    ACCESS_TO_ADD_USER          = 30001;     //Додавання нового користувача
    ACCESS_TO_EDIT_USER         = 30002;     //Редагування користувача
    ACCESS_TO_DEL_USER          = 30003;     //Видалення користувача
    ACCESS_TO_ACTIVATE_USER     = 30004;     //Активація користувача
    ACCESS_TO_DEACTIVATE_USER   = 30005;     //Деактивація користувача
    ACCESS_TO_MODIFY_PASSWORDS  = 30006;     //Зміна паролів
    ACCESS_TO_EXPORT_USERS      = 30007;     //Експорт даних довідника "Користувачі"

    ACCESS_TO_GROUPS_DIC        = 40000;     //Доступ до довідника Групи користувачів
    ACCESS_TO_ADD_GROUP         = 40001;     //Створення нової групи
    ACCESS_TO_EDIT_GROUP        = 40002;     //Редагування групи
    ACCESS_TO_DEL_GROUP         = 40003;     //Видалення групи

    ACCESS_TO_BACKUP_DIC        = 50000;     //Доступ до довідника Архівація
    ACCESS_TO_ADD_BACKUP        = 50001;     //Право створювати шаблон архівації
    ACCESS_TO_EDIT_BACKUP       = 50004;     //Право редагувати шаблон архівації
    ACCESS_TO_DEL_BACKUP        = 50002;     //Право видаляти шаблон архівації
    ACCESS_TO_EXPORT_BACKUPS    = 50003;     //Експорт даних довідника "Архівація"
    ACCESS_TO_MAKE_BACKUPS      = 50005;     //Право здійснювати архівації

    ACCESS_TO_REPORTS_DIC       = 60000;     //Доступ до довідника Звіти

    ACCESS_TO_UNBLOCK           = 1000001;   // Довідник "Автозамовлення"

    ACCESS_TO_CONFIGS_DIC       = 70000;     //Доступ до довідника "Конфігурації"
    ACCESS_TO_ADD_CONFIG        = 70001;     //Створення нової конфігурації
    ACCESS_TO_EDIT_CONFIG       = 70002;     //Редагування конфігурації
    ACCESS_TO_DEL_CONFIG        = 70003;     //Видалення конфігурації

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

type
    //ZContainerId = class(ZContainerId)
    //end;
    // Структура, що передається в функції редагування записів.
    // Якщо id <= 0 то запис інсертиться, інакше редагується.
    // Інші ідентифікатори можуть використовуватись у виключних
    // випадках
    ZFuncArgs = record
        id: integer;
        id1: string;
        id2: string;
        id3: string;
        id4: string;
    end;

    //вказівники на компоненти головної форми програми (ядра);
    //використовуються в основному в процедурі TShowPage;
    ZControlPointers = record
        form,                         //TForm
        panel_ptr,                    //TPanel
        menu_ptr,                     //TMainMenu
        side_bar_ptr,                 //TdxSideBar
        status_bar_ptr,               //TStatusBar
        caption_ptr,                  //TPanel
        module_manager:       Pointer;//XModuleManager
    end;

    //Структура, котра містить додаткову інформацію
    ZCustom_data = record
        DateLife:     TDateTime;        //Для не сумісності
        DateOfDeath : TDateTime;        //Дата завершення ліцензії
//        code_dealer: Integer;
        pcode_dealer: ^Integer;
    end;

    //структура, що містить інформацію про програму, яка передається модулям
    //як параметр функції TShowPage; майже всі поля заповнюються в ядрі;
    //інші в процедурі TGetFuncResult;
    ZVelesInfoRec = record
        custom_data:      ZCustom_data;
        // Основні шляхи
        prog_way,
        root_way,
        server_ip,
        base_way,
        security_way:     array[0..255] of char;
        //reports_way,
        ini_way:          array[0..255] of char;

        //Основні налаштування
        version:     Integer;
        app_name:    array[0..255] of char;
        app_handle:  THandle;
        base:        Pointer;//TIBDatabase
        db_handle:   TISC_DB_HANDLE;

        // Права користувача
        user_id:          Integer;
        user_name,
        user_password,
        SYSDBA_password:  array[0..255] of char;

        control_pointers: ZControlPointers;
    end;

//*******************************procedures*************************************
    //процедури які мають бути задекларовані, реалізовані та екпортовані в модулях
    //(дллках) і за допомогою яких здійснюється створення та загрузка модулей
    //(точніше окремих сторінок (pages в термінах ядра)), а також їх вигрузка та
    //їх показ на головній формі

    //параметр a_prm містить інформацію про програму (див. вище);
    //частково заповнюється в ядрі - решта в дллці (з якої експортується дана функція);
    //значення яке вертається це результат роботи дллки, тобто якщо все нормально
    //RESULT_OK, неправильно або помилка - RESULT_FAIL, відміна - RESULT_CANCEL;
    //відповідно до результатів функції програма запуститься або припинить своє
    //виконання;
    //ім"я функції (тобто під яким іменем вона екпортується з дллки) задається
    //в xml файлі (<VelesAppInfo> -> <StartWork> -> <FunctionName>)
    TGetStartResult = function(var a_prm: ZVelesInfoRec): Integer; stdcall;

    //параметр a_prm містить інформацію про програму (див. вище);
    //поля app_handle, control_pointers використовуються для створення форми
    //модуля та прив"язки до головної форми програми;
    //значення яке вертається це перетворений в Longint вказівник на форму
    //модуля;
    //якщо сторінка ще не загружена то загружає (попередньо створивши її) та
    //показує; якщо сторінка вже загружена просто показує її;
    TShowPage = function(var a_prm: ZVelesInfoRec): Longint; stdcall;

    //знищує форму модуля; параметр a_form_ref це вказівник на форму модуля
    //отриманий процедурою TShowPage; після знищення форми модуля необхідно
    //вигрузити дллку (хоча, звичайно, не обов"язково);
    TFreePage = procedure(a_form_ref: Longint); stdcall;

    //показує плагін як модальну форму;
    ZShowPlugin = function(var a_prm: ZVelesInfoRec): Longint; stdcall;

    // Стандартна процедура створення/редагування запису
    ZRecordDialogFunc = function (var id: ZFuncArgs; var prm: ZVelesInfoRec): Integer;

//var
//  code_dealer: Integer;

//*******************************procedures*************************************

// Допоміжні процедури, що спрощують роботу над продуктом


implementation


end.
