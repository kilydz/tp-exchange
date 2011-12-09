inherited fpoint_l0: Tfpoint_l0
  Left = 0
  Top = 0
  Caption = 'fpoint_l0'
  ClientHeight = 217
  ClientWidth = 592
  Font.Name = 'Tahoma'
  ExplicitWidth = 598
  ExplicitHeight = 241
  PixelsPerInch = 96
  TextHeight = 13
  inherited master: ZMaster
    Left = 8
    Height = 177
    ExplicitLeft = 8
    ExplicitHeight = 177
  end
  inherited p_pages: TPageControl
    Left = 136
    Height = 161
    ActivePage = TabSheet1
    ExplicitLeft = 136
    ExplicitHeight = 161
    object TabSheet1: TTabSheet
      Caption = #1050#1088#1072#1111#1085#1072
      object pStage0: TPanel
        Left = 16
        Top = 16
        Width = 361
        Height = 97
        TabOrder = 0
        object Label2: TLabel
          Left = 8
          Top = 24
          Width = 88
          Height = 13
          Caption = #1053#1072#1079#1074#1072' '#1082#1088#1072#1111#1085#1080' (24)'
        end
        object ed_name: TdxEdit
          Left = 107
          Top = 16
          Width = 232
          TabOrder = 0
          Text = 'ed_name'
          MaxLength = 20
          StyleController = scStyle
          StoredValues = 2
        end
      end
    end
  end
end
