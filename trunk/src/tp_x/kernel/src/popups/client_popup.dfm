inherited fclient_popup: Tfclient_popup
  Left = 324
  Top = 218
  Caption = 'fclient_popup'
  ClientHeight = 353
  ClientWidth = 529
  OldCreateOrder = True
  ExplicitWidth = 537
  ExplicitHeight = 387
  PixelsPerInch = 96
  TextHeight = 13
  inherited panel: TPanel
    Left = 8
    Top = 8
    Width = 509
    ExplicitLeft = 8
    ExplicitTop = 8
    ExplicitWidth = 509
    inherited p_top_control_bar: ZControlBar
      Width = 507
      ExplicitWidth = 507
      inherited p_main_tool_bar: ZToolBar
        AutoSize = False
      end
      object ZToolBar1: ZToolBar
        Left = 126
        Top = 2
        Width = 332
        Height = 22
        AutoSize = True
        ButtonHeight = 21
        Caption = 'XToolBar1'
        EdgeInner = esNone
        EdgeOuter = esNone
        TabOrder = 1
        object ed_flag: TdxImageEdit
          Left = 0
          Top = 0
          Width = 161
          Hint = #1058#1080#1087' '#1082#1083#1110#1108#1085#1090#1072
          Enabled = False
          ParentShowHint = False
          ShowHint = True
          Style.BorderColor = clGray
          Style.BorderStyle = xbsFlat
          Style.ButtonStyle = btsFlat
          Style.ButtonTransparence = ebtNone
          TabOrder = 0
          Text = 'ed_flag'
          OnChange = ed_flagChange
          Descriptions.Strings = (
            #1057#1082#1083#1072#1076#1080
            #1055#1086#1089#1090#1072#1095#1072#1083#1100#1085#1080#1082#1080
            #1055#1086#1089#1090#1072#1095#1072#1083#1100#1085#1080#1082#1080' '#1090#1072' '#1087#1086#1082#1091#1087#1094#1110
            #1040#1082#1090#1080#1074#1085#1110' '#1087#1086#1089#1090#1072#1095#1072#1083#1100#1085#1080#1082#1080
            #1042#1085#1091#1090#1088#1110#1096#1085#1110' '#1082#1083#1110#1108#1085#1090#1080
            #1055#1086#1089#1090#1072#1095#1072#1083#1100#1085#1080#1082#1080' '#1090#1072' '#1074#1085#1091#1090#1088#1110#1096#1085#1110)
          ImageIndexes.Strings = (
            '0'
            '1'
            '2'
            '3'
            '4'
            '5')
          Values.Strings = (
            '1'
            '3'
            '2'
            '4'
            '5'
            '6')
        end
        object ToolButton2: TToolButton
          Left = 161
          Top = 0
          Width = 8
          Caption = 'ToolButton2'
          Style = tbsSeparator
        end
        object ed_grpc_id: TdxPopupEdit
          Left = 169
          Top = 0
          Width = 161
          Hint = #1044#1077#1088#1077#1074#1086' '#1082#1083#1110#1077#1085#1090#1110#1074
          ParentShowHint = False
          ShowHint = True
          Style.BorderColor = clGray
          Style.BorderStyle = xbsFlat
          Style.ButtonStyle = btsFlat
          Style.ButtonTransparence = ebtNone
          TabOrder = 1
          Text = #1059#1089#1110' '#1075#1088#1091#1087#1080
          PopupFormBorderStyle = pbsSysPanel
        end
      end
    end
    inherited g_dic: TdxDBGrid
      Width = 507
      KeyField = 'OCLIENT_ID'
      Filter.Criteria = {00000000}
      ExplicitWidth = 507
      object g_dicOCLIENT_ID: TdxDBGridMaskColumn
        Visible = False
        Width = 71
        BandIndex = 0
        RowIndex = 0
        FieldName = 'OCLIENT_ID'
      end
      object g_dicOCODE: TdxDBGridMaskColumn
        Caption = #1050#1086#1076
        Width = 65
        BandIndex = 0
        RowIndex = 0
        FieldName = 'OCODE'
      end
      object g_dicOSHORT_NAME: TdxDBGridMaskColumn
        Caption = #1050#1086#1088'. '#1085#1072#1079#1074#1072
        Width = 184
        BandIndex = 0
        RowIndex = 0
        FieldName = 'OSHORT_NAME'
      end
      object g_dicOFULL_NAME: TdxDBGridMaskColumn
        Caption = #1055#1086#1074#1085#1072' '#1085#1072#1079#1074#1072
        Width = 304
        BandIndex = 0
        RowIndex = 0
        FieldName = 'OFULL_NAME'
      end
      object g_dicOADRESS: TdxDBGridMaskColumn
        Caption = #1040#1076#1088#1077#1089#1072
        Width = 304
        BandIndex = 0
        RowIndex = 0
        FieldName = 'OADRESS'
      end
      object g_dicZKPO: TdxDBGridMaskColumn
        Caption = #1047#1050#1055#1054
        BandIndex = 0
        RowIndex = 0
        FieldName = 'ZKPO'
      end
    end
    inherited filter_dic: ZFilter
      Width = 507
      ExplicitWidth = 507
    end
    inherited Panel1: TPanel
      Width = 507
      ExplicitWidth = 507
    end
  end
  inherited q_dic: TIBQuery
    SQL.Strings = (
      
        'select oclient_id, ocode, oshort_name, ofull_name, oadress, ogrp' +
        'c_id, ois_pdv, c.zkpo'
      ' from ps_popup_clients_view(:iflag, :igrpc_id)'
      'pc left join t_clients c on c.clients_id = pc.oclient_id'
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
        Name = 'iflag'
        ParamType = ptUnknown
      end
      item
        DataType = ftUnknown
        Name = 'igrpc_id'
        ParamType = ptUnknown
      end>
    object q_dicOCLIENT_ID: TIntegerField
      FieldName = 'OCLIENT_ID'
      Origin = '"PS_POPUP_CLIENTS_VIEW"."OCLIENT_ID"'
    end
    object q_dicOCODE: TIBStringField
      FieldName = 'OCODE'
      Origin = '"PS_POPUP_CLIENTS_VIEW"."OCODE"'
      Size = 7
    end
    object q_dicOSHORT_NAME: TIBStringField
      FieldName = 'OSHORT_NAME'
      Origin = '"PS_POPUP_CLIENTS_VIEW"."OSHORT_NAME"'
      Size = 30
    end
    object q_dicOFULL_NAME: TIBStringField
      FieldName = 'OFULL_NAME'
      Origin = '"PS_POPUP_CLIENTS_VIEW"."OFULL_NAME"'
      Size = 50
    end
    object q_dicOADRESS: TIBStringField
      DisplayWidth = 160
      FieldName = 'OADRESS'
      Origin = '"PS_POPUP_CLIENTS_VIEW"."OADRESS"'
      Size = 160
    end
    object q_dicOGRPC_ID: TIntegerField
      FieldName = 'OGRPC_ID'
      Origin = '"PS_POPUP_CLIENTS_VIEW"."OGRPC_ID"'
    end
    object q_dicOIS_PDV: TSmallintField
      FieldName = 'OIS_PDV'
      Origin = '"PS_POPUP_CLIENTS_VIEW"."OIS_PDV"'
    end
    object q_dicZKPO: TIBStringField
      FieldName = 'ZKPO'
      Origin = '"CLIENTS"."ZKPO"'
    end
  end
  inherited dic_images: TImageList
    Left = 360
    Top = 88
  end
  inherited images: TImageList
    Left = 360
    Top = 40
  end
  inherited scStyle: TdxEditStyleController
    BorderStyle = xbsFlat
    Left = 408
    Top = 40
  end
end
