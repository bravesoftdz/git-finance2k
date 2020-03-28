object dmHistoricoConsulta: TdmHistoricoConsulta
  OldCreateOrder = False
  Height = 303
  Width = 479
  object qryObterHistoricoSemContaContabil: TFDQuery
    Connection = dmConexao.Conn
    SQL.Strings = (
      'SELECT H.descricao, H.CODIGO'
      'FROM  HISTORICO H'
      'WHERE (H.ID_ORGANIZACAO = :pIdOrganizacao) AND'
      '      (H.id_conta_contabil IS NULL)')
    Left = 128
    Top = 64
    ParamData = <
      item
        Name = 'PIDORGANIZACAO'
        DataType = ftString
        ParamType = ptInput
        Size = 36
      end>
  end
  object qryObterTPHistoricoPorTitulo: TFDQuery
    Connection = dmConexao.Conn
    FormatOptions.AssignedValues = [fvDefaultParamDataType, fvFmtDisplayDate, fvFmtDisplayNumeric, fvFmtEditNumeric]
    FormatOptions.DefaultParamDataType = ftString
    FormatOptions.FmtDisplayDate = 'DD/MM/YYYY'
    FormatOptions.FmtDisplayNumeric = '###,##0.00'
    FormatOptions.FmtEditNumeric = '###,##0.00'
    SQL.Strings = (
      
        'SELECT TPH.ID_TITULO_PAGAR, TPH.VALOR, H.DESCRICAO,H.CODIGO, CD.' +
        'conta, CD.codreduz'
      '        '
      'FROM TITULO_PAGAR_HISTORICO TPH'
      
        'LEFT OUTER JOIN HISTORICO H ON (TPH.ID_HISTORICO = H.ID_HISTORIC' +
        'O)'
      
        'LEFT OUTER JOIN conta_contabil CD ON (CD.id_conta_contabil = H.i' +
        'd_conta_contabil)'
      ''
      'WHERE (TPH.ID_ORGANIZACAO = :pIdOrganizacao)AND'
      '      (TPH.ID_TITULO_PAGAR = :PID_TITULO_PAGAR)'
      ''
      'ORDER BY TPH.VALOR;'
      '')
    Left = 204
    Top = 192
    ParamData = <
      item
        Name = 'PIDORGANIZACAO'
        DataType = ftString
        ParamType = ptInput
        Size = 36
      end
      item
        Name = 'PID_TITULO_PAGAR'
        DataType = ftString
        ParamType = ptInput
        Size = 36
      end>
  end
  object qryHstSemCC: TFDQuery
    Connection = dmConexao.Conn
    SQL.Strings = (
      'SELECT H.descricao, H.CODIGO'
      'FROM  HISTORICO H'
      'WHERE (H.ID_ORGANIZACAO = :pIdOrganizacao) AND'
      '      (H.id_conta_contabil IS NULL)')
    Left = 312
    Top = 152
    ParamData = <
      item
        Name = 'PIDORGANIZACAO'
        DataType = ftString
        ParamType = ptInput
        Size = 36
      end>
  end
end
