object dmUsuarios: TdmUsuarios
  OldCreateOrder = False
  Height = 444
  Width = 580
  object sqlUsuarios: TFDQuery
    Connection = dmConexao.SQLConexao
    Left = 32
    Top = 32
  end
  object cdsUsuarios: TClientDataSet
    Aggregates = <>
    Params = <>
    ProviderName = 'dspUsuarios'
    Left = 176
    Top = 32
    object cdsUsuariosid: TStringField
      FieldName = 'id'
      Size = 36
    end
    object cdsUsuariosNome: TStringField
      FieldName = 'nome'
      Size = 50
    end
    object cdsUsuarioslogin: TStringField
      FieldName = 'login'
    end
    object cdsUsuariossenha: TStringField
      FieldName = 'senha'
    end
    object cdsUsuariosstatus: TStringField
      FieldName = 'status'
      Size = 1
    end
    object cdsUsuariosdata_cadastro: TDateField
      FieldName = 'data_cadastro'
    end
  end
  object dspUsuarios: TDataSetProvider
    DataSet = sqlUsuarios
    Options = [poAllowCommandText, poUseQuoteChar]
    Left = 104
    Top = 32
  end
end
