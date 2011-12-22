unit ustep;

interface

uses ComObj, global_h, ComCtrls, Variants, SysUtils, IBDatabase, IBSQL,
     IBHeader;

type

TStepDirection = (sdTP21C=0, sd1C2TP=1);

TSyncStep=class(TObject)
public
  name: string;
  direction: TStepDirection;  // 0 - ТП-1С; 1 - 1С-ТП
  Query_TP: string; // запит для ТП
  Query_1C: string; // запит для 1С
  Query_TP_Confirm: string;
  Query_TP_Records: string;
  Query_TP_Record_Confirm: string;
  prm: lpTParametersTP1C;

  constructor Create(iprm: lpTParametersTP1C; iname:string; idirection: TStepDirection;
         iQuery_TP, iQuery_1C, iQuery_TP_Confirm, iQuery_TP_Records, iQuery_TP_Record_Confirm: string);
  destructor Destroy;

  procedure DoStep;
  function DoStepT_1C2TP: integer;
  function DoStepT_TP21C: integer;
  function DoStepDocRecords(document_ole: olevariant; tp_doc_id: integer): integer; // передача записів в документі
  procedure Confirm1CImport(iid_1c, iid: integer; iQuery_TP_Confirm: string);
end;

implementation

uses umain;

constructor TSyncStep.Create(iprm: lpTParametersTP1C; iname:string; idirection: TStepDirection;
   iQuery_TP, iQuery_1C, iQuery_TP_Confirm, iQuery_TP_Records, iQuery_TP_Record_Confirm: string);
begin
  prm := iprm;
  name := iname;
  direction := idirection;
  Query_TP := iQuery_TP;
  Query_1C := iQuery_1C;
  Query_TP_Confirm := iQuery_TP_Confirm;
  Query_TP_Records := iQuery_TP_Records;
  Query_TP_Record_Confirm := iQuery_TP_Record_Confirm;

  prm.lsteps.Add(self);
end;

destructor TSyncStep.Destroy;
begin

end;

procedure TSyncStep.DoStep;
var dataset_ole: olevariant;
    tr: TIBTransaction;
    q: TIBSQL;
    i: integer;
    oid: integer;
    records_cnt: integer;
    id_1c: integer;
begin
  if direction = sdTP21C then
    DoStepT_TP21C
  else if direction = sd1C2TP then
    DoStepT_1C2TP;
end;

procedure TSyncStep.Confirm1CImport(iid_1c, iid: integer; iQuery_TP_Confirm: string);
var tr: TIBTransaction;
    q: TIBSQL;
begin
  tr := TIBTransaction.Create(prm.App);
  q := TIBSQL.Create(prm.App);
  tr.DefaultDatabase := prm.sTP_base;
  q.Transaction := tr;
  q.Database := prm.sTP_base;
  tr.Params.Clear;
  tr.Params.Add('write');
  tr.Params.Add('concurrency');
  tr.Params.Add('nowait');

   try
    if tr.InTransaction then tr.Commit;
    tr.StartTransaction;
     q.SQL.Text := iQuery_TP_Confirm;
     q.ParamByName('iid_1c').AsInteger := iid_1c;
     q.ParamByName('iid').AsInteger := iid;
     q.ExecQuery;
    if tr.InTransaction then tr.Commit;
   except
    on E: Exception do
    begin
      flog.SaveToLog('Невдале підтвердження запису в БД ТП: ' + E.Message);
      prm.modeTP := tpmError;
      if tr.InTransaction then tr.Rollback;
    end;
   end;
end;

function TSyncStep.DoStepT_1C2TP: integer;
var dataset_ole: olevariant;
    field: olevariant;
    inp_list, q_1c: olevariant;
    tr: TIBTransaction;
    q: TIBSQL;
    i: integer;
    oid: integer;
    records_cnt: integer;
    id_1c: integer;
begin
  tr := TIBTransaction.Create(prm.App);
  q := TIBSQL.Create(prm.App);
  tr.DefaultDatabase := prm.sTP_base;
  q.Transaction := tr;
  q.Database := prm.sTP_base;
  tr.Params.Clear;

  tr.Params.Add('write');
  tr.Params.Add('concurrency');
  tr.Params.Add('nowait');

  records_cnt := 0;
  flog.SaveToLog('1C -> TP: ' + name);

  q_1c := prm.s1C82_ole.NewObject('Запрос');
  q_1c.Text := Query_1C;
  if  Pos('iknot', Query_1C) <> 0 then
    q_1c.SetParameter('iknot', prm.s1C82_knot);

  dataset_ole := q_1c.Execute().Choose();
  while dataset_ole.Next() do
  begin
   try
    if tr.InTransaction then tr.Commit;
    tr.StartTransaction;
     q.SQL.Text := Query_TP;
     for i := 0 to q.Params.Count - 1 do
       q.Params[i].Value := dataset_ole.Get(i+1);
     q.ExecQuery;
     oid := q.FieldByName('oid').AsInteger;
    // if prm.modeTP <> tplInit then
    if dataset_ole.Get(0) <> '' then
      prm.s1C82_ole.ExportToTP.DeleteFromKnot(dataset_ole);
    if tr.InTransaction then tr.Commit;
    records_cnt := records_cnt + 1;
    if ((records_cnt mod 1000) = 0) then
      flog.SaveToLog('Передано: ' + IntToStr(records_cnt) + ' записів');
   except
    on E: Exception do
    begin
      flog.SaveToLog(Query_TP);
      flog.SaveToLog('Невдала вставка в БД ТП 1C2TP: ' + E.Message);
      prm.modeTP := tpmError;
      if tr.InTransaction then tr.Rollback;
    end;
   end

    //  field := dataset_ole.Get(0);
    //  flog.SaveToLog(dataset_ole.Get(1) + '   ' + field);
  end;

  if records_cnt > 0 then
    flog.SaveToLog('Всього: ' + IntToStr(records_cnt) + ' записів');

  Result := 1;
end;

function  FillPrmArray(q: TIBSQL; var inp_list: olevariant): integer;
var i: integer;
begin
  for i := 0 to q.FieldCount - 1 do
  begin
    if q.Fields[i].SQLType = SQL_LONG then
      inp_list.Add(q.Fields[i].AsLong)
    else if q.Fields[i].SQLType = SQL_SHORT then
      inp_list.Add(q.Fields[i].AsShort)
    else if q.Fields[i].SQLType = SQL_INT64 then
      inp_list.Add(q.Fields[i].AsInt64)
    else if q.Fields[i].SQLType = SQL_TYPE_DATE then
      inp_list.Add(q.Fields[i].AsDate)
    else
      inp_list.Add(q.Fields[i].Value);
  end;
end;

function TSyncStep.DoStepT_TP21C: integer;
var dataset_ole: olevariant;
    field: olevariant;
    inp_list, q_1c: olevariant;
    knot: olevariant;
    tr: TIBTransaction;
    q: TIBSQL;
    i: integer;
    oid: integer;
    records_cnt: integer;
    id_1c: integer;
    document_ole: olevariant;
begin
  tr := TIBTransaction.Create(prm.App);
  q := TIBSQL.Create(prm.App);
  tr.DefaultDatabase := prm.sTP_base;
  q.Transaction := tr;
  q.Database := prm.sTP_base;
  tr.Params.Clear;

  tr.Params.Add('read_committed');
  tr.Params.Add('rec_version');
  tr.Params.Add('nowait');
  tr.Params.Add('read');

  records_cnt := 0;
  flog.SaveToLog('TP -> 1C: ' + name);
 try
  if tr.InTransaction then tr.Commit;
  tr.StartTransaction;
   q.SQL.Text := Query_TP;
   q.ExecQuery;
   inp_list := prm.s1C82_ole.NewObject('Массив');
   while not q.Eof do
   begin
     FillPrmArray(q, inp_list);
     
     if (Query_TP_Records <> '') then
     begin
       document_ole := prm.s1C82_ole.ImportFromTP.ImportDocHeader(inp_list, Query_1C);
       DoStepDocRecords(document_ole, q.Fields[0].AsInteger);
       document_ole.Write();
       Confirm1CImport(document_ole.Number, q.Fields[0].AsInteger, Query_TP_Record_Confirm);
       Confirm1CImport(document_ole.Number, q.Fields[0].AsInteger, Query_TP_Confirm);
     end
     else
     begin
       id_1c := prm.s1C82_ole.ImportFromTP.ImportRecord(inp_list, Query_1C);
       Confirm1CImport(id_1c, q.Fields[0].AsInteger, Query_TP_Confirm);
     end;

     records_cnt := records_cnt + 1;
     q.Next;
     inp_list.Clear();
   end;
  if tr.InTransaction then tr.Commit;
 except
  on E: Exception do
  begin
    flog.SaveToLog(Query_TP);
    flog.SaveToLog('Невдала вибірка з TP21C: ' + E.Message);
    prm.modeTP := tpmError;
    if tr.InTransaction then tr.Rollback;
  end;
 end;

  if records_cnt > 0 then
    flog.SaveToLog('Всього: ' + IntToStr(records_cnt) + ' записів');

  Result := 1;

end;

function TSyncStep.DoStepDocRecords(document_ole: olevariant; tp_doc_id: integer): integer; // передача записів документу
var dataset_ole: olevariant;
    field: olevariant;
    inp_list, q_1c: olevariant;
    knot: olevariant;
    tr: TIBTransaction;
    q: TIBSQL;
    i: integer;
    oid: integer;
    id_1c: integer;
    sql_TP: string;
begin
  tr := TIBTransaction.Create(prm.App);
  q := TIBSQL.Create(prm.App);
  tr.DefaultDatabase := prm.sTP_base;
  q.Transaction := tr;
  q.Database := prm.sTP_base;
  tr.Params.Clear;

  tr.Params.Add('read_committed');
  tr.Params.Add('rec_version');
  tr.Params.Add('nowait');
  tr.Params.Add('read');

  if tr.InTransaction then tr.Commit;
  tr.StartTransaction;
   q.SQL.Text := Query_TP_Records;
   q.ParamByName('idoc_id').AsInteger := tp_doc_id;
   q.ExecQuery;
   inp_list := prm.s1C82_ole.NewObject('Массив');
   while not q.Eof do
   begin
     FillPrmArray(q, inp_list);
     id_1c := prm.s1C82_ole.ImportFromTP.ImportDocRecord(document_ole, inp_list, Query_1C);

     q.Next;
     inp_list.Clear();
   end;
  if tr.InTransaction then tr.Commit;
  Result := document_ole.Number;
end;


end.
