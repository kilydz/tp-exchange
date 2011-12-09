inherited fscale: Tfscale
  Left = 189
  Top = 274
  Caption = 'fscale'
  ClientWidth = 827
  OldCreateOrder = True
  ExplicitWidth = 833
  ExplicitHeight = 285
  PixelsPerInch = 96
  TextHeight = 13
  inherited p_pages: TPageControl
    Width = 393
    ActivePage = TabSheet1
    TabOrder = 0
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
          Top = 96
          Width = 45
          Height = 13
          Caption = #1058#1080#1087' '#1074#1072#1075#1080
        end
        object Label2: TLabel
          Left = 8
          Top = 62
          Width = 53
          Height = 13
          Caption = #1053#1072#1079#1074#1072' (60)'
        end
        object Label3: TLabel
          Left = 8
          Top = 30
          Width = 10
          Height = 13
          Caption = #1030#1056
        end
        object Label4: TLabel
          Left = 122
          Top = 27
          Width = 5
          Height = 16
          Caption = '.'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -13
          Font.Name = 'MS Sans Serif'
          Font.Style = [fsBold]
          ParentFont = False
        end
        object Label5: TLabel
          Left = 157
          Top = 27
          Width = 5
          Height = 16
          Caption = '.'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -13
          Font.Name = 'MS Sans Serif'
          Font.Style = [fsBold]
          ParentFont = False
        end
        object Label6: TLabel
          Left = 192
          Top = 27
          Width = 5
          Height = 16
          Caption = '.'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -13
          Font.Name = 'MS Sans Serif'
          Font.Style = [fsBold]
          ParentFont = False
        end
        object ed_scale: TdxEdit
          Left = 92
          Top = 56
          Width = 261
          TabOrder = 4
          Text = 'ed_scale'
          OnKeyPress = EditsKeyPress
          MaxLength = 60
          StyleController = scStyle
          StoredValues = 2
        end
        object ed_scale_type: TdxImageEdit
          Left = 92
          Top = 88
          Width = 165
          TabOrder = 5
          Text = 'ed_scale_type'
          OnKeyPress = EditsKeyPress
          StyleController = scStyle
        end
        object ed_ip1: TdxMaskEdit
          Left = 92
          Top = 22
          Width = 29
          Style.BorderStyle = xbsFlat
          TabOrder = 0
          IgnoreMaskBlank = False
          MaxLength = 3
          StoredValues = 6
        end
        object ed_ip2: TdxMaskEdit
          Left = 127
          Top = 22
          Width = 29
          Style.BorderStyle = xbsFlat
          TabOrder = 1
          IgnoreMaskBlank = False
          MaxLength = 3
          StoredValues = 6
        end
        object ed_ip3: TdxMaskEdit
          Left = 162
          Top = 22
          Width = 29
          Style.BorderStyle = xbsFlat
          TabOrder = 2
          IgnoreMaskBlank = False
          MaxLength = 3
          StoredValues = 6
        end
        object ed_ip4: TdxMaskEdit
          Left = 197
          Top = 22
          Width = 29
          Style.BorderStyle = xbsFlat
          TabOrder = 3
          IgnoreMaskBlank = False
          MaxLength = 3
          StoredValues = 6
        end
      end
    end
  end
end
