inherited fdocrec_dr1: Tfdocrec_dr1
  Left = 241
  Top = 132
  Caption = #1047#1072#1087#1080#1089' '#1074' '#1076#1086#1082#1091#1084#1077#1085#1090#1110
  ClientHeight = 320
  ClientWidth = 609
  OldCreateOrder = True
  ExplicitWidth = 617
  ExplicitHeight = 347
  PixelsPerInch = 96
  TextHeight = 13
  inherited master: ZMaster
    Width = 401
    Height = 289
    ExplicitWidth = 401
    ExplicitHeight = 289
  end
  inherited p_stage0: TPanel
    Left = 200
    Width = 393
    Height = 193
    ExplicitLeft = 200
    ExplicitWidth = 393
    ExplicitHeight = 193
    inherited Label1: TLabel
      Top = 49
      Width = 46
      Caption = #1050#1110#1083#1100#1082#1110#1089#1090#1100
      ExplicitTop = 49
      ExplicitWidth = 46
    end
    object Label2: TLabel [1]
      Left = 227
      Top = 103
      Width = 22
      Height = 13
      Caption = #1062#1110#1085#1072
    end
    object Label4: TLabel [2]
      Left = 227
      Top = 130
      Width = 26
      Height = 13
      Caption = #1057#1091#1084#1072
    end
    object Label3: TLabel [3]
      Left = 8
      Top = 103
      Width = 64
      Height = 13
      Caption = #1062#1110#1085#1072' ('#1079' '#1055#1044#1042')'
    end
    object Label5: TLabel [4]
      Left = 8
      Top = 130
      Width = 68
      Height = 13
      Caption = #1057#1091#1084#1072' ('#1079' '#1055#1044#1042')'
    end
    inherited Label_name: TLabel
      Top = 18
      ExplicitTop = 18
    end
    inherited lbl1: TLabel
      Left = 8
      Top = 76
      ExplicitLeft = 8
      ExplicitTop = 76
    end
    inherited ed_goods_list: TStringGrid
      Top = 160
      Width = 391
      Height = 32
      Enabled = False
      TabOrder = 7
      Visible = False
      OnKeyDown = EditsKeyDown
      OnKeyPress = EditsKeyPress
      OnKeyUp = EditsKeyUp
      ExplicitTop = 160
      ExplicitWidth = 391
      ExplicitHeight = 32
    end
    inherited ed_kilk: TdxCalcEdit
      Left = 88
      Top = 41
      Width = 121
      TabOrder = 0
      OnChange = ed_kilkChange
      ExplicitLeft = 88
      ExplicitTop = 41
      ExplicitWidth = 121
    end
    inherited ed_price: TdxCalcEdit
      Left = 259
      Top = 95
      Width = 122
      TabOrder = 4
      ExplicitLeft = 259
      ExplicitTop = 95
      ExplicitWidth = 122
    end
    inherited ed_sum: TdxCalcEdit
      Left = 259
      Top = 122
      Width = 122
      TabOrder = 5
      ExplicitLeft = 259
      ExplicitTop = 122
      ExplicitWidth = 122
    end
    inherited ed_price_pdv: TdxCalcEdit
      Left = 88
      Top = 95
      Width = 121
      TabOrder = 2
      ExplicitLeft = 88
      ExplicitTop = 95
      ExplicitWidth = 121
    end
    inherited ed_sum_pdv: TdxCalcEdit
      Left = 88
      Top = 122
      Width = 121
      TabOrder = 3
      ExplicitLeft = 88
      ExplicitTop = 122
      ExplicitWidth = 121
    end
    inherited ed_name: TdxEdit
      Width = 289
      ExplicitWidth = 289
      StoredValues = 2
    end
    inherited ed_code_unit: TdxLookupEdit
      Left = 88
      Top = 68
      TabOrder = 1
      ExplicitLeft = 88
      ExplicitTop = 68
    end
  end
end
