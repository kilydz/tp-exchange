object Form1: TForm1
  Left = 0
  Top = 0
  BorderStyle = bsSizeToolWin
  Caption = #1042#1080#1073#1110#1088' '#1084#1072#1075#1072#1079#1080#1085#1091
  ClientHeight = 239
  ClientWidth = 395
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  Position = poDesktopCenter
  OnShow = FormShow
  DesignSize = (
    395
    239)
  PixelsPerInch = 96
  TextHeight = 13
  object dxDBGrid1: TdxDBGrid
    Left = 0
    Top = 8
    Width = 394
    Height = 185
    Bands = <
      item
      end>
    DefaultLayout = True
    HeaderPanelRowCount = 1
    KeyField = 'OID'
    SummaryGroups = <>
    SummarySeparator = ', '
    PopupMenu = PopupMenu1
    TabOrder = 0
    OnDblClick = Button1Click
    DataSource = DataSource1
    Filter.Criteria = {00000000}
    LookAndFeel = lfFlat
    OptionsBehavior = [edgoAutoSort, edgoDragScroll, edgoImmediateEditor, edgoTabThrough, edgoVertThrough]
    OptionsView = [edgoBandHeaderWidth, edgoRowSelect, edgoUseBitmap]
    Anchors = [akLeft, akTop, akRight, akBottom]
    object dxDBGrid1OID: TdxDBGridMaskColumn
      Width = 39
      BandIndex = 0
      RowIndex = 0
      FieldName = 'OID'
    end
    object dxDBGrid1ONAME: TdxDBGridMaskColumn
      Width = 300
      BandIndex = 0
      RowIndex = 0
      FieldName = 'ONAME'
    end
  end
  object Button1: TButton
    Left = 176
    Top = 206
    Width = 100
    Height = 25
    Anchors = [akRight, akBottom]
    Caption = #1055#1088#1080#1081#1085#1103#1090#1080
    TabOrder = 1
    OnClick = Button1Click
  end
  object Button2: TButton
    Left = 288
    Top = 206
    Width = 100
    Height = 25
    Anchors = [akRight, akBottom]
    Caption = #1042#1110#1076#1084#1110#1085#1080#1090#1080
    TabOrder = 2
    OnClick = Button2Click
  end
  object IBDatabase1: TIBDatabase
    DatabaseName = '192.168.0.223:tp_svn'
    Params.Strings = (
      'user_name=sysdba'
      'password=masterkey'
      'lc_ctype=WIN1251')
    LoginPrompt = False
    DefaultTransaction = IBTransaction1
    TraceFlags = [tfQExecute, tfError, tfStmt, tfConnect, tfTransact, tfService, tfMisc]
    Left = 120
    Top = 104
  end
  object IBTransaction1: TIBTransaction
    DefaultDatabase = IBDatabase1
    Params.Strings = (
      'read_committed'
      'rec_version'
      'nowait'
      'read')
    Left = 168
    Top = 96
  end
  object IBQuery1: TIBQuery
    Database = IBDatabase1
    Transaction = IBTransaction1
    SQL.Strings = (
      'select CODE_DEALER as OID, NAME_DEALER as ONAME'
      '    from DEALER'
      ''
      '')
    Left = 208
    Top = 96
    object IBQuery1OID: TIntegerField
      DisplayLabel = 'ID'
      FieldName = 'OID'
      Origin = '"DEALER"."CODE_DEALER"'
      Required = True
    end
    object IBQuery1ONAME: TIBStringField
      DisplayLabel = #1053#1072#1079#1074#1072
      FieldName = 'ONAME'
      Origin = '"DEALER"."NAME_DEALER"'
      Size = 70
    end
  end
  object DataSource1: TDataSource
    AutoEdit = False
    DataSet = IBQuery1
    Left = 248
    Top = 96
  end
  object PopupMenu1: TPopupMenu
    Left = 296
    Top = 120
    object miRights: TMenuItem
      Caption = #1055#1088#1072#1074#1072' ...'
      OnClick = miRightsClick
    end
  end
end
