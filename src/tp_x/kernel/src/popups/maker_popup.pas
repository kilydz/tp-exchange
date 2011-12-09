unit maker_popup;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, etalon_popup, dxExEdtr, dxCntner, ImgList, IBSQL, Menus,
  IBCustomDataSet, IBUpdateSQL, DB, IBQuery, IBDatabase, StdCtrls,
  uZFilter, dxTL, dxDBCtrl, dxDBGrid, ComCtrls, ToolWin, uZToolBar,
  ExtCtrls, dxEdLib, uZControlBar, kernel_h, dxEditor, tree_h, popups_h, popup_h,
  secure_h, uZToolButton, uZbutton;

type
  Tfmaker_popup = class(Tfetalon_popup)
    q_dicOMAKER_ID: TIntegerField;
    q_dicOMAKER_NAME: TIBStringField;
    g_dicOMAKER_ID: TdxDBGridMaskColumn;
    g_dicOMAKER_NAME: TdxDBGridMaskColumn;
    procedure tool_buttonClick(Sender: TObject);
  private
    { Private declarations }
  public
    procedure InitInfo; override;
    procedure RefreshDic; override;
  end;

procedure MakerPopupCreate(popup_prm: lpZPopupParams; prm: ZVelesInfoRec);
procedure MakerPopupRefresh(popup_prm: lpZPopupParams);
procedure MakerPopupFree(popup_prm: lpZPopupParams);

implementation

{$R *.dfm}

procedure MakerPopupCreate(popup_prm: lpZPopupParams; prm: ZVelesInfoRec);
var fpopup: Tfmaker_popup;
begin
  fpopup := Tfmaker_popup.Create(nil);
  popup_prm.prew_form := fpopup;
  fpopup.popup_prm := popup_prm;
  fpopup.prm := prm;

  fpopup.InitInfo;
end;

procedure MakerPopupRefresh(popup_prm: lpZPopupParams);
var fpopup: Tfmaker_popup;
begin
  fpopup := Tfmaker_popup(popup_prm.prew_form);
  fpopup.RefreshDic;
end;

procedure MakerPopupFree(popup_prm: lpZPopupParams);
var fpopup: Tfmaker_popup;
begin
  fpopup := Tfmaker_popup(popup_prm.prew_form);
  fpopup.Free;
end;

procedure Tfmaker_popup.InitInfo;
begin
  sql_refresh_document  := 'select omaker_id, omaker_name from PS_POPUP_MAKER_VIEW(:idocument_id)';
  sql_fill_popup_edit := 'select maker_name as fill_line from t_makers where maker_id = :idocument_id';

  dic_refresh_enabled := false;

  inherited InitInfo;
  if(GetConfig(prm.db_handle, 1, 'store_maker') = 'yes') then
  begin
    bt_ins.Visible := False;
    bt_upd.Visible := False;
    ToolButton1.Visible := False;
  end;
end;

procedure Tfmaker_popup.RefreshDic;
begin
  inherited RefreshDic;
end;

procedure Tfmaker_popup.tool_buttonClick(Sender: TObject);
var resulted: ZMakerDialogResulted;
    lpMakerDialog: function (id: integer; resulted: lpZMakerDialogResulted; var prm: ZVelesInfoRec): integer;
    lib_handle: THandle;
    button: ZToolButton;
begin
  inherited tool_buttonClick(Sender);

  button := ZToolButton(Sender);
  if button = bt_ins then
  begin
    @lpMakerDialog := nil;
    lib_handle := LoadLibrary('popup.dll');
    if lib_handle >= 32 then
    begin
      @lpMakerDialog := GetProcAddress(lib_handle, 'MakerDialog');
      if @lpMakerDialog <> nil then
        if lpMakerDialog(0, @resulted, prm) > 0 then
        begin
          q_dic.Insert;
          q_dic.FieldByName('omaker_id').AsInteger := resulted.maker_id;
          q_dic.Post;
          RefreshRecord;
        end;
      FreeLibrary(lib_handle);
    end;
  end
  else if button = bt_upd then
  begin
    if q_dic.FieldByName('omaker_id').AsInteger <= 0 then
    begin
      ShowMessage('Не вибрано запису для редагування.');
      exit;
    end;

    @lpMakerDialog := nil;
    lib_handle := LoadLibrary('popup.dll');
    if lib_handle >= 32 then
    begin
      @lpMakerDialog := GetProcAddress(lib_handle, 'MakerDialog');
      if @lpMakerDialog <> nil then
        if lpMakerDialog(q_dic.FieldByName('omaker_id').AsInteger, @resulted, prm) > 0 then
        begin
          RefreshRecord;
        end;
      FreeLibrary(lib_handle);
    end;
  end 
end;

end.
