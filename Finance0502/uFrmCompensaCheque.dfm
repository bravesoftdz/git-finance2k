object frmCompensaCheque: TfrmCompensaCheque
  Left = 0
  Top = 0
  Caption = 'Compensar Cheque'
  ClientHeight = 464
  ClientWidth = 822
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  Position = poDesktopCenter
  OnClose = FormClose
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 13
  object lbl1: TLabel
    Left = 247
    Top = 23
    Width = 71
    Height = 13
    Caption = 'Conta Cont'#225'bil'
  end
  object lbl2: TLabel
    Left = 374
    Top = 23
    Width = 135
    Height = 13
    Caption = 'Descri'#231#227'o da Conta Cont'#225'bil'
  end
  object lbl3: TLabel
    Left = 592
    Top = 23
    Width = 84
    Height = 13
    Caption = 'Cheques emitidos'
  end
  object lbl4: TLabel
    Left = 536
    Top = 69
    Width = 38
    Height = 13
    Caption = 'Emiss'#227'o'
  end
  object lbl5: TLabel
    Left = 536
    Top = 99
    Width = 37
    Height = 13
    Caption = 'Estorno'
  end
  object lbl6: TLabel
    Left = 549
    Top = 126
    Width = 24
    Height = 13
    Caption = 'Valor'
  end
  object lbl7: TLabel
    Left = 247
    Top = 99
    Width = 42
    Height = 13
    Caption = 'Portador'
  end
  object lblIDTP: TLabel
    Left = 708
    Top = 45
    Width = 33
    Height = 13
    Caption = 'lblIDTP'
    Visible = False
  end
  object lblIDCONTAbANCARIA: TLabel
    Left = 708
    Top = 83
    Width = 108
    Height = 13
    Caption = 'lblIDCONTAbANCARIA'
    Visible = False
  end
  object lblIDCHEQUE: TLabel
    Left = 708
    Top = 64
    Width = 62
    Height = 13
    Caption = 'lblIDCHEQUE'
    Visible = False
  end
  object lblRESPONSAVEL: TLabel
    Left = 708
    Top = 102
    Width = 80
    Height = 13
    Caption = 'lblRESPONSAVEL'
    Visible = False
  end
  object lblTOB: TLabel
    Left = 708
    Top = 126
    Width = 30
    Height = 13
    Caption = 'lblTOB'
    Visible = False
  end
  object lblIDUSER: TLabel
    Left = 708
    Top = 145
    Width = 26
    Height = 13
    Caption = 'USER'
    Visible = False
  end
  object lbl8: TLabel
    Left = 317
    Top = 325
    Width = 108
    Height = 13
    Caption = 'Data da Compensa'#231#227'o'
  end
  inline frmContaBancaria1: TfrmContaBancaria
    Left = 8
    Top = 23
    Width = 233
    Height = 59
    TabOrder = 0
    ExplicitLeft = 8
    ExplicitTop = 23
    ExplicitWidth = 233
    ExplicitHeight = 59
    inherited lbl1: TLabel
      Width = 73
      Height = 13
      ExplicitWidth = 73
      ExplicitHeight = 13
    end
    inherited cbbConta: TComboBox
      Height = 21
      OnChange = frmContaBancaria1cbbContaChange
      ExplicitHeight = 21
    end
    inherited qryObterTodos: TFDQuery
      Top = 0
    end
    inherited qryObterContaContabil: TFDQuery
      Left = 24
      Top = 0
    end
  end
  object edtContaContabil: TEdit
    Left = 247
    Top = 42
    Width = 121
    Height = 21
    Alignment = taRightJustify
    Enabled = False
    TabOrder = 1
  end
  object edtDescricaoCC: TEdit
    Left = 374
    Top = 42
    Width = 200
    Height = 21
    Enabled = False
    TabOrder = 2
  end
  object cbbcheque: TComboBox
    Left = 591
    Top = 42
    Width = 97
    Height = 21
    TabOrder = 3
    OnChange = cbbchequeChange
  end
  object edtPortador: TEdit
    Left = 247
    Top = 123
    Width = 283
    Height = 21
    TabOrder = 4
  end
  object medtDataEmissao: TMaskEdit
    Left = 592
    Top = 69
    Width = 96
    Height = 21
    Alignment = taRightJustify
    Enabled = False
    EditMask = '99/99/9999;1;_'
    MaxLength = 10
    TabOrder = 5
    Text = '  /  /    '
  end
  object medtEstorno: TMaskEdit
    Left = 592
    Top = 96
    Width = 96
    Height = 21
    Alignment = taRightJustify
    Enabled = False
    EditMask = '99/99/9999;1;_'
    MaxLength = 10
    TabOrder = 6
    Text = '  /  /    '
  end
  object medtvalor: TMaskEdit
    Left = 592
    Top = 123
    Width = 93
    Height = 21
    Alignment = taRightJustify
    Enabled = False
    TabOrder = 7
    Text = ''
  end
  object dbgrd1: TDBGrid
    Left = 24
    Top = 166
    Width = 665
    Height = 131
    DataSource = ds1
    TabOrder = 8
    TitleFont.Charset = DEFAULT_CHARSET
    TitleFont.Color = clWindowText
    TitleFont.Height = -11
    TitleFont.Name = 'Tahoma'
    TitleFont.Style = []
    Columns = <
      item
        Expanded = False
        FieldName = 'NUMERO_DOCUMENTO'
        Title.Caption = 'DOCUMENTO'
        Width = 100
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'DATA_VENCIMENTO'
        Title.Caption = 'VENCIMENTO'
        Width = 80
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'DATA_PAGAMENTO'
        Title.Caption = 'PAGAMENTO'
        Width = 80
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'DESCRICAO_TP'
        Title.Caption = 'DESCRI'#199#195'O'
        Width = 200
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'ID_TIPO_OPERACAO_BANCARIA'
        Title.Caption = 'OPERA'#199#195'O BANC'#193'RIA'
        Width = 70
        Visible = True
      end
      item
        Alignment = taRightJustify
        Expanded = False
        FieldName = 'VALOR_NOMINAL'
        Title.Caption = 'VALOR DO T'#205'TULO'
        Width = 100
        Visible = True
      end>
  end
  object btnCompensar: TButton
    Left = 596
    Top = 320
    Width = 93
    Height = 25
    Caption = 'Compensar'
    TabOrder = 9
    OnClick = btnCompensarClick
  end
  object dtpCompensa: TDateTimePicker
    Left = 443
    Top = 320
    Width = 131
    Height = 25
    Date = 43754.999055312510000000
    Time = 43754.999055312510000000
    TabOrder = 10
  end
  object btnFechar: TBitBtn
    Left = 712
    Top = 320
    Width = 93
    Height = 25
    Caption = 'Fechar'
    TabOrder = 11
    OnClick = btnFecharClick
  end
  object qryObterCheque: TFDQuery
    Connection = dmConexao.conn
    SQL.Strings = (
      'SELECT  CBC.ID_CONTA_BANCARIA_CHEQUE AS IDCHEQUE,'
      '        CBC.ID_ORGANIZACAO,'
      '        CBC.ID_CONTA_BANCARIA,'
      '        CBC.ID_FUNCIONARIO,'
      '        CBC.ID_TIPO_STATUS,'
      '        CBC.NUMERO_CHEQUE,'
      '        CBC.DATA_EMISSAO,'
      '        CBC.DATA_ESTORNO,'
      '        CBC.VALOR,'
      '        CBC.OBSERVACAO,'
      '        CBC.PORTADOR,'
      '        CBC.QTD_IMPRESSAO,'
      '        F.NOME,'
      '        TS.DESCRICAO AS STATUS,'
      '        CB.CONTA_INTERNA,'
      '        CB.CONTA,'
      '        CB.AGENCIA,'
      '        CB.TITULAR'
      ''
      ' FROM CONTA_BANCARIA_CHEQUE CBC'
      ''
      
        ' LEFT OUTER JOIN FUNCIONARIO F ON (F.ID_FUNCIONARIO = CBC.ID_FUN' +
        'CIONARIO)  AND (F.ID_ORGANIZACAO = CBC.ID_ORGANIZACAO)'
      
        ' LEFT OUTER JOIN TIPO_STATUS TS ON (TS.ID_TIPO_STATUS = CBC.ID_T' +
        'IPO_STATUS) AND (TS.ID_ORGANIZACAO = CBC.ID_ORGANIZACAO)'
      
        ' LEFT OUTER JOIN CONTA_BANCARIA CB ON (CB.ID_CONTA_BANCARIA = CB' +
        'C.ID_CONTA_BANCARIA) AND (CB.ID_ORGANIZACAO = CBC.ID_ORGANIZACAO' +
        ')'
      ''
      ' WHERE (CBC.ID_ORGANIZACAO =  :PIDORGANIZACAO) AND'
      '       (CBC.ID_CONTA_BANCARIA_CHEQUE = :PIDCHEQUE)')
    Left = 56
    Top = 368
    ParamData = <
      item
        Name = 'PIDORGANIZACAO'
        DataType = ftString
        ParamType = ptInput
        Size = 36
      end
      item
        Name = 'PIDCHEQUE'
        DataType = ftString
        ParamType = ptInput
        Size = 36
      end>
  end
  object qryListaChequesPorCB: TFDQuery
    Connection = dmConexao.conn
    SQL.Strings = (
      'SELECT  CBC.ID_CONTA_BANCARIA_CHEQUE AS IDCHEQUE,       '
      '        CBC.NUMERO_CHEQUE'
      ''
      'FROM CONTA_BANCARIA_CHEQUE CBC'
      ''
      'WHERE (CBC.ID_ORGANIZACAO =  :PIDORGANIZACAO) AND'
      '       (CBC.ID_CONTA_BANCARIA = :PIDCONTABANCARIA) '
      '  AND  (CBC.ID_TIPO_STATUS = '#39'EMITIDO'#39')'
      '')
    Left = 160
    Top = 368
    ParamData = <
      item
        Name = 'PIDORGANIZACAO'
        DataType = ftString
        ParamType = ptInput
        Size = 36
      end
      item
        Name = 'PIDCONTABANCARIA'
        DataType = ftString
        ParamType = ptInput
        Size = 36
      end>
  end
  object qryTPBBAIXA: TFDQuery
    Connection = dmConexao.conn
    FormatOptions.AssignedValues = [fvFmtDisplayDate, fvFmtDisplayNumeric, fvFmtEditNumeric]
    FormatOptions.FmtDisplayDate = 'DD/MM/YYYY'
    FormatOptions.FmtDisplayNumeric = '###,##0.00'
    FormatOptions.FmtEditNumeric = '###,##0.00'
    SQL.Strings = (
      'SELECT TPBCH.ID_TITULO_PAGAR_BAIXA_CHEQUE,'
      '       TPBCH.ID_ORGANIZACAO,'
      '       TPBCH.VALOR,'
      '       TPBCH.ID_TIPO_OPERACAO_BANCARIA AS TOB,'
      '       TOB.DESCRICAO,'
      '       TP.NUMERO_DOCUMENTO,'
      '       TP.DATA_VENCIMENTO,'
      '       TP.DATA_PAGAMENTO,'
      '       TP.DESCRICAO AS DESCRICAO_TP,'
      '       TP.VALOR_NOMINAL,'
      '       TP.ID_TITULO_PAGAR,'
      '       TP.ID_RESPONSAVEL'
      ''
      '     '
      'FROM TITULO_PAGAR_BAIXA_CHEQUE TPBCH'
      
        'LEFT OUTER JOIN TIPO_OPERACAO_BANCARIA TOB ON (TOB.ID_TIPO_OPERA' +
        'CAO_BANCARIA = TPBCH.ID_TIPO_OPERACAO_BANCARIA)'
      
        'LEFT OUTER JOIN TITULO_PAGAR_BAIXA TPB ON (TPB.ID_TITULO_PAGAR_B' +
        'AIXA = TPBCH.ID_TITULO_PAGAR_BAIXA)'
      
        'LEFT OUTER JOIN TITULO_PAGAR TP ON (TP.ID_TITULO_PAGAR = TPB.ID_' +
        'TITULO_PAGAR)'
      ''
      ''
      'WHERE  (TPBCH.ID_ORGANIZACAO = :PIDORGANIZACAO)'
      '   AND (TPBCH.ID_CONTA_BANCARIA_CHEQUE = :PIDCHEQUE)'
      ''
      '')
    Left = 272
    Top = 368
    ParamData = <
      item
        Name = 'PIDORGANIZACAO'
        DataType = ftString
        ParamType = ptInput
        Size = 36
      end
      item
        Name = 'PIDCHEQUE'
        DataType = ftString
        ParamType = ptInput
        Size = 36
      end>
  end
  object ds1: TDataSource
    DataSet = qryTPBBAIXA
    Left = 264
    Top = 208
  end
  object qryInsereCBD: TFDQuery
    Connection = dmConexao.conn
    FormatOptions.AssignedValues = [fvFmtDisplayDate, fvFmtDisplayNumeric, fvFmtEditNumeric]
    FormatOptions.FmtDisplayDate = 'DD/MM/YYYY'
    FormatOptions.FmtDisplayNumeric = '###,##0.00'
    FormatOptions.FmtEditNumeric = '###,##0.00'
    Left = 344
    Top = 368
  end
  object qryCheckIdent: TFDQuery
    Connection = dmConexao.conn
    FormatOptions.AssignedValues = [fvFmtDisplayDate, fvFmtDisplayNumeric, fvFmtEditNumeric]
    FormatOptions.FmtDisplayDate = 'DD/MM/YYYY'
    FormatOptions.FmtDisplayNumeric = '###,##0.00'
    FormatOptions.FmtEditNumeric = '###,##0.00'
    SQL.Strings = (
      'SELECT COUNT(*) AS QTD '
      ''
      'FROM CONTA_BANCARIA_DEBITO CBD '
      ''
      ''
      'WHERE (CBD.IDENTIFICACAO = :PIDENT)')
    Left = 552
    Top = 368
    ParamData = <
      item
        Name = 'PIDENT'
        DataType = ftString
        ParamType = ptInput
        Size = 36
      end>
  end
  object qryUpdateCheque: TFDQuery
    Connection = dmConexao.conn
    FormatOptions.AssignedValues = [fvFmtDisplayDate, fvFmtDisplayNumeric, fvFmtEditNumeric]
    FormatOptions.FmtDisplayDate = 'DD/MM/YYYY'
    FormatOptions.FmtDisplayNumeric = '###,##0.00'
    FormatOptions.FmtEditNumeric = '###,##0.00'
    SQL.Strings = (
      'UPDATE CONTA_BANCARIA_CHEQUE CBC '
      '       SET CBC.ID_TIPO_STATUS = :PSTATUS, '
      '           CBC.DATA_COMPENSACAO = :PDATACOMPENSADO'
      ''
      'WHERE (CBC.ID_ORGANIZACAO = :PIDORGANIZACAO) AND'
      '      (CBC.ID_CONTA_BANCARIA_CHEQUE = :PIDCHEQUE)')
    Left = 432
    Top = 368
    ParamData = <
      item
        Name = 'PSTATUS'
        DataType = ftString
        ParamType = ptInput
        Size = 36
      end
      item
        Name = 'PDATACOMPENSADO'
        DataType = ftDate
        ParamType = ptInput
      end
      item
        Name = 'PIDORGANIZACAO'
        DataType = ftString
        ParamType = ptInput
        Size = 36
      end
      item
        Name = 'PIDCHEQUE'
        DataType = ftString
        ParamType = ptInput
        Size = 36
      end>
  end
end