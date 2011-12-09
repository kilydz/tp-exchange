inherited fgroup: Tfgroup
  Left = 298
  Top = 338
  Caption = #1043#1088#1091#1087#1072' '#1082#1086#1088#1080#1089#1090#1091#1074#1072#1095#1110#1074
  ClientHeight = 257
  ClientWidth = 382
  OldCreateOrder = True
  PixelsPerInch = 96
  TextHeight = 13
  inherited master: ZMaster
    Width = 361
    ExplicitWidth = 361
  end
  inherited p_pages: TPageControl
    Left = 8
    Top = 32
    Width = 361
    Height = 177
    ActivePage = tab_sheet_0
    ExplicitLeft = 8
    ExplicitTop = 32
    ExplicitWidth = 361
    ExplicitHeight = 177
    object tab_sheet_0: TTabSheet
      Caption = #1053#1072#1079#1074#1072' '#1075#1088#1091#1087#1080
      ExplicitLeft = 0
      ExplicitTop = 0
      ExplicitWidth = 0
      ExplicitHeight = 0
      object page_0: TPanel
        Left = 0
        Top = 0
        Width = 353
        Height = 149
        Align = alClient
        TabOrder = 0
        object Label1: TLabel
          Left = 27
          Top = 19
          Width = 84
          Height = 13
          Caption = #1053#1072#1079#1074#1072' '#1075#1088#1091#1087#1080' (50)'
        end
        object ed_name: TdxEdit
          Left = 120
          Top = 16
          Width = 201
          TabOrder = 0
          OnKeyDown = EditsKeyDown
          OnKeyPress = EditsKeyPress
          OnKeyUp = EditsKeyUp
          MaxLength = 50
          StyleController = scStyle
          StoredValues = 2
        end
      end
    end
  end
  inherited base: TIBDatabase
    DatabaseName = 'D:\prj\CRM_2_1\base\CRM.GDB'
    Left = 256
    Top = 24
  end
  inherited trR: TIBTransaction
    Left = 288
    Top = 24
  end
  inherited qR: TIBSQL
    Left = 328
    Top = 24
  end
  inherited qW: TIBSQL
    Left = 328
    Top = 56
  end
  inherited trW: TIBTransaction
    Left = 288
    Top = 56
  end
  inherited scStyle: TdxEditStyleController
    Left = 552
    Top = 16
  end
end
