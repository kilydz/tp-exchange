unit etalon_dr;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, dxCntner, IBSQL, IBDatabase, DB, uZMaster, kernel_h, ExtCtrls, IB,
  Grids, document_h, dxEditor, dxExEdtr, dxEdLib, StdCtrls, genstor_h, Zutils_h,
  dxDBELib, dxDBEdtr, IBCustomDataSet, IBQuery;

type
  Tfetalon_dr = class(TForm)
    master: ZMaster;
    base: TIBDatabase;
    trR: TIBTransaction;
    qR: TIBSQL;
    trW: TIBTransaction;
    qW: TIBSQL;
    scStyle: TdxEditStyleController;
    p_stage0: TPanel;
    ed_goods_list: TStringGrid;
    Label1: TLabel;
    ed_kilk: TdxCalcEdit;
    ed_price: TdxCalcEdit;
    ed_sum: TdxCalcEdit;
    ed_price_pdv: TdxCalcEdit;
    ed_sum_pdv: TdxCalcEdit;
    Label_name: TLabel;
    ed_name: TdxEdit;
    lbl1: TLabel;
    trR1: TIBTransaction;
    q_dic: TIBQuery;
    q_dicCODE_UNIT: TIntegerField;
    q_dicNAME_UNIT: TIBStringField;
    q_dicCOEFFICIENT: TFMTBCDField;
    q_dicBAR_CODE: TIBStringField;
    q_dicDEFAULT_UNIT: TIBStringField;
    ds_dic: TDataSource;
    ed_code_unit: TdxLookupEdit;
    procedure btn1Click(Sender: TObject);
    procedure masterMasterResult(Sender: TObject;
      MasterResult: ZMasterResult); virtual;

    procedure EditsKeyDown(Sender: TObject; var Key: Word;
                        Shift: TShiftState); virtual;
    procedure EditsKeyPress(Sender: TObject; var Key: Char); virtual;
    procedure EditsKeyUp(Sender: TObject; var Key: Word;
                        Shift: TShiftState); virtual;
    procedure FormShow(Sender: TObject);
    procedure FormDestroy(Sender: TObject); virtual;
    procedure EditsChange(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
    refresh_enabled: boolean;

    id: integer;
    nomen_id: integer;
    code_unit: Integer;
    prm: ZVelesInfoRec;
    resulted: lpZDocrecDialogResulted;

    current_goods_row: integer;
    old_kilk, old_inprice :real;
    sql_goods_list: string;

    procedure InitInfo; virtual;
    procedure InitINS; virtual;
    procedure InitUPD; virtual;
    procedure InitControls; virtual;

    function  AnalizChanges: integer; virtual;

    procedure ApplyChanges; virtual;
    procedure ApplyControls; virtual;
    procedure ApplyINS; virtual;
    procedure ApplyUPD; virtual;

    //********* Допоміжні методи ***************************
    function ConvertEditor(ed: TdxCalcEdit): real;
    function ConvertEditorExt(ed: TdxCalcEdit): real;

    function CalcPrice: real; virtual;
    function CalcPricePDV: real; virtual;

    function CalcFromKilk: real;
    function CalcFromPricePDV: real;
    function CalcFromPrice: real;
    function CalcFromSumPDV: real;
    function CalcFromSum: real;

    function CurrentInPrice: real;
    function CurrentOldInPricePDV: real;
    function CurrentInPricePDV: real;

    // ******** Методи роботи зі списком goods-ів **********
    procedure FillGeneralInfo;
  end;

implementation

{$R *.dfm}

procedure Tfetalon_dr.InitInfo;
var rest:real;
begin
  base.SetHandle(prm.db_handle);

  master.PageAdd('Параметри', p_stage0);



{  if sql_goods_list = '' then
    sql_goods_list := 'select goods_id, goods_rest, goods_inprice, doc_date from t_goods ' +
                    ' where nomen_id = :inomen_id order by goods_id desc';
 }
  FillGeneralInfo;

{  current_goods_row := ed_goods_list.RowCount - 1;
  try
    rest := StrToFloat(ed_goods_list.Cells[1,current_goods_row])
  except
    rest := 0
  end;
  while (rest <= 0)and(current_goods_row>1) do
    current_goods_row := current_goods_row - 1;

  if (current_goods_row < 1) then
    current_goods_row := 1;

  ed_goods_list.Row := current_goods_row;
 }
{  if(trR.InTransaction) then trR.Commit;
  trR.StartTransaction;
   qR.SQL.Text := 'select typepdv_id, out_price from t_nomens where nomen_id = :inomen_id';
   qR.ParamByName('inomen_id').AsInteger := nomen_id;
   qR.ExecQuery;
   resulted.nomen.typepdv_id := qR.FieldByName('typepdv_id').AsInteger;
   resulted.nomen.out_price  := qR.FieldByName('out_price').AsCurrency;
  if(trR.InTransaction) then trR.Commit;}

  if (id <= 0) then
    InitINS
  else
    InitUPD;
  //
  if trR1.InTransaction then
    trR1.Commit;
  trR1.StartTransaction;
  q_dic.ParamByName('icode_wares').AsInteger := resulted.nomen.code_wares;
  q_dic.Open;
//  ed_code_unit.LookupKeyValue := resulted.code_unit;
  //q_dic.Locate('code_unit',resulted.nomen.code_wares, [loCaseInsensitive]);
  //q_dic.Lookup(['code_unit'],[resulted.nomen.code_wares])
  //
  InitControls;

  AutoSize := true;
  Position := poDesktopCenter;
end;

procedure Tfetalon_dr.InitINS;
begin
  old_inprice := 0;
  old_kilk := 0;
  resulted.docrec_id := 0;
  resulted.nomen.code_wares := nomen_id;
  resulted.code_unit := code_unit;
  resulted.kilk := 1;//resulted.document.default_kilk;
  resulted.price_pdv := 0.00;
  resulted.price := 0.00;

  if trR.InTransaction then trR.Commit;
  trR.StartTransaction;
  qR.SQL.Text :=
  'select w.code_wares, w.name_wares, def_ud.code_unit, def_ud.name_unit, w.vat' + #13#10 +
  'from wares w' + #13#10 +
      'left join addition_unit def_au on (w.code_wares = def_au.code_wares and def_au.default_unit = ''y'')' + #13#10 +
      'left join unit_dimension def_ud on (def_ud.code_unit = def_au.code_unit)' + #13#10 +
  'where w.code_wares = :icode_wares';
  qR.ParamByName('icode_wares').AsInteger := nomen_id;
  qR.ExecQuery;
  resulted.nomen.name_wares := qR.FieldByName('name_wares').AsString;
  resulted.vat              := qR.FieldByName('vat').AsDouble;

  if trR.InTransaction then trR.Commit;
end;

procedure Tfetalon_dr.InitUPD;
begin
  if(trR.InTransaction)then trR.Commit;
  trR.StartTransaction;
  qR.SQL.Text :=
   'select r.doc_rec_id, r.code_wares, w.name_wares, r.code_unit, r.quantity, r.price_with_vat, r.vat' + #13#10 +
    'from t_doc_recs r, wares w where doc_rec_id = :idocrec_id and r.code_wares = w.code_wares';
  qR.ParamByName('idocrec_id').AsInteger := id;
  qR.ExecQuery;
  resulted.docrec_id         := qR.FieldByName('doc_rec_id').AsInteger;
  resulted.nomen.code_wares  := qR.FieldByName('code_wares').AsInteger;
  resulted.code_unit         := qR.FieldByName('code_unit').AsInteger;
  resulted.kilk              := qR.FieldByName('quantity').AsDouble;
  resulted.price_pdv         := qR.FieldByName('price_with_vat').AsDouble;
  resulted.vat               := qR.FieldByName('vat').AsDouble;
  resulted.nomen.name_wares  := qR.FieldByName('name_wares').AsString;
  if(trR.InTransaction) then trR.Commit;
//  old_inprice := CurrentOldInPricePDV;
  old_kilk := resulted.kilk;
end;

procedure Tfetalon_dr.InitControls;
begin
  refresh_enabled := true;

  ed_name.Text      := resulted.nomen.name_wares;
  ed_kilk.Text      := FloatToStr(resulted.kilk);
  ed_price_pdv.Text := FloatToStr(resulted.price_pdv);
  ed_code_unit.LookupKeyValue := resulted.code_unit;
end;

function  Tfetalon_dr.AnalizChanges: integer;
var returned: integer;
begin
  returned := 0;

  if resulted.kilk <= 0.00 then
  begin
    GMessageBox('Кількість не перевищує нульової.', 'Закрити');
    master.PageIndex := 0;
    ed_kilk.SetFocus;
    returned := -1;
  end
  else if resulted.price_pdv <= 0.00 then
  begin
    GMessageBox('Ціна не перевищує нульової.', 'Закрити');
    master.PageIndex := 0;
    ed_price_pdv.SetFocus;
    returned := -1;
  end;

  AnalizChanges := returned;
end;

procedure Tfetalon_dr.ApplyChanges;
begin
  // Підготовка даних
  ApplyControls;

 try
  if(trW.InTransaction)then trW.Commit;
  trW.StartTransaction;
   if id <= 0 then
   begin
     ApplyINS;
   end
   else if id > 0 then
   begin
     ApplyUPD;
   end;
  if(trW.InTransaction) then trW.Commit;

 except

  on E: EIBInterbaseError do
  begin
    if trW.InTransaction then trW.Rollback;
    ShowMessage(Format('Відбувся збій: %s Повідомте розробників про помилку.', [#13 + E.Message + #13]));
    ModalResult := mrNone;
  end;
 end;

end;

procedure Tfetalon_dr.ApplyControls;
begin
  // Підготовка даних
  resulted.kilk            := StrToFloat(ed_kilk.Text);
  resulted.price_pdv       := StrToFloat(ed_price_pdv.Text);
  resulted.code_unit       := ed_code_unit.LookupKeyValue; 
end;

procedure Tfetalon_dr.ApplyINS;
begin
end;

procedure Tfetalon_dr.ApplyUPD;
begin
end;

procedure Tfetalon_dr.btn1Click(Sender: TObject);
begin
end;

//********* Допоміжні методи ***************************
function Tfetalon_dr.ConvertEditor(ed: TdxCalcEdit): real;
begin
 if ed.Text = '' then
 begin
   ed.Text := '0,00';
   if Visible then
     ed.SelectAll;
 end;

 try
   Result := StrToFloat(ed.Text);
 except
   GMessageBox('Недопустиме значення параметра.', 'Закрити');
   Result := 0.00;
 end;

 if ((Result < 0) or (Result > 10000000)) then
 begin
   GMessageBox('Значення параметра лежить за межами 0 і 10000000.', 'Закрити');
   Result := 0.00;
 end;

end;

function Tfetalon_dr.ConvertEditorExt(ed: TdxCalcEdit): real;
begin
 if ed.Text = '' then
 begin
   ed.Text := '0,00';
   if Visible then
     ed.SelectAll;
 end;

 try
   Result := StrToFloat(ed.Text);
 except
   GMessageBox('Недопустиме значення параметра.', 'Закрити');
   Result := 0.00;
 end;

 if ((Result < -10000000) or (Result > 10000000)) then
 begin
   GMessageBox('Значення параметра лежить за межами -10000000 і 10000000.', 'Закрити');
   Result := 0.00;
 end;

end;
/////////////////////////////////////////////
// тут треба робити аналіз нових типв пдв
/////////////////////////////////////////////
function Tfetalon_dr.CalcPrice: real;
begin
  Result := 0.00;
  if ((resulted.typepdv_id = 1) or (resulted.typepdv_id = 2)) then
    Result := resulted.price_pdv
  else if (resulted.typepdv_id = 3) then
    Result := resulted.price_pdv / 1.2;
  Result := 0;
end;

function Tfetalon_dr.CalcPricePDV: real;
begin
    Result := 0.00;
  if ((resulted.typepdv_id = 1) or (resulted.typepdv_id = 2)) then
    Result := resulted.price
  else if (resulted.typepdv_id = 3) then
    Result := resulted.price * 1.2;
  Result := resulted.price_pdv;
end;
/////////////////////////////////////////////
// тут треба робити аналіз нових типв пдв
/////////////////////////////////////////////
function Tfetalon_dr.CalcFromKilk: real;
begin
  if refresh_enabled then
  begin
    refresh_enabled := false;

    resulted.kilk      := ConvertEditor(ed_kilk);
    resulted.sum_pdv   := resulted.price_pdv * resulted.kilk;
    resulted.sum       := resulted.price * resulted.kilk;

    ed_sum_pdv.Text    := FloatToStr(resulted.sum_pdv);
    ed_sum.Text        := FloatToStr(resulted.sum);

    refresh_enabled := true;
  end;
  CalcFromKilk := resulted.kilk;
end;

function Tfetalon_dr.CalcFromPricePDV: real;
begin
  if refresh_enabled then
  begin
    refresh_enabled := false;

    resulted.price_pdv := ConvertEditor(ed_price_pdv);
    resulted.price     := CalcPrice;
    resulted.sum_pdv   := resulted.price_pdv * resulted.kilk;
    resulted.sum       := resulted.price * resulted.kilk;

    ed_price.Text      := FloatToStr(resulted.price);
    ed_sum_pdv.Text    := FloatToStr(resulted.sum_pdv);
    ed_sum.Text        := FloatToStr(resulted.sum);

    refresh_enabled := true;
  end;
  CalcFromPricePDV := resulted.price_pdv;
end;

function Tfetalon_dr.CalcFromPrice: real;
begin
  if refresh_enabled then
  begin
    refresh_enabled := false;

    resulted.price     := ConvertEditor(ed_price);
    resulted.price_pdv := CalcPricePDV;
    resulted.sum_pdv   := resulted.price_pdv * resulted.kilk;
    resulted.sum       := resulted.price * resulted.kilk;

    ed_price_pdv.Text  := FloatToStr(resulted.price_pdv);
    ed_sum_pdv.Text    := FloatToStr(resulted.sum_pdv);
    ed_sum.Text        := FloatToStr(resulted.sum);

    refresh_enabled := true;
  end;
  CalcFromPrice := resulted.price;
  Result := 0;
end;

function Tfetalon_dr.CalcFromSumPDV: real;
begin
  if refresh_enabled then
  begin
    refresh_enabled := false;

    resulted.sum_pdv   := ConvertEditor(ed_sum_pdv);
    if resulted.kilk <= 0 then
      resulted.price_pdv := 0.00
    else
      resulted.price_pdv := resulted.sum_pdv / resulted.kilk;

    resulted.price     := CalcPrice;
    resulted.sum       := resulted.price * resulted.kilk;

    ed_price_pdv.Text  := FloatToStr(resulted.price_pdv);
    ed_price.Text      := FloatToStr(resulted.price);
    ed_sum.Text        := FloatToStr(resulted.sum);

    refresh_enabled := true;
  end;
  CalcFromSumPDV := resulted.sum_pdv;
end;

function Tfetalon_dr.CalcFromSum: real;
begin
  if refresh_enabled then
  begin
    refresh_enabled := false;

    resulted.sum       := ConvertEditor(ed_sum);
    if resulted.kilk <= 0 then
      resulted.price     := 0.00
    else
      resulted.price     := resulted.sum / resulted.kilk;

    resulted.price_pdv   := CalcPricePDV;
    resulted.sum_pdv     := resulted.price_pdv * resulted.kilk;

    ed_price_pdv.Text  := FloatToStr(resulted.price_pdv);
    ed_price.Text      := FloatToStr(resulted.price);
    ed_sum_pdv.Text    := FloatToStr(resulted.sum_pdv);

    refresh_enabled := true;
  end;
  CalcFromSum := resulted.sum;
  Result := 0;
end;

function Tfetalon_dr.CurrentInPrice: real;
begin
  Result := 0;
{  Result := 0.00;
  if (resulted.nomen.typepdv_id in [1, 2]) then
    Result := CurrentInPricePDV
  else if (resulted.nomen.typepdv_id = 3) then
    Result := CurrentInPricePDV / 1.2;
}
end;

function Tfetalon_dr.CurrentOldInPricePDV: real;
begin
  Result := 0;
{  try
    if trR.InTransaction then trR.Commit;
    trR.StartTransaction;
    qR.SQL.Text := 'select osum_in_pdv, okilk from PS_DOCUMENT_RECORD_VIEW(:idocrec_id)';
    qR.ParamByName('idocrec_id').AsInteger := id;
    qR.ExecQuery;
    Result := qR.FieldByName('osum_in_pdv').AsCurrency / qR.FieldByName('okilk').AsCurrency;
    if trR.InTransaction then trR.Commit;
  except
    trR.Rollback;
    Result := 0.00;
  end;}
end;

function Tfetalon_dr.CurrentInPricePDV: real;
var RealKilk, SumPDV, Kilk, min, CurrentPrice, CurrentKilk: real;
    i: integer;
begin
  try
    RealKilk   := StrToFloat(ed_kilk.Text);
  except
    RealKilk   := 0;
  end;
  try
    CurrentKilk  := StrToFloat(ed_goods_list.Cells[1, current_goods_row]);
    CurrentPrice := StrToFloat(ed_goods_list.Cells[2, current_goods_row]);
  except
    Result := old_inprice;
    Exit;
  end;
  if (RealKilk = 0) then
    Result := CurrentPrice
  else  
  if ((RealKilk > old_kilk)and(old_kilk > 0))or(old_kilk = 0) then
    // к-сть збільшилась
    if ((RealKilk - old_kilk) <= CurrentKilk) then
    begin
      Result := (old_inprice*old_kilk +CurrentPrice*(RealKilk - old_kilk))/RealKilk ;
    end else
    begin //RealKilk > CurrentKilk //
      Kilk := RealKilk - old_kilk;
      Kilk := Kilk - StrToFloat(ed_goods_list.Cells[1, current_goods_row]);
      SumPDV := StrToFloat(ed_goods_list.Cells[1, current_goods_row])*StrToFloat(ed_goods_list.Cells[2, current_goods_row]);
      i := ed_goods_list.RowCount - 1;
      while (Kilk > 0)and(i > 0) do
      begin
        CurrentKilk := StrToFloat(ed_goods_list.Cells[1,i]);
        if (CurrentKilk > 0)and(i <> current_goods_row) then
        begin
          CurrentPrice := StrToFloat(ed_goods_list.Cells[2,i]);
          min := kilk;
          if min > CurrentKilk then min := CurrentKilk;
          SumPDV := SumPDV + min * CurrentPrice;
          kilk   := kilk - min;
        end;
        i:=i-1;
      end;
      if Kilk > 0 then
      begin
        CurrentPrice := StrToFloat(ed_goods_list.Cells[2,1]);
        SumPDV := SumPDV + CurrentPrice * kilk;
      end;
      Result := (SumPDV + old_inprice*(RealKilk - old_kilk))/ RealKilk;
    end
  else // not((RealKilk > old_kilk)and(old_kilk>0))or(old_kilk = 0)
  if (RealKilk = old_kilk) then // кількість не змінилась
    Result := old_inprice
  else if(RealKilk < old_kilk) then // зменшилась
    Result := old_inprice; //
end;

// ******** Методи роботи зі списком goods-ів **********
procedure Tfetalon_dr.FillGeneralInfo;
var pos: integer;
begin
  {ed_goods_list.Cells[0,0] := '№';
  ed_goods_list.Cells[1,0] := 'Залишок';
  ed_goods_list.Cells[2,0] := 'Вх. ціна';
  ed_goods_list.Cells[3,0] := 'Дата';

  if(trR.InTransaction) then trR.Commit;
  trR.StartTransaction;
   qR.SQL.Text := sql_goods_list;
   qR.ParamByName('inomen_id').AsInteger := nomen_id;
   qR.ExecQuery;
   pos := 0;
   while not qR.Eof do
   begin
     if pos > 0 then
       ed_goods_list.RowCount := pos + 2;
     pos := pos + 1;
     ed_goods_list.Cells[0, pos] := qR.FieldByName('goods_id').AsString;
     ed_goods_list.Cells[1, pos] := Format('%0.04f', [qR.FieldByName('goods_rest').AsCurrency]);
     ed_goods_list.Cells[2, pos] := Format('%0.03f', [qR.FieldByName('goods_inprice').AsCurrency]);
     ed_goods_list.Cells[3, pos] := qR.FieldByName('doc_date').AsString;
     qR.Next;
   end;
  if(trR.InTransaction) then trR.Commit;}
end;


procedure Tfetalon_dr.EditsKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if ((ssCtrl	in Shift) and (Key = 13)) then
    masterMasterResult(master, MasterResultOk);
  if (Key = VK_ESCAPE) then
    masterMasterResult(master, MasterResultCancel);
end;

procedure Tfetalon_dr.EditsKeyPress(Sender: TObject; var Key: Char);
var currWin: TWinControl;
begin
  currWin := TWinControl(Sender);

  if (Key = Char(13)) then
    master.SetFocusAtNextEdit(TControl(currWin));

  if Sender.ClassName = 'TdxCalcEdit' then
  begin
    if ((Key = '.') or (Key = ',')) then
      Key := ','
    else if (Key < '0') or (Key > '9') then
      Key := #0;
  end
end;

procedure Tfetalon_dr.EditsKeyUp(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
//
end;

procedure Tfetalon_dr.masterMasterResult(Sender: TObject;
  MasterResult: ZMasterResult);
begin
  if MasterResult = MasterResultOk then
  begin
    if AnalizChanges = 0 then
    begin
      ModalResult := mrOk;
      ApplyChanges;
    end
    else
      ModalResult := mrNone;
  end
  else if MasterResult = MasterResultCancel then
    ModalResult := mrCancel;
end;

procedure Tfetalon_dr.FormShow(Sender: TObject);
begin
  master.PageIndex := 0;
end;

procedure Tfetalon_dr.FormDestroy(Sender: TObject);
begin
//
end;

procedure Tfetalon_dr.EditsChange(Sender: TObject);
var currWin: TWinControl;
begin
  currWin := TWinControl(Sender);

  if currWin = ed_kilk then
  begin
    CalcFromKilk;
  end
  else if currWin = ed_price_pdv then
  begin
    CalcFromPricePDV;
  end
  else if currWin = ed_sum_pdv then
  begin
    CalcFromSumPDV;
  end
{  else if currWin = ed_price then
  begin
    CalcFromPrice;
  end
  else if currWin = ed_sum then
  begin
    CalcFromSum;
  end
}
end;

end.
