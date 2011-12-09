unit sync_LC_h;

interface
uses veles_h;


//  ������ ���� ������ 4-�������
const
        PORTNUM = 7777;

        CMD_DO_ON_BACK = 'DOBK';     // ��������� � �������
        CMD_DO_ON_FRONT = 'DOFR';     // ��������� � ����
        CMD_SEND_TO_SERVER = 'SNDD';   // ³�������� �����
        CMD_GET_FROM_SERVER = 'GETD';  // ��������� �����
        CMD_READ_FROM_BASE = 'RBAS';   // ������� ��� � ����
        CMD_WRITE_TO_BASE = 'WBAS';   // �������� ��� � ����

//  ������ ������ 8-�������
        CMD_TYPEDISC = 'TYPEDISC';   // ���� ��������
        CMD_DISCONTS = 'DISCONTS';   // �����������
        CMD_DISC_INF = 'DISC_INF';   // ���� ��� ��� �����������
        CMD_NOMENEXP = 'NOMENEXP';   // ������������
        CMD_PRICEZVT = 'PRICEZVT';   // ��� �� �����
        CMD_RALACZVT = 'RALACZVT';   // ��� �� ���������
        CMD_KARDSZVT = 'KARDSZVT';   // ��� �� ��������� �� �������
        CMD_GROUPZVT = 'GROUPZVT';   // ��� �� ��������� �� ������
        CMD_SCRIPTMD = 'SCRIPTMD';   // �������� ������ ��������� � ��������
        CMD_SCRIPTDO = 'SCRIPTDO';   // �������� ������

type lpfLogCallback = function(str: PChar): integer; //stdcall;

function clnt_init_socket(pLogCallback: lpfLogCallback; vdstway: PChar): integer; stdcall  //  ����������� ������
          external 'veles_clnt.dll' name 'clnt_init_socket';

procedure clnt_free_socket; stdcall;
          external 'veles_clnt.dll' name 'clnt_free_socket';

function clnt_connect_to_host(port: integer; host: PChar; proxy_port: integer; proxy_host: PChar): integer;  stdcall // ���������� �� �����
          external 'veles_clnt.dll' name 'clnt_connect_to_host';

function clnt_send_command(type_cmd, cmd, sql_buf: PChar): integer;  stdcall   // ������� �������
          external 'veles_clnt.dll' name 'clnt_send_command';

function clnt_close_socket(): integer;  stdcall // �������� ������
          external 'veles_clnt.dll' name 'clnt_close_socket';

function clnt_file_copy(src, dst: PChar): integer; stdcall //��������� �����
          external 'veles_clnt.dll' name 'clnt_file_copy';

function veles_file_unzip(gz_name, dst_file_name: PChar): integer; stdcall
          external 'veles_clnt.dll' name 'veles_file_unzip';

function veles_file_zip(src_file_name, gz_name: PChar): integer; stdcall
          external 'veles_clnt.dll' name 'veles_file_zip';

function RemoteDialog(prm: ZVelesInfoRec): integer;
          external 'remote.dll' name 'RemoteDialog';

implementation

end.

