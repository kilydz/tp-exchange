inherited fmanager: Tfmanager
  Left = 0
  Top = 0
  Caption = 'fmanager'
  ClientHeight = 330
  ClientWidth = 628
  Font.Name = 'Tahoma'
  ExplicitWidth = 634
  ExplicitHeight = 354
  PixelsPerInch = 96
  TextHeight = 13
  inherited master: ZMaster
    Height = 265
    ExplicitHeight = 265
  end
  inherited p_pages: TPageControl
    Left = 107
    Top = 16
    ActivePage = TabSheet1
    ExplicitLeft = 107
    ExplicitTop = 16
    object TabSheet1: TTabSheet
      Caption = #1054#1089#1085#1086#1074#1085#1110
      object pStage0: TPanel
        Left = 3
        Top = 0
        Width = 361
        Height = 202
        TabOrder = 0
        object Label4: TLabel
          Left = 8
          Top = 22
          Width = 113
          Height = 13
          Caption = #1053#1072#1079#1074#1072' '#1084#1077#1085#1077#1076#1078#1077#1088#1072' (20)'
        end
        object ed_manager_name: TdxEdit
          Left = 127
          Top = 14
          Width = 226
          TabOrder = 0
          Text = 'ed_manager_name'
          OnKeyDown = EditsKeyDown
          OnKeyPress = EditsKeyPress
          OnKeyUp = EditsKeyUp
          MaxLength = 20
          StyleController = scStyle
          StoredValues = 2
        end
      end
    end
    object TabSheet2: TTabSheet
      Caption = #1050#1072#1090#1077#1075#1086#1088#1110#1111
      ImageIndex = 1
      object Panel1: TPanel
        Left = 3
        Top = 0
        Width = 361
        Height = 202
        TabOrder = 0
        object ed_groups: ZFilterCombo
          Left = 1
          Top = 1
          Width = 359
          Height = 200
          Align = alClient
          BevelInner = bvNone
          Ctl3D = False
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'MS Sans Serif'
          Font.Style = []
          ItemHeight = 13
          ParentCtl3D = False
          ParentFont = False
          ParentShowHint = False
          ShowHint = False
          TabOrder = 0
        end
      end
    end
  end
end
