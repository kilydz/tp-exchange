inherited fbarcode: Tfbarcode
  Left = 189
  Top = 274
  Caption = 'fbarcode'
  ClientWidth = 775
  OldCreateOrder = True
  ExplicitWidth = 781
  ExplicitHeight = 285
  PixelsPerInch = 96
  TextHeight = 13
  inherited p_pages: TPageControl
    Left = 368
    Width = 393
    ActivePage = TabSheet1
    TabOrder = 0
    ExplicitLeft = 368
    ExplicitWidth = 393
    object TabSheet1: TTabSheet
      Caption = #1054#1089#1085#1086#1074#1085#1110
      object pStage0: TPanel
        Left = 8
        Top = 16
        Width = 361
        Height = 145
        TabOrder = 0
        object Label1: TLabel
          Left = 8
          Top = 56
          Width = 76
          Height = 13
          Caption = #1058#1080#1087' '#1096#1090#1088#1080#1093#1082#1086#1076#1072
          Visible = False
        end
        object Label2: TLabel
          Left = 8
          Top = 24
          Width = 70
          Height = 13
          Caption = #1064#1090#1088#1080#1093#1082#1086#1076' (14)'
        end
        object Label3: TLabel
          Left = 8
          Top = 88
          Width = 22
          Height = 13
          Caption = #1062#1110#1085#1072
          Visible = False
        end
        object ed_barcode: TdxEdit
          Left = 88
          Top = 16
          Width = 161
          TabOrder = 0
          Text = 'ed_barcode'
          OnKeyPress = EditsKeyPress
          MaxLength = 14
          StyleController = scStyle
          StoredValues = 2
        end
        object ed_barcode_type: TdxImageEdit
          Left = 88
          Top = 48
          Width = 185
          TabOrder = 1
          Text = 'ed_barcode_type'
          Visible = False
          OnKeyPress = EditsKeyPress
          StyleController = scStyle
        end
        object ed_out_price: TdxCalcEdit
          Left = 88
          Top = 80
          Width = 89
          TabOrder = 2
          Visible = False
          OnKeyPress = EditsKeyPress
          StyleController = scStyle
          Text = '0'
          ButtonGlyph.Data = {
            EE000000424DEE0000000000000076000000280000000B0000000F0000000100
            0400000000007800000000000000000000001000000000000000000000000000
            8000008000000080800080000000800080008080000080808000C0C0C0000000
            FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00700000000070
            0000088888888800000008080899980000000888888888000000080808080800
            0000088888888800000008080808080000000888888888000000080808080800
            00000888888888000000080000000800000008000E0E08000000080000000800
            000008888888880000007000000000700000}
        end
      end
    end
  end
end
