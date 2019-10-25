object dmContaContabil: TdmContaContabil
  OldCreateOrder = False
  Height = 454
  Width = 529
  object qryObterPlanoContas: TFDQuery
    Connection = dmConexao.Conn
    FetchOptions.AssignedValues = [evRowsetSize]
    FetchOptions.RowsetSize = 500000
    SQL.Strings = (
      
        'SELECT * FROM conta_contabil C WHERE (C.id_organizacao = :PIDORG' +
        'ANIZACAO) ORDER BY CONTA')
    Left = 352
    Top = 376
    ParamData = <
      item
        Name = 'PIDORGANIZACAO'
        DataType = ftString
        ParamType = ptInput
        Size = 36
      end>
  end
  object dtsPlanoContas: TDataSource
    DataSet = qryObterPlanoContas
    Left = 464
    Top = 384
  end
  object qryIncluirConta: TFDQuery
    Left = 80
    Top = 304
  end
  object qryObterPorConta: TFDQuery
    Connection = dmConexao.Conn
    SQL.Strings = (
      
        'SELECT * FROM conta_contabil C WHERE (C.id_organizacao = :PIDORG' +
        'ANIZACAO)'
      ' AND ((c.conta = :PCONTA));')
    Left = 80
    Top = 200
    ParamData = <
      item
        Name = 'PIDORGANIZACAO'
        DataType = ftString
        ParamType = ptInput
        Size = 36
      end
      item
        Name = 'PCONTA'
        DataType = ftString
        ParamType = ptInput
      end>
  end
  object qryAtualizaDescricaoConta: TFDQuery
    Connection = dmConexao.Conn
    SQL.Strings = (
      'UPDATE CONTA_CONTABIL CC SET  CC.DESCRICAO = UPPER(:pDescricao),'
      '                              CC.conta = (:PCONTA),'
      '                              CC.dgver = (:PDGVER),'
      '                              CC.codreduz = (:PCODREDUZ),'
      '                              CC.dgreduz = (:PDGREDUZ),'
      '                              CC.tipo = (:PTIPO)'
      ''
      'WHERE (CC.ID_CONTA_CONTABIL = :pIdContaContabil) AND '
      '      (CC.ID_ORGANIZACAO = :pIDOrganizacao);')
    Left = 248
    Top = 192
    ParamData = <
      item
        Name = 'PDESCRICAO'
        DataType = ftString
        ParamType = ptInput
      end
      item
        Name = 'PCONTA'
        DataType = ftString
        ParamType = ptInput
      end
      item
        Name = 'PDGVER'
        DataType = ftString
        ParamType = ptInput
      end
      item
        Name = 'PCODREDUZ'
        DataType = ftString
        ParamType = ptInput
      end
      item
        Name = 'PDGREDUZ'
        DataType = ftString
        ParamType = ptInput
      end
      item
        Name = 'PTIPO'
        DataType = ftString
        ParamType = ptInput
      end
      item
        Name = 'PIDCONTACONTABIL'
        DataType = ftString
        ParamType = ptInput
        Size = 36
      end
      item
        Name = 'PIDORGANIZACAO'
        DataType = ftString
        ParamType = ptInput
        Size = 36
      end>
  end
  object qryObterPorCodigoReduzido: TFDQuery
    Connection = dmConexao.Conn
    SQL.Strings = (
      ''
      'SELECT * FROM conta_contabil C'
      'WHERE (C.id_organizacao = :PIDORGANIZACAO) AND'
      '(C.CODREDUZ = :PCODREDUZ)')
    Left = 352
    Top = 120
    ParamData = <
      item
        Name = 'PIDORGANIZACAO'
        DataType = ftString
        ParamType = ptInput
        Size = 36
      end
      item
        Name = 'PCODREDUZ'
        DataType = ftString
        ParamType = ptInput
      end>
  end
end
