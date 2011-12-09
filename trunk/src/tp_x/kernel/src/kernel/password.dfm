object fpassword: Tfpassword
  Left = 342
  Top = 443
  BorderStyle = bsToolWindow
  Caption = '  '#1040#1091#1090#1077#1085#1090#1080#1092#1110#1082#1072#1094#1110#1103
  ClientHeight = 153
  ClientWidth = 326
  Color = clWhite
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  Position = poDesktopCenter
  OnClose = FormClose
  OnCreate = FormCreate
  OnHide = FormHide
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object luser_name: TLabel
    Left = 16
    Top = 35
    Width = 33
    Height = 13
    Caption = #1051#1086#1075#1110#1085
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = [fsBold]
    ParentFont = False
  end
  object lpassword: TLabel
    Left = 16
    Top = 74
    Width = 49
    Height = 13
    Caption = #1055#1072#1088#1086#1083#1100':'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = [fsBold]
    ParentFont = False
  end
  object ed_base_way: TdxEdit
    Left = 16
    Top = 8
    Width = 241
    Color = clBtnFace
    TabOrder = 0
    TabStop = False
    Visible = False
  end
  object ed_user_name: TdxEdit
    Left = 71
    Top = 27
    Width = 121
    Style.BorderStyle = xbsFlat
    Style.ButtonStyle = btsDefault
    TabOrder = 1
    CharCase = ecUpperCase
  end
  object ed_password: TdxEdit
    Left = 71
    Top = 66
    Width = 121
    Style.BorderStyle = xbsFlat
    TabOrder = 2
    PasswordChar = '*'
  end
  object bt_ok: ZButton
    Left = 40
    Top = 114
    Width = 83
    Height = 25
    Caption = #1055#1088#1080#1081#1085#1103#1090#1080
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = 18
    Font.Name = 'Tahoma'
    Font.Style = []
    ModalResult = 1
    ParentFont = False
    TabOrder = 3
    OnClick = bokClick
  end
  object ZButton1: ZButton
    Left = 190
    Top = 114
    Width = 81
    Height = 25
    Caption = #1047#1072#1082#1088#1080#1090#1080
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = 18
    Font.Name = 'Tahoma'
    Font.Style = []
    ModalResult = 2
    ParentFont = False
    TabOrder = 4
  end
  object l_anime: TAnimate
    Left = 198
    Top = 17
    Width = 120
    Height = 70
    StopFrame = 20
  end
end
