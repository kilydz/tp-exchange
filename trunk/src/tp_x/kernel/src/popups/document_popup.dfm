inherited fdocument_popup: Tfdocument_popup
  Left = 324
  Top = 218
  Caption = 'fdocument_popup'
  ClientWidth = 590
  OldCreateOrder = True
  ExplicitWidth = 598
  PixelsPerInch = 96
  TextHeight = 13
  inherited panel: TPanel
    Width = 561
    ExplicitWidth = 561
    inherited p_top_control_bar: ZControlBar
      Width = 559
      ExplicitWidth = 559
      inherited p_main_tool_bar: ZToolBar
        Width = 109
        AutoSize = False
        ExplicitWidth = 109
      end
      object ZToolBar1: ZToolBar
        Left = 133
        Top = 2
        Width = 372
        Height = 21
        AutoSize = True
        ButtonHeight = 21
        Caption = 'XToolBar1'
        EdgeInner = esNone
        EdgeOuter = esNone
        TabOrder = 1
        object RxLabel1: TRxLabel
          Left = 0
          Top = 0
          Width = 112
          Height = 21
          Alignment = taCenter
          AutoSize = False
          Caption = #1056#1086#1073#1086#1095#1080#1081' '#1087#1077#1088#1110#1086#1076' '#1079
          Font.Charset = DEFAULT_CHARSET
          Font.Color = 7039851
          Font.Height = -11
          Font.Name = 'MS Sans Serif'
          Font.Style = [fsBold]
          Layout = tlCenter
          ParentFont = False
          ShadowColor = 7105644
          ShadowSize = 0
        end
        object ed_date_0: TdxDateEdit
          Left = 112
          Top = 0
          Width = 112
          TabOrder = 0
          TabStop = False
          StyleController = scStyle
          OnChange = ed_date_0Change
          Date = -700000.000000000000000000
        end
        object RxLabel2: TRxLabel
          Left = 224
          Top = 0
          Width = 25
          Height = 21
          Alignment = taCenter
          AutoSize = False
          Caption = #1087#1086
          Font.Charset = DEFAULT_CHARSET
          Font.Color = 7105644
          Font.Height = -11
          Font.Name = 'MS Sans Serif'
          Font.Style = [fsBold]
          Layout = tlCenter
          ParentFont = False
          ShadowColor = 7105644
          ShadowSize = 0
        end
        object ed_date_1: TdxDateEdit
          Left = 249
          Top = 0
          Width = 111
          TabOrder = 1
          TabStop = False
          StyleController = scStyle
          OnChange = ed_date_0Change
          Date = -700000.000000000000000000
        end
      end
    end
    inherited g_dic: TdxDBGrid
      Width = 559
      KeyField = 'ODOCUMENT_ID'
      Filter.Criteria = {00000000}
      ExplicitWidth = 559
      object g_dicODOCUMENT_ID: TdxDBGridMaskColumn
        Caption = 'DOCUMENT_ID'
        Visible = False
        Width = 88
        BandIndex = 0
        RowIndex = 0
        FieldName = 'ODOCUMENT_ID'
        SummaryFooterType = cstCount
        SummaryFooterField = 'ODOCUMENT_ID'
        SummaryType = cstCount
        SummaryField = 'ODOCUMENT_ID'
      end
      object g_dicONUMBER: TdxDBGridMaskColumn
        Alignment = taLeftJustify
        Caption = #8470' '#1076#1086#1082'.'
        Width = 88
        BandIndex = 0
        RowIndex = 0
        FieldName = 'ONUMBER'
        SummaryFooterType = cstCount
        SummaryType = cstCount
      end
      object g_dicOOPLATA_STATE: TdxDBGridImageColumn
        Alignment = taRightJustify
        Caption = ' '
        MinWidth = 16
        Width = 26
        BandIndex = 0
        RowIndex = 0
        FieldName = 'OOPLATA_STATE'
        ImageIndexes.Strings = (
          '0'
          '1'
          '2'
          '3')
        Values.Strings = (
          '0'
          '1'
          '2'
          '3')
      end
      object g_dicOIS_FIXED: TdxDBGridImageColumn
        Alignment = taRightJustify
        Caption = ' '
        MinWidth = 16
        Width = 26
        BandIndex = 0
        RowIndex = 0
        FieldName = 'OIS_FIXED'
        Images = dic_images
        ImageIndexes.Strings = (
          '0'
          '1'
          '2')
        Values.Strings = (
          '0'
          '1'
          '2')
      end
      object g_dicOARROW: TdxDBGridImageColumn
        Alignment = taRightJustify
        Caption = ' '
        MinWidth = 16
        Width = 20
        BandIndex = 0
        RowIndex = 0
        FieldName = 'OARROW'
        ImageIndexes.Strings = (
          '0'
          '1')
        Values.Strings = (
          '0'
          '1')
      end
      object g_dicOOPLATA_TYPE_ID: TdxDBGridImageColumn
        Alignment = taRightJustify
        Caption = #1058#1080#1087' '#1087#1088#1086#1087#1083#1072#1090#1080
        MinWidth = 16
        Width = 83
        BandIndex = 0
        RowIndex = 0
        FieldName = 'OOPLATA_TYPE_ID'
        ShowDescription = True
      end
      object g_dicOTYPEDOC_ID: TdxDBGridImageColumn
        Alignment = taRightJustify
        Caption = #1058#1080#1087' '#1076#1086#1082#1091#1084#1077#1085#1090#1072
        MinWidth = 16
        Width = 90
        BandIndex = 0
        RowIndex = 0
        FieldName = 'OTYPEDOC_ID'
        ImageIndexes.Strings = (
          '0')
        ShowDescription = True
      end
      object g_dicOTOKEN: TdxDBGridMaskColumn
        Caption = #1055#1088#1080#1084#1110#1090#1082#1072
        Width = 88
        BandIndex = 0
        RowIndex = 0
        FieldName = 'OTOKEN'
      end
      object g_dicODATE: TdxDBGridDateColumn
        Caption = #1044#1072#1090#1072' '#1076#1086#1082'.'
        BandIndex = 0
        RowIndex = 0
        FieldName = 'ODATE'
      end
      object g_dicOSRC_NAME: TdxDBGridMaskColumn
        Caption = #1042#1110#1076' '#1082#1086#1075#1086
        Width = 184
        BandIndex = 0
        RowIndex = 0
        FieldName = 'OSRC_NAME'
      end
      object g_dicOSRC_FULLNAME: TdxDBGridMaskColumn
        Caption = #1042#1110#1076' '#1082#1086#1075#1086'('#1087#1086#1074#1085')'
        Width = 304
        BandIndex = 0
        RowIndex = 0
        FieldName = 'OSRC_FULLNAME'
      end
      object g_dicODST_NAME: TdxDBGridMaskColumn
        Caption = #1050#1086#1084#1091
        Width = 184
        BandIndex = 0
        RowIndex = 0
        FieldName = 'ODST_NAME'
      end
      object g_dicODST_FULLNAME: TdxDBGridMaskColumn
        Caption = #1050#1086#1084#1091' ('#1087#1086#1074#1085')'
        Width = 304
        BandIndex = 0
        RowIndex = 0
        FieldName = 'ODST_FULLNAME'
      end
      object g_dicOSUM_IN: TdxDBGridMaskColumn
        Caption = #1057#1047
        BandIndex = 0
        RowIndex = 0
        FieldName = 'OSUM_IN'
        SummaryFooterType = cstSum
        SummaryFooterField = 'OSUM_IN'
        SummaryType = cstSum
        SummaryField = 'OSUM_IN'
      end
      object g_dicOSUM_OUT: TdxDBGridMaskColumn
        Caption = #1057#1056
        BandIndex = 0
        RowIndex = 0
        FieldName = 'OSUM_OUT'
        SummaryFooterType = cstSum
        SummaryFooterField = 'OSUM_OUT'
        SummaryType = cstSum
        SummaryField = 'OSUM_OUT'
      end
      object g_dicOSUM_IN_PDV: TdxDBGridMaskColumn
        Caption = #1057#1047' ('#1079' '#1055#1044#1042')'
        BandIndex = 0
        RowIndex = 0
        FieldName = 'OSUM_IN_PDV'
        SummaryFooterType = cstSum
        SummaryFooterField = 'OSUM_IN_PDV'
        SummaryType = cstSum
        SummaryField = 'OSUM_IN_PDV'
      end
      object g_dicOSUM_OUT_PDV: TdxDBGridMaskColumn
        Caption = #1057#1056' ('#1079' '#1055#1044#1042')'
        BandIndex = 0
        RowIndex = 0
        FieldName = 'OSUM_OUT_PDV'
        SummaryFooterType = cstSum
        SummaryFooterField = 'OSUM_OUT_PDV'
        SummaryType = cstSum
        SummaryField = 'OSUM_OUT_PDV'
      end
      object g_dicOIS_PRINT_TAX: TdxDBGridMaskColumn
        Caption = #1055#1086#1076#1072#1090#1082#1086#1074#1072
        Width = 72
        BandIndex = 0
        RowIndex = 0
        FieldName = 'OIS_PRINT_TAX'
      end
      object g_dicONOTARIZATION: TdxDBGridMaskColumn
        Caption = #1061#1090#1086' '#1087#1110#1076#1090#1074#1077#1088#1076#1080#1074
        Width = 82
        BandIndex = 0
        RowIndex = 0
        FieldName = 'ONOTARIZATION'
      end
      object g_dicODISC_PERSENT: TdxDBGridMaskColumn
        Caption = '% '#1079#1085#1080#1078#1082#1080' '
        Width = 66
        BandIndex = 0
        RowIndex = 0
        FieldName = 'ODISC_PERSENT'
      end
      object g_dicSUM_PDV: TdxDBGridColumn
        Caption = #1057' '#1055#1044#1042
        BandIndex = 0
        RowIndex = 0
        FieldName = 'SUM_PDV'
      end
      object g_dicOSTAFFNAME: TdxDBGridMaskColumn
        Caption = #1042#1110#1076#1087#1086#1074#1110#1076#1072#1083#1100#1085#1080#1081
        BandIndex = 0
        RowIndex = 0
        FieldName = 'OSTAFFNAME'
      end
      object g_dicOZKPO: TdxDBGridMaskColumn
        Caption = #1047#1050#1055#1054
        BandIndex = 0
        RowIndex = 0
        FieldName = 'OZKPO'
      end
      object g_dicOW3_CLIENTS_ID: TdxDBGridMaskColumn
        Caption = #1050#1086#1076' '#1094#1077#1085#1090#1088#1072#1083#1110#1079#1072#1094#1110#1111' '#1082#1083#1110#1108#1085#1090#1072
        BandIndex = 0
        RowIndex = 0
        FieldName = 'OW3_CLIENTS_ID'
      end
    end
    inherited filter_dic: ZFilter
      Width = 559
      ExplicitWidth = 559
    end
    inherited Panel1: TPanel
      Width = 559
      ExplicitWidth = 559
    end
  end
  inherited base: TIBDatabase
    DatabaseName = '192.168.1.33:kraj_0'
  end
  inherited q_dic: TIBQuery
    SQL.Strings = (
      
        'select odocument_id, onumber, otypedoc_id, ois_fixed, otoken, od' +
        'ate, osrc_name, osrc_fullname, odst_name, odst_fullname, osum_in' +
        ', osum_out, osum_in_pdv, osum_out_pdv, ooplata_state, ooplata_ty' +
        'pe_id, otime_cr, oarrow, ois_print_tax, onotarization, odisc_per' +
        'sent, ostaffname, ozkpo, ow3_clients_id from PS_DOCUMENTS_VIEW(:' +
        'idate0, :idate1, :itypes, :ipays, :iis_pays)'
      ''
      ''
      'where odocument_id <> -1'
      ''
      ''
      ''
      ''
      ''
      ''
      '')
    ParamData = <
      item
        DataType = ftUnknown
        Name = 'idate0'
        ParamType = ptUnknown
      end
      item
        DataType = ftUnknown
        Name = 'idate1'
        ParamType = ptUnknown
      end
      item
        DataType = ftUnknown
        Name = 'itypes'
        ParamType = ptUnknown
      end
      item
        DataType = ftUnknown
        Name = 'ipays'
        ParamType = ptUnknown
      end
      item
        DataType = ftUnknown
        Name = 'iis_pays'
        ParamType = ptUnknown
      end>
    object q_dicODOCUMENT_ID: TIntegerField
      FieldName = 'ODOCUMENT_ID'
      Origin = '"PS_DOCUMENTS_VIEW"."ODOCUMENT_ID"'
    end
    object q_dicONUMBER: TIBStringField
      FieldName = 'ONUMBER'
      Origin = '"PS_DOCUMENTS_VIEW"."ONUMBER"'
      Size = 14
    end
    object q_dicOTYPEDOC_ID: TIntegerField
      FieldName = 'OTYPEDOC_ID'
      Origin = '"PS_DOCUMENTS_VIEW"."OTYPEDOC_ID"'
    end
    object q_dicOIS_FIXED: TSmallintField
      FieldName = 'OIS_FIXED'
      Origin = '"PS_DOCUMENTS_VIEW"."OIS_FIXED"'
    end
    object q_dicOTOKEN: TIBStringField
      FieldName = 'OTOKEN'
      Origin = '"PS_DOCUMENTS_VIEW"."OTOKEN"'
      Size = 14
    end
    object q_dicODATE: TDateField
      FieldName = 'ODATE'
      Origin = '"PS_DOCUMENTS_VIEW"."ODATE"'
    end
    object q_dicOSRC_NAME: TIBStringField
      FieldName = 'OSRC_NAME'
      Origin = '"PS_DOCUMENTS_VIEW"."OSRC_NAME"'
      Size = 30
    end
    object q_dicOSRC_FULLNAME: TIBStringField
      FieldName = 'OSRC_FULLNAME'
      Origin = '"PS_DOCUMENTS_VIEW"."OSRC_FULLNAME"'
      Size = 50
    end
    object q_dicODST_NAME: TIBStringField
      FieldName = 'ODST_NAME'
      Origin = '"PS_DOCUMENTS_VIEW"."ODST_NAME"'
      Size = 30
    end
    object q_dicODST_FULLNAME: TIBStringField
      FieldName = 'ODST_FULLNAME'
      Origin = '"PS_DOCUMENTS_VIEW"."ODST_FULLNAME"'
      Size = 50
    end
    object q_dicOSUM_IN: TFloatField
      FieldName = 'OSUM_IN'
      Origin = '"PS_DOCUMENTS_VIEW"."OSUM_IN"'
      DisplayFormat = '0.00'
    end
    object q_dicOSUM_OUT: TFloatField
      FieldName = 'OSUM_OUT'
      Origin = '"PS_DOCUMENTS_VIEW"."OSUM_OUT"'
      DisplayFormat = '0.00'
    end
    object q_dicOSUM_IN_PDV: TFloatField
      FieldName = 'OSUM_IN_PDV'
      Origin = '"PS_DOCUMENTS_VIEW"."OSUM_IN_PDV"'
      DisplayFormat = '0.00'
    end
    object q_dicOSUM_OUT_PDV: TFloatField
      FieldName = 'OSUM_OUT_PDV'
      Origin = '"PS_DOCUMENTS_VIEW"."OSUM_OUT_PDV"'
      DisplayFormat = '0.00'
    end
    object q_dicOOPLATA_STATE: TIntegerField
      FieldName = 'OOPLATA_STATE'
      Origin = '"PS_DOCUMENTS_VIEW"."OOPLATA_STATE"'
    end
    object q_dicMARKUP_SUM: TCurrencyField
      FieldKind = fkCalculated
      FieldName = 'MARKUP_SUM'
      DisplayFormat = '0.00'
      Calculated = True
    end
    object q_dicMARKUP: TCurrencyField
      FieldKind = fkCalculated
      FieldName = 'MARKUP'
      DisplayFormat = '0.00'
      Calculated = True
    end
    object q_dicMARKUP_OFIC: TCurrencyField
      FieldKind = fkCalculated
      FieldName = 'MARKUP_OFIC'
      DisplayFormat = '0.00'
      Calculated = True
    end
    object q_dicOOPLATA_TYPE_ID: TIntegerField
      FieldName = 'OOPLATA_TYPE_ID'
      Origin = '"PS_DOCUMENTS_VIEW"."OOPLATA_TYPE_ID"'
    end
    object q_dicOARROW: TSmallintField
      FieldName = 'OARROW'
      Origin = '"PS_DOCUMENTS_VIEW"."OARROW"'
    end
    object q_dicOIS_PRINT_TAX: TSmallintField
      FieldName = 'OIS_PRINT_TAX'
      Origin = '"PS_DOCUMENTS_VIEW"."OIS_PRINT_TAX"'
    end
    object q_dicONOTARIZATION: TIBStringField
      FieldName = 'ONOTARIZATION'
      Origin = '"PS_DOCUMENTS_VIEW"."ONOTARIZATION"'
      Size = 12
    end
    object q_dicODISC_PERSENT: TFloatField
      FieldName = 'ODISC_PERSENT'
      Origin = '"PS_DOCUMENTS_VIEW"."ODISC_PERSENT"'
    end
    object q_dicSUM_PDV: TCurrencyField
      FieldKind = fkCalculated
      FieldName = 'SUM_PDV'
      Calculated = True
    end
    object q_dicOSTAFFNAME: TIBStringField
      FieldName = 'OSTAFFNAME'
      Origin = '"PS_DOCUMENTS_VIEW"."OSTAFFNAME"'
      Size = 40
    end
    object q_dicOZKPO: TIBStringField
      FieldName = 'OZKPO'
      Origin = '"PS_DOCUMENTS_VIEW"."OZKPO"'
    end
    object q_dicOW3_CLIENTS_ID: TIntegerField
      FieldName = 'OW3_CLIENTS_ID'
      Origin = '"PS_DOCUMENTS_VIEW"."OW3_CLIENTS_ID"'
    end
  end
  inherited dic_images: TImageList
    Left = 360
    Top = 88
  end
  inherited images: TImageList
    Left = 360
    Top = 64
  end
  inherited scStyle: TdxEditStyleController
    Left = 408
    Top = 40
  end
end
