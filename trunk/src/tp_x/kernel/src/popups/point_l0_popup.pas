unit point_l0_popup;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, etalon_popup, dxExEdtr, Menus, dxCntner, ImgList, IBSQL,
  IBCustomDataSet, IBUpdateSQL, DB, IBQuery, IBDatabase, StdCtrls, uZbutton,
  uZFilter, dxTL, dxDBCtrl, dxDBGrid, ComCtrls, ExtCtrls, uZToolButton, ToolWin,
  uZToolBar, uZControlBar, popups_h, kernel_h;

type
  Tfpoint_l0_popup = class(Tfetalon_popup)
    q_dicOL0_POINT_ID: TIntegerField;
    q_dicONAME: TIBStringField;
    g_dicOL0_POINT_ID: TdxDBGridMaskColumn;
    g_dicONAME: TdxDBGridMaskColumn;
    procedure tool_buttonClick(Sender: TObject);
  private
    { Private declarations }
  public
    procedure InitInfo; override;
  end;

procedure L0PointPopupCreate(popup_prm: lpZPopupParams; prm: ZVelesInfoRec);
procedure L0PointPopupRefresh(popup_prm: lpZPopupParams);
procedure L0PointPopupFree(popup_prm: lpZPopupParams);

implementation

{$R *.dfm}

procedure L0PointPopupCreate(popup_prm: lpZPopupParams; prm: ZVelesInfoRec);
var fpopup: Tfpoint_l0_popup;
begin
  fpopup := Tfpoint_l0_popup.Create(nil);
  popup_prm.prew_form := fpopup;
  fpopup.popup_prm := popup_prm;
  fpopup.prm := prm;

  fpopup.InitInfo;
end;

procedure L0PointPopupRefresh(popup_prm: lpZPopupParams);
var fpopup: Tfpoint_l0_popup;
begin
  fpopup := Tfpoint_l0_popup(popup_prm.prew_form);
  fpopup.RefreshDic;
end;

procedure L0PointPopupFree(popup_prm: lpZPopupParams);
var fpopup: Tfpoint_l0_popup;
begin
  fpopup := Tfpoint_l0_popup(popup_prm.prew_form);
  fpopup.Free;
end;


procedure Tfpoint_l0_popup.InitInfo;
begin
  sql_refresh_document  := 'select ol0_point_id, oname from PS_POPUP_L0_POINT_VIEW(:idocument_id)';
  sql_fill_popup_edit := 'select name as fill_line from t_l0_points  where l0_point_id = :idocument_id ';

  dic_refresh_enabled := false;

  inherited InitInfo;

end;

procedure Tfpoint_l0_popup.tool_buttonClick(Sender: TObject);
var lpPointDialog: function (id: integer; var prm: ZVelesInfoRec): integer;
    lib_handle: THandle;
    button: ZToolButton;
    point_id: integer;
begin
  inherited tool_buttonClick(Sender);

  button := ZToolButton(Sender);

  if button = bt_ins then
  begin
    @lpPointDialog := nil;
    lib_handle := LoadLibrary('popup.dll');
    if lib_handle >= 32 then
    begin
      @lpPointDialog := GetProcAddress(lib_handle, 'L0PointDialog');
      if @lpPointDialog <> nil then
      begin
        point_id := lpPointDialog(0, prm);
        if point_id > 0 then
        begin
          q_dic.Insert;
          q_dic.FieldByName('ol0_point_id').AsInteger := point_id;
          q_dic.Post;
          RefreshRecord;
        end;
      end;
      FreeLibrary(lib_handle);
    end;
  end;
  if button = bt_upd then
  begin
    if q_dic.FieldByName('ol0_point_id').IsNull then
      exit;

    @lpPointDialog := nil;
    lib_handle := LoadLibrary('popup.dll');
    if lib_handle >= 32 then
    begin
      @lpPointDialog := GetProcAddress(lib_handle, 'L0PointDialog');
      if @lpPointDialog <> nil then
      begin
        point_id := lpPointDialog(q_dic.FieldByName('ol0_point_id').AsInteger, prm);
        if point_id > 0 then
          RefreshRecord;
      end;
      FreeLibrary(lib_handle);
    end;
  end;
end;

end.
