inherited fscale: Tfscale
  Left = 0
  Top = 0
  Caption = 'fscale'
  ClientHeight = 249
  ClientWidth = 593
  Font.Name = 'Tahoma'
  ExplicitWidth = 599
  ExplicitHeight = 273
  PixelsPerInch = 96
  TextHeight = 13
  inherited p_pages: TPageControl
    Left = 152
    Height = 209
    ActivePage = TabSheet1
    ExplicitLeft = 152
    ExplicitHeight = 209
    object TabSheet1: TTabSheet
      Caption = #1054#1089#1085#1086#1074#1085#1110
      object pStage0: TPanel
        Left = 40
        Top = 17
        Width = 361
        Height = 152
        TabOrder = 0
        object Label1: TLabel
          Left = 8
          Top = 24
          Width = 57
          Height = 13
          Caption = #1053#1086#1084#1077#1088' '#1074#1072#1075#1080
        end
        object Label2: TLabel
          Left = 8
          Top = 54
          Width = 79
          Height = 13
          Caption = #1053#1072#1079#1074#1072' '#1074#1072#1075#1080' (20)'
        end
        object Label10: TLabel
          Left = 8
          Top = 85
          Width = 44
          Height = 13
          Caption = #1058#1080#1087' '#1074#1072#1075#1080
        end
        object Label3: TLabel
          Left = 172
          Top = 24
          Width = 107
          Height = 13
          Caption = #1055#1088#1077#1092#1110#1082#1089' '#1082#1086#1076#1091' '#1090#1086#1074#1072#1088#1091
        end
        object Label4: TLabel
          Left = 9
          Top = 117
          Width = 78
          Height = 13
          Caption = #1058#1080#1087' '#1110#1085#1090#1077#1088#1092#1077#1081#1089#1091
        end
        object ed_name: TdxEdit
          Left = 104
          Top = 46
          Width = 233
          TabOrder = 2
          Text = 'ed_name'
          OnKeyDown = EditsKeyDown
          OnKeyPress = EditsKeyPress
          OnKeyUp = EditsKeyUp
          MaxLength = 20
          StyleController = scStyle
          StoredValues = 2
        end
        object ed_scale_interface: TdxImageEdit
          Left = 104
          Top = 109
          Width = 233
          TabOrder = 4
          Text = 'ed_scale_interface'
          OnKeyDown = EditsKeyDown
          OnKeyPress = EditsKeyPress
          OnKeyUp = EditsKeyUp
          StyleController = scStyle
          Descriptions.Strings = (
            '')
          ImageIndexes.Strings = (
            '0')
          Values.Strings = (
            '')
        end
        object ed_scale_type: TdxImageEdit
          Left = 104
          Top = 77
          Width = 233
          TabOrder = 3
          Text = 'ed_scale_type'
          OnKeyDown = EditsKeyDown
          OnKeyPress = EditsKeyPress
          OnKeyUp = EditsKeyUp
          StyleController = scStyle
          OnChange = ed_scale_typeChange
          Descriptions.Strings = (
            '')
          ImageIndexes.Strings = (
            '0')
          Values.Strings = (
            '')
        end
        object ed_number: TdxSpinEdit
          Left = 77
          Top = 16
          Width = 67
          TabOrder = 0
          OnKeyDown = EditsKeyDown
          OnKeyPress = EditsKeyPress
          OnKeyUp = EditsKeyUp
          StyleController = scStyle
          Value = 1.000000000000000000
        end
        object ed_prefix: TdxImageEdit
          Left = 286
          Top = 16
          Width = 51
          TabOrder = 1
          Text = '22'
          OnKeyDown = EditsKeyDown
          OnKeyPress = EditsKeyPress
          OnKeyUp = EditsKeyUp
          StyleController = scStyle
          Descriptions.Strings = (
            '22'
            '28')
          ImageIndexes.Strings = (
            '0'
            '1')
          Values.Strings = (
            '22'
            '28')
        end
      end
    end
  end
  inherited scStyle: TdxEditStyleController
    Left = 160
  end
end
