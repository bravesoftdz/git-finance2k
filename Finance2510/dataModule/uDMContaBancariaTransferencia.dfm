object dmCBT: TdmCBT
  OldCreateOrder = False
  Height = 388
  Width = 562
  object qryObterPorPeriodo: TFDQuery
    Connection = dmConexao.Conn
    FormatOptions.AssignedValues = [fvFmtDisplayDate, fvFmtDisplayNumeric, fvFmtEditNumeric]
    FormatOptions.FmtDisplayDate = 'DD/MM/YYYY'
    FormatOptions.FmtDisplayNumeric = '###,##0.00'
    FormatOptions.FmtEditNumeric = '###,##0.00'
    SQL.Strings = (
      'SELECT  CBT.ID_CONTA_BANCARIA_TRANSFERENCIA,'
      '        CBT.ID_CONTA_BANCARIA_CREDITO,'
      '        CBT.ID_CONTA_BANCARIA_DEBITO,'
      '        CBT.ID_TIPO_OPERACAO_BANCARIA,'
      '        CBT.VALOR, CBT.DATA_MOVIMENTO,'
      '        CBT.IDENTIFICACAO,'
      '       '#39'CBT'#39' AS TIPO'
      ''
      ''
      'FROM CONTA_BANCARIA_TRANSFERENCIA CBT'
      ''
      
        'LEFT OUTER JOIN CONTA_BANCARIA_CREDITO CBC ON (CBC.ID_CONTA_BANC' +
        'ARIA_CREDITO = CBT.ID_CONTA_BANCARIA_CREDITO) AND (CBC.ID_ORGANI' +
        'ZACAO = CBT.ID_ORGANIZACAO)'
      ''
      'WHERE   (CBT.ID_ORGANIZACAO = :PIDORGANIZACAO) AND'
      
        '        (CBT.DATA_MOVIMENTO BETWEEN :DTDATAINICIAL AND :DTDATAFI' +
        'NAL) AND'
      '        (CBC.ID_LOTE_CONTABIL IS NULL)'
      ''
      ''
      ''
      '')
    Left = 96
    Top = 96
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
end
