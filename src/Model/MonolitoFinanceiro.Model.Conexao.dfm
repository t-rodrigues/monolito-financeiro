object dmConexao: TdmConexao
  OldCreateOrder = False
  OnCreate = DataModuleCreate
  Height = 355
  Width = 526
  object FDQuery1: TFDQuery
    Connection = SQLConexao
    SQL.Strings = (
      'select * from usuarios order by nome;')
    Left = 40
    Top = 144
  end
  object SQLConexao: TFDConnection
    Left = 48
    Top = 88
  end
end
