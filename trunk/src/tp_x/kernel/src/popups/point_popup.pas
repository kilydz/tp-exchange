unit point_popup;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, etalon_popup, dxExEdtr, dxTL, dxDBCtrl, dxDBGrid, DB,
  IBCustomDataSet, Menus, dxCntner, ImgList, IBSQL, IBUpdateSQL, IBQuery,
  IBDatabase, StdCtrls, uZbutton, uZFilter, ComCtrls, ExtCtrls, uZToolButton,
  ToolWin, uZToolBar, uZControlBar, popups_h, kernel_h;

type
  Tfpoint_popup = class(Tfetalon_popup)
    q_dicOL3_POINT_ID: TIntegerField;
    q_dicOPOST_CODE: TIBStringField;
    q_dicOFULL_NAME: TIBStringField;
    g_dicOL3_POINT_ID: TdxDBGridMaskColumn;
    g_dicOPOST_CODE: TdxDBGridMaskColumn;
    g_dicOFULL_NAME: TdxDBGridMaskColumn;
    procedure tool_buttonClick(Sender: TObject);
  private
    { Private declarations }
  public
    procedure InitInfo; override;
  end;

procedure PointPopupCreate(popup_prm: lpZPopupParams; prm: ZVelesInfoRec);
procedure PointPopupRefresh(popup_prm: lpZPopupParams);
procedure PointPopupFree(popup_prm: lpZPopupParams);

implementation

{$R *.dfm}

procedure PointPopupCreate(popup_prm: lpZPopupParams; prm: ZVelesInfoRec);
var fpopup: Tfpoint_popup;
begin
  fpopup := Tfpoint_popup.Create(nil);
  popup_prm.prew_form := fpopup;
  fpopup.popup_prm := popup_prm;
  fpopup.prm := prm;

  fpopup.InitInfo;
end;

procedure PointPopupRefresh(popup_prm: lpZPopupParams);
var fpopup: Tfpoint_popup;
begin
  fpopup := Tfpoint_popup(popup_prm.prew_form);
  fpopup.RefreshDic;
end;

procedure PointPopupFree(popup_prm: lpZPopupParams);
var fpopup: Tfpoint_popup;
begin
  fpopup := Tfpoint_popup(popup_prm.prew_form);
  fpopup.Free;
end;


procedure Tfpoint_popup.InitInfo;
begin
  sql_refresh_document  := 'select ol3_point_id, opost_code, ofull_name from PS_POPUP_POINTS_VIEW(:idocument_id)';
  sql_fill_popup_edit := 'select post_code || '' '' || full_name as fill_line from t_l3_points  where l3_point_id = :idocument_id ';

  dic_refresh_enabled := false;

  inherited InitInfo;

end;

procedure Tfpoint_popup.tool_buttonClick(Sender: TObject);
var lpPointDialog: function (id: integer; var prm: ZVelesInfoRec): integer;
    lib_handle: THandle;
    button: ZToolButton;
    point_id: integer;
begin
  inherited tool_buttonClick(Sender);

  button := ZToolButton(Sender);

  if button = bt_upd then
  begin
    if q_dic.FieldByName('ol3_point_id').IsNull then
      exit;

    @lpPointDialog := nil;
    lib_handle := LoadLibrary('popup.dll');
    if lib_handle >= 32 then
    begin
      @lpPointDialog := GetProcAddress(lib_handle, 'PointDialog');
      if @lpPointDialog <> nil then
      begin
        point_id := lpPointDialog(q_dic.FieldByName('ol3_point_id').AsInteger, prm);
        if point_id > 0 then
          popup_prm.id := point_id;
        RefreshDic;
      end;
      FreeLibrary(lib_handle);
    end;
  end;
end;

end.
