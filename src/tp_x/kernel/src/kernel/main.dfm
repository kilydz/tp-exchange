object fmain: Tfmain
  Left = 318
  Top = 219
  ClientHeight = 411
  ClientWidth = 794
  Color = clBtnFace
  DefaultMonitor = dmMainForm
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  Menu = MainMenu
  OldCreateOrder = False
  Position = poScreenCenter
  WindowState = wsMaximized
  OnCloseQuery = FormCloseQuery
  OnCreate = FormCreate
  OnDestroy = FormDestroy
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object splitterMain: TSplitter
    Left = 33
    Top = 0
    Height = 371
    Visible = False
    ExplicitLeft = 27
    ExplicitTop = -6
    ExplicitHeight = 351
  end
  object p_main: TPanel
    Left = 36
    Top = 0
    Width = 758
    Height = 371
    Align = alClient
    BevelOuter = bvNone
    TabOrder = 0
  end
  object StatusBar: TStatusBar
    Left = 0
    Top = 392
    Width = 794
    Height = 19
    Panels = <
      item
        Width = 200
      end
      item
        Width = 200
      end
      item
        Width = 200
      end>
  end
  object tab_set: TTabSet
    Left = 0
    Top = 371
    Width = 794
    Height = 21
    Align = alBottom
    Font.Charset = RUSSIAN_CHARSET
    Font.Color = clWindowText
    Font.Height = -13
    Font.Name = 'Times New Roman'
    Font.Style = [fsBold]
    SelectedColor = 10930928
    SoftTop = True
    Style = tsSoftTabs
    OnChange = tab_setChange
  end
  object SideBar_: TdxSideBar
    Left = 0
    Top = 0
    Width = 33
    Height = 371
    BkGround.BeginColor = clGrayText
    BkGround.EndColor = clGrayText
    BkGround.FillStyle = bfsNone
    CanSelected = False
    GroupFont.Charset = DEFAULT_CHARSET
    GroupFont.Color = clWindowText
    GroupFont.Height = -11
    GroupFont.Name = 'MS Sans Serif'
    GroupFont.Style = []
    Groups = <>
    ActiveGroupIndex = 0
    GroupHeightOffSet = 0
    ItemFont.Charset = DEFAULT_CHARSET
    ItemFont.Color = clWindow
    ItemFont.Height = -11
    ItemFont.Name = 'MS Sans Serif'
    ItemFont.Style = []
    LargeImages = LargeImagesForSideBar
    ScrollDelay = 300
    SpaceHeight = 7
    TransparentImages = False
    ShowGroups = True
    StoreInRegistry = False
    OnItemClick = SideBar_ItemClick
    Visible = False
  end
  object LargeImagesForSideBar: TImageList
    Height = 48
    Width = 48
    Left = 374
    Top = 284
  end
  object FormStorage: TFormStorage
    IniFileName = 'fmain'
    Options = [fpPosition]
    StoredProps.Strings = (
      'p_main.Width')
    StoredValues = <>
    Left = 343
    Top = 168
  end
  object base: TIBDatabase
    DatabaseName = 'D:\PC_Capital\Base\KRAJ.GDB'
    LoginPrompt = False
    DefaultTransaction = tr_default
    Left = 454
    Top = 284
  end
  object tr_default: TIBTransaction
    Left = 494
    Top = 284
  end
  object qr_R: TIBSQL
    Database = base
    Transaction = tr_default
    Left = 544
    Top = 304
  end
  object tray_menu: TPopupMenu
    Left = 408
    Top = 168
    object pmi_restore: TMenuItem
      Caption = #1042#1110#1076#1082#1088#1080#1090#1080
      Hint = #1042#1110#1076#1082#1088#1080#1090#1080' '#1087#1088#1086#1075#1088#1072#1084#1091
      OnClick = pmi_restoreClick
    end
    object N1: TMenuItem
      Caption = '-'
    end
    object pmi_exit: TMenuItem
      Caption = #1042#1080#1093#1110#1076
      Hint = #1042#1080#1093#1110#1076' '#1079' '#1087#1088#1086#1075#1088#1072#1084#1080
      OnClick = pmi_exitClick
    end
  end
  object MainMenu: TMainMenu
    Left = 304
    Top = 280
    object mi_exit: TMenuItem
      Caption = #1047#1072#1082#1088#1080#1090#1080
      OnClick = mi_exitClick
    end
  end
  object trR: TIBTransaction
    DefaultDatabase = base
    Params.Strings = (
      'read_committed'
      'rec_version'
      'nowait')
    Left = 488
    Top = 176
  end
  object qR: TIBSQL
    Database = base
    Transaction = trR
    Left = 528
    Top = 176
  end
  object trW: TIBTransaction
    DefaultDatabase = base
    Params.Strings = (
      'concurrency'
      'nowait')
    Left = 488
    Top = 208
  end
  object qW: TIBSQL
    Database = base
    Transaction = trW
    Left = 528
    Top = 208
  end
  object tray_icon: TTrayIcon
    PopupMenu = tray_menu
    OnDblClick = tray_iconDblClick
    Left = 376
    Top = 168
  end
end
