unit usync_log;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, dxCntner, dxEditor, dxExEdtr, dxEdLib, StdCtrls, uZbutton, ExtCtrls,
  RxMemDS, kernel_h, IBSQL, IBDatabase, DB;

//report codes
const REPORT_CODE_NOMORE = 0; // Wip_Search => это последнее сообщение, больше не будет
const REPORT_CODE_OK	 = 1; // Wip_Search => еще одни весы откликнулись на опрос сети

type

  XLibraConnectionString = array [0..255] of char;
  lpXLibraConnectionString = ^XLibraConnectionString;
  XLibraType  = (
	  LIBRA_LT_NONE         = $00,
	  LIBRA_LT_LP           = $01,
	  LIBRA_LT_MASSA_K_VPM   = $02,
	  LIBRA_LT_MASSA_K_VP    = $03,
	  LIBRA_LT_TIGER_D      = $04
  );

  XLibraCallBack = procedure (str: PChar);


//Отчет по обмену файлами (прием/передача)
  TWip_FileReport = record
    nReportCode: Integer; //+error codes
	  lpszFilename: PChar;
	  nFileType: Byte;
	  nTotalCount: Word;
	  nCurrentNum: Word;
  end;

  Tfsync_log = class(TForm)
    Panel1: TPanel;
    bt_ok: ZButton;
    ed_log: TdxMemo;
    base: TIBDatabase;
    tr_R: TIBTransaction;
    q_R: TIBSQL;
    bt_go: ZButton;
    procedure bt_goClick(Sender: TObject);
  private
    { Private declarations }
  public
    prm: ZVelesInfoRec;
    mem_dic: TRxMemoryData;

    procedure InitInfo;
    procedure SyncCurrentScale;

  end;

procedure ScaleSyncLog(var imem_dic: TRxMemoryData; var prm: ZVelesInfoRec);

var sync_log: Tfsync_log;

implementation

{$R *.dfm}

function LibraConnect(im_hWnd: HWnd; handle: pointer; prog_way: PChar; itype: integer;
        icall_finc: pointer; iconnection_strings: lpXLibraConnectionString): integer; stdcall; external 'libra.dll';
function LibraTovarAdd(handle: pointer; nomen_num: integer; name: PChar; price: double; date: PChar; termin: integer; art_num: integer): integer; stdcall; external 'libra.dll';
function LibraProgrammingAllTovar(handle: pointer): integer; stdcall; external 'libra.dll';
function LibraDisconnect(handle: pointer): integer; stdcall; external 'libra.dll';

procedure ScaleSyncLog(var imem_dic: TRxMemoryData; var prm: ZVelesInfoRec);

begin
try
  sync_log := Tfsync_log.Create(Application);
  sync_log.mem_dic := imem_dic;
  sync_log.prm := prm;
  sync_log.InitInfo;

  sync_log.ShowModal;

finally
  sync_log.Free;
end;

end;

procedure AddToLog(str: PChar); stdcall;
begin
  sync_log.ed_log.Lines.Add(str);
  sync_log.ed_log.Refresh;
 // Lines.Add(str);
end;

procedure Tfsync_log.InitInfo;
begin
  base.SetHandle(prm.db_handle);
end;

procedure Tfsync_log.bt_goClick(Sender: TObject);
begin
  mem_dic.First;
  while not mem_dic.Eof do
  begin
    if mem_dic.FieldByName('is_sync').AsBoolean then
      SyncCurrentScale;
    mem_dic.Next;
  end;
end;

procedure Tfsync_log.SyncCurrentScale;
var conn_lines: array [0..20] of XLibraConnectionString;
  libra: pointer;
  prm_pos: integer;
  add_pure_rest: integer;
  libra_num: string;
  counter: integer;
begin
  if mem_dic.FieldByName('scale_interface_id').AsInteger = 0 then
    strcopy(conn_lines[0], PAnsiChar('connection=COM'))
  else
    strcopy(conn_lines[0], PAnsiChar('connection=Eithernet'));
  strcopy(conn_lines[1], PChar('number=' + mem_dic.FieldByName('number').AsString));
  strcopy(conn_lines[2], PChar('prefix=' + mem_dic.FieldByName('prefix').AsString));
  strcopy(conn_lines[3], PChar('ip=' + mem_dic.FieldByName('ip').AsString));

  LibraConnect(self.Handle,
      libra,
      prm.prog_way,
      mem_dic.FieldByName('scale_type_id').AsInteger,
      @AddToLog,
      @conn_lines);


  if tr_R.InTransaction then tr_R.Commit;
  tr_R.StartTransaction;
   q_R.Close;
   q_R.SQL.Text := 'select onomen_id,  onomen_code, onomen_name, oout_price, ' +
' odate, otermin, oart_num from PS_SCALE_NOMENS(:iadd_pure_rest, :ilibra_num, :icode_dealer)  order by onomen_code';
   //if mem_dic.FieldByName('with_zero_rest').AsBoolean then
     add_pure_rest := 1;
  // else
  //   add_pure_rest := 0;
   libra_num := '25'; //IntToStr(mem_dic.FieldByName('prefix').AsInteger);
	 q_R.ParamByName('iadd_pure_rest').AsInteger := add_pure_rest; //
	 q_R.ParamByName('ilibra_num').AsString := libra_num; //
   q_R.ParamByName('icode_dealer').AsInteger := 0;
   q_R.ExecQuery;
   counter := 0;
   while not q_R.Eof do
   begin
      LibraTovarAdd(libra, q_R.FieldByName('onomen_code').AsInteger,
             PChar(q_R.FieldByName('onomen_name').AsString),
             q_R.FieldByName('oout_price').AsDouble,
             PChar(q_R.FieldByName('odate').AsString),
             q_R.FieldByName('otermin').AsInteger,
             q_R.FieldByName('oart_num').AsInteger);
      q_R.Next;
      counter := counter + 1;
   end;
  if tr_R.InTransaction then tr_R.Commit;

  LibraProgrammingAllTovar(libra);

  LibraDisconnect(libra);
end;

end.
