unit discount_popup;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, etalon_popup, dxExEdtr, Menus, dxCntner, ImgList, IBSQL,
  IBCustomDataSet, IBUpdateSQL, DB, IBQuery, IBDatabase, StdCtrls, uZFilter,
  dxTL, dxDBCtrl, dxDBGrid, ComCtrls, ToolWin, uZToolBar, ExtCtrls, uZControlBar,
  kernel_h, tree_h, popup_h, popups_h, uZToolButton, uZbutton;

type
  Tfdiscount_popup = class(Tfetalon_popup)
    q_dicODISCOUNT_ID: TIntegerField;
    q_dicOPROCENT: TFloatField;
    q_dicOSUMMA: TIntegerField;
    g_dicOPROCENT: TdxDBGridMaskColumn;
    g_dicOSUMMA: TdxDBGridMaskColumn;
 procedure tool_buttonClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }

    procedure InitInfo; override;
    procedure RefreshDic; override;
  end;

procedure DiscountPopupCreate(popup_prm: lpZPopupParams; prm: ZVelesInfoRec);
procedure DiscountPopupRefresh(popup_prm: lpZPopupParams);
procedure DiscountPopupFree(popup_prm: lpZPopupParams);

implementation

{$R *.dfm}

procedure DiscountPopupCreate(popup_prm: lpZPopupParams; prm: ZVelesInfoRec);
var fpopup: Tfdiscount_popup;
begin
  fpopup := Tfdiscount_popup.Create(nil);
  popup_prm.prew_form := fpopup;
  fpopup.popup_prm := popup_prm;
  fpopup.prm := prm;

  fpopup.InitInfo;
end;

procedure DiscountPopupRefresh(popup_prm: lpZPopupParams);
var fpopup: Tfdiscount_popup;
begin
  fpopup := Tfdiscount_popup(popup_prm.prew_form);
  fpopup.RefreshDic;
end;

procedure DiscountPopupFree(popup_prm: lpZPopupParams);
var fpopup: Tfdiscount_popup;
begin
  fpopup := Tfdiscount_popup(popup_prm.prew_form);
  fpopup.Free;
end;

procedure Tfdiscount_popup.InitInfo;
begin
  sql_refresh_document  := 'select odiscount_id, oprocent, osumma from PS_POPUP_DISCOUNT(:idocument_id)';
  sql_fill_popup_edit   := 'select cast ( cast (d.procent as numeric(10,3)) as varchar(12)) || '' %'' as fill_line from T_DISCOUNTS d where d.discont_id = :idocument_id';

  dic_refresh_enabled := false;

  inherited InitInfo;
end;

procedure Tfdiscount_popup.RefreshDic;
begin
  inherited RefreshDic;
end;

procedure Tfdiscount_popup.tool_buttonClick(Sender: TObject);
var lpDiscountDialog: function (id: integer; var prm: ZVelesInfoRec): integer;
    lib_handle: THandle;
    button: ZToolButton;
    discount_id: integer;
begin
  inherited tool_buttonClick(Sender);

  button := ZToolButton(Sender);
  if button = bt_ins then
  begin
    @lpDiscountDialog := nil;
    lib_handle := LoadLibrary('popup.dll');
    if lib_handle >= 32 then
    begin
      @lpDiscountDialog := GetProcAddress(lib_handle, 'DiscountDialog');
      if @lpDiscountDialog <> nil then
      begin
        discount_id := lpDiscountDialog(0, prm);
        if discount_id > 0 then
        begin
          q_dic.Insert;
          q_dic.FieldByName('odiscount_id').AsInteger := discount_id;
          q_dic.Post;
          RefreshRecord;
        end;
      end;
      FreeLibrary(lib_handle);
    end;
  end
  else if button = bt_upd then
  begin
    if q_dic.FieldByName('odiscount_id').AsInteger <= 0 then
    begin
      ShowMessage('Не вибрано запису для редагування.');
      exit;
    end;

    @lpDiscountDialog := nil;
    lib_handle := LoadLibrary('popup.dll');
    if lib_handle >= 32 then
    begin
      @lpDiscountDialog := GetProcAddress(lib_handle, 'DiscountDialog');
      if @lpDiscountDialog <> nil then
      begin
        if lpDiscountDialog(q_dic.FieldByName('odiscount_id').AsInteger, prm) > 0 then
        begin
          RefreshRecord;
        end;
      end;
      FreeLibrary(lib_handle);
    end;
  end 
end;

end.
