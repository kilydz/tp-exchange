inherited forders_view: Tforders_view
  Left = 0
  Top = 0
  Caption = #1042#1110#1076#1086#1073#1088#1072#1078#1077#1085#1085#1103' '#1079#1072#1084#1086#1074#1083#1077#1085#1100
  ClientHeight = 360
  ClientWidth = 688
  Font.Name = 'Tahoma'
  Position = poMainFormCenter
  ExplicitWidth = 696
  ExplicitHeight = 387
  PixelsPerInch = 96
  TextHeight = 13
  inherited panel: TPanel
    Width = 688
    Height = 360
    ExplicitWidth = 688
    ExplicitHeight = 360
    inherited s_v_splitter: TSplitter
      Left = 500
      Height = 197
      ExplicitLeft = 308
      ExplicitHeight = 158
    end
    inherited s_h_splitter: TSplitter
      Top = 197
      Width = 688
      ExplicitTop = 158
      ExplicitWidth = 496
    end
    inherited p_dic: TPanel
      Width = 388
      Height = 197
      ExplicitWidth = 388
      ExplicitHeight = 197
      inherited g_dic: TdxDBGrid
        Width = 386
        Height = 142
        KeyField = 'ONOMEN_ID'
        Filter.Criteria = {00000000}
        ExplicitWidth = 386
        ExplicitHeight = 142
        object g_dicONOMEN_ID: TdxDBGridMaskColumn
          Visible = False
          BandIndex = 0
          RowIndex = 0
          FieldName = 'ONOMEN_ID'
        end
        object g_dicOW3_NOMEN_ID: TdxDBGridMaskColumn
          Caption = #1050#1086#1076' '#1094#1077#1085#1090#1088#1072#1083#1110#1079#1072#1094#1110#1111
          BandIndex = 0
          RowIndex = 0
          FieldName = 'OW3_NOMEN_ID'
        end
        object g_dicONOMEN_CODE: TdxDBGridMaskColumn
          Caption = #1050#1086#1076' '#1090#1086#1074#1072#1088#1091
          BandIndex = 0
          RowIndex = 0
          FieldName = 'ONOMEN_CODE'
        end
        object g_dicONOMEN_NAME: TdxDBGridMaskColumn
          Caption = #1053#1072#1079#1074#1072' '#1090#1086#1074#1072#1088#1091
          BandIndex = 0
          RowIndex = 0
          FieldName = 'ONOMEN_NAME'
        end
        object g_dicODOC_KILK: TdxDBGridMaskColumn
          Caption = #1050'. '#1087#1086' '#1076#1086#1082#1091#1084#1077#1085#1090#1091
          BandIndex = 0
          RowIndex = 0
          FieldName = 'ODOC_KILK'
          SummaryFooterType = cstSum
          SummaryFooterField = 'ODOC_KILK'
          SummaryType = cstSum
          SummaryField = 'ODOC_KILK'
        end
        object g_dicOORDERED: TdxDBGridMaskColumn
          Caption = #1047#1072#1084#1086#1074#1083#1077#1085#1086
          BandIndex = 0
          RowIndex = 0
          FieldName = 'OORDERED'
          SummaryFooterType = cstSum
          SummaryFooterField = 'OORDERED'
          SummaryType = cstSum
          SummaryField = 'OORDERED'
        end
        object g_dicODOC_SUM_OUT: TdxDBGridMaskColumn
          Caption = #1057#1056' '#1087#1086' '#1076#1086#1082#1091#1084'.'
          BandIndex = 0
          RowIndex = 0
          FieldName = 'ODOC_SUM_OUT'
          SummaryFooterType = cstSum
          SummaryFooterField = 'ODOC_SUM_OUT'
          SummaryType = cstSum
          SummaryField = 'ODOC_SUM_OUT'
        end
        object g_dicODOC_SUM_OUT_PDV: TdxDBGridMaskColumn
          Caption = #1057#1056' '#1055#1044#1042' '#1087#1086' '#1076#1086#1082#1091#1084'.'
          BandIndex = 0
          RowIndex = 0
          FieldName = 'ODOC_SUM_OUT_PDV'
          SummaryFooterType = cstSum
          SummaryFooterField = 'ODOC_SUM_OUT_PDV'
          SummaryType = cstSum
          SummaryField = 'ODOC_SUM_OUT_PDV'
        end
        object g_dicOAO_SUM_OUT_PDV: TdxDBGridMaskColumn
          Caption = #1057#1056' '#1055#1044#1042' '#1087#1086' '#1079#1072#1084#1086#1074#1083'.'
          BandIndex = 0
          RowIndex = 0
          FieldName = 'OAO_SUM_OUT_PDV'
          SummaryFooterType = cstSum
          SummaryFooterField = 'OAO_SUM_OUT_PDV'
          SummaryType = cstSum
          SummaryField = 'OAO_SUM_OUT_PDV'
        end
        object g_dicODOC_SUM_IN: TdxDBGridMaskColumn
          Caption = #1057#1047' '#1087#1086' '#1076#1086#1082#1091#1084'.'
          BandIndex = 0
          RowIndex = 0
          FieldName = 'ODOC_SUM_IN'
          SummaryFooterType = cstSum
          SummaryFooterField = 'ODOC_SUM_IN'
          SummaryType = cstSum
          SummaryField = 'ODOC_SUM_IN'
        end
        object g_dicODOC_SUM_IN_PDV: TdxDBGridMaskColumn
          Caption = #1057#1047' '#1055#1044#1042' '#1087#1086' '#1076#1086#1082#1091#1084'.'
          BandIndex = 0
          RowIndex = 0
          FieldName = 'ODOC_SUM_IN_PDV'
          SummaryFooterType = cstSum
          SummaryFooterField = 'ODOC_SUM_IN_PDV'
          SummaryType = cstSum
          SummaryField = 'ODOC_SUM_IN_PDV'
        end
        object g_dicOAO_SUM_IN_PDV: TdxDBGridMaskColumn
          Caption = #1057#1047' '#1087#1086' '#1079#1072#1084#1086#1074#1083'.'
          BandIndex = 0
          RowIndex = 0
          FieldName = 'OAO_SUM_IN_PDV'
          SummaryFooterType = cstSum
          SummaryFooterField = 'OAO_SUM_IN_PDV'
          SummaryType = cstSum
          SummaryField = 'OAO_SUM_IN_PDV'
        end
        object g_dicOAO_LAST_INPRICE: TdxDBGridMaskColumn
          Caption = #1054#1089#1090#1072#1085#1085#1103' '#1062#1047
          BandIndex = 0
          RowIndex = 0
          FieldName = 'OAO_LAST_INPRICE'
        end
      end
      inherited filter_dic: ZFilter
        Top = 171
        Width = 386
        ExplicitTop = 171
        ExplicitWidth = 386
      end
      inherited p_top_control_bar: ZControlBar
        Width = 386
        ExplicitWidth = 386
        inherited p_main_tool_bar: ZToolBar
          Left = 173
          ExplicitLeft = 173
        end
        inherited ToolBar1: TToolBar
          Left = 136
          ExplicitLeft = 136
        end
      end
    end
    inherited p_detaile: TPanel
      Top = 200
      Width = 688
      ExplicitTop = 200
      ExplicitWidth = 688
      inherited g_detaile: TdxDBGrid
        Width = 686
        Filter.Criteria = {00000000}
        ExplicitWidth = 686
      end
      inherited filter_detile: ZFilter
        Width = 686
        ExplicitWidth = 686
      end
    end
    inherited Panel1: TPanel
      Height = 197
      ExplicitHeight = 197
      inherited bt_ins: ZToolButton
        Visible = False
      end
      inherited bt_upd: ZToolButton
        Visible = False
      end
      inherited bt_del: ZToolButton
        Visible = False
      end
      inherited bt_help: ZToolButton
        Top = 173
        ExplicitTop = 134
      end
    end
    inherited p_description: TPanel
      Left = 503
      Height = 197
      ExplicitLeft = 503
      ExplicitHeight = 197
      inherited ed_description: TdxMemo
        ExplicitHeight = 197
        Height = 197
        StoredValues = 64
      end
    end
    inherited pg_pages: TPageControl
      Width = 494
      Height = 291
      ActivePage = TabSheet2
      ExplicitWidth = 494
      ExplicitHeight = 291
      inherited TabSheet2: TTabSheet
        ExplicitLeft = 4
        ExplicitTop = 25
        ExplicitWidth = 486
        ExplicitHeight = 262
        object Splitter1: TSplitter
          Left = 0
          Top = 29
          Width = 486
          Height = 233
          ExplicitTop = 0
          ExplicitHeight = 100
        end
        object p_navigator: TToolBar
          Left = 0
          Top = 0
          Width = 486
          Height = 29
          TabOrder = 0
        end
        object p_panel_detile: TPanel
          Left = 0
          Top = 0
          Width = 486
          Height = 41
          TabOrder = 1
        end
      end
      inherited TabSheet1: TTabSheet
        ExplicitLeft = 4
        ExplicitTop = 25
        ExplicitWidth = 486
        ExplicitHeight = 262
      end
      object TabSheet3: TTabSheet
      end
      object TabSheet4: TTabSheet
      end
    end
  end
  inherited q_dic: TIBQuery
    SQL.Strings = (
      'select * from PS_DOC_AUTOORDERS_VIEW(:idocument_id)'
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
      ''
      ''
      ''
      ''
      '')
    ParamData = <
      item
        DataType = ftUnknown
        Name = 'idocument_id'
        ParamType = ptUnknown
      end>
    object q_dicONOMEN_ID: TIntegerField
      FieldName = 'ONOMEN_ID'
      Origin = '"PS_DOC_AUTOORDERS_VIEW"."ONOMEN_ID"'
    end
    object q_dicOW3_NOMEN_ID: TIntegerField
      FieldName = 'OW3_NOMEN_ID'
      Origin = '"PS_DOC_AUTOORDERS_VIEW"."OW3_NOMEN_ID"'
    end
    object q_dicONOMEN_CODE: TIBStringField
      FieldName = 'ONOMEN_CODE'
      Origin = '"PS_DOC_AUTOORDERS_VIEW"."ONOMEN_CODE"'
      Size = 7
    end
    object q_dicONOMEN_NAME: TIBStringField
      FieldName = 'ONOMEN_NAME'
      Origin = '"PS_DOC_AUTOORDERS_VIEW"."ONOMEN_NAME"'
      Size = 40
    end
    object q_dicODOC_KILK: TFloatField
      FieldName = 'ODOC_KILK'
      Origin = '"PS_DOC_AUTOORDERS_VIEW"."ODOC_KILK"'
      DisplayFormat = '0.00'
    end
    object q_dicOORDERED: TFloatField
      FieldName = 'OORDERED'
      Origin = '"PS_DOC_AUTOORDERS_VIEW"."OORDERED"'
      DisplayFormat = '0.00'
    end
    object q_dicODOC_SUM_OUT: TFloatField
      FieldName = 'ODOC_SUM_OUT'
      Origin = '"PS_DOC_AUTOORDERS_VIEW"."ODOC_SUM_OUT"'
      DisplayFormat = '0.00'
    end
    object q_dicODOC_SUM_OUT_PDV: TFloatField
      FieldName = 'ODOC_SUM_OUT_PDV'
      Origin = '"PS_DOC_AUTOORDERS_VIEW"."ODOC_SUM_OUT_PDV"'
      DisplayFormat = '0.00'
    end
    object q_dicOAO_SUM_OUT_PDV: TFloatField
      FieldName = 'OAO_SUM_OUT_PDV'
      Origin = '"PS_DOC_AUTOORDERS_VIEW"."OAO_SUM_OUT_PDV"'
      DisplayFormat = '0.00'
    end
    object q_dicODOC_SUM_IN: TFloatField
      FieldName = 'ODOC_SUM_IN'
      Origin = '"PS_DOC_AUTOORDERS_VIEW"."ODOC_SUM_IN"'
      DisplayFormat = '0.00'
    end
    object q_dicODOC_SUM_IN_PDV: TFloatField
      FieldName = 'ODOC_SUM_IN_PDV'
      Origin = '"PS_DOC_AUTOORDERS_VIEW"."ODOC_SUM_IN_PDV"'
      DisplayFormat = '0.00'
    end
    object q_dicOAO_SUM_IN_PDV: TFloatField
      FieldName = 'OAO_SUM_IN_PDV'
      Origin = '"PS_DOC_AUTOORDERS_VIEW"."OAO_SUM_IN_PDV"'
      DisplayFormat = '0.00'
    end
    object q_dicOAO_LAST_INPRICE: TFloatField
      FieldName = 'OAO_LAST_INPRICE'
      Origin = '"PS_DOC_AUTOORDERS_VIEW"."OAO_LAST_INPRICE"'
      DisplayFormat = '0.00'
    end
  end
  inherited base: TIBDatabase
    DatabaseName = '192.168.1.33:kraj_0'
  end
end
