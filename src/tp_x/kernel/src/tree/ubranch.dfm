inherited fbranch: Tfbranch
  Left = 240
  Top = 106
  Caption = 'fbranch'
  ClientHeight = 303
  ClientWidth = 518
  OldCreateOrder = True
  ExplicitWidth = 524
  ExplicitHeight = 327
  PixelsPerInch = 96
  TextHeight = 13
  inherited master: ZMaster
    Width = 405
    Height = 145
    ExplicitWidth = 405
    ExplicitHeight = 145
  end
  inherited p_pages: TPageControl
    Left = 24
    Top = 64
    ActivePage = TabSheet1
    ExplicitLeft = 24
    ExplicitTop = 64
    object TabSheet1: TTabSheet
      Caption = #1055#1072#1088#1072#1084#1077#1090#1088#1080' '#1075#1110#1083#1082#1080
      object Panel1: TPanel
        Left = 16
        Top = 16
        Width = 369
        Height = 177
        TabOrder = 0
        object Label3: TLabel
          Left = 8
          Top = 115
          Width = 50
          Height = 13
          Caption = #1050#1086#1076' '#1075#1088#1091#1087#1080
          Visible = False
        end
        object Label1: TLabel
          Left = 8
          Top = 24
          Width = 53
          Height = 13
          Caption = #1053#1072#1079#1074#1072' (40)'
        end
        object Label8: TLabel
          Left = 8
          Top = 51
          Width = 16
          Height = 13
          Caption = #1058#1052
          Visible = False
        end
        object ed_name: TdxEdit
          Left = 72
          Top = 16
          Width = 289
          TabOrder = 0
          Text = 'ed_name'
          OnKeyDown = EditsKeyDown
          OnKeyPress = EditsKeyPress
          OnKeyUp = EditsKeyUp
          MaxLength = 40
          StyleController = scStyle
          StoredValues = 2
        end
        object ed_code: TdxEdit
          Left = 72
          Top = 107
          Width = 289
          TabOrder = 1
          Text = 'ed_code'
          Visible = False
          MaxLength = 12
          StyleController = scStyle
          StoredValues = 2
        end
        object ed_maker: TdxImageEdit
          Left = 30
          Top = 43
          Width = 329
          TabOrder = 2
          Text = 'ed_maker'
          Visible = False
          StyleController = scStyle
          Descriptions.Strings = (
            #1053#1077' '#1086#1087#1086#1076#1072#1090#1082#1086#1074#1091#1108#1090#1100#1089#1103
            #1055#1044#1042' '#1074#1110#1076' '#1085#1072#1094#1110#1085#1082#1080' 20%'
            #1055#1044#1042' '#1074#1110#1076' '#1089#1091#1084#1080' 20%')
          ImageIndexes.Strings = (
            '0'
            '1'
            '2')
          Values.Strings = (
            '1'
            '2'
            '3')
        end
      end
    end
  end
end
