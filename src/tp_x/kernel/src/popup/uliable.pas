unit uliable;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ComCtrls, uZMaster, ExtCtrls, StdCtrls, dxExEdtr, dxEdLib,
  dxCntner, dxEditor, dxTL, dxDBCtrl, dxDBGrid, ImgList, IBSQL, IBDatabase,
  DB, IB,
  kernel_h, editors_h, popup_h, etalon_dlg;

type
  Tfliable = class(Tfetalon_dlg)
    ImageList1: TImageList;
    TabSheet1: TTabSheet;
    pStage0: TPanel;
    Label2: TLabel;
    ed_surname: TdxEdit;
    Label1: TLabel;
    ed_name: TdxEdit;
    Label3: TLabel;
    Label4: TLabel;
    ed_patronymic: TdxEdit;
    ed_is_responsible: TCheckBox;
    procedure FormDestroy(Sender: TObject); override;
  private
    { Private declarations }
  public
    { Public declarations }
    resulted: lpZLiableDialogResulted;

    procedure InitINS; override;
    procedure InitUPD; override;
    procedure InitControls; override;

    function  AnalizChanges: integer; override;
    procedure ApplyChanges; override;
    procedure ApplyControls; override;
    procedure ApplyINS; override;
    procedure ApplyUPD; override;
  end;

function LiableDialog(id: integer; resulted: lpZLiableDialogResulted; var prm: ZVelesInfoRec): integer;
implementation

{$R *.dfm}

function LiableDialog(id: integer; resulted: lpZLiableDialogResulted; var prm: ZVelesInfoRec): integer;
var
  dlg: Tfliable;
  returned: integer;
begin
// Перевірка прав
  returned := 0;
try
// Створення та ініціалізація форми діалогу.
    dlg := Tfliable.Create(Application);
    dlg.id.id := id;
    dlg.prm := prm;
    dlg.resulted := resulted;
    dlg.InitInfo;

// Візуалізація діалогу
    if (dlg.ShowModal = mrOk) then
    begin
      returned := dlg.resulted.liable_id;
    end;
finally
  if dlg <> nil then dlg.Free;
end;
//    returned <= 0 - код помилки, або відмова;
//    returned > 0  - id результату;
  Result := returned;
end;

procedure Tfliable.InitINS;
begin
  Caption := 'Процедура створення відповідального.';
  resulted.liable_id := 0;
  resulted.surname := '';
  resulted.name := '';
  resulted.patronymic := '';
  resulted.is_responsible := 0;
end;

procedure Tfliable.InitUPD;
begin
  Caption := 'Процедура редагування відповідального.';
  if(trR.InTransaction)then trR.Commit;
  trR.StartTransaction;
   qR.SQL.Text := 'select staff_id, surname, name, patronymic, responsible ' +
                           ' from T_LIABLES where staff_id = :istaff_id';
   qR.ParamByName('istaff_id').AsInteger := id.id;
   qR.ExecQuery;
   resulted.liable_id           := qR.FieldByName('staff_id').AsInteger;
   resulted.surname             := qR.FieldByName('surname').AsString;
   resulted.name                := qR.FieldByName('name').AsString;
   resulted.patronymic          := qR.FieldByName('patronymic').AsString;
   resulted.is_responsible      := qR.FieldByName('responsible').AsInteger;
  if(trR.InTransaction) then trR.Commit;
end;

procedure Tfliable.InitControls;
begin
  ed_surname.Text           := resulted.surname;
  ed_name.Text              := resulted.name;
  ed_patronymic.Text        := resulted.patronymic;
  ed_is_responsible.Checked := (resulted.is_responsible <> 0);
end;

function Tfliable.AnalizChanges: integer;
var returned: integer;
begin
  returned := 0;

  if(ed_surname.Text = '')then
  begin
    ShowMessage('Не вказано прізвища.');
    master.PageIndex := 0;
    ed_surname.SetFocus;
    returned := -1;
  end;

  AnalizChanges := returned;
end;

procedure Tfliable.ApplyChanges;
begin
  inherited ApplyChanges;
end;

procedure Tfliable.ApplyControls;
begin
  resulted.surname        := ed_surname.Text;
  resulted.name           := ed_name.Text;
  resulted.patronymic     := ed_patronymic.Text;
  if ed_is_responsible.Checked then
    resulted.is_responsible := 1
  else
    resulted.is_responsible := 0;
end;

procedure Tfliable.ApplyINS;
begin
  qW.SQL.Text := 'select oliable_id from PS_LIABLE_INS(:isurname, :iname, :ipatronymic, :iis_responsible)';
  qW.ParamByName('isurname').AsString         := resulted.surname;
  qW.ParamByName('iname').AsString            := resulted.name;
  qW.ParamByName('ipatronymic').AsString      := resulted.patronymic;
  qW.ParamByName('iis_responsible').AsInteger := resulted.is_responsible;
  qW.ExecQuery;
  resulted.liable_id := qW.FieldByName('oliable_id').AsInteger;
end;

procedure Tfliable.ApplyUPD;
begin
  qW.SQL.Text := 'update T_LIABLES set ' +
                     ' surname = :isurname, ' +
                     ' name = :iname, ' +
                     ' patronymic = :ipatronymic, ' +
                     ' responsible = :iis_responsible ' +
                 ' where staff_id = :iliable_id ';
  qW.ParamByName('iliable_id').AsInteger   := resulted.liable_id;
  qW.ParamByName('isurname').AsString         := resulted.surname;
  qW.ParamByName('iname').AsString            := resulted.name;
  qW.ParamByName('ipatronymic').AsString      := resulted.patronymic;
  qW.ParamByName('iis_responsible').AsInteger := resulted.is_responsible;
  qW.ExecQuery;
end;

procedure Tfliable.FormDestroy(Sender: TObject);
begin
  inherited FormDestroy(Sender);
end;

end.
