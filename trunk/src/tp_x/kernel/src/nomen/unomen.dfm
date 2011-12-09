inherited fnomen: Tfnomen
  Left = 152
  Top = 215
  Caption = 'fnomen'
  ClientHeight = 346
  ClientWidth = 612
  DefaultMonitor = dmMainForm
  OldCreateOrder = True
  ExplicitWidth = 618
  ExplicitHeight = 370
  PixelsPerInch = 96
  TextHeight = 13
  inherited master: ZMaster
    Left = 22
    Height = 321
    ExplicitLeft = 22
    ExplicitHeight = 321
  end
  inherited p_pages: TPageControl
    Left = 184
    Top = 16
    Width = 393
    Height = 281
    ActivePage = TabSheet2
    TabOrder = 0
    ExplicitLeft = 184
    ExplicitTop = 16
    ExplicitWidth = 393
    ExplicitHeight = 281
    object TabSheet1: TTabSheet
      Caption = #1054#1089#1085#1086#1074#1085#1110
      object pStage0: TPanel
        Left = 3
        Top = 16
        Width = 361
        Height = 201
        TabOrder = 0
        object Label1: TLabel
          Left = 8
          Top = 24
          Width = 69
          Height = 13
          Caption = #1043#1088#1091#1087#1072' '#1090#1086#1074#1072#1088#1110#1074
        end
        object Label2: TLabel
          Left = 8
          Top = 56
          Width = 71
          Height = 13
          Caption = #1050#1086#1076' '#1090#1086#1074#1072#1088#1091' (6)'
        end
        object Label3: TLabel
          Left = 8
          Top = 88
          Width = 90
          Height = 13
          Caption = #1053#1072#1079#1074#1072' '#1090#1086#1074#1072#1088#1091' (40)'
        end
        object Label4: TLabel
          Left = 8
          Top = 119
          Width = 133
          Height = 13
          Caption = #1050#1086#1088#1086#1090#1082#1072' '#1085#1072#1079#1074#1072' '#1090#1086#1074#1072#1088#1091' (24)'
        end
        object Label8: TLabel
          Left = 168
          Top = 56
          Width = 56
          Height = 13
          Caption = #1057#1087#1077#1094'.'#1075#1088#1091#1087#1072
        end
        object Label14: TLabel
          Left = 104
          Top = 176
          Width = 56
          Height = 13
          Caption = #1058#1080#1087' '#1090#1086#1074#1072#1088#1091
          Visible = False
        end
        object Label15: TLabel
          Left = 8
          Top = 149
          Width = 98
          Height = 13
          Caption = #1058#1077#1088#1084#1110#1085' '#1087#1088#1080#1076#1072#1090#1085#1086#1089#1090#1110
        end
        object Label16: TLabel
          Left = 189
          Top = 149
          Width = 20
          Height = 13
          Caption = #1076#1085#1110#1074
        end
        object ed_tree: TdxPopupEdit
          Left = 88
          Top = 16
          Width = 265
          TabOrder = 0
          OnKeyDown = EditsKeyUp
          OnKeyPress = EditsKeyPress
          OnKeyUp = EditsKeyDown
          ReadOnly = True
          StyleController = scStyle
          Text = #1053#1077' '#1074#1080#1079#1085#1072#1095#1077#1085#1072' '#1075#1088#1091#1087#1072
          PopupFormBorderStyle = pbsSimple
          StoredValues = 64
        end
        object ed_code: TdxEdit
          Left = 88
          Top = 48
          Width = 73
          TabOrder = 1
          Text = 'ed_code'
          OnKeyDown = EditsKeyUp
          OnKeyPress = EditsKeyPress
          OnKeyUp = EditsKeyDown
          MaxLength = 6
          StyleController = scStyle
          StoredValues = 2
        end
        object ed_full_name: TdxEdit
          Left = 104
          Top = 80
          Width = 249
          TabOrder = 3
          Text = 'ed_full_name'
          OnKeyDown = EditsKeyUp
          OnKeyPress = EditsKeyPress
          OnKeyUp = EditsKeyDown
          MaxLength = 40
          StyleController = scStyle
          StoredValues = 2
        end
        object ed_short_name: TdxEdit
          Left = 144
          Top = 111
          Width = 209
          TabOrder = 4
          Text = 'ed_short_name'
          OnKeyDown = EditsKeyUp
          OnKeyPress = EditsKeyPress
          OnKeyUp = EditsKeyDown
          MaxLength = 24
          StyleController = scStyle
          StoredValues = 2
        end
        object ed_sg: TdxImageEdit
          Left = 232
          Top = 48
          Width = 121
          TabOrder = 2
          Text = 'ed_sg'
          OnKeyDown = EditsKeyUp
          OnKeyPress = EditsKeyPress
          OnKeyUp = EditsKeyDown
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
        object ed_type_nomen: TdxImageEdit
          Left = 166
          Top = 170
          Width = 132
          TabOrder = 5
          Text = 'ed_type_nomen'
          Visible = False
          StyleController = scStyle
          Descriptions.Strings = (
            #1047#1074#1080#1095#1072#1081#1085#1080#1081' '#1090#1086#1074#1072#1088
            #1057#1080#1088#1086#1074#1080#1085#1072
            #1055#1088#1086#1076#1091#1082#1094#1110#1103)
          ImageIndexes.Strings = (
            '0'
            '1'
            '2')
          Values.Strings = (
            '0'
            '1'
            '2')
        end
        object ed_termin: TdxSpinEdit
          Left = 112
          Top = 143
          Width = 71
          TabOrder = 6
          OnKeyDown = EditsKeyDown
          OnKeyPress = EditsKeyPress
          OnKeyUp = EditsKeyUp
          StyleController = scStyle
          MaxValue = 9999.000000000000000000
          MinValue = 1.000000000000000000
          Value = 1.000000000000000000
          StoredValues = 48
        end
      end
    end
    object TabSheet2: TTabSheet
      Caption = #1044#1086#1076#1072#1090#1082#1086#1074#1086
      ImageIndex = 1
      object pStage1: TPanel
        Left = 3
        Top = 3
        Width = 361
        Height = 238
        TabOrder = 0
        object Label5: TLabel
          Left = 8
          Top = 24
          Width = 46
          Height = 13
          Caption = #1058#1080#1087' '#1055#1044#1042
        end
        object Label7: TLabel
          Left = 8
          Top = 182
          Width = 67
          Height = 13
          Caption = #1052#1110#1085'. '#1079#1072#1083#1080#1096#1086#1082
        end
        object Label6: TLabel
          Left = 189
          Top = 150
          Width = 53
          Height = 13
          Caption = #1054#1076'. '#1074#1080#1084#1110#1088#1091
        end
        object Label9: TLabel
          Left = 7
          Top = 150
          Width = 75
          Height = 13
          Caption = #1042#1072#1075#1072'/'#1084#1110#1089#1090#1082#1110#1089#1090#1100
        end
        object Label12: TLabel
          Left = 8
          Top = 56
          Width = 121
          Height = 13
          Caption = #1042#1080#1088#1086#1073#1085#1080#1082' ('#1058#1086#1088#1075'. '#1052#1072#1088#1082#1072')'
        end
        object Label13: TLabel
          Left = 8
          Top = 119
          Width = 123
          Height = 13
          Caption = #1054#1089#1085#1086#1074#1085#1080#1081' '#1087#1086#1089#1090#1072#1095#1072#1083#1100#1085#1080#1082
        end
        object Label17: TLabel
          Left = 8
          Top = 87
          Width = 85
          Height = 13
          Caption = #1050#1088#1072#1111#1085#1072'-'#1074#1080#1088#1086#1073#1085#1080#1082
        end
        object ed_is_dividend: TdxCheckEdit
          Left = 8
          Top = 210
          Width = 105
          Style.Edges = [edgLeft, edgTop, edgRight, edgBottom]
          TabOrder = 7
          OnKeyDown = EditsKeyUp
          OnKeyPress = EditsKeyPress
          OnKeyUp = EditsKeyDown
          Caption = #1044#1110#1083#1080#1084#1080#1081' '#1090#1086#1074#1072#1088
        end
        object ed_typePDV: TdxImageEdit
          Left = 64
          Top = 16
          Width = 201
          TabOrder = 0
          Text = 'ed_typePDV'
          OnKeyDown = EditsKeyUp
          OnKeyPress = EditsKeyPress
          OnKeyUp = EditsKeyDown
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
        object ed_min_rest: TdxCalcEdit
          Left = 88
          Top = 177
          Width = 66
          TabOrder = 6
          OnKeyDown = EditsKeyUp
          OnKeyPress = EditsKeyPress
          OnKeyUp = EditsKeyDown
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
        object ed_netto: TdxCalcEdit
          Left = 88
          Top = 145
          Width = 65
          TabOrder = 4
          OnKeyDown = EditsKeyUp
          OnKeyPress = EditsKeyPress
          OnKeyUp = EditsKeyDown
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
        object ed_si: TdxImageEdit
          Left = 248
          Top = 145
          Width = 105
          TabOrder = 5
          Text = 'ed_si'
          OnKeyDown = EditsKeyUp
          OnKeyPress = EditsKeyPress
          OnKeyUp = EditsKeyDown
          StyleController = scStyle
        end
        object ed_is_visible: TdxCheckEdit
          Left = 120
          Top = 209
          Width = 105
          TabOrder = 8
          OnKeyDown = EditsKeyUp
          OnKeyPress = EditsKeyPress
          OnKeyUp = EditsKeyDown
          Caption = #1042#1080#1076#1080#1084#1080#1081' '#1090#1086#1074#1072#1088
        end
        object ed_is_active: TdxCheckEdit
          Left = 232
          Top = 209
          Width = 105
          TabOrder = 9
          OnKeyDown = EditsKeyUp
          OnKeyPress = EditsKeyPress
          OnKeyUp = EditsKeyDown
          Caption = #1040#1082#1090#1080#1074#1085#1080#1081' '#1090#1086#1074#1072#1088
        end
        object ed_maker: TdxPopupEdit
          Left = 135
          Top = 48
          Width = 217
          TabOrder = 1
          OnKeyDown = EditsKeyUp
          OnKeyPress = EditsKeyPress
          OnKeyUp = EditsKeyDown
          StyleController = scStyle
          Text = 'ed_maker'
        end
        object ed_src_client: TdxPopupEdit
          Left = 135
          Top = 111
          Width = 217
          TabOrder = 3
          OnKeyDown = EditsKeyUp
          OnKeyPress = EditsKeyPress
          OnKeyUp = EditsKeyDown
          StyleController = scStyle
          Text = 'ed_src_client'
        end
        object ed_l0_point: TdxPopupEdit
          Left = 135
          Top = 79
          Width = 217
          TabOrder = 2
          OnKeyDown = EditsKeyUp
          OnKeyPress = EditsKeyPress
          OnKeyUp = EditsKeyDown
          StyleController = scStyle
          Text = 'ed_l0_point'
        end
      end
    end
    object TabSheet3: TTabSheet
      Caption = #1064#1090#1088#1080#1093#1082#1086#1076#1080
      ImageIndex = 2
      object pStage2: TPanel
        Left = 8
        Top = 16
        Width = 361
        Height = 145
        TabOrder = 0
        object ZToolBar1: ZToolBar
          Left = 1
          Top = 1
          Width = 359
          Height = 22
          AutoSize = True
          Caption = 'XToolBar1'
          EdgeInner = esNone
          EdgeOuter = esNone
          Images = ImageList1
          TabOrder = 1
          object bt_ins_barcode: ZToolButton
            Left = 0
            Top = 0
            Width = 22
            Height = 22
            Hint = #1044#1086#1076#1072#1090#1080' '#1096#1090#1088#1080#1093#1082#1086#1076
            Align = alTop
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = 18
            Font.Name = 'Tahoma'
            Font.Style = []
            ParentShowHint = False
            ShowHint = True
            OnClick = barcodeClick
            Style = xbsButton
            Down = False
            ImageIndex = 0
          end
          object bt_del_barcode: ZToolButton
            Left = 22
            Top = 0
            Width = 22
            Height = 22
            Hint = #1042#1080#1076#1072#1083#1080#1090#1080' '#1096#1090#1088#1080#1093#1082#1086#1076
            Align = alTop
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = 18
            Font.Name = 'Tahoma'
            Font.Style = []
            ParentShowHint = False
            ShowHint = True
            OnClick = barcodeClick
            Style = xbsButton
            Down = False
            ImageIndex = 1
          end
        end
        object ed_barcodes: ZVirtualGrid
          Left = 1
          Top = 23
          Width = 359
          Height = 121
          Align = alClient
          Options = [dgTitles, dgIndicator, dgColumnResize, dgColLines, dgRowLines, dgTabs, dgConfirmDelete, dgCancelOnExit]
          TabOrder = 0
          TitleFont.Charset = DEFAULT_CHARSET
          TitleFont.Color = clWindowText
          TitleFont.Height = -11
          TitleFont.Name = 'MS Sans Serif'
          TitleFont.Style = []
          OnKeyDown = EditsKeyUp
          OnKeyPress = EditsKeyPress
          OnKeyUp = EditsKeyUp
        end
      end
    end
    object TabSheet4: TTabSheet
      Caption = #1062#1110#1085#1072
      ImageIndex = 3
      object pStage3: TPanel
        Left = 8
        Top = 16
        Width = 361
        Height = 145
        TabOrder = 0
        object Label10: TLabel
          Left = 8
          Top = 24
          Width = 22
          Height = 13
          Caption = #1062#1110#1085#1072
        end
        object Label11: TLabel
          Left = 136
          Top = 24
          Width = 20
          Height = 13
          Caption = #1075#1088#1085'.'
        end
        object ed_out_price: TdxCalcEdit
          Left = 48
          Top = 16
          Width = 81
          TabOrder = 0
          OnKeyDown = EditsKeyUp
          OnKeyPress = EditsKeyPress
          OnKeyUp = EditsKeyDown
          StyleController = scStyle
          Text = '0'
        end
        object ed_is_in_discount: TdxCheckEdit
          Left = 16
          Top = 52
          Width = 225
          Style.Edges = [edgLeft, edgTop, edgRight, edgBottom]
          TabOrder = 1
          OnKeyDown = EditsKeyUp
          OnKeyPress = EditsKeyPress
          OnKeyUp = EditsKeyDown
          Caption = #1059#1095#1072#1089#1090#1100' '#1091' '#1076#1080#1089#1082#1086#1085#1090#1085#1110#1081' '#1087#1088#1086#1075#1088#1072#1084#1110
          State = cbsChecked
        end
      end
    end
  end
  object ImageList1: TImageList
    BlendColor = clWhite
    BkColor = clWhite
    DrawingStyle = dsTransparent
    Left = 152
    Top = 115
    Bitmap = {
      494C010102000400040010001000FFFFFF00FF10FFFFFFFFFFFFFFFF424D3600
      0000000000003600000028000000400000001000000001002000000000000010
      000000000000000000000000000000000000FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00808080008080800080808000808080008080800080808000808080008080
      80008080800080808000FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000FFFFFF00FFFFFF00FFFFFF000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000080808000FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF0000000000FFFFFF00FFFFFF000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000FFFFFF00FFFFFF00FFFFFF000000
      0000FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF000000000080808000FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF000000
      0000FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000FFFFFF00FFFFFF00FFFFFF000000
      0000FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF000000000080808000FFFFFF00FFFFFF00FFFFFF00FFFFFF00000000000000
      000000000000FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF0000000000FFFFFF00FFFFFF00FFFFFF000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000FFFFFF00FFFFFF00FFFFFF000000
      0000FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF000000000080808000FFFFFF00FFFFFF00FFFFFF00FFFFFF00000000000000
      000000000000FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF000000
      0000FFFFFF00FFFFFF00FFFFFF00FFFFFF000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000FFFFFF00FFFFFF00FFFFFF000000
      0000FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF000000000080808000FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF000000
      00000000000000000000FFFFFF00FFFFFF00FFFFFF00FFFFFF00000000000000
      0000FFFFFF00FFFFFF00FFFFFF00FFFFFF000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000FFFFFF00FFFFFF00FFFFFF000000
      0000FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF000000000080808000FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00000000000000000000000000FFFFFF00FFFFFF000000000000000000FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000FFFFFF00FFFFFF00FFFFFF000000
      0000FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF000000000080808000FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF000000000000000000000000000000000000000000FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000FFFFFF00FFFFFF00FFFFFF000000
      0000FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF000000000080808000FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00000000000000000000000000FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000FFFFFF00FFFFFF00FFFFFF000000
      0000FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF000000000080808000FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF000000000000000000000000000000000000000000FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000FFFFFF00FFFFFF00FFFFFF000000
      0000FFFFFF00FFFFFF00FFFFFF00FFFFFF000000000000000000000000000000
      000000000000FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00000000000000000000000000FFFFFF00FFFFFF0000000000FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000FFFFFF00FFFFFF00FFFFFF000000
      0000FFFFFF00FFFFFF00FFFFFF00FFFFFF0000000000FFFFFF00FFFFFF000000
      0000FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00000000000000
      00000000000000000000FFFFFF00FFFFFF00FFFFFF00FFFFFF00000000000000
      0000FFFFFF00FFFFFF00FFFFFF00FFFFFF000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000FFFFFF00FFFFFF00FFFFFF000000
      0000FFFFFF00FFFFFF00FFFFFF00FFFFFF0000000000FFFFFF0000000000FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF0000000000000000000000
      000000000000FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF000000
      000000000000FFFFFF00FFFFFF00FFFFFF000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000FFFFFF00FFFFFF00FFFFFF000000
      0000FFFFFF00FFFFFF00FFFFFF00FFFFFF000000000000000000FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF000000000000000000FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF000000000000000000FFFFFF00FFFFFF000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000FFFFFF00FFFFFF00FFFFFF000000
      00000000000000000000000000000000000000000000FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000424D3E000000000000003E000000
      2800000040000000100000000100010000000000800000000000000000000000
      000000000000000000000000FFFFFF00F003FFFF00000000E003FFF900000000
      E003E7FF00000000E003C3F300000000E003C3E700000000E003E1C700000000
      E003F08F00000000E003F81F00000000E003FC3F00000000E003F81F00000000
      E007F09F00000000E00FC1C700000000E01F83E300000000E03F8FF100000000
      E07FFFFF00000000FFFFFFFF0000000000000000000000000000000000000000
      000000000000}
  end
end
