object fgroup_dlg: Tfgroup_dlg
  Left = 287
  Top = 430
  BorderStyle = bsToolWindow
  Caption = 'fgroup_dlg'
  ClientHeight = 102
  ClientWidth = 252
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  Position = poMainFormCenter
  PixelsPerInch = 96
  TextHeight = 13
  object l_prompt: TLabel
    Left = 24
    Top = 15
    Width = 40
    Height = 13
    Caption = 'l_prompt'
  end
  object ed_input: TdxEdit
    Left = 22
    Top = 32
    Width = 209
    Style.BorderStyle = cbsSingle
    TabOrder = 0
    MaxLength = 50
    StoredValues = 2
  end
  object btn_ok: TButton
    Left = 49
    Top = 65
    Width = 75
    Height = 25
    Caption = '&OK'
    ModalResult = 1
    TabOrder = 1
    OnClick = btn_okClick
  end
  object btn_cancel: TButton
    Left = 129
    Top = 65
    Width = 75
    Height = 25
    Cancel = True
    Caption = '&'#1042#1110#1076#1084#1086#1074#1072
    ModalResult = 2
    TabOrder = 2
  end
end
