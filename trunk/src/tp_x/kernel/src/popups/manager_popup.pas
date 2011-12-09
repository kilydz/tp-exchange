unit manager_popup;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, popups_h, popup_h, kernel_h, etalon_popup, dxExEdtr, Menus, dxCntner,
  ImgList, IBSQL, IBCustomDataSet, IBUpdateSQL, DB, IBQuery, IBDatabase,
  StdCtrls, uZbutton, uZFilter, dxTL, dxDBCtrl, dxDBGrid, ComCtrls, ExtCtrls,
  uZToolButton, ToolWin, uZToolBar, uZControlBar;

type
  Tfmanager_popup = class(Tfetalon_popup)
    q_dicMANAGER_ID: TIntegerField;
    q_dicMANAGER_NAME: TIBStringField;
    g_dicMANAGER_ID: TdxDBGridMaskColumn;
    g_dicMANAGER_NAME: TdxDBGridMaskColumn;
    procedure tool_buttonClick(Sender: TObject);
  private
    { Private declarations }
  public
    procedure InitInfo; override;
    procedure RefreshDic; override;
  end;

procedure ManagerPopupCreate(popup_prm: lpZPopupParams; prm: ZVelesInfoRec);
procedure ManagerPopupRefresh(popup_prm: lpZPopupParams);
procedure ManagerPopupFree(popup_prm: lpZPopupParams);

implementation

{$R *.dfm}

procedure ManagerPopupCreate(popup_prm: lpZPopupParams; prm: ZVelesInfoRec);
var fpopup: Tfmanager_popup;
begin
  fpopup := Tfmanager_popup.Create(nil);
  popup_prm.prew_form := fpopup;
  fpopup.popup_prm := popup_prm;
  fpopup.prm := prm;

  fpopup.InitInfo;
end;

procedure ManagerPopupRefresh(popup_prm: lpZPopupParams);
var fpopup: Tfmanager_popup;
begin
  fpopup := Tfmanager_popup(popup_prm.prew_form);
  fpopup.RefreshDic;
end;

procedure ManagerPopupFree(popup_prm: lpZPopupParams);
var fpopup: Tfmanager_popup;
begin
  fpopup := Tfmanager_popup(popup_prm.prew_form);
  fpopup.Free;
end;

procedure Tfmanager_popup.InitInfo;
begin
  sql_refresh_document  := 'select manager_id, manager_name  from t_managers where manager_id = :idocument_id';
  sql_fill_popup_edit := 'select manager_name as fill_line from t_managers where manager_id = :idocument_id';

  dic_refresh_enabled := false;

  inherited InitInfo;
end;

procedure Tfmanager_popup.RefreshDic;
begin
  inherited RefreshDic;
end;

procedure Tfmanager_popup.tool_buttonClick(Sender: TObject);
var lpManagerDialog: function (var id: ZFuncArgs; var prm: ZVelesInfoRec): integer;
    lib_handle: THandle;
    button: ZToolButton;
    manager_id: integer;
    arg: ZFuncArgs;
begin
  inherited tool_buttonClick(Sender);

  button := ZToolButton(Sender);
  if button = bt_ins then
  begin
    @lpManagerDialog := nil;
    lib_handle := LoadLibrary('popup.dll');
    if lib_handle >= 32 then
    begin
      @lpManagerDialog := GetProcAddress(lib_handle, 'ManagerDialog');
      if @lpManagerDialog <> nil then
      begin
        arg.id := 0;
        manager_id := lpManagerDialog(arg, prm);
        if manager_id > 0 then
        begin
          q_dic.Insert;
          q_dic.FieldByName('manager_id').AsInteger := manager_id;
          q_dic.Post;
          RefreshRecord;
        end;
      end;
      FreeLibrary(lib_handle);
    end;
  end
  else if button = bt_upd then
  begin
    if q_dic.FieldByName('manager_id').IsNull then
    begin
      ShowMessage('Не вибрано запису для редагування.');
      exit;
    end;

    @lpManagerDialog := nil;
    lib_handle := LoadLibrary('popup.dll');
    if lib_handle >= 32 then
    begin
      @lpManagerDialog := GetProcAddress(lib_handle, 'ManagerDialog');
      if @lpManagerDialog <> nil then
      begin
        arg.id := q_dic.FieldByName('manager_id').AsInteger;
        if lpManagerDialog(arg, prm) > 0 then
        begin
          RefreshRecord;
        end;
      end;
      FreeLibrary(lib_handle);
    end;
  end
end;


end.
