inherited fuser: Tfuser
  Left = 298
  Top = 338
  Caption = #1050#1086#1088#1080#1089#1090#1091#1074#1072#1095
  ClientHeight = 283
  ClientWidth = 449
  OldCreateOrder = True
  ExplicitWidth = 455
  ExplicitHeight = 307
  PixelsPerInch = 96
  TextHeight = 13
  inherited master: ZMaster
    Width = 377
    Height = 257
    ExplicitWidth = 377
    ExplicitHeight = 257
  end
  inherited p_pages: TPageControl
    Left = 64
    Top = 32
    Width = 361
    Height = 185
    ActivePage = tab_sheet_1
    ExplicitLeft = 64
    ExplicitTop = 32
    ExplicitWidth = 361
    ExplicitHeight = 185
    object tab_sheet_0: TTabSheet
      Caption = #1051#1086#1075#1110#1085
      object page_2: TPanel
        Left = 0
        Top = 0
        Width = 353
        Height = 157
        Align = alClient
        TabOrder = 0
        object Label7: TLabel
          Left = 10
          Top = 14
          Width = 48
          Height = 13
          Caption = #1051#1086#1075#1110#1085' (12)'
        end
        object Label8: TLabel
          Left = 88
          Top = 44
          Width = 59
          Height = 13
          Caption = #1055#1072#1088#1086#1083#1100' (20)'
        end
        object Label9: TLabel
          Left = 10
          Top = 71
          Width = 137
          Height = 13
          Caption = #1055#1110#1076#1090#1074#1077#1088#1076#1078#1077#1085#1085#1103' '#1087#1072#1088#1086#1083#1103' (20)'
        end
        object Label4: TLabel
          Left = 10
          Top = 98
          Width = 114
          Height = 13
          Caption = #1062#1080#1092#1088#1086#1074#1080#1081' '#1087#1110#1076#1087#1080#1089' (128)'
          Visible = False
        end
        object Label5: TLabel
          Left = 10
          Top = 125
          Width = 123
          Height = 13
          Caption = #1055#1110#1076#1090#1074#1077#1088#1076#1078#1077#1085#1085#1103' '#1062#1055' (128)'
          Visible = False
        end
        object Label6: TLabel
          Left = 234
          Top = 14
          Width = 31
          Height = 13
          Caption = #1053#1110#1082' (3)'
        end
        object ed_login: TdxEdit
          Left = 64
          Top = 9
          Width = 164
          TabOrder = 0
          OnKeyDown = EditsKeyDown
          OnKeyPress = EditsKeyPress
          OnKeyUp = EditsKeyUp
          CharCase = ecUpperCase
          MaxLength = 12
          StyleController = scStyle
          StoredValues = 2
        end
        object ed_keyword: TdxEdit
          Left = 153
          Top = 36
          Width = 176
          TabOrder = 2
          OnKeyDown = EditsKeyDown
          OnKeyPress = EditsKeyPress
          OnKeyUp = EditsKeyUp
          MaxLength = 20
          PasswordChar = '*'
          StyleController = scStyle
          StoredValues = 2
        end
        object ed_confirm: TdxEdit
          Left = 153
          Top = 63
          Width = 176
          TabOrder = 3
          OnKeyDown = EditsKeyDown
          OnKeyPress = EditsKeyPress
          OnKeyUp = EditsKeyUp
          MaxLength = 20
          PasswordChar = '*'
          StyleController = scStyle
          StoredValues = 2
        end
        object ed_signature: TdxEdit
          Left = 139
          Top = 117
          Width = 190
          TabOrder = 4
          Visible = False
          OnKeyDown = EditsKeyDown
          OnKeyPress = EditsKeyPress
          OnKeyUp = EditsKeyUp
          MaxLength = 20
          PasswordChar = '*'
          StyleController = scStyle
          StoredValues = 2
        end
        object ed_signature_confirm: TdxEdit
          Left = 139
          Top = 90
          Width = 190
          TabOrder = 5
          Visible = False
          OnKeyDown = EditsKeyDown
          OnKeyPress = EditsKeyPress
          OnKeyUp = EditsKeyUp
          MaxLength = 20
          PasswordChar = '*'
          StyleController = scStyle
          StoredValues = 2
        end
        object ed_nick: TdxEdit
          Left = 271
          Top = 9
          Width = 57
          TabOrder = 1
          OnKeyDown = EditsKeyDown
          OnKeyPress = EditsKeyPress
          OnKeyUp = EditsKeyUp
          MaxLength = 3
          StyleController = scStyle
          StoredValues = 2
        end
      end
    end
    object tab_sheet_1: TTabSheet
      Caption = #1043#1088#1091#1087#1072
      ImageIndex = 1
      object page_1: TPanel
        Left = 0
        Top = 0
        Width = 353
        Height = 157
        Align = alClient
        TabOrder = 0
        object Label3: TLabel
          Left = 12
          Top = 16
          Width = 29
          Height = 13
          Caption = #1043#1088#1091#1087#1072
        end
        object ed_rights_grp: TdxImageEdit
          Left = 56
          Top = 8
          Width = 273
          TabOrder = 0
          OnKeyDown = EditsKeyDown
          OnKeyPress = EditsKeyPress
          OnKeyUp = EditsKeyUp
          StyleController = scStyle
        end
      end
    end
    object tab_sheet_2: TTabSheet
      Caption = #1055#1030#1041
      ImageIndex = 2
      object page_0: TPanel
        Left = 0
        Top = 0
        Width = 353
        Height = 157
        Align = alClient
        TabOrder = 0
        object Label1: TLabel
          Left = 43
          Top = 19
          Width = 70
          Height = 13
          Caption = #1055#1088#1110#1079#1074#1080#1097#1077' (50)'
        end
        object Label2: TLabel
          Left = 73
          Top = 53
          Width = 40
          Height = 13
          Caption = #1030#1084#39#1103' (50)'
        end
        object Label10: TLabel
          Left = 32
          Top = 85
          Width = 81
          Height = 13
          Caption = #1055#1086'-'#1073#1072#1090#1100#1082#1086#1074#1110' (50)'
        end
        object ed_surname: TdxEdit
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
        object ed_first_name: TdxEdit
          Left = 120
          Top = 48
          Width = 201
          TabOrder = 1
          OnKeyDown = EditsKeyDown
          OnKeyPress = EditsKeyPress
          OnKeyUp = EditsKeyUp
          MaxLength = 50
          StyleController = scStyle
          StoredValues = 2
        end
        object ed_second_name: TdxEdit
          Left = 120
          Top = 80
          Width = 201
          TabOrder = 2
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
    Left = 384
    Top = 48
  end
  object secure_service: TIBSecurityService
    LoginPrompt = False
    TraceFlags = []
    Left = 32
    Top = 112
  end
end
