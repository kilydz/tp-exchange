unit udocuments;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, etalon_dic, dxExEdtr, DB, dxCntner, Menus, IBCustomDataSet,
  IBUpdateSQL, IBSQL, IBDatabase, IBQuery, ImgList, StdCtrls, ExtCtrls,
  uZFilter, dxDBGrid, dxDBTLCl, dxGrClms, dxTL, dxDBCtrl, ComCtrls,
  dxEditor, dxEdLib, RXCtrls, ToolWin, uZToolBar, uZControlBar, uorders_view,
  kernel_h, genstor_h, markup_h, udoc_filter, pricelist_h, {uTypes, uGeneralDLL,}
  document_h, {ib_h,} Zutils_h, store_h, pay_h, export_1c_h, IB, uexport_excel_xml,
  uZToolButton, secure_h, pays_h;

type
  Tfdocuments = class(Tfetalon_dic)
    ed_date_0: TdxDateEdit;
    ed_date_1: TdxDateEdit;
    Label1: TLabel;
    l_number: TStaticText;
    Label2: TLabel;
    l_token: TStaticText;
    Label3: TLabel;
    l_date: TStaticText;
    Label4: TLabel;
    l_sum_in: TStaticText;
    Label5: TLabel;
    l_sum_out: TStaticText;
    mi_prices: TMenuItem;
    ed_filter: TdxPopupEdit;
    Label6: TLabel;
    Label7: TLabel;
    l_sum_in_pdv: TStaticText;
    l_sum_out_pdv: TStaticText;
    Label8: TLabel;
    l_liable: TStaticText;
    Label9: TLabel;
    l_src_fullname: TStaticText;
    Label10: TLabel;
    l_src_name: TStaticText;
    Label11: TLabel;
    l_dst_fullname: TStaticText;
    Label12: TLabel;
    l_dst_name: TStaticText;
    mi_markup: TMenuItem;
    mi_print: TMenuItem;
    N3: TMenuItem;
    mi_like_create: TMenuItem;
    pay_state_images: TImageList;
    mi_close: TMenuItem;
    mi_pay: TMenuItem;
    mi_reestr: TMenuItem;
    mi_notarization: TMenuItem;
    N4: TMenuItem;
    RxLabel1: TRxLabel;
    RxLabel2: TRxLabel;
    mi_export_td2: TMenuItem;
    mi_orders_view: TMenuItem;
    ZToolButton1: ZToolButton;
    bt_pays: ZToolButton;
    q_dicDOC_ID: TIntegerField;
    q_dicDOC_NUM: TIBStringField;
    q_dicEDRPOU: TIBStringField;
    q_dicDOC_DATE: TDateField;
    q_dicCREATED: TDateTimeField;
    q_dicDOC_SUM: TFloatField;
    q_dicDOC_SUM_WITH_PDV: TFloatField;
    g_dicDOC_ID: TdxDBGridMaskColumn;
    g_dicDOC_NUM: TdxDBGridMaskColumn;
    g_dicEDRPOU: TdxDBGridMaskColumn;
    g_dicDOC_DATE: TdxDBGridDateColumn;
    g_dicCREATED: TdxDBGridDateColumn;
    g_dicDOC_SUM: TdxDBGridMaskColumn;
    g_dicDOC_SUM_WITH_PDV: TdxDBGridMaskColumn;
    q_dicIS_CLOSED: TSmallintField;
    g_dicIS_CLOSED: TdxDBGridImageColumn;
    q_detaileDOC_REC_ID: TIntegerField;
    q_detaileCODE_WARES: TIntegerField;
    q_detaileNAME_WARES: TIBStringField;
    q_detaileNAME_WARES_BRAND: TIBStringField;
    q_detaileABR_UNIT: TIBStringField;
    q_detailePRICE: TFloatField;
    q_detaileSUMA: TFloatField;
    q_detailePRICE_WITH_VAT: TFloatField;
    q_detaileSUMA_WITH_VAT: TFloatField;
    g_detaileDOC_REC_ID: TdxDBGridMaskColumn;
    g_detaileCODE_WARES: TdxDBGridMaskColumn;
    g_detaileNAME_WARES: TdxDBGridMaskColumn;
    g_detaileNAME_WARES_BRAND: TdxDBGridMaskColumn;
    g_detaileABR_UNIT: TdxDBGridMaskColumn;
    g_detailePRICE: TdxDBGridMaskColumn;
    g_detaileSUMA: TdxDBGridMaskColumn;
    g_detailePRICE_WITH_VAT: TdxDBGridMaskColumn;
    g_detaileSUMA_WITH_VAT: TdxDBGridMaskColumn;
    q_detaileQUANTITY: TFloatField;
    g_detaileQUANTITY: TdxDBGridMaskColumn;
    procedure q_dicAfterScroll(DataSet: TDataSet);

    procedure mi_Click(Sender: TObject);
    procedure tool_buttonClick(Sender: TObject); override;
    procedure q_dicCalcFields(DataSet: TDataSet);
    procedure q_detileCalcFields(DataSet: TDataSet);
    procedure ed_dateChange(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure ed_filterCloseUp(Sender: TObject; var Text: String;
      var Accept: Boolean);
    procedure g_dicCustomDrawCell(Sender: TObject; ACanvas: TCanvas;
      ARect: TRect; ANode: TdxTreeListNode; AColumn: TdxTreeListColumn;
      ASelected, AFocused, ANewItemRow: Boolean; var AText: String;
      var AColor: TColor; AFont: TFont; var AAlignment: TAlignment;
      var ADone: Boolean);
    procedure g_dicMouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; Z, Y: Integer);
  private
    { Private declarations }
    TodayDate: TDateTime;
    DaysCount :integer;
  public
    { Public declarations }

    procedure InitInfo; override;
    procedure RefreshDic; override;
    procedure RefreshDetaile; override;
  end;

function ShowPage(var a_veles_info: ZVelesInfoRec): Longint; stdcall;
procedure FreePage(a_form_ref: Longint); stdcall;

var
    dlg: Tfdocuments;

implementation

{uses PrintDoc, invoice_h;}
{$R *.dfm}

function ShowPage(var a_veles_info: ZVelesInfoRec): Longint;
begin
  if not HasUserAccessEx(a_veles_info, ACCESS_TO_DOCUMENTS) then
    Exit;

  if dlg = nil then
  begin
    dlg := Tfdocuments.Create(Application);
    dlg.prm := a_veles_info;
    dlg.InitInfo;
  end;
  dlg.panel.Visible := true;

  Result:=Longint(dlg);
end;

procedure FreePage(a_form_ref: Longint);
begin
  if (dlg <> nil) then dlg.Free;
end;

procedure Tfdocuments.InitInfo;
begin
  sql_refresh_document  :=
  'select d.DOC_ID, d.DOC_NUM, d.EDRPOU, d.DOC_DATE, d.CREATED, d.IS_CLOSED,' + #13#10 +
    'sum(dr.price_with_vat / (dr.vat/100 + 1) * dr.quantity) as DOC_SUM,' + #13#10 +
    'sum(dr.price_with_vat  * dr.quantity) as DOC_SUM_WITH_PDV' + #13#10 +
    'from T_DOCS d' + #13#10 +
        'left join t_doc_recs dr on d.doc_id = dr.doc_id' + #13#10 +
    'where d.doc_id = :idocument_id' + #13#10 +
    'group by d.DOC_ID, d.DOC_NUM, d.EDRPOU, d.DOC_DATE, d.CREATED, d.IS_CLOSED';

  sql_delete_document   := 'delete from t_docs where doc_id = :idocument_id)';
  sql_close_document    := 'update t_docs set is_closed = 1 where doc_id = :idocument_id)';
  sql_unclose_document  := 'update t_docs set is_closed = 0 where doc_id = :idocument_id)';
//  sql_unblock_document  := 'update t_documents set blok = 0 where document_id = :idocument_id';
  sql_is_fixed_document := 'select is_closed as is_fixed from t_docs where doc_id = :idocument_id';
  //sql_is_block_document := 'select blok as is_block from t_documents where document_id = :idocument_id';
//  sql_record_info       := 'select odescript from PS_DOCUMENT_INFO(:idocument_id)';

  access_to_del            := ACCESS_TO_DOCUMENT_DEL;
  access_to_export_dic     := ACCESS_TO_DOCUMENTS_EXPORT;    // Експорт довідника
  access_to_export_detaile := ACCESS_TO_DOCUMENT_EXPORT;     // Експорт документа
  access_to_unblock        := ACCESS_TO_DOCUMENTS;           // Розблокування документа

  dic_refresh_enabled := false;
  ed_date_0.Date := Date;
  ed_date_1.Date := Date;

  // Настройка конфігурації довідника
  is_new_project := False;
  inherited InitInfo;


  if(tr_R.InTransaction)then tr_R.Commit;
  tr_R.StartTransaction;
  q_R.SQL.Text := 'select cast(''today'' as date) as date_ from rdb$database';
  q_R.ExecQuery;
  TodayDate          := q_R.FieldByName('date_').AsDate;
end;

procedure Tfdocuments.RefreshDic;
var MinDate: TDate;
begin
  MinDate := ed_date_1.Date;
  if MinDate > prm.custom_data.DateOfDeath then
     MinDate := prm.custom_data.DateOfDeath;

  q_dic.ParamByName('idate0').AsString := DateToStr(ed_date_0.Date);
  q_dic.ParamByName('idate1').AsString := DateToStr(MinDate);

  inherited RefreshDic;
end;

procedure Tfdocuments.RefreshDetaile;
begin
  inherited RefreshDetaile;
end;

procedure Tfdocuments.mi_Click(Sender: TObject);
var item: TMenuItem;
// prm_doc: ZInvoice;
  lib_handle: THandle;
// func: procedure (prm_doc: ZInvoice);
  lpPricesBySQL: procedure(sql: string; prm: ZVelesInfoRec);
  document_id: integer;
  resulted_markup: ZMarkupDocDialogResulted;
  lpMarkupDocDialog: function(id: integer; document_id: integer; var resulted: ZMarkupDocDialogResulted; var prm: ZVelesInfoRec): integer;
  create_like_prm: ZCreateLike;
  lpGCreateLike: function(id: integer; create_like_prm: lpZCreateLike; var a_veles_info: ZVelesInfoRec): integer;
  invoice_types: string;
  lpInvoiceDialog: procedure(document_id: integer; list_id: string; var prm: ZVelesInfoRec);
  resulted_reestr: ZReestrDialogResulted;
  lpReestrDialog: function(document_id: integer; resulted: lpZReestrDialogResulted; var prm: ZVelesInfoRec): integer;
  lpPaysDialog: ZPaysDialog;
  str_data: TStrings;
  i: integer;
  r: real;
  mes: PAnsiChar;
  price_sql, docs_ids: string;
begin
  item := TMenuItem(Sender);

   // фіксування документу
  if item = mi_fix then
  begin
    if IsRecordNull then
      exit;

{    if q_dic.FieldByName('OIS_FIXED').AsInteger > 1 then
    begin
      GMessageBox('Спочутку потрібно зняти відвантаження', 'Закрити');
      exit;
    end;
 }
    if q_dic.FieldByName('OIS_FIXED').AsInteger = 0 then
    begin
      if not HasUserAccessEx(prm, ACCESS_TO_DOCUMENT_FIX) then
        Exit
    end
    else if q_dic.FieldByName('OIS_FIXED').AsInteger = 1 then
    begin
      if (not HasUserAccessEx(prm, ACCESS_TO_DOCUMENT_UNFIX)) then
        Exit;
    end;
    if q_dic.FieldByName('OIS_FIXED').AsInteger > 0 then
    begin
//      if (q_dic.FieldByName('otypedoc_id').AsInteger in [6, 7, 15]) then
//      begin
//        GMessageBox('Неможна відкривати даний тип документу', 'OK');
//        Exit;
//      end;
    end;

    mes := 'Ви дійсно бажаєте закрити документ?';
    if (q_dic.FieldByName('otypedoc_id').AsInteger in [6, 7, 15]) then
       mes := 'Ви дійсно бажаєте закрити документ?'+#13+'Увага! Ви не зможете відкрити його знову';
    if GMessageBox(mes, 'Так|Ні') <> 1 then
     exit;

   try
    if tr_W.InTransaction then tr_W.Commit;
    tr_W.StartTransaction;
     q_W.SQL.Text := sql_close_document;
     q_W.ParamByName('idocument_id').AsInteger :=
                      q_dic.FieldByName(g_dic.KeyField).AsInteger;
     q_W.ExecQuery;
    if tr_W.InTransaction then tr_W.Commit;
   except
      on E: EIBInterbaseError do
      begin
        if tr_W.InTransaction then tr_W.Rollback;
        ShowMessage(Format('Відбувся збій при закритті документа %s.', [#13 + E.Message + #13]));
      end;
   end;

    RefreshRecord;
    Exit;
  end;

  inherited mi_Click(Sender);

  if item = mi_reestr then
  begin
    if IsRecordNull then
      exit;

    if (not (q_dic.FieldByName('otypedoc_id').AsInteger in  [ 1, 2])) then
    begin
      GMessageBox('В реєстр можна додавати лише прихідні та розхідні накладні.', 'OK');
      Exit;
    end;

    @lpReestrDialog := nil;
    lib_handle := LoadLibrary('export_1c.dll');
    if lib_handle >= 32 then
    begin
      @lpReestrDialog := GetProcAddress(lib_handle, 'ReestrDialog');
      if @lpReestrDialog <> nil then
        lpReestrDialog(q_dic.FieldByName('odocument_id').AsInteger, @resulted_reestr, prm);
      FreeLibrary(lib_handle);
    end;

    RefreshRecord;
  end
  else if item = mi_pay then
  begin
    if IsRecordNull then
      exit;

    @lpPaysDialog := nil;
    lib_handle := LoadLibrary('pay.dll');
    if lib_handle >= 32 then
    begin
      @lpPaysDialog := GetProcAddress(lib_handle, 'PaysDialog');
      if @lpPaysDialog <> nil then
        lpPaysDialog(prm, q_dic.FieldByName('odocument_id').AsInteger);
    end;
    FreeLibrary(lib_handle);
    RefreshRecord;
  end
  else if item = mi_close then
  begin
    if IsRecordNull then
      exit;

    if q_dic.FieldByName('ois_fixed').AsInteger = 0 then
    begin
      GMessageBox('Документ потрібно спочатку зафіксувати.', 'OK');
      Exit;
    end;

    if q_dic.FieldByName('otypedoc_id').AsInteger in [14, 16] then
    begin
      GMessageBox('Не можна знімати відвантаження даного документа.', 'OK');
      Exit;
    end;

    if GMessageBox('Ви дійсно бажаєте відвантажити документ?', 'Так|Ні') <> 1 then
     exit;

    if q_dic.FieldByName('OIS_FIXED').AsInteger = 1 then
    begin
      if not HasUserAccessEx(prm, ACCESS_TO_DOCUMENT_CLOUSE) then
        Exit
    end
    else if q_dic.FieldByName('OIS_FIXED').AsInteger = 2 then
    begin
      if not HasUserAccessEx(prm, ACCESS_TO_DOCUMENT_UNCLOUSE) then
        Exit
    end;

    if tr_W.InTransaction then tr_W.Commit;
    tr_W.StartTransaction;
     q_W.SQL.Text := 'update t_documents set doc_lock = :iis_fixed where document_id = :idocument_id';
     if q_dic.FieldByName('ois_fixed').AsInteger = 1 then
       q_W.ParamByName('iis_fixed').AsInteger := 2
     else if q_dic.FieldByName('ois_fixed').AsInteger = 2 then
       q_W.ParamByName('iis_fixed').AsInteger := 1;
     q_W.ParamByName('idocument_id').AsInteger := q_dic.FieldByName('odocument_id').AsInteger;
     q_W.ExecQuery;
    if tr_W.InTransaction then tr_W.Commit;

    RefreshRecord;
  end
  else if (item = mi_print) then
//--------- Друк документів ----------------------
 begin
    @lpInvoiceDialog := nil;
    lib_handle       := LoadLibrary('invoice.dll');
    if lib_handle    >= 32 then
    begin
      @lpInvoiceDialog := GetProcAddress(lib_handle, 'InvoiceDialog');
      if tr_R.InTransaction then tr_R.Commit;
      tr_R.StartTransaction;
      q_R.SQL.Text := 'select first(1) invoice_types from T_INVOICE_TYPES where typedoc_id ='+
                       q_dic.FieldByName('otypedoc_id').AsString;
      q_R.ExecQuery;
      if q_R.RecordCount > 0 then
        invoice_types := q_R.FieldByName('invoice_types').AsString + ' '
      else
        invoice_types := '';
      if tr_R.InTransaction then tr_R.Commit;

        if @lpInvoiceDialog <> nil then
        begin
           lpInvoiceDialog(q_dic.FieldByName('odocument_id').AsInteger, invoice_types, prm);
        end;
    end;
    FreeLibrary(lib_handle);
  end 
  else if item = mi_markup then                           
  begin
    if IsRecordNull then
      exit;

    if not(q_dic.FieldByName('otypedoc_id').AsInteger in [1, 7]) then
    begin
      ShowMessage('Акти переоцінок можна створювати лише на прихідні накладні, та прихідні внутрішні переміщення');
      exit;
    end;

    @lpMarkupDocDialog := nil;
    lib_handle := LoadLibrary('markup.dll');
    if lib_handle >= 32 then
    begin
      @lpMarkupDocDialog := GetProcAddress(lib_handle, 'MarkupDocDialog');
      if @lpMarkupDocDialog <> nil then
        lpMarkupDocDialog(0, q_dic.FieldByName('odocument_id').AsInteger,
                      resulted_markup, prm)
    end;
    FreeLibrary(lib_handle);
  end
  else if item = mi_like_create then
  begin
    if IsRecordNull then
      exit;

    create_like_prm.sql_info := 'select * from PS_DOCUMENT_INFO(:idocument_id)';
    create_like_prm.sql_types_convert := 'select * from PS_DOCUMENT_LIKE_TYPES(' +
                                               q_dic.FieldByName('otypedoc_id').AsString + ')';
    create_like_prm.sql_create := 'select * from PS_DOCUMENT_CREATE_LIKE(:idocument_id, :itype_convert)';
    @lpGCreateLike := nil;
    lib_handle := LoadLibrary('zutils.dll');
    if lib_handle >= 32 then
    begin
      @lpGCreateLike := GetProcAddress(lib_handle, 'GCreateLike');
      if @lpGCreateLike <> nil then
      begin
        document_id := lpGCreateLike(q_dic.FieldByName('odocument_id').AsInteger,
                                @create_like_prm, prm);
        if (document_id > 0) then
        begin
          if (document_id <> q_dic.FieldByName('odocument_id').AsInteger) then
          begin
            q_dic.Insert;
            q_dic.FieldByName('odocument_id').AsInteger := document_id;
            q_dic.Post;
          end;
          RefreshRecord;
        end
      end
    end;
    FreeLibrary(lib_handle);
  end
  else if item = mi_prices then
  begin
    if IsRecordNull then
      exit;

    @lpPricesBySQL := nil;
    lib_handle := LoadLibrary('pricelist.dll');
    if lib_handle >= 32 then
    begin
      @lpPricesBySQL := GetProcAddress(lib_handle, 'PricesBySQL');
      if @lpPricesBySQL <> nil then
      begin
        if id_list.GenerateSpaceList = '  ' then
          docs_ids := q_dic.FieldByName('doc_id').AsString
        else
          docs_ids := id_list.GenerateList;

        price_sql :=
        'with dr_wares as' + #13#10 +
        '(' + #13#10 +
            'select distinct dr.code_wares' + #13#10 +
            'from t_doc_recs dr where dr.doc_id in ('+docs_ids+')' + #13#10 +
        ')' + #13#10 +
        'select w.code_wares as onomen_id, w.code_wares as onomen_code,' + #13#10 +
               'w.NAME_WARES_RECEIPT as onomen_name, pd.price_dealer as ooutprice,' + #13#10 +
               '0 ois_in_discount, 1 as oprint_it' + #13#10 +
        'from wares w' + #13#10 +
            'inner join dr_wares on (w.code_wares = dr_wares.code_wares)' + #13#10 +
            'left join price_dealer pd on (pd.code_wares = w.code_wares and pd.code_dealer ='+
            IntToStr(prm.custom_data.code_dealer)+')';
        lpPricesBySQL(price_sql, prm);
      end;
      FreeLibrary(lib_handle);
    end
  end
  else if item = mi_notarization then
  begin
    if IsRecordNull then
      exit;

   if not HasUserAccessEx(prm, ACCESS_TO_DOCUMENT_NOTARIZATION) then
   begin
     Exit
   end;

    if q_dic.FieldByName('ois_fixed').AsInteger <> 2 then
    begin
      GMessageBox('Документ потрібно спочатку зафіксувати і відвантажити.', 'OK');
      Exit;
    end;

    if tr_W.InTransaction then tr_W.Commit;
    tr_W.StartTransaction;
     q_W.SQL.Text := 'update t_documents set notarization = user where document_id = :idocument_id';
     q_W.ParamByName('idocument_id').AsInteger := q_dic.FieldByName('odocument_id').AsInteger;
     q_W.ExecQuery;
    if tr_W.InTransaction then tr_W.Commit;

    RefreshRecord;
  end
  else if item = mi_orders_view then
  begin
  //Показати замовлення
    if IsRecordNull then
      exit;
    if ((q_dic.FieldByName('otypedoc_id').AsInteger <> 1)or
        (q_dic.FieldByName('note').AsString = '')) then
      exit;
    OrdersViewDialog(q_dic.FieldByName('odocument_id').AsInteger, prm);
  end
  else if item = mi_export_td2 then
  //Експорт розхідних накладних
  begin
    if IsRecordNull then
      exit;

    export_dialog.DefaultExt := '*.xml';
    export_dialog.Filter     := 'Файли MS Excel |*.xml';
    export_dialog.Title      := 'Експорт розхідної накладної в Excel';
    export_dialog.FileName   := q_dic.FieldByName('onumber').AsString + '.xml';
    if export_dialog.Execute then
    begin
      str_data := TStringList.Create;
      if tr_R.InTransaction then tr_R.Commit;
      tr_R.StartTransaction;
      q_R.SQL.Text := 'select * from PS_DOC_HEADER_VIEW(:DOCUMENT_ID)';
      q_R.ParamByName('DOCUMENT_ID').AsInteger := q_dic.FieldByName('odocument_id').AsInteger;
      q_R.ExecQuery;
      str_data.Add(GenTitleData(q_R.FieldByName('doc_num').AsString,
                      q_R.FieldByName('doc_mark').AsString,
                      q_R.FieldByName('doc_date').AsString,
                      q_R.FieldByName('name_s').AsString,
                      q_R.FieldByName('name_d').AsString,
                      q_R.FieldByName('adress_s').AsString,
                      q_R.FieldByName('adress_d').AsString,
                      q_R.FieldByName('deliv_addr_d').AsString,
                      q_R.FieldByName('phone_s').AsString,
                      q_R.FieldByName('oplata_type').AsString));
      if tr_R.InTransaction then tr_R.Commit;

      tr_R.StartTransaction;
      q_R.SQL.Text := 'select * from PS_DOCREC_PRINT (:DOCUMENT_ID) order by NOMEN_NAME';
      q_R.ParamByName('DOCUMENT_ID').AsInteger := q_dic.FieldByName('odocument_id').AsInteger;
      q_R.ExecQuery;
      str_data.Add(ROWS_TITLE);
      i:=1; r:=0;
      while not(q_R.Eof) do
      begin
        str_data.Add(GenRowData(IntToStr(i),
                    q_R.FieldByName('nomen_code').AsString,
                    q_R.FieldByName('nomen_name').AsString,
                    q_R.FieldByName('kilk').AsString + ' ' + q_R.FieldByName('si_name').AsString,
                    q_R.FieldByName('OUT_PRICE').AsString,
                    q_R.FieldByName('OUT_PRICE_PDV').AsString,
                    q_R.FieldByName('SUM_OUT_PDV').AsString));
        i := i+1;
        r := r + q_R.FieldByName('DISC_PERSENT').AsFloat;
        q_R.Next;
      end;
      if tr_R.InTransaction then tr_R.Commit;
      if i < 2 then i:=2;
      
      tr_R.StartTransaction;
      q_R.SQL.Text := 'select * from PS_DOC_HEADER_VIEW(:DOCUMENT_ID)';
      q_R.ParamByName('DOCUMENT_ID').AsInteger := q_dic.FieldByName('odocument_id').AsInteger;
      q_R.ExecQuery;
      str_data.Add(GenResultData(q_R.FieldByName('doc_sumpdv').AsString,
                      q_R.FieldByName('staff_name').AsString,
                      FloatToStr(r/(i-1)),
                      q_R.FieldByName('ousername').AsString,
                      q_R.FieldByName('doc_sum').AsString,
                      q_R.FieldByName('doc_pdv').AsString));
      if tr_R.InTransaction then tr_R.Commit;

      str_data.Text := UTF8Encode(str_data.Text);
      str_data.SaveToFile(export_dialog.FileName);
      str_data.Destroy;
    end;
  end;
end;

procedure Tfdocuments.tool_buttonClick(Sender: TObject);
  var button: ZToolButton;
    resulted: ZDocumentDialogResulted;
    lib_handle: THandle;
    DaysCount1: integer;
    lpDocumentDialog: function(id: integer; resulted: lpZDocumentDialogResulted; var prm: ZVelesInfoRec): integer;
begin
  inherited tool_buttonClick(Sender);

  button := ZToolButton(Sender);
  if button = bt_ins then
  begin
    if not HasUserAccessEx(prm, ACCESS_TO_DOCUMENT_INS_UPD) then
      Exit;

    @lpDocumentDialog := nil;
    lib_handle := LoadLibrary('document.dll');
    if lib_handle >= 32 then
    begin
      @lpDocumentDialog := GetProcAddress(lib_handle, 'DocumentDialog');
      if @lpDocumentDialog <> nil then
        if lpDocumentDialog(0, @resulted, prm) > 0 then
        begin
          q_dic.Insert;
          q_dic.FieldByName('doc_id').AsInteger := resulted.document_id;
          q_dic.Post;
          RefreshRecord;
        end;
      FreeLibrary(lib_handle);
    end;
  end
  else if button = bt_upd then
  begin
    if IsRecordNull then
      exit;

    if not HasUserAccessEx(prm, ACCESS_TO_DOCUMENT_INS_UPD) then
      Exit;

    if IsRecordFixed or IsRecordBlocked then
      exit;

    DaysCount1 := DaysCount;
//    if (q_dic.FieldByName('otypedoc_id').AsInteger in [1, 17]) then
//      DaysCount1 := 45;

{    if ((DaysCount > 0)and
        ((q_dic.FieldByName('odate').AsDateTime < TodayDate - DaysCount1)or
         (q_dic.FieldByName('odate').AsDateTime > TodayDate + DaysCount1))) then
    begin
      ShowMessage('Неможна редагувати документи старіші на '+IntToStr(DaysCount1)+' днів наперед чи назад'+#10#13+
                'від сьогоднішньої дати ('+DateToStr(TodayDate)+')');
      exit;
    end;}

    @lpDocumentDialog := nil;
    lib_handle := LoadLibrary('document.dll');
    if lib_handle >= 32 then
    begin
      @lpDocumentDialog := GetProcAddress(lib_handle, 'DocumentDialog');
      if @lpDocumentDialog <> nil then
        if lpDocumentDialog(q_dic.FieldByName('doc_id').AsInteger, @resulted, prm) > 0 then
        begin
          RefreshRecord;
        end;
      FreeLibrary(lib_handle);
    end;
  end;
end;

procedure Tfdocuments.q_dicAfterScroll(DataSet: TDataSet);
begin
  inherited;
//  if detail_refresh_enabled and bt_pays.Down then
//    PayFormRefresh(fPays, q_dic.FieldByName('odocument_id').AsInteger);
end;

procedure Tfdocuments.q_dicCalcFields(DataSet: TDataSet);
begin
  q_dic.FieldByName('MARKUP_SUM').AsCurrency :=
                 q_dic.FieldByName('OSUM_OUT').AsCurrency -
                 q_dic.FieldByName('OSUM_IN').AsCurrency;

  q_dic.FieldByName('SUM_PDV').AsCurrency :=
                 q_dic.FieldByName('OSUM_OUT_PDV').AsCurrency -
                 q_dic.FieldByName('OSUM_OUT').AsCurrency;

  if (q_dic.FieldByName('OSUM_IN').AsCurrency <> 0) then
    q_dic.FieldByName('MARKUP_OFIC').AsCurrency :=
                 (q_dic.FieldByName('MARKUP_SUM').AsCurrency /
                  q_dic.FieldByName('OSUM_IN').AsCurrency) * 100
  else
    q_dic.FieldByName('MARKUP_OFIC').AsCurrency := 0.00;

  if (q_dic.FieldByName('OSUM_OUT').AsCurrency <> 0) then
    q_dic.FieldByName('MARKUP').AsCurrency :=
                 (q_dic.FieldByName('MARKUP_SUM').AsCurrency /
                  q_dic.FieldByName('OSUM_OUT').AsCurrency) * 100
  else
    q_dic.FieldByName('MARKUP').AsCurrency := 0.00;
end;

procedure Tfdocuments.q_detileCalcFields(DataSet: TDataSet);
var nomen_sum: real;
begin
{  q_detaile.FieldByName('PRICE_SUM').AsCurrency :=
     q_detaile.FieldByName('ONOMEN_PRICE').AsCurrency * q_detaile.FieldByName('OKILK').AsCurrency;

  if q_dic.FieldByName('OTYPEDOC_ID').AsInteger = 1 then
  begin
    nomen_sum := q_detaile.FieldByName('OKILK').AsCurrency *
                 q_detaile.FieldByName('ONOMEN_PRICE').AsCurrency;

    q_detaile.FieldByName('MARKUP_SUM').AsCurrency :=
                    nomen_sum - q_detaile.FieldByName('OSUM_IN_PDV').AsCurrency;

    if (q_detaile.FieldByName('OSUM_IN_PDV').AsCurrency <> 0) then
      q_detaile.FieldByName('MARKUP_OFIC').AsCurrency :=
                   (q_detaile.FieldByName('MARKUP_SUM').AsCurrency /
                    q_detaile.FieldByName('OSUM_IN_PDV').AsCurrency) * 100
    else
      q_detaile.FieldByName('MARKUP_OFIC').AsCurrency := 0.00;

    if (nomen_sum <> 0) then
      q_detaile.FieldByName('MARKUP').AsCurrency :=
                   (q_detaile.FieldByName('MARKUP_SUM').AsCurrency / nomen_sum) * 100
    else
      q_detaile.FieldByName('MARKUP').AsCurrency := 0.00;
  end
  else
  begin
    q_detaile.FieldByName('MARKUP_SUM').AsCurrency :=
                   q_detaile.FieldByName('OSUM_OUT').AsCurrency -
                   q_detaile.FieldByName('OSUM_IN').AsCurrency;

    if (q_detaile.FieldByName('OSUM_IN').AsCurrency <> 0) then
      q_detaile.FieldByName('MARKUP_OFIC').AsCurrency :=
                   (q_detaile.FieldByName('MARKUP_SUM').AsCurrency /
                    q_detaile.FieldByName('OSUM_IN').AsCurrency) * 100
    else
      q_detaile.FieldByName('MARKUP_OFIC').AsCurrency := 0.00;

    if (q_detaile.FieldByName('OSUM_OUT').AsCurrency <> 0) then
      q_detaile.FieldByName('MARKUP').AsCurrency :=
                   (q_detaile.FieldByName('MARKUP_SUM').AsCurrency /
                    q_detaile.FieldByName('OSUM_OUT').AsCurrency) * 100
    else
      q_detaile.FieldByName('MARKUP').AsCurrency := 0.00;
  end;}
end;

procedure Tfdocuments.ed_dateChange(Sender: TObject);
begin
  RefreshDic;
end;

procedure Tfdocuments.FormDestroy(Sender: TObject);
begin
  inherited FormDestroy(Sender);
end;

procedure Tfdocuments.ed_filterCloseUp(Sender: TObject; var Text: String;
  var Accept: Boolean);
begin
   RefreshDic;
end;

procedure Tfdocuments.g_dicCustomDrawCell(Sender: TObject;
  ACanvas: TCanvas; ARect: TRect; ANode: TdxTreeListNode;
  AColumn: TdxTreeListColumn; ASelected, AFocused, ANewItemRow: Boolean;
  var AText: String; var AColor: TColor; AFont: TFont;
  var AAlignment: TAlignment; var ADone: Boolean);

var
 value,
 valueID: Variant;
begin
  inherited g_dicCustomDrawCell(Sender, ACanvas, ARect, ANode, AColumn,
        ASelected, AFocused, ANewItemRow, AText, AColor, AFont,
        AAlignment, ADone);
end;

procedure Tfdocuments.g_dicMouseDown(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; Z, Y: Integer);
begin
{  if (Button = mbRight)and(not(q_dic.FieldByName(g_dic.KeyField).IsNull)) then
  begin
    if (q_dic.FieldByName('OTYPEDOC_ID').AsInteger = 2) then
      mi_export_td2.Visible := True
    else
      mi_export_td2.Visible := False;
  end;}
end;

end.
