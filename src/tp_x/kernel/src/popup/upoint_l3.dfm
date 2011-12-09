inherited fpoint_l3: Tfpoint_l3
  Left = 0
  Top = 0
  Caption = 'fpoint_l3'
  ClientHeight = 211
  ClientWidth = 681
  Font.Name = 'Tahoma'
  ExplicitWidth = 687
  ExplicitHeight = 235
  PixelsPerInch = 96
  TextHeight = 13
  inherited master: ZMaster
    Width = 449
    Height = 191
    ExplicitWidth = 449
    ExplicitHeight = 191
  end
  inherited p_pages: TPageControl
    Left = 136
    Width = 489
    Height = 178
    ActivePage = TabSheet1
    ExplicitLeft = 136
    ExplicitWidth = 489
    ExplicitHeight = 178
    object TabSheet1: TTabSheet
      Caption = #1054#1073#1083#1072#1089#1090#1100
      object pStage0: TPanel
        Left = 16
        Top = 11
        Width = 445
        Height = 126
        TabOrder = 0
        object Label2: TLabel
          Left = 8
          Top = 24
          Width = 153
          Height = 13
          Caption = #1053#1072#1079#1074#1072' '#1085#1072#1089#1077#1083#1077#1085#1086#1075#1086' '#1087#1091#1085#1082#1090#1072' (32)'
        end
        object Label1: TLabel
          Left = 8
          Top = 58
          Width = 86
          Height = 13
          Caption = #1055#1086#1096#1090#1086#1074#1080#1081' '#1110#1085#1076#1077#1082#1089
        end
        object Label3: TLabel
          Left = 189
          Top = 56
          Width = 118
          Height = 13
          Caption = #1058#1080#1087' '#1085#1072#1089#1077#1083#1077#1085#1086#1075#1086' '#1087#1091#1085#1082#1090#1091
        end
        object ed_name: TdxEdit
          Left = 175
          Top = 16
          Width = 250
          TabOrder = 0
          Text = 'ed_name'
          OnKeyDown = EditsKeyDown
          OnKeyPress = EditsKeyPress
          OnKeyUp = EditsKeyUp
          MaxLength = 32
          StyleController = scStyle
          StoredValues = 2
        end
        object ed_post_code: TdxMaskEdit
          Left = 105
          Top = 50
          Width = 56
          TabOrder = 1
          OnKeyDown = EditsKeyDown
          OnKeyPress = EditsKeyPress
          OnKeyUp = EditsKeyUp
          EditMask = '00000;1;_'
          IgnoreMaskBlank = True
          StyleController = scStyle
          Text = '     '
          StoredValues = 4
        end
        object ed_point_type_id: TdxImageEdit
          Left = 316
          Top = 50
          Width = 109
          TabOrder = 2
          Text = 'ed_point_type_id'
          OnKeyDown = EditsKeyDown
          OnKeyPress = EditsKeyPress
          OnKeyUp = EditsKeyUp
          ReadOnly = False
          StyleController = scStyle
          Descriptions.Strings = (
            #1053#1077' '#1074#1082#1072#1079#1072#1085#1086
            #1052#1110#1089#1090#1086' ('#1084'.)'
            #1057#1077#1083#1086' ('#1089'.)')
          ImageIndexes.Strings = (
            '0'
            '1'
            '2')
          Values.Strings = (
            '0'
            '1'
            '2')
          StoredValues = 64
        end
      end
    end
  end
end
