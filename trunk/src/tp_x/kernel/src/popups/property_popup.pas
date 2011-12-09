unit property_popup;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, popups_h, kernel_h, etalon_popup, dxExEdtr, Menus, dxCntner, ImgList,
  IBSQL, IBCustomDataSet, IBUpdateSQL, DB, IBQuery, IBDatabase, StdCtrls,
  uZbutton, uZFilter, dxTL, dxDBCtrl, dxDBGrid, ComCtrls, ExtCtrls,
  uZToolButton, ToolWin, uZToolBar, uZControlBar;

type
  Tfproperty_popup = class(Tfetalon_popup)
    q_dicOTYPEPROP_ID: TIntegerField;
    q_dicOFULL_NAME: TIBStringField;
    g_dicOTYPEPROP_ID: TdxDBGridMaskColumn;
    g_dicOFULL_NAME: TdxDBGridMaskColumn;
    procedure tool_buttonClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
    procedure InitInfo; override;
    procedure RefreshDic; override;
  end;

procedure PropertyPopupCreate(popup_prm: lpXPopupParams; prm: XVelesInfoRec);
procedure PropertyPopupRefresh(popup_prm: lpXPopupParams);
procedure PropertyPopupFree(popup_prm: lpXPopupParams);

implementation

{$R *.dfm}

procedure PropertyPopupCreate(popup_prm: lpXPopupParams; prm: XVelesInfoRec);
var fpopup: Tfproperty_popup;
begin
  fpopup := Tfproperty_popup.Create(nil);
  popup_prm.prew_form := fpopup;
  fpopup.popup_prm := popup_prm;
  fpopup.prm := prm;

  fpopup.InitInfo;
end;

procedure PropertyPopupRefresh(popup_prm: lpXPopupParams);
var fpopup: Tfproperty_popup;
begin
  fpopup := Tfproperty_popup(popup_prm.prew_form);
  fpopup.RefreshDic;
end;

procedure PropertyPopupFree(popup_prm: lpXPopupParams);
var fpopup: Tfproperty_popup;
begin
  fpopup := Tfproperty_popup(popup_prm.prew_form);
  fpopup.Free;
end;

procedure Tfproperty_popup.InitInfo;
begin
  sql_refresh_document  := 'select otypeprop_id, ofull_name from PS_POPUP_PROPERTY_VIEW(:idocument_id)';
  sql_fill_popup_edit := 'select tp.name || '' ('' || tp.short_name || '')'' as fill_line from T_OWNER_FORMS tp where tp.typeprop_id = :idocument_id';

  dic_refresh_enabled := false;

  inherited InitInfo;
end;

procedure Tfproperty_popup.RefreshDic;
begin
  inherited RefreshDic;
end;

procedure Tfproperty_popup.tool_buttonClick(Sender: TObject);
var lpPropertyDialog: function (id: integer; var prm: XVelesInfoRec): integer;
    lib_handle: THandle;
    button: XToolButton;
    property_id: integer;
begin
  inherited tool_buttonClick(Sender);

  button := XToolButton(Sender);
  if button = bt_ins then
  begin
    @lpPropertyDialog := nil;
    lib_handle := LoadLibrary('popup.dll');
    if lib_handle >= 32 then
    begin
      @lpPropertyDialog := GetProcAddress(lib_handle, 'PropertyDialog');
      if @lpPropertyDialog <> nil then
      begin
        property_id := lpPropertyDialog(0, prm);
        if property_id > 0 then
        begin
          q_dic.Insert;
          q_dic.FieldByName('otypeprop_id').AsInteger := property_id;
          q_dic.Post;
          RefreshRecord;
        end;
      end;
      FreeLibrary(lib_handle);
    end;
  end
  else if button = bt_upd then
  begin
    if q_dic.FieldByName('otypeprop_id').AsInteger <= 0 then
    begin
      ShowMessage('Не вибрано запису для редагування.');
      exit;
    end;

    @lpPropertyDialog := nil;
    lib_handle := LoadLibrary('popup.dll');
    if lib_handle >= 32 then
    begin
      @lpPropertyDialog := GetProcAddress(lib_handle, 'PropertyDialog');
      if @lpPropertyDialog <> nil then
        if lpPropertyDialog(q_dic.FieldByName('otypeprop_id').AsInteger, prm) > 0 then
        begin
          RefreshRecord;
        end;
      FreeLibrary(lib_handle);
    end;
  end
end;

end.
