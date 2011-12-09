unit discount;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ComCtrls, uZMaster, ExtCtrls, StdCtrls, dxExEdtr, dxEdLib,
  dxCntner, dxEditor, dxTL, dxDBCtrl, dxDBGrid, ImgList, IBSQL, IBDatabase,
  DB, IB,
  kernel_h, editors_h, popup_h, etalon_dlg;

type
  ZLiableDialogResulted = record
     discont_id: integer;
     procent: real;
     summa: real;
   end;
lpZLiableDialogResulted = ^ZLiableDialogResulted;

  Tfdiscount = class(Tfetalon_dlg)
    ImageList1: TImageList;
    TabSheet1: TTabSheet;
    pStage0: TPanel;
    Label2: TLabel;
    Label1: TLabel;
    ed_procent: TdxCalcEdit;
    ed_summa: TdxCalcEdit;
    procedure FormDestroy(Sender: TObject); override;
  private
    { Private declarations }
  public
    { Public declarations }
    resulted: ZLiableDialogResulted;

    procedure InitINS; override;
    procedure InitUPD; override;
    procedure InitControls; override;

    function  AnalizChanges: integer; override;
    procedure ApplyChanges; override;
    procedure ApplyControls; override;
    procedure ApplyINS; override;
    procedure ApplyUPD; override;
  end;

function DiscountDialog(id: integer; var prm: ZVelesInfoRec): integer;
implementation

{$R *.dfm}

function DiscountDialog(id: integer; var prm: ZVelesInfoRec): integer;
var
  dlg: Tfdiscount;
  returned: integer;
begin
// Перевірка прав
  returned := 0;
try
// Створення та ініціалізація форми діалогу.
    dlg := Tfdiscount.Create(Application);
    dlg.id.id := id;
    dlg.prm := prm;
    dlg.InitInfo;

// Візуалізація діалогу
    if (dlg.ShowModal = mrOk) then
    begin
      returned := dlg.resulted.discont_id;
    end;
finally
  if dlg <> nil then dlg.Free;
end;
//    returned <= 0 - код помилки, або відмова;
//    returned > 0  - id результату;
  Result := returned;
end;

procedure Tfdiscount.InitINS;
begin
  Caption := 'Процедура створення дисконту.';
  resulted.discont_id := 0;
  resulted.procent := 0;
  resulted.summa := 0;
end;

procedure Tfdiscount.InitUPD;
begin
  Caption := 'Процедура редагування дисконту.';
  if(trR.InTransaction)then trR.Commit;
  trR.StartTransaction;
   qR.SQL.Text := 'select d.discont_id, d.procent, d.summa from T_DISCOUNTS d where d.discont_id = :iid';
   qR.ParamByName('iid').AsInteger := id.id;
   qR.ExecQuery;
   resulted.discont_id          := qR.FieldByName('discont_id').AsInteger;
   resulted.procent             := qR.FieldByName('procent').AsFloat;
   resulted.summa             := qR.FieldByName('summa').AsFloat;
  if(trR.InTransaction) then trR.Commit;

  ed_procent.Enabled := false;
end;

procedure Tfdiscount.InitControls;
begin
  ed_procent.Text           := FloatToStr(resulted.procent);
  ed_summa.Text             := FloatToStr(resulted.summa);
end;

function Tfdiscount.AnalizChanges: integer;
var returned: integer;
begin
  returned := 0;

 try
    if trR.InTransaction then trR.Commit;
    trR.StartTransaction;
     qR.SQL.Text := 'select count(discont_id) as ocnt from T_DISCOUNTS '+
                       ' where procent=:iprocent and discont_id<>:idiscont_id';
     qR.ParamByName('idiscont_id').AsInteger  := resulted.discont_id;
     qR.ParamByName('iprocent').AsFloat       := StrToFloat(ed_procent.Text);
     qR.ExecQuery;
     if qR.FieldByName('ocnt').AsInteger > 0 then
     begin
       ShowMessage('Такий відсоток вже існує.');
       master.PageIndex := 0;
       ed_procent.SetFocus;
       returned := -1;
     end;
    if trR.InTransaction then trR.Commit;
 except
  ShowMessage('Не вірний відсоток знижки.');
  master.PageIndex := 0;
  ed_procent.SetFocus;
  returned := -1;
 end;

  AnalizChanges := returned;
end;

procedure Tfdiscount.ApplyChanges;
begin
  inherited ApplyChanges;
end;

procedure Tfdiscount.ApplyControls;
begin
  resulted.procent        := StrToFloat(ed_procent.Text);
  resulted.summa          := StrToFloat(ed_summa.Text);
end;

procedure Tfdiscount.ApplyINS;
var new_id: integer;
begin
  new_id := GetNextID('GEN_DISCONT_ID');

  qW.SQL.Text := 'insert into T_DISCOUNTS (discont_id, procent, summa) ' +
          ' values (:idiscont_id, :iprocent, :isumma)';
  qW.ParamByName('idiscont_id').AsInteger     := new_id;
  qW.ParamByName('iprocent').AsFloat          := resulted.procent;
  qW.ParamByName('isumma').AsFloat            := resulted.summa;
  qW.ExecQuery;
  resulted.discont_id := new_id;
end;

procedure Tfdiscount.ApplyUPD;
begin
  qW.SQL.Text := 'update T_DISCOUNTS set ' +
                     ' procent = :iprocent, ' +
                     ' summa = :isumma ' +
                 ' where discont_id = :idiscont_id ';
  qW.ParamByName('idiscont_id').AsInteger   := resulted.discont_id;
  qW.ParamByName('iprocent').AsFloat        := resulted.procent;
  qW.ParamByName('isumma').AsFloat          := resulted.summa;
  qW.ExecQuery;
end;

procedure Tfdiscount.FormDestroy(Sender: TObject);
begin
  inherited FormDestroy(Sender);
end;

end.
