object dmServerMail: TdmServerMail
  OldCreateOrder = False
  Height = 309
  Width = 406
  object qryObterDadosMail: TFDQuery
    Connection = dmConexao.Conn
    SQL.Strings = (
      'SELECT S.HOST, '
      '       S.REMETENTE,'
      '       S.REQUER_AUTENTICACAO,'
      '       S.LOGIN, '
      '       S.SENHA,'
      '       S.PORTA, '
      '       S.ID_SERVIDOR_EMAIL,'
      '       S.ID_ORGANIZACAO'
      'FROM SERVIDOR_EMAIL S WHERE S.ID_ORGANIZACAO = :PIDORGANIZACAO;'
      '')
    Left = 80
    Top = 56
    ParamData = <
      item
        Name = 'PIDORGANIZACAO'
        DataType = ftString
        ParamType = ptInput
        Size = 36
      end>
  end
  object dtsDadosServerMail: TDataSource
    DataSet = qryObterDadosMail
    Left = 248
    Top = 56
  end
  object qrySalvar: TFDQuery
    Connection = dmConexao.Conn
    Left = 88
    Top = 165
  end
end
