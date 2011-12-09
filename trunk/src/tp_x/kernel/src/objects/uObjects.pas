unit uObjects;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, kernel_h, utils_h, dxExEdtr, dxTL, dxDBCtrl, dxDBGrid, DB, IBCustomDataSet,
  IBQuery, IBDatabase, StdCtrls, dxCntner, ComCtrls, IniFiles, Menus;

type
  TForm1 = class(TForm)
    dxDBGrid1: TdxDBGrid;
    Button1: TButton;
    Button2: TButton;
    IBDatabase1: TIBDatabase;
    IBTransaction1: TIBTransaction;
    IBQuery1: TIBQuery;
    DataSource1: TDataSource;
    PopupMenu1: TPopupMenu;
    miRights: TMenuItem;
    IBQuery1OID: TIntegerField;
    IBQuery1ONAME: TIBStringField;
    dxDBGrid1OID: TdxDBGridMaskColumn;
    dxDBGrid1ONAME: TdxDBGridMaskColumn;
    procedure FormShow(Sender: TObject);
    procedure Button1Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure miRightsClick(Sender: TObject);
  private
    { Private declarations }
    object_id: integer;
  public
    { Public declarations }
    prm: ZVelesInfoRec;
  end;

var
  Form1: TForm1;
  iniFile: TIniFile;

function DialogObjects(var prm: ZVelesInfoRec): Longint; stdcall;
function ObjectSetLast(var prm: ZVelesInfoRec): boolean;


implementation

uses uDM;//, datarights_h;

{$R *.dfm}

function DialogObjects(var prm: ZVelesInfoRec): Longint;
var
  mm: ZModuleManager;
  i, j: integer;
begin
  Result := -1;

  iniFile := TIniFile.Create(ini_files_path + KERNEL_INI_FILE_NAME);
  try
    Form1 := TForm1.Create(nil);
    Form1.prm := prm;
    Form1.IBDatabase1.SetHandle(prm.db_handle);
    Form1.object_id := code_dealer;

    Result := Form1.ShowModal;

    if Result = mrOk then
    begin
      code_dealer := Form1.IBQuery1.FieldByName('oid').AsInteger;

      TStatusBar(prm.control_pointers.status_bar_ptr).Panels[1].Text :=
        'Магазин: ' + Form1.IBQuery1.FieldByName('oname').AsString;

      if prm.control_pointers.module_manager <> nil then
      begin
        mm := ZModuleManager(prm.control_pointers.module_manager);
        for i := 0 to mm.ModuleCount - 1 do
          for j := 0 to mm.Modules[i].PageCount - 1 do
            if (mm.Modules[i].Pages[j].page_form <> nil) then
              SendMessage(mm.Modules[i].Pages[j].page_form.Handle, UM_REFRESH_DIC, 0, 0);
      end;

      iniFile.WriteInteger('Object', 'Active', code_dealer);
    end;

  finally
    Form1.Free;
  end;
  iniFile.Free;
end;

function ObjectSetLast(var prm: ZVelesInfoRec): boolean;
var
  objectName: string;
  objectId, new_objectId: integer;
begin
  Result := false;

  iniFile := TIniFile.Create(ini_files_path + KERNEL_INI_FILE_NAME);
  try
    ObjectId := iniFile.ReadInteger('Object', 'Active', -1);
    iniFile.Free;
//    if ObjectId = -1 then exit
//    else
    code_dealer := objectId;

    DM := TDataModule1.Create(nil);
    DM.IBDatabase1.SetHandle(prm.db_handle);
//    DM.IBSQL1.SQL.Text := 'select objects_name from objects where objects_id = :iobject_id';
    DM.IBSQL1.SQL.Text := 'select CODE_DEALER as OID, NAME_DEALER as ONAME from DEALER where CODE_DEALER = :iobject_id';
    if DM.IBTransaction1.InTransaction then DM.IBTransaction1.Commit;
    DM.IBTransaction1.StartTransaction;
    DM.IBSQL1.ParamByName('iobject_id').AsInteger := code_dealer;
    DM.IBSQL1.ExecQuery;
    objectName := DM.IBSQL1.FieldByName('oname').AsString;
    new_objectId := DM.IBSQL1.FieldByName('oid').AsInteger;
    DM.IBTransaction1.Commit;

    if new_objectId = 0 then
    begin
      if DialogObjects(prm)<> mrOk then Application.Terminate;
    end
    else
      TStatusBar(prm.control_pointers.status_bar_ptr).Panels[1].Text :=
                    'Магазин: ' + objectName;

    DM.IBDatabase1.SetHandle(nil);
  finally
    Result := true;
  end;
  DM.Free;
//  iniFile.Free;
end;

procedure TForm1.Button1Click(Sender: TObject);
begin
  ModalResult := mrOk;
end;

procedure TForm1.Button2Click(Sender: TObject);
begin
  ModalResult := mrCancel;
end;

procedure TForm1.FormShow(Sender: TObject);
begin
 //
 if IBTransaction1.InTransaction then IBTransaction1.Commit;
 IBTransaction1.StartTransaction;
 IBQuery1.Open;
 IBTransaction1.CommitRetaining;

  if object_id > 0 then
    IBQuery1.Locate(dxDBGrid1.KeyField, object_id, []);
end;

procedure TForm1.miRightsClick(Sender: TObject);
begin
{  DialogDataRights(prm, TBL_OBJECT_R, Form1.IBQuery1.FieldByName('oid').AsInteger,
  true, Form1.IBQuery1.FieldByName('oname').AsString);}
end;

//initialization

//iniFile := TIniFile.Create(ini_files_path + KERNEL_INI_FILE_NAME);

//finalization

//iniFile.Free;

end.
