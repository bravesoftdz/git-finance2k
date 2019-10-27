object dmTPHistoricoConsulta: TdmTPHistoricoConsulta
  OldCreateOrder = False
  Height = 518
  Width = 808
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
      'JOIN HISTORICO H ON (TPH.ID_HISTORICO = H.ID_HISTORICO)'
      
        'JOIN conta_contabil CD ON (CD.id_conta_contabil = H.id_conta_con' +
        'tabil)'
      ''
      'WHERE (TPH.ID_ORGANIZACAO = :pIdOrganizacao)AND'
      '      (TPH.ID_TITULO_PAGAR = :PID_TITULO_PAGAR)'
      ''
      'ORDER BY TPH.VALOR;'
      '')
    Left = 172
    Top = 160
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
end
