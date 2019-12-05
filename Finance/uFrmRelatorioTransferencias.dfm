object frmRelatorioTransferencias: TfrmRelatorioTransferencias
  Left = 0
  Top = 0
  Caption = 'Relat'#243'rio das Transferencias '
  ClientHeight = 304
  ClientWidth = 654
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  Position = poMainFormCenter
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 13
  inline frmPeriodo1: TfrmPeriodo
    Left = 1
    Top = 1
    Width = 257
    Height = 97
    TabOrder = 0
    ExplicitLeft = 1
    ExplicitTop = 1
    ExplicitWidth = 257
    ExplicitHeight = 97
  end
  object btnBuscaTRF: TBitBtn
    Left = 328
    Top = 1
    Width = 153
    Height = 26
    Caption = 'Buscar'
    TabOrder = 1
    OnClick = btnBuscaTRFClick
  end
  object btnImprimir: TBitBtn
    Left = 328
    Top = 33
    Width = 153
    Height = 26
    Caption = 'Imprimir'
    TabOrder = 2
    OnClick = btnImprimirClick
  end
  object btnFechar: TBitBtn
    Left = 328
    Top = 65
    Width = 153
    Height = 26
    Caption = 'Fechar'
    TabOrder = 3
    OnClick = btnFecharClick
  end
  object dxStatusBar1: TdxStatusBar
    Left = 0
    Top = 284
    Width = 654
    Height = 20
    Panels = <
      item
        PanelStyleClassName = 'TdxStatusBarTextPanelStyle'
        Width = 100
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
  object EvDBGrid3D1: TEvDBGrid3D
    Left = 14
    Top = 136
    Width = 624
    Height = 142
    Color = cl3DLight
    Columns = <
      item
        Alignment = taCenter
        Expanded = False
        FieldName = 'DATA_MOVIMENTO'
        Title.Alignment = taCenter
        Title.Caption = 'DATA'
        Width = 80
        Visible = True
      end
      item
        Alignment = taRightJustify
        Expanded = False
        FieldName = 'CONTAORIGEM'
        Title.Alignment = taCenter
        Title.Caption = 'ORIGEM'
        Width = 100
        Visible = True
      end
      item
        Alignment = taRightJustify
        Expanded = False
        FieldName = 'CONTADESTINO'
        Title.Alignment = taCenter
        Title.Caption = 'DESTINO'
        Width = 100
        Visible = True
      end
      item
        Alignment = taCenter
        Expanded = False
        FieldName = 'LOTE'
        Title.Alignment = taCenter
        Width = 60
        Visible = True
      end
      item
        Alignment = taRightJustify
        Expanded = False
        FieldName = 'IDENTIFICACAO'
        Title.Alignment = taCenter
        Width = 110
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'VALOR'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'Tahoma'
        Font.Style = [fsBold]
        Title.Alignment = taCenter
        Visible = True
      end>
    DataSource = ds1
    TabOrder = 5
    TitleFont.Charset = DEFAULT_CHARSET
    TitleFont.Color = clWindowText
    TitleFont.Height = -11
    TitleFont.Name = 'Tahoma'
    TitleFont.Style = []
    Columns = <
      item
        Alignment = taCenter
        Expanded = False
        FieldName = 'DATA_MOVIMENTO'
        Title.Alignment = taCenter
        Title.Caption = 'DATA'
        Width = 80
        Visible = True
      end
      item
        Alignment = taRightJustify
        Expanded = False
        FieldName = 'CONTAORIGEM'
        Title.Alignment = taCenter
        Title.Caption = 'ORIGEM'
        Width = 100
        Visible = True
      end
      item
        Alignment = taRightJustify
        Expanded = False
        FieldName = 'CONTADESTINO'
        Title.Alignment = taCenter
        Title.Caption = 'DESTINO'
        Width = 100
        Visible = True
      end
      item
        Alignment = taCenter
        Expanded = False
        FieldName = 'LOTE'
        Title.Alignment = taCenter
        Width = 60
        Visible = True
      end
      item
        Alignment = taRightJustify
        Expanded = False
        FieldName = 'IDENTIFICACAO'
        Title.Alignment = taCenter
        Width = 110
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'VALOR'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'Tahoma'
        Font.Style = [fsBold]
        Title.Alignment = taCenter
        Visible = True
      end>
  end
  object qryObterPorPeriodo: TFDQuery
    Active = True
    Connection = dmConexao.conn
    FormatOptions.AssignedValues = [fvFmtDisplayDate, fvFmtDisplayNumeric, fvFmtEditNumeric]
    FormatOptions.FmtDisplayDate = 'DD/MM/YYYY'
    FormatOptions.FmtDisplayNumeric = '###,##0.00'
    FormatOptions.FmtEditNumeric = '###,##0.00'
    SQL.Strings = (
      'SELECT  CBT.ID_CONTA_BANCARIA_TRANSFERENCIA,'
      '        CBT.ID_CONTA_BANCARIA_CREDITO,'
      '        CBT.ID_CONTA_BANCARIA_DEBITO,'
      '        CBT.ID_TIPO_OPERACAO_BANCARIA,'
      '        CBT.VALOR, '
      '        CBT.DATA_MOVIMENTO,'
      '        CBT.IDENTIFICACAO,'
      '        CBT.VALOR,'
      '       CBDS.id_conta_bancaria_credito,'
      '       CBC.CONTA AS CONTADESTINO,'
      '       CBC.AGENCIA AS AGENCIADESTINO,'
      '       CBC.TITULAR AS TITULARDESTINO,'
      '       CBDS.IDENTIFICACAO AS IDENTICACAODESTINO,'
      '       CBD.CONTA AS CONTAORIGEM,'
      '       CBD.AGENCIA AS AGENCIAORIGEM,'
      '       CBD.TITULAR AS TITULARORIGEM,'
      '       CBOG.IDENTIFICACAO AS IDENTICACAOORIGEM,'
      '       lc.lote, lc.data_registro'
      ''
      ''
      'FROM CONTA_BANCARIA_TRANSFERENCIA CBT'
      ''
      
        'LEFT OUTER JOIN CONTA_BANCARIA_CREDITO CBDS ON (CBDS.ID_CONTA_BA' +
        'NCARIA_CREDITO = CBT.ID_CONTA_BANCARIA_CREDITO) AND (CBDS.ID_ORG' +
        'ANIZACAO = CBT.ID_ORGANIZACAO)'
      
        'LEFT OUTER JOIN CONTA_BANCARIA CBC ON (CBC.ID_CONTA_BANCARIA = C' +
        'BDS.ID_CONTA_BANCARIA) AND (CBC.ID_ORGANIZACAO = CBT.ID_ORGANIZA' +
        'CAO)'
      
        'LEFT OUTER JOIN CONTA_BANCARIA_DEBITO  CBOG ON (CBOG.ID_CONTA_BA' +
        'NCARIA_DEBITO  = CBT.ID_CONTA_BANCARIA_DEBITO) AND (CBOG.ID_ORGA' +
        'NIZACAO = CBT.ID_ORGANIZACAO)'
      
        'LEFT OUTER JOIN CONTA_BANCARIA CBD ON (CBD.ID_CONTA_BANCARIA = C' +
        'BOG.ID_CONTA_BANCARIA) AND (CBD.ID_ORGANIZACAO = CBT.ID_ORGANIZA' +
        'CAO)'
      
        'LEFT OUTER JOIN LOTE_CONTABIL LC ON (LC.ID_LOTE_CONTABIL = CBT.I' +
        'D_LOTE_CONTABIL) AND (LC.ID_ORGANIZACAO = CBT.ID_ORGANIZACAO)'
      ''
      ''
      'WHERE   (CBT.ID_ORGANIZACAO = :PIDORGANIZACAO) AND        '
      
        '        (CBT.DATA_MOVIMENTO BETWEEN :DTDATAINICIAL AND :DTDATAFI' +
        'NAL)'
      ''
      'ORDER BY CBT.DATA_MOVIMENTO, CBT.VALOR'
      ''
      ''
      '')
    Left = 536
    Top = 32
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
  object frxDBTRFS: TfrxDBDataset
    UserName = 'TRFS'
    CloseDataSource = False
    FieldAliases.Strings = (
      'ID_CONTA_BANCARIA_TRANSFERENCIA=ID_CONTA_BANCARIA_TRANSFERENCIA'
      'ID_CONTA_BANCARIA_CREDITO=ID_CONTA_BANCARIA_CREDITO'
      'ID_CONTA_BANCARIA_DEBITO=ID_CONTA_BANCARIA_DEBITO'
      'ID_TIPO_OPERACAO_BANCARIA=ID_TIPO_OPERACAO_BANCARIA'
      'VALOR=VALOR'
      'DATA_MOVIMENTO=DATA_MOVIMENTO'
      'IDENTIFICACAO=IDENTIFICACAO'
      'VALOR_1=VALOR_1'
      'ID_CONTA_BANCARIA_CREDITO_1=ID_CONTA_BANCARIA_CREDITO_1'
      'CONTADESTINO=CONTADESTINO'
      'AGENCIADESTINO=AGENCIADESTINO'
      'TITULARDESTINO=TITULARDESTINO'
      'IDENTICACAODESTINO=IDENTICACAODESTINO'
      'CONTAORIGEM=CONTAORIGEM'
      'AGENCIAORIGEM=AGENCIAORIGEM'
      'TITULARORIGEM=TITULARORIGEM'
      'IDENTICACAOORIGEM=IDENTICACAOORIGEM'
      'LOTE=LOTE'
      'DATA_REGISTRO=DATA_REGISTRO')
    DataSet = qryObterPorPeriodo
    BCDToCurrency = False
    Left = 592
    Top = 80
  end
  object frxRelatorioTRF: TfrxReport
    Version = '6.3.7'
    DotMatrixReport = False
    IniFile = '\Software\Fast Reports'
    PreviewOptions.Buttons = [pbPrint, pbLoad, pbSave, pbExport, pbZoom, pbFind, pbOutline, pbPageSetup, pbTools, pbEdit, pbNavigator, pbExportQuick, pbCopy, pbSelection]
    PreviewOptions.Zoom = 1.000000000000000000
    PrintOptions.Printer = 'Padr'#227'o'
    PrintOptions.PrintOnSheet = 0
    ReportOptions.CreateDate = 43789.446609259300000000
    ReportOptions.LastChange = 43789.703120358800000000
    ScriptLanguage = 'PascalScript'
    ScriptText.Strings = (
      ''
      'begin'
      ''
      'end.')
    Left = 592
    Top = 24
    Datasets = <
      item
        DataSet = frxDBTRFS
        DataSetName = 'TRFS'
      end>
    Variables = <
      item
        Name = ' Pempec'
        Value = Null
      end
      item
        Name = 'strRazaoSocial'
        Value = Null
      end
      item
        Name = 'strCNPJ'
        Value = Null
      end
      item
        Name = 'strEndereco'
        Value = Null
      end
      item
        Name = 'strCEP'
        Value = Null
      end
      item
        Name = 'strCidade'
        Value = Null
      end
      item
        Name = 'strUF'
        Value = Null
      end
      item
        Name = 'strTipoStatus'
        Value = Null
      end
      item
        Name = 'strTipo'
        Value = Null
      end
      item
        Name = 'cc_perc'
        Value = Null
      end
      item
        Name = 'strPeriodo'
        Value = Null
      end>
    Style = <
      item
        Name = 'Title'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWhite
        Font.Height = -16
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        Frame.Typ = []
        Fill.BackColor = clGray
      end
      item
        Name = 'Header'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clMaroon
        Font.Height = -13
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        Frame.Typ = []
      end
      item
        Name = 'Group header'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clMaroon
        Font.Height = -13
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        Frame.Typ = []
        Fill.BackColor = 16053492
      end
      item
        Name = 'Data'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -13
        Font.Name = 'Arial'
        Font.Style = []
        Frame.Typ = []
      end
      item
        Name = 'Group footer'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -13
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        Frame.Typ = []
      end
      item
        Name = 'Header line'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -13
        Font.Name = 'Arial'
        Font.Style = []
        Frame.Typ = [ftBottom]
        Frame.Width = 2.000000000000000000
      end>
    object Data: TfrxDataPage
      Height = 1000.000000000000000000
      Width = 1000.000000000000000000
    end
    object Page1: TfrxReportPage
      PaperWidth = 210.000000000000000000
      PaperHeight = 297.000000000000000000
      PaperSize = 9
      LeftMargin = 10.000000000000000000
      RightMargin = 10.000000000000000000
      TopMargin = 10.000000000000000000
      BottomMargin = 10.000000000000000000
      Frame.Typ = []
      MirrorMode = []
      object PageHeader1: TfrxPageHeader
        FillType = ftBrush
        Frame.Typ = []
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -16
        Font.Name = 'Arial'
        Font.Style = []
        Height = 93.504020000000000000
        ParentFont = False
        Top = 18.897650000000000000
        Width = 718.110700000000000000
        object Memo31: TfrxMemoView
          Align = baWidth
          AllowVectorExport = True
          Top = 61.488250000000000000
          Width = 718.110700000000000000
          Height = 15.118120000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -16
          Font.Name = 'tahoma'
          Font.Style = [fsBold]
          Frame.Typ = []
          HAlign = haCenter
          Memo.UTF8W = (
            'LISTAGEM DE TRANSFER'#202'NCIAS')
          ParentFont = False
          VAlign = vaCenter
        end
        object Memo2: TfrxMemoView
          AllowVectorExport = True
          Left = 3.779530000000000000
          Top = 1.559060000000000000
          Width = 109.606370000000000000
          Height = 22.677180000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -16
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Frame.Typ = []
          Memo.UTF8W = (
            'Organiza'#231#227'o: ')
          ParentFont = False
        end
        object strRazaoSocial1: TfrxMemoView
          AllowVectorExport = True
          Left = 117.283550000000000000
          Top = 1.559060000000000000
          Width = 230.551330000000000000
          Height = 18.897650000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -16
          Font.Name = 'Arial'
          Font.Style = []
          Frame.Typ = []
          Memo.UTF8W = (
            '[strRazaoSocial]')
          ParentFont = False
        end
        object Memo3: TfrxMemoView
          AllowVectorExport = True
          Left = 353.220470000000000000
          Top = 1.559060000000000000
          Width = 52.913420000000000000
          Height = 18.897650000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -16
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Frame.Typ = []
          Memo.UTF8W = (
            'CNPJ:')
          ParentFont = False
        end
        object strCNPJ: TfrxMemoView
          AllowVectorExport = True
          Left = 420.764070000000000000
          Top = 1.559060000000000000
          Width = 158.740260000000000000
          Height = 18.897650000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -16
          Font.Name = 'Arial'
          Font.Style = []
          Frame.Typ = []
          Memo.UTF8W = (
            '[strCNPJ]')
          ParentFont = False
        end
        object Memo29: TfrxMemoView
          AllowVectorExport = True
          Left = 616.842920000000000000
          Top = 1.559060000000000000
          Width = 45.354360000000000000
          Height = 18.897650000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -16
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Frame.Typ = []
          HAlign = haCenter
          Memo.UTF8W = (
            'P'#193'G.')
          ParentFont = False
        end
        object Page: TfrxMemoView
          AllowVectorExport = True
          Left = 669.315400000000000000
          Top = 1.559060000000000000
          Width = 60.472480000000000000
          Height = 18.897650000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -16
          Font.Name = 'Arial'
          Font.Style = []
          Frame.Typ = []
          Memo.UTF8W = (
            '[Page]')
          ParentFont = False
          Formats = <
            item
            end
            item
            end>
        end
        object Memo4: TfrxMemoView
          AllowVectorExport = True
          Left = 3.779530000000000000
          Top = 26.795300000000000000
          Width = 109.606370000000000000
          Height = 18.897650000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -16
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Frame.Typ = []
          Memo.UTF8W = (
            'Endere'#231'o:')
          ParentFont = False
        end
        object strEndereco: TfrxMemoView
          AllowVectorExport = True
          Left = 117.283550000000000000
          Top = 26.795300000000000000
          Width = 230.551330000000000000
          Height = 18.897650000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -16
          Font.Name = 'Arial'
          Font.Style = []
          Frame.Typ = []
          Memo.UTF8W = (
            '[strEndereco]')
          ParentFont = False
        end
        object Memo5: TfrxMemoView
          AllowVectorExport = True
          Left = 353.220470000000000000
          Top = 26.795300000000000000
          Width = 56.692950000000000000
          Height = 18.897650000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -16
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Frame.Typ = []
          Memo.UTF8W = (
            'CEP  :')
          ParentFont = False
        end
        object strCEP: TfrxMemoView
          AllowVectorExport = True
          Left = 420.764070000000000000
          Top = 26.795300000000000000
          Width = 86.929190000000000000
          Height = 18.897650000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -16
          Font.Name = 'Arial'
          Font.Style = []
          Frame.Typ = []
          Memo.UTF8W = (
            '[strCEP]')
          ParentFont = False
        end
        object Memo28: TfrxMemoView
          AllowVectorExport = True
          Left = 510.236550000000000000
          Top = 26.795300000000000000
          Width = 98.267780000000000000
          Height = 18.897650000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -16
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Frame.Typ = []
          Memo.UTF8W = (
            'CIDADE/UF:')
          ParentFont = False
        end
        object strCidade: TfrxMemoView
          AllowVectorExport = True
          Left = 619.842920000000000000
          Top = 26.795300000000000000
          Width = 120.944960000000000000
          Height = 18.897650000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -16
          Font.Name = 'Arial'
          Font.Style = []
          Frame.Typ = []
          Memo.UTF8W = (
            '[strCidade]/[strUF]')
          ParentFont = False
          Formats = <
            item
            end
            item
            end>
        end
        object Line4: TfrxLineView
          Align = baWidth
          AllowVectorExport = True
          Top = 83.826840000000000000
          Width = 718.110700000000000000
          Color = clBlack
          Frame.Style = fsDouble
          Frame.Typ = [ftTop]
        end
        object Line5: TfrxLineView
          Align = baWidth
          AllowVectorExport = True
          Top = 56.692950000000000000
          Width = 718.110700000000000000
          Color = clBlack
          Frame.Typ = [ftTop]
        end
      end
      object GroupHeader1: TfrxGroupHeader
        FillType = ftBrush
        Frame.Typ = []
        Height = 26.456710000000000000
        Top = 173.858380000000000000
        Width = 718.110700000000000000
        Condition = '1=1'
        object Memo7: TfrxMemoView
          AllowVectorExport = True
          Left = 99.836107010000000000
          Width = 57.281476180000000000
          Height = 18.897650000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clDefault
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Frame.Typ = []
          Fill.BackColor = clWindow
          HAlign = haRight
          Memo.UTF8W = (
            'DATA')
          ParentFont = False
        end
        object Memo8: TfrxMemoView
          AllowVectorExport = True
          Left = 1.377323190000000000
          Width = 88.721891160000000000
          Height = 18.897650000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clDefault
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Frame.Typ = []
          Fill.BackColor = clWindow
          HAlign = haRight
          Memo.UTF8W = (
            'IDENT. CBT')
          ParentFont = False
        end
        object Memo11: TfrxMemoView
          AllowVectorExport = True
          Left = 319.792509340000000000
          Width = 62.314480980000000000
          Height = 18.897650000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clDefault
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Frame.Typ = []
          Fill.BackColor = clWindow
          HAlign = haRight
          Memo.UTF8W = (
            'DESTINO')
          ParentFont = False
        end
        object Memo14: TfrxMemoView
          AllowVectorExport = True
          Left = 385.065655250000000000
          Width = 96.330250980000000000
          Height = 18.897650000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clDefault
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Frame.Typ = []
          Fill.BackColor = clWindow
          HAlign = haRight
          Memo.UTF8W = (
            'IDENT. DESTINO')
          ParentFont = False
        end
        object Memo15: TfrxMemoView
          AllowVectorExport = True
          Left = 159.118519920000000000
          Width = 57.604397680000000000
          Height = 18.897650000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clDefault
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Frame.Typ = []
          Fill.BackColor = clWindow
          HAlign = haRight
          Memo.UTF8W = (
            'ORIGEM')
          ParentFont = False
        end
        object Memo18: TfrxMemoView
          AllowVectorExport = True
          Left = 221.002734730000000000
          Width = 77.432600980000000000
          Height = 18.897650000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clDefault
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Frame.Typ = []
          Fill.BackColor = clWindow
          HAlign = haRight
          Memo.UTF8W = (
            'IDENT. ORIG')
          ParentFont = False
        end
        object Memo19: TfrxMemoView
          AllowVectorExport = True
          Left = 513.868545700000000000
          Width = 92.550720980000000000
          Height = 18.897650000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clDefault
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Frame.Typ = []
          Fill.BackColor = clWindow
          HAlign = haRight
          Memo.UTF8W = (
            'LOTE CONT'#193'BIL')
          ParentFont = False
        end
        object Line3: TfrxLineView
          Align = baWidth
          AllowVectorExport = True
          Top = 21.456710000000000000
          Width = 718.110700000000000000
          Color = clBlack
          Frame.Style = fsDouble
          Frame.Typ = [ftTop]
        end
        object Memo6: TfrxMemoView
          AllowVectorExport = True
          Left = 612.277560020000000000
          Width = 102.635836180000000000
          Height = 18.897650000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clDefault
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Frame.Typ = []
          Fill.BackColor = clWindow
          HAlign = haRight
          Memo.UTF8W = (
            'VALOR')
          ParentFont = False
        end
      end
      object MasterData1: TfrxMasterData
        FillType = ftBrush
        Frame.Typ = []
        Height = 15.118110240000000000
        Top = 245.669450000000000000
        Width = 718.110700000000000000
        DataSet = frxDBTRFS
        DataSetName = 'TRFS'
        RowCount = 0
        object Memo26: TfrxMemoView
          AllowVectorExport = True
          Left = 99.836107010000000000
          Width = 57.281476180000000000
          Height = 18.897650000000000000
          DataField = 'DATA_MOVIMENTO'
          DataSet = frxDBTRFS
          DataSetName = 'TRFS'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -8
          Font.Name = 'Tahoma'
          Font.Style = []
          Frame.Typ = []
          HAlign = haRight
          Memo.UTF8W = (
            '[TRFS."DATA_MOVIMENTO"]')
          ParentFont = False
        end
        object Memo27: TfrxMemoView
          AllowVectorExport = True
          Left = 1.377323190000000000
          Width = 88.721891160000000000
          Height = 18.897650000000000000
          DataField = 'IDENTIFICACAO'
          DataSet = frxDBTRFS
          DataSetName = 'TRFS'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -8
          Font.Name = 'Tahoma'
          Font.Style = []
          Frame.Typ = []
          HAlign = haRight
          Memo.UTF8W = (
            '[TRFS."IDENTIFICACAO"]')
          ParentFont = False
        end
        object Memo30: TfrxMemoView
          AllowVectorExport = True
          Left = 319.792509340000000000
          Width = 62.314480980000000000
          Height = 18.897650000000000000
          DataField = 'CONTADESTINO'
          DataSet = frxDBTRFS
          DataSetName = 'TRFS'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -8
          Font.Name = 'Tahoma'
          Font.Style = []
          Frame.Typ = []
          HAlign = haRight
          Memo.UTF8W = (
            '[TRFS."CONTADESTINO"]')
          ParentFont = False
        end
        object Memo33: TfrxMemoView
          AllowVectorExport = True
          Left = 385.065655250000000000
          Width = 96.330250980000000000
          Height = 18.897650000000000000
          DataField = 'IDENTICACAODESTINO'
          DataSet = frxDBTRFS
          DataSetName = 'TRFS'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -8
          Font.Name = 'Tahoma'
          Font.Style = []
          Frame.Typ = []
          HAlign = haRight
          Memo.UTF8W = (
            '[TRFS."IDENTICACAODESTINO"]')
          ParentFont = False
        end
        object Memo34: TfrxMemoView
          AllowVectorExport = True
          Left = 159.118519920000000000
          Width = 57.604397680000000000
          Height = 18.897650000000000000
          DataField = 'CONTAORIGEM'
          DataSet = frxDBTRFS
          DataSetName = 'TRFS'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -8
          Font.Name = 'Tahoma'
          Font.Style = []
          Frame.Typ = []
          HAlign = haRight
          Memo.UTF8W = (
            '[TRFS."CONTAORIGEM"]')
          ParentFont = False
        end
        object Memo37: TfrxMemoView
          AllowVectorExport = True
          Left = 221.002734730000000000
          Width = 77.432600980000000000
          Height = 18.897650000000000000
          DataField = 'IDENTICACAOORIGEM'
          DataSet = frxDBTRFS
          DataSetName = 'TRFS'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -8
          Font.Name = 'Tahoma'
          Font.Style = []
          Frame.Typ = []
          HAlign = haRight
          Memo.UTF8W = (
            '[TRFS."IDENTICACAOORIGEM"]')
          ParentFont = False
        end
        object Memo38: TfrxMemoView
          AllowVectorExport = True
          Left = 513.868545700000000000
          Width = 92.550720980000000000
          Height = 18.897650000000000000
          DataField = 'LOTE'
          DataSet = frxDBTRFS
          DataSetName = 'TRFS'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -8
          Font.Name = 'Tahoma'
          Font.Style = []
          Frame.Typ = []
          HAlign = haRight
          Memo.UTF8W = (
            '[TRFS."LOTE"]')
          ParentFont = False
        end
        object Memo25: TfrxMemoView
          AllowVectorExport = True
          Left = 612.277560020000000000
          Width = 102.635836180000000000
          Height = 18.897650000000000000
          DataField = 'VALOR'
          DataSet = frxDBTRFS
          DataSetName = 'TRFS'
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -8
          Font.Name = 'Tahoma'
          Font.Style = []
          Frame.Typ = []
          HAlign = haRight
          Memo.UTF8W = (
            '[TRFS."VALOR"]')
          ParentFont = False
        end
      end
      object GroupFooter1: TfrxGroupFooter
        FillType = ftBrush
        Frame.Typ = []
        Top = 283.464750000000000000
        Width = 718.110700000000000000
      end
      object ReportSummary1: TfrxReportSummary
        FillType = ftBrush
        Frame.Typ = []
        Height = 52.913420000000000000
        Top = 343.937230000000000000
        Width = 718.110700000000000000
        object Memo20: TfrxMemoView
          AllowVectorExport = True
          Left = 619.057090020000000000
          Top = 3.000000000000000000
          Width = 98.856306180000000000
          Height = 18.897650000000000000
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlue
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Frame.Typ = []
          Fill.BackColor = 14211288
          HAlign = haRight
          Memo.UTF8W = (
            '[SUM(<TRFS."VALOR">,MasterData1)]')
          ParentFont = False
        end
        object Line1: TfrxLineView
          Align = baWidth
          AllowVectorExport = True
          Width = 718.110700000000000000
          Color = clBlack
          Frame.Style = fsDouble
          Frame.Typ = [ftTop]
        end
        object Memo21: TfrxMemoView
          AllowVectorExport = True
          Left = 483.818573190000000000
          Top = 3.000000000000000000
          Width = 136.063080000000000000
          Height = 18.897650000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlue
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Frame.Typ = []
          Fill.BackColor = 14211288
          HAlign = haRight
          Memo.UTF8W = (
            'TOTAL DO PER'#205'ODO  R$ ')
          ParentFont = False
        end
        object Line2: TfrxLineView
          Align = baWidth
          AllowVectorExport = True
          Top = 23.456710000000000000
          Width = 718.110700000000000000
          Color = clBlack
          Frame.Typ = [ftTop]
        end
      end
      object GroupHeader2: TfrxGroupHeader
        FillType = ftBrush
        Frame.Typ = []
        Top = 222.992270000000000000
        Width = 718.110700000000000000
        Condition = 'TRFS."ID_CONTA_BANCARIA_TRANSFERENCIA"'
      end
      object PageFooter1: TfrxPageFooter
        FillType = ftBrush
        Frame.Typ = []
        Height = 18.897650000000000000
        Top = 419.527830000000000000
        Width = 718.110700000000000000
        object Memo36: TfrxMemoView
          Align = baLeft
          AllowVectorExport = True
          Width = 287.244280000000000000
          Height = 15.118120000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -8
          Font.Name = 'Tahoma'
          Font.Style = [fsBold]
          Frame.Typ = []
          Memo.UTF8W = (
            'Pempec Enterprise Finance')
          ParentFont = False
          VAlign = vaBottom
        end
        object Memo79: TfrxMemoView
          Align = baRight
          AllowVectorExport = True
          Left = 540.472790000000000000
          Width = 71.811070000000000000
          Height = 15.118120000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -8
          Font.Name = 'Tahoma'
          Font.Style = [fsBold]
          Frame.Typ = []
          HAlign = haRight
          Memo.UTF8W = (
            'Emitido em:  ')
          ParentFont = False
          VAlign = vaBottom
        end
        object Date: TfrxMemoView
          Align = baRight
          AllowVectorExport = True
          Left = 612.283860000000000000
          Width = 56.692950000000000000
          Height = 15.118120000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -8
          Font.Name = 'Tahoma'
          Font.Style = [fsBold]
          Frame.Typ = []
          HAlign = haRight
          Memo.UTF8W = (
            '[Date]')
          ParentFont = False
          VAlign = vaBottom
        end
        object Time: TfrxMemoView
          Align = baRight
          AllowVectorExport = True
          Left = 668.976810000000000000
          Width = 49.133890000000000000
          Height = 15.118120000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -8
          Font.Name = 'Tahoma'
          Font.Style = [fsBold]
          Frame.Typ = []
          HAlign = haRight
          Memo.UTF8W = (
            '[Time]')
          ParentFont = False
          VAlign = vaBottom
        end
      end
    end
  end
  object ds1: TDataSource
    DataSet = qryObterPorPeriodo
    Left = 528
    Top = 88
  end
end
