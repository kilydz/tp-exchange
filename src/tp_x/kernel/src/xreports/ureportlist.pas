unit ureportlist;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, etalon_dic, dxExEdtr, dxCntner, Menus, IBCustomDataSet,
  IBUpdateSQL, IBSQL, IBDatabase, DB, IBQuery, ImgList, ExtCtrls, uZFilter,
  dxTL, dxDBCtrl, dxDBGrid, ComCtrls, ToolWin, uZToolBar, uZControlBar, kernel_h,
  reports_h, dxDBTLCl, dxGrClms, StdCtrls, dxEditor, dxEdLib, secure_h, genstor_h,
  uZToolButton, zutils_h;

type
  Tfreportlist = class(Tfetalon_dic)
    q_dicOREPORT_ID: TIntegerField;
    q_dicONAME: TIBStringField;
    q_dicODESCRIPT: TIBStringField;
    q_dicOFIELDS_CNT: TIntegerField;
    g_dicOREPORT_ID: TdxDBGridMaskColumn;
    g_dicONAME: TdxDBGridMaskColumn;
    g_dicODESCRIPT: TdxDBGridMaskColumn;
    g_dicOFIELDS_CNT: TdxDBGridMaskColumn;
    q_dicOPARAMS_CNT: TIntegerField;
    g_dicOPARAMS_CNT: TdxDBGridMaskColumn;
    q_dicOIS_ENABLED: TSmallintField;
    g_dicOIS_ENABLED: TdxDBGridImageColumn;
    q_detaileOLABEL: TIBStringField;
    q_detaileODESCRIPT: TIBStringField;
    q_detaileOTYPE: TSmallintField;
    q_detaileOPOSITION: TIntegerField;
    g_detaileOLABEL: TdxDBGridMaskColumn;
    g_detaileODESCRIPT: TdxDBGridMaskColumn;
    g_detaileOPOSITION: TdxDBGridMaskColumn;
    g_detaileOTYPE: TdxDBGridImageColumn;
    lNomenCode: TLabel;
    l_code: TStaticText;
    lNomenName: TLabel;
    l_name: TStaticText;
    l_descript: TdxMemo;
    Label1: TLabel;
    bt_do_report: ZToolButton;
    procedure tool_buttonClick(Sender: TObject);
    procedure pg_pagesChange(Sender: TObject);
    procedure mi_Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }

    procedure InitInfo; override;
    procedure RefreshDic; override;
    procedure RefreshDetaile; override;
  end;


function ShowPage(var a_veles_info: ZVelesInfoRec): Longint; stdcall;
procedure FreePage(a_form_ref: Longint); stdcall;

var
  dlg: Tfreportlist;

implementation

uses udialogformreport;

{$R *.dfm}


function ShowPage(var a_veles_info: ZVelesInfoRec): Longint;
begin
  if not HasUserAccessEx(a_veles_info, ACCESS_TO_REPORTS_DIC) then
  begin
      GMessageBox('Ви не маєте права доступу до довідника ''Звіти''', 'OK');
      Exit;
  end;

  if dlg = nil then
  begin
    dlg := Tfreportlist.Create(nil);
    dlg.prm := a_veles_info;
    dlg.InitInfo;
  end;
    dlg.panel.Visible := true;

  Result:=Longint(dlg);
end;

procedure FreePage(a_form_ref: Longint);
begin
  if (dlg <> nil) then dlg.Free;
end;

procedure Tfreportlist.InitInfo;
begin
  dic_refresh_enabled := false;

  inherited InitInfo;
end;

procedure Tfreportlist.RefreshDic;
begin
  inherited RefreshDic;
end;

procedure Tfreportlist.RefreshDetaile;
begin
  if detail_refresh_enabled and (pg_pages.TabIndex = 1) then
  begin
    l_code.Caption        := q_dic.FieldByName('oreport_id').AsString;
    l_name.Caption        := q_dic.FieldByName('oname').AsString;
    l_descript.Text       := q_dic.FieldByName('odescript').AsString;

    q_detaile.Close;
    if tr_detaile.InTransaction then tr_detaile.Commit;
    tr_detaile.StartTransaction;
     q_detaile.ParamByName('ireport_id').AsInteger :=
                  q_dic.FieldByName('oreport_id').AsInteger;
     q_detaile.Open;
    if tr_detaile.InTransaction then tr_detaile.CommitRetaining;   
  end
end;

procedure Tfreportlist.pg_pagesChange(Sender: TObject);
begin
  inherited pg_pagesChange(Sender);
end;

procedure Tfreportlist.tool_buttonClick(Sender: TObject);
var rep_prm: ZReports;
    lib_handle: THandle;
    button: ZToolButton;
begin
  inherited tool_buttonClick(Sender);

  button := ZToolButton(Sender);
  if button = bt_do_report then
  begin
    if IsRecordNull then
      exit;

    if q_dic.FieldByName('ois_enabled').AsInteger = 2 then
    begin
      ShowMessage('Звіт на реконструкції. Зверніться до адміністратора.');
      exit;
    end;

    if q_dic.FieldByName('ois_enabled').AsInteger <= 0 then
    begin
      ShowMessage('Ви не маєте прав на виконання даного звіту. Зверніться до адміністратора.');
      exit;
    end;

    rep_prm.prm := prm;
    rep_prm.report_id := q_dic.FieldByName('oreport_id').AsInteger;
    ReportShow(rep_prm);
  end
end;

procedure Tfreportlist.mi_Click(Sender: TObject);
begin
  inherited mi_Click(Sender);
end;

end.
