unit price_print;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, ExtCtrls, dxExEdtr, dxEdLib, dxCntner, dxEditor, DB,
  IBCustomDataSet, IBQuery, IBDatabase, FR_DSet, FR_DBSet,
  FR_Class, Buttons, FR_E_CSV, FR_E_TXT, FR_E_HTM, FR_Shape, FR_E_RTF,
  Grids, DBGrids, kernel_h, tree_h, uZbutton;

type
  TfPriceDialog = class(TForm)
    Panel1: TPanel;
    Base: TIBDatabase;
    tr: TIBTransaction;
    q: TIBQuery;
    frReport1: TfrReport;
    frDBDataSet1: TfrDBDataSet;
    SaveDialog1: TSaveDialog;
    dsQ: TDataSource;
    CheckBox1: TCheckBox;
    CheckBox2: TCheckBox;
    qShapka: TIBQuery;
    dsQShapka: TDataSource;
    Label1: TLabel;
    ed_tree: TdxPopupEdit;
    scStyle: TdxEditStyleController;
    qRNOMEN_CODE: TIBStringField;
    qRNOMEN_NAME: TIBStringField;
    qRREST: TFloatField;
    qROUT_PRICE: TFloatField;
    qRGRP_NAME: TIBStringField;
    dxDateEdit1: TdxDateEdit;
    dxTimeEdit1: TdxTimeEdit;
    Label2: TLabel;
    bt_cancel: ZButton;
    bt_ok: ZButton;
    procedure Button1Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  //  prm: TParamPrice;
    prm: ZVelesInfoRec;
    tree_prm: TTreeParams;
    order: string;
    queries: array[0..3] of PChar;
    procedure RefreshPrice;//(pexport: integer);
    procedure InitInfo;
  end;

//function PriceList(var prm: TParamPrice): integer;

function PricesPrint(var prm: ZVelesInfoRec): integer;

implementation

{$R *.dfm}

function PricesPrint(var prm: ZVelesInfoRec): integer;
var
  dlg: TfPriceDialog;
begin
  try
    // Створення та ініціалізація форми діалогу.
    dlg := TfPriceDialog.Create(Application);

    dlg.prm := prm;
    dlg.InitInfo;

    dlg.ShowModal;
  finally
    dlg.Free;
  end;
  Result := 1;
end;

procedure ChengeBranchEv(var prm: TTreeParams);
var
  dlg: TfPriceDialog;
begin
  dlg := TfPriceDialog(prm.PrewForma);
//  dlg.resulted.grp_id := prm.ActiveNode.id;
  if prm.ActiveNode.id <= 0 then
    dlg.ed_tree.Text := 'Всі групи'
  else
    dlg.ed_tree.Text := prm.ActiveNode.name;
  dlg.ed_tree.Tag := prm.ActiveNode.id;
end;

procedure ShowHideEv(var prm: TTreeParams);
begin
end;


procedure TfPriceDialog.InitInfo;
begin
  base.SetHandle(prm.db_handle);

  if @tree_prm.OnChengeBranch = nil then
  begin
    tree_prm.sGen := prm;
    tree_prm.PrewForma := self;
    tree_prm.OnChengeBranch := @ChengeBranchEv;
    tree_prm.OnShowHide := @ShowHideEv;
    tree_prm.Visible := true;
    TreeCreate(tree_prm);
    ed_tree.PopupControl := tree_prm.Panel;
  end;
  ed_tree.Tag := -1;
  ed_tree.Text := 'Всі групи';
  dxDateEdit1.Date := Date;
  dxTimeEdit1.Time := Time;
end;

procedure TfPriceDialog.RefreshPrice;
begin
  q.Close;
  qShapka.Close;
  if tr.InTransaction then tr.Commit;

  if CheckBox2.Checked then
  begin
    {q.SQL.Text := 'select rnomen_code, rnomen_name, rrest, rout_price, rgrp_name'+
                  ' from RP_PRICE_INGRP_V1(:vgrp_id, :vdate_time, :vwith_0, :vsklad_id)';}
    frReport1.LoadFromFile(prm.root_way + 'tuning\print\prices\PriceListRests.frf');
  end
  else
  begin
    {q.SQL.Text := 'select rnomen_code, rnomen_name, rout_price, rgrp_name'+
                  ' from RP_PRICE_INGRP_V1(:vgrp_id, :vdate_time, :vwith_0, :vsklad_id)';}
    frReport1.LoadFromFile(prm.root_way + 'tuning\print\prices\PriceList.frf');
  end;

  q.ParamByName('vgrp_id').AsInteger := ed_tree.Tag;
  q.ParamByName('vdate_time').AsString := DateToStr(dxDateEdit1.Date)+' '+TimeToStr(dxTimeEdit1.Time);
  if CheckBox1.Checked then
    q.ParamByName('vwith_0').AsInteger := 1
  else
    q.ParamByName('vwith_0').AsInteger := 0;

  qShapka.ParamByName('client_id').AsInteger := 1;

  tr.StartTransaction;
  qShapka.Open;
  q.Open;
  frReport1.PrepareReport;
end;

{procedure TfPriceDialog.RefreshPrice(pexport: integer);
var date_time: string;
begin
  if tr.InTransaction then tr.Commit;
  if RadioButton1.Checked then
    q.SQL.Text := queries[1] + prm.grp_list + order
  else
  begin
    q.SQL.Text := queries[0] + prm.grp_list + order;
    date_time := DateToStr(dxDateEdit1.Date) + ' ';
    date_time := date_time + TimeToStr(dxTimeEdit1.Time);
    q.ParamByName('date_time').AsString := date_time;
  end;
  q.ParamByName('sklad_id').AsInteger := prm.sGen.sSkladID;
  if CheckBox1.Checked then
    q.ParamByName('with_0').AsInteger := 1
  else
    q.ParamByName('with_0').AsInteger := 0;
  qShapka.ParamByName('client_id').AsInteger := 1;
  tr.StartTransaction;
  qShapka.Open;
  q.Open;
  tr.CommitRetaining;

  if pexport = 0 then
  begin
    if CheckBox2.Checked then
      frReport1.LoadFromFile(prm.sGen.wReportsWay + '\PriceListRests.frf')
    else
      frReport1.LoadFromFile(prm.sGen.wReportsWay + '\PriceList.frf');
  end
  else
  begin if pexport = 1 then
      frReport1.LoadFromFile(prm.sGen.wReportsWay + '\PriceListExport.frf');
  end;
  frReport1.PrepareReport;
end;}


procedure TfPriceDialog.Button1Click(Sender: TObject);
begin
  RefreshPrice;
  frReport1.ShowReport;
  tr.Commit;
end;

end.
