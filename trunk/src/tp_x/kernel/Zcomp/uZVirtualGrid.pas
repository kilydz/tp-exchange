unit uZVirtualGrid;

interface

uses
  SysUtils, Classes, Controls, Grids, DBGrids, RxMemDS, DB;

type
  ZVirtualGrid = class(TCustomDBGrid)
  private
    Fq: TRxMemoryData;
    Fds: TDataSource;
    Fdeletes: TStringList;
    Fvirt_id_name: String;

    function GetKeyValue: string;
    procedure SetKeyValue(ival: string);
    { Private declarations }
  protected
    { Protected declarations }
  public
    { Public declarations }
    constructor Create(AOwner:TComponent); override;
    destructor Destroy; override;

    //додати выртуальну колонку
    procedure AddColumnVirt(name, title: string; width: integer);
    //видалити запис з віртуального списку
    procedure DelRecordVirt;

    property  MemoryData: TRxMemoryData read Fq;
    property  DeletedIdList: TStringList read Fdeletes;
    property  KeyValue: String read GetKeyValue write SetKeyValue;
  published
    property Align;
    property Anchors;
    property BiDiMode;
    property BorderStyle;
    property Color;
    property Columns stored False; //StoreColumns;
    property Constraints;
    property Ctl3D;
    //property DataSource;
    property DefaultDrawing;
    property DragCursor;
    property DragKind;
    property DragMode;
    property Enabled;
    property FixedColor;
    property Font;
    property ImeMode;
    property ImeName;
    property Options;
    property ParentBiDiMode;
    property ParentColor;
    property ParentCtl3D;
    property ParentFont;
    property ParentShowHint;
    property PopupMenu;
    property ReadOnly;
    property ShowHint;
    property TabOrder;
    property TabStop;
    property TitleFont;
    property Visible;
    property OnCellClick;
    property OnColEnter;
    property OnColExit;
    property OnColumnMoved;
    property OnDrawDataCell;  { obsolete }
    property OnDrawColumnCell;
    property OnDblClick;
    property OnDragDrop;
    property OnDragOver;
    property OnEditButtonClick;
    property OnEndDock;
    property OnEndDrag;
    property OnEnter;
    property OnExit;
    property OnKeyDown;
    property OnKeyPress;
    property OnKeyUp;
    property OnMouseActivate;
    property OnMouseDown;
    property OnMouseEnter;
    property OnMouseLeave;
    property OnMouseMove;
    property OnMouseUp;
    property OnMouseWheel;
    property OnMouseWheelDown;
    property OnMouseWheelUp;
    property OnStartDock;
    property OnStartDrag;
    property OnTitleClick;
  end;

procedure Register;

implementation

procedure Register;
begin
  RegisterComponents('Freedom', [ZVirtualGrid]);
end;


constructor ZVirtualGrid.Create(AOwner:TComponent);
var field: TStringField;
begin
  inherited Create(AOwner);

  Fvirt_id_name := 'virt_id';
  Ctl3d := false;
  Options := Options - [dgEditing];

  Fq := TRxMemoryData.Create(self);
  Fds := TDataSource.Create(self);
  Fds.DataSet := Fq;
  self.DataSource := Fds;

  Fdeletes := TStringList.Create;

  // додаємо колонку з айдіхами
  field := TStringField.Create(self);
  field.FieldName := Fvirt_id_name;
  field.Size:=200;
  field.DataSet := Fq;
  field.Visible := false;
  field.Name := self.Name + field.FieldName;
 // Fq.Fields.Add(field);
  Fq.FieldDefs.Add(Fvirt_id_name, ftWord, 0, false);
end;

destructor ZVirtualGrid.Destroy;
begin
try
  Fdeletes.Free;
  Fds.Free;
  Fq.Free;

  inherited Destroy;
finally

end;
end;

procedure ZVirtualGrid.AddColumnVirt(name, title: string; width: integer);
var field: TStringField;
begin
  field := TStringField.Create(self);
  field.FieldName := name;
  field.Size:=200;
  field.DataSet := Fq;
  field.Name := self.Name + field.FieldName;
 // Fq.Fields.Add(field);
  Fq.FieldDefs.Add(name, ftWord, 0, false);

  Columns.Add;
  Columns.Items[Fq.FieldDefs.Count-2].FieldName := name;
  Columns.Items[Fq.FieldDefs.Count-2].Title.Caption := title;
  Columns.Items[Fq.FieldDefs.Count-2].Width := width;
end;

procedure ZVirtualGrid.DelRecordVirt;
var id: string;
begin
  try
    id := Fq.FieldByName(Fvirt_id_name).AsString;
    Fq.Delete;
    if (id <> '') then
      Fdeletes.Add(id);
  finally

  end;
end;

function ZVirtualGrid.GetKeyValue: string;
begin
  result := Fq.FieldByName(Fvirt_id_name).AsString;
end;

procedure ZVirtualGrid.SetKeyValue(ival: string);
begin
  Fq.FieldByName(Fvirt_id_name).AsString := ival;
end;

end.
