unit eddocument;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, etalon_ed, dxExEdtr, ImgList, IBCustomDataSet, IBUpdateSQL,
  IBSQL, DB, IBQuery, IBDatabase, ExtCtrls, dxCntner, dxTL, dxDBCtrl,
  dxDBGrid, ComCtrls, ToolWin, uZToolBar, uZControlBar, document_h, kernel_h, nomenlist,
  dxEditor, dxEdLib, StdCtrls, Menus, dxDBTLCl, dxGrClms, IB, uZToolButton;

type
  Tfeddocument = class(Tfetalon_ed)
    ZToolBar1: ZToolBar;
    ed_default: TdxPopupEdit;
    Panel1: TPanel;
    p_default: TPanel;
    p_default_kilk: TPanel;
    Label1: TLabel;
    ed_default_kilk: TdxCalcEdit;
    p_price_type: TPanel;
    Label3: TLabel;
    ed_price_type: TdxImageEdit;
    p_koef: TPanel;
    Label2: TLabel;
    ed_default_koef: TdxCalcEdit;
    s_v_splitter: TSplitter;
    ed_description: TdxMemo;
    q_dicDOC_REC_ID: TIntegerField;
    q_dicCODE_WARES: TIntegerField;
    q_dicNAME_WARES: TIBStringField;
    q_dicNAME_WARES_BRAND: TIBStringField;
    q_dicABR_UNIT: TIBStringField;
    q_dicPRICE: TFloatField;
    q_dicSUMA: TFloatField;
    q_dicPRICE_WITH_VAT: TFloatField;
    q_dicSUMA_WITH_VAT: TFloatField;
    g_dicDOC_REC_ID: TdxDBGridMaskColumn;
    g_dicCODE_WARES: TdxDBGridMaskColumn;
    g_dicNAME_WARES: TdxDBGridMaskColumn;
    g_dicNAME_WARES_BRAND: TdxDBGridMaskColumn;
    g_dicABR_UNIT: TdxDBGridMaskColumn;
    g_dicPRICE: TdxDBGridMaskColumn;
    g_dicSUMA: TdxDBGridMaskColumn;
    g_dicPRICE_WITH_VAT: TdxDBGridMaskColumn;
    g_dicSUMA_WITH_VAT: TdxDBGridMaskColumn;
    q_dicQUANTITY: TFloatField;
    g_dicQUANTITY: TdxDBGridMaskColumn;
    procedure q_dicAfterScroll(DataSet: TDataSet);
    procedure bt_toolClick(Sender: TObject); override;
    procedure g_dicKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState); override;
    procedure g_dicKeyUp(Sender: TObject; var Key: Word;
      Shift: TShiftState); override;
    procedure FormClose(Sender: TObject; var Action: TCloseAction); override;
    procedure FormShow(Sender: TObject);
    procedure ed_default_kilkKeyPress(Sender: TObject; var Key: Char);
    procedure ed_default_kilkChange(Sender: TObject);
    procedure ed_price_typeChange(Sender: TObject);
    procedure ed_defaultCloseUp(Sender: TObject; var Text: String;
      var Accept: Boolean);
    procedure ed_default_koefChange(Sender: TObject);
    procedure q_dicCalcFields(DataSet: TDataSet);
  private
    { Private declarations }
  public
    { Public declarations }
    resulted: lpZDocumentDialogResulted;
    sql_record_info: string;
    detail_refresh_enabled: boolean;
    has_autoorder: Boolean;

    procedure InitInfo; override;
    procedure RefreshDic; override;
    function DocrecDialogDR(docrec_id, nomen_id: integer; code_unit: integer): integer;

    procedure OnAddRec(var nomen_id: integer; code_unit: integer); override;
    procedure OnAddAllRec(var grp_id: integer;nl_q_dic: TIBQuery); override;

    procedure RefreshDetaile;
  end;

function DocumentEditor(resulted: lpZDocumentDialogResulted; var prm: ZVelesInfoRec): integer;

implementation

{$R *.dfm}

function DocumentEditor(resulted: lpZDocumentDialogResulted; var prm: ZVelesInfoRec): integer;
var dlg: Tfeddocument;
begin
 try
  dlg := Tfeddocument.Create(Application);
  dlg.prm := prm;
  dlg.resulted := resulted;
  dlg.InitInfo;
  dlg.ShowModal;
 finally
  if dlg <> nil then dlg.Free;
 end;
  Result := 0;
end;

procedure Tfeddocument.InitInfo;
var proc_del: string;
begin
  document_id := resulted.document_id;
  nomen_list_descr.resulted := resulted;

  sql_header_info       := '';//'select odescript from PS_DOCUMENT_INFO(:idocument_id)';
  sql_record_info       := '';//'select odescript from PS_NOMEN_UNITE_INFO(:idocument_id)';
  has_autoorder := False;
  Tag := 6;

  inherited InitInfo;

  Caption := 'Редагування документа № ' + IntToStr(resulted.document_id);
  if resulted.name_firm <> '' then
    Caption := Caption + ' для '+ resulted.name_firm;
  

  document_id := resulted.document_id;

  sql_refresh_record :=
    'select dr.doc_rec_id, dr.code_wares, w.name_wares, w.name_wares_brand, dr.quantity,' + #13#10 +
      'ud.abr_unit,' + #13#10 +
      'dr.price_with_vat / (1 + dr.vat/100) as PRICE,' + #13#10 +
      'dr.price_with_vat / (1 + dr.vat/100) * dr.quantity as SUMA,' + #13#10 +
      'dr.price_with_vat,' + #13#10 +
      'dr.price_with_vat * dr.quantity as SUMA_WITH_VAT' + #13#10 +
      'from t_doc_recs dr, wares w, unit_dimension ud' + #13#10 +
          'where dr.doc_rec_id = :irecord_id' + #13#10 +
              'and dr.code_wares = w.code_wares' + #13#10 +
              'and dr.code_unit = ud.code_unit';
  sql_delete_record    := 'delete from t_doc_recs where doc_rec_id = (:idocument_id)';

  sql_block_document   := '';//'update t_documents set blok = 1 where document_id = :idocument_id';
  sql_unblock_document := '';//'update t_documents set blok = 0 where document_id = :idocument_id';
end;

procedure Tfeddocument.RefreshDic;
begin
  detail_refresh_enabled := false;
  q_dic.ParamByName('idocument_id').AsInteger := resulted.document_id;
  inherited RefreshDic;
  detail_refresh_enabled := true;
  RefreshDetaile;
end;

function Tfeddocument.DocrecDialogDR(docrec_id, nomen_id: integer; code_unit: integer): integer;
var docrec_prm: ZDocrecDialogResulted;
    markup_value: real;
begin
  docrec_prm.document := resulted;
  Result := DocrecDialogDR1 (docrec_id, nomen_id, code_unit, @docrec_prm, prm);
end;

procedure Tfeddocument.OnAddRec(var nomen_id: integer; code_unit: integer);
var docrec_id: integer;
begin

  if FindRecordIdByNomenId('onomen_id', nomen_id) <> -1 then
    exit;

  docrec_id := DocrecDialogDR(0, nomen_id, code_unit);
  if docrec_id > 0 then
  begin

    l_nomen_id.Add(docrec_id,nomen_id);

    q_dic.Insert;
    q_dic.FieldByName('doc_rec_id').AsInteger := docrec_id;
    q_dic.Post;
    RefreshRecord;
//    if resulted.typedoc_id = 1 then
    begin
      (nomen_list_descr.forma as Tfnomenlist).RefreshDic;
    end;
  end
end;

procedure Tfeddocument.OnAddAllRec(var grp_id: integer;nl_q_dic: TIBQuery);
//--------- Закидання товару по групі ----------------------------
var ao_record_id, nomen_id, record_id :integer;
begin
//
end;

procedure Tfeddocument.bt_toolClick(Sender: TObject);
var button: ZToolButton;
begin
  inherited bt_toolClick(Sender);

  button := ZToolButton(Sender);
  if button = bt_upd then
  begin
    if q_dic.FieldByName(g_dic.KeyField).AsInteger <= 0 then
    begin
      ShowMessage('Не вибрано запису для редагування.');
      exit;
    end;

    if (DocrecDialogDR(q_dic.FieldByName(g_dic.KeyField).AsInteger,
                       q_dic.FieldByName('code_wares').AsInteger, -1) > 0) then
    begin
      RefreshRecord;
    end;
  end else
  if button = bt_del then
  begin
    (nomen_list_descr.forma as Tfnomenlist).RefreshDic;
  end;
end;

procedure Tfeddocument.g_dicKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  inherited g_dicKeyDown(Sender, Key, Shift);
end;

procedure Tfeddocument.g_dicKeyUp(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  inherited g_dicKeyUp(Sender, Key, Shift);
end;

procedure Tfeddocument.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  inherited FormClose(Sender, Action);
end;

procedure Tfeddocument.FormShow(Sender: TObject);
begin
  inherited FormShow(Sender);
end;

procedure Tfeddocument.ed_default_kilkKeyPress(Sender: TObject; var Key: Char);
begin
  if ((Key = '.') or (Key = ',')) then
    Key := ','
  else if (Key < '0') or (Key > '9') then
    Key := #0;
end;

procedure Tfeddocument.ed_default_kilkChange(Sender: TObject);
begin
  if (ed_default_kilk.Text = '') then
  begin
    ed_default_kilk.Text := '0';
    if Visible then
      ed_default_kilk.SelectAll;
  end;
end;

procedure Tfeddocument.ed_default_koefChange(Sender: TObject);
begin
  if (ed_default_koef.Text = '') then
  begin
    ed_default_koef.Text := '0';
    if Visible then
      ed_default_koef.SelectAll;
  end;
end;

procedure Tfeddocument.ed_price_typeChange(Sender: TObject);
begin
  p_koef.Enabled := ((ed_price_type.Text = '1') or
                     (ed_price_type.Text = '2') or
                     (ed_price_type.Text = '3') or
                     (ed_price_type.Text = '4'));
end;

procedure Tfeddocument.ed_defaultCloseUp(Sender: TObject; var Text: String;
  var Accept: Boolean);
begin
//  resulted.default_kilk := StrToFloat(ed_default_kilk.Text);
//  resulted.default_price_type := StrToInt(ed_price_type.Text);
//  resulted.default_koef := StrToFloat(ed_default_koef.Text);
end;

procedure Tfeddocument.q_dicAfterScroll(DataSet: TDataSet);
begin
  inherited;
  RefreshDetaile;
end;

procedure Tfeddocument.q_dicCalcFields(DataSet: TDataSet);
begin
//
end;

// Обновлення детального довідника
procedure Tfeddocument.RefreshDetaile;
begin
  if (q_dic.FieldByName('code_wares').AsInteger = 0) then
    ed_description.Clear
  else if detail_refresh_enabled then
  begin
      ed_description.Clear;
{
     try
      if tr_R.InTransaction then tr_R.Commit;
      tr_R.StartTransaction;
       q_R.SQL.Text := sql_record_info;
       q_R.ParamByName('idocument_id').AsInteger :=
                      q_dic.FieldByName('code_wares').AsInteger;
       q_R.ExecQuery;
       while not q_R.Eof do
       begin
         ed_description.Lines.Add(q_R.FieldByName('odescript').AsString);
         q_R.Next;
       end;
      if tr_R.InTransaction then tr_R.Commit;
     except
        on E: EIBInterbaseError do
        begin
          if tr_W.InTransaction then tr_W.Rollback;
          ShowMessage(Format('Відбувся збій %s.', [#13 + E.Message + #13]));
        end;
     end;
}
  end;
end;

end.
