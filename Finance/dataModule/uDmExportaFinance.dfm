object dmExportaFinance: TdmExportaFinance
  OldCreateOrder = False
  OnCreate = DataModuleCreate
  Height = 681
  Width = 1141
  object qryGravarLoteContabil: TFDQuery
    Connection = dmConexao.Conn
    Left = 128
    Top = 24
  end
  object qryObterCentroCustoPorTitulo2: TFDQuery
    Connection = dmConexao.Conn
    FormatOptions.AssignedValues = [fvFmtDisplayDate, fvFmtDisplayNumeric, fvFmtEditNumeric]
    FormatOptions.FmtDisplayDate = 'DD/MM/YYY'
    FormatOptions.FmtDisplayNumeric = '###,##0.00'
    FormatOptions.FmtEditNumeric = '###,##0.00'
    SQL.Strings = (
      'SELECT TPC.VALOR,       '
      '       TPC.ID_TITULO_PAGAR,'
      '       CC.DESCRICAO,'
      '       CC.CODIGO'
      '        '
      'FROM TITULO_PAGAR_RATEIO_CC TPC'
      
        'LEFT OUTER  JOIN CENTRO_CUSTO CC ON (CC.ID_CENTRO_CUSTO = TPC.ID' +
        '_CENTRO_CUSTO)'
      ''
      'WHERE    (TPC.ID_ORGANIZACAO = :pIdOrganizacao) AND'
      '         (TPC.ID_TITULO_PAGAR = :pId_TITULO_PAGAR) ;'
      ''
      '       '
      '')
    Left = 132
    Top = 384
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
  object qryObterCBTPERIODO: TFDQuery
    Connection = dmConexao.Conn
    SQL.Strings = (
      'SELECT CBT.DATA_MOVIMENTO AS DATA,'
      '       CBT.VALOR AS VALOR,'
      '       CBT.ID_TIPO_OPERACAO_BANCARIA AS IDOPER,'
      '       CBT.ID_CONTA_BANCARIA_TRANSFERENCIA AS ID, '
      '       CBT.ID_ORGANIZACAO AS IDORG, '
      '       CBT.IDENTIFICACAO AS IDENTIFCRE,'
      '       CBT.IDENTIFICACAO AS IDENTIFDEB,'
      '       CBT.ID_CONTA_BANCARIA_CREDITO AS IDCRE,'
      '       CBT.ID_CONTA_BANCARIA_DEBITO AS IDDEB,'
      '       CCCBD.CONTA AS CONTA_DEB,'
      '       CCCBD.DGVER AS DGDEB,'
      '       CCCBD.CODREDUZ AS CDREDUZDEB,'
      '       CCCBD.DGREDUZ AS DGREDUZDEB,'
      '       CCCBD.DESCRICAO AS DESCTADEBITO,'
      '       CCCBC.CONTA AS CONTA_CRE,'
      '       CCCBC.DGVER AS DGCRE,'
      '       CCCBC.CODREDUZ AS CDREDUZCRE,'
      '       CCCBC.DGREDUZ AS DGREDUZCRE,'
      '       CCCBC.DESCRICAO AS DESCTACREDITO,'
      '       TOPB.TIPO AS TIPOOPERACAO,'
      '       TOPB.CODIGO AS CDHIST,'
      '       TOPB.DESCRICAO AS COMPL,'
      '       TOPB.ID_TIPO_OPERACAO_BANCARIA AS HISTORICO,'
      '       BANCOD.CONTA AS CTAORIGEM,'
      '       BANCOC.CONTA AS CTADESTINO'
      'FROM CONTA_BANCARIA_TRANSFERENCIA CBT'
      ''
      
        'LEFT OUTER JOIN CONTA_BANCARIA_CREDITO CBC ON (CBC.ID_CONTA_BANC' +
        'ARIA_CREDITO = CBT.ID_CONTA_BANCARIA_CREDITO) AND (CBC.ID_ORGANI' +
        'ZACAO=CBT.ID_ORGANIZACAO)'
      
        'LEFT OUTER JOIN  CONTA_BANCARIA BANCOC ON (BANCOC.ID_CONTA_BANCA' +
        'RIA = CBC.ID_CONTA_BANCARIA) AND (BANCOC.ID_ORGANIZACAO=CBT.ID_O' +
        'RGANIZACAO)'
      
        'LEFT OUTER JOIN  CONTA_BANCARIA_DEBITO CBD ON (CBD.ID_CONTA_BANC' +
        'ARIA_DEBITO = CBT.ID_CONTA_BANCARIA_DEBITO) AND (CBD.ID_ORGANIZA' +
        'CAO=CBT.ID_ORGANIZACAO)'
      
        'LEFT OUTER JOIN  CONTA_BANCARIA BANCOD ON (BANCOD.ID_CONTA_BANCA' +
        'RIA = CBD.ID_CONTA_BANCARIA) AND (BANCOD.ID_ORGANIZACAO=CBT.ID_O' +
        'RGANIZACAO)'
      
        'LEFT OUTER JOIN  CONTA_CONTABIL CCCBC ON(CCCBC.ID_CONTA_CONTABIL' +
        ' =BANCOD.ID_CONTA_CONTABIL) AND (CCCBC.ID_ORGANIZACAO=CBT.ID_ORG' +
        'ANIZACAO)'
      
        'LEFT OUTER JOIN  CONTA_CONTABIL CCCBD ON(CCCBD.ID_CONTA_CONTABIL' +
        ' =BANCOC.ID_CONTA_CONTABIL) AND (CCCBD.ID_ORGANIZACAO=CBT.ID_ORG' +
        'ANIZACAO)'
      
        'LEFT OUTER JOIN TIPO_OPERACAO_BANCARIA TOPB ON (TOPB.ID_TIPO_OPE' +
        'RACAO_BANCARIA=CBT.ID_TIPO_OPERACAO_BANCARIA AND TOPB.ID_ORGANIZ' +
        'ACAO=CBT.ID_ORGANIZACAO)'
      ''
      
        'WHERE (CBT.DATA_MOVIMENTO BETWEEN :DTDATAINICIAL AND :DTDATAFINA' +
        'L)  AND'
      '      (CBT.ID_ORGANIZACAO= :PIDORGANIZACAO)  AND'
      '      (CBT.ID_LOTE_CONTABIL IS NULL)'
      ''
      'ORDER BY CBT.DATA_MOVIMENTO, CBT.VALOR')
    Left = 40
    Top = 112
    ParamData = <
      item
        Name = 'DTDATAINICIAL'
        DataType = ftDate
        ParamType = ptInput
      end
      item
        Name = 'DTDATAFINAL'
        DataType = ftDate
        ParamType = ptInput
      end
      item
        Name = 'PIDORGANIZACAO'
        DataType = ftString
        ParamType = ptInput
      end>
  end
  object qryObterCBCPERIODO: TFDQuery
    Connection = dmConexao.Conn
    SQL.Strings = (
      'SELECT CBC.ID_CONTA_BANCARIA_CREDITO AS IDCBC,'
      'CBC.TIPO_LANCAMENTO AS TIPOLANCAMENTO,'
      'CBC.DATA_MOVIMENTO AS DATALANCAMENTO,'
      'CBC.VALOR AS VALORLANCAMENTO,'
      'CBC.DESCRICAO AS DESCLANCAMENTO,'
      'CBC.IDENTIFICACAO AS IDENTIFICACAO,'
      'TOPB.DESCRICAO AS OPERACAO,'
      'TOPB.CODIGO AS CODHISTORICOPADRAO,'
      'TOPB.DESCRICAO AS HISTORICOPADRAO,'
      'TOPB.TIPO AS TIPOOPERACAO,'
      'CCD.CONTA AS CONTADEBITO,'
      'CCD.DESCRICAO AS CCDDESC,'
      'CCD.CODREDUZ AS CCDCODREDUZ,'
      'CCC.CONTA AS CONTACREDITO,'
      'CCC.DESCRICAO AS CCCDESC,'
      'CCC.CODREDUZ AS CCCCODREDUZ,'
      'CB.CONTA AS CONTABANCARIA'
      'FROM CONTA_BANCARIA_CREDITO CBC'
      
        'LEFT OUTER JOIN CONTA_BANCARIA CB ON CBC.ID_CONTA_BANCARIA=CB.ID' +
        '_CONTA_BANCARIA AND CBC.ID_ORGANIZACAO=CB.ID_ORGANIZACAO'
      
        'LEFT OUTER JOIN TIPO_OPERACAO_BANCARIA TOPB ON CBC.ID_TIPO_OPERA' +
        'CAO_BANCARIA=TOPB.ID_TIPO_OPERACAO_BANCARIA AND CBC.ID_ORGANIZAC' +
        'AO=TOPB.ID_ORGANIZACAO'
      
        'LEFT OUTER JOIN CONTA_CONTABIL CCC ON TOPB.ID_CONTA_CONTABIL=CCC' +
        '.ID_CONTA_CONTABIL AND TOPB.ID_ORGANIZACAO=CCC.ID_ORGANIZACAO'
      
        'LEFT OUTER JOIN CONTA_CONTABIL CCD ON CB.ID_CONTA_CONTABIL=CCD.I' +
        'D_CONTA_CONTABIL AND TOPB.ID_ORGANIZACAO=CCD.ID_ORGANIZACAO'
      'WHERE CBC.ID_ORGANIZACAO=:PIDORGANIZACAO'
      'AND CBC.ID_TITULO_RECEBER IS NULL'
      
        'AND CBC.ID_TIPO_OPERACAO_BANCARIA <> '#39'TRANSFERENCIA ENTRE CONTAS' +
        #39
      'AND CBC.DATA_MOVIMENTO BETWEEN :DTDATAINICIAL AND :DTDATAFINAL'
      'ORDER BY CBC.DATA_MOVIMENTO DESC')
    Left = 640
    Top = 552
    ParamData = <
      item
        Name = 'PIDORGANIZACAO'
        DataType = ftString
        ParamType = ptInput
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
  object qryObterCBDPERIODO: TFDQuery
    Connection = dmConexao.Conn
    SQL.Strings = (
      'SELECT CBD.ID_CONTA_BANCARIA_DEBITO AS IDCBD,'
      'CBD.DATA_MOVIMENTO AS DATALANCAMENTO,'
      'CBD.VALOR AS VALORLANCAMENTO,'
      'CBD.DESCRICAO AS DESCLANCAMENTO,'
      'CBD.IDENTIFICACAO AS IDENTIFICACAO,'
      'TOPB.CODIGO AS CODHISTORICOPADRAO,'
      'TOPB.DESCRICAO AS HISTORICOPADRAO,'
      'TOPB.TIPO AS TIPOOPERACAO,'
      'CCD.CONTA AS CONTADEBITO,'
      'CCD.DESCRICAO AS CCDDESC,'
      'CCD.CODREDUZ AS CCDCODREDUZ,'
      'CCC.CONTA AS CONTACREDITO,'
      'CCC.DESCRICAO AS CCCDESC,'
      'CCC.CODREDUZ AS CCCCODREDUZ,'
      'CB.CONTA AS CONTABANCARIA'
      ''
      'FROM CONTA_BANCARIA_DEBITO CBD'
      
        'LEFT OUTER JOIN CONTA_BANCARIA CB ON (CB.ID_CONTA_BANCARIA=CBD.I' +
        'D_CONTA_BANCARIA AND CB.ID_ORGANIZACAO=CBD.ID_ORGANIZACAO)'
      
        'LEFT OUTER JOIN TIPO_OPERACAO_BANCARIA TOPB ON (TOPB.ID_TIPO_OPE' +
        'RACAO_BANCARIA=CBD.ID_TIPO_OPERACAO_BANCARIA AND TOPB.ID_ORGANIZ' +
        'ACAO=CBD.ID_ORGANIZACAO)'
      
        'LEFT OUTER JOIN CONTA_CONTABIL CCD ON (TOPB.ID_CONTA_CONTABIL=CC' +
        'D.ID_CONTA_CONTABIL AND CCD.ID_ORGANIZACAO=TOPB.ID_ORGANIZACAO)'
      
        'LEFT OUTER JOIN CONTA_CONTABIL CCC ON (CB.ID_CONTA_CONTABIL=CCC.' +
        'ID_CONTA_CONTABIL AND CCC.ID_ORGANIZACAO=TOPB.ID_ORGANIZACAO)'
      'WHERE CBD.ID_ORGANIZACAO=:PIDORGANIZACAO'
      'AND CBD.ID_TITULO_PAGAR IS NULL'
      'AND CBD.ID_LOTE_CONTABIL IS NULL'
      
        'AND CBD.ID_TIPO_OPERACAO_BANCARIA <> '#39'TRANSFERENCIA ENTRE CONTAS' +
        #39
      'AND CBD.DATA_MOVIMENTO BETWEEN :DTDATAINICIAL AND :DTDATAFINAL'
      'ORDER BY CBD.DATA_MOVIMENTO DESC')
    Left = 632
    Top = 472
    ParamData = <
      item
        Name = 'PIDORGANIZACAO'
        DataType = ftString
        ParamType = ptInput
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
  object qryObterTDPERIODO: TFDQuery
    Connection = dmConexao.Conn
    SQL.Strings = (
      'SELECT TD.ID_TESOURARIA_DEBITO AS IDTD,'
      'TD.DATA_MOVIMENTO AS DATALANCAMENTO,'
      'TD.DESCRICAO AS DESCLANCAMENTO,'
      'HST.CODIGO AS CODIGOHISTORICOPADRAO,'
      'HST.DESCRICAO AS DESCHISTORICO,'
      'TD.VALOR_NOMINAL AS VALORLANCAMENTO,'
      'TD.TIPO_LANCAMENTO AS TIPOLANCAMENTO,'
      'CCD.CONTA AS CONTADEBITO,'
      'CCD.DESCRICAO AS CCDDESC,'
      'CCD.CODREDUZ AS CCDCODREDUZ'
      
        '--CCC.CONTA AS CONTACREDITO, -- AQUI '#201' A CONTA CAIXA. VER COMO F' +
        'AZER ISSO.'
      '--CCC.DESCRICAO AS CCCDESC,'
      '--CCC.CODREDUZ AS CCCCODREDUZ'
      'FROM TESOURARIA_DEBITO TD'
      
        'LEFT OUTER JOIN HISTORICO HST ON TD.ID_HISTORICO=HST.ID_HISTORIC' +
        'O AND TD.ID_ORGANIZACAO=HST.ID_ORGANIZACAO'
      
        'LEFT OUTER JOIN CONTA_CONTABIL CCD ON (CCD.ID_CONTA_CONTABIL=HST' +
        '.ID_CONTA_CONTABIL AND HST.ID_ORGANIZACAO=CCD.ID_ORGANIZACAO)'
      'WHERE TD.ID_ORGANIZACAO=:PIDORGANIZACAO'
      'AND TD.DATA_MOVIMENTO BETWEEN :DTDATAINICIAL AND :DTDATAFINAL'
      'AND TD.ID_TITULO_PAGAR_BAIXA IS NULL'
      'AND TD.ID_LOTE_CONTABIL IS NULL'
      'AND TD.ID_HISTORICO <> '#39'DEPOSITO TESOURARIA/BANCO'#39)
    Left = 504
    Top = 552
    ParamData = <
      item
        Name = 'PIDORGANIZACAO'
        DataType = ftString
        ParamType = ptInput
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
  object qryObterTCPERIODO: TFDQuery
    Connection = dmConexao.Conn
    SQL.Strings = (
      'SELECT TC.ID_TESOURARIA_CREDITO AS IDTC,'
      'TC.DATA_MOVIMENTO AS DATALANCAMENTO,'
      'TC.DESCRICAO AS DESCLANCAMENTO,'
      'HST.CODIGO AS CODIGOHISTORICOPADRAO,'
      'HST.DESCRICAO AS DESCHISTORICO,'
      'TC.VALOR_NOMINAL AS VALORLANCAMENTO,'
      'TC.TIPO_LANCAMENTO AS TIPOLANCAMENTO,'
      
        '--CCD.CONTA AS CONTADEBITO, -- AQUI '#201' A CONTA CAIXA. VER COMO FA' +
        'ZER ISSO.'
      '--CCD.DESCRICAO AS CCDDESC,'
      '--CCD.CODREDUZ AS CCDCODREDUZ'
      'CCC.CONTA AS CONTACREDITO,'
      'CCC.DESCRICAO AS CCCDESC,'
      'CCC.CODREDUZ AS CCCCODREDUZ'
      'FROM TESOURARIA_CREDITO TC'
      
        'LEFT OUTER JOIN HISTORICO HST ON TC.ID_HISTORICO=HST.ID_HISTORIC' +
        'O AND TC.ID_ORGANIZACAO=HST.ID_ORGANIZACAO'
      
        'LEFT OUTER JOIN CONTA_CONTABIL CCC ON (CCC.ID_CONTA_CONTABIL=HST' +
        '.ID_CONTA_CONTABIL AND HST.ID_ORGANIZACAO=CCC.ID_ORGANIZACAO)'
      'WHERE TC.ID_ORGANIZACAO=:PIDORGANIZACAO'
      'AND TC.DATA_MOVIMENTO BETWEEN :DTDATAINICIAL AND :DTDATAFINAL'
      'AND TC.ID_TITULO_RECEBER_BAIXA IS NULL'
      'AND TC.id_titulo_receber_baixa_cheque is null'
      'AND TC.ID_LOTE_CONTABIL IS NULL'
      'AND TC.ID_HISTORICO <> '#39'TRANSFERE BANCO/TESOURARIA'#39)
    Left = 504
    Top = 472
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
  object qryObterPendentes: TFDQuery
    Connection = dmConexao.Conn
    SQL.Strings = (
      'SELECT LC.id,'
      'lc.id_organizacao,'
      'lc.identificacao,'
      'lc.valor,'
      'lc.tipo,'
      'lc.pendencia'
      ''
      ' FROM lanc_export_pend LC'
      ' WHERE LC.id_organizacao = :PIDORGANIZACAO ')
    Left = 36
    Top = 568
    ParamData = <
      item
        Name = 'PIDORGANIZACAO'
        DataType = ftString
        ParamType = ptInput
      end>
  end
  object qryInserePendente: TFDQuery
    Connection = dmConexao.Conn
    Left = 384
    Top = 472
  end
  object qryLimparPendentes: TFDQuery
    Connection = dmConexao.Conn
    SQL.Strings = (
      'DELETE FROM  lanc_export_pend lc '
      'WHERE lc.id_organizacao = :pIDORGANIZACAO'
      
        'AND lc.data_registro between '#39'01.01.1900'#39' AND ( Select (current_' +
        'date -1) from RDB$DATABASE)')
    Left = 36
    Top = 440
    ParamData = <
      item
        Name = 'PIDORGANIZACAO'
        DataType = ftString
        ParamType = ptInput
        Size = 36
      end>
  end
  object qryObterValorDebitoGeneric: TFDQuery
    Connection = dmConexao.Conn
    SQL.Strings = (
      'Select Sum(valor) as valorDebito'
      'from conta_bancaria_transferencia cbt'
      'WHERE CBT.DATA_MOVIMENTO BETWEEN :DTDATAINICIAL AND :DTDATAFINAL'
      'AND CBT.ID_ORGANIZACAO=:PIDORGANIZACAO'
      'AND CBT.ID_LOTE_CONTABIL IS NULL')
    Left = 264
    Top = 24
    ParamData = <
      item
        Name = 'DTDATAINICIAL'
        DataType = ftDate
        ParamType = ptInput
      end
      item
        Name = 'DTDATAFINAL'
        DataType = ftDate
        ParamType = ptInput
      end
      item
        Name = 'PIDORGANIZACAO'
        DataType = ftString
        ParamType = ptInput
        Size = 36
      end>
  end
  object qryUpdateGeneric: TFDQuery
    Connection = dmConexao.Conn
    Left = 36
    Top = 496
  end
  object qryHstSemCC: TFDQuery
    Connection = dmConexao.Conn
    SQL.Strings = (
      'SELECT H.descricao, H.CODIGO'
      'FROM  HISTORICO H'
      'WHERE (H.ID_ORGANIZACAO = :pIdOrganizacao) AND'
      '      (H.id_conta_contabil IS NULL)')
    Left = 32
    Top = 24
    ParamData = <
      item
        Name = 'PIDORGANIZACAO'
        DataType = ftString
        ParamType = ptInput
        Size = 36
      end>
  end
  object qryBancoCaixa: TFDQuery
    Connection = dmConexao.Conn
    FetchOptions.AssignedValues = [evRowsetSize]
    FetchOptions.RowsetSize = 500
    FormatOptions.AssignedValues = [fvFmtDisplayDate, fvFmtDisplayNumeric, fvFmtEditNumeric]
    FormatOptions.FmtDisplayDate = 'DD/MM/YYYY'
    FormatOptions.FmtDisplayNumeric = '###,##0.00'
    FormatOptions.FmtEditNumeric = '###,##0.00'
    SQL.Strings = (
      'SELECT  CBD.id_conta_bancaria_debito AS ID, '
      '        CBD.id_tipo_operacao_bancaria AS IDOPER,'
      '        CBD.ID_ORGANIZACAO AS IDORG,        '
      '        CBD.VALOR AS VALOR,'
      '        CBD.DATA_MOVIMENTO AS DATA,'
      '        CBD.IDENTIFICACAO AS IDENTIFCRE,'
      '        CBD.IDENTIFICACAO AS IDENTIFDEB,'
      ''
      '       CCC.CONTA AS CONTA_CRE,'
      '       CCC.DGVER AS DGCRE,'
      '       CCC.CODREDUZ AS CDREDUZCRE,'
      '       CCC.DGREDUZ AS DGREDUZCRE,'
      '       CCC.DESCRICAO AS DESCTACREDITO,'
      '     '
      '       CCD.CONTA AS CONTA_DEB,'
      '       CCD.DGVER AS DGDEB,'
      '       CCD.CODREDUZ AS CDREDUZDEB,'
      '       CCD.DGREDUZ AS DGREDUZDEB,'
      '       CCD.DESCRICAO AS DESCTADEBITO,'
      '       TOB.TIPO AS TIPOOPERACAO,'
      '       TOB.CODIGO AS CDHIST,'
      '       TOB.DESCRICAO AS COMPL,'
      '       TOB.ID_TIPO_OPERACAO_BANCARIA AS HISTORICO,             '
      '       '#39'TRF_BC_CX'#39' as TIPO'
      ''
      'FROM CONTA_BANCARIA_DEBITO CBD'
      
        'LEFT OUTER JOIN CONTA_BANCARIA CB ON (CB.ID_CONTA_BANCARIA = CBD' +
        '.ID_CONTA_BANCARIA) AND (CB.ID_ORGANIZACAO = CBD.ID_ORGANIZACAO)'
      'LEFT OUTER JOIN BANCO B ON (B.ID_BANCO = CB.ID_BANCO)'
      
        'LEFT OUTER JOIN CONTA_CONTABIL CCC ON (CCC.ID_CONTA_CONTABIL = C' +
        'B.ID_CONTA_CONTABIL)  AND (CCC.ID_ORGANIZACAO = CBD.ID_ORGANIZAC' +
        'AO)'
      
        'LEFT OUTER JOIN TIPO_OPERACAO_BANCARIA TOB ON (TOB.ID_TIPO_OPERA' +
        'CAO_BANCARIA = CBD.ID_TIPO_OPERACAO_BANCARIA) AND (TOB.ID_ORGANI' +
        'ZACAO = CBD.ID_ORGANIZACAO)'
      
        'LEFT OUTER JOIN CONTA_CONTABIL CCD ON (CCD.ID_CONTA_CONTABIL = T' +
        'OB.ID_CONTA_CONTABIL) AND (CCD.ID_ORGANIZACAO = CBD.ID_ORGANIZAC' +
        'AO)'
      ''
      ''
      ''
      'WHERE (CBD.ID_ORGANIZACAO = :PIDORGANIZACAO)AND'
      
        '      (CBD.DATA_MOVIMENTO BETWEEN :DTDATAINICIAL AND :DTDATAFINA' +
        'L) AND'
      
        '      (CBD.ID_TIPO_OPERACAO_BANCARIA = '#39'TRANSFERE BANCO/TESOURAR' +
        'IA'#39') AND'
      '      (CBD.ID_LOTE_CONTABIL IS NULL)'
      'ORDER BY CBD.DATA_MOVIMENTO, CBD.VALOR')
    Left = 160
    Top = 112
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
  object qryCaixaBanco: TFDQuery
    Connection = dmConexao.Conn
    FormatOptions.AssignedValues = [fvFmtDisplayDate, fvFmtDisplayNumeric, fvFmtEditNumeric]
    FormatOptions.FmtDisplayDate = 'DD/MM/YYYY'
    FormatOptions.FmtDisplayNumeric = '###,##0.00'
    FormatOptions.FmtEditNumeric = '###,##0.00'
    SQL.Strings = (
      '--obter as transferencias da tesouraria para o banco'
      '-- por periodo'
      'SELECT  CBC.ID_CONTA_BANCARIA_CREDITO as ID,'
      '        CBC.id_organizacao as IDORG,'
      '        CBC.id_tipo_operacao_bancaria AS IDOPER,'
      '        CBC.DESCRICAO,'
      '        CBC.VALOR as VALOR,'
      '        CBC.DATA_MOVIMENTO AS DATA,'
      '        CBC.IDENTIFICACAO AS IDENTIFCRE,'
      '        CBC.IDENTIFICACAO AS IDENTIFDEB,'
      '        CB.CONTA AS CONTA_BANCO,'
      '        CB.AGENCIA,'
      '       '
      '       CCC.CONTA AS CONTA_CRE,'
      '       CCC.DGVER AS DGCRE,'
      '       CCC.CODREDUZ AS CDREDUZCRE,'
      '       CCC.DGREDUZ AS DGREDUZCRE,'
      '       CCC.DESCRICAO AS DESCTACREDITO,'
      ' '
      '      CCD.CONTA AS CONTA_DEB,'
      '       CCD.DGVER AS DGDEB,'
      '       CCD.CODREDUZ AS CDREDUZDEB,'
      '       CCD.DGREDUZ AS DGREDUZDEB,'
      '       CCD.DESCRICAO AS DESCTADEBITO,'
      ''
      '        TOB.TIPO AS TIPOOPERACAO,'
      '        TOB.CODIGO AS CDHIST,'
      '        TOB.DESCRICAO AS COMPL,'
      '        TOB.ID_TIPO_OPERACAO_BANCARIA AS HISTORICO,        '
      '        '#39'TRF_TES_BCO'#39' as TIPO'
      ''
      'FROM CONTA_BANCARIA_CREDITO CBC'
      
        'LEFT OUTER JOIN tipo_operacao_bancaria TOB ON (TOB.id_tipo_opera' +
        'cao_bancaria = CBC.id_tipo_operacao_bancaria) AND (TOB.ID_ORGANI' +
        'ZACAO = CBC.ID_ORGANIZACAO)'
      
        'LEFT OUTER JOIN CONTA_BANCARIA CB ON (CB.ID_CONTA_BANCARIA = CBC' +
        '.ID_CONTA_BANCARIA) AND (CB.ID_ORGANIZACAO = CBC.ID_ORGANIZACAO)'
      
        'LEFT OUTER JOIN CONTA_CONTABIL CCC ON (CCC.ID_CONTA_CONTABIL = C' +
        'B.ID_CONTA_CONTABIL) AND (CCC.ID_ORGANIZACAO = CBC.ID_ORGANIZACA' +
        'O)'
      
        'LEFT OUTER JOIN CONTA_CONTABIL CCD ON (CCD.ID_CONTA_CONTABIL = T' +
        'OB.ID_CONTA_CONTABIL) AND (CCD.ID_ORGANIZACAO = CBC.ID_ORGANIZAC' +
        'AO)'
      ''
      'WHERE (CBC.ID_ORGANIZACAO = :PIDORGANIZACAO)AND'
      
        '      (CBC.DATA_MOVIMENTO BETWEEN :DTDATAINICIAL AND :DTDATAFINA' +
        'L) AND'
      
        '      (CBC.ID_TIPO_OPERACAO_BANCARIA = '#39'DEPOSITO TESOURARIA/BANC' +
        'O'#39') AND'
      '      (CBC.ID_LOTE_CONTABIL IS NULL)')
    Left = 272
    Top = 112
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
  object qryTPPROVBASE: TFDQuery
    Connection = dmConexao.Conn
    SQL.Strings = (
      '--PEGA TODOS OS TITULOS A PAGAR PROVISIONADOS '
      '--PAGOS/ ABERTOS E PARCIALMENTE PAGOS'
      ''
      'SELECT TP.VALOR_NOMINAL AS VALOR,'
      '       TP.ID_ORGANIZACAO,'
      '       TP.REGISTRO_PROVISAO,'
      '       TP.ID_TITULO_PAGAR as ID,'
      '       TP.ID_ORGANIZACAO,'
      '       TP.NUMERO_DOCUMENTO,'
      '       TP.DATA_PAGAMENTO,'
      '       TP.DATA_EMISSAO,'
      '       TP.DESCRICAO,'
      '       TP.ID_CEDENTE,'
      '       TP.ID_CONTA_CONTABIL_CREDITO,'
      '       CCD.CONTA AS CONTA_DEB,'
      '       CCD.DGVER AS DGDEB,'
      '       CCD.CODREDUZ AS CDREDUZDEB,'
      '       CCD.DGREDUZ AS DGREDUZDEB,'
      '       CCD.DESCRICAO AS DESCTADEBITO,'
      '       TPB.ID_TITULO_PAGAR_BAIXA as IDTPB,'
      '       H.CODIGO AS CDHIST,'
      '       H.descricao_reduzida AS COMPL,'
      '       H.descricao AS HISTORICO,'
      '       '#39'TPPROV'#39' as TIPO'
      ''
      'FROM TITULO_PAGAR TP'
      
        'LEFT OUTER JOIN CONTA_CONTABIL CCD ON (CCD.ID_CONTA_CONTABIL = T' +
        'P.ID_CONTA_CONTABIL_CREDITO) AND (CCD.ID_ORGANIZACAO = TP.ID_ORG' +
        'ANIZACAO)'
      
        'LEFT OUTER JOIN TITULO_PAGAR_BAIXA TPB ON (TPB.ID_TITULO_PAGAR =' +
        ' TP.ID_TITULO_PAGAR) AND (TPB.ID_ORGANIZACAO = TP.ID_ORGANIZACAO' +
        ')'
      
        'LEFT OUTER JOIN HISTORICO H ON (H.ID_HISTORICO = TP.ID_HISTORICO' +
        ')  AND (H.ID_ORGANIZACAO = TP.ID_ORGANIZACAO)'
      ''
      ''
      'WHERE (TP.ID_ORGANIZACAO = :PIDORGANIZACAO) AND'
      
        '      (TP.DATA_EMISSAO BETWEEN :pDataInicial AND :pDataFinal) AN' +
        'D'
      '      (TP.REGISTRO_PROVISAO IS NOT NULL) AND'
      '      (TP.ID_LOTE_TPB IS NULL) AND'
      '      (TP.ID_TIPO_STATUS in ('#39'ABERTO'#39','#39'QUITADO'#39', '#39'PARCIAL'#39'))'
      ''
      ''
      ''
      'ORDER BY DATA_EMISSAO ASC, VALOR_NOMINAL DESC;'
      '')
    Left = 496
    Top = 32
    ParamData = <
      item
        Name = 'PIDORGANIZACAO'
        DataType = ftString
        ParamType = ptInput
        Size = 36
      end
      item
        Name = 'PDATAINICIAL'
        DataType = ftDate
        ParamType = ptInput
      end
      item
        Name = 'PDATAFINAL'
        DataType = ftDate
        ParamType = ptInput
      end>
  end
  object qryTPPROVDB: TFDQuery
    Connection = dmConexao.Conn
    FormatOptions.AssignedValues = [fvDefaultParamDataType, fvFmtDisplayDate, fvFmtDisplayNumeric, fvFmtEditNumeric]
    FormatOptions.DefaultParamDataType = ftString
    FormatOptions.FmtDisplayDate = 'DD/MM/YYYY'
    FormatOptions.FmtDisplayNumeric = '###,##0.00'
    FormatOptions.FmtEditNumeric = '###,##0.00'
    SQL.Strings = (
      'SELECT TPH.valor,'
      '       TPH.ID_TITULO_PAGAR_HISTORICO AS ID,'
      '       TPH.id_organizacao,'
      '       CCD.CONTA AS CONTA_DEB,'
      '       CCD.DGVER AS DGDEB,'
      '       CCD.CODREDUZ AS CDREDUZDEB,'
      '       CCD.DGREDUZ AS DGREDUZDEB,'
      '       CCD.DESCRICAO AS DESCTADEBITO,'
      '       H.CODIGO AS CDHIST,'
      '       H.descricao_reduzida AS COMPL,'
      '       H.descricao AS HISTORICO'
      ''
      ''
      'FROM titulo_pagar_historico TPH'
      ''
      
        ' LEFT OUTER JOIN HISTORICO H ON (H.id_historico = TPH.id_histori' +
        'co) AND (H.id_organizacao = TPH.id_organizacao)'
      
        ' LEFT OUTER JOIN conta_contabil CCD ON (CCD.id_conta_contabil = ' +
        'H.id_conta_contabil) AND (CCD.id_organizacao = TPH.id_organizaca' +
        'o)'
      ' '
      'WHERE  (TPH.ID_ORGANIZACAO = :PIDORGANIZACAO) AND'
      '       (TPH.ID_TITULO_PAGAR = :PID)')
    Left = 496
    Top = 168
    ParamData = <
      item
        Name = 'PIDORGANIZACAO'
        DataType = ftString
        ParamType = ptInput
        Size = 36
      end
      item
        Name = 'PID'
        DataType = ftString
        ParamType = ptInput
        Size = 36
      end>
  end
  object qryTPPROVCR: TFDQuery
    Connection = dmConexao.Conn
    SQL.Strings = (
      'SELECT TP.ID_TITULO_PAGAR AS ID,'
      '       TP.VALOR_NOMINAL AS VALOR,'
      '       TP.DATA_EMISSAO AS DATA,'
      '       TP.NUMERO_DOCUMENTO AS IDENTIFCRE,'
      '       C.ID_CEDENTE,'
      '       C.NOME,'
      '       C.ID_CONTA_CONTABIL AS IDCRE,'
      '       CCC.CONTA AS CONTA_CRE,'
      '       CCC.DGVER AS DGCRE,'
      '       CCC.CODREDUZ AS CDREDUZCRE,'
      '       CCC.DGREDUZ AS DGREDUZCRE,'
      '       CCC.DESCRICAO AS DESCTACREDITO,'
      '       H.CODIGO AS CDHIST,'
      '       H.descricao_reduzida AS COMPL,'
      '       H.descricao AS HISTORICO'
      ''
      'FROM  TITULO_PAGAR TP'
      
        'LEFT OUTER JOIN CEDENTE C ON (C.ID_CEDENTE = TP.ID_CEDENTE) AND ' +
        '(C.ID_ORGANIZACAO = TP.ID_ORGANIZACAO)'
      
        'LEFT OUTER JOIN CONTA_CONTABIL CCC ON (CCC.ID_CONTA_CONTABIL = C' +
        '.ID_CONTA_CONTABIL) AND (CCC.ID_ORGANIZACAO = TP.ID_ORGANIZACAO)'
      
        'LEFT OUTER JOIN HISTORICO H ON (H.id_historico = TP.ID_HISTORICO' +
        ')  AND (H.ID_ORGANIZACAO = TP.ID_ORGANIZACAO)'
      'WHERE  (TP.ID_ORGANIZACAO = :PIDORGANIZACAO) AND'
      '       (TP.ID_TITULO_PAGAR = :PID)'
      ''
      ''
      '')
    Left = 496
    Top = 96
    ParamData = <
      item
        Name = 'PIDORGANIZACAO'
        DataType = ftString
        ParamType = ptInput
        Size = 36
      end
      item
        Name = 'PID'
        DataType = ftString
        ParamType = ptInput
        Size = 36
      end>
  end
  object qryCR: TFDQuery
    Connection = dmConexao.Conn
    SQL.Strings = (
      'SELECT TP.ID_TITULO_PAGAR AS ID,'
      '       TP.VALOR_NOMINAL AS VALOR,'
      '       TP.DATA_EMISSAO AS DATA,'
      '       TP.NUMERO_DOCUMENTO AS IDENTIFCRE,'
      '       C.ID_CEDENTE,'
      '       C.NOME,'
      '       C.ID_CONTA_CONTABIL AS IDCRE,'
      '       CCC.CONTA AS CONTA_CRE,'
      '       CCC.DGVER AS DGCRE,'
      '       CCC.CODREDUZ AS CDREDUZCRE,'
      '       CCC.DGREDUZ AS DGREDUZCRE,'
      '       CCC.DESCRICAO AS DESCTACREDITO,'
      '       H.CODIGO AS CDHIST,'
      '       H.descricao_reduzida AS COMPL,'
      '       H.descricao AS HISTORICO'
      ''
      'FROM  TITULO_PAGAR TP'
      
        'LEFT OUTER JOIN CEDENTE C ON (C.ID_CEDENTE = TP.ID_CEDENTE) AND ' +
        '(C.ID_ORGANIZACAO = TP.ID_ORGANIZACAO)'
      
        'LEFT OUTER JOIN CONTA_CONTABIL CCC ON (CCC.ID_CONTA_CONTABIL = C' +
        '.ID_CONTA_CONTABIL) AND (CCC.ID_ORGANIZACAO = TP.ID_ORGANIZACAO)'
      
        'LEFT OUTER JOIN HISTORICO H ON (H.id_historico = TP.ID_HISTORICO' +
        ')  AND (H.ID_ORGANIZACAO = TP.ID_ORGANIZACAO)'
      'WHERE  (TP.ID_ORGANIZACAO  = :ORG) AND'
      '       (TP.ID_TITULO_PAGAR = :PIDTITULO)'
      ''
      ''
      '')
    Left = 1024
    Top = 352
    ParamData = <
      item
        Name = 'ORG'
        DataType = ftString
        ParamType = ptInput
        Size = 36
      end
      item
        Name = 'PIDTITULO'
        DataType = ftString
        ParamType = ptInput
        Size = 36
      end>
  end
  object qryObterValorTitulo: TFDQuery
    Connection = dmConexao.Conn
    SQL.Strings = (
      '--PEGA TODOS OS TITULOS A PAGAR PROVISIONADOS '
      '--PAGOS/ ABERTOS E PARCIALMENTE PAGOS'
      'SELECT distinct'
      '              SUM(TP.VALOR_NOMINAL) AS VALOR_NOMINAL,'
      '              COUNT(tp.registro_provisao) as QTD,'
      '              max(tp.numero_documento),'
      '              max(TP.id_historico) as id_historico,'
      '              TP.REGISTRO_PROVISAO, '
      '              MAX(TP.ID_ORGANIZACAO) AS ID_ORGANIZACAO,'
      '              max(tp.id_titulo_pagar) as ID,'
      '              max(TP.data_emissao) as DATA_EMISSAO,'
      '              max(TP.numero_documento) as NUMERO_DOCUMENTO,'
      '              max(TP.ID_CEDENTE) AS ID_CEDENTE,'
      '              max(TP.DESCRICAO) AS DESCRICAO,'
      '              max(h.descricao) as HST_DSC,'
      '             '#39'TPPROV'#39' as TIPO'
      ''
      ''
      'FROM TITULO_PAGAR TP'
      
        'LEFT OUTER JOIN historico h on (h.id_historico = tp.id_historico' +
        ') AND (H.ID_ORGANIZACAO = TP.ID_ORGANIZACAO)'
      ''
      'WHERE (TP.ID_ORGANIZACAO = :PIDORGANIZACAO) AND'
      
        '      (TP.DATA_EMISSAO BETWEEN :pDataInicial AND :pDataFinal) AN' +
        'D'
      '      (TP.IS_PROVISAO = 1) AND'
      '      (TP.ID_TIPO_STATUS <> '#39'EXCLUIDO'#39') AND'
      '      (TP.ID_LOTE_CONTABIL IS NULL)'
      ''
      ' GROUP BY TP.REGISTRO_PROVISAO'
      ''
      'ORDER BY DATA_EMISSAO ASC, VALOR_NOMINAL DESC;'
      '')
    Left = 272
    Top = 216
    ParamData = <
      item
        Name = 'PIDORGANIZACAO'
        DataType = ftString
        ParamType = ptInput
        Size = 36
      end
      item
        Name = 'PDATAINICIAL'
        DataType = ftDate
        ParamType = ptInput
      end
      item
        Name = 'PDATAFINAL'
        DataType = ftDate
        ParamType = ptInput
      end>
  end
  object qryTPB_PROV: TFDQuery
    Connection = dmConexao.Conn
    SQL.Strings = (
      '--CONSULTA: TITULOS PROVISIONADOS QUE FORAM PAGOS '
      
        '-- BAIXA DE PROVISAO N'#195'O PODE TER STATUS PARCIAL. SOMENTE QUITAD' +
        'O'
      
        '--O VALOR QUE PEGA AQUI '#201' O VALOR PRINCIPAL. PRECISA PEGAR A CNT' +
        'A DEBITO DOS ACRESCIMOS'
      ''
      'SELECT TP.VALOR_NOMINAL AS VALOR,'
      '       TP.REGISTRO_PROVISAO,'
      '       TP.ID_TITULO_PAGAR as ID,'
      '       TP.ID_ORGANIZACAO,'
      '       TP.NUMERO_DOCUMENTO,'
      '       TP.DATA_PAGAMENTO,'
      '       TP.ID_CEDENTE,'
      '       TP.ID_CONTA_CONTABIL_CREDITO,'
      '       CCD.CONTA AS CONTA_DEB,'
      '       CCD.DGVER AS DGDEB,'
      '       CCD.CODREDUZ AS CDREDUZDEB,'
      '       CCD.DGREDUZ AS DGREDUZDEB,'
      '       CCD.DESCRICAO AS DESCTADEBITO,'
      '       TPB.ID_TITULO_PAGAR_BAIXA as IDTPB,'
      '       H.CODIGO AS CDHIST,'
      '       H.descricao_reduzida AS COMPL,'
      '       LEFT(H.descricao,50) AS HISTORICO '
      ''
      'FROM TITULO_PAGAR TP'
      
        'LEFT OUTER JOIN CONTA_CONTABIL CCD ON (CCD.ID_CONTA_CONTABIL = T' +
        'P.ID_CONTA_CONTABIL_CREDITO) AND (CCD.ID_ORGANIZACAO = TP.ID_ORG' +
        'ANIZACAO)'
      
        'LEFT OUTER JOIN TITULO_PAGAR_BAIXA TPB ON (TPB.ID_TITULO_PAGAR =' +
        ' TP.ID_TITULO_PAGAR) AND (TPB.ID_ORGANIZACAO = TP.ID_ORGANIZACAO' +
        ')'
      
        'LEFT OUTER JOIN HISTORICO H ON (H.ID_HISTORICO = TP.ID_HISTORICO' +
        ')  AND (H.ID_ORGANIZACAO = TP.ID_ORGANIZACAO)'
      ''
      'WHERE (TP.ID_ORGANIZACAO = :PIDORGANIZACAO) AND'
      
        '      (TP.DATA_PAGAMENTO BETWEEN :pDataInicial AND :pDataFinal) ' +
        'AND'
      '     --(TP.REGISTRO_PROVISAO IS NOT NULL) AND'
      '      (TP.ID_TIPO_STATUS in ('#39'QUITADO'#39', '#39'PARCIAL'#39'))'
      '')
    Left = 624
    Top = 144
    ParamData = <
      item
        Name = 'PIDORGANIZACAO'
        DataType = ftString
        ParamType = ptInput
        Size = 36
      end
      item
        Name = 'PDATAINICIAL'
        DataType = ftDate
        ParamType = ptInput
      end
      item
        Name = 'PDATAFINAL'
        DataType = ftDate
        ParamType = ptInput
      end>
  end
  object qryTRBAcrescimos: TFDQuery
    Connection = dmConexao.Conn
    SQL.Strings = (
      'SELECT TRBAC.ID_TITULO_RECEBER_BAIXA_AC,'
      '    TRBAC.ID_TITULO_RECEBER_BAIXA,'
      '    TRBAC.ID_TIPO_ACRESCIMO,'
      '    TRBAC.VALOR as VALOR,'
      '    H.CODIGO AS CDHIST,'
      '    H.descricao_reduzida AS COMPL,'
      '    H.descricao AS HISTORICO,'
      '    CCD.CONTA AS CONTA_DEB,'
      '    CCD.DGVER AS DGDEB,'
      '    CCD.CODREDUZ AS CDREDUZDEB,'
      '    CCD.DGREDUZ AS DGREDUZDEB,'
      '    CCD.DESCRICAO AS DESCTADEBITO, '
      '    TA.DESCRICAO AS DSC_ACRESCIMO'
      ''
      'FROM TITULO_RECEBER_BAIXA_AC TRBAC'
      ''
      
        'LEFT OUTER JOIN TIPO_ACRESCIMO TA ON (TA.ID_TIPO_ACRESCIMO = TRB' +
        'AC.ID_TIPO_ACRESCIMO) AND (TA.ID_ORGANIZACAO = TR.ID_ORGANIZACAO' +
        ')'
      
        'LEFT OUTER JOIN HISTORICO H ON (H.ID_HISTORICO = TA.ID_HISTORICO' +
        ')'
      
        'LEFT OUTER JOIN CONTA_CONTABIL CCD ON (CCD.ID_CONTA_CONTABIL = H' +
        '.ID_CONTA_CONTABIL)'
      ''
      'WHERE   (TRBAC.ID_ORGANIZACAO = :PIDORGANIZACAO) AND'
      '        (TRBAC.ID_TITULO_RECEBER_BAIXA =:PIDTITULORECEBERBAIXA);'
      '')
    Left = 1024
    Top = 424
    ParamData = <
      item
        Name = 'PIDORGANIZACAO'
        DataType = ftString
        ParamType = ptInput
        Size = 36
      end
      item
        Name = 'PIDTITULORECEBERBAIXA'
        DataType = ftString
        ParamType = ptInput
        Size = 36
      end>
  end
  object qryTPBAcrescimos: TFDQuery
    Connection = dmConexao.Conn
    SQL.Strings = (
      'SELECT TPBA.id_titulo_pagar_baixa, '
      '       TPBA.valor as VALOR, '
      '       TA.descricao,'
      '       TA.id_historico, '
      '       H.CODIGO AS CDHIST,'
      '       H.descricao_reduzida AS COMPL,'
      '       H.descricao AS HISTORICO,'
      '       CCD.CONTA AS CONTA_DEB,'
      '       CCD.DGVER AS DGDEB,'
      '       CCD.CODREDUZ AS CDREDUZDEB,'
      '       CCD.DGREDUZ AS DGREDUZDEB,'
      '       CCD.DESCRICAO AS DESCTADEBITO, '
      '       TA.DESCRICAO AS DSC_ACRESCIMO'
      ''
      '      '
      'FROM titulo_pagar_baixa_ac TPBA'
      ''
      
        'JOIN tipo_acrescimo TA ON (TA.id_tipo_acrescimo = TPBA.id_tipo_a' +
        'crescimo) AND (TA.ID_ORGANIZACAO = TPBA.ID_ORGANIZACAO)'
      
        'JOIN HISTORICO H ON (H.id_historico = TA.id_historico) AND (H.ID' +
        '_ORGANIZACAO = TPBA.ID_ORGANIZACAO)'
      
        'JOIN conta_contabil CCD ON (CCD.id_conta_contabil = H.id_conta_c' +
        'ontabil) AND (CCD.ID_ORGANIZACAO = TPBA.ID_ORGANIZACAO)'
      ''
      'WHERE (TPBA.ID_ORGANIZACAO = :pIdOrganizacao) AND'
      '      (TPBA.id_titulo_pagar_baixa = :pIdTitutloPagarBaixa)'
      ''
      'order by TPBA.valor')
    Left = 698
    Top = 40
    ParamData = <
      item
        Name = 'PIDORGANIZACAO'
        DataType = ftString
        ParamType = ptInput
        Size = 36
      end
      item
        Name = 'PIDTITUTLOPAGARBAIXA'
        DataType = ftString
        ParamType = ptInput
        Size = 36
      end>
  end
  object qryTPBDeducao: TFDQuery
    Connection = dmConexao.Conn
    FormatOptions.AssignedValues = [fvFmtDisplayDate]
    FormatOptions.FmtDisplayDate = 'DD/MM/YYYY'
    SQL.Strings = (
      'SELECT TPBD.ID_TITULO_PAGAR_BAIXA AS ID, '
      '       TPBD.VALOR AS VALOR, '
      '       TD.DESCRICAO,'
      '       TD.ID_HISTORICO, '
      '       CCC.CONTA AS CONTA_CRE,'
      '       CCC.DGVER AS DGCRE,'
      '       CCC.CODREDUZ AS CDREDUZCRE,'
      '       CCC.DGREDUZ AS DGREDUZCRE,'
      '       CCC.DESCRICAO AS DESCTACREDITO,'
      '       H.CODIGO AS CDHIST,'
      '       H.DESCRICAO_REDUZIDA AS COMPL,'
      '       H.DESCRICAO AS HISTORICO'
      ''
      'FROM TITULO_PAGAR_BAIXA_DE TPBD'
      ''
      
        'JOIN TIPO_DEDUCAO TD ON (TD.ID_TIPO_DEDUCAO = TPBD.ID_TIPO_DEDUC' +
        'AO) AND (TD.ID_ORGANIZACAO = TPBD.ID_ORGANIZACAO)'
      
        'JOIN HISTORICO H ON (H.ID_HISTORICO = TD.ID_HISTORICO) AND (H.ID' +
        '_ORGANIZACAO = TPBD.ID_ORGANIZACAO)'
      
        'JOIN CONTA_CONTABIL CCC ON (CCC.ID_CONTA_CONTABIL = H.ID_CONTA_C' +
        'ONTABIL) AND (CCC.ID_ORGANIZACAO = TPBD.ID_ORGANIZACAO)'
      ''
      'WHERE (TPBD.ID_ORGANIZACAO = :PIDORGANIZACAO) AND'
      '      (TPBD.ID_TITULO_PAGAR_BAIXA = :PIDTITUTLOPAGARBAIXA)'
      ''
      'ORDER BY TPBD.VALOR DESC')
    Left = 784
    Top = 40
    ParamData = <
      item
        Name = 'PIDORGANIZACAO'
        DataType = ftString
        ParamType = ptInput
        Size = 36
      end
      item
        Name = 'PIDTITUTLOPAGARBAIXA'
        DataType = ftString
        ParamType = ptInput
        Size = 36
      end>
  end
  object qryTPBCaixa: TFDQuery
    Connection = dmConexao.Conn
    SQL.Strings = (
      'SELECT TD.ID_TITULO_PAGAR_BAIXA,'
      '          TD.ID_ORGANIZACAO,'
      '          TD.ID_TESOURARIA_DEBITO AS ID, '
      '          TD.DATA_MOVIMENTO AS DATA, '
      '          TD.VALOR_NOMINAL AS VALOR,'
      '          TD.OBSERVACAO, '
      '          TD.DESCRICAO, '
      '          CCC.CONTA AS CONTA_CRE,'
      '          CCC.DGVER AS DGCRE,'
      '          CCC.CODREDUZ AS CDREDUZCRE,'
      '          CCC.DGREDUZ AS DGREDUZCRE,'
      '          CCC.DESCRICAO AS DESCTACREDITO,'
      '          H.CODIGO AS CDHIST,'
      '          H.DESCRICAO_REDUZIDA AS COMPL,'
      '          H.DESCRICAO AS HISTORICO'
      ''
      ''
      'FROM TESOURARIA_DEBITO TD'
      
        'LEFT OUTER JOIN HISTORICO H ON (H.ID_HISTORICO = TD.ID_HISTORICO' +
        ') AND (H.ID_ORGANIZACAO = TD.ID_ORGANIZACAO)'
      
        'LEFT OUTER JOIN CONTA_CONTABIL CCC ON (CCC.ID_CONTA_CONTABIL = H' +
        '.ID_CONTA_CONTABIL) AND (CCC.ID_ORGANIZACAO = TD.ID_ORGANIZACAO)'
      ''
      'WHERE (TD.ID_ORGANIZACAO = :PIDORGANIZACAO) AND'
      '         (TD.ID_TITULO_PAGAR_BAIXA = :PIDTITULOPAGARBAIXA) ')
    Left = 848
    Top = 40
    ParamData = <
      item
        Name = 'PIDORGANIZACAO'
        DataType = ftString
        ParamType = ptInput
        Size = 36
      end
      item
        Name = 'PIDTITULOPAGARBAIXA'
        DataType = ftString
        ParamType = ptInput
        Size = 36
      end>
  end
  object qryTPBCheque: TFDQuery
    Connection = dmConexao.Conn
    SQL.Strings = (
      'SELECT  TPBC.ID_TITULO_PAGAR_BAIXA_CHEQUE AS ID,'
      '        TPBC.ID_ORGANIZACAO,'
      '        TPBC.ID_CONTA_BANCARIA_CHEQUE,'
      '        TPBC.ID_TITULO_PAGAR_BAIXA,'
      '        TPBC.VALOR AS VALOR,'
      '        CCC.CONTA AS CONTA_CRE,'
      '        CCC.DGVER AS DGCRE,'
      '        CCC.CODREDUZ AS CDREDUZCRE,'
      '        CCC.DGREDUZ AS DGREDUZCRE,'
      '        CCC.DESCRICAO AS DESCTACREDITO,'
      '        TOB.CODIGO AS CDHIST,'
      '        TOB.DESCRICAO AS COMPL,'
      '        TOB.DESCRICAO AS HISTORICO'
      ''
      ''
      'FROM TITULO_PAGAR_BAIXA_CHEQUE TPBC'
      
        'LEFT OUTER JOIN CONTA_BANCARIA_CHEQUE CBC ON (CBC.ID_CONTA_BANCA' +
        'RIA_CHEQUE = TPBC.ID_CONTA_BANCARIA_CHEQUE)AND (CBC.ID_ORGANIZAC' +
        'AO = TPBC.ID_ORGANIZACAO)'
      
        'LEFT OUTER JOIN CONTA_BANCARIA CB ON (CB.ID_CONTA_BANCARIA = CBC' +
        '.ID_CONTA_BANCARIA) AND (CB.ID_ORGANIZACAO = TPBC.ID_ORGANIZACAO' +
        ')'
      
        'LEFT OUTER JOIN CONTA_CONTABIL CCC ON (CCC.ID_CONTA_CONTABIL = C' +
        'B.ID_CONTA_CONTABIL) AND (CCC.ID_ORGANIZACAO = TPBC.ID_ORGANIZAC' +
        'AO)'
      
        'LEFT OUTER JOIN TIPO_OPERACAO_BANCARIA TOB ON (TOB.ID_TIPO_OPERA' +
        'CAO_BANCARIA = TPBC.ID_TIPO_OPERACAO_BANCARIA)'
      ''
      'WHERE (TPBC.ID_ORGANIZACAO = :PIDORGANIZACAO) AND'
      '      (TPBC.ID_TITULO_PAGAR_BAIXA = :PIDTITULOPAGARBAIXA) ')
    Left = 928
    Top = 40
    ParamData = <
      item
        Name = 'PIDORGANIZACAO'
        DataType = ftString
        ParamType = ptInput
        Size = 36
      end
      item
        Name = 'PIDTITULOPAGARBAIXA'
        DataType = ftString
        ParamType = ptInput
        Size = 36
      end>
  end
  object qryTPBInternet: TFDQuery
    Connection = dmConexao.Conn
    SQL.Strings = (
      'SELECT TPBI.ID_TITULO_PAGAR_BAIXA,'
      '       TPBI.ID_ORGANIZACAO,'
      '       TPBI.VALOR as VALOR,'
      '       TPBI.id_conta_bancaria,'
      '       CCC.CONTA AS CONTA_CRE,'
      '       CCC.DGVER AS DGCRE,'
      '       CCC.CODREDUZ AS CDREDUZCRE,'
      '       CCC.DGREDUZ AS DGREDUZCRE,'
      '       CCC.DESCRICAO AS DESCTACREDITO,'
      '       TOB.CODIGO AS CDHIST,'
      '       TOB.DESCRICAO AS COMPL,'
      '       TOB.DESCRICAO AS HISTORICO'
      '        '
      'FROM TITULO_PAGAR_BAIXA_INTERNET TPBI'
      
        'LEFT OUTER JOIN CONTA_BANCARIA CB ON (CB.ID_CONTA_BANCARIA = TPB' +
        'I.ID_CONTA_BANCARIA) AND (CB.ID_ORGANIZACAO = TPBI.ID_ORGANIZACA' +
        'O)'
      
        'LEFT OUTER JOIN CONTA_CONTABIL CCC ON (CCC.ID_CONTA_CONTABIL = C' +
        'B.ID_CONTA_CONTABIL) AND (CCC.ID_ORGANIZACAO = TPBI.ID_ORGANIZAC' +
        'AO)'
      
        'LEFT OUTER JOIN TIPO_OPERACAO_BANCARIA TOB ON (TOB.ID_TIPO_OPERA' +
        'CAO_BANCARIA = TPBI.ID_TIPO_OPERACAO_BANCARIA)'
      ''
      'WHERE (TPBI.ID_ORGANIZACAO = :PIDORGANIZACAO) AND'
      '      (TPBI.ID_TITULO_PAGAR_BAIXA = :PIDTITULOPAGARBAIXA) '
      ''
      'ORDER BY TPBI.VALOR;'
      '')
    Left = 1005
    Top = 40
    ParamData = <
      item
        Name = 'PIDORGANIZACAO'
        DataType = ftString
        ParamType = ptInput
        Size = 36
      end
      item
        Name = 'PIDTITULOPAGARBAIXA'
        DataType = ftString
        ParamType = ptInput
        Size = 36
      end>
  end
  object qryObterTodosLoteContabil: TFDQuery
    Connection = dmConexao.Conn
    FetchOptions.AssignedValues = [evRowsetSize]
    FetchOptions.RowsetSize = 500
    SQL.Strings = (
      'SELECT  LC.ID_LOTE_CONTABIL,'
      '        LC.ID_ORGANIZACAO,'
      '        LC.LOTE,'
      '        LC.STATUS,'
      '        LC.DATA_REGISTRO,'
      '        LC.DATA_ATUALIZACAO,'
      '        LC.PERIODO_INICIAL,'
      '        LC.PERIODO_FINAL,'
      '        LC.TIPO_TABLE,'
      '        LC.QTD_REGISTROS'
      ''
      ' FROM LOTE_CONTABIL LC'
      ''
      'WHERE (LC.ID_ORGANIZACAO = :PIDORGANIZACAO) AND'
      
        '      (LC.DATA_REGISTRO BETWEEN :DTDATAINICIAL AND :DTDATAFINAL)' +
        ' AND'
      '      LC.STATUS <> '#39'EXCLUIDO'#39
      ''
      'ORDER BY LC.DATA_REGISTRO, LC.LOTE'
      '')
    Left = 36
    Top = 232
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
  object qryDeletaLoteContabil: TFDQuery
    Connection = dmConexao.Conn
    FetchOptions.AssignedValues = [evRowsetSize]
    FetchOptions.RowsetSize = 500
    SQL.Strings = (
      'UPDATE LOTE_CONTABIL LC SET LC.STATUS = '#39'EXCLUIDO'#39
      ''
      'WHERE (LC.ID_ORGANIZACAO = :PIDORGANIZACAO) AND '
      '      (LC.ID_LOTE_CONTABIL = :PIDLOTE);'
      '')
    Left = 36
    Top = 296
    ParamData = <
      item
        Name = 'PIDORGANIZACAO'
        DataType = ftString
        ParamType = ptInput
        Size = 36
      end
      item
        Name = 'PIDLOTE'
        DataType = ftString
        ParamType = ptInput
        Size = 36
      end>
  end
  object qrytpprovbase_1: TFDQuery
    SQL.Strings = (
      '--PEGA TODOS OS TITULOS A PAGAR PROVISIONADOS '
      '--PAGOS/ ABERTOS E PARCIALMENTE PAGOS'
      'SELECT distinct'
      '              SUM(TP.VALOR_NOMINAL) AS VALOR_NOMINAL,'
      '              COUNT(tp.registro_provisao) as QTD,'
      '              max(tp.numero_documento),'
      '              max(TP.id_historico) as id_historico,'
      '              TP.REGISTRO_PROVISAO, '
      '              MAX(TP.ID_ORGANIZACAO) AS ID_ORGANIZACAO,'
      '              max(tp.id_titulo_pagar) as ID,'
      '              max(TP.data_emissao) as DATA_EMISSAO,'
      '              max(TP.numero_documento) as NUMERO_DOCUMENTO,'
      '              max(TP.ID_CEDENTE) AS ID_CEDENTE,'
      '              max(TP.DESCRICAO) AS DESCRICAO,'
      '              max(h.descricao) as HST_DSC,'
      '             '#39'TPPROV'#39' as TIPO'
      ''
      ''
      'FROM TITULO_PAGAR TP'
      
        'LEFT OUTER JOIN historico h on (h.id_historico = tp.id_historico' +
        ') AND (H.ID_ORGANIZACAO = TP.ID_ORGANIZACAO)'
      ''
      'WHERE (TP.ID_ORGANIZACAO = :PIDORGANIZACAO) AND'
      
        '      (TP.DATA_EMISSAO BETWEEN :pDataInicial AND :pDataFinal) AN' +
        'D'
      '      (TP.ID_TIPO_STATUS <> '#39'EXCLUIDO'#39') AND'
      '      (TP.ID_LOTE_CONTABIL IS NULL)'
      ''
      'GROUP BY TP.REGISTRO_PROVISAO'
      ''
      'ORDER BY DATA_EMISSAO ASC, VALOR_NOMINAL DESC;'
      '')
    Left = 696
    Top = 312
    ParamData = <
      item
        Name = 'PIDORGANIZACAO'
        ParamType = ptInput
      end
      item
        Name = 'PDATAINICIAL'
        ParamType = ptInput
      end
      item
        Name = 'PDATAFINAL'
        ParamType = ptInput
      end>
  end
end