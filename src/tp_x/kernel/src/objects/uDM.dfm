object DataModule1: TDataModule1
  OldCreateOrder = False
  Height = 92
  Width = 258
  object IBDatabase1: TIBDatabase
    TraceFlags = [tfQExecute, tfError, tfStmt, tfConnect, tfTransact, tfService, tfMisc]
    Left = 24
    Top = 24
  end
  object IBTransaction1: TIBTransaction
    DefaultDatabase = IBDatabase1
    Params.Strings = (
      'read_committed'
      'rec_version'
      'nowait'
      'read')
    Left = 104
    Top = 24
  end
  object IBSQL1: TIBSQL
    Database = IBDatabase1
    Transaction = IBTransaction1
    Left = 184
    Top = 24
  end
end
