unit bank_popup;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, etalon_popup, dxExEdtr, Menus, dxCntner, ImgList, IBSQL,
  IBCustomDataSet, IBUpdateSQL, DB, IBQuery, IBDatabase, StdCtrls, uZbutton,
  uZFilter, dxTL, dxDBCtrl, dxDBGrid, ComCtrls, ExtCtrls, uZToolButton, ToolWin,
  uZToolBar, uZControlBar, popups_h, kernel_h;

type
  Tfbank_popup = class(Tfetalon_popup)
    q_dicBANKS_ID: TIntegerField;
    q_dicMFO: TIBStringField;
    q_dicNAME: TIBStringField;
    g_dicBANKS_ID: TdxDBGridMaskColumn;
    g_dicMFO: TdxDBGridMaskColumn;
    g_dicNAME: TdxDBGridMaskColumn;
    procedure tool_buttonClick(Sender: TObject);
  private
    { Private declarations }
  public
    procedure InitInfo; override;
    procedure RefreshDic; override;
  end;

procedure BankPopupCreate(popup_prm: lpZPopupParams; prm: ZVelesInfoRec);
procedure BankPopupRefresh(popup_prm: lpZPopupParams);
procedure BankPopupFree(popup_prm: lpZPopupParams);

implementation

{$R *.dfm}

procedure BankPopupCreate(popup_prm: lpZPopupParams; prm: ZVelesInfoRec);
var fpopup: Tfbank_popup;
begin
  fpopup := Tfbank_popup.Create(nil);
  popup_prm.prew_form := fpopup;
  fpopup.popup_prm := popup_prm;
  fpopup.prm := prm;

  fpopup.InitInfo;
end;

procedure BankPopupRefresh(popup_prm: lpZPopupParams);
var fpopup: Tfbank_popup;
begin
  fpopup := Tfbank_popup(popup_prm.prew_form);
  fpopup.RefreshDic;
end;

procedure BankPopupFree(popup_prm: lpZPopupParams);
var fpopup: Tfbank_popup;
begin
  fpopup := Tfbank_popup(popup_prm.prew_form);
  fpopup.Free;
end;

procedure Tfbank_popup.InitInfo;
begin
  sql_refresh_document  := 'select banks_id, mfo, name from t_banks where banks_id = :idocument_id';
  sql_fill_popup_edit := 'select ' + #39 + '(' + #39 + '||mfo||' + #39 + ')' + #39 + '||name as fill_line from t_banks where banks_id = :idocument_id ';

  dic_refresh_enabled := false;

  inherited InitInfo;

end;

procedure Tfbank_popup.RefreshDic;
begin
  inherited RefreshDic;
end;

procedure Tfbank_popup.tool_buttonClick(Sender: TObject);
var button: ZToolButton;
    old_cursor: TCursor;
    lpDeleteRecord: function(query: PChar; id: integer; for_upd: TIBQuery;
                                var prm: ZVelesInfoRec): integer;
    lib_handle: THandle;
    ins_upd_result: integer;
    lpInsUpdDialod: function(id: integer; var prm: ZVelesInfoRec): integer;
begin
  button := ZToolButton(Sender);

  // Створення запису
  if button = bt_ins then
  begin
    @lpInsUpdDialod := nil;
    lib_handle := LoadLibrary(PAnsiChar('client.dll'));
    if lib_handle >= 32 then
    begin
      @lpInsUpdDialod := GetProcAddress(lib_handle, PAnsiChar('BankDialog'));
      if @lpInsUpdDialod <> nil then
      begin
        ins_upd_result := lpInsUpdDialod(0, prm);
        if ins_upd_result > 0 then
        begin
          q_dic.Insert;
          q_dic.FieldByName(g_dic.KeyField).AsInteger := ins_upd_result;
          q_dic.Post;
          RefreshRecord;
        end;
      end;
      FreeLibrary(lib_handle);
    end;
  end
  // Редагування запису
  else if button = bt_upd then
  begin
    if q_dic.FieldByName(g_dic.KeyField).IsNull then
      exit;

    @lpInsUpdDialod := nil;
    lib_handle := LoadLibrary(PAnsiChar('client.dll'));
    if lib_handle >= 32 then
    begin
      @lpInsUpdDialod := GetProcAddress(lib_handle, PAnsiChar('BankDialog'));
      if @lpInsUpdDialod <> nil then
      begin
        ins_upd_result := lpInsUpdDialod(q_dic.FieldByName(g_dic.KeyField).AsInteger, prm);
        if ins_upd_result > 0 then
        begin
          RefreshRecord;
        end;
      end;
      FreeLibrary(lib_handle);
    end;
  end
end;

end.
