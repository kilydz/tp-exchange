unit document_popup;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, etalon_popup, dxExEdtr, dxCntner, ImgList, IBSQL, Menus, DB,
  IBCustomDataSet, IBUpdateSQL, IBQuery, IBDatabase, StdCtrls,
  dxTL, dxDBCtrl, dxDBGrid, ComCtrls, ToolWin, uZToolBar,
  ExtCtrls, dxEdLib, uZControlBar, kernel_h, dxEditor, tree_h, popups_h, document_h,
  RXCtrls, dxDBTLCl, dxGrClms, uZFilter, uZToolButton, uZbutton;

type
  Tfdocument_popup = class(Tfetalon_popup)
    ZToolBar1: ZToolBar;
    q_dicODOCUMENT_ID: TIntegerField;
    q_dicONUMBER: TIBStringField;
    q_dicOTYPEDOC_ID: TIntegerField;
    q_dicOIS_FIXED: TSmallintField;
    q_dicOTOKEN: TIBStringField;
    q_dicODATE: TDateField;
    q_dicOSRC_NAME: TIBStringField;
    q_dicOSRC_FULLNAME: TIBStringField;
    q_dicODST_NAME: TIBStringField;
    q_dicODST_FULLNAME: TIBStringField;
    q_dicOSUM_IN: TFloatField;
    q_dicOSUM_OUT: TFloatField;
    q_dicOSUM_IN_PDV: TFloatField;
    q_dicOSUM_OUT_PDV: TFloatField;
    q_dicOOPLATA_STATE: TIntegerField;
    g_dicODOCUMENT_ID: TdxDBGridMaskColumn;
    g_dicONUMBER: TdxDBGridMaskColumn;
    g_dicOTOKEN: TdxDBGridMaskColumn;
    g_dicODATE: TdxDBGridDateColumn;
    g_dicOSRC_NAME: TdxDBGridMaskColumn;
    g_dicOSRC_FULLNAME: TdxDBGridMaskColumn;
    g_dicODST_NAME: TdxDBGridMaskColumn;
    g_dicODST_FULLNAME: TdxDBGridMaskColumn;
    g_dicOSUM_IN: TdxDBGridMaskColumn;
    g_dicOSUM_OUT: TdxDBGridMaskColumn;
    g_dicOSUM_IN_PDV: TdxDBGridMaskColumn;
    g_dicOSUM_OUT_PDV: TdxDBGridMaskColumn;
    q_dicMARKUP_SUM: TCurrencyField;
    q_dicMARKUP: TCurrencyField;
    q_dicMARKUP_OFIC: TCurrencyField;
    g_dicOIS_FIXED: TdxDBGridImageColumn;
    g_dicOTYPEDOC_ID: TdxDBGridImageColumn;
    q_dicOOPLATA_TYPE_ID: TIntegerField;
    g_dicOOPLATA_TYPE_ID: TdxDBGridImageColumn;
    RxLabel1: TRxLabel;
    ed_date_0: TdxDateEdit;
    RxLabel2: TRxLabel;
    ed_date_1: TdxDateEdit;
    procedure tool_buttonClick(Sender: TObject);
    procedure ed_date_0Change(Sender: TObject);
  private
    { Private declarations }
    type_docs: string;
  public
    { Public declarations }
    procedure InitInfo; override;
    procedure RefreshDic; override;

  end;

procedure DocumentPopupCreate(popup_prm: lpZPopupParams; prm: ZVelesInfoRec);
procedure DocumentPopupRefresh(popup_prm: lpZPopupParams; type_docs: string);
procedure DocumentPopupFree(popup_prm: lpZPopupParams);

implementation

{$R *.dfm}

procedure DocumentPopupCreate(popup_prm: lpZPopupParams; prm: ZVelesInfoRec);
var fpopup: Tfdocument_popup;
begin
  fpopup := Tfdocument_popup.Create(nil);
  popup_prm.prew_form := fpopup;
  fpopup.popup_prm := popup_prm;
  fpopup.prm := prm;

  fpopup.InitInfo;
end;

procedure DocumentPopupRefresh(popup_prm: lpZPopupParams; type_docs: string);
var fpopup: Tfdocument_popup;
begin
  fpopup := Tfdocument_popup(popup_prm.prew_form);
  fpopup.type_docs := type_docs;
  fpopup.RefreshDic;
end;

procedure DocumentPopupFree(popup_prm: lpZPopupParams);
var fpopup: Tfdocument_popup;
begin
  fpopup := Tfdocument_popup(popup_prm.prew_form);
  fpopup.Free;
end;

procedure Tfdocument_popup.ed_date_0Change(Sender: TObject);
begin
  RefreshDic;
end;

procedure Tfdocument_popup.InitInfo;
begin
  sql_refresh_document  := 'select odocument_id, onumber, otypedoc_id, ois_fixed, otoken, odate, ' +
                ' osrc_name, osrc_fullname, odst_name, odst_fullname, osum_in, osum_out, osum_in_pdv, ' +
                ' osum_out_pdv, ooplata_state, ooplata_type_id, otime_cr, oarrow, ois_print_tax, onotarization, ostaffname from PS_DOCUMENT_VIEW(:idocument_id)';
  sql_fill_popup_edit := 'select doc_num as fill_line from t_documents where document_id = :idocument_id';
  
  dic_refresh_enabled := false;
  ed_date_0.Date := Date;
  ed_date_1.Date := Date;

  inherited InitInfo;
end;

procedure Tfdocument_popup.RefreshDic;
begin
  q_dic.ParamByName('idate0').AsString := DateToStr(ed_date_0.Date);
  q_dic.ParamByName('idate1').AsString := DateToStr(ed_date_1.Date);

    q_dic.ParamByName('itypes').AsString := type_docs;
    q_dic.ParamByName('ipays').AsString  := ' 0 1 2 3 ';
    q_dic.ParamByName('iis_pays').AsString := ' 0 1 2 3 ';

  inherited RefreshDic;
end;

procedure Tfdocument_popup.tool_buttonClick(Sender: TObject);
var resulted: ZDocumentDialogResulted;
    lpDocumentDialog: function(id: integer; resulted: lpZDocumentDialogResulted; var prm: ZVelesInfoRec): integer;
    lib_handle: THandle;
    button: ZToolButton;
begin
  inherited tool_buttonClick(Sender);

  button := ZToolButton(Sender);
  if button = bt_ins then
  begin
    @lpDocumentDialog := nil;
    lib_handle := LoadLibrary('document.dll');
    if lib_handle >= 32 then
    begin
      @lpDocumentDialog := GetProcAddress(lib_handle, 'DocumentDialog');
      if @lpDocumentDialog <> nil then
        if lpDocumentDialog(0, @resulted, prm) > 0 then
        begin
          q_dic.Insert;
          q_dic.FieldByName('odocument_id').AsInteger := resulted.document_id;
          q_dic.Post;
          RefreshDic;//RefreshRecord;
        end;
      FreeLibrary(lib_handle);
    end;
  end
  else if button = bt_upd then
  begin
    @lpDocumentDialog := nil;
    lib_handle := LoadLibrary('document.dll');
    if lib_handle >= 32 then
    begin
      @lpDocumentDialog := GetProcAddress(lib_handle, 'DocumentDialog');
      if @lpDocumentDialog <> nil then
        if lpDocumentDialog(q_dic.FieldByName('odocument_id').AsInteger, @resulted, prm) > 0 then
        begin
          RefreshDic;//RefreshRecord;
        end;
      FreeLibrary(lib_handle);
    end;
  end
end;

end.
