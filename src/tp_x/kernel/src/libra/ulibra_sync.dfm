inherited fnomen: Tfnomen
  Left = 235
  Top = 190
  Caption = #1057#1080#1085#1093#1088#1086#1085#1110#1079#1072#1094#1110#1103' '#1079' '#1074#1072#1075#1086#1102
  ClientHeight = 317
  ClientWidth = 523
  DefaultMonitor = dmMainForm
  OldCreateOrder = True
  ExplicitWidth = 529
  ExplicitHeight = 341
  PixelsPerInch = 96
  TextHeight = 13
  inherited master: ZMaster
    Left = 8
    Width = 362
    Height = 301
    OnPageChange = masterPageChange
    ExplicitLeft = 8
    ExplicitWidth = 362
    ExplicitHeight = 301
  end
  inherited p_pages: TPageControl
    Left = 68
    Width = 429
    Height = 273
    ActivePage = TabSheet1
    TabOrder = 0
    ExplicitLeft = 68
    ExplicitWidth = 429
    ExplicitHeight = 273
    object TabSheet1: TTabSheet
      Caption = #1054#1089#1085#1086#1074#1085#1110
      object pStage0: TPanel
        Left = 0
        Top = 12
        Width = 401
        Height = 230
        TabOrder = 0
        DesignSize = (
          401
          230)
        object Label4: TLabel
          Left = 184
          Top = 24
          Width = 45
          Height = 13
          Anchors = [akTop, akRight]
          Caption = #1058#1080#1087' '#1074#1072#1075#1080
          ExplicitLeft = 168
        end
        object ed_libra_type: TdxImageEdit
          Left = 235
          Top = 16
          Width = 142
          TabOrder = 1
          Text = 'CAS LP v1.5'
          Anchors = [akTop, akRight]
          StyleController = scStyle
          OnChange = ed_libra_typeChange
          Descriptions.Strings = (
            'CAS LP v1.5'
            'METLER Tiger D'
            'Ethernet'
            'METLER Tiger D (1line)')
          ImageIndexes.Strings = (
            '0'
            '1'
            '2'
            '3')
          Values.Strings = (
            'CAS LP v1.5'
            'METLER Tiger D'
            'Ethernet'
            'METLER Tiger D (1line)')
        end
        object Panel_COM: TPanel
          Left = 7
          Top = 66
          Width = 187
          Height = 62
          BevelOuter = bvNone
          TabOrder = 3
          object Label2: TLabel
            Left = 9
            Top = 9
            Width = 25
            Height = 13
            Caption = #1055#1086#1088#1090
          end
          object Label3: TLabel
            Left = 9
            Top = 39
            Width = 52
            Height = 13
            Caption = #1064#1074#1080#1076#1082#1110#1089#1090#1100
          end
          object ed_port: TdxImageEdit
            Left = 81
            Top = 3
            Width = 89
            TabOrder = 0
            Text = '0'
            OnKeyDown = EditsKeyDown
            OnKeyPress = EditsKeyPress
            OnKeyUp = EditsKeyUp
            StyleController = scStyle
            Descriptions.Strings = (
              'COM 1'
              'COM 2'
              'COM 3')
            ImageIndexes.Strings = (
              '0'
              '1'
              '2')
            Values.Strings = (
              '0'
              '1'
              '2')
          end
          object ed_speed: TdxImageEdit
            Left = 81
            Top = 33
            Width = 89
            TabOrder = 1
            Text = '19200'
            OnKeyDown = EditsKeyDown
            OnKeyPress = EditsKeyPress
            OnKeyUp = EditsKeyUp
            StyleController = scStyle
            Descriptions.Strings = (
              '2400'
              '4800'
              '9600'
              '19200')
            ImageIndexes.Strings = (
              '0'
              '1'
              '2'
              '3')
            Values.Strings = (
              '2400'
              '4800'
              '9600'
              '19200')
          end
        end
        object Panel_fname: TPanel
          Left = 8
          Top = 126
          Width = 345
          Height = 33
          BevelOuter = bvNone
          TabOrder = 4
          Visible = False
          object Label5: TLabel
            Left = 5
            Top = 10
            Width = 69
            Height = 13
            Caption = #1053#1072#1079#1074#1072' '#1092#1072#1081#1083#1091' '
          end
          object ed_file_name: TdxButtonEdit
            Left = 80
            Top = 3
            Width = 265
            TabOrder = 0
            OnKeyDown = EditsKeyDown
            OnKeyPress = EditsKeyPress
            StyleController = scStyle
            Buttons = <
              item
                Default = True
              end>
            OnButtonClick = ed_file_nameButtonClick
            ExistButtons = True
          end
        end
        object Panel_Ethernet: TGroupBox
          Left = 1
          Top = 66
          Width = 399
          Height = 163
          Align = alBottom
          Caption = #1042#1080#1073#1110#1088' '#1074#1072#1075': '
          TabOrder = 5
          Visible = False
          object ed_scales: ZFilterCombo
            Left = 2
            Top = 39
            Width = 395
            Height = 122
            Align = alClient
            BevelInner = bvNone
            Ctl3D = False
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -11
            Font.Name = 'Tahoma'
            Font.Style = []
            ItemHeight = 13
            ParentCtl3D = False
            ParentFont = False
            ParentShowHint = False
            ShowHint = False
            TabOrder = 0
          end
          object ZToolBar1: ZToolBar
            Left = 2
            Top = 15
            Width = 395
            Height = 24
            AutoSize = True
            ButtonHeight = 24
            Caption = 'XToolBar1'
            EdgeInner = esNone
            EdgeOuter = esNone
            Images = ImageList1
            TabOrder = 1
            object bt_ins_scale: ZToolButton
              Left = 0
              Top = 0
              Width = 24
              Height = 24
              Hint = #1044#1086#1076#1072#1090#1080' '#1074#1072#1075#1091
              Align = alTop
              Font.Charset = DEFAULT_CHARSET
              Font.Color = clWindowText
              Font.Height = 18
              Font.Name = 'Tahoma'
              Font.Style = []
              ParentShowHint = False
              ShowHint = True
              OnClick = ScaleClick
              Style = xbsButton
              Down = False
              ImageIndex = 0
            end
            object bt_upd_scale: ZToolButton
              Left = 24
              Top = 0
              Width = 24
              Height = 24
              Hint = #1056#1077#1076#1072#1075#1091#1074#1072#1090#1080' '#1074#1072#1075#1091
              Align = alLeft
              Font.Charset = DEFAULT_CHARSET
              Font.Color = clWindowText
              Font.Height = 18
              Font.Name = 'Tahoma'
              Font.Style = []
              ParentShowHint = False
              ShowHint = True
              OnClick = ScaleClick
              Style = xbsButton
              Down = False
              ImageIndex = 1
            end
            object bt_del_scale: ZToolButton
              Left = 48
              Top = 0
              Width = 24
              Height = 24
              Hint = #1042#1080#1076#1072#1083#1080#1090#1080' '#1079#1072#1087#1080#1089
              Align = alTop
              Font.Charset = DEFAULT_CHARSET
              Font.Color = clWindowText
              Font.Height = 18
              Font.Name = 'Tahoma'
              Font.Style = []
              ParentShowHint = False
              ShowHint = True
              OnClick = ScaleClick
              Style = xbsButton
              Down = False
              ImageIndex = 2
            end
          end
        end
        object panel_scale_no: TPanel
          Left = 8
          Top = 6
          Width = 129
          Height = 35
          BevelOuter = bvNone
          TabOrder = 0
          object Label1: TLabel
            Left = 9
            Top = 18
            Width = 37
            Height = 13
            Caption = #8470' '#1074#1072#1075#1080
          end
          object ed_libra_num: TdxImageEdit
            Left = 64
            Top = 10
            Width = 57
            TabOrder = 0
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
        object ed_ZeroPrograming: TCheckBox
          Left = 17
          Top = 47
          Width = 329
          Height = 17
          Caption = #1055#1088#1086#1075#1088#1072#1084#1091#1074#1072#1090#1080' '#1090#1086#1074#1072#1088#1080' '#1079' '#1085#1091#1083#1100#1086#1074#1080#1084#1080' '#1079#1072#1083#1080#1096#1082#1072#1084#1080
          Checked = True
          State = cbChecked
          TabOrder = 2
        end
      end
    end
    object TabSheet2: TTabSheet
      Caption = #1051#1086#1075
      ImageIndex = 1
      object pStage1: TPanel
        Left = 8
        Top = 3
        Width = 361
        Height = 191
        TabOrder = 0
        object pb_progress: TProgressBar
          Left = 1
          Top = 1
          Width = 359
          Height = 16
          Align = alTop
          TabOrder = 0
        end
        object ed_log: TdxMemo
          Left = 1
          Top = 17
          Width = 359
          Align = alClient
          TabOrder = 1
          ReadOnly = True
          StyleController = scStyle
          ScrollBars = ssVertical
          Height = 173
          StoredValues = 64
        end
      end
    end
  end
  inherited base: TIBDatabase
    Left = 408
    Top = 16
  end
  inherited trR: TIBTransaction
    Left = 440
    Top = 16
  end
  inherited qR: TIBSQL
    Left = 480
    Top = 16
  end
  inherited qW: TIBSQL
    Left = 480
    Top = 88
  end
  inherited trW: TIBTransaction
    Left = 440
    Top = 88
  end
  inherited scStyle: TdxEditStyleController
    Left = 160
    Top = 56
  end
  object export_dialog: TSaveDialog
    Filter = 'plu.txt|*.txt'
    Left = 312
    Top = 80
  end
  object tr_R: TIBTransaction
    DefaultDatabase = base
    Params.Strings = (
      'read_committed'
      'rec_version'
      'nowait')
    Left = 224
    Top = 136
  end
  object q_R: TIBSQL
    Database = base
    Transaction = tr_R
    Left = 256
    Top = 136
  end
  object tr_R2: TIBTransaction
    DefaultDatabase = base
    Params.Strings = (
      'read_committed'
      'rec_version'
      'nowait')
    Left = 224
    Top = 168
  end
  object q_R2: TIBSQL
    Database = base
    Transaction = tr_R2
    Left = 256
    Top = 168
  end
  object ImageList1: TImageList
    BlendColor = clWhite
    BkColor = clWhite
    DrawingStyle = dsTransparent
    Left = 232
    Top = 51
    Bitmap = {
      494C010103000400040010001000FFFFFF00FF10FFFFFFFFFFFFFFFF424D3600
      0000000000003600000028000000400000001000000001002000000000000010
      000000000000000000000000000000000000FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00808080008080800080808000808080008080800080808000808080008080
      80008080800080808000FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00808080008080800080808000808080008080800080808000808080008080
      80008080800080808000FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000FFFFFF00FFFFFF00FFFFFF000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000080808000FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000080808000FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF0000000000FFFFFF00FFFFFF000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000FFFFFF00FFFFFF00FFFFFF000000
      0000FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF000000000080808000FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF000000
      0000FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF000000000080808000FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF000000
      0000FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000FFFFFF00FFFFFF00FFFFFF000000
      0000FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF000000000080808000FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF000000
      0000FFFFFF00000000000000000000000000000000000000000000000000FFFF
      FF000000000080808000FFFFFF00FFFFFF00FFFFFF00FFFFFF00000000000000
      000000000000FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF0000000000FFFFFF00FFFFFF00FFFFFF000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000FFFFFF00FFFFFF00FFFFFF000000
      0000FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF000000000080808000FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF000000
      0000FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF000000000080808000FFFFFF00FFFFFF00FFFFFF00FFFFFF00000000000000
      000000000000FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF000000
      0000FFFFFF00FFFFFF00FFFFFF00FFFFFF000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000FFFFFF00FFFFFF00FFFFFF000000
      0000FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF000000000080808000FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF000000
      0000FFFFFF00FFFFFF00FFFFFF000000000000000000FFFFFF0000000000FFFF
      FF000000000080808000FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF000000
      00000000000000000000FFFFFF00FFFFFF00FFFFFF00FFFFFF00000000000000
      0000FFFFFF00FFFFFF00FFFFFF00FFFFFF000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000FFFFFF00FFFFFF00FFFFFF000000
      0000FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF000000000080808000FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF000000
      0000FFFFFF00FFFFFF00000000008080800000000000FFFFFF00FFFFFF00FFFF
      FF000000000080808000FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00000000000000000000000000FFFFFF00FFFFFF000000000000000000FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000FFFFFF00FFFFFF00FFFFFF000000
      0000FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF000000000080808000FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF000000
      0000FFFFFF00000000008080800000000000FFFFFF00FFFFFF00FFFFFF00FFFF
      FF000000000080808000FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF000000000000000000000000000000000000000000FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000FFFFFF00FFFFFF00FFFFFF000000
      0000FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF000000000080808000FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF000000
      0000000000008080800000000000FFFFFF00FFFFFF000000000000000000FFFF
      FF000000000080808000FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00000000000000000000000000FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000FFFFFF00FFFFFF00FFFFFF000000
      0000FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF000000000080808000FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF000000
      00008080800000000000FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF000000000080808000FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF000000000000000000000000000000000000000000FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000FFFFFF00FFFFFF00FFFFFF000000
      0000FFFFFF00FFFFFF00FFFFFF00FFFFFF000000000000000000000000000000
      000000000000FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00000000008080
      800000000000FFFFFF00FFFFFF00FFFFFF000000000000000000000000000000
      000000000000FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00000000000000000000000000FFFFFF00FFFFFF0000000000FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000FFFFFF00FFFFFF00FFFFFF000000
      0000FFFFFF00FFFFFF00FFFFFF00FFFFFF0000000000FFFFFF00FFFFFF000000
      0000FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF0000000000808080000000
      0000FFFFFF00FFFFFF00FFFFFF00FFFFFF0000000000FFFFFF00FFFFFF000000
      0000FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00000000000000
      00000000000000000000FFFFFF00FFFFFF00FFFFFF00FFFFFF00000000000000
      0000FFFFFF00FFFFFF00FFFFFF00FFFFFF000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000FFFFFF00FFFFFF00FFFFFF000000
      0000FFFFFF00FFFFFF00FFFFFF00FFFFFF0000000000FFFFFF0000000000FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF000000000080808000000000000000
      0000FFFFFF000000000000000000FFFFFF0000000000FFFFFF0000000000FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF0000000000000000000000
      000000000000FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF000000
      000000000000FFFFFF00FFFFFF00FFFFFF000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000FFFFFF00FFFFFF00FFFFFF000000
      0000FFFFFF00FFFFFF00FFFFFF00FFFFFF000000000000000000FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF0000000000FFFFFF000000
      0000FFFFFF00FFFFFF00FFFFFF00FFFFFF000000000000000000FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF000000000000000000FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF000000000000000000FFFFFF00FFFFFF000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000FFFFFF00FFFFFF00FFFFFF000000
      00000000000000000000000000000000000000000000FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF000000
      00000000000000000000000000000000000000000000FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000424D3E000000000000003E000000
      2800000040000000100000000100010000000000800000000000000000000000
      000000000000000000000000FFFFFF00F003F003FFFF0000E003E003FFF90000
      E003E003E7FF0000E003E003C3F30000E003E003C3E70000E003E003E1C70000
      E003E003F08F0000E003E003F81F0000E003E003FC3F0000E003E003F81F0000
      E007C007F09F0000E00F800FC1C70000E01F001F83E30000E03FA03F8FF10000
      E07FE07FFFFF0000FFFFFFFFFFFF000000000000000000000000000000000000
      000000000000}
  end
end
