unit edmarkup;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, dxExEdtr, ExtCtrls, dxCntner, dxTL, dxDBCtrl, dxDBGrid,
  ComCtrls, ToolWin, uXToolBar, uXControlBar, nomenlist,
  veles_h, markup_h, editors_h, DB, IBDatabase,
  IBCustomDataSet, IBQuery, IBSQL, IB, etalon_ed, IBUpdateSQL,
  ImgList, Menus, dxEditor, dxEdLib;

type
  Tfedmarkup = class(Tfetalon_ed)
    q_dicOCODE: TIBStringField;
    q_dicOFULL_NAME: TIBStringField;
    q_dicOIN_PRICE: TFloatField;
    q_dicOOUT_PRICE: TFloatField;
    g_dicOCODE: TdxDBGridMaskColumn;
    g_dicOFULL_NAME: TdxDBGridMaskColumn;
    g_dicOIN_PRICE: TdxDBGridMaskColumn;
    g_dicOOUT_PRICE: TdxDBGridMaskColumn;
    q_dicMARKUP: TCurrencyField;
    q_dicMARKUP_SUM: TCurrencyField;
    g_dicMARKUP: TdxDBGridColumn;
    g_dicMARKUP_SUM: TdxDBGridColumn;
    q_dicOIN_PRICE_OLD: TFloatField;
    q_dicOOUT_PRICE_CURR: TFloatField;
    g_dicOIN_PRICE_OLD: TdxDBGridMaskColumn;
    g_dicOOUT_PRICE_CURR: TdxDBGridMaskColumn;
    q_dicIN_PRICE_DELTA: TCurrencyField;
    g_dicIN_PRICE_DELTA: TdxDBGridColumn;
    q_dicORECORD_ID: TIntegerField;
    g_dicORECORD_ID: TdxDBGridMaskColumn;
    q_dicONOMEN_ID: TIntegerField;
    procedure bt_toolClick(Sender: TObject); override;
    procedure q_dicCalcFields(DataSet: TDataSet);
    procedure FormClose(Sender: TObject; var Action: TCloseAction); override;
  private
    { Private declarations }
  public
    resulted: lpZMarkupDialogResulted;

    procedure InitInfo; override;
    procedure RefreshDic; override;

    procedure OnAddRec(var nomen_id: integer); override;
  end;

function MarkupRecordsEditor(resulted: lpZMarkupDialogResulted; var prm: ZVelesInfoRec): integer;

implementation

{$R *.dfm}
function MarkupRecordsEditor(resulted: lpZMarkupDialogResulted; var prm: ZVelesInfoRec): integer;
var
  dlg: Tfedmarkup;
  returned: integer;
begin
  // Перевірка прав
  returned := 0;
try
    // Створення та ініціалізація форми діалогу.
    dlg := Tfedmarkup.Create(Application);
    dlg.prm := prm;
    dlg.resulted := resulted;
    dlg.InitInfo;

    // Візуалізація діалогу
    if (dlg.ShowModal = mrOk) then
    begin
      returned := dlg.resulted.markup_id;
    end;
finally
  if dlg <> nil then dlg.Free;
end;
  //    returned <= 0 - код помилки, або відмова;
  //    returned > 0  - id результату;
  MarkupRecordsEditor := returned;
end;

//------------------------------------------------------------------------------
//
//------------------------------------------------------------------------------
procedure Tfedmarkup.InitInfo;
begin
  inherited InitInfo;
  document_id := resulted.markup_id;
  sql_refresh_record   := 'select ocode, ofull_name, oin_price, oout_price, oin_price_old, oout_price_curr, onomen_id from PS_MARKUP_RECORD_VIEW_V1(:irecord_id)';
  sql_delete_record    := 'select * from PS_MARKUP_RECORD_DEL(:idocument_id)';

  sql_block_document   := 'update t_markups set is_block = 1 where markup_id = :idocument_id';
  sql_unblock_document := 'update t_markups set is_block = 0 where markup_id = :idocument_id';

end;

procedure Tfedmarkup.RefreshDic;
begin
  q_dic.ParamByName('imarkup_id').AsInteger := resulted.markup_id;
  inherited RefreshDic;
end;

procedure Tfedmarkup.bt_toolClick(Sender: TObject);
var button: TToolButton;
    resulted: ZMarkupRecordDialogResulted;
begin
  inherited bt_toolClick(Sender);

  button := TToolButton(Sender);
  if button = bt_upd then
  begin
    if q_dic.FieldByName(g_dic.KeyField).AsInteger <= 0 then
    begin
      ShowMessage('Не вибрано запису для редагування.');
      exit;
    end;

    if (MarkupRecordDialog(q_dic.FieldByName('orecord_id').AsInteger,
                                 @resulted, prm) > 0) then
    begin
      RefreshRecord;
    end;
  end
  else if button = bt_header then
  begin

    RefreshRecord;
  end
end;

procedure Tfedmarkup.OnAddRec(var nomen_id: integer);
var markup_record_id: integer;
begin
  if FindRecordIdByNomenId('onomen_id', nomen_id) <> -1 then
    exit;

 try
  if tr_W.InTransaction then tr_W.Commit;
  tr_W.StartTransaction;
   q_W.SQL.Text := 'select omarkup_record_id from PS_MARKUP_RECORD_INS(:imarkup_id, :inomen_id, :imarkup, :imarkup_around_id)';
   q_W.ParamByName('imarkup_id').AsInteger       := resulted.markup_id;
   q_W.ParamByName('inomen_id').AsInteger        := nomen_id;
   q_W.ParamByName('imarkup').AsCurrency         := resulted.markup;
   q_W.ParamByName('imarkup_around_id').AsShort  := resulted.markup_around_id;
   q_W.ExecQuery;
   markup_record_id := q_W.FieldByName('omarkup_record_id').AsInteger;
  if tr_W.InTransaction then tr_W.Commit;

  l_nomen_id.Add(markup_record_id, nomen_id);

  q_dic.Insert;
  q_dic.FieldByName('orecord_id').AsInteger := markup_record_id;
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

procedure Tfedmarkup.q_dicCalcFields(DataSet: TDataSet);
begin
  q_dic.FieldByName('MARKUP_SUM').AsCurrency :=
                 q_dic.FieldByName('OOUT_PRICE').AsCurrency -
                 q_dic.FieldByName('OIN_PRICE').AsCurrency;
  q_dic.FieldByName('IN_PRICE_DELTA').AsCurrency :=
                 q_dic.FieldByName('OIN_PRICE').AsCurrency -
                 q_dic.FieldByName('OIN_PRICE_OLD').AsCurrency;

  if (q_dic.FieldByName('OIN_PRICE').AsCurrency <> 0) then
    q_dic.FieldByName('MARKUP').AsCurrency :=
                 (q_dic.FieldByName('MARKUP_SUM').AsCurrency /
                  q_dic.FieldByName('OIN_PRICE').AsCurrency) * 100
  else
    q_dic.FieldByName('MARKUP').AsCurrency := 0.00;
end;

procedure Tfedmarkup.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  inherited FormClose(Sender, Action);
end;

end.
