unit liable_popup;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, etalon_popup, dxExEdtr, dxCntner, ImgList, IBSQL, Menus,
  IBCustomDataSet, IBUpdateSQL, DB, IBQuery, IBDatabase, StdCtrls,
  uZFilter, dxTL, dxDBCtrl, dxDBGrid, ComCtrls, ToolWin, uZToolBar,
  ExtCtrls, dxEdLib, uZControlBar, kernel_h, dxEditor, tree_h, popups_h, popup_h,
  uZToolButton, uZbutton;

type
  Tfliable_popup = class(Tfetalon_popup)
    q_dicOLIABLE_ID: TIntegerField;
    q_dicOCODE: TIBStringField;
    q_dicOFULL_NAME: TIBStringField;
    g_dicOLIABLE_ID: TdxDBGridMaskColumn;
    g_dicOCODE: TdxDBGridMaskColumn;
    g_dicOFULL_NAME: TdxDBGridMaskColumn;
    procedure tool_buttonClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }

    procedure InitInfo; override;
    procedure RefreshDic; override;
  end;

procedure LiablePopupCreate(popup_prm: lpZPopupParams; prm: ZVelesInfoRec);
procedure LiablePopupRefresh(popup_prm: lpZPopupParams);
procedure LiablePopupFree(popup_prm: lpZPopupParams);

implementation

{$R *.dfm}

procedure LiablePopupCreate(popup_prm: lpZPopupParams; prm: ZVelesInfoRec);
var fpopup: Tfliable_popup;
begin
  fpopup := Tfliable_popup.Create(nil);
  popup_prm.prew_form := fpopup;
  fpopup.popup_prm := popup_prm;
  fpopup.prm := prm;

  fpopup.InitInfo;
end;

procedure LiablePopupRefresh(popup_prm: lpZPopupParams);
var fpopup: Tfliable_popup;
begin
  fpopup := Tfliable_popup(popup_prm.prew_form);
  fpopup.RefreshDic;
end;

procedure LiablePopupFree(popup_prm: lpZPopupParams);
var fpopup: Tfliable_popup;
begin
  fpopup := Tfliable_popup(popup_prm.prew_form);
  fpopup.Free;
end;

procedure Tfliable_popup.InitInfo;
begin
  sql_refresh_document  := 'select oliable_id, ocode, ofull_name from PS_POPUP_LIABLE_VIEW(:idocument_id)';
  sql_fill_popup_edit := 'select ofull_name as fill_line from PS_POPUP_LIABLE_VIEW(:idocument_id)';

  dic_refresh_enabled := false;

  inherited InitInfo;
end;

procedure Tfliable_popup.RefreshDic;
begin
  inherited RefreshDic;
end;

procedure Tfliable_popup.tool_buttonClick(Sender: TObject);
var resulted: ZLiableDialogResulted;
    lpLiableDialog: function (id: integer; resulted: lpZLiableDialogResulted; var prm: ZVelesInfoRec): integer;
    lib_handle: THandle;
    button: ZToolButton;
begin
  inherited tool_buttonClick(Sender);

  button := ZToolButton(Sender);
  if button = bt_ins then
  begin
    @lpLiableDialog := nil;
    lib_handle := LoadLibrary('popup.dll');
    if lib_handle >= 32 then
    begin
      @lpLiableDialog := GetProcAddress(lib_handle, 'LiableDialog');
      if @lpLiableDialog <> nil then
        if lpLiableDialog(0, @resulted, prm) > 0 then
        begin
          q_dic.Insert;
          q_dic.FieldByName('oliable_id').AsInteger := resulted.liable_id;
          q_dic.Post;
          RefreshRecord;
        end;
      FreeLibrary(lib_handle);
    end;
  end
  else if button = bt_upd then
  begin
    if q_dic.FieldByName('oliable_id').AsInteger <= 0 then
    begin
      ShowMessage('Не вибрано запису для редагування.');
      exit;
    end;

    @lpLiableDialog := nil;
    lib_handle := LoadLibrary('popup.dll');
    if lib_handle >= 32 then
    begin
      @lpLiableDialog := GetProcAddress(lib_handle, 'LiableDialog');
      if @lpLiableDialog <> nil then
        if lpLiableDialog(q_dic.FieldByName('oliable_id').AsInteger, @resulted, prm) > 0 then
        begin
          RefreshRecord;
        end;
      FreeLibrary(lib_handle);
    end;
  end
end;

end.
