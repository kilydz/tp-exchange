unit edrevision;

interface

uses etalon_ed, revision_h, veles_h, nomenlist, {invoice_h,scanrevision_h,}
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, dxExEdtr, ExtCtrls, dxCntner, dxTL, dxDBCtrl, dxDBGrid,
  ComCtrls, ToolWin, uXToolBar, uXControlBar, 
   {veles_h,} DB, IBDatabase,
  IBCustomDataSet, IBQuery, IBSQL, IB, IBUpdateSQL,
  ImgList, dxDBTLCl, dxGrClms, dxEditor, dxEdLib;

type
  Tfedrevision = class(Tfetalon_ed)
    q_dicORECORD_ID: TIntegerField;
    q_dicOCODE: TIBStringField;
    q_dicOFULL_NAME: TIBStringField;
    q_dicOPRICE_IN_PDV: TFloatField;
    q_dicOPRICE_OUT_PDV: TFloatField;
    q_dicOKILK_OLD: TFloatField;
    q_dicOKILK_NEW: TFloatField;
    q_dicOTYPE_PDV_ID: TIntegerField;
    g_dicORECORD_ID: TdxDBGridMaskColumn;
    g_dicOCODE: TdxDBGridMaskColumn;
    g_dicOFULL_NAME: TdxDBGridMaskColumn;
    q_dicCKILK_DIFF: TCurrencyField;
    q_dicCSUM_IN_PDV_DIFF: TFloatField;
    q_dicCSUM_OUT_PDV_DIFF: TFloatField;
    q_dicCSUM_OUT_PDV_NEW: TFloatField;
    q_dicCSUM_OUT_PDV_OLD: TFloatField;
    q_dicCSUM_IN_PDV_NEW: TFloatField;
    q_dicCSUM_IN_PDV_OLD: TFloatField;
    q_dicOPDV: TFloatField;
    q_dicCPRICE_IN: TFloatField;
    q_dicCPRICE_OUT: TFloatField;
    q_dicCSUM_IN_OLD: TFloatField;
    q_dicCSUM_IN_NEW: TFloatField;
    q_dicCSUM_OUT_OLD: TFloatField;
    q_dicCSUM_OUT_NEW: TFloatField;
    q_dicCSUM_IN_DIFF: TFloatField;
    q_dicCSUM_OUT_DIFF: TFloatField;
    g_dicOPRICE_IN_PDV: TdxDBGridColumn;
    g_dicOPRICE_OUT_PDV: TdxDBGridColumn;
    g_dicOKILK_OLD: TdxDBGridColumn;
    g_dicOKILK_NEW: TdxDBGridColumn;
    g_dicOTYPE_PDV_ID: TdxDBGridColumn;
    g_dicCKILK_DIFF: TdxDBGridColumn;
    g_dicCSUM_IN_PDV_DIFF: TdxDBGridColumn;
    g_dicCSUM_OUT_PDV_DIFF: TdxDBGridColumn;
    g_dicCSUM_OUT_PDV_NEW: TdxDBGridColumn;
    g_dicCSUM_OUT_PDV_OLD: TdxDBGridColumn;
    g_dicCSUM_IN_PDV_NEW: TdxDBGridColumn;
    g_dicCSUM_IN_PDV_OLD: TdxDBGridColumn;
    g_dicOPDV: TdxDBGridColumn;
    g_dicCPRICE_IN: TdxDBGridColumn;
    g_dicCPRICE_OUT: TdxDBGridColumn;
    g_dicCSUM_IN_OLD: TdxDBGridColumn;
    g_dicCSUM_IN_NEW: TdxDBGridColumn;
    g_dicCSUM_OUT_OLD: TdxDBGridColumn;
    g_dicCSUM_OUT_NEW: TdxDBGridColumn;
    g_dicCSUM_IN_DIFF: TdxDBGridColumn;
    g_dicCSUM_OUT_DIFF: TdxDBGridColumn;
    q_dicONOMEN_ID: TIntegerField;
    ToolButton2: TToolButton;
    bt_scanrevision: TToolButton;
    ToolButton5: TToolButton;
    ed_flag: TdxImageEdit;
    procedure bt_toolClick(Sender: TObject);  override;
    procedure FormClose(Sender: TObject; var Action: TCloseAction);  override;
    procedure q_dicCalcFields(DataSet: TDataSet);
    procedure g_dicKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);

    procedure InitInfo; virtual;
    procedure RefreshDic; override;
    procedure ToolButton2Click(Sender: TObject);
  private
    resulted:XRevisionDialogResulted;
    { Private declarations }
  public
    //procedure q_dicCalcFields(DataSet: TDataSet);
    procedure OnAddRec(var nomen_id: integer);
    { Public declarations }
  end;

//var
//  fedrevision: Tfedrevision;
function RevisionRecordsEditor(var resulted: ZRevisionDialogResulted; var prm: ZVelesInfoRec): integer;

implementation

{$R *.dfm}
function RevisionRecordsEditor(var resulted: ZRevisionDialogResulted; var prm: ZVelesInfoRec): integer;
var
  dlg: Tfedrevision;
  returned: integer;
begin
  // Перевірка прав
  returned := 0;
try
    // Створення та ініціалізація форми діалогу.
    dlg := Tfedrevision.Create(Application);
    dlg.prm := prm;
    dlg.resulted := resulted;
    dlg.InitInfo;

    // Візуалізація діалогу
    if (dlg.ShowModal = mrOk) then
    begin
      resulted := dlg.resulted;
      returned := dlg.resulted.revision_id;
    end;
finally
  if dlg <> nil then dlg.Free;
end;
  //    returned <= 0 - код помилки, або відмова;
  //    returned > 0  - id результату;
  RevisionRecordsEditor := returned;
end;

//------------------------------------------------------------------------------
//
//------------------------------------------------------------------------------
procedure Tfedrevision.InitInfo;
begin
  inherited InitInfo;
  q_dic.ParamByName('irevision_id').AsInteger := resulted.revision_id;
  document_id := resulted.revision_id;
  sql_refresh_record   := 'select OCODE, OFULL_NAME, OIN_PRICE_PDV, OOUT_PRICE_PDV, OKILK_OLD, OKILK_NEW, onomen_id' +
                            '  from PS_REV_RECORD_VIEW(:irecord_id) ';

  sql_refresh_record   := 'select OCODE, OFULL_NAME, OIN_PRICE_PDV as OPRICE_IN_PDV, OOUT_PRICE_PDV as OPRICE_OUT_PDV, OKILK_OLD, OKILK_NEW, onomen_id' +
                            '  from PS_REV_RECORD_VIEW(:irecord_id) ';

  sql_delete_record    := 'delete from t_rev_records rr where rr.rev_records_id = :irecord_id';

  sql_block_document   := 'update t_revisions set is_block = 1 where revision_id = :idocument_id';
  sql_unblock_document := 'update t_revisions set is_block = 0 where revision_id = :idocument_id';

  // Ініціалізація довідника товарів
  nomen_list_descr.parent_panel := p_choicer;
  nomen_list_descr.mode := 0;
  nomen_list_descr.forma_prew := Self;
  NomenListCreate(nomen_list_descr, prm);
  Tfnomenlist(nomen_list_descr.forma).OnAddRec := OnAddRec;
//  nomen_list_descr.on_add_all := @OnAddAll;

end;

procedure Tfedrevision.RefreshDic;
var rev_record_id: integer;
    old_cursor: TCursor;
begin
  q_dic.ParamByName('irevision_id').AsInteger := resulted.revision_id;
  inherited RefreshDic;
end;

procedure Tfedrevision.bt_toolClick(Sender: TObject);
var button: TToolButton;
    lib_handle: THandle;
    resulted: ZRevisionRecordDialogResulted;
    lpScanRevisionShow: procedure (id: integer; var prm: ZVelesInfoRec);
begin
  inherited bt_toolClick(Sender);

  button := TToolButton(Sender);
  if button = bt_upd then
  begin

    if (RevisionRecordDialog(q_dic.FieldByName('orecord_id').AsInteger,
                                 @resulted, prm) > 0) then
    begin
      RefreshRecord;
    end;
  end
  else if button = bt_scanrevision then
  begin
    @lpScanRevisionShow := nil;
    lib_handle := LoadLibrary('scanrevision.dll');
    if lib_handle >= 32 then begin
      @lpScanRevisionShow := GetProcAddress(lib_handle,'ScanRevisionShow');
      if @lpScanRevisionShow <> nil then
        lpScanRevisionShow(self.resulted.revision_id, prm);
    end;
    FreeLibrary(lib_handle);
    RefreshDic;
  end;
end;

procedure Tfedrevision.OnAddRec(var nomen_id: integer);
var rev_record_id: integer;
begin
  if FindRecordIdByNomenId('onomen_id', nomen_id) = -1 then
    exit;

 try  
   if tr_W.InTransaction then tr_W.Commit;
   tr_W.StartTransaction;
    q_W.SQL.Text := 'select orev_record_id from PS_REV_RECORD_INS(:irevision_id, :inomen_id, :iflag)';
    q_W.ParamByName('irevision_id').AsInteger     := resulted.revision_id;
    q_W.ParamByName('inomen_id').AsInteger        := nomen_id;
    q_W.ParamByName('iflag').AsInteger            := StrToInt(ed_flag.Text);
    q_W.ExecQuery;
    rev_record_id := q_W.FieldByName('orev_record_id').AsInteger;
   if tr_W.InTransaction then tr_W.Commit;

   q_dic.Insert;
   q_dic.FieldByName('orecord_id').AsInteger := rev_record_id;
   q_dic.Post;

 except
   on E: EIBInterbaseError do
   begin
     if tr_W.InTransaction then tr_W.Rollback;
     ShowMessage(Format('Відбувся збій: %s Повідомте розробників про помилку.', [#13 + E.Message + #13]));
   end;
 end;

   RefreshRecord;
end;


procedure Tfedrevision.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
   inherited FormClose(Sender, Action);
end;

procedure Tfedrevision.q_dicCalcFields(DataSet: TDataSet);
begin
  inherited;

  q_dic.FieldByName('CKILK_DIFF').AsFloat :=
                 q_dic.FieldByName('OKILK_NEW').AsFloat -
                 q_dic.FieldByName('OKILK_OLD').AsFloat;
  q_dic.FieldByName('CSUM_IN_PDV_OLD').AsFloat :=
                 q_dic.FieldByName('OPRICE_IN_PDV').AsFloat -
                 q_dic.FieldByName('OKILK_OLD').AsFloat;

  q_dic.FieldByName('CSUM_IN_PDV_NEW').AsFloat :=
                 q_dic.FieldByName('OKILK_NEW').AsFloat -
                 q_dic.FieldByName('OPRICE_IN_PDV').AsFloat;

  q_dic.FieldByName('CSUM_OUT_PDV_OLD').AsFloat :=
                 q_dic.FieldByName('OPRICE_OUT_PDV').AsFloat -
                 q_dic.FieldByName('OKILK_OLD').AsFloat;

  q_dic.FieldByName('CSUM_OUT_PDV_NEW').AsFloat :=
                 q_dic.FieldByName('OKILK_NEW').AsFloat -
                 q_dic.FieldByName('OPRICE_OUT_PDV').AsFloat;

  q_dic.FieldByName('CSUM_OUT_PDV_DIFF').AsFloat :=
                 q_dic.FieldByName('CSUM_OUT_PDV_NEW').AsFloat -
                 q_dic.FieldByName('CSUM_OUT_PDV_OLD').AsFloat;

  q_dic.FieldByName('CSUM_IN_PDV_DIFF').AsFloat :=
                 q_dic.FieldByName('CSUM_IN_PDV_NEW').AsFloat -
                 q_dic.FieldByName('CSUM_IN_PDV_OLD').AsFloat;

  case q_dic.FieldByName('OTYPE_PDV_ID').AsInteger of
  0: begin end;
  1: begin
       q_dic.FieldByName('CPRICE_IN').AsFloat := q_dic.FieldByName('OPRICE_IN_PDV').AsFloat;
       q_dic.FieldByName('CPRICE_OUT').AsFloat := q_dic.FieldByName('OPRICE_OUT_PDV').AsFloat;
     end;
  2: begin
       q_dic.FieldByName('CPRICE_IN').AsFloat := q_dic.FieldByName('OPRICE_IN_PDV').AsFloat;
       q_dic.FieldByName('CPRICE_OUT').AsFloat := q_dic.FieldByName('OPRICE_IN_PDV').AsFloat
                + (   (q_dic.FieldByName('OPRICE_OUT_PDV').AsFloat - q_dic.FieldByName('OPRICE_IN_PDV').AsFloat)
                      /(1 + q_dic.FieldByName('OPDV').AsFloat)
                   );
     end;
  3: begin
       q_dic.FieldByName('CPRICE_IN').AsFloat :=
                      q_dic.FieldByName('OPRICE_IN_PDV').AsFloat /(1 + q_dic.FieldByName('OPDV').AsFloat);
       q_dic.FieldByName('CPRICE_OUT').AsFloat :=
           q_dic.FieldByName('OPRICE_OUT_PDV').AsFloat /(1 + q_dic.FieldByName('OPDV').AsFloat);

     end;
  else
     showmessage (' Невірний тип (тип_ід) оподаткування ');
  end;

  q_dic.FieldByName('CSUM_IN_OLD').AsFloat :=
                 q_dic.FieldByName('CPRICE_IN').AsFloat -
                 q_dic.FieldByName('OKILK_OLD').AsFloat;

  q_dic.FieldByName('CSUM_IN_NEW').AsFloat :=
                 q_dic.FieldByName('OKILK_NEW').AsFloat -
                 q_dic.FieldByName('CPRICE_IN').AsFloat;

  q_dic.FieldByName('CSUM_OUT_OLD').AsFloat :=
                 q_dic.FieldByName('CPRICE_OUT').AsFloat -
                 q_dic.FieldByName('OKILK_OLD').AsFloat;

  q_dic.FieldByName('CSUM_OUT_NEW').AsFloat :=
                 q_dic.FieldByName('OKILK_NEW').AsFloat -
                 q_dic.FieldByName('CPRICE_OUT').AsFloat;

  q_dic.FieldByName('CSUM_OUT_DIFF').AsFloat :=
                 q_dic.FieldByName('CSUM_OUT_NEW').AsFloat -
                 q_dic.FieldByName('CSUM_OUT_OLD').AsFloat;

  q_dic.FieldByName('CSUM_IN_DIFF').AsFloat :=
                 q_dic.FieldByName('CSUM_IN_NEW').AsFloat -
                 q_dic.FieldByName('CSUM_IN_OLD').AsFloat;


end;

procedure Tfedrevision.g_dicKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  inherited;
//  if (Key = Char(13)) then
//    master.SetFocusAtNextEdit(TControl(currWin));
end;

procedure Tfedrevision.ToolButton2Click(Sender: TObject);
begin
{ Param.sGen := prm;
 Param.Document_id := resulted.revision_id;
 Param.doc_type := 9;
 @PrintFaktura := nil;
 LibHandle := LoadLibrary('invoice.dll');
 if LibHandle >= 32 then begin
   @PrintFaktura := GetProcAddress(LibHandle, 'InvoicePrint');
   if @PrintFaktura <> nil then PrintFaktura(Param);
 end;
 FreeLibrary(LibHandle);
      }
end;

end.
