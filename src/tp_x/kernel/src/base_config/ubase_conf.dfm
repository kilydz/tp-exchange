object fveles_conf: Tfveles_conf
  Left = 159
  Top = 114
  Caption = #1043#1077#1085#1077#1088#1072#1094#1110#1103' '#1073#1072#1079#1080' '#1076#1072#1085#1080#1093
  ClientHeight = 287
  ClientWidth = 458
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  OnCreate = FormCreate
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object master: ZMaster
    Left = 0
    Top = 0
    Width = 409
    Height = 257
    OnMasterResult = masterMasterResult
  end
  object pStage0: TPanel
    Left = 81
    Top = 38
    Width = 369
    Height = 179
    TabOrder = 1
    object Label1: TLabel
      Left = 16
      Top = 24
      Width = 49
      Height = 13
      Caption = 'IP-'#1072#1076#1088#1077#1089#1072
    end
    object Label2: TLabel
      Left = 16
      Top = 56
      Width = 16
      Height = 13
      Caption = #1041#1044
    end
    object Label4: TLabel
      Left = 16
      Top = 88
      Width = 84
      Height = 13
      Caption = #1055#1072#1088#1086#1083#1100' SYSDBA'
    end
    object Label3: TLabel
      Left = 16
      Top = 117
      Width = 247
      Height = 13
      Caption = #1055#1088#1086#1094#1077#1089' '#1084#1086#1078#1077' '#1090#1088#1080#1074#1072#1090#1080' '#1082#1110#1083#1100#1082#1072' '#1093#1074#1080#1083#1080#1085'. '#1047#1072#1095#1077#1082#1072#1081#1090#1077'.'
      Visible = False
    end
    object l_progress: TLabel
      Left = 16
      Top = 133
      Width = 247
      Height = 13
      Caption = #1055#1088#1086#1094#1077#1089' '#1084#1086#1078#1077' '#1090#1088#1080#1074#1072#1090#1080' '#1082#1110#1083#1100#1082#1072' '#1093#1074#1080#1083#1080#1085'. '#1047#1072#1095#1077#1082#1072#1081#1090#1077'.'
      Visible = False
    end
    object ed_ServerIP: TdxEdit
      Left = 80
      Top = 16
      Width = 137
      TabOrder = 0
      Text = '127.0.0.1'
      OnKeyDown = EditsKeyDown
      OnKeyPress = EditsKeyPress
      OnKeyUp = EditsKeyUp
      StyleController = dxEditStyleController
    end
    object ed_BaseWay: TdxEdit
      Left = 80
      Top = 48
      Width = 273
      TabOrder = 1
      Text = 'D:\BASE\SHOP.GDB'
      OnKeyDown = EditsKeyDown
      OnKeyPress = EditsKeyPress
      OnKeyUp = EditsKeyUp
      StyleController = dxEditStyleController
    end
    object ed_SYSDBAPassword: TdxEdit
      Left = 106
      Top = 80
      Width = 247
      TabOrder = 2
      Text = 'masterkey'
      OnKeyDown = EditsKeyDown
      OnKeyPress = EditsKeyPress
      OnKeyUp = EditsKeyUp
      StyleController = dxEditStyleController
    end
    object l_process: TAnimate
      Left = 16
      Top = 152
      Width = 178
      Height = 16
      FileName = 'X:\kernel\src\base_config\process.avi'
      StopFrame = 100
      Visible = False
    end
  end
  object dxEditStyleController: TdxEditStyleController
    BorderStyle = xbsFlat
    ButtonStyle = btsHotFlat
    ButtonTransparence = ebtInactive
    Left = 344
    Top = 56
  end
  object base: TIBDatabase
    LoginPrompt = False
    Left = 24
    Top = 120
  end
end
