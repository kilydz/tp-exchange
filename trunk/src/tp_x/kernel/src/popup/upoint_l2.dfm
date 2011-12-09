inherited fpoint_l2: Tfpoint_l2
  Left = 0
  Top = 0
  Caption = 'fpoint_l2'
  ClientHeight = 211
  ClientWidth = 681
  Font.Name = 'Tahoma'
  ExplicitWidth = 687
  ExplicitHeight = 235
  PixelsPerInch = 96
  TextHeight = 13
  inherited master: ZMaster
    Height = 161
    ExplicitHeight = 161
  end
  inherited p_pages: TPageControl
    Left = 224
    Top = 7
    Height = 178
    ActivePage = TabSheet1
    ExplicitLeft = 224
    ExplicitTop = 7
    ExplicitHeight = 178
    object TabSheet1: TTabSheet
      Caption = #1056#1072#1081#1086#1085
      object pStage0: TPanel
        Left = 16
        Top = 16
        Width = 361
        Height = 97
        TabOrder = 0
        object Label2: TLabel
          Left = 8
          Top = 24
          Width = 92
          Height = 13
          Caption = #1053#1072#1079#1074#1072' '#1088#1072#1081#1086#1085#1091' (32)'
        end
        object ed_name: TdxEdit
          Left = 107
          Top = 16
          Width = 232
          TabOrder = 0
          Text = 'ed_name'
          OnKeyDown = EditsKeyDown
          OnKeyPress = EditsKeyPress
          OnKeyUp = EditsKeyUp
          MaxLength = 32
          StyleController = scStyle
          StoredValues = 2
        end
      end
    end
  end
end
