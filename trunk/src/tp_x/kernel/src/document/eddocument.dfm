inherited feddocument: Tfeddocument
  Tag = 1
  Left = 245
  Top = 148
  Caption = 'feddocument'
  ClientHeight = 523
  ClientWidth = 667
  DefaultMonitor = dmDesktop
  OldCreateOrder = True
  ExplicitWidth = 675
  ExplicitHeight = 557
  PixelsPerInch = 96
  TextHeight = 13
  inherited Splitter1: TSplitter
    Top = 289
    Width = 667
    ExplicitTop = 289
    ExplicitWidth = 762
  end
  object s_v_splitter: TSplitter [1]
    Left = 517
    Top = 129
    Height = 160
    Align = alRight
    ExplicitLeft = 605
    ExplicitTop = 184
    ExplicitHeight = 351
  end
  inherited ZControlBar2: ZControlBar
    Width = 667
    ExplicitWidth = 667
    inherited tool_bar: ZToolBar
      Width = 126
      ExplicitWidth = 126
    end
    object ZToolBar1: ZToolBar
      Left = 150
      Top = 2
      Width = 147
      Height = 21
      AutoSize = True
      ButtonHeight = 21
      Caption = 'XToolBar1'
      EdgeInner = esNone
      EdgeOuter = esNone
      TabOrder = 1
      Visible = False
      object ed_default: TdxPopupEdit
        Left = 0
        Top = 0
        Width = 137
        Style.BorderStyle = xbsFlat
        Style.ButtonStyle = btsFlat
        TabOrder = 0
        TabStop = False
        Visible = False
        Text = #1055#1072#1088#1072#1084#1077#1090#1088#1080' '#1079#1072' '#1079#1072#1084#1086#1074#1095'.'
        PopupControl = p_default
        PopupFormBorderStyle = pbsSimple
        OnCloseUp = ed_defaultCloseUp
      end
    end
  end
  inherited g_dic: TdxDBGrid
    Width = 517
    Height = 160
    KeyField = 'DOC_REC_ID'
    Filter.Criteria = {00000000}
    ExplicitWidth = 517
    ExplicitHeight = 160
    object g_dicDOC_REC_ID: TdxDBGridMaskColumn
      BandIndex = 0
      RowIndex = 0
      FieldName = 'DOC_REC_ID'
    end
    object g_dicCODE_WARES: TdxDBGridMaskColumn
      BandIndex = 0
      RowIndex = 0
      FieldName = 'CODE_WARES'
    end
    object g_dicNAME_WARES: TdxDBGridMaskColumn
      BandIndex = 0
      RowIndex = 0
      FieldName = 'NAME_WARES'
    end
    object g_dicNAME_WARES_BRAND: TdxDBGridMaskColumn
      BandIndex = 0
      RowIndex = 0
      FieldName = 'NAME_WARES_BRAND'
    end
    object g_dicABR_UNIT: TdxDBGridMaskColumn
      BandIndex = 0
      RowIndex = 0
      FieldName = 'ABR_UNIT'
    end
    object g_dicQUANTITY: TdxDBGridMaskColumn
      BandIndex = 0
      RowIndex = 0
      FieldName = 'QUANTITY'
    end
    object g_dicPRICE: TdxDBGridMaskColumn
      BandIndex = 0
      RowIndex = 0
      FieldName = 'PRICE'
    end
    object g_dicSUMA: TdxDBGridMaskColumn
      BandIndex = 0
      RowIndex = 0
      FieldName = 'SUMA'
    end
    object g_dicPRICE_WITH_VAT: TdxDBGridMaskColumn
      BandIndex = 0
      RowIndex = 0
      FieldName = 'PRICE_WITH_VAT'
    end
    object g_dicSUMA_WITH_VAT: TdxDBGridMaskColumn
      BandIndex = 0
      RowIndex = 0
      FieldName = 'SUMA_WITH_VAT'
    end
  end
  inherited p_choicer: TPanel
    Top = 293
    Width = 667
    Height = 230
    ExplicitTop = 293
    ExplicitWidth = 667
    ExplicitHeight = 230
  end
  object Panel1: TPanel [5]
    Left = 230
    Top = 224
    Width = 265
    Height = 145
    Caption = 'Panel1'
    TabOrder = 3
    Visible = False
    object p_default: TPanel
      Left = 24
      Top = 16
      Width = 217
      Height = 106
      AutoSize = True
      TabOrder = 0
      object p_default_kilk: TPanel
        Left = 1
        Top = 1
        Width = 215
        Height = 40
        Align = alTop
        BevelOuter = bvNone
        Ctl3D = False
        ParentCtl3D = False
        TabOrder = 0
        object Label1: TLabel
          Left = 8
          Top = 16
          Width = 46
          Height = 13
          Caption = #1050#1110#1083#1100#1082#1110#1089#1090#1100
        end
        object ed_default_kilk: TdxCalcEdit
          Left = 120
          Top = 8
          Width = 89
          Hint = #1050'-'#1090#1100' '#1079#1072' '#1079#1072#1084#1086#1074#1095#1091#1074#1072#1085#1085#1103#1084
          ParentShowHint = False
          ShowHint = True
          Style.BorderStyle = xbsFlat
          Style.ButtonStyle = btsFlat
          TabOrder = 0
          TabStop = False
          OnKeyPress = ed_default_kilkKeyPress
          Text = '1'
          OnChange = ed_default_kilkChange
        end
      end
      object p_price_type: TPanel
        Left = 1
        Top = 41
        Width = 215
        Height = 32
        Align = alTop
        BevelOuter = bvNone
        Ctl3D = False
        ParentCtl3D = False
        TabOrder = 1
        object Label3: TLabel
          Left = 8
          Top = 11
          Width = 57
          Height = 13
          Caption = #1060#1086#1088#1084'. '#1094#1110#1085#1080
        end
        object ed_price_type: TdxImageEdit
          Left = 80
          Top = 0
          Width = 129
          Style.BorderStyle = xbsFlat
          Style.ButtonStyle = btsFlat
          TabOrder = 0
          Text = '0'
          OnChange = ed_price_typeChange
          Descriptions.Strings = (
            #1062#1056'.'
            #1050#1086#1077#1092'.'
            #1062#1056'. * '#1050#1086#1077#1092'.'
            #1062#1047' * '#1050#1086#1077#1092'.'
            #1057#1077#1088'. '#1062#1047' * '#1050#1086#1077#1092'.')
          ImageIndexes.Strings = (
            '0'
            '1'
            '2'
            '3'
            '4')
          Values.Strings = (
            '0'
            '1'
            '2'
            '3'
            '4')
        end
      end
      object p_koef: TPanel
        Left = 1
        Top = 73
        Width = 215
        Height = 32
        Align = alTop
        BevelOuter = bvNone
        Ctl3D = False
        ParentCtl3D = False
        TabOrder = 2
        object Label2: TLabel
          Left = 8
          Top = 8
          Width = 54
          Height = 13
          Caption = #1050#1086#1077#1092#1110#1094#1110#1108#1085#1090
        end
        object ed_default_koef: TdxCalcEdit
          Left = 120
          Top = 0
          Width = 89
          Hint = #1050'-'#1090#1100' '#1079#1072' '#1079#1072#1084#1086#1074#1095#1091#1074#1072#1085#1085#1103#1084
          ParentShowHint = False
          ShowHint = True
          Style.BorderStyle = xbsFlat
          Style.ButtonStyle = btsFlat
          TabOrder = 0
          TabStop = False
          OnKeyPress = ed_default_kilkKeyPress
          Text = '1'
          OnChange = ed_default_koefChange
        end
      end
    end
  end
  inherited p_header: TPanel
    Width = 667
    TabOrder = 4
    ExplicitWidth = 667
    inherited m_header: TdxMemo
      Width = 665
      ExplicitWidth = 665
      Height = 99
    end
  end
  object ed_description: TdxMemo [7]
    Left = 520
    Top = 129
    Width = 147
    Align = alRight
    TabOrder = 5
    ReadOnly = True
    StyleController = scStyle
    Lines.Strings = (
      'ed_description')
    Height = 160
    StoredValues = 64
  end
  inherited base: TIBDatabase
    DatabaseName = '192.168.0.223:tp_svn'
    Top = 272
  end
  inherited q_dic: TIBQuery
    AfterScroll = q_dicAfterScroll
    OnCalcFields = q_dicCalcFields
    SQL.Strings = (
      
        'select dr.doc_rec_id, dr.code_wares, w.name_wares, w.name_wares_' +
        'brand, dr.quantity,'
      '    ud.abr_unit,'
      '    dr.price_with_vat / (1 + dr.vat/100) as PRICE,'
      '    dr.price_with_vat / (1 + dr.vat/100) * dr.quantity as SUMA,'
      '    dr.price_with_vat,'
      '    dr.price_with_vat * dr.quantity as SUMA_WITH_VAT'
      '    from t_doc_recs dr, wares w, unit_dimension ud'
      '        where dr.doc_id = :idocument_id'
      '            and dr.code_wares = w.code_wares'
      '            and dr.code_unit = ud.code_unit'
      'order by dr.doc_rec_id'
      ''
      '        '
      '')
    ParamData = <
      item
        DataType = ftUnknown
        Name = 'idocument_id'
        ParamType = ptUnknown
      end>
    object q_dicDOC_REC_ID: TIntegerField
      DisplayLabel = 'ID'
      FieldName = 'DOC_REC_ID'
      Origin = '"T_DOC_RECS"."DOC_REC_ID"'
      ProviderFlags = [pfInUpdate, pfInWhere, pfInKey]
      Required = True
    end
    object q_dicCODE_WARES: TIntegerField
      DisplayLabel = #1050#1086#1076' '#1090#1086#1074#1072#1088#1091
      FieldName = 'CODE_WARES'
      Origin = '"T_DOC_RECS"."CODE_WARES"'
    end
    object q_dicNAME_WARES: TIBStringField
      DisplayLabel = #1053#1072#1079#1074#1072' '#1090#1086#1074#1072#1088#1091
      FieldName = 'NAME_WARES'
      Origin = '"WARES"."NAME_WARES"'
      Size = 100
    end
    object q_dicNAME_WARES_BRAND: TIBStringField
      DisplayLabel = #1053#1072#1079#1074#1072' '#1074#1110#1076' '#1087#1086#1089#1090#1072#1095#1072#1083#1100#1085#1080#1082#1072
      FieldName = 'NAME_WARES_BRAND'
      Origin = '"WARES"."NAME_WARES_BRAND"'
      Size = 100
    end
    object q_dicABR_UNIT: TIBStringField
      DisplayLabel = #1054#1076#1080#1085#1080#1094#1103
      FieldName = 'ABR_UNIT'
      Origin = '"UNIT_DIMENSION"."ABR_UNIT"'
      FixedChar = True
      Size = 4
    end
    object q_dicQUANTITY: TFloatField
      DisplayLabel = #1050#1110#1083#1100#1082#1110#1089#1090#1100
      FieldName = 'QUANTITY'
      Origin = '"T_DOC_RECS"."QUANTITY"'
      DisplayFormat = '0.000'
    end
    object q_dicPRICE: TFloatField
      DisplayLabel = #1062#1110#1085#1072
      FieldName = 'PRICE'
      ProviderFlags = []
      DisplayFormat = '0.000'
    end
    object q_dicSUMA: TFloatField
      DisplayLabel = #1057#1091#1084#1072
      FieldName = 'SUMA'
      ProviderFlags = []
      DisplayFormat = '0.000'
    end
    object q_dicPRICE_WITH_VAT: TFloatField
      DisplayLabel = #1062#1110#1085#1072' '#1079' '#1055#1044#1042
      FieldName = 'PRICE_WITH_VAT'
      Origin = '"T_DOC_RECS"."PRICE_WITH_VAT"'
      DisplayFormat = '0.000'
    end
    object q_dicSUMA_WITH_VAT: TFloatField
      DisplayLabel = #1057#1091#1084#1072' '#1079' '#1055#1044#1042
      FieldName = 'SUMA_WITH_VAT'
      ProviderFlags = []
      DisplayFormat = '0.000'
    end
  end
  inherited upd_dic: TIBUpdateSQL
    RefreshSQL.Strings = (
      'Select '
      'from PS_DOCUMENT_RECORDS_VIEW '
      'where'
      '  ODISC_PERSENT = :ODISC_PERSENT and'
      '  ODOCREC_ID = :ODOCREC_ID and'
      '  OGENERAL_PRICE = :OGENERAL_PRICE and'
      '  OKILK = :OKILK and'
      '  ONOMEN_CODE = :ONOMEN_CODE and'
      '  ONOMEN_ID = :ONOMEN_ID and'
      '  ONOMEN_NAME = :ONOMEN_NAME and'
      '  ONOMEN_PRICE = :ONOMEN_PRICE and'
      '  OOUT_PRICE = :OOUT_PRICE and'
      '  OOUT_PRICE_PDV = :OOUT_PRICE_PDV and'
      '  OSUM_IN = :OSUM_IN and'
      '  OSUM_IN_PDV = :OSUM_IN_PDV and'
      '  OSUM_IN1 = :OSUM_IN1 and'
      '  OSUM_OUT = :OSUM_OUT and'
      '  OSUM_OUT_PDV = :OSUM_OUT_PDV and'
      '  OTYPE_PDV = :OTYPE_PDV and'
      '  OTYPEPDV_ID = :OTYPEPDV_ID')
    ModifySQL.Strings = (
      'update PS_DOCUMENT_RECORDS_VIEW'
      'set'
      '  ODISC_PERSENT = :ODISC_PERSENT,'
      '  ODOCREC_ID = :ODOCREC_ID,'
      '  OGENERAL_PRICE = :OGENERAL_PRICE,'
      '  OKILK = :OKILK,'
      '  ONOMEN_CODE = :ONOMEN_CODE,'
      '  ONOMEN_ID = :ONOMEN_ID,'
      '  ONOMEN_NAME = :ONOMEN_NAME,'
      '  ONOMEN_PRICE = :ONOMEN_PRICE,'
      '  OOUT_PRICE = :OOUT_PRICE,'
      '  OOUT_PRICE_PDV = :OOUT_PRICE_PDV,'
      '  OSUM_IN = :OSUM_IN,'
      '  OSUM_IN_PDV = :OSUM_IN_PDV,'
      '  OSUM_IN1 = :OSUM_IN1,'
      '  OSUM_OUT = :OSUM_OUT,'
      '  OSUM_OUT_PDV = :OSUM_OUT_PDV,'
      '  OTYPE_PDV = :OTYPE_PDV,'
      '  OTYPEPDV_ID = :OTYPEPDV_ID'
      'where'
      '  ODISC_PERSENT = :OLD_ODISC_PERSENT and'
      '  ODOCREC_ID = :OLD_ODOCREC_ID and'
      '  OGENERAL_PRICE = :OLD_OGENERAL_PRICE and'
      '  OKILK = :OLD_OKILK and'
      '  ONOMEN_CODE = :OLD_ONOMEN_CODE and'
      '  ONOMEN_ID = :OLD_ONOMEN_ID and'
      '  ONOMEN_NAME = :OLD_ONOMEN_NAME and'
      '  ONOMEN_PRICE = :OLD_ONOMEN_PRICE and'
      '  OOUT_PRICE = :OLD_OOUT_PRICE and'
      '  OOUT_PRICE_PDV = :OLD_OOUT_PRICE_PDV and'
      '  OSUM_IN = :OLD_OSUM_IN and'
      '  OSUM_IN_PDV = :OLD_OSUM_IN_PDV and'
      '  OSUM_IN1 = :OLD_OSUM_IN1 and'
      '  OSUM_OUT = :OLD_OSUM_OUT and'
      '  OSUM_OUT_PDV = :OLD_OSUM_OUT_PDV and'
      '  OTYPE_PDV = :OLD_OTYPE_PDV and'
      '  OTYPEPDV_ID = :OLD_OTYPEPDV_ID')
    InsertSQL.Strings = (
      'insert into PS_DOCUMENT_RECORDS_VIEW'
      
        '  (ODISC_PERSENT, ODOCREC_ID, OGENERAL_PRICE, OKILK, ONOMEN_CODE' +
        ', ONOMEN_ID, '
      
        '   ONOMEN_NAME, ONOMEN_PRICE, OOUT_PRICE, OOUT_PRICE_PDV, OSUM_I' +
        'N, OSUM_IN_PDV, '
      '   OSUM_IN1, OSUM_OUT, OSUM_OUT_PDV, OTYPE_PDV, OTYPEPDV_ID)'
      'values'
      
        '  (:ODISC_PERSENT, :ODOCREC_ID, :OGENERAL_PRICE, :OKILK, :ONOMEN' +
        '_CODE, '
      
        '   :ONOMEN_ID, :ONOMEN_NAME, :ONOMEN_PRICE, :OOUT_PRICE, :OOUT_P' +
        'RICE_PDV, '
      
        '   :OSUM_IN, :OSUM_IN_PDV, :OSUM_IN1, :OSUM_OUT, :OSUM_OUT_PDV, ' +
        ':OTYPE_PDV, '
      '   :OTYPEPDV_ID)')
    DeleteSQL.Strings = (
      'delete from PS_DOCUMENT_RECORDS_VIEW'
      'where'
      '  ODISC_PERSENT = :OLD_ODISC_PERSENT and'
      '  ODOCREC_ID = :OLD_ODOCREC_ID and'
      '  OGENERAL_PRICE = :OLD_OGENERAL_PRICE and'
      '  OKILK = :OLD_OKILK and'
      '  ONOMEN_CODE = :OLD_ONOMEN_CODE and'
      '  ONOMEN_ID = :OLD_ONOMEN_ID and'
      '  ONOMEN_NAME = :OLD_ONOMEN_NAME and'
      '  ONOMEN_PRICE = :OLD_ONOMEN_PRICE and'
      '  OOUT_PRICE = :OLD_OOUT_PRICE and'
      '  OOUT_PRICE_PDV = :OLD_OOUT_PRICE_PDV and'
      '  OSUM_IN = :OLD_OSUM_IN and'
      '  OSUM_IN_PDV = :OLD_OSUM_IN_PDV and'
      '  OSUM_IN1 = :OLD_OSUM_IN1 and'
      '  OSUM_OUT = :OLD_OSUM_OUT and'
      '  OSUM_OUT_PDV = :OLD_OSUM_OUT_PDV and'
      '  OTYPE_PDV = :OLD_OTYPE_PDV and'
      '  OTYPEPDV_ID = :OLD_OTYPEPDV_ID')
  end
end
