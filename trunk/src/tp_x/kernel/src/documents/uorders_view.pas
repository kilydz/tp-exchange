unit uorders_view;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, etalon_dic, dxExEdtr, dxCntner, Menus, IBCustomDataSet, IBUpdateSQL,
  IBSQL, IBDatabase, DB, IBQuery, ImgList, ExtCtrls, uZFilter, dxTL, dxDBCtrl,
  dxDBGrid, ComCtrls, ToolWin, uZToolBar, uZControlBar, popups_h, autoorder_h,
  StdCtrls, kernel_h, dxEditor, dxEdLib, uZToolButton;

type
  Tforders_view = class(Tfetalon_dic)
    q_dicONOMEN_ID: TIntegerField;
    q_dicOW3_NOMEN_ID: TIntegerField;
    q_dicONOMEN_CODE: TIBStringField;
    q_dicONOMEN_NAME: TIBStringField;
    q_dicODOC_KILK: TFloatField;
    q_dicOORDERED: TFloatField;
    q_dicODOC_SUM_OUT: TFloatField;
    q_dicODOC_SUM_OUT_PDV: TFloatField;
    q_dicOAO_SUM_OUT_PDV: TFloatField;
    q_dicODOC_SUM_IN: TFloatField;
    q_dicODOC_SUM_IN_PDV: TFloatField;
    q_dicOAO_SUM_IN_PDV: TFloatField;
    q_dicOAO_LAST_INPRICE: TFloatField;
    g_dicONOMEN_ID: TdxDBGridMaskColumn;
    g_dicOW3_NOMEN_ID: TdxDBGridMaskColumn;
    g_dicONOMEN_CODE: TdxDBGridMaskColumn;
    g_dicONOMEN_NAME: TdxDBGridMaskColumn;
    g_dicODOC_KILK: TdxDBGridMaskColumn;
    g_dicOORDERED: TdxDBGridMaskColumn;
    g_dicODOC_SUM_OUT: TdxDBGridMaskColumn;
    g_dicODOC_SUM_OUT_PDV: TdxDBGridMaskColumn;
    g_dicOAO_SUM_OUT_PDV: TdxDBGridMaskColumn;
    g_dicODOC_SUM_IN: TdxDBGridMaskColumn;
    g_dicODOC_SUM_IN_PDV: TdxDBGridMaskColumn;
    g_dicOAO_SUM_IN_PDV: TdxDBGridMaskColumn;
    g_dicOAO_LAST_INPRICE: TdxDBGridMaskColumn;

    procedure mi_Click(Sender: TObject);
  private
    { Private declarations }
    id :integer;
  public
    { Public declarations }
    procedure InitInfo; override;
    procedure RefreshDic; override;
  end;

var
  forders_view: Tforders_view;

function OrdersViewDialog(id: integer; var prm: ZVelesInfoRec): integer;

implementation

{$R *.dfm}

function OrdersViewDialog(id: integer; var prm: ZVelesInfoRec): integer;
var
  dlg: Tforders_view;
  returned: integer;
begin
// Перевірка прав
  returned := 0;
try
// Створення та ініціалізація форми діалогу.
    dlg := Tforders_view.Create(Application);
    dlg.id := id;
    dlg.prm := prm;
    dlg.prm.control_pointers.panel_ptr := nil;
    dlg.InitInfo;

// Візуалізація діалогу
    if (dlg.ShowModal = mrOk) then
    begin
      returned := dlg.id;
    end;
finally
  if dlg <> nil then dlg.Free;
end;
//    returned <= 0 - код помилки, або відмова;
//    returned > 0  - id результату;
  Result := returned;
end;

procedure Tforders_view.InitInfo;
begin
//  sql_refresh_document  := 'select ois_fixed, otoken, odate, oanalysed_days, oordered_days, oclient_name, ostaff_name, ao.ao_use_period, ao.ao_date0, ao.ao_date1, ao.document_id, ao.print_cnt from PS_AUTOORDER_VIEW(:idocument_id)'+
//                           '  aov left join t_autoorders ao on aov.oautoorder_id = ao.autoorder_id' ;
//  sql_delete_document   := 'select * from PS_AUTOORDER_DEL(:idocument_id)';
//  sql_close_document    := 'update t_autoorders set ao_conditions = absrizn(ao_conditions, 1) where autoorder_id = :idocument_id';
////  sql_block_document    :=
//  sql_unblock_document  := 'update t_autoorders set is_block = 0 where autoorder_id = :idocument_id';
//  sql_is_fixed_document := 'select ao_conditions as is_fixed from t_autoorders where autoorder_id = :idocument_id';
//  sql_is_block_document := 'select is_block from t_autoorders where autoorder_id = :idocument_id';

//  access_to_del            := ACCESS_TO_AUTOORDER_DEL;
//  access_to_export_detaile := ACCESS_TO_AUTOORDER_EXPORT;  // Експорт документа

  access_to_export_dic     := ACCESS_TO_DOCUMENTS_EXPORT;    // Експорт довідника
  access_to_export_detaile := ACCESS_TO_DOCUMENT_EXPORT;     // Експорт документа

  dic_refresh_enabled := false;

  inherited InitInfo;
  panel.Visible := True;
end;

procedure Tforders_view.RefreshDic;
begin
  q_dic.ParamByName('idocument_id').AsInteger := id;
  inherited RefreshDic;
end;

procedure Tforders_view.mi_Click(Sender: TObject);
//var item: TMenuItem;
begin
  //item := TMenuItem(Sender);
  inherited mi_Click(Sender);
end;

end.
