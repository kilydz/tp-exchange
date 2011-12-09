inherited fdocrec_dr10: Tfdocrec_dr10
  Left = 331
  Top = 198
  Caption = #1047#1072#1087#1080#1089' '#1074' '#1076#1086#1082#1091#1084#1077#1085#1090#1110
  ClientWidth = 577
  OldCreateOrder = True
  ExplicitWidth = 593
  ExplicitHeight = 469
  PixelsPerInch = 96
  TextHeight = 13
  inherited master: ZMaster
    Left = 8
    ExplicitLeft = 8
  end
  inherited p_stage0: TPanel
    Left = 200
    Height = 305
    ExplicitLeft = 200
    ExplicitHeight = 305
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
      Left = 160
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
    object Label9: TLabel [6]
      Left = 160
      Top = 45
      Width = 39
      Height = 13
      Caption = #1047#1085#1080#1078#1082#1072
    end
    object Label10: TLabel [7]
      Left = 310
      Top = 44
      Width = 8
      Height = 13
      Caption = '%'
    end
    object Label6: TLabel [8]
      Left = 8
      Top = 144
      Width = 40
      Height = 13
      Caption = #1053#1072#1094#1110#1085#1082#1072
    end
    object Label7: TLabel [9]
      Left = 139
      Top = 144
      Width = 8
      Height = 13
      Caption = '%'
    end
    object Label8: TLabel [10]
      Left = 162
      Top = 144
      Width = 57
      Height = 13
      Caption = #1062#1047' ('#1079' '#1055#1044#1042')'
    end
    inherited ed_goods_list: TStringGrid
      Top = 168
      Height = 136
      TabOrder = 5
      OnKeyDown = EditsKeyDown
      OnKeyPress = EditsKeyPress
      OnKeyUp = EditsKeyUp
      ExplicitTop = 168
      ExplicitHeight = 136
    end
    inherited ed_kilk: TdxCalcEdit
      TabOrder = 0
    end
    inherited ed_price: TdxCalcEdit
      TabOrder = 1
    end
    inherited ed_price_pdv: TdxCalcEdit
      TabOrder = 2
    end
    inherited ed_sum_pdv: TdxCalcEdit
      TabOrder = 4
    end
    inherited ed_name: TdxEdit
      StoredValues = 2
    end
    object ed_discount: TdxCalcEdit
      Left = 224
      Top = 37
      Width = 80
      TabOrder = 7
      OnKeyDown = EditsKeyDown
      OnKeyPress = EditsKeyPress
      OnKeyUp = EditsKeyUp
      StyleController = scStyle
      Text = '0'
      OnChange = ed_discountChange
    end
    object ed_markup: TdxCalcEdit
      Left = 57
      Top = 141
      Width = 80
      TabOrder = 8
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
      TabOrder = 9
      Text = 'ed_inprice'
      MaxLength = 14
      StyleController = scStyle
      StoredValues = 2
    end
  end
end
