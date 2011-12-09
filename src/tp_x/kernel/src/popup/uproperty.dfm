inherited fproperty: Tfproperty
  Left = 0
  Top = 0
  Caption = 'fproperty'
  ClientHeight = 250
  ClientWidth = 647
  Font.Name = 'Tahoma'
  ExplicitWidth = 653
  ExplicitHeight = 274
  PixelsPerInch = 96
  TextHeight = 13
  inherited master: ZMaster
    Height = 185
    ExplicitHeight = 185
  end
  inherited p_pages: TPageControl
    Left = 232
    Width = 393
    ActivePage = TabSheet1
    ExplicitLeft = 232
    ExplicitWidth = 393
    object TabSheet1: TTabSheet
      Caption = #1054#1089#1085#1086#1074#1085#1110
      object Panel1: TPanel
        Left = 24
        Top = 16
        Width = 358
        Height = 169
        TabOrder = 0
        object Label2: TLabel
          Left = 8
          Top = 24
          Width = 59
          Height = 13
          Caption = #1053#1072#1079#1074#1072' (100)'
        end
        object Label1: TLabel
          Left = 8
          Top = 56
          Width = 84
          Height = 13
          Caption = #1057#1082#1086#1088#1086#1095#1077#1085#1085#1103' (10)'
        end
        object ed_name: TdxEdit
          Left = 73
          Top = 16
          Width = 266
          TabOrder = 0
          Text = 'ed_name'
          OnKeyDown = EditsKeyDown
          OnKeyPress = EditsKeyPress
          OnKeyUp = EditsKeyUp
          MaxLength = 100
          StyleController = scStyle
          StoredValues = 2
        end
        object ed_short_name: TdxEdit
          Left = 98
          Top = 48
          Width = 95
          TabOrder = 1
          Text = 'ed_short_name'
          OnKeyDown = EditsKeyDown
          OnKeyPress = EditsKeyPress
          OnKeyUp = EditsKeyUp
          MaxLength = 10
          StyleController = scStyle
          StoredValues = 2
        end
      end
    end
  end
end
