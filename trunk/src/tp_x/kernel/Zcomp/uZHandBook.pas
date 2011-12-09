unit uZHandBook;

interface

uses
  Windows, Messages, SysUtils, Classes, Controls, ExtCtrls, ComCtrls, ToolWin,
  Graphics, Imglist, DB, IBQuery, IBDataBase, uZControlBar;

type
  ZHandBook = class(TPanel)
  private
    { Private declarations }
    activated: boolean;
    bmp: TBitmap;
    image_list:   TImageList;

    control_bar:  ZControlBar;
    tool_bar:     TToolBar;
    bt_ins:       TToolButton;
    bt_upd:       TToolButton;
    bt_del:       TToolButton;
    separator:    TToolButton;
    bt_refresh:   TToolButton;
    bt_fetch:     TToolButton;

    page_control: TPageControl;
    tab_shet0:    TTabSheet;
    tab_shet1:    TTabSheet;

    base : TIBDataBase;
    q: TIBQuery;

    procedure SetActivate(value: boolean);
//    function  GetDataSource: TDataSource;
  protected
    { Protected declarations }
  public
    { Public declarations }
    constructor Create(AOwner:TComponent); override;
    destructor Destroy; override;

  published
    { Published declarations }
    property Align;
    property Visible;
    property Autosize;
    property Anchors;
    property Constraints;

    property Activate: boolean read activated write SetActivate default false;
  end;

procedure Register;

implementation
{$R ZHandBook.dcr}

procedure Register;
begin
  RegisterComponents('Freedom', [ZHandBook]);
end;

constructor ZHandBook.Create(AOwner:TComponent);
begin
  inherited Create(AOwner);
  Width := 360;
  Height := 225;

  activated := false;

  base := TIBDataBase.Create(Self);
  q := TIBQuery.Create(base);
//  q.DataBase := base;

  image_list := TImageList.Create(Self);
  bmp := TBitmap.Create;
  bmp.Handle := LoadBitmap(hInstance, 'XPICT_INS');
  image_list.AddMasked(bmp, clFuchsia);
  bmp.Handle := LoadBitmap(hInstance, 'XPICT_UPD');
  image_list.AddMasked(bmp, clFuchsia);
  bmp.Handle := LoadBitmap(hInstance, 'XPICT_DEL');
  image_list.AddMasked(bmp, clFuchsia);
  bmp.Handle := LoadBitmap(hInstance, 'XPICT_REFRESH');
  image_list.AddMasked(bmp, clFuchsia);
  bmp.Handle := LoadBitmap(hInstance, 'XPICT_FETCH');
  image_list.AddMasked(bmp, clFuchsia);

  bmp.Handle := LoadBitmap(hInstance, 'XTAB_DIC');
  image_list.AddMasked(bmp, clFuchsia);
  bmp.Handle := LoadBitmap(hInstance, 'XTAB_DETAIL');
  image_list.AddMasked(bmp, clFuchsia);
  bmp.Free;

  // Ініціалізація верхньої панелі
  control_bar := ZControlBar.Create(Self);
  control_bar.Parent := Self;

  tool_bar := TToolBar.Create(control_bar);
  tool_bar.Parent := control_bar;
  tool_bar.Visible := true;
  tool_bar.EdgeBorders := [];
  tool_bar.EdgeInner := esNone;
  tool_bar.EdgeOuter := esNone;
  tool_bar.Flat := true;

  bt_fetch := TToolButton.Create(control_bar);
  bt_fetch.ImageIndex := 4;
  bt_fetch.Visible := true;
  bt_fetch.Style := tbsCheck;
  bt_fetch.ShowHint := true;
  bt_fetch.Hint := 'Кешування даних';

  bt_refresh := TToolButton.Create(tool_bar);
  bt_refresh.ImageIndex := 3;
  bt_refresh.Visible := true;
  bt_refresh.ShowHint := true;
  bt_refresh.Hint := 'Обновити довідник';

  separator := TToolButton.Create(tool_bar);
  separator.Visible := true;
  separator.Style := tbsSeparator;
  separator.Width := 5;

  bt_del := TToolButton.Create(tool_bar);
  bt_del.ImageIndex := 2;
  bt_del.Visible := true;
  bt_del.ShowHint := true;
  bt_del.Hint := 'Видалити запис';

  bt_upd := TToolButton.Create(tool_bar);
  bt_upd.ImageIndex := 1;
  bt_upd.Visible := true;
  bt_upd.ShowHint := true;
  bt_upd.Hint := 'Редагувати запис';

  bt_ins := TToolButton.Create(tool_bar);
  bt_ins.ImageIndex := 0;
  bt_ins.Visible := true;
  bt_ins.ShowHint := true;
  bt_ins.Hint := 'Додати запис';

  control_bar.AutoSize := true;

  page_control := TPageControl.Create(Self);
  page_control.Parent := Self;
  page_control.Visible := true;
  page_control.Align := alClient;

  tab_shet0 := TTabSheet.Create(page_control);
  tab_shet0.ImageIndex := 5;
  tab_shet0.Caption := 'Довідник';
  tab_shet0.Visible := true;

  tab_shet1 := TTabSheet.Create(page_control);
  tab_shet1.ImageIndex := 6;
  tab_shet1.Caption := 'Детально';
  tab_shet1.Visible := true;
end;

procedure ZHandBook.SetActivate(value: boolean);
begin
  if value then
  begin
    tool_bar.Images := image_list;
    bt_fetch.Parent   := tool_bar;
    bt_refresh.Parent := tool_bar;
    separator.Parent  := tool_bar;
    bt_del.Parent     := tool_bar;
    bt_upd.Parent     := tool_bar;
    bt_ins.Parent     := tool_bar;

    page_control.Images := image_list;
    tab_shet0.PageControl := page_control;
    tab_shet1.PageControl := page_control;

    page_control.TabIndex := 0;
    activated := value;
  end;
end;

destructor ZHandBook.Destroy;
begin
  inherited Destroy;
end;

{procedure ZHandBook.SetBaseHandle(base_handle: Pointer);
begin
  base.SetHandle(base_handle);
end;

function  ZHandBook.SetDataSource(data_source: TDataSource);
begin
  GetDataSource := q.DataSource;
end;
}
end.
