object ftree: Tftree
  Left = 185
  Top = 126
  Caption = 'ftree'
  ClientHeight = 349
  ClientWidth = 248
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  OnDestroy = FormDestroy
  PixelsPerInch = 96
  TextHeight = 13
  object panel: TPanel
    Left = 0
    Top = 0
    Width = 248
    Height = 349
    Align = alClient
    BevelOuter = bvNone
    BorderWidth = 1
    Caption = 'panel'
    Ctl3D = False
    DragKind = dkDock
    ParentCtl3D = False
    TabOrder = 0
    object ed_tree_list: TdxTreeList
      Left = 1
      Top = 1
      Width = 246
      Height = 315
      Bands = <
        item
        end>
      DefaultLayout = True
      HeaderPanelRowCount = 1
      Align = alClient
      Ctl3D = False
      ParentCtl3D = False
      TabOrder = 0
      LookAndFeel = lfUltraFlat
      Options = [aoColumnSizing, aoColumnMoving, aoTabThrough, aoRowSelect, aoMultiSelect, aoAutoWidth, aoExtMultiSelect, aoAutoSort]
      OptionsEx = [aoUseBitmap, aoBandHeaderWidth, aoAutoCalcPreviewLines, aoBandSizing, aoBandMoving, aoCellMultiSelect, aoDragScroll, aoDragExpand, aoMultiSort, aoAutoSortRefresh, aoAnsiSort, aoAutoSearch]
      TreeLineColor = clGrayText
      OnChangeNode = ed_tree_listChangeNode
      object trWColumn1: TdxTreeListColumn
        Caption = #1053#1072#1079#1074#1072
        Sorted = csUp
        Width = 187
        BandIndex = 0
        RowIndex = 0
      end
    end
    object Panel2: TPanel
      Left = 1
      Top = 316
      Width = 246
      Height = 32
      Align = alBottom
      TabOrder = 1
      object bt_ok: ZButton
        Left = 5
        Top = 3
        Width = 75
        Height = 25
        Caption = #1055#1088#1080#1081#1085#1103#1090#1080
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = 18
        Font.Name = 'Tahoma'
        Font.Style = []
        ParentFont = False
        TabOrder = 0
        OnClick = bt_okClick
      end
    end
  end
  object Base: TIBDatabase
    DatabaseName = '192.168.0.212:/BASE/SOFTWEST/W3.GDB'
    Params.Strings = (
      'user_name=sysdba'
      'password=panasdb')
    DefaultTransaction = tr
    Left = 40
    Top = 112
  end
  object tr: TIBTransaction
    DefaultDatabase = Base
    Params.Strings = (
      'read_committed'
      'rec_version'
      'nowait')
    Left = 72
    Top = 112
  end
  object q: TIBSQL
    Database = Base
    Transaction = tr
    Left = 112
    Top = 112
  end
  object PopupMenu1: TPopupMenu
    Left = 176
    Top = 8
  end
end
