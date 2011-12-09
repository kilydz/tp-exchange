unit sync_LC_h;

interface
uses veles_h;


//  Список груп команд 4-символа
const
        PORTNUM = 7777;

        CMD_DO_ON_BACK = 'DOBK';     // Виконання в магазині
        CMD_DO_ON_FRONT = 'DOFR';     // Виконання в офісі
        CMD_SEND_TO_SERVER = 'SNDD';   // Відсилання даних
        CMD_GET_FROM_SERVER = 'GETD';  // Отримання даних
        CMD_READ_FROM_BASE = 'RBAS';   // Видерти дані з бази
        CMD_WRITE_TO_BASE = 'WBAS';   // Вставити дані в базу

//  Список команд 8-символів
        CMD_TYPEDISC = 'TYPEDISC';   // Типи дисконту
        CMD_DISCONTS = 'DISCONTS';   // Дисконтники
        CMD_DISC_INF = 'DISC_INF';   // Повні дані про дисконтників
        CMD_NOMENEXP = 'NOMENEXP';   // Номенклатура
        CMD_PRICEZVT = 'PRICEZVT';   // Звіт по цінах
        CMD_RALACZVT = 'RALACZVT';   // Звіт по реалізації
        CMD_KARDSZVT = 'KARDSZVT';   // Звіт по реалізації по картках
        CMD_GROUPZVT = 'GROUPZVT';   // Звіт по реалізації по групах
        CMD_SCRIPTMD = 'SCRIPTMD';   // Одержати скрипт метаданих з магазину
        CMD_SCRIPTDO = 'SCRIPTDO';   // Виконати скрипт

type lpfLogCallback = function(str: PChar): integer; //stdcall;

function clnt_init_socket(pLogCallback: lpfLogCallback; vdstway: PChar): integer; stdcall  //  ініціалізація сокета
          external 'veles_clnt.dll' name 'clnt_init_socket';

procedure clnt_free_socket; stdcall;
          external 'veles_clnt.dll' name 'clnt_free_socket';

function clnt_connect_to_host(port: integer; host: PChar; proxy_port: integer; proxy_host: PChar): integer;  stdcall // підключення до хоста
          external 'veles_clnt.dll' name 'clnt_connect_to_host';

function clnt_send_command(type_cmd, cmd, sql_buf: PChar): integer;  stdcall   // послати команду
          external 'veles_clnt.dll' name 'clnt_send_command';

function clnt_close_socket(): integer;  stdcall // Закриття сокету
          external 'veles_clnt.dll' name 'clnt_close_socket';

function clnt_file_copy(src, dst: PChar): integer; stdcall //Копіювання файлу
          external 'veles_clnt.dll' name 'clnt_file_copy';

function veles_file_unzip(gz_name, dst_file_name: PChar): integer; stdcall
          external 'veles_clnt.dll' name 'veles_file_unzip';

function veles_file_zip(src_file_name, gz_name: PChar): integer; stdcall
          external 'veles_clnt.dll' name 'veles_file_zip';

function RemoteDialog(prm: ZVelesInfoRec): integer;
          external 'remote.dll' name 'RemoteDialog';

implementation

end.

