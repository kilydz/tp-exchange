unit upoint;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ExtCtrls, ImgList, uZToolButton, ToolWin, ComCtrls, uZToolBar,
  dxExEdtr, dxCntner, dxTL, dxDBCtrl, dxDBGrid, StdCtrls, uZbutton, DB,
  IBCustomDataSet, IBQuery, IBDatabase, kernel_h, IBSQL, Zutils_h;

type
  ZPointLX = record
    l0_point_id, l1_point_id, l2_point_id, l3_point_id: integer;
    l0_refresh, l1_refresh, l2_refresh, l3_refresh: boolean;
  end;

  Ted_points = class(TForm)
    Panel1: TPanel;
    Panel2: TPanel;
    p_point_l1: TPanel;
    p_point_l3: TPanel;
    p_point_l2: TPanel;
    ZToolBar1: ZToolBar;
    bt_del_l1: ZToolButton;
    bt_upd_l1: ZToolButton;
    bt_ins_l1: ZToolButton;
    images: TImageList;
    ZToolBar2: ZToolBar;
    bt_ins_l2: ZToolButton;
    bt_upd_l2: ZToolButton;
    bt_del_l2: ZToolButton;
    ZToolBar3: ZToolBar;
    bt_ins_l3: ZToolButton;
    bt_upd_l3: ZToolButton;
    bt_del_l3: ZToolButton;
    g_point_l1: TdxDBGrid;
    g_point_l2: TdxDBGrid;
    g_point_l3: TdxDBGrid;
    bt_ok: ZButton;
    bt_cancel: ZButton;
    base: TIBDatabase;
    tr_point_l1: TIBTransaction;
    q_point_l1: TIBQuery;
    ds_point_l1: TDataSource;
    q_point_l1L1_POINT_ID: TIntegerField;
    q_point_l1NAME: TIBStringField;
    g_point_l1NAME: TdxDBGridMaskColumn;
    tr_point_l2: TIBTransaction;
    q_point_l2: TIBQuery;
    ds_point_l2: TDataSource;
    q_point_l2L2_POINT_ID: TIntegerField;
    q_point_l2NAME: TIBStringField;
    g_point_l2NAME: TdxDBGridMaskColumn;
    tr_point_l3: TIBTransaction;
    q_point_l3: TIBQuery;
    ds_point_l3: TDataSource;
    q_point_l3L3_POINT_ID: TIntegerField;
    q_point_l3NAME: TIBStringField;
    q_point_l3POST_CODE: TIBStringField;
    g_point_l3NAME: TdxDBGridMaskColumn;
    g_point_l3POST_CODE: TdxDBGridMaskColumn;
    trR: TIBTransaction;
    qR: TIBSQL;
    trW: TIBTransaction;
    qW: TIBSQL;
    procedure bt_l3Click(Sender: TObject);
    procedure bt_l2Click(Sender: TObject);
    procedure bt_l1Click(Sender: TObject);
    procedure q_point_l3AfterScroll(DataSet: TDataSet);
    procedure q_point_l2AfterScroll(DataSet: TDataSet);
    procedure q_point_l1AfterScroll(DataSet: TDataSet);
  private
    { Private declarations }
  public
    prm: ZVelesInfoRec;
    point: ZPointLX;
    id: integer;
    resulted_id: integer;

    procedure InitInfo;
    procedure RefreshL1;
    procedure RefreshL2;
    procedure RefreshL3;
  end;

function PointDialog(id: integer; var prm: ZVelesInfoRec): integer;

implementation

uses upoint_l1, upoint_l2, upoint_l3;

{$R *.dfm}

function PointDialog(id: integer; var prm: ZVelesInfoRec): integer;
var ret: integer;
    dlg: Ted_points;
begin
  ret := 0;
  dlg := Ted_points.Create(Application);
  dlg.id := id;
  dlg.prm := prm;
  dlg.InitInfo;

  if dlg.ShowModal = mrOK then
    ret := dlg.resulted_id;
  dlg.Free;

  Result := ret;
end;

procedure Ted_points.bt_l1Click(Sender: TObject);
var button: ZToolButton;
    point_id: integer;
begin
  button := ZToolButton(Sender);

  if button = bt_ins_l1 then
  begin
    point_id := PointL1Dialog(0, point.l0_point_id, prm);
    if point_id > 0 then
    begin
      point.l1_point_id := point_id;
      point.l2_point_id := 0;
      point.l3_point_id := 0;
      RefreshL1;
    end;
  end else
  if button = bt_upd_l1 then
  begin
    if ((q_point_l1.FieldByName('l1_point_id').IsNull) or
        (q_point_l1.FieldByName('l1_point_id').AsInteger = 0)) then
    begin
      ShowMessage('Встановіть курсор на не порожній запис.');
      exit;
    end;

    point_id := PointL1Dialog(q_point_l1.FieldByName('l1_point_id').AsInteger,
                   point.l0_point_id, prm);
    if point_id > 0 then
    begin
      point.l1_point_id := point_id;
      point.l2_point_id := q_point_l2.FieldByName('l2_point_id').AsInteger;
      point.l3_point_id := q_point_l3.FieldByName('l3_point_id').AsInteger;
      RefreshL1;
    end;
  end else
  if button = bt_del_l1 then
  begin
    if ((q_point_l1.FieldByName('l1_point_id').IsNull) or
        (q_point_l1.FieldByName('l1_point_id').AsInteger = 0)) then
    begin
      ShowMessage('Встановіть курсор на не порожній запис.');
      exit;
    end;
    GDeleteRecord('select * from PS_L1_POINT_DEL(:idocument_id)',
           q_point_l1.FieldByName('l1_point_id').AsInteger, nil, prm);

    RefreshL3;
  end
end;

procedure Ted_points.bt_l2Click(Sender: TObject);
var button: ZToolButton;
    point_id: integer;
begin
  button := ZToolButton(Sender);

  if button = bt_ins_l2 then
  begin
    if ((q_point_l1.FieldByName('l1_point_id').IsNull) or
        (q_point_l1.FieldByName('l1_point_id').AsInteger = 0)) then
    begin
      ShowMessage('Область не може бути порожньою для нового району.');
      exit;
    end;

    point_id := PointL2Dialog(0, q_point_l1.FieldByName('l1_point_id').AsInteger, prm);
    if point_id > 0 then
    begin
      point.l2_point_id := point_id;
      point.l3_point_id := 0;
      RefreshL2;
    end;
  end else
  if button = bt_upd_l2 then
  begin
    if ((q_point_l2.FieldByName('l2_point_id').IsNull) or
        (q_point_l2.FieldByName('l2_point_id').AsInteger = 0)) then
    begin
      ShowMessage('Встановіть курсор на не порожній запис.');
      exit;
    end;

    point_id := PointL2Dialog(q_point_l2.FieldByName('l2_point_id').AsInteger,
                   q_point_l1.FieldByName('l1_point_id').AsInteger, prm);
    if point_id > 0 then
    begin
      point.l2_point_id := point_id;
      point.l3_point_id := q_point_l3.FieldByName('l3_point_id').AsInteger;
      RefreshL2;
    end;
  end else
  if button = bt_del_l2 then
  begin
    if ((q_point_l2.FieldByName('l2_point_id').IsNull) or
        (q_point_l2.FieldByName('l2_point_id').AsInteger = 0)) then
    begin
      ShowMessage('Встановіть курсор на не порожній запис.');
      exit;
    end;
    GDeleteRecord('select * from PS_L2_POINT_DEL(:idocument_id)',
           q_point_l2.FieldByName('l2_point_id').AsInteger, nil, prm);

    RefreshL2;
  end
end;

procedure Ted_points.bt_l3Click(Sender: TObject);
var button: ZToolButton;
    point_id: integer;
begin
  button := ZToolButton(Sender);

  if button = bt_ins_l3 then
  begin
    if ((q_point_l2.FieldByName('l2_point_id').IsNull) or
        (q_point_l2.FieldByName('l2_point_id').AsInteger = 0)) then
    begin
      ShowMessage('Район не може бути порожнім для нового населеного пункту.');
      exit;
    end;

    point_id := PointL3Dialog(0, q_point_l2.FieldByName('l2_point_id').AsInteger, prm);
    if point_id > 0 then
    begin
      point.l3_point_id := point_id;
      RefreshL3;
    end;
  end else
  if button = bt_upd_l3 then
  begin
    if ((q_point_l3.FieldByName('l3_point_id').IsNull) or
        (q_point_l3.FieldByName('l3_point_id').AsInteger = 0)) then
    begin
      ShowMessage('Встановіть курсор на не порожній запис.');
      exit;
    end;

    point_id := PointL3Dialog(q_point_l3.FieldByName('l3_point_id').AsInteger,
                   q_point_l2.FieldByName('l2_point_id').AsInteger, prm);
    if point_id > 0 then
    begin
      point.l3_point_id := point_id;
      RefreshL3;
    end;
  end else
  if button = bt_del_l3 then
  begin
    if ((q_point_l3.FieldByName('l3_point_id').IsNull) or
          (q_point_l3.FieldByName('l3_point_id').AsInteger = 0)) then
    begin
      ShowMessage('Встановіть курсор на не порожній запис.');
      exit;
    end;
    GDeleteRecord('select * from PS_L3_POINT_DEL(:idocument_id)',
           q_point_l3.FieldByName('l3_point_id').AsInteger, nil, prm);

    RefreshL3;
  end
end;


procedure Ted_points.InitInfo;
begin
  base.SetHandle(prm.db_handle);
  point.l0_refresh := true;
  point.l1_refresh := true;

  point.l0_point_id := 1;
  if trR.InTransaction then trR.Commit;
  trR.StartTransaction;
   qR.SQL.Text := 'select l3p.l3_point_id, l2p.l2_point_id, l2p.l1_point_id from t_l3_points l3p, t_l2_points l2p ' +
        ' where   l3p.l3_point_id = :iid and ' +
                ' l2p.l2_point_id = l3p.l2_point_id';
   qR.ParamByName('iid').AsInteger := id;
   qR.ExecQuery;
   point.l3_point_id := qR.FieldByName('l3_point_id').AsInteger;
   point.l2_point_id := qR.FieldByName('l2_point_id').AsInteger;
   point.l1_point_id := qR.FieldByName('l1_point_id').AsInteger;
  if trR.InTransaction then trR.Commit;

  RefreshL1;
end;

procedure Ted_points.q_point_l1AfterScroll(DataSet: TDataSet);
begin
  RefreshL2;
end;

procedure Ted_points.q_point_l2AfterScroll(DataSet: TDataSet);
begin
  RefreshL3;
end;

procedure Ted_points.q_point_l3AfterScroll(DataSet: TDataSet);
begin
  resulted_id := q_point_l3.FieldByName('l3_point_id').AsInteger;
end;

procedure Ted_points.RefreshL1;
begin
  point.l2_refresh := false;
  if tr_point_l1.InTransaction then tr_point_l1.Commit;
  tr_point_l1.StartTransaction;
   q_point_l1.Open;
  if tr_point_l1.InTransaction then tr_point_l1.CommitRetaining;

  q_point_l1.Locate('l1_point_id', point.l1_point_id, [loCaseInsensitive]);
  point.l2_refresh := true;

  RefreshL2;
end;

procedure Ted_points.RefreshL2;
begin
  if point.l2_refresh then
  begin
    point.l3_refresh := false;
    if tr_point_l2.InTransaction then tr_point_l2.Commit;
    tr_point_l2.StartTransaction;
     q_point_l2.ParamByName('il1_point_id').AsInteger :=
                 q_point_l1.FieldByName('l1_point_id').AsInteger;
     q_point_l2.Open;
    if tr_point_l2.InTransaction then tr_point_l2.CommitRetaining;

    q_point_l2.Locate('l2_point_id', point.l2_point_id, [loCaseInsensitive]);
    point.l3_refresh := true;

    RefreshL3;
  end;
end;

procedure Ted_points.RefreshL3;
begin
  if point.l3_refresh then
  begin
    if tr_point_l3.InTransaction then tr_point_l3.Commit;
    tr_point_l3.StartTransaction;
     q_point_l3.ParamByName('il2_point_id').AsInteger :=
                 q_point_l2.FieldByName('l2_point_id').AsInteger;
     q_point_l3.Open;
     q_point_l3.Locate('l3_point_id', point.l3_point_id, [loCaseInsensitive]);
    if tr_point_l3.InTransaction then tr_point_l3.CommitRetaining;

  end;
end;

end.
