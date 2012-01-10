 unit udocument;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ComCtrls, uZMaster, ExtCtrls, StdCtrls, dxExEdtr, dxEdLib,
  dxCntner, dxEditor, dxTL, dxDBCtrl, dxDBGrid, ImgList, IBSQL, IBDatabase,
  DB, document_h, kernel_h, editors_h, popups_h, {store_h,} secure_h, DateUtils;

type
  Tfdocument = class(TForm)
    master: ZMaster;
    base: TIBDatabase;
    trR: TIBTransaction;
    qR: TIBSQL;
    trW: TIBTransaction;
    qW: TIBSQL;
    scStyle: TdxEditStyleController;
    pPages: TPageControl;
    TabSheet1: TTabSheet;
    pStage0: TPanel;
    Label1: TLabel;
    ed_number: TdxEdit;
    Label11: TLabel;
    ed_doc_date: TdxDateEdit;
    ed_EDRPOU: TdxEdit;
    Label2: TLabel;
    procedure ed_documentKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure ed_documentKeyPress(Sender: TObject; var Key: Char);
    procedure ed_documentKeyUp(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure FormDestroy(Sender: TObject);
    procedure masterMasterResult(Sender: TObject;
      MasterResult: ZMasterResult);
    procedure FormShow(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
    id      :integer;
    auth_id :integer;
    prm: ZVelesInfoRec;
    resulted: lpZDocumentDialogResulted;

    procedure InitInfo;
    function  AnalizChanges: integer;
    procedure ApplyChanges;

  end;

var
  fdocument: Tfdocument;

function DocumentDialog(id: integer; resulted: lpZDocumentDialogResulted; var prm: ZVelesInfoRec): integer;
implementation

{$R *.dfm}

function DocumentDialog(id: integer; resulted: lpZDocumentDialogResulted; var prm: ZVelesInfoRec): integer;
var
  dlg: Tfdocument;
  returned: integer;
begin
// Перевірка прав
  returned := 0;
  Result := -1;
  if not HasUserAccessEx(prm, ACCESS_TO_DOCUMENT_INS_UPD) then
    Exit;
try
// Створення та ініціалізація форми діалогу.
    Application.Handle := prm.app_handle;
    Application.CreateForm(Tfdocument, dlg);
//    dlg := Tfdocument.Create(Application);
    dlg.id := id;
    dlg.prm := prm;
    dlg.resulted := resulted;
    dlg.InitInfo;

// Візуалізація діалогу
    if (dlg.ShowModal = mrOk) then
    begin
//      resulted^ := dlg.resulted;
      DocumentEditor(lpZDocumentDialogResulted(resulted), dlg.prm);
      returned := dlg.resulted.document_id;
    end;
finally
  if dlg <> nil then dlg.Free;
end;
//    returned <= 0 - код помилки, або відмова;
//    returned > 0  - id результату;
  Result := returned;
end;

procedure Tfdocument.InitInfo;
begin
  base.SetHandle(prm.db_handle);

  // Ініціалізація майстра
  master.PageAdd('Основні', pStage0);

  // Ініціалізація списків

  // Ініціалізація структури даних
  if (id <= 0) then  //    id <= 0 - створити новий запис;
  begin
    Caption := 'Процедура створення документа.';
    resulted.document_id  := 0;
    resulted.doc_date     := DateToStr(Date);
    resulted.edrpou       := '';
    resulted.doc_num      := '';
    //  генерується номер документа
  end
  else if (id >0) then  //    id > 0  - редагувати запис з даним id;
  begin
    Caption := 'Процедура редагування документа.';
    if(trR.InTransaction)then trR.Commit;
    trR.StartTransaction;
    qR.SQL.Text := 'select DOC_ID, DOC_NUM, EDRPOU, DOC_DATE '+
       ' from T_DOCS where doc_id = :idocument_id';
    qR.ParamByName('idocument_id').AsInteger := id;
    qR.ExecQuery;
    resulted.document_id  := qR.FieldByName('doc_id').AsInteger;
    resulted.doc_date     := qR.FieldByName('doc_date').AsString;
    resulted.edrpou       := qR.FieldByName('EDRPOU').AsString;
    resulted.doc_num      := qR.FieldByName('DOC_NUM').AsString;
    if(trR.InTransaction) then trR.Commit;
  end;
  ed_number.Text     := resulted.doc_num;
  ed_EDRPOU.Text     := resulted.edrpou;
  ed_doc_date.Text   := resulted.doc_date;

  Autosize := true;
  Position := poDesktopCenter;
end;

function Tfdocument.AnalizChanges: integer;
var returned, DaysCount1: integer;
begin
  Result := 0;

  if Trim(ed_number.Text) = '' then
  begin
    ShowMessage('Не визначено №.');
    master.PageIndex := 0;
    ed_number.SetFocus;
    Result := -1;
  end
  else if Trim(ed_EDRPOU.Text) = '' then
  begin
    ShowMessage('Не визначено Код ЄДРПОУ');
    master.PageIndex := 0;
    ed_EDRPOU.SetFocus;
    Result := -1;
  end
  else if Trim(ed_doc_date.Text) = '' then
  begin
    ShowMessage('Не визначено Дату');
    master.PageIndex := 0;
    ed_doc_date.SetFocus;
    Result := -1;
  end;
end;

procedure Tfdocument.ApplyChanges;
begin
  // Підготовка даних
  resulted.doc_date     := ed_doc_date.Text;
  resulted.edrpou       := ed_EDRPOU.Text;
  resulted.doc_num      := ed_number.Text;

  if(trW.InTransaction)then trW.Commit;
  trW.StartTransaction;
   if id <= 0 then
   begin
     qW.SQL.Text := 'select ODOC_ID '+
      ' from PTP_DOC_INS(:DOC_NUM, :EDRPOU, :DOC_DATE)';

     qW.ParamByName('doc_date').AsString      := resulted.doc_date;
     qW.ParamByName('DOC_NUM').AsString       := resulted.doc_num;
     qW.ParamByName('EDRPOU').AsString        := resulted.edrpou;
     qW.ExecQuery;
     resulted.document_id := qW.FieldByName('odoc_id').AsInteger;
   end
   else if id > 0 then
   begin
     qW.SQL.Text := 'update t_docs' + #13#10 +
        'set doc_num = :doc_num,' + #13#10 +
            'edrpou = :edrpou,' + #13#10 +
            'doc_date = :doc_date' + #13#10 +
            'where (doc_id = :doc_id)   ';

     qW.ParamByName('doc_id').AsInteger     := resulted.document_id;
     qW.ParamByName('doc_date').AsString      := resulted.doc_date;
     qW.ParamByName('DOC_NUM').AsString       := resulted.doc_num;
     qW.ParamByName('EDRPOU').AsString        := resulted.edrpou;
     qW.ExecQuery;
   end;
  if (trW.InTransaction) then trW.Commit;

  //EDRPOU
  if(trR.InTransaction)then trR.Commit;
  trR.StartTransaction;
  qR.SQL.Text := 'select first (1) f.name from firms f where f.code_zip = :icode_zip';
  qR.ParamByName('icode_zip').AsString := resulted.edrpou;
  qR.ExecQuery;
  if qR.RecordCount > 0 then
    resulted.name_firm := qR.FieldByName('name').AsString
  else
    resulted.name_firm := '';
  if (trR.InTransaction) then trR.Commit;

end;

procedure Tfdocument.FormShow(Sender: TObject);
begin
  master.PageIndex := 0;
end;

procedure Tfdocument.ed_documentKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
//
end;

procedure Tfdocument.ed_documentKeyPress(Sender: TObject; var Key: Char);
var currWin: TWinControl;
begin
  currWin := TWinControl(Sender);

  if (Key = Char(13)) then
    master.SetFocusAtNextEdit(TControl(currWin));

  if (currWin = ed_EDRPOU) then
  begin
    if ((Key = '.') or (Key = ',')) then
      Key := ','
    else if (Key < '0') or (Key > '9') then
      Key := #0;
  end
end;

procedure Tfdocument.ed_documentKeyUp(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
//
end;

procedure Tfdocument.FormDestroy(Sender: TObject);
begin
  //LiablePopupFree(@liable_popup_prm);
end;

procedure Tfdocument.masterMasterResult(Sender: TObject;
  MasterResult: ZMasterResult);
begin
  if MasterResult = MasterResultOk then
  begin
    if AnalizChanges = 0 then
    begin
      ApplyChanges;
      ModalResult := mrOk;
    end
    else
      ModalResult := mrNone;
  end
  else if MasterResult = MasterResultCancel then
    ModalResult := mrCancel;
end;

end.
