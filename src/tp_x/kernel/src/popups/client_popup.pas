unit client_popup;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, etalon_popup, dxExEdtr, dxCntner, ImgList, IBSQL, Menus,
  IBCustomDataSet, IBUpdateSQL, DB, IBQuery, IBDatabase, StdCtrls,
  uZFilter, dxTL, dxDBCtrl, dxDBGrid, ComCtrls, ToolWin, uZToolBar,
  ExtCtrls, dxEdLib, kernel_h, dxEditor, tree_h, popups_h, client_h,
  uZControlBar, uZToolButton, uZbutton;

type
  Tfclient_popup = class(Tfetalon_popup)
    ZToolBar1: ZToolBar;
    ed_flag: TdxImageEdit;
    ToolButton2: TToolButton;
    ed_grpc_id: TdxPopupEdit;
    q_dicOCLIENT_ID: TIntegerField;
    q_dicOCODE: TIBStringField;
    q_dicOSHORT_NAME: TIBStringField;
    q_dicOFULL_NAME: TIBStringField;
    q_dicOADRESS: TIBStringField;
    q_dicOGRPC_ID: TIntegerField;
    q_dicOIS_PDV: TSmallintField;
    g_dicOCLIENT_ID: TdxDBGridMaskColumn;
    g_dicOCODE: TdxDBGridMaskColumn;
    g_dicOSHORT_NAME: TdxDBGridMaskColumn;
    g_dicOFULL_NAME: TdxDBGridMaskColumn;
    g_dicOADRESS: TdxDBGridMaskColumn;
    q_dicZKPO: TIBStringField;
    g_dicZKPO: TdxDBGridMaskColumn;
    procedure ed_flagChange(Sender: TObject);
    procedure tool_buttonClick(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
    grpc_id: integer;
    tree_prm: TTreeParams;

    procedure InitInfo; override;
    procedure RefreshDic; override;

  end;

procedure ClientPopupCreate(popup_prm: lpZPopupParams; prm: ZVelesInfoRec);
procedure ClientPopupRefresh(popup_prm: lpZPopupParams; flag: integer);
procedure ClientPopupFree(popup_prm: lpZPopupParams);

procedure ChengeBranchEv(var prm: TTreeParams);
procedure ShowHideEv(var prm: TTreeParams);

implementation

{$R *.dfm}

procedure ChengeBranchEv(var prm: TTreeParams);
var fpopup: Tfclient_popup;
begin
  fpopup := Tfclient_popup(prm.PrewForma);
  fpopup.ed_grpc_id.Text := prm.ActiveNode.name;
  fpopup.grpc_id := prm.ActiveNode.id;
  fpopup.RefreshDic;
end;

procedure ShowHideEv(var prm: TTreeParams);
begin
end;

procedure ClientPopupCreate(popup_prm: lpZPopupParams; prm: ZVelesInfoRec);
var fpopup: Tfclient_popup;
begin
  fpopup := Tfclient_popup.Create(nil);
  popup_prm.prew_form := fpopup;
  fpopup.popup_prm := popup_prm;
  fpopup.prm := prm;

  fpopup.InitInfo;
end;

procedure ClientPopupRefresh(popup_prm: lpZPopupParams; flag: integer);
var fpopup: Tfclient_popup;
begin
  fpopup := Tfclient_popup(popup_prm.prew_form);
  fpopup.popup_prm := popup_prm;
  fpopup.ed_flag.Text := IntToStr(flag);
  if popup_prm.id <> 0 then
  begin
     fpopup.q_dic.First;
     while ((fpopup.q_dic.FieldByName(fpopup.g_dic.KeyField).AsInteger <> popup_prm.id)and
            (fpopup.q_dic.RecNo < fpopup.q_dic.RecordCount)) do
       fpopup.q_dic.Next;
  end;
  { flag = 1: Відображаються лише клієнти з типу "Склад" (clienttype_id = 1)
           2: -//- "Постачальник" та "Покупець"          (clienttype_id in [2, 3])
           3: -//- "Постачальник"                        (clienttype_id = 2) }
end;

procedure ClientPopupFree(popup_prm: lpZPopupParams);
var fpopup: Tfclient_popup;
begin
  fpopup := Tfclient_popup(popup_prm.prew_form);
  fpopup.Free;
end;

procedure Tfclient_popup.InitInfo;
begin
  sql_refresh_document  := 'select oclient_id, ocode, oshort_name, ofull_name, oadress, ogrpc_id, ois_pdv from PS_POPUP_CLIENT_VIEW(:idocument_id)';
  sql_fill_popup_edit := 'select name as fill_line from t_clients where clients_id = :idocument_id';
  
  dic_refresh_enabled := false;

  if @tree_prm.OnChengeBranch = nil then
  begin
    tree_prm.sGen := prm;
    tree_prm.PrewForma := self;
    tree_prm.OnChengeBranch := @ChengeBranchEv;
    tree_prm.OnShowHide := @ShowHideEv;
    tree_prm.Visible := false;
    TreeCreateC(tree_prm);
    ed_grpc_id.PopupControl := tree_prm.Panel;
  end;
  grpc_id := 0;

  is_new_project := true;
  inherited InitInfo;
  ins_upd_func_name := 'ClientDialog';
  ins_upd_dll_name := 'client.dll';

end;

procedure Tfclient_popup.RefreshDic;
begin
  q_dic.ParamByName('iflag').AsInteger := StrToInt(ed_flag.Text);
  q_dic.ParamByName('igrpc_id').AsInteger := grpc_id;
  inherited RefreshDic;
end;

procedure Tfclient_popup.ed_flagChange(Sender: TObject);
begin
  RefreshDic;
end;

procedure Tfclient_popup.tool_buttonClick(Sender: TObject);
begin
  inherited tool_buttonClick(Sender);
end;

procedure Tfclient_popup.FormDestroy(Sender: TObject);
begin
  TreeRelaseC(tree_prm);
end;

end.
