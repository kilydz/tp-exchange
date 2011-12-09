unit sql_price;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, Buttons, ExtCtrls, CheckLst, dxCntner, dxTL, dxTLClms,
  pricelist_h, dxExEdtr, kernel_h, DB, IBCustomDataSet, IBQuery, IBDatabase, genstor_h,
  secure_h, Zutils_h, uZbutton, dxEditor, dxEdLib, dxDBTLCl,
  dxGrClms, dxDBCtrl, dxDBGrid, RxMemDS, IBSQL, FR_Shape, FR_BarC, FR_Class,
  FR_DSet, FR_DBSet, Menus, FR_Desgn, IniFiles;

const pcSmall = 1; pcA5 = 2; pcA4 = 3;
                   pcA5_P = 100; pcA4_P = 101;
                   pcMoroz = 200;

type
  Tfsql_price = class(TForm)
    pBottom: TPanel;
    base: TIBDatabase;
    bt_cancel: ZButton;
    bt_ok: ZButton;
    Panel1: TPanel;
    ed_price_type: TdxImageEdit;
    Label1: TLabel;
    ds_dic: TDataSource;
    tr_R: TIBTransaction;
    q_R: TIBSQL;
    tr_W: TIBTransaction;
    q_W: TIBSQL;
    mem_dic: TRxMemoryData;
    mem_dicid: TIntegerField;
    mem_dicnomen_id: TIntegerField;
    mem_dicnomen_name: TStringField;
    mem_dicnomen_code: TStringField;
    g_dic: TdxDBGrid;
    mem_diccnt: TIntegerField;
    g_dicid: TdxDBGridMaskColumn;
    g_dicnomen_id: TdxDBGridMaskColumn;
    g_dicnomen_name: TdxDBGridMaskColumn;
    g_dicnomen_code: TdxDBGridMaskColumn;
    g_dicprint_it: TdxDBGridCheckColumn;
    g_dicis_in_discount: TdxDBGridCheckColumn;
    g_diccnt: TdxDBGridMaskColumn;
    g_dicoutprice: TdxDBGridMaskColumn;
    mem_print: TRxMemoryData;
    mem_printid: TIntegerField;
    mem_printnomen_id: TIntegerField;
    mem_printnomen_name: TStringField;
    mem_printnomen_code: TStringField;
    mem_printintp0: TIntegerField;
    mem_printdecp0: TStringField;
    mem_printintp: TIntegerField;
    mem_printdecp: TStringField;
    mem_printsi_name: TStringField;
    mem_dicoutprice: TFloatField;
    mem_printoutprice: TFloatField;
    mem_printbarcode: TStringField;
    mem_printdatex_name: TStringField;
    mem_dicis_in_discount: TIntegerField;
    mem_dicprint_it: TIntegerField;
    mem_printis_in_discount: TSmallintField;
    base_frf: TfrDBDataSet;
    report_frf: TfrReport;
    frBarCodeObject1: TfrBarCodeObject;
    frShapeObject1: TfrShapeObject;
    mi_popup: TPopupMenu;
    mi_select_all: TMenuItem;
    mi_deselect_all: TMenuItem;
    frDesigner1: TfrDesigner;
    mem_printmaker_point: TStringField;
    procedure mi_popupPopup(Sender: TObject);
    procedure mi_itemsClick(Sender: TObject);
    procedure report_frfUserFunction(const Name: string; p1, p2, p3: Variant;
      var Val: Variant);
    procedure FormDestroy(Sender: TObject);
    procedure btnPrintClick(Sender: TObject);
    procedure BitBtn1Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
    prm: ZVelesInfoRec;
    sql: string;
    frf_list: TStringList;

    function GetFullNomenName: String;
    procedure InitInfo;
    procedure RefreshDic;
    procedure RefreshPrint;
  end;

procedure PricesBySQL(sql: string; prm: ZVelesInfoRec);

implementation

{$R *.dfm}

procedure PricesBySQL(sql: string; prm: ZVelesInfoRec);
var dlg: Tfsql_price;
begin
  if not HasUserAccessEx(prm, ACCESS_TO_PRINT, false) then
  begin
      GMessageBox('Ви не маєте прав на друк!', 'OK');
      Exit;
  end;
  if not HasUserAccessEx(prm, ACCESS_TO_PRINT_PRICES_SQL, false) then
  begin
      GMessageBox('Ви не маєте прав на друк цінників по документу!', 'OK');
      Exit;
  end;

try
  dlg := Tfsql_price.Create(Application);
  dlg.prm := prm;
  dlg.sql := sql;
  dlg.InitInfo;
  dlg.ShowModal;
finally
  if dlg <> nil then dlg.Free;
end;
end;

procedure Tfsql_price.InitInfo;
var f: TIniFile;
begin
  base.SetHandle(prm.db_handle);

  frf_list := TStringList.Create;
  ed_price_type.Descriptions.Clear;
  ed_price_type.Values.Clear;
  ed_price_type.Descriptions.Add('Маленькі цінники');
  ed_price_type.Values.Add('0');
  frf_list.Add('small.frf');
  ed_price_type.Descriptions.Add('Цінник А5');
  ed_price_type.Values.Add('1');
  frf_list.Add('A5.frf');
  ed_price_type.Descriptions.Add('Цінник А4');
  ed_price_type.Values.Add('2');
  frf_list.Add('A4.frf');
  ed_price_type.Descriptions.Add('Переоцінка А5');
  ed_price_type.Values.Add('3');
  frf_list.Add('A5_P.frf');
  ed_price_type.Descriptions.Add('Переоцінка А4');
  ed_price_type.Values.Add('4');
  frf_list.Add('A4_P.frf');
  ed_price_type.Descriptions.Add('Для морозильників');
  ed_price_type.Values.Add('5');
  frf_list.Add('moroz.frf');
  ed_price_type.Descriptions.Add('Комічний стиль (без знижки)');
  ed_price_type.Values.Add('6');
  frf_list.Add('comic.frf');
  ed_price_type.Descriptions.Add('Комічний стиль А5 (без знижки)');
  ed_price_type.Values.Add('7');
  frf_list.Add('comic_A5.frf');
  ed_price_type.Descriptions.Add('Комічний стиль А4 (без знижки)');
  ed_price_type.Values.Add('8');
  frf_list.Add('comic_A4.frf');
  RefreshDic;

  //Налаштування
  f := TIniFile.Create(prm.root_way + WAY_INI + 'sql_price.ini');
   ed_price_type.Text := f.ReadString('Type', 'price_type', '0');
  f.Free;
end;

procedure Tfsql_price.mi_itemsClick(Sender: TObject);
var field_name   :string;
begin
  field_name  := g_dic.FocusedField.FieldName;

  if ((field_name <> 'print_it') and (field_name <> 'is_in_discount')) then
    exit;

  if Sender = mi_select_all then
  begin
    mem_dic.First;
    while not mem_dic.Eof do
    begin
      if mem_dic.FieldByName(field_name).AsInteger = 0 then
      begin
        mem_dic.Edit;
        mem_dic.FieldByName(field_name).AsInteger := 1;
        mem_dic.Post;
      end;
      mem_dic.Next;
    end
  end
  else if Sender = mi_deselect_all then
  begin
    mem_dic.First;
    while not mem_dic.Eof do
    begin
      if mem_dic.FieldByName(field_name).AsInteger = 1 then
      begin
        mem_dic.Edit;
        mem_dic.FieldByName(field_name).AsInteger := 0;
        mem_dic.Post;
      end;
      mem_dic.Next;
    end
  end
end;

procedure Tfsql_price.mi_popupPopup(Sender: TObject);
var field_name   :string;
begin
  field_name  := g_dic.FocusedField.FieldName;

  if ((field_name <> 'print_it') and (field_name <> 'is_in_discount')) then
  begin
    mi_select_all.Enabled := false;
    mi_deselect_all.Enabled := false;
  end
  else
  begin
    mi_select_all.Enabled := true;
    mi_deselect_all.Enabled := true;
  end;
end;

procedure Tfsql_price.RefreshDic;
var document_id: integer;
    old_cursor: TCursor;
    num: integer;
begin
    old_cursor := Screen.Cursor;
   try
    Screen.Cursor := crSQLWait;

    if tr_R.InTransaction then tr_R.Commit;
    tr_R.StartTransaction;
     q_R.SQL.Text := sql;
     q_R.ExecQuery;
     mem_dic.Close;
     mem_dic.Open;
     num := 1;
     while not q_R.Eof do
     begin
       mem_dic.Append;
       mem_dicid.AsInteger := num;
       mem_dicnomen_id.AsInteger := q_R.FieldByName('onomen_id').AsInteger;
       mem_dicnomen_code.AsString := q_R.FieldByName('onomen_code').AsString;
       mem_dicnomen_name.AsString := q_R.FieldByName('onomen_name').AsString;
       mem_dicoutprice.AsFloat := q_R.FieldByName('ooutprice').AsFloat;
       mem_dicis_in_discount.AsInteger := q_R.FieldByName('ois_in_discount').AsInteger;
       mem_dicprint_it.AsInteger := q_R.FieldByName('oprint_it').AsInteger;
       mem_diccnt.AsInteger := 1;
       mem_dic.Post;
       num := num + 1;
       q_R.Next;
     end;
    if tr_R.InTransaction then tr_R.Commit;

   finally
    Screen.Cursor := old_cursor;
   end;
end;

procedure Tfsql_price.RefreshPrint;
var num: integer;
    cnt: integer;
begin
  if tr_R.InTransaction then tr_R.Commit;
  tr_R.StartTransaction;
   mem_print.Close;
   mem_print.Open;
   mem_dic.First;
   num := 0;
   while not mem_dic.Eof do
   begin
     if (mem_dicprint_it.AsInteger > 0) and (mem_diccnt.AsInteger > 0) then
     begin
       q_R.Close;
       q_R.SQL.Text := 'select * from PS_PRINT_PRICES_V1(:inomen_id)';
       q_R.ParamByName('inomen_id').AsInteger := mem_dicnomen_id.AsInteger;
       q_R.ExecQuery;
       cnt := mem_diccnt.AsInteger;
       while cnt > 0 do
       begin
         mem_print.Append;
         mem_printid.AsInteger := num;
         mem_printnomen_id.AsInteger := q_R.FieldByName('onomen_id').AsInteger;
         mem_printnomen_code.AsString := q_R.FieldByName('onomen_code').AsString;
         mem_printnomen_name.AsString := q_R.FieldByName('onomen_name').AsString;
         mem_printintp0.AsInteger := q_R.FieldByName('ointp0').AsInteger;
         mem_printdecp0.AsString := q_R.FieldByName('odecp0').AsString;
         mem_printintp.AsInteger := q_R.FieldByName('ointp').AsInteger;
         mem_printdecp.AsString := q_R.FieldByName('odecp').AsString;
         mem_printsi_name.AsString := q_R.FieldByName('osi_name').AsString;
         mem_printbarcode.AsString := q_R.FieldByName('obarcode').AsString;
         mem_printoutprice.AsFloat := q_R.FieldByName('ooutprice').AsFloat;
         mem_printdatex_name.AsString := q_R.FieldByName('odatex_name').AsString;
         mem_printmaker_point.AsString := q_R.FieldByName('omaker_point').AsString;
         mem_printis_in_discount.AsInteger := mem_dicis_in_discount.AsInteger;
         mem_print.Post;
         cnt := cnt - 1;
         num := num + 1;
       end;
     end;
     mem_dic.Next;
   end;
end;

procedure Tfsql_price.report_frfUserFunction(const Name: string; p1, p2,
  p3: Variant; var Val: Variant);
var int_part: integer;
    dec_part: integer;
    rr: real;
begin
  if name ='INT_PART' then
  begin
    rr := frParser.Calc(p1) * frParser.Calc(p2);
    if (Trunc(rr * 100) < Trunc(frParser.Calc(p1) * 100)) then
      rr := rr + 0.01;

    int_part := Trunc(rr);
    val := int_part;
  end;
  if name ='DEC_PART' then
  begin
    rr := frParser.Calc(p1) * frParser.Calc(p2);
    if (Trunc(rr * 100) < Trunc(frParser.Calc(p1) * 100)) then
      rr := (rr + 0.01) * 100;
    dec_part := Trunc(rr) mod 100;
    val := dec_part;
  end
end;

function Tfsql_price.GetFullNomenName: String;
begin

end;

procedure Tfsql_price.BitBtn1Click(Sender: TObject);
var i :integer;
begin

end;

procedure Tfsql_price.btnPrintClick(Sender: TObject);
var frf: string;
    frf_index: integer;
begin
  RefreshPrint;

  frf_index := ed_price_type.Values.IndexOf(ed_price_type.Text);
  frf := prm.root_way + 'tuning\print\prices\' +  frf_list[frf_index];
  report_frf.LoadFromFile(frf);
  report_frf.ShowReport;
end;

procedure Tfsql_price.FormDestroy(Sender: TObject);
var f: TIniFile;
begin
  //Налаштування
  f := TIniFile.Create(prm.root_way + WAY_INI + 'sql_price.ini');
   f.WriteString('Type', 'price_type', ed_price_type.Text);
  f.Free;

  frf_list.Free;
end;

end.
