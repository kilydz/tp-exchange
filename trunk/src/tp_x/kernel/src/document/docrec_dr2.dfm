inherited fdocrec_dr2: Tfdocrec_dr2
  Left = 358
  Top = 186
  Caption = #1047#1072#1087#1080#1089' '#1074' '#1076#1086#1082#1091#1084#1077#1085#1090#1110
  ClientWidth = 527
  OldCreateOrder = True
  ExplicitWidth = 543
  ExplicitHeight = 469
  PixelsPerInch = 96
  TextHeight = 13
  inherited p_stage0: TPanel
    Left = 104
    Height = 305
    ExplicitLeft = 104
    ExplicitHeight = 305
    inherited Label1: TLabel
      Top = 45
      ExplicitTop = 45
    end
    object Label2: TLabel [1]
      Left = 8
      Top = 80
      Width = 15
      Height = 13
      Caption = #1062#1056
    end
    object Label4: TLabel [2]
      Left = 8
      Top = 112
      Width = 14
      Height = 13
      Caption = #1057#1056
    end
    object Label3: TLabel [3]
      Left = 161
      Top = 80
      Width = 57
      Height = 13
      Caption = #1062#1056' ('#1079' '#1055#1044#1042')'
    end
    object Label5: TLabel [4]
      Left = 160
      Top = 112
      Width = 56
      Height = 13
      Caption = #1057#1056' ('#1079' '#1055#1044#1042')'
    end
    object Label6: TLabel [5]
      Left = 8
      Top = 144
      Width = 40
      Height = 13
      Caption = #1053#1072#1094#1110#1085#1082#1072
    end
    object Label7: TLabel [6]
      Left = 139
      Top = 144
      Width = 8
      Height = 13
      Caption = '%'
    end
    inherited Label_name: TLabel
      Top = 18
      ExplicitTop = 18
    end
    object Label8: TLabel [8]
      Left = 162
      Top = 144
      Width = 57
      Height = 13
      Caption = #1062#1047' ('#1079' '#1055#1044#1042')'
    end
    object Label9: TLabel [9]
      Left = 160
      Top = 45
      Width = 39
      Height = 13
      Caption = #1047#1085#1080#1078#1082#1072
    end
    object Label10: TLabel [10]
      Left = 310
      Top = 44
      Width = 8
      Height = 13
      Caption = '%'
    end
    inherited ed_goods_list: TStringGrid
      Top = 168
      Height = 136
      TabOrder = 7
      ExplicitTop = 168
      ExplicitHeight = 136
    end
    inherited ed_kilk: TdxCalcEdit
      Left = 35
      Top = 37
      TabOrder = 0
      ExplicitLeft = 35
      ExplicitTop = 37
    end
    inherited ed_price: TdxCalcEdit
      Top = 77
      TabOrder = 1
      ExplicitTop = 77
    end
    inherited ed_price_pdv: TdxCalcEdit
      Top = 77
      TabOrder = 2
      ExplicitTop = 77
    end
    inherited ed_sum_pdv: TdxCalcEdit
      TabOrder = 4
    end
    inherited ed_name: TdxEdit
      Left = 83
      ExplicitLeft = 83
      StoredValues = 2
    end
    object ed_markup: TdxCalcEdit
      Left = 57
      Top = 141
      Width = 80
      TabOrder = 5
      OnKeyDown = EditsKeyDown
      OnKeyPress = EditsKeyPress
      OnKeyUp = EditsKeyUp
      StyleController = scStyle
      Text = '0'
      OnChange = ed_markupChange
    end
    object ed_inprice: TdxEdit
      Left = 224
      Top = 141
      Width = 97
      Enabled = False
      TabOrder = 8
      Text = 'ed_inprice'
      MaxLength = 14
      StyleController = scStyle
      StoredValues = 2
    end
    object ed_discount: TdxCalcEdit
      Left = 224
      Top = 37
      Width = 80
      TabOrder = 9
      OnKeyDown = EditsKeyDown
      OnKeyPress = EditsKeyPress
      OnKeyUp = EditsKeyUp
      StyleController = scStyle
      Text = '0'
      OnChange = ed_discountChange
    end
  end
end
