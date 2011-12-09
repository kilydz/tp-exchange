object DM: TDM
  OldCreateOrder = False
  Height = 178
  Width = 371
  object Designer: TfrDesigner
    Left = 16
    Top = 72
  end
  object frDialogControls: TfrDialogControls
    Left = 56
    Top = 72
  end
  object tr: TIBTransaction
    DefaultDatabase = Base
    Params.Strings = (
      'read'
      'read_committed'
      'rec_version'
      'nowait')
    Left = 168
    Top = 8
  end
  object Base: TIBDatabase
    DatabaseName = '192.168.0.5:/BASE/SOFTWEST/KRAJ.GDB'
    Params.Strings = (
      'lc_ctype=WIN1251'
      'user_name=sysdba'
      'password=masterkey')
    LoginPrompt = False
    DefaultTransaction = tr
    Left = 16
    Top = 8
  end
  object q: TIBQuery
    Database = Base
    Transaction = tr
    SQL.Strings = (
      'select * from S_DOCREC_VIEW   '
      '(:DOCUMENT_ID) '
      'order by NOMEN_NAME')
    Left = 152
    Top = 64
    ParamData = <
      item
        DataType = ftInteger
        Name = 'DOCUMENT_ID'
        ParamType = ptInput
        Value = '582'
      end>
  end
  object qTitle: TIBQuery
    Database = Base
    Transaction = tr
    SQL.Strings = (
      'select * from PS_DOC_HEADER_VIEW('
      ':DOCUMENT_ID'
      ')')
    Left = 192
    Top = 64
    ParamData = <
      item
        DataType = ftInteger
        Name = 'DOCUMENT_ID'
        ParamType = ptInput
        Value = '582'
      end>
  end
  object q_upd: TIBQuery
    Database = Base
    Transaction = tr_upd
    SQL.Strings = (
      'select * from P_REESTR_ADD ('
      ':DOCUMENT_ID'
      ')')
    Left = 312
    Top = 80
    ParamData = <
      item
        DataType = ftInteger
        Name = 'DOCUMENT_ID'
        ParamType = ptInput
      end>
  end
  object tr_upd: TIBTransaction
    DefaultDatabase = Base
    Params.Strings = (
      'write'
      'concurrency'
      'nowait')
    Left = 296
    Top = 8
  end
  object Report: TfrReport
    Dataset = frDS
    InitialZoom = pzDefault
    PreviewButtons = [pbZoom, pbLoad, pbSave, pbPrint, pbFind, pbHelp, pbExit]
    OnGetValue = ReportGetValue
    OnUserFunction = ReportUserFunction
    OnPrintReport = ReportPrintReport
    Left = 58
    Top = 10
    ReportForm = {18000000}
  end
  object qe_upd: TIBSQL
    Database = Base
    SQL.Strings = (
      'execute procedure PS_ROLL_TAX_ADD (:DOCUMENT_ID)')
    Transaction = tr_upd
    Left = 256
    Top = 80
  end
  object frDS: TfrDBDataSet
    DataSet = q
    Left = 104
    Top = 8
  end
  object frShapeObject1: TfrShapeObject
    Left = 104
    Top = 72
  end
  object frRichObject1: TfrRichObject
    Left = 232
    Top = 8
  end
end
