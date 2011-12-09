inherited fbranchC: TfbranchC
  Left = 240
  Top = 106
  Caption = 'fbranchC'
  ClientHeight = 214
  ClientWidth = 518
  OldCreateOrder = True
  ExplicitWidth = 524
  ExplicitHeight = 238
  PixelsPerInch = 96
  TextHeight = 13
  inherited master: ZMaster
    Width = 405
    Height = 145
    ExplicitWidth = 405
    ExplicitHeight = 145
  end
  inherited p_pages: TPageControl
    Left = 24
    Top = 64
    Height = 129
    ActivePage = TabSheet1
    ExplicitLeft = 24
    ExplicitTop = 64
    ExplicitHeight = 129
    object TabSheet1: TTabSheet
      Caption = #1055#1072#1088#1072#1084#1077#1090#1088#1080' '#1075#1110#1083#1082#1080
      object Panel1: TPanel
        Left = 16
        Top = 16
        Width = 369
        Height = 65
        TabOrder = 0
        object Label1: TLabel
          Left = 8
          Top = 24
          Width = 53
          Height = 13
          Caption = #1053#1072#1079#1074#1072' (40)'
        end
        object ed_name: TdxEdit
          Left = 72
          Top = 16
          Width = 289
          TabOrder = 0
          Text = 'ed_name'
          OnKeyDown = EditsKeyDown
          OnKeyPress = EditsKeyPress
          OnKeyUp = EditsKeyUp
          MaxLength = 40
          StyleController = scStyle
          StoredValues = 2
        end
      end
    end
  end
end
