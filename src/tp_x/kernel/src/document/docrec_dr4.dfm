inherited fdocrec_dr4: Tfdocrec_dr4
  Left = 281
  Caption = #1047#1072#1087#1080#1089' '#1074' '#1076#1086#1082#1091#1084#1077#1085#1090#1110
  ClientWidth = 577
  OldCreateOrder = True
  ExplicitWidth = 593
  PixelsPerInch = 96
  TextHeight = 13
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
    inherited ed_goods_list: TStringGrid
      Height = 168
      TabOrder = 5
      OnClick = ed_goods_listClick
      OnKeyDown = EditsKeyDown
      OnKeyPress = EditsKeyPress
      OnKeyUp = EditsKeyUp
      OnSelectCell = ed_goods_listSelectCell
      ExplicitHeight = 168
    end
    inherited ed_kilk: TdxCalcEdit
      TabOrder = 0
    end
    inherited ed_price: TdxCalcEdit
      Enabled = False
      TabOrder = 1
    end
    inherited ed_sum: TdxCalcEdit
      Enabled = False
    end
    inherited ed_price_pdv: TdxCalcEdit
      Enabled = False
      TabOrder = 2
    end
    inherited ed_sum_pdv: TdxCalcEdit
      Enabled = False
      TabOrder = 4
    end
    inherited ed_name: TdxEdit
      StoredValues = 2
    end
  end
end
