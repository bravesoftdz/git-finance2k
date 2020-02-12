object frmDeletaLoteContabil: TfrmDeletaLoteContabil
  Left = 0
  Top = 0
  Caption = '  Deleta Lote Contabil'
  ClientHeight = 523
  ClientWidth = 691
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
    Left = 147
    Top = 24
    Width = 61
    Height = 13
    Caption = 'Lote cont'#225'bil'
  end
  object lbl2: TLabel
    Left = 27
    Top = 85
    Width = 42
    Height = 13
    Caption = 'ID LOTE '
  end
  object lbl3: TLabel
    Left = 275
    Top = 85
    Width = 81
    Height = 13
    Caption = 'DATA REGISTRO'
  end
  object lbl4: TLabel
    Left = 387
    Top = 85
    Width = 95
    Height = 13
    Caption = 'TIPO LAN'#199'AMENTO'
  end
  object lbl5: TLabel
    Left = 27
    Top = 147
    Width = 73
    Height = 13
    Caption = 'VALOR D'#201'BITO'
  end
  object lbl6: TLabel
    Left = 296
    Top = 147
    Width = 81
    Height = 13
    Caption = 'VALOR CR'#201'DITO'
  end
  object lbl7: TLabel
    Left = 27
    Top = 24
    Width = 75
    Height = 13
    Caption = 'Selecione o ano'
  end
  object cbbLoteContabil: TComboBox
    Left = 147
    Top = 43
    Width = 110
    Height = 21
    Font.Charset = DEFAULT_CHARSET
    Font.Color = 12582911
    Font.Height = -11
    Font.Name = 'Tahoma'
    Font.Style = [fsBold]
    ParentFont = False
    TabOrder = 1
    OnSelect = cbbLoteContabilSelect
  end
  object btnLimpar: TButton
    Left = 387
    Top = 39
    Width = 102
    Height = 28
    Caption = 'Limpar'
    TabOrder = 3
    OnClick = btnLimparClick
  end
  object edtIdLote: TEdit
    Left = 27
    Top = 107
    Width = 230
    Height = 21
    Alignment = taRightJustify
    Enabled = False
    TabOrder = 4
  end
  object edtDataRegistro: TEdit
    Left = 275
    Top = 107
    Width = 85
    Height = 21
    Alignment = taRightJustify
    Enabled = False
    TabOrder = 5
  end
  object medtValorDB: TMaskEdit
    Left = 117
    Top = 143
    Width = 140
    Height = 21
    Alignment = taRightJustify
    Color = clMoneyGreen
    Enabled = False
    TabOrder = 7
    Text = ''
  end
  object edtTabela: TEdit
    Left = 387
    Top = 107
    Width = 155
    Height = 21
    Alignment = taCenter
    Enabled = False
    TabOrder = 6
  end
  object medtValorCR: TMaskEdit
    Left = 387
    Top = 143
    Width = 155
    Height = 21
    Alignment = taRightJustify
    Color = 13619199
    Enabled = False
    TabOrder = 8
    Text = ''
  end
  object btnDeletarLote: TButton
    Left = 275
    Top = 39
    Width = 102
    Height = 28
    Caption = 'Deletar'
    TabOrder = 2
    OnClick = btnDeletarLoteClick
  end
  object cbbAno: TComboBox
    Left = 27
    Top = 43
    Width = 110
    Height = 21
    TabOrder = 0
    Text = '>>Selecione <<'
    OnChange = cbbAnoChange
    Items.Strings = (
      '>> Selecione o ano << '
      '2019'
      '2018'
      '2017'
      '2016'
      '2015'
      '2014')
  end
  object btnFechar: TBitBtn
    Left = 560
    Top = 39
    Width = 102
    Height = 28
    Caption = 'Fechar'
    TabOrder = 9
    OnClick = btnFecharClick
  end
  object edtTipoLancamento: TEdit
    Left = 560
    Top = 107
    Width = 102
    Height = 21
    Alignment = taCenter
    Enabled = False
    TabOrder = 10
  end
  object dbgrd1: TDBGrid
    Left = 27
    Top = 256
    Width = 294
    Height = 185
    DataSource = dsMega
    TabOrder = 11
    TitleFont.Charset = DEFAULT_CHARSET
    TitleFont.Color = clWindowText
    TitleFont.Height = -11
    TitleFont.Name = 'Tahoma'
    TitleFont.Style = []
    Columns = <
      item
        Expanded = False
        FieldName = 'ANO'
        Title.Alignment = taCenter
        Width = 50
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'EMPRESA'
        Title.Alignment = taCenter
        Width = 60
        Visible = True
      end
      item
        Alignment = taCenter
        Expanded = False
        FieldName = 'LOTE'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlue
        Font.Height = -11
        Font.Name = 'Tahoma'
        Font.Style = [fsBold]
        Title.Alignment = taCenter
        Width = 50
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'TOTAL'
        Title.Alignment = taRightJustify
        Width = 100
        Visible = True
      end>
  end
  object dbgrd2: TDBGrid
    Left = 368
    Top = 256
    Width = 294
    Height = 185
    DataSource = dsFinance
    TabOrder = 12
    TitleFont.Charset = DEFAULT_CHARSET
    TitleFont.Color = clWindowText
    TitleFont.Height = -11
    TitleFont.Name = 'Tahoma'
    TitleFont.Style = []
    Columns = <
      item
        Expanded = False
        FieldName = 'ANO'
        Width = 50
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'EMPRESA'
        Width = 60
        Visible = True
      end
      item
        Alignment = taCenter
        Expanded = False
        FieldName = 'LOTE'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clRed
        Font.Height = -11
        Font.Name = 'Tahoma'
        Font.Style = []
        Width = 50
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'TOTAL'
        Width = 100
        Visible = True
      end>
  end
  object pnl1: TPanel
    Left = 27
    Top = 200
    Width = 635
    Height = 41
    Caption = 'Sincronizar lotes exportados para o sistema cont'#225'bil'
    TabOrder = 13
  end
  object btnSincronizaLotes: TBitBtn
    Left = 560
    Top = 458
    Width = 102
    Height = 28
    Caption = 'Sincronizar'
    TabOrder = 14
    OnClick = btnSincronizaLotesClick
  end
  object dxStatusBar: TdxStatusBar
    Left = 0
    Top = 503
    Width = 691
    Height = 20
    Panels = <
      item
        PanelStyleClassName = 'TdxStatusBarTextPanelStyle'
        Width = 60
      end
      item
        PanelStyleClassName = 'TdxStatusBarTextPanelStyle'
        Width = 500
      end>
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'Tahoma'
    Font.Style = []
  end
  object qryObterLoteID: TFDQuery
    Connection = dmConexao.conn
    FetchOptions.AssignedValues = [evRowsetSize]
    FetchOptions.RowsetSize = 500
    SQL.Strings = (
      ''
      'SELECT  LC.ID_LOTE_CONTABIL,'
      '        LC.ID_ORGANIZACAO,'
      '        LC.LOTE,'
      '        LC.STATUS,'
      '        LC.DATA_REGISTRO,'
      '        LC.DATA_ATUALIZACAO,'
      '        LC.PERIODO_INICIAL,'
      '        LC.PERIODO_FINAL,'
      '        LC.TIPO_TABLE, '
      '        LC.TIPO_LANCAMENTO, '
      '        LC.VALOR_CR, '
      '        LC.VALOR_DB,'
      '        LC.QTD_REGISTROS'
      ''
      ''
      ' FROM LOTE_CONTABIL LC'
      ''
      'WHERE (LC.ID_ORGANIZACAO = :PIDORGANIZACAO) AND'
      '      (LC.ID_LOTE_CONTABIL = :PIDLOTE)'
      '      ')
    Left = 112
    Top = 448
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
  object qryGeneric: TFDQuery
    Connection = dmConexao.conn
    Left = 192
    Top = 448
  end
  object qryAlteraGeneric: TFDQuery
    Connection = dmConexao.conn
    Left = 32
    Top = 448
  end
  object qryAlteraLote: TFDQuery
    Connection = dmConexao.conn
    Left = 384
    Top = 464
  end
  object qryObterTPPROV: TFDQuery
    Connection = dmConexao.conn
    Left = 304
    Top = 456
  end
  object qryDeletaLote: TFDQuery
    Connection = dmConexao.conn
    Left = 248
    Top = 456
  end
  object qryObterLotePorAno: TFDQuery
    Connection = dmConexao.ConnMega
    FormatOptions.AssignedValues = [fvFmtDisplayDate, fvFmtDisplayNumeric, fvFmtEditNumeric]
    FormatOptions.FmtDisplayDate = 'DD/MM/YYY'
    FormatOptions.FmtDisplayNumeric = '###,##0.00'
    FormatOptions.FmtEditNumeric = '###,##0.00'
    SQL.Strings = (
      'SELECT DISTINCT CAST( CL.EMPRESA AS VARCHAR(5)) AS ID_EMPRESA,'
      '       CL.ANO,'
      '      CAST( CL.LOTE AS VARCHAR(10)) AS LOTE,'
      '       CL.TOTAL,'
      '       C.NOME AS EMPRESA'
      ''
      'FROM CLOTES CL'
      'LEFT OUTER JOIN cadastro C ON (C.ID = CL.empresa)'
      ''
      'WHERE (CL.empresa = :PIDEMPRESA)'
      'AND   (CL.ano = :PANO)'
      ''
      'ORDER BY CL.LOTE DESC')
    Left = 224
    Top = 312
    ParamData = <
      item
        Name = 'PIDEMPRESA'
        DataType = ftInteger
        ParamType = ptInput
      end
      item
        Name = 'PANO'
        DataType = ftString
        ParamType = ptInput
      end>
  end
  object dsMega: TDataSource
    AutoEdit = False
    DataSet = qryObterLotePorAno
    Left = 88
    Top = 320
  end
  object qryObterLoteFNC: TFDQuery
    Connection = dmConexao.conn
    FormatOptions.AssignedValues = [fvFmtDisplayDate, fvFmtDisplayNumeric, fvFmtEditNumeric]
    FormatOptions.FmtDisplayDate = 'DD/MM/YYY'
    FormatOptions.FmtDisplayNumeric = '###,##0.00'
    FormatOptions.FmtEditNumeric = '###,##0.00'
    SQL.Strings = (
      'SELECT LC.LOTE, LC.TIPO_TABLE as TABELA,'
      '       LC.ID_ORGANIZACAO AS EMPRESA, LC.ID_LOTE_CONTABIL,'
      
        '      CAST(EXTRACT(year FROM LC.PERIODO_INICIAL) AS VARCHAR(4)) ' +
        'AS ANO,'
      '       LC.VALOR_DB AS TOTAL'
      ''
      'FROM LOTE_CONTABIL LC'
      ''
      'WHERE (LC.ID_ORGANIZACAO = :PIDORGANIZACAO)'
      
        'AND   (LC.PERIODO_INICIAL BETWEEN :DTDATAINICIAL AND :DTDATAFINA' +
        'L) '
      'ORDER BY LC.LOTE DESC')
    Left = 408
    Top = 304
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
  object dsFinance: TDataSource
    DataSet = qryObterLoteFNC
    Left = 504
    Top = 280
  end
end