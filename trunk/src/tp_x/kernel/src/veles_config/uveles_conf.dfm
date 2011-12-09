object fveles_conf: Tfveles_conf
  Left = 159
  Top = 114
  Caption = #1050#1086#1085#1092#1110#1075#1091#1088#1072#1090#1086#1088' '#1103#1076#1088#1072
  ClientHeight = 287
  ClientWidth = 806
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
  object pStage0: TPanel
    Left = 424
    Top = 48
    Width = 369
    Height = 177
    TabOrder = 0
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
      Top = 87
      Width = 84
      Height = 13
      Caption = #1055#1072#1088#1086#1083#1100' SYSDBA'
    end
    object Label5: TLabel
      Left = 16
      Top = 119
      Width = 118
      Height = 13
      Caption = #1055#1110#1076#1090#1074#1077#1088#1076#1078#1077#1085#1085#1103' '#1087#1072#1088#1086#1083#1102
    end
    object ed_ServerIP: TdxEdit
      Left = 80
      Top = 16
      Width = 137
      TabOrder = 0
      Text = 'ed_ServerIP'
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
      Text = 'ed_BaseWay'
      OnKeyDown = EditsKeyDown
      OnKeyPress = EditsKeyPress
      OnKeyUp = EditsKeyUp
      StyleController = dxEditStyleController
    end
    object ed_SYSDBAPassword: TdxEdit
      Left = 152
      Top = 79
      Width = 169
      TabOrder = 2
      Text = 'ed_SYSDBAPassword'
      OnKeyDown = EditsKeyDown
      OnKeyPress = EditsKeyPress
      OnKeyUp = EditsKeyUp
      PasswordChar = '*'
      StyleController = dxEditStyleController
    end
    object ed_SYSDBAPassword_confirm: TdxEdit
      Left = 152
      Top = 111
      Width = 169
      TabOrder = 3
      Text = 'ed_SYSDBAPassword_confirm'
      OnKeyDown = EditsKeyDown
      OnKeyPress = EditsKeyPress
      OnKeyUp = EditsKeyUp
      PasswordChar = '*'
      StyleController = dxEditStyleController
    end
  end
  object master: ZMaster
    Left = 0
    Top = 0
    Width = 409
    Height = 273
    OnMasterResult = masterMasterResult
  end
  object dxEditStyleController: TdxEditStyleController
    BorderStyle = xbsFlat
    ButtonStyle = btsHotFlat
    ButtonTransparence = ebtInactive
    Left = 344
    Top = 56
  end
end
