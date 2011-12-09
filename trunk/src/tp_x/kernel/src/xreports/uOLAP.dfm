object fOLAP: TfOLAP
  Left = 0
  Top = 0
  Caption = 'OLAP '#1092#1086#1088#1084#1072#1090
  ClientHeight = 369
  ClientWidth = 684
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  WindowState = wsMaximized
  OnDestroy = FormDestroy
  PixelsPerInch = 96
  TextHeight = 13
  object ZToolBar1: ZToolBar
    Left = 0
    Top = 0
    Width = 684
    Height = 22
    AutoSize = True
    Caption = 'XToolBar1'
    EdgeInner = esNone
    EdgeOuter = esNone
    TabOrder = 0
    object bt_print: TToolButton
      Left = 0
      Top = 0
      Caption = 'bt_print'
      ImageIndex = 0
      OnClick = ToolButtonClick
    end
    object bt_total_sum: TToolButton
      Left = 23
      Top = 0
      Hint = #1047#1072#1075#1072#1083#1100#1085#1110' '#1089#1091#1084#1080
      Caption = 'bt_total_sum'
      Down = True
      ImageIndex = 1
      Style = tbsCheck
      OnClick = ToolButtonClick
    end
  end
  object base: TIBDatabase
    DefaultTransaction = tr_dic
    Left = 40
    Top = 160
  end
  object q_dic: TIBQuery
    Database = base
    Transaction = tr_dic
    Left = 80
    Top = 160
  end
  object tr_dic: TIBTransaction
    DefaultDatabase = base
    Params.Strings = (
      'read'
      'read_committed'
      'rec_version'
      'nowait')
    AutoStopAction = saCommit
    Left = 112
    Top = 160
  end
  object tr: TIBTransaction
    DefaultDatabase = base
    Left = 112
    Top = 208
  end
  object q: TIBSQL
    Database = base
    Transaction = tr
    Left = 80
    Top = 208
  end
  object ds_dic: TDataSource
    DataSet = q_dic
    Left = 176
    Top = 160
  end
  object pr_print_style_mgr: TdxPrintStyleManager
    AutoHFTextEntries.Strings = (
      ', -[Page #]- ,'
      '[User Name], Page [Page #], [Date Printed]'
      'Confidential, Page [Page #], [Date Printed]'
      'Created By [User Name]'
      'Created On [Date & Time Printed]'
      'Printed By [User Name]'
      'Printed On [Date & Time Printed]'
      'Last Printed [Date & Time Printed]'
      'Page [Page # of Pages #]')
    HelpContext = 0
    PageSetupDialog = pr_page_setup
    Version = 0
    Left = 176
    Top = 232
  end
  object pr_component: TdxComponentPrinter
    Version = 0
    Left = 216
    Top = 232
  end
  object pr_dialog: TdxPrintDialog
    HelpContext = 0
    StyleManager = pr_print_style_mgr
    Left = 256
    Top = 232
  end
  object pr_page_setup: TdxPageSetupDialog
    ActivePageIndex = 0
    HelpContext = 0
    ButtonsVisible = [psbStyleOptions]
    Left = 304
    Top = 232
  end
  object pr_engine: TdxPSEngineController
    Left = 344
    Top = 232
  end
end
