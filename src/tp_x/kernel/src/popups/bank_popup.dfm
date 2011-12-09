inherited fbank_popup: Tfbank_popup
  Left = 0
  Top = 0
  Caption = 'fbank_popup'
  ClientHeight = 346
  ClientWidth = 476
  Font.Name = 'Tahoma'
  ExplicitWidth = 484
  ExplicitHeight = 380
  PixelsPerInch = 96
  TextHeight = 13
  inherited panel: TPanel
    Left = 8
    Top = 8
    ExplicitLeft = 8
    ExplicitTop = 8
    inherited g_dic: TdxDBGrid
      KeyField = 'BANKS_ID'
      Filter.Criteria = {00000000}
      object g_dicBANKS_ID: TdxDBGridMaskColumn
        Visible = False
        Width = 69
        BandIndex = 0
        RowIndex = 0
        FieldName = 'BANKS_ID'
      end
      object g_dicMFO: TdxDBGridMaskColumn
        Caption = #1052#1060#1054
        Width = 103
        BandIndex = 0
        RowIndex = 0
        FieldName = 'MFO'
      end
      object g_dicNAME: TdxDBGridMaskColumn
        Caption = #1053#1072#1079#1074#1072' '#1073#1072#1085#1082#1091
        Width = 294
        BandIndex = 0
        RowIndex = 0
        FieldName = 'NAME'
      end
    end
  end
  inherited q_dic: TIBQuery
    SQL.Strings = (
      'select banks_id, mfo, name from t_banks '
      ''
      ''
      ''
      ''
      ''
      ''
      ''
      ''
      ''
      ''
      ''
      ''
      ''
      'order by mfo'
      '')
    object q_dicBANKS_ID: TIntegerField
      FieldName = 'BANKS_ID'
      Origin = '"BANKS"."BANKS_ID"'
      ProviderFlags = [pfInUpdate, pfInWhere, pfInKey]
      Required = True
    end
    object q_dicMFO: TIBStringField
      FieldName = 'MFO'
      Origin = '"BANKS"."MFO"'
    end
    object q_dicNAME: TIBStringField
      FieldName = 'NAME'
      Origin = '"BANKS"."NAME"'
      Size = 40
    end
  end
end
