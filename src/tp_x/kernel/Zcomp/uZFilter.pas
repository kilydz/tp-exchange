unit uZFilter;

interface

uses
  Windows, Messages, SysUtils, Classes, Controls, StdCtrls, DB, math,
  dxEdLib, dxDBGrid, dxCntner, Dialogs, Buttons, Graphics;

type
  TFilterType = (ftNone, ftText, ftInt, ftFloat);
  TFilterFinishEvent = procedure (Sender: TObject) of object;

  ZFilterResult = class(TObject)
  private
    current_field: TField;
    filter_type: TFilterType;
    filter_parent: TWinControl;

    filter_finish_event: TFilterFinishEvent;

    function GetDefaultFilter: string; virtual;
    procedure KeyDown(Sender: TObject; var Key: Word;
                                 Shift: TShiftState);
  public
    constructor Create(AParent: TWinControl); virtual;
    destructor Destroy; override;
    procedure SetFocus; virtual;

    property DefaultFilter: string read GetDefaultFilter;
    property FilterType: TFilterType read filter_type write filter_type;
    property Parent: TWinControl read filter_parent write filter_parent;
    property Field: TField read current_field write current_field;

    property OnFilterFinish: TFilterFinishEvent
                read filter_finish_event write filter_finish_event;
  end;

//------------------
  ZFilterResultText = class(ZFilterResult)
  private
    ed_text: TdxEdit;

    function GetDefaultFilter: string; override;
    procedure KeyPress(Sender: TObject; var Key: Char);
  public
    constructor Create(AParent: TWinControl); override;
    destructor Destroy; override;
    procedure SetFocus; override;
    function GetText: string;

    property DefaultFilter;
    property FilterType;

    procedure SetFirstChar(var key: char);
  end;

//------------------
  ZFilterResultFloat = class(ZFilterResult)
  private
    ed_border0: TdxCalcEdit;
    ed_border1: TdxCalcEdit;
    caption0, caption1: TLabel;
    procedure KeyPress(Sender: TObject; var Key: Char);
    function GetDefaultFilter: string; override;
  public
    constructor Create(AParent: TWinControl); override;
    destructor Destroy; override;
    procedure SetFocus; override;
    function GetBorderMin: real;
    function GetBorderMax: real;

    property DefaultFilter;
    property FilterType;
  end;

//------------------
  ZFilterResultInt = class(ZFilterResult)
  private
    ed_border0: TdxSpinEdit;
    ed_border1: TdxSpinEdit;
    caption0, caption1: TLabel;
    procedure KeyPress(Sender: TObject; var Key: Char);
    function GetDefaultFilter: string; override;
  public
    constructor Create(AParent: TWinControl); override;
    destructor Destroy; override;
    procedure SetFocus; override;
    function GetBorderMin: integer;
    function GetBorderMax: integer;

    property DefaultFilter;
    property FilterType;
  end;

//------------------
  ZFilterResultTime = class(ZFilterResult)
  private
    border0: string;
    border1: string;
    ed_border0: TdxTimeEdit;
    ed_border1: TdxTimeEdit;
    caption0, caption1: TLabel;
    procedure KeyPress(Sender: TObject; var Key: Char);
    function ToStr(var ed_border: TdxTimeEdit): string;
    function GetDefaultFilter: string; override;
  public
    constructor Create(AParent: TWinControl); override;
    destructor Destroy; override;
    procedure SetFocus; override;
    function GetBorderMin: string;
    function GetBorderMax: string;

    property DefaultFilter;
    property FilterType;
  end;

//------------------
  TFilterResultEvent = procedure (Sender: TObject; Result: ZFilterResult) of object;

  ZFilter = class(TWinControl)
  private
    { Private declarations }
    exit_bmp: TBitmap;
    caption: TLabel;
    bt_exit: TSpeedButton;
    result: ZFilterResult;

    filter_result_event: TFilterResultEvent;
    grid: TdxDBGrid;
    field: TField;

    procedure FilterFinishEvent(Sender: TObject);
    procedure bt_exitClick(Sender: TObject);
  protected
    { Protected declarations }
  public
    { Public declarations }
    constructor Create(AOwner:TComponent); override;
    destructor Destroy; override;

    procedure ShowFilter(key: char);
    function GetFieldName: string;
    procedure ExitFromFilter;
  published
    { Published declarations }
    property FilteredGrid: TdxDBGrid read grid write grid;
    property OnFilterResult: TFilterResultEvent
                read filter_result_event write filter_result_event;
  end;

procedure Register;
{$R ZFilter.res}

implementation

const CALC_WARNING = 'Не можна фільтрувати по обчислюваному полю. Зверніться до розробників.';

procedure Register;
begin
  RegisterComponents('Freedom', [ZFilter]);
end;

///////////////////////////////////
constructor ZFilterResult.Create(AParent: TWinControl);
begin
  filter_type := ftNone;
  filter_parent := AParent;
end;

destructor ZFilterResult.Destroy;
begin
end;

procedure ZFilterResult.SetFocus;
begin
end;

function ZFilterResult.GetDefaultFilter: string;
begin
  if current_field = nil then
    GetDefaultFilter := '';
end;

procedure ZFilterResult.KeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
var filter: ZFilter;
begin
  if key = 27 then
  begin
    filter := ZFilter(filter_parent);
    filter.ExitFromFilter;
  end;
end;
//////////////////////////////
constructor ZFilterResultText.Create(AParent: TWinControl);
begin
  inherited Create(AParent);
  filter_type := ftText;
  ed_text := TdxEdit.Create(AParent);
  ed_text.Parent := filter_parent;
  ed_text.Top := 3;
  ed_text.Left := 200;
  ed_text.Width := 200;
  ed_text.Style.BorderStyle := xbsSingle;
  ed_text.Style.ButtonStyle := btsFlat;
  ed_text.OnKeyPress := KeyPress;
  ed_text.OnKeyDown := KeyDown;
end;

destructor ZFilterResultText.Destroy;
begin
  inherited Destroy;
  ed_text.Free;
end;

procedure ZFilterResultText.SetFocus;
begin
  inherited SetFocus;
  ed_text.SetFocus;
end;

function ZFilterResultText.GetText: string;
var text: string;
    i: integer;
begin
  text := AnsiUpperCase(ed_text.Text);
  for i := 1 to StrLen(PChar(text)) do
    if text[i] = ' ' then
      text[i] := '%';
  GetText := text;
end;

procedure ZFilterResultText.KeyPress(Sender: TObject; var Key: Char);
begin
  if key = #13 then
    if @filter_finish_event <> nil then
      filter_finish_event(Self);
  if key = #39 then
    key := '"';
end;

function ZFilterResultText.GetDefaultFilter: string;
begin
  GetDefaultFilter := '';
  if current_field = nil then
    exit;

  if (Field.FieldKind = fkCalculated) then
  begin
    ShowMessage(CALC_WARNING);
    exit;
  end;

  GetDefaultFilter := 'where upper(' +
                              current_field.FieldName + ' collate WIN1251_UA) like ' +
                                     #39 + '%' + GetText + '%' + #39;
end;

procedure ZFilterResultText.SetFirstChar(var key: char);
begin
  ed_text.Text := key;
  SendMessage(ed_text.Handle, WM_KEYDOWN, VK_END, 78);
end;

//////////////////////////////
constructor ZFilterResultFloat.Create(AParent: TWinControl);
begin
  inherited Create(AParent);
  filter_type := ftFloat;

  caption0 := TLabel.Create(filter_parent);
  caption0.Parent := filter_parent;
  caption0.Caption := 'більше';
  caption0.Top := 5;
  caption0.Left := 200;

  ed_border0 := TdxCalcEdit.Create(filter_parent);
  ed_border0.Parent := filter_parent;
  ed_border0.Style.BorderStyle := xbsSingle;
  ed_border0.Style.ButtonStyle := btsFlat;
  ed_border0.Top := 3;
  ed_border0.Left := 250;
  ed_border0.Width := 100;
  ed_border0.OnKeyPress := KeyPress;
  ed_border0.OnKeyDown := KeyDown;

  caption1 := TLabel.Create(filter_parent);
  caption1.Parent := filter_parent;
  caption1.Caption := 'менше';
  caption1.Top := 5;
  caption1.Left := 355;

  ed_border1 := TdxCalcEdit.Create(filter_parent);
  ed_border1.Parent := filter_parent;
  ed_border1.Style.BorderStyle := xbsSingle;
  ed_border1.Style.ButtonStyle := btsFlat;
  ed_border1.Top := 3;
  ed_border1.Left := 400;
  ed_border1.Width := 100;
  ed_border1.OnKeyPress := KeyPress;
  ed_border1.OnKeyDown := KeyDown;
end;

destructor ZFilterResultFloat.Destroy;
begin
  inherited Destroy;
  caption0.Free;
  ed_border0.Free;
  caption1.Free;
  ed_border1.Free;
end;

procedure ZFilterResultFloat.SetFocus;
begin
  inherited SetFocus;
  ed_border0.SetFocus;
end;

function ZFilterResultFloat.GetBorderMin: real;
begin
  GetBorderMin := Min(StrToFloat(ed_border0.Text), StrToFloat(ed_border1.Text));
end;

function ZFilterResultFloat.GetBorderMax: real;
begin
  GetBorderMax := Max(StrToFloat(ed_border0.Text), StrToFloat(ed_border1.Text));
end;

procedure ZFilterResultFloat.KeyPress(Sender: TObject; var Key: Char);
begin
  if key = #13 then
    if Sender = ed_border0 then
      ed_border1.SetFocus
    else if Sender = ed_border1 then
      if @filter_finish_event <> nil then
        filter_finish_event(Self);

  if (key = '.') then
    key := ','
  else if ((key < '0') or (key > '9')) and
           (key <> '-') then
    key := #0;
end;

function ZFilterResultFloat.GetDefaultFilter: string;
begin
  GetDefaultFilter := '';
  if current_field = nil then
    exit;

  if Field.FieldKind = fkCalculated	then
  begin
    ShowMessage(CALC_WARNING);
    exit;
  end;

  GetDefaultFilter := ' where ' + current_field.FieldName +
                         ' between ' + FloatToStr(GetBorderMin) +
                         ' and ' + FloatToStr(GetBorderMax);
end;

//////////////////////////////
constructor ZFilterResultInt.Create(AParent: TWinControl);
begin
  inherited Create(AParent);
  filter_type := ftInt;

  caption0 := TLabel.Create(filter_parent);
  caption0.Parent := filter_parent;
  caption0.Caption := 'більше';
  caption0.Top := 5;
  caption0.Left := 200;

  ed_border0 := TdxSpinEdit.Create(filter_parent);
  ed_border0.Parent := filter_parent;
  ed_border0.Style.BorderStyle := xbsSingle;
  ed_border0.Style.ButtonStyle := btsFlat;
  ed_border0.Top := 3;
  ed_border0.Left := 250;
  ed_border0.Width := 100;
  ed_border0.OnKeyPress := KeyPress;
  ed_border0.OnKeyDown := KeyDown;

  caption1 := TLabel.Create(filter_parent);
  caption1.Parent := filter_parent;
  caption1.Caption := 'менше';
  caption1.Top := 5;
  caption1.Left := 355;

  ed_border1 := TdxSpinEdit.Create(filter_parent);
  ed_border1.Style.BorderStyle := xbsSingle;
  ed_border1.Style.ButtonStyle := btsFlat;
  ed_border1.Parent := filter_parent;
  ed_border1.Top := 3;
  ed_border1.Left := 400;
  ed_border1.Width := 100;
  ed_border1.OnKeyPress := KeyPress;
  ed_border1.OnKeyDown := KeyDown;
end;

destructor ZFilterResultInt.Destroy;
begin
  inherited Destroy;
  caption0.Free;
  ed_border0.Free;
  caption1.Free;
  ed_border1.Free;
end;

procedure ZFilterResultInt.SetFocus;
begin
  inherited SetFocus;
  ed_border0.SetFocus;
end;

function ZFilterResultInt.GetBorderMin: integer;
begin
  GetBorderMin := Min(StrToInt(ed_border0.Text), StrToInt(ed_border1.Text));
end;

function ZFilterResultInt.GetBorderMax: integer;
begin
  GetBorderMax := Max(StrToInt(ed_border0.Text), StrToInt(ed_border1.Text));
end;

procedure ZFilterResultInt.KeyPress(Sender: TObject; var Key: Char);
begin
  if key = #13 then
    if Sender = ed_border0 then
      ed_border1.SetFocus
    else if Sender = ed_border1 then
      if @filter_finish_event <> nil then
        filter_finish_event(Self);

    if ((key < '0') or (key > '9')) and
           (key <> '-') then
    key := #0;
end;

function ZFilterResultInt.GetDefaultFilter: string;
begin
  GetDefaultFilter := '';
  if current_field = nil then
    exit;

  if Field.FieldKind = fkCalculated	then
  begin
    ShowMessage(CALC_WARNING);
    exit;
  end;

  GetDefaultFilter := ' where ' + current_field.FieldName +
                       ' between ' + IntToStr(GetBorderMin) +
                       ' and ' + IntToStr(GetBorderMax);
end;

//////////////////////////////
constructor ZFilterResultTime.Create(AParent: TWinControl);
begin
  inherited Create(AParent);
  filter_type := ftInt;

  caption0 := TLabel.Create(filter_parent);
  caption0.Parent := filter_parent;
  caption0.Caption := 'більше';
  caption0.Top := 5;
  caption0.Left := 200;

  ed_border0 := TdxTimeEdit.Create(filter_parent);
  ed_border0.Parent := filter_parent;
  ed_border0.Style.BorderStyle := xbsSingle;
  ed_border0.Style.ButtonStyle := btsFlat;
  ed_border0.Top := 3;
  ed_border0.Left := 250;
  ed_border0.Width := 100;
  ed_border0.OnKeyPress := KeyPress;
  ed_border0.OnKeyDown := KeyDown;

  caption1 := TLabel.Create(filter_parent);
  caption1.Parent := filter_parent;
  caption1.Caption := 'менше';
  caption1.Top := 5;
  caption1.Left := 355;

  ed_border1 := TdxTimeEdit.Create(filter_parent);
  ed_border1.Style.BorderStyle := xbsSingle;
  ed_border1.Style.ButtonStyle := btsFlat;
  ed_border1.Parent := filter_parent;
  ed_border1.Top := 3;
  ed_border1.Left := 400;
  ed_border1.Width := 100;
  ed_border1.OnKeyPress := KeyPress;
  ed_border1.OnKeyDown := KeyDown;
end;

destructor ZFilterResultTime.Destroy;
begin
  inherited Destroy;
  caption0.Free;
  ed_border0.Free;
  caption1.Free;
  ed_border1.Free;
end;

procedure ZFilterResultTime.SetFocus;
begin
  inherited SetFocus;
  ed_border0.SetFocus;
end;

function ZFilterResultTime.GetBorderMin: string;
begin
  if (ed_border0.Text < ed_border1.Text) then
    GetBorderMin := border0
  else
    GetBorderMin := border1;
end;

function ZFilterResultTime.GetBorderMax: string;
begin
  if (ed_border0.Text < ed_border1.Text) then
    GetBorderMax := border1
  else
    GetBorderMax := border0;
end;

procedure ZFilterResultTime.KeyPress(Sender: TObject; var Key: Char);
begin
  if key = #13 then
  begin
    if Sender = ed_border0 then
    begin
      border0 := ToStr(ed_border0);
      ed_border1.SetFocus
    end
    else if Sender = ed_border1 then
    begin
      border1 := ToStr(ed_border1);
      if @filter_finish_event <> nil then
        filter_finish_event(Self);
    end
  end;

    if ((key < '0') or (key > '9')) and
           (key <> ':') then
    key := #0;
end;

function ZFilterResultTime.ToStr(var ed_border: TdxTimeEdit): string;
var i: integer;
    len: integer;
    temp: string;
begin
  temp := ed_border.Text;
  len := length(temp);

  for i := 1 to len do
  begin
    if temp[i] =' ' then
      temp[i] := '0';
  end;
  ToStr := temp;
end;

function ZFilterResultTime.GetDefaultFilter: string;
begin
  GetDefaultFilter := '';
  if current_field = nil then
    exit;

  if Field.FieldKind = fkCalculated	then
  begin
    ShowMessage(CALC_WARNING);
    exit;
  end;

  GetDefaultFilter := ' where ' + current_field.FieldName +
                       ' between ' + #39 + GetBorderMin + #39 +
                       ' and ' + #39 + GetBorderMax + #39;
end;

//////////////////////////////
constructor ZFilter.Create(AOwner:TComponent);
begin
  inherited Create(AOwner);
  Height := 25;
  Align := alBottom;
  Visible := false;

  exit_bmp := TBitmap.Create;
  exit_bmp.Handle := LoadBitmap(hInstance, 'ZEXIT');

  bt_exit := TSpeedButton.Create(Self);
  bt_exit.Parent := Self;
  bt_exit.Top := 5;
  bt_exit.Left := 3;
  bt_exit.Height := 16;
  bt_exit.Width := 16;
  bt_exit.Flat := true;
  bt_exit.Glyph := exit_bmp;
  bt_exit.ShowHint := true;
  bt_exit.Hint := 'Зняти фільтр (Esc)';
  bt_exit.OnClick := bt_exitClick;

  caption := TLabel.Create(Self);
  caption.Parent := Self;
  caption.AutoSize := true;
  caption.Top := 5;
  caption.Left := 22;
end;

destructor ZFilter.Destroy;
begin
  inherited Destroy;
  exit_bmp.Free;
end;

procedure ZFilter.ShowFilter(key: char);
var new_field: TField;
    class_name: string;
begin
  if (grid = nil) or (key = #27) then exit;

  new_field := grid.Columns[grid.GetAbsoluteColumnIndex(grid.FocusedColumn)].Field;
  caption.Caption := Format('Фільтр по полю %s:',
              [grid.Columns[grid.GetAbsoluteColumnIndex(grid.FocusedColumn)].Caption]);
  class_name := new_field.ClassName;

  if class_name = 'TIBStringField' then
  begin
    if field <> new_field then
    begin
      if result <> nil then
        result.Free;
      result := ZFilterResultText.Create(Self);
      result.current_field := new_field;
      result.OnFilterFinish := FilterFinishEvent;
    end;
    Visible := true;
    result.SetFocus;
    ZFilterResultText(result).SetFirstChar(key);
    field := new_field;
  end
  else if ((new_field.ClassName = 'TFloatField') or
           (new_field.ClassName = 'TCurrencyField'))then
  begin
    if field <> new_field then
    begin
      if result <> nil then
        result.Free;
      result := ZFilterResultFloat.Create(Self);
      result.current_field := new_field;
      result.OnFilterFinish := FilterFinishEvent;
    end;
    Visible := true;
    result.SetFocus;
    field := new_field;
  end
  else if ((class_name = 'TIntegerField') or
           (class_name = 'TSmallintField') or
           (class_name = 'TLargeintField')) then
  begin
    if field <> new_field then
    begin
      if result <> nil then
        result.Free;
      result := ZFilterResultInt.Create(Self);
      result.current_field := new_field;
      result.OnFilterFinish := FilterFinishEvent;
    end;
    Visible := true;
    result.SetFocus;
    field := new_field;
  end
  else if (class_name = 'TTimeField') then
  begin
    if field <> new_field then
    begin
      if result <> nil then
        result.Free;
      result := ZFilterResultTime.Create(Self);
      result.current_field := new_field;
      result.OnFilterFinish := FilterFinishEvent;
    end;
    Visible := true;
    result.SetFocus;
    field := new_field;
  end;

end;

procedure ZFilter.FilterFinishEvent(Sender: TObject);
begin
  if grid = nil then exit;

  if field = nil then
  begin
    if result = nil then
      result := ZFilterResult.Create(Self);
    result.current_field := nil;
    result.OnFilterFinish := FilterFinishEvent;
    Visible := false;
  end;

  if @filter_result_event <> nil then
  begin
    filter_result_event(Self, result);
    grid.SetFocus;
  end
end;

procedure ZFilter.bt_exitClick(Sender: TObject);
begin
  ExitFromFilter;
end;

procedure ZFilter.ExitFromFilter;
begin
  field := nil;
  FilterFinishEvent(nil);
end;

function ZFilter.GetFieldName: string;
begin
  if field = nil then
    GetFieldName := ''
  else
    GetFieldName := field.FieldName;
end;

end.
