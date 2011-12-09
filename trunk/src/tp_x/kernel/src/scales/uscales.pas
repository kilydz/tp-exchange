unit uscales;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, dxExEdtr, StdCtrls, uZbutton, uZFilter, dxCntner, dxTL, dxDBCtrl,
  dxDBGrid, ExtCtrls, uZToolButton, ToolWin, ComCtrls, uZToolBar, uZControlBar,
  DB, RxMemDS, IBSQL, IBDatabase, ImgList, kernel_h, Zutils_h, dxDBTLCl,
  dxGrClms;

type
  Tfscales = class(TForm)
    images: TImageList;
    base: TIBDatabase;
    tr_R: TIBTransaction;
    q_R: TIBSQL;
    mem_dic: TRxMemoryData;
    ds_dic: TDataSource;
    panel: TPanel;
    p_top_control_bar: ZControlBar;
    p_main_tool_bar: ZToolBar;
    bt_ins: ZToolButton;
    bt_upd: ZToolButton;
    bt_del: ZToolButton;
    g_dic: TdxDBGrid;
    Panel1: TPanel;
    bt_ok: ZButton;
    mem_dicscale_id: TIntegerField;
    mem_dicnumber: TIntegerField;
    mem_dicname: TStringField;
    mem_dicprefix: TIntegerField;
    mem_dicscale_interface_id: TSmallintField;
    mem_dicscale_type_id: TSmallintField;
    mem_dicis_sync: TBooleanField;
    g_dicscale_id: TdxDBGridMaskColumn;
    g_dicnumber: TdxDBGridMaskColumn;
    g_dicname: TdxDBGridMaskColumn;
    g_dicprefix: TdxDBGridMaskColumn;
    g_dicis_sync: TdxDBGridCheckColumn;
    mem_dicwith_zero_rest: TBooleanField;
    g_dicwith_zero_rest: TdxDBGridCheckColumn;
    g_dicscale_type_id: TdxDBGridImageColumn;
    g_dicscale_interface_id: TdxDBGridImageColumn;
    ZButton1: ZButton;
    procedure ZButton1Click(Sender: TObject);
    procedure bt_Click(Sender: TObject);
  private
    { Private declarations }
  public
    prm: ZVelesInfoRec;

    procedure InitInfo;
    procedure RefreshDic;
    procedure RefreshRecord;

    function IsRecordNull: boolean;

    procedure ListInit(ed_list: TdxDBGridImageColumn; sql_fill: string);
    procedure ListClear(ed_list: TdxDBGridImageColumn);
  end;

function ScalesListDialog(var prm: ZVelesInfoRec): Longint; stdcall;

implementation

uses uscale, usync_log;

{$R *.dfm}

function ScalesListDialog(var prm: ZVelesInfoRec): Longint; stdcall;
var dlg: Tfscales;
begin
  dlg := Tfscales.Create(Application);
  dlg.prm := prm;
  dlg.InitInfo;
  dlg.ShowModal;

  ScalesListDialog := 0;

  dlg.Free;
end;

procedure Tfscales.InitInfo;
begin
  base.SetHandle(prm.db_handle);

  ListClear(g_dicscale_type_id);
  ListInit(g_dicscale_type_id, 'select scale_type_id as id, name from t_scale_types');
  ListClear(g_dicscale_interface_id);
  ListInit(g_dicscale_interface_id, 'select scale_interface_id as id, name from t_scale_interfaces');

  RefreshDic;
end;

procedure Tfscales.RefreshDic;
var old_cursor: TCursor;
begin
    old_cursor := Screen.Cursor;
   try
    Screen.Cursor := crSQLWait;

    if tr_R.InTransaction then tr_R.Commit;
    tr_R.StartTransaction;
     q_R.SQL.Text := 'select scale_id, number, name, prefix, scale_interface_id, ' +
' scale_type_id from t_scales_v1';
     q_R.ExecQuery;
     mem_dic.Close;
     mem_dic.Open;
     while not q_R.Eof do
     begin
       mem_dic.Append;
       mem_dicscale_id.AsInteger := q_R.FieldByName('scale_id').AsInteger;
       mem_dicnumber.AsInteger := q_R.FieldByName('number').AsInteger;
       mem_dicname.AsString := q_R.FieldByName('name').AsString;
       mem_dicprefix.AsInteger := q_R.FieldByName('prefix').AsInteger;
       mem_dicscale_interface_id.AsInteger := q_R.FieldByName('scale_interface_id').AsInteger;
       mem_dicscale_type_id.AsInteger := q_R.FieldByName('scale_type_id').AsInteger;
       mem_dicis_sync.AsBoolean := true;
       mem_dicwith_zero_rest.AsBoolean := true;
       mem_dic.Post;
       q_R.Next;
     end;
    if tr_R.InTransaction then tr_R.Commit;

   finally
    Screen.Cursor := old_cursor;
   end;
end;

procedure Tfscales.RefreshRecord;
var old_cursor: TCursor;
begin
    old_cursor := Screen.Cursor;
   try
    Screen.Cursor := crSQLWait;

    if tr_R.InTransaction then tr_R.Commit;
    tr_R.StartTransaction;
     q_R.SQL.Text := 'select scale_id, number, name, prefix, scale_interface_id, ' +
' scale_type_id from t_scales_v1 where scale_id = :iscale_id';
     q_R.ParamByName('iscale_id').AsInteger := mem_dic.FieldByName('scale_id').AsInteger;
     q_R.ExecQuery;
     mem_dic.Edit;
     mem_dicscale_id.AsInteger := q_R.FieldByName('scale_id').AsInteger;
     mem_dicnumber.AsInteger := q_R.FieldByName('number').AsInteger;
     mem_dicname.AsString := q_R.FieldByName('name').AsString;
     mem_dicprefix.AsInteger := q_R.FieldByName('prefix').AsInteger;
     mem_dicscale_interface_id.AsInteger := q_R.FieldByName('scale_interface_id').AsInteger;
     mem_dicscale_type_id.AsInteger := q_R.FieldByName('scale_type_id').AsInteger;
     mem_dic.Post;
    if tr_R.InTransaction then tr_R.Commit;

   finally
    Screen.Cursor := old_cursor;
   end;
end;

procedure Tfscales.ZButton1Click(Sender: TObject);
begin
  ScaleSyncLog(mem_dic, prm);
end;

procedure Tfscales.bt_Click(Sender: TObject);
var button: ZToolButton;
    old_cursor: TCursor;
    ins_upd_result: integer;
    ins_upd_input: ZFuncArgs;
begin
  button := ZToolButton(Sender);

    // Створення запису
  if button = bt_ins then
  begin
    ins_upd_input.id := 0;
    ins_upd_result := ScaleDialog(ins_upd_input, prm);
    if ins_upd_result > 0 then
    begin
      mem_dic.Insert;
      mem_dic.FieldByName(g_dic.KeyField).AsInteger := ins_upd_result;
      mem_dic.Post;
      RefreshRecord;
    end;
  end
  // Редагування запису
  else if button = bt_upd then
  begin
    if IsRecordNull then
      exit;

    ins_upd_input.id := mem_dic.FieldByName(g_dic.KeyField).AsInteger;
    ins_upd_result := ScaleDialog(ins_upd_input, prm);
    if ins_upd_result > 0 then
    begin
      RefreshRecord;
    end;
  end
end;

// Перевірка, чи існує запис
function Tfscales.IsRecordNull: boolean;
var res: boolean;
begin
  res := mem_dic.FieldByName(g_dic.KeyField).IsNull;
  if res then
    GMessageBox('Потрібно встановити курсор на запис.', 'Закрити');
  IsRecordNull := res;
end;

// Процедура заповнення випадаючого списку з запроса
procedure Tfscales.ListInit(ed_list: TdxDBGridImageColumn; sql_fill: string);
begin
  if(tr_R.InTransaction)then tr_R.Commit;
  tr_R.StartTransaction;
   q_R.SQL.Text := sql_fill;
   q_R.ExecQuery;
   while not q_R.Eof do
   begin
     ed_list.Descriptions.Add(q_R.FieldByName('name').AsString);
     ed_list.Values.Add(q_R.FieldByName('id').AsString);
     q_R.Next;
   end;
  if(tr_R.InTransaction) then tr_R.Commit;
end;

procedure Tfscales.ListClear(ed_list: TdxDBGridImageColumn);
begin
  ed_list.Descriptions.Clear;
  ed_list.Values.Clear;
end;

end.
