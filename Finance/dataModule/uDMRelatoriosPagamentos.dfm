object dmRelPagamentos: TdmRelPagamentos
  OldCreateOrder = False
  OnCreate = DataModuleCreate
  Height = 665
  Width = 1183
  object qryTitulosExcel: TFDQuery
    Connection = dmConexao.Conn
    SQL.Strings = (
      'SELECT'
      'CE.ID_CEDENTE AS IDENT_CEDENTE,'
      'CE.NOME AS CEDENTE,'
      'TP.NUMERO_DOCUMENTO AS DOC, '
      'TP.DATA_EMISSAO AS DATA_EMISSAO,'
      'TP.DATA_VENCIMENTO AS DATA_VCTO,'
      'TP.DATA_PAGAMENTO AS DATA_PAGTO,'
      'TP.DESCRICAO AS DESCRICAO,'
      'H.ID_HISTORICO AS ID_HIST,'
      'H.DESCRICAO AS DSC_HIST,'
      'CC.DESCRICAO AS DSC_CONTA_CTBIL,'
      'CC.CONTA AS CONTA_CTBIL,'
      'CC.ID_CONTA_CONTABIL AS ID_CONTA_CTBIL,'
      'TP.VALOR_NOMINAL AS VALOR,'
      'TP.ID_TIPO_STATUS AS STATUS,'
      'CCT.ID_CENTRO_CUSTO AS ID_CST,'
      'CCT.DESCRICAO AS CENTRO_CST'
      ' '
      'FROM  TITULO_PAGAR TP'
      ' '
      
        'LEFT OUTER JOIN CEDENTE CE ON (TP.ID_CEDENTE = CE.ID_CEDENTE AND' +
        ' CE.ID_ORGANIZACAO = TP.ID_ORGANIZACAO)'
      
        'LEFT OUTER JOIN CONTA_CONTABIL CC ON (CC.ID_CONTA_CONTABIL = TP.' +
        'ID_CONTA_CONTABIL_DEBITO AND CC.ID_ORGANIZACAO = TP.ID_ORGANIZAC' +
        'AO)'
      
        'LEFT OUTER JOIN HISTORICO H ON (H.ID_HISTORICO = TP.ID_HISTORICO' +
        ' AND H.ID_ORGANIZACAO = TP.ID_ORGANIZACAO)'
      
        'LEFT OUTER JOIN CENTRO_CUSTO CCT ON (CCT.ID_CENTRO_CUSTO = TP.ID' +
        '_CENTRO_CUSTO  AND CCT.ID_ORGANIZACAO = TP.ID_ORGANIZACAO)'
      ''
      ' '
      '   WHERE (TP.ID_TIPO_STATUS <> '#39'EXCLUIDO'#39') AND '
      '        (TP.ID_ORGANIZACAO = :PIDORGANIZACAO) AND'
      
        '        (TP.data_emissao between :DTDATAINICIAL AND :DTDATAFINAL' +
        ')'
      '        ORDER BY TP.DATA_VENCIMENTO DESC;'
      '')
    Left = 48
    Top = 464
    ParamData = <
      item
        Name = 'PIDORGANIZACAO'
        DataType = ftString
        ParamType = ptInput
        Size = 36
      end
      item
        Name = 'DTDATAINICIAL'
        DataType = ftDate
        ParamType = ptInput
      end
      item
        Name = 'DTDATAFINAL'
        DataType = ftDate
        ParamType = ptInput
      end>
  end
  object qryCentroCusto: TFDQuery
    Connection = dmConexao.Conn
    FormatOptions.AssignedValues = [fvFmtDisplayDate, fvFmtDisplayNumeric, fvFmtEditNumeric]
    FormatOptions.FmtDisplayDate = 'DD/MM/YYYY'
    FormatOptions.FmtDisplayNumeric = '###,##0.00'
    FormatOptions.FmtEditNumeric = '###,##0.00'
    SQL.Strings = (
      'SELECT'
      '  CC.ID_CENTRO_CUSTO,'
      '  CC.DESCRICAO'
      'FROM'
      '  CENTRO_CUSTO CC'
      'WHERE (CC.ID_ORGANIZACAO = :PIDORGANIZACAO)')
    Left = 776
    Top = 32
    ParamData = <
      item
        Name = 'PIDORGANIZACAO'
        DataType = ftString
        ParamType = ptInput
        Size = 36
      end>
  end
  object sqlScriptContainer: TFDScript
    SQLScripts = <
      item
        Name = 'sqlRelPagamentos'
        SQL.Strings = (
          'SELECT'
          '  TP.NUMERO_DOCUMENTO,'
          '  TP.VALOR_NOMINAL,'
          '  TP.DESCRICAO,'
          '  H.DESCRICAO AS DESC_HISTORICO,'
          '  CC.DESCRICAO AS CENTRO_DE_CUSTO,'
          '  CCTP.DESCRICAO AS CENTRO_DE_CUSTO_PRINCIPAL,'
          '  C.NOME AS NOME_CEDENTE,'
          '  TP.DATA_VENCIMENTO AS DATA_VENCIMENTO,'
          '  TP.DATA_PAGAMENTO AS DATA_PAGAMENTO,'
          '  T.DESCRICAO AS STATUS,'
          '  TP.ID_ORGANIZACAO,'
          '  TP.PARCELA,'
          '  TP.ID_TITULO_PAGAR'
          ''
          'FROM'
          '  TITULO_PAGAR TP'
          ' '
          
            '  LEFT OUTER JOIN TITULO_PAGAR_RATEIO_CC TPC ON (TPC.ID_TITULO_P' +
            'AGAR = TP.ID_TITULO_PAGAR  AND TPC.ID_ORGANIZACAO = TP.ID_ORGANI' +
            'ZACAO)'
          ''
          
            '  LEFT OUTER JOIN TIPO_STATUS T ON (T.ID_TIPO_STATUS = TP.ID_TIP' +
            'O_STATUS AND T.ID_ORGANIZACAO = TP.ID_ORGANIZACAO)'
          ''
          
            '  LEFT OUTER JOIN CENTRO_CUSTO CC ON (CC.ID_CENTRO_CUSTO = TPC.I' +
            'D_CENTRO_CUSTO AND CC.ID_ORGANIZACAO = TP.ID_ORGANIZACAO)'
          ''
          
            '  LEFT OUTER JOIN CENTRO_CUSTO CCTP ON (CCTP.ID_CENTRO_CUSTO = T' +
            'P.ID_CENTRO_CUSTO AND CC.ID_ORGANIZACAO = TP.ID_ORGANIZACAO)'
          ''
          
            '  LEFT OUTER JOIN HISTORICO H ON (H.ID_HISTORICO = TP.ID_HISTORI' +
            'CO AND H.ID_ORGANIZACAO = TP.ID_ORGANIZACAO)'
          ''
          
            '  LEFT OUTER JOIN CEDENTE C ON (C.ID_CEDENTE = TP.ID_CEDENTE AND' +
            ' C.ID_ORGANIZACAO = TP.ID_ORGANIZACAO)')
      end>
    Connection = dmConexao.Conn
    Params = <>
    Macros = <>
    FetchOptions.AssignedValues = [evItems, evAutoClose, evAutoFetchAll]
    FetchOptions.AutoClose = False
    FetchOptions.Items = [fiBlobs, fiDetails]
    ResourceOptions.AssignedValues = [rvMacroCreate, rvMacroExpand, rvDirectExecute, rvPersistent]
    ResourceOptions.MacroCreate = False
    ResourceOptions.DirectExecute = True
    Left = 888
    Top = 32
  end
  object qryObterCentroCustoPorTitulo: TFDQuery
    Connection = dmConexao.Conn
    FormatOptions.AssignedValues = [fvFmtDisplayDate, fvFmtDisplayNumeric, fvFmtEditNumeric]
    FormatOptions.FmtDisplayDate = 'DD/MM/YYY'
    FormatOptions.FmtDisplayNumeric = '###,##0.00'
    FormatOptions.FmtEditNumeric = '###,##0.00'
    SQL.Strings = (
      'SELECT TPC.VALOR,       '
      '       TPC.ID_TITULO_PAGAR,'
      '       CC.DESCRICAO,TPC.ID_ORGANIZACAO,  '
      '       CC.CODIGO'
      '        '
      'FROM TITULO_PAGAR_RATEIO_CC TPC'
      
        'LEFT OUTER JOIN CENTRO_CUSTO CC ON (CC.ID_CENTRO_CUSTO = TPC.ID_' +
        'CENTRO_CUSTO)'
      ''
      'WHERE    (TPC.ID_ORGANIZACAO  = :PIDORGANIZACAO) AND'
      '         (TPC.ID_TITULO_PAGAR = :PIDTITULOPAGAR) '
      'ORDER BY TPC.VALOR'
      ''
      '       ')
    Left = 644
    Top = 232
    ParamData = <
      item
        Name = 'PIDORGANIZACAO'
        DataType = ftString
        ParamType = ptInput
        Size = 36
      end
      item
        Name = 'PIDTITULOPAGAR'
        DataType = ftString
        ParamType = ptInput
        Size = 36
      end>
  end
  object qryTotalDebitoPorFornecedor: TFDQuery
    Connection = dmConexao.Conn
    FormatOptions.AssignedValues = [fvFmtDisplayDate, fvFmtDisplayNumeric, fvFmtEditNumeric]
    FormatOptions.FmtDisplayDate = 'DD/MM/YY'
    FormatOptions.FmtDisplayNumeric = '###,##0.00'
    FormatOptions.FmtEditNumeric = '###,##0.00'
    SQL.Strings = (
      'SELECT SUM(TP.VALOR_NOMINAL) as DEBITO'
      'FROM  TITULO_PAGAR TP'
      ''
      'WHERE (TP.ID_CEDENTE = :PIDCEDENTE) AND'
      '      (TP.ID_TIPO_STATUS in ('#39'ABERTO'#39', '#39'PARCIAL'#39','#39'QUITADO'#39')) AND'
      '      (TP.ID_ORGANIZACAO = :PIDORGANIZACAO)AND'
      
        '      (TP.DATA_EMISSAO  BETWEEN :DTDATAINICIAL AND :DTDATAFINAL)' +
        ';')
    Left = 400
    Top = 536
    ParamData = <
      item
        Name = 'PIDCEDENTE'
        DataType = ftString
        ParamType = ptInput
        Size = 36
      end
      item
        Name = 'PIDORGANIZACAO'
        DataType = ftString
        ParamType = ptInput
        Size = 36
      end
      item
        Name = 'DTDATAINICIAL'
        DataType = ftDate
        ParamType = ptInput
      end
      item
        Name = 'DTDATAFINAL'
        DataType = ftDate
        ParamType = ptInput
      end>
  end
  object qryTotalQuitadoPorFornecedor: TFDQuery
    Connection = dmConexao.Conn
    FormatOptions.AssignedValues = [fvFmtDisplayDate, fvFmtDisplayNumeric, fvFmtEditNumeric]
    FormatOptions.FmtDisplayDate = 'DD/MM/YY'
    FormatOptions.FmtDisplayNumeric = '###,##0.00'
    FormatOptions.FmtEditNumeric = '###,##0.00'
    SQL.Strings = (
      'SELECT SUM(TP.VALOR_NOMINAL)as DEBITO'
      ''
      'FROM  TITULO_PAGAR TP'
      ''
      'WHERE (TP.ID_CEDENTE = :PIDCEDENTE) AND'
      '      (TP.ID_TIPO_STATUS in ('#39'QUITADO'#39', '#39'PARCIAL'#39')) AND'
      '      (TP.ID_ORGANIZACAO = :PIDORGANIZACAO)AND'
      '      (TP.DATA_EMISSAO BETWEEN :DTDATAINICIAL AND :DTDATAFINAL);'
      '')
    Left = 568
    Top = 536
    ParamData = <
      item
        Name = 'PIDCEDENTE'
        DataType = ftString
        ParamType = ptInput
        Size = 36
      end
      item
        Name = 'PIDORGANIZACAO'
        DataType = ftString
        ParamType = ptInput
        Size = 36
      end
      item
        Name = 'DTDATAINICIAL'
        DataType = ftDate
        ParamType = ptInput
      end
      item
        Name = 'DTDATAFINAL'
        DataType = ftDate
        ParamType = ptInput
      end>
  end
  object dsTitulosPagarAll: TDataSource
    DataSet = qryTitulosPorFornecedor
    Left = 296
    Top = 328
  end
  object qryTitulosPorFornecedor: TFDQuery
    Connection = dmConexao.Conn
    FormatOptions.AssignedValues = [fvFmtDisplayDate, fvFmtDisplayNumeric, fvFmtEditNumeric]
    FormatOptions.FmtDisplayDate = 'DD/MM/YYYY'
    FormatOptions.FmtDisplayNumeric = '###,##0.00'
    FormatOptions.FmtEditNumeric = '###,##0.00'
    SQL.Strings = (
      'SELECT *'
      'FROM  TITULO_PAGAR TP'
      'WHERE (TP.ID_CEDENTE = :PIDCEDENTE) AND'
      '      (TP.ID_TIPO_STATUS in ('#39'ABERTO'#39','#39'QUITADO'#39', '#39'PARCIAL'#39')) AND'
      '      (TP.ID_ORGANIZACAO = :PIDORGANIZACAO)AND'
      '      (TP.DATA_EMISSAO BETWEEN :DTDATAINICIAL AND :DTDATAFINAL)'
      'ORDER BY TP.DATA_EMISSAO, TP.VALOR_NOMINAL'
      '')
    Left = 720
    Top = 536
    ParamData = <
      item
        Name = 'PIDCEDENTE'
        DataType = ftString
        ParamType = ptInput
        Size = 36
      end
      item
        Name = 'PIDORGANIZACAO'
        DataType = ftString
        ParamType = ptInput
        Size = 36
      end
      item
        Name = 'DTDATAINICIAL'
        DataType = ftDate
        ParamType = ptInput
      end
      item
        Name = 'DTDATAFINAL'
        DataType = ftDate
        ParamType = ptInput
      end>
  end
  object qryRelPagamentos: TFDQuery
    Connection = dmConexao.Conn
    FormatOptions.AssignedValues = [fvFmtDisplayDate, fvFmtDisplayNumeric, fvFmtEditNumeric]
    FormatOptions.FmtDisplayDate = 'DD/MM/YYYY'
    FormatOptions.FmtDisplayNumeric = '###,##0.00'
    FormatOptions.FmtEditNumeric = '###,##0.00'
    SQL.Strings = (
      'SELECT'
      '  TP.NUMERO_DOCUMENTO,'
      '  TP.ID_TITULO_PAGAR,'
      '  TP.ID_ORGANIZACAO,  '
      '  TP.VALOR_NOMINAL,'
      '  TP.PARCELA,'
      '  TP.DATA_VENCIMENTO AS DATA_VENCIMENTO,'
      '  TP.DATA_PAGAMENTO AS DATA_PAGAMENTO,'
      '  TP.DESCRICAO,'
      '  H.DESCRICAO AS DESC_HISTORICO,'
      '  C.NOME AS NOME_CEDENTE,'
      '  T.DESCRICAO AS STATUS,'
      '  CC.DESCRICAO AS CENTRO_DE_CUSTO'
      '  '
      'FROM'
      '  TITULO_PAGAR TP'
      
        '  LEFT OUTER JOIN TIPO_STATUS T ON (T.ID_TIPO_STATUS = TP.ID_TIP' +
        'O_STATUS AND T.ID_ORGANIZACAO = TP.ID_ORGANIZACAO)'
      
        '  LEFT OUTER JOIN CENTRO_CUSTO CC ON (CC.ID_CENTRO_CUSTO = TP.ID' +
        '_CENTRO_CUSTO AND T.ID_ORGANIZACAO = TP.ID_ORGANIZACAO)'
      
        '  LEFT OUTER JOIN HISTORICO H ON (H.ID_HISTORICO = TP.ID_HISTORI' +
        'CO AND H.ID_ORGANIZACAO = TP.ID_ORGANIZACAO)'
      
        '  LEFT OUTER JOIN CEDENTE C ON (C.ID_CEDENTE = TP.ID_CEDENTE AND' +
        ' C.ID_ORGANIZACAO = TP.ID_ORGANIZACAO)'
      ''
      'WHERE TP.ID_TIPO_STATUS = '#39'EXCLUIDO'#39
      ''
      'ORDER BY TP.VALOR_NOMINAL asc')
    Left = 440
    Top = 40
  end
  object dsTituloPagarExcel: TDataSource
    DataSet = qryRelPagamentos
    Left = 184
    Top = 328
  end
  object qryObterTodos: TFDQuery
    Connection = dmConexao.Conn
    SQL.Strings = (
      
        'SELECT TP.ID_TITULO_PAGAR, TP.ID_ORGANIZACAO, TP.NUMERO_DOCUMENT' +
        'O, TP.VALOR_NOMINAL, TP.DESCRICAO, TP.DATA_EMISSAO, TP.DATA_VENC' +
        'IMENTO, TP.DATA_PAGAMENTO, TP.DATA_PROTOCOLO, TP.PARCELA, C.NOME' +
        ' AS FORNECEDOR'
      'FROM  TITULO_PAGAR TP'
      
        'LEFT OUTER JOIN CEDENTE C ON (C.ID_CEDENTE = TP.ID_CEDENTE) AND ' +
        '(C.ID_ORGANIZACAO = TP.ID_ORGANIZACAO)'
      ''
      'WHERE (TP.ID_TIPO_STATUS in ('#39'ABERTO'#39','#39'QUITADO'#39','#39'PARCIAL'#39')) AND'
      '      (TP.ID_ORGANIZACAO = :PIDORGANIZACAO)'
      ''
      'ORDER BY TP.DATA_VENCIMENTO DESC, TP.VALOR_NOMINAL'
      '')
    Left = 64
    Top = 40
    ParamData = <
      item
        Name = 'PIDORGANIZACAO'
        DataType = ftString
        ParamType = ptInput
      end>
  end
  object qryObterPorNumeroDocumento: TFDQuery
    Connection = dmConexao.Conn
    SQL.Strings = (
      'SELECT *'
      'FROM  TITULO_PAGAR TP'
      'WHERE (TP.numero_documento = :PNUMDOC) AND'
      '      (TP.ID_ORGANIZACAO   = :PIDORGANIZACAO);'
      '')
    Left = 64
    Top = 176
    ParamData = <
      item
        Name = 'PNUMDOC'
        DataType = ftString
        ParamType = ptInput
        Size = 50
      end
      item
        Name = 'PIDORGANIZACAO'
        DataType = ftString
        ParamType = ptInput
        Size = 36
      end>
  end
  object qryObterTotalPorStatus: TFDQuery
    Connection = dmConexao.Conn
    FormatOptions.AssignedValues = [fvFmtDisplayDate, fvFmtDisplayNumeric, fvFmtEditNumeric]
    FormatOptions.FmtDisplayDate = 'DD/MM/YYYY'
    FormatOptions.FmtDisplayNumeric = '###,##0.00'
    FormatOptions.FmtEditNumeric = '###,##0.00'
    SQL.Strings = (
      'SELECT SUM(TP.VALOR_NOMINAL)DEBITO'
      'FROM  TITULO_PAGAR TP'
      'WHERE (TP.ID_TIPO_STATUS = :PIDSTATUS) AND'
      '      (TP.ID_ORGANIZACAO = :PIDORGANIZACAO)AND'
      '      (TP.DATA_EMISSAO BETWEEN :DTDATAINICIAL AND :DTDATAFINAL);'
      '')
    Left = 64
    Top = 104
    ParamData = <
      item
        Name = 'PIDSTATUS'
        ParamType = ptInput
      end
      item
        Name = 'PIDORGANIZACAO'
        DataType = ftString
        ParamType = ptInput
        Size = 36
      end
      item
        Name = 'DTDATAINICIAL'
        DataType = ftDate
        ParamType = ptInput
      end
      item
        Name = 'DTDATAFINAL'
        DataType = ftDate
        ParamType = ptInput
      end>
  end
  object dsTitulosExcel: TDataSource
    DataSet = qryTitulosExcel
    Left = 392
    Top = 328
  end
  object qryObterTPHistoricoPorTitulo: TFDQuery
    Connection = dmConexao.Conn
    SQL.Strings = (
      'SELECT TPH.ID_TITULO_PAGAR, '
      '       TPH.VALOR, H.DESCRICAO,TPH.ID_ORGANIZACAO,  '
      '       H.CODIGO, '
      '       CD.conta, '
      '       CD.codreduz'
      '        '
      'FROM TITULO_PAGAR_HISTORICO TPH'
      
        'LEFT OUTER JOIN HISTORICO H ON (TPH.ID_HISTORICO = H.ID_HISTORIC' +
        'O)'
      
        'LEFT OUTER JOIN conta_contabil CD ON (CD.id_conta_contabil = H.i' +
        'd_conta_contabil)'
      ''
      'WHERE (TPH.ID_ORGANIZACAO  = :PIDORGANIZACAO)AND'
      '      (TPH.ID_TITULO_PAGAR = :PIDTITULOPAGAR)'
      ''
      'ORDER BY TPH.VALOR;'
      '')
    Left = 648
    Top = 168
    ParamData = <
      item
        Name = 'PIDORGANIZACAO'
        DataType = ftString
        ParamType = ptInput
        Size = 36
      end
      item
        Name = 'PIDTITULOPAGAR'
        DataType = ftString
        ParamType = ptInput
        Size = 36
      end>
  end
end
