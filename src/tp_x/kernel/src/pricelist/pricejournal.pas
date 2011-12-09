unit pricejournal;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ExtCtrls, dxCntner, dxTL, dxDBCtrl, dxDBGrid, dxEditor,
  dxExEdtr, dxEdLib, DB, IBDatabase, IBCustomDataSet, IBQuery, dxDBTLCl,
  dxGrClms, StdCtrls, kernel_h, ToolWin, ComCtrls, uZToolBar, uZControlBar,
  uZbutton;

type
  Tfpricejournal = class(TForm)
    dxDBGrid1: TdxDBGrid;
    Base: TIBDatabase;
    q: TIBQuery;
    tr: TIBTransaction;
    ds: TDataSource;
    dxDBGrid1ODATE_TIME: TdxDBGridDateColumn;
    dxDBGrid1OOUT_PRICE: TdxDBGridMaskColumn;
    dxDBGrid1OUSER_NAME: TdxDBGridMaskColumn;
    qODATE_TIME: TDateTimeField;
    qOOUT_PRICE: TFloatField;
    qOUSER_NAME: TIBStringField;
    qONAME: TIBStringField;
    dxDBGrid1ONAME: TdxDBGridMaskColumn;
    Panel1: TPanel;
    Date2: TdxDateEdit;
    Label2: TLabel;
    Date1: TdxDateEdit;
    Label1: TLabel;
    bt_ok: ZButton;
    procedure FormCreate(Sender: TObject);
    procedure Date1DateChange(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
    refresh_enabled: boolean;
    prm: ZVelesInfoRec;
    nomen_id: integer;
    procedure RefreshJournal;
  end;

procedure PriceJournalShow(nomen_id: integer; var prm: ZVelesInfoRec);

implementation

{$R *.dfm}

procedure PriceJournalShow(nomen_id: integer; var prm: ZVelesInfoRec);
var dlg: TfPriceJournal;
begin
  dlg := Tfpricejournal.Create(Application);
  try
    dlg.Base.SetHandle(prm.db_handle);
    dlg.nomen_id := nomen_id;
    dlg.prm := prm;
    dlg.RefreshJournal;

    dlg.ShowModal;
  finally
    if dlg <> nil then dlg.Free;
  end;  
end;

procedure Tfpricejournal.RefreshJournal;
begin
  Caption := '∆урнал зм≥ни ц≥н';
  q.Close;
  if tr.InTransaction then tr.Commit;
  tr.StartTransaction;
  q.ParamByName('d1').AsString := DateToStr(Date1.Date);
  q.ParamByName('d2').AsString := DateToStr(Date2.Date);
  q.ParamByName('nomen_id').AsInteger := nomen_id;
  q.Prepare;
  q.Open;
  tr.CommitRetaining;
end;

procedure Tfpricejournal.FormCreate(Sender: TObject);
begin
  refresh_enabled := false;
  Date1.Date := Date;
  Date2.Date := Date;
  refresh_enabled := true;
end;

procedure Tfpricejournal.Date1DateChange(Sender: TObject);
begin
  if refresh_enabled then
    RefreshJournal;
end;

end.
