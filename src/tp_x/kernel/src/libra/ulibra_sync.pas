unit ulibra_sync;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, dxCntner, Tabs, StdCtrls, Buttons, dxExEdtr, dxEdLib, dxEditor,
  ExtCtrls, ComCtrls, IB,
  kernel_h, ImgList, IBSQL, IBDatabase, DB, Grids, ToolWin, ExtDlgs,
  uZToolBar, etalon_dlg, secure_h, libra_sync_h, IniFiles, CheckLst,
  uZFilterCombo, DIGI_SP, scale, shtrih_print, uZMaster, uZToolButton;

type
  Tfnomen = class(Tfetalon_dlg)
    TabSheet1: TTabSheet;
    TabSheet2: TTabSheet;
    pStage1: TPanel;
    pStage0: TPanel;
    Label4: TLabel;
    ed_libra_type: TdxImageEdit;
    pb_progress: TProgressBar;
    ed_log: TdxMemo;
    Panel_COM: TPanel;
    Label2: TLabel;
    ed_port: TdxImageEdit;
    Label3: TLabel;
    ed_speed: TdxImageEdit;
    Panel_fname: TPanel;
    export_dialog: TSaveDialog;
    Panel_Ethernet: TGroupBox;
    ed_scales: ZFilterCombo;
    ZToolBar1: ZToolBar;
    tr_R: TIBTransaction;
    q_R: TIBSQL;
    panel_scale_no: TPanel;
    Label1: TLabel;
    ed_libra_num: TdxImageEdit;
    tr_R2: TIBTransaction;
    q_R2: TIBSQL;
    ed_ZeroPrograming: TCheckBox;
    Label5: TLabel;
    ed_file_name: TdxButtonEdit;
    bt_ins_scale: ZToolButton;
    ImageList1: TImageList;
    bt_upd_scale: ZToolButton;
    bt_del_scale: ZToolButton;
    procedure ed_file_nameButtonClick(Sender: TObject; AbsoluteIndex: Integer);
    procedure ed_libra_typeChange(Sender: TObject);
    procedure EditsKeyPress(Sender: TObject; var Key: Char); override;
    procedure FormDestroy(Sender: TObject); override;
    procedure masterPageChange(Sender: TObject; NewTab: Integer;
      var AllowChange: Boolean);
    procedure ScaleClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }

    procedure InitInfo; override;
    procedure InitINS; override;
    procedure InitUPD; override;
    procedure InitControls; override;

    function  AnalizChanges: integer; override;
    procedure ApplyChanges; override;
    procedure ApplyControls; override;
    procedure ApplyINS; override;
    procedure ApplyUPD; override;
    procedure ApplyDefault; override;

    function IntToSpaseStr(value:integer; lng:integer):string;
    function FloatToSpaseStr(value:real):string;
    function StrToSpaseStr(value:string; lng:integer):string;
    function CreateNomenLine(nomen_No, nomen_code:integer; nomen_name:string; price:real; termin: integer):string;
    function CreateNomenLine1(nomen_No, nomen_code:integer; nomen_name:string; price:real; termin: integer):string;

    procedure SetNomenCount(libra_num :byte);

    procedure DigiSyncExecute(libra_num: byte);
    procedure ShtrihPrSyncExecute(libra_num: byte);
    procedure TigerDSyncExecute(libra_num: byte);

    procedure EthernetSyncExecute;
    procedure InitScale;
  end;

function LibraSyncDialog(var prm: ZVelesInfoRec): Longint; stdcall;

implementation

{$R *.dfm}

function LibraSyncDialog(var prm: ZVelesInfoRec): Longint; stdcall;
var
  dlg: Tfnomen;
  returned: integer;
begin
// Перевірка прав
  returned := 0;
  Result := -1;
//  if not HasUserAccess(prm.db_handle, prm.user_id, ACCESS_TO_NOMEN_INS_UPD) then
//      Exit;
try
// Створення та ініціалізація форми діалогу.
    dlg := Tfnomen.Create(Application);
    dlg.prm := prm;
    dlg.InitInfo;
// Візуалізація діалогу

    dlg.ShowModal;

finally
  dlg.Free;
end;
//    returned <= 0 - код помилки, або відмова;
//    returned > 0  - id результату;
  Result := returned;
end;

//------------------------------------------------------------------------------
//
//------------------------------------------------------------------------------
procedure TFnomen.InitInfo;
var f: TIniFile;
begin
  inherited InitInfo;

  //Налаштування виводу в файл
  f := TIniFile.Create(prm.root_way + WAY_INI + 'libra_sync.ini');
   ed_file_name.Text := f.ReadString('Ways', 'file_name', '\..\plu.txt');
   ed_libra_num.Text := f.ReadString('General', 'libra_num', '22');
   ed_libra_type.Text := f.ReadString('General', 'libra_type', 'Ethernet');
  f.Free;

  //Налаштування списку ваг Ethernet-синхронізації
  ed_scales.InitFilter;
  InitScale;
end;

procedure TFnomen.InitScale;
begin
  if trR.InTransaction then trR.Commit;
  trR.StartTransaction;
  qR.SQL.Text := 'select id, ''[''||ip||''] ''||name as name ' +
                 '  from t_scales s                          ' +
                 ' order by ip ';
   qR.ExecQuery;
   ed_scales.Clear;
   while not qR.Eof do
   begin
     ed_scales.AddLine(qR.FieldByName('name').AsString, qR.FieldByName('id').AsInteger);
     qR.Next;
   end;
  if trR.InTransaction then trR.Commit;
end;

procedure TFnomen.InitINS;
begin
//
end;

procedure Tfnomen.InitUPD;
begin
//
end;

procedure Tfnomen.InitControls;
begin
//
end;

function TFnomen.AnalizChanges: integer;
var returned: integer;
begin
  returned := 0;
  AnalizChanges := returned;
end;

procedure TFnomen.ApplyChanges;
begin
  inherited ApplyChanges;
end;

procedure Tfnomen.ApplyControls;
begin
//
end;

procedure Tfnomen.ApplyINS;
begin
//
end;

procedure Tfnomen.ApplyUPD;
begin
//
end;

procedure Tfnomen.ApplyDefault;
begin
//
end;

procedure Tfnomen.EditsKeyPress(Sender: TObject; var Key: Char);
var currWin: TWinControl;
begin
  currWin := TWinControl(Sender);

  inherited EditsKeyPress(Sender, Key);
end;

procedure Tfnomen.ed_file_nameButtonClick(Sender: TObject;
  AbsoluteIndex: Integer);
begin
  inherited;
  if export_dialog.Execute then
    ed_file_name.Text := export_dialog.FileName;
end;

procedure Tfnomen.ed_libra_typeChange(Sender: TObject);
begin
  ed_libra_num.Values.LineBreak := ',';
  ed_libra_num.Descriptions.LineBreak := ',';
  if ed_libra_type.Text = 'CAS LP v1.5' then
  begin
    panel_COM.Visible       := True;
    panel_fname.Visible     := False;
    panel_Ethernet.Visible  := False;
    ed_libra_num.Descriptions.Text := '22,28';
    ed_libra_num.Values.Text := '22,28';
    if ed_libra_num.Text = '1' then
      ed_libra_num.Text := '22';
  end else
  if (ed_libra_type.Text = 'METLER Tiger D')or(ed_libra_type.Text = 'METLER Tiger D (1line)') then
  begin
    panel_COM.Visible       := False;
    panel_fname.Visible     := True;
    panel_Ethernet.Visible  := False;
    ed_libra_num.Descriptions.Text := '22,28';
    ed_libra_num.Values.Text := '22,28';
    if ed_libra_num.Text = '1' then
      ed_libra_num.Text := '22';
  end else
  if ed_libra_type.Text = 'Ethernet' then
  begin
    panel_COM.Visible       := False;
    panel_fname.Visible     := False;
    panel_Ethernet.Visible  := True;
    ed_libra_num.Descriptions.Text := '22,28,1';
    ed_libra_num.Values.Text := '22,28,1';
  end;
end;

procedure Tfnomen.FormDestroy(Sender: TObject);
  var f: TIniFile;
begin
  inherited FormDestroy(Sender);

  f := TIniFile.Create(prm.root_way + WAY_INI + 'libra_sync.ini');
  f.WriteString('Ways', 'file_name', ed_file_name.Text);
  f.WriteString('General', 'libra_num', ed_libra_num.Text);
  f.WriteString('General', 'libra_type', ed_libra_type.Text);
  f.Free;
end;

procedure Tfnomen.masterPageChange(Sender: TObject; NewTab: Integer;
  var AllowChange: Boolean);
var libra_num: byte;
    speed, port, Plu_No :integer;
    file_name, str_line :string;
    str_data: TStrings;
begin
  if (NewTab = 1) then
  begin
    libra_num := StrToInt(ed_libra_num.Text);
    speed := StrToInt(ed_speed.Text);
    port := StrToInt(ed_port.Text);
    file_name := ed_file_name.Text;

    ed_log.Lines.Add('***  Початок вигрузки   ***');
  if ed_libra_type.Text = 'Ethernet' then
     EthernetSyncExecute
  else
  begin
  try
    SetNomenCount(libra_num);
    //Prepeare Block
    if ed_libra_type.Text = 'CAS LP v1.5' then
     begin
       LibraConnect(port, speed, libra_num);
       LibraSWAdaptor;
     end else
     if (ed_libra_type.Text = 'METLER Tiger D')or(ed_libra_type.Text = 'METLER Tiger D (1line)') then
     begin
       str_data := TStringList.Create;
     end;

    if trR.InTransaction then trR.Commit;
    trR.StartTransaction;
    if ed_ZeroPrograming.Checked then    
      qR.SQL.Text :=  ' select n.nomen_code, n.nomen_name, n.datex_name,  ' +
                      '        around(n.out_price) as price, termin       ' +
                      '   from t_nomens n                                    ' +
                      '  where nomen_code like ''' + IntToStr(libra_num) + '%'' '
    else
      qR.SQL.Text :=  ' select n.nomen_code, n.nomen_name, n.datex_name,  ' +
                      '        around(n.out_price) as price, termin       ' +
                      '   from t_nomens n, t_rests r                             ' +
                      '  where r.nomen_id = n.nomen_id                and ' +
                      '       ((r.rest < -0.001)or(r.rest > 0.001))   and ' +
                      '        n.nomen_code like ''' + IntToStr(libra_num) + '%'' ';
    qR.ExecQuery;

     ed_log.Lines.Add('  процес експорту........');
     pb_progress.Position := 0;
     //Nomens Add Block
     if ed_libra_type.Text = 'CAS LP v1.5' then
     begin
       while not qR.Eof do
       begin
         Plu_No := qR.FieldByName('nomen_code').AsInteger - (StrToInt(ed_libra_num.Text) * 10000);
         if ((Plu_no < 1) or (Plu_No > 3999)) then
           ed_log.Lines.Add('Увага! Товар ' + q_R.FieldByName('nomen_name').AsString  +
                ' не запрограмовано. Код ' + IntToStr(Plu_no) + ' > '+ IntToStr(3999) +
                ' або ' + IntToStr(Plu_no) + ' < 1' )
         else
           if (LibraProgrammingTovar(Plu_No, PChar(qR.FieldByName('nomen_name').AsString),
                             qR.FieldByName('price').AsCurrency) <> 0) then
           begin
             raise Exception.Create('-- ПОМИЛКА --');
           end;

          pb_progress.Position := pb_progress.Position + 1;
          qR.Next;
       end;
     end else
     if (ed_libra_type.Text = 'METLER Tiger D')or(ed_libra_type.Text = 'METLER Tiger D (1line)') then
     begin
       while not qR.Eof do
       begin
         if (ed_libra_type.Text = 'METLER Tiger D') then
         str_line := CreateNomenLine(qR.FieldByName('nomen_code').AsInteger - (StrToInt(ed_libra_num.Text) * 10000),
                        qR.FieldByName('nomen_code').AsInteger,
                        PChar(qR.FieldByName('nomen_name').AsString),
                        qR.FieldByName('price').AsCurrency,
                        qR.FieldByName('termin').AsInteger) else
         if (ed_libra_type.Text = 'METLER Tiger D (1line)') then
         str_line := CreateNomenLine1(qR.FieldByName('nomen_code').AsInteger - (StrToInt(ed_libra_num.Text) * 10000),
                        qR.FieldByName('nomen_code').AsInteger,
                        PChar(qR.FieldByName('nomen_name').AsString),
                        qR.FieldByName('price').AsCurrency,
                        qR.FieldByName('termin').AsInteger);
          str_data.Add(str_line);

          pb_progress.Position := pb_progress.Position + 1;
          qR.Next;
       end;
     end;

     ed_log.Lines.Add('  відключення від ваги');
     ed_log.Lines.Add('*** Завершення вигрузки ***');
     ed_log.Lines.Add('***************************');
     ed_log.Lines.Add('Бажаємо приємної роботи :-)');
     ed_log.Lines.Add('***************************');

  except
    on E: Exception do
       ed_log.Lines.Add(E.Message);
  end;
   if ed_libra_type.Text = 'CAS LP v1.5' then
      LibraDisconnect
    else
    if (ed_libra_type.Text = 'METLER Tiger D')or(ed_libra_type.Text = 'METLER Tiger D (1line)') then
    begin
      str_data.SaveToFile(ed_file_name.Text);
      str_data.Destroy;
    end;
  if trR.InTransaction then trR.Commit;
  end;
 //   FreeLibrary(lib_handle);
  end
end;

function Tfnomen.IntToSpaseStr(value:integer; lng:integer):string;
var str_val:string;
    i, val_diff: integer;
begin
  if value < 0 then
    value := 0;
  str_val := IntToStr(value);
  Result := '';
  val_diff := lng - length(str_val);
  for I := 1 to val_diff do
    Result := Result + ' ';
  if length(str_val) <= lng then
    Result := Result + str_val
  else
    Result := Copy(str_val, -val_diff - 1, lng);
end;

function Tfnomen.FloatToSpaseStr(value:real):string;
var str_val, before_point, after_point:string;
    i, val_diff: integer;
    is_point: boolean;
    ch: char;
begin
  if value < 0.002    then  value := 0.00 else
  if value > 99999.99 then  value := 99999.99;

  value := value + 0.005;

  str_val := FloatToStr(value);

  Result       := '';
  after_point  := '';
  before_point := '';
  is_point     := False;

  for I := 1 to length(str_val) do
  begin
    ch := str_val[i];
    if ch = ',' then is_point := True
    else
    begin
      if is_point then
        after_point  := after_point + ch
      else
        before_point := before_point + ch;
    end;
  end;
  val_diff     := 5 - length(before_point);
  for I := 1 to val_diff do
    Result := Result + ' ';
  if val_diff < 0 then
    before_point := Copy(before_point, -val_diff - 1, 5);

  after_point := copy(after_point, 0, 2);
  if length(after_point) = 1 then after_point := after_point + '0' else
  if length(after_point) = 0 then after_point := '00';

  Result := Result + before_point + '.' + after_point;
end;

function Tfnomen.StrToSpaseStr(value:string; lng:integer):string;
var i, val_diff: integer;
begin
  val_diff := lng - length(value);
  if length(value) <= lng then
    Result := Result + value
  else
    Result := Copy(value, 0, lng);
  for I := 1 to val_diff do
    Result := Result + ' ';
  for I := 1 to lng do
    if Result[i] = ',' then
       Result[i] := '.';
end;

function Tfnomen.CreateNomenLine(nomen_No, nomen_code:integer;
 nomen_name:string; price:real; termin: integer):string;
begin
  Result := IntToSpaseStr(nomen_No, 6)    + ',' +   //PLU #
            IntToSpaseStr(nomen_code, 13) + ',' +   //Артикул
            IntToSpaseStr(0, 2)           + ',' +   //Група
            FloatToSpaseStr(price)        + ',' +   //Ціна
            IntToSpaseStr(0, 2)           + ',' +   //Tapa
            IntToSpaseStr(0, 3)           + ',' +   //№ додаткового тексту
            IntToSpaseStr(0, 1)           + ',' +   //PDV
            IntToSpaseStr(0, 3)           + ',' +   //Зміщення дати
            IntToSpaseStr(termin, 3)      + ',' +   //Зміщення строку придатності
            IntToSpaseStr(0, 8)           + ',' +   //Фіксована вага
            IntToSpaseStr(0, 1)           + ',' +   //Тип PLU (By Weight / By Count)
            IntToSpaseStr(0, 1)           + ',' +   //Вільна ціна (No / Yes)
            IntToSpaseStr(0, 1)           + ',' +   //Скидка (No / Yes)
            StrToSpaseStr(nomen_name, 30) + ',' +   //Назва PLU
            '';                                     //Назва PLU2
end;

function Tfnomen.CreateNomenLine1(nomen_No, nomen_code:integer;
 nomen_name:string; price:real; termin: integer):string;
begin
  Result := IntToSpaseStr(nomen_No, 6)    + ',' +   //PLU #
            IntToSpaseStr(nomen_code, 13) + ',' +   //Артикул
            IntToSpaseStr(0, 2)           + ',' +   //Група
            FloatToSpaseStr(price)        + ',' +   //Ціна
            IntToSpaseStr(0, 2)           + ',' +   //Tapa
            IntToSpaseStr(0, 3)           + ',' +   //№ додаткового тексту
            IntToSpaseStr(0, 1)           + ',' +   //PDV
            IntToSpaseStr(0, 3)           + ',' +   //Зміщення дати
            IntToSpaseStr(termin, 3)      + ',' +   //Зміщення строку придатності
            IntToSpaseStr(0, 8)           + ',' +   //Фіксована вага
            IntToSpaseStr(0, 1)           + ',' +   //Тип PLU (By Weight / By Count)
            IntToSpaseStr(0, 1)           + ',' +   //Вільна ціна (No / Yes)
            IntToSpaseStr(0, 1)           + ',' +   //Скидка (No / Yes)
            StrToSpaseStr(nomen_name, 28);          //Назва PLU
end;

procedure Tfnomen.SetNomenCount(libra_num :byte);
begin
  if trR.InTransaction then trR.Commit;
  trR.StartTransaction;
  if libra_num < 0 then
    qR.SQL.Text := ' select count(n.nomen_id) as cnt from t_nomens n where is_weight = 1'
  else
    if ed_ZeroPrograming.Checked then
      qR.SQL.Text := ' select count(n.nomen_id) as cnt from t_nomens n where nomen_code like (' +
                 #39 + IntToStr(libra_num) + '%' + #39 + ') '
   else
      qR.SQL.Text :=  ' select count(n.nomen_id) as cnt                   ' +
                      '   from t_nomens n, t_rests r                             ' +
                      '  where r.nomen_id = n.nomen_id                and ' +
                      '       ((r.rest < -0.001)or(r.rest > 0.001))   and ' +
                      '        n.nomen_code like ''' + IntToStr(libra_num) + '%'' ';

  qR.ExecQuery;
  pb_progress.Max := qR.FieldByName('cnt').AsInteger;
  ed_log.Lines.Add('  загальна к-ть товарів: ' + IntToStr(pb_progress.Max));
  qR.Close;
  if trR.InTransaction then trR.Commit;
end;

procedure Tfnomen.EthernetSyncExecute;
var libra_num: byte;
begin
try
  libra_num := StrToInt(ed_libra_num.Text);

  if tr_R.InTransaction then tr_R.Commit;
  tr_R.StartTransaction;
  q_R.SQL.Clear;
  q_R.SQL.Add('select distinct otype_scale '+
              '  from ps_scales_view( ''' + ed_scales.GenerateSpaceList +''') ');
  q_R.ExecQuery;
  while not q_R.Eof do
  begin
    if q_R.FieldByName('otype_scale').AsInteger = 1 then
    begin
    // DIGI SP (SP-80SX, SP-90, SP-300, SP-500)
      DigiSyncExecute(libra_num);
    end else
    if q_R.FieldByName('otype_scale').AsInteger = 2 then //Штрих-Принт
    begin
    // Shtrih - Print
      ShtrihPrSyncExecute(libra_num);
    end else
    if q_R.FieldByName('otype_scale').AsInteger = 3 then //METLER Tiger D
    begin
    // METLER Tiger D
      TigerDSyncExecute(libra_num);
    end;
    q_R.Next;
  end;

  if tr_R.InTransaction then tr_R.Commit;

     ed_log.Lines.Add('*** Завершення вигрузки ***');
     ed_log.Lines.Add('***************************');
     ed_log.Lines.Add('Бажаємо приємної роботи :-)');
     ed_log.Lines.Add('***************************');

  except
    on E: Exception do
       ed_log.Lines.Add(E.Message);
  end;
end;

procedure Tfnomen.DigiSyncExecute(libra_num: byte);
var
  //str_data: TStrings;
  FileName: string;
  flag: string[2];
  nomen_no, type_barcode, multiplier : integer;
  str_file :TextFile;
begin
  ed_log.Lines.Add('+++++++Синхронізація ваг DIGI SP++++++++');
  //Генерування файлу для пересилки
  FileName := prm.root_way + 'TmpNomenDigiSP.dat';
  //str_data := TStringList.Create;
  AssignFile(str_file, FileName);
  ReWrite(str_file);
  try
  SetNomenCount(libra_num);

  if (libra_num = 1) then
  begin
    flag          := '21';
    type_barcode  := 5;
    multiplier    := 100000;
  end else //if (libra_num = 1) then
  begin
    flag          := ed_libra_num.Text;
    type_barcode  := 9;
    multiplier    := 10000;
  end;

  if trR.InTransaction then trR.Commit;
  trR.StartTransaction;

  if ed_ZeroPrograming.Checked then
    qR.SQL.Text := ' select n.nomen_code, n.nomen_name, around(n.out_price) as price ' +
                   '   from t_nomens n                                                  ' +
                   '  where n.nomen_code like ''' + IntToStr(libra_num) + '%''       '
  else
    qR.SQL.Text := ' select n.nomen_code, n.nomen_name, around(n.out_price) as price ' +
                   '   from t_nomens n, t_rests r                                           ' +
                   '  where n.nomen_id = r.nomen_id                            and   ' +
                   '        n.nomen_code like ''' + IntToStr(libra_num) + '%'' and   ' +
                   '       ((r.rest < -0.001)or(r.rest > 0.001)) ';
  qR.ExecQuery;

  ed_log.Lines.Add('  створення файлу з номенклатурою для ваг DIGI SP...');
  Application.ProcessMessages;
  pb_progress.Position := 0;
 // str_data.LineBreak := '';
  while not qR.Eof do
  begin
    Write(str_file,
         DigiGenNomenLine(qR.FieldByName('nomen_code').AsInteger - (libra_num * multiplier),
                          flag,
                          qR.FieldByName('nomen_name').AsString,
                          qR.FieldByName('price').AsCurrency,
                          type_barcode));

    pb_progress.Position := pb_progress.Position + 1;
    qR.Next;
  end;
  if trR.InTransaction then trR.Commit;

//  str_data.SaveToFile(FileName);
 CloseFile(str_file);
  ed_log.Lines.Add('  ОК...');
  //Синхронізація з вагами
  trR.StartTransaction;
  qR.SQL.Text := 'select oip, oname '+
                 '  from ps_scales_view( ''' + ed_scales.GenerateSpaceList +''') '+
                 ' where otype_scale = 1 ';
  qR.ExecQuery;
  while not qR.Eof do
  begin
    ed_log.Lines.Add('--Синхронізація ваги [' + qR.FieldByName('oip').AsString +
                     '] ' + qR.FieldByName('oname').AsString);
    Application.ProcessMessages;
       {УВАГА!!!! У всіх описах номера файлів ваги даються в HEX формать,
        а дана функція приймає значення в десятковому форматі.
        Приклад: В описі номер файлу 25, а подавати потрібно 37}
    ed_log.Lines.Add(DigiGenStringError(
           DigiExecute(UPLOAD, PChar(qR.FieldByName('oip').AsString), PChar(FileName), 37)));

    qR.Next;
  end;
  if trR.InTransaction then trR.Commit;
  finally
    //str_data.Destroy;
  end;
end;

procedure Tfnomen.ShtrihPrSyncExecute(libra_num: byte);
var
  LP: Variant;
  flag: string[2];
  nomen_no, multiplier, PLUCount, nomen_code :integer;
  mes :string;
begin
  ed_log.Lines.Add('+++++++Синхронізація ваг Штрих-Принт++++++++');

  if (libra_num = 1) then
  begin
    flag          := '21';
    multiplier    := 100000;
  end else //if (libra_num = 1) then
  begin
    flag          := ed_libra_num.Text;
    multiplier    := 10000;
  end;
  try
  //Синхронізація з вагами
  SetNomenCount(libra_num);
  trR.StartTransaction;
  qR.SQL.Text := 'select oip, oname '+
                 '  from ps_scales_view( ''' + ed_scales.GenerateSpaceList +' '') '+
                 ' where otype_scale = 2 ';
  qR.ExecQuery;

  if not ShtrihPrInitDriver(LP, mes) then
  begin
    ed_log.Lines.Add(mes);
    raise Exception.Create('-- ПОМИЛКА --');
  end;
  if tr_R2.InTransaction then tr_R2.Commit;
  tr_R2.StartTransaction;

  while not qR.Eof do
  begin
    ed_log.Lines.Add('--Синхронізація ваги [' + qR.FieldByName('oip').AsString +
                     '] ' + qR.FieldByName('oname').AsString);
    Application.ProcessMessages;
    if not ShtrihPrEthernetConnect(LP, qR.FieldByName('oip').AsString) then
      ed_log.Lines.Add(ShtrihPrGenStringError(LP))
    else
    begin
      ShtrihPrSetBarcodePropertys(LP, flag);
      PLUCount := ShtrihPrPLUCount(LP);
      ed_log.Lines.Add(ShtrihPrGenStringError(LP));

      if ed_ZeroPrograming.Checked then
        q_R2.SQL.Text := ' select n.nomen_code, n.nomen_name, around(n.out_price) as price ' +
                         '   from t_nomens n                                                  ' +
                         '  where n.nomen_code like ''' + IntToStr(libra_num) + '%''       '
     else
        q_R2.SQL.Text := ' select n.nomen_code, n.nomen_name, around(n.out_price) as price ' +
                         '   from t_nomens n, t_rests r                                           ' +
                         '  where n.nomen_id = r.nomen_id                            and   ' +
                         '        n.nomen_code like ''' + IntToStr(libra_num) + '%'' and   ' +
                         '       ((r.rest < -0.001)or(r.rest > 0.001)) ';
      q_R2.ExecQuery;

      Application.ProcessMessages;
      pb_progress.Position := 0;
      Application.ProcessMessages;
      while not q_R2.Eof do
      begin
        Nomen_no := q_R2.FieldByName('nomen_code').AsInteger - (libra_num * multiplier);
        if multiplier = 10000 then
          nomen_code := nomen_no * 10
        else
          nomen_code := nomen_No;
        if (Nomen_No > 0)and(Nomen_No <= PLUCount) then
          ShtrihPrAddNomen(LP, Nomen_no, nomen_code,
                    q_R2.FieldByName('nomen_name').AsString,
                    q_R2.FieldByName('price').AsCurrency)
        else
          ed_log.Lines.Add('Увага! Товар ' + q_R2.FieldByName('nomen_name').AsString +
             ' не запрограмовано. Код ' + IntToStr(Nomen_No) + ' > '+ IntToStr(PLUCount));

        pb_progress.Position := pb_progress.Position + 1;
        q_R2.Next;
      end;

      ShtrihPrEthernetDisconnect(LP);
      ed_log.Lines.Add(ShtrihPrGenStringError(LP));
    end;
    qR.Next;
  end;
  if tr_R2.InTransaction then trR.Commit;
  if trR.InTransaction then trR.Commit;
  except
    on E: Exception do
       ed_log.Lines.Add(E.Message);
  end;
end;

procedure Tfnomen.TigerDSyncExecute(libra_num: byte);
var
  //str_data: TStrings;
  FileName: string;
  flag: string[2];
  nomen_no, type_barcode, multiplier : integer;
  str_file :TextFile;
begin
  ed_log.Lines.Add('+++++++Синхронізація ваг METLER Tiger D++++++++');
  //Генерування файлу для пересилки
  FileName := prm.root_way + 'TmpNomenTigerD.txt';

  AssignFile(str_file, FileName);
  ReWrite(str_file);


end;

procedure Tfnomen.ScaleClick(Sender: TObject);
var snd: ZToolButton;
    p_scale: ^ZScaleDialogResulted;
    scale: ZScaleDialogResulted;
    i, id: integer;
begin
  snd := ZToolButton(Sender);
  if (snd = bt_ins_scale) then
  begin
    if scaleDialog(0, @scale, prm) <= 0 then
      Exit;
    ed_scales.AddLine('[' + scale.IP + '] ' + scale.name, scale.scale_id);
  end
  else if (snd = bt_upd_scale) then
  begin
    if (ed_scales.ItemIndex  < 1) then
      exit;
    id := ed_scales.PosToID(ed_scales.ItemIndex);
    if ScaleDialog(id, @scale, prm) <= 0 then
      exit;
    ed_scales.Items[ed_scales.ItemIndex] := '[' + scale.IP + '] ' + scale.name;
  end
  else if (snd = bt_del_scale) then
  begin
    if ed_scales.ItemIndex < 1 then
      Exit;
    if (MessageBox(0, 'Ви впевнені в потребі видалення ваги?', 'Увага!',  MB_YESNO) = ID_NO) then
      exit;
    id := ed_scales.PosToID(ed_scales.ItemIndex);
    if trW.InTransaction then trW.Commit;
    trW.StartTransaction;
    qW.SQL.Text := 'delete from t_scales where id = '+
            IntToStr(id);
    qW.ExecQuery;
    if trW.InTransaction then trW.Commit;
    ed_scales.DeleteSelected;
  end
end;

end.
