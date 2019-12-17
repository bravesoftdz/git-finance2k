object frmSaldoContas: TfrmSaldoContas
  Left = 0
  Top = 0
  Caption = 'Saldo das Contas Banc'#225'rias'
  ClientHeight = 599
  ClientWidth = 1387
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
  object pnl1: TPanel
    Left = 0
    Top = 0
    Width = 1387
    Height = 599
    Align = alClient
    Color = clInfoBk
    ParentBackground = False
    TabOrder = 5
    object btn1: TBitBtn
      Left = 768
      Top = 107
      Width = 145
      Height = 45
      Caption = 'Fechar'
      TabOrder = 0
      OnClick = btn1Click
    end
    object dxStatusBar: TdxStatusBar
      AlignWithMargins = True
      Left = 4
      Top = 575
      Width = 1379
      Height = 20
      Panels = <
        item
          PanelStyleClassName = 'TdxStatusBarTextPanelStyle'
          Width = 100
        end
        item
          PanelStyleClassName = 'TdxStatusBarTextPanelStyle'
          Width = 600
        end>
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'Tahoma'
      Font.Style = []
    end
  end
  inline frmContaBancaria1: TfrmContaBancaria
    Left = 311
    Top = 38
    Width = 243
    Height = 114
    TabOrder = 0
    ExplicitLeft = 311
    ExplicitTop = 38
    inherited cbbConta: TComboBox
      OnChange = frmContaBancaria1cbbContaChange
    end
  end
  object dbgrd1: TDBGrid
    AlignWithMargins = True
    Left = 3
    Top = 166
    Width = 1377
    Height = 408
    Color = clInfoBk
    DataSource = dsSaldo
    GradientEndColor = clTeal
    GradientStartColor = clMoneyGreen
    Options = [dgTitles, dgColLines, dgRowLines, dgTabs]
    TabOrder = 1
    TitleFont.Charset = DEFAULT_CHARSET
    TitleFont.Color = clWindowText
    TitleFont.Height = -11
    TitleFont.Name = 'Tahoma'
    TitleFont.Style = []
    StyleElements = [seFont, seClient]
    OnDrawColumnCell = dbgrd1DrawColumnCell
    Columns = <
      item
        Expanded = False
        FieldName = 'CONTA'
        Width = 70
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'JANEIRO'
        Width = 100
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'FEVEREIRO'
        Width = 100
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'MARCO'
        Width = 100
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'ABRIL'
        Width = 100
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'MAIO'
        Width = 100
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'JUNHO'
        Width = 100
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'JULHO'
        Width = 100
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'AGOSTO'
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'SETEMBRO'
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'OUTUBRO'
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'NOVEMBRO'
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'DEZEMBRO'
        Visible = True
      end>
  end
  object btnProcessarSaldo: TButton
    Left = 584
    Top = 28
    Width = 145
    Height = 45
    Caption = 'Processar'
    TabOrder = 2
    OnClick = btnProcessarSaldoClick
  end
  inline frmPeriodo1: TfrmPeriodo
    Left = 15
    Top = 21
    Width = 281
    Height = 89
    TabOrder = 3
    ExplicitLeft = 15
    ExplicitTop = 21
    ExplicitWidth = 281
    ExplicitHeight = 89
    inherited lbl1: TLabel
      Top = 22
      ExplicitTop = 22
    end
    inherited lbl2: TLabel
      Top = 22
      ExplicitTop = 22
    end
    inherited dtpDataInicial: TDateTimePicker
      Top = 41
      ExplicitTop = 41
    end
    inherited dtpDataFinal: TDateTimePicker
      Top = 41
      ExplicitTop = 41
    end
  end
  object btnImprimir: TButton
    Left = 584
    Top = 107
    Width = 145
    Height = 45
    Caption = 'Imprimir'
    TabOrder = 4
    OnClick = btnImprimirClick
  end
  object dsSaldo: TDataSource
    DataSet = qrySaldosBancarios
    OnDataChange = dsSaldoDataChange
    Left = 448
    Top = 256
  end
  object qryObterConta: TFDQuery
    Connection = dmConexao.conn
    SQL.Strings = (
      'SELECT'
      '     CB.ID_CONTA_BANCARIA,'
      '     CB.CONTA,'
      '     CB.AGENCIA,'
      '     CB.TITULAR,'
      '     CB.SALDO_INICIAL,'
      '     CB.ID_CONTA_CONTABIL,'
      '     CC.CONTA AS CONTA_CONT,'
      '     CC.DESCRICAO AS DSC_CONT,'
      '     CC.CODREDUZ AS COD_CONT'
      ''
      ' FROM CONTA_BANCARIA CB'
      
        'LEFT OUTER JOIN CONTA_CONTABIL CC ON (CC.ID_CONTA_CONTABIL = CB.' +
        'ID_CONTA_CONTABIL) AND (CC.ID_ORGANIZACAO = CB.ID_ORGANIZACAO)'
      
        'WHERE (CB.ID_CONTA_BANCARIA = :PIDCONTA) AND (CB.ID_ORGANIZACAO ' +
        '= :PIDORGANIZACAO)'
      ''
      '')
    Left = 432
    Top = 528
    ParamData = <
      item
        Name = 'PIDCONTA'
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
  object qrySaldosBancarios: TFDQuery
    Connection = dmConexao.conn
    FormatOptions.AssignedValues = [fvFmtDisplayNumeric, fvFmtEditNumeric]
    FormatOptions.FmtDisplayNumeric = '###,##0.00'
    FormatOptions.FmtEditNumeric = '###,##0.00'
    SQL.Strings = (
      'SELECT'
      '     CB.ID_CONTA_BANCARIA,'
      '     CB.CONTA,     '
      '     CB.TITULAR,'
      '     CBS.ANO,'
      '     CBS.JANE AS JANEIRO,'
      '     CBS.FEVE AS FEVEREIRO,'
      '     CBS.MARC AS MARCO,'
      '     CBS.ABRI AS ABRIL,'
      '     CBS.MAIO AS MAIO,'
      '     CBS.JUNH AS JUNHO,'
      '     CBS.JULH AS JULHO,'
      '     CBS.AGOS AS AGOSTO,'
      '     CBS.SETE AS SETEMBRO,'
      '     CBS.OUTU AS OUTUBRO,'
      '     CBS.NOVE AS NOVEMBRO,'
      '     CBS.DEZE AS DEZEMBRO'
      ''
      ''
      ''
      'FROM CONTA_BANCARIA_SALDO CBS'
      ''
      ''
      
        'LEFT OUTER JOIN CONTA_BANCARIA CB  ON (CB.ID_CONTA_BANCARIA = CB' +
        'S.ID_CONTA_BANCARIA)'
      ''
      'WHERE 1=1'
      ''
      'ORDER BY CBS.ANO, CB.CONTA'
      ''
      '')
    Left = 936
    Top = 528
  end
  object qryObterTodasContas: TFDQuery
    Connection = dmConexao.conn
    SQL.Strings = (
      'SELECT'
      '     CB.ID_CONTA_BANCARIA,'
      '     CB.CONTA,'
      '     CB.AGENCIA,'
      '     CB.TITULAR,'
      '     CB.SALDO_INICIAL,'
      '     CB.ID_CONTA_CONTABIL'
      ''
      ''
      'FROM CONTA_BANCARIA CB'
      'WHERE (CB.ID_ORGANIZACAO = :PIDORGANIZACAO)'
      ''
      '')
    Left = 568
    Top = 528
    ParamData = <
      item
        Name = 'PIDORGANIZACAO'
        DataType = ftString
        ParamType = ptInput
        Size = 36
      end>
  end
  object qryLimpaDataset: TFDQuery
    Connection = dmConexao.conn
    FormatOptions.AssignedValues = [fvFmtDisplayNumeric, fvFmtEditNumeric]
    FormatOptions.FmtDisplayNumeric = '###,##0.00'
    FormatOptions.FmtEditNumeric = '###,##0.00'
    SQL.Strings = (
      'DELETE FROM  CONTA_BANCARIA_SALDO WHERE 1=1')
    Left = 88
    Top = 528
  end
  object qryPreparaDataset: TFDQuery
    Connection = dmConexao.conn
    FormatOptions.AssignedValues = [fvFmtDisplayNumeric, fvFmtEditNumeric]
    FormatOptions.FmtDisplayNumeric = '###,##0.00'
    FormatOptions.FmtEditNumeric = '###,##0.00'
    SQL.Strings = (
      
        'INSERT INTO CONTA_BANCARIA_SALDO (ID_CONTA_BANCARIA, ANO) VALUES' +
        ' ( :PIDCONTA, :PANO);'
      '')
    Left = 200
    Top = 528
    ParamData = <
      item
        Name = 'PIDCONTA'
        DataType = ftString
        ParamType = ptInput
        Size = 36
      end
      item
        Name = 'PANO'
        DataType = ftString
        ParamType = ptInput
        Size = 4
      end>
  end
  object qryInsereSaldoConta: TFDQuery
    Connection = dmConexao.conn
    FormatOptions.AssignedValues = [fvFmtDisplayNumeric, fvFmtEditNumeric]
    FormatOptions.FmtDisplayNumeric = '###,##0.00'
    FormatOptions.FmtEditNumeric = '###,##0.00'
    SQL.Strings = (
      
        'INSERT INTO CONTA_BANCARIA_SALDO (ID_CONTA_BANCARIA, ANO) VALUES' +
        ' ( :PIDCONTA, :PANO);'
      '')
    Left = 320
    Top = 528
    ParamData = <
      item
        Name = 'PIDCONTA'
        DataType = ftString
        ParamType = ptInput
        Size = 36
      end
      item
        Name = 'PANO'
        DataType = ftString
        ParamType = ptInput
        Size = 4
      end>
  end
  object frxRelatorioSaldos: TfrxReport
    Version = '6.3.7'
    DotMatrixReport = False
    IniFile = '\Software\Fast Reports'
    PreviewOptions.Buttons = [pbPrint, pbLoad, pbSave, pbExport, pbZoom, pbFind, pbOutline, pbPageSetup, pbTools, pbEdit, pbNavigator, pbExportQuick]
    PreviewOptions.Zoom = 1.000000000000000000
    PrintOptions.Printer = 'Default'
    PrintOptions.PrintOnSheet = 0
    ReportOptions.CreateDate = 42573.413464710600000000
    ReportOptions.LastChange = 43770.569159594910000000
    ScriptLanguage = 'PascalScript'
    ScriptText.Strings = (
      'begin'
      ''
      'end.')
    Left = 784
    Top = 40
    Datasets = <
      item
        DataSet = frxDBSaldos
        DataSetName = 'SALDOS'
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
    Style = <>
    object Data: TfrxDataPage
      Height = 1000.000000000000000000
      Width = 1000.000000000000000000
    end
    object Page1: TfrxReportPage
      Orientation = poLandscape
      PaperWidth = 297.000000000000000000
      PaperHeight = 220.000000000000000000
      PaperSize = 256
      LeftMargin = 10.000000000000000000
      RightMargin = 10.000000000000000000
      TopMargin = 10.000000000000000000
      BottomMargin = 10.000000000000000000
      Frame.Style = fsDouble
      Frame.Typ = []
      LargeDesignHeight = True
      MirrorMode = []
      PrintOnPreviousPage = True
      object PageHeader1: TfrxPageHeader
        FillType = ftBrush
        Frame.Typ = []
        Height = 117.165395830000000000
        Top = 18.897650000000000000
        Width = 1046.929810000000000000
        object Memo2: TfrxMemoView
          AllowVectorExport = True
          Left = 3.779530000000000000
          Top = 1.559059999999999000
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
          Top = 1.559059999999999000
          Width = 442.205010000000000000
          Height = 18.897650000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = []
          Frame.Typ = []
          Memo.UTF8W = (
            '[strRazaoSocial]')
          ParentFont = False
        end
        object Memo3: TfrxMemoView
          AllowVectorExport = True
          Left = 572.094620000000000000
          Top = 1.559059999999999000
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
          Left = 628.638220000000000000
          Top = 1.559059999999999000
          Width = 245.669450000000000000
          Height = 18.897650000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = []
          Frame.Typ = []
          Memo.UTF8W = (
            '[strCNPJ]')
          ParentFont = False
        end
        object Memo4: TfrxMemoView
          AllowVectorExport = True
          Left = 3.779530000000000000
          Top = 30.015770000000010000
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
          Top = 30.015770000000010000
          Width = 442.205010000000000000
          Height = 18.897650000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = []
          Frame.Typ = []
          Memo.UTF8W = (
            '[strEndereco]')
          ParentFont = False
        end
        object strCEP: TfrxMemoView
          AllowVectorExport = True
          Left = 632.417750000000000000
          Top = 33.795300000000000000
          Width = 147.401670000000000000
          Height = 18.897650000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = []
          Frame.Typ = []
          Memo.UTF8W = (
            '[strCEP]')
          ParentFont = False
        end
        object Memo5: TfrxMemoView
          AllowVectorExport = True
          Left = 572.094620000000000000
          Top = 33.795300000000000000
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
        object Memo6: TfrxMemoView
          AllowVectorExport = True
          Left = 790.142240000000000000
          Top = 33.795300000000000000
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
          Left = 903.307670000000000000
          Top = 33.795300000000000000
          Width = 120.944960000000000000
          Height = 18.897650000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
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
        object Page: TfrxMemoView
          AllowVectorExport = True
          Left = 963.780150000000000000
          Top = 1.559059999999999000
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
        object Memo15: TfrxMemoView
          AllowVectorExport = True
          Left = 910.866730000000000000
          Top = 1.559059999999999000
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
        object Memo8: TfrxMemoView
          Align = baWidth
          AllowVectorExport = True
          Top = 63.031540000000010000
          Width = 1046.929810000000000000
          Height = 26.456710000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -16
          Font.Name = 'tahoma'
          Font.Style = [fsBold]
          Frame.Typ = []
          HAlign = haCenter
          Memo.UTF8W = (
            'SALDO BANC'#193'RIO GLOBAL')
          ParentFont = False
          VAlign = vaCenter
        end
        object Memo78: TfrxMemoView
          Align = baWidth
          AllowVectorExport = True
          Top = 90.267780000000000000
          Width = 1046.929810000000000000
          Height = 26.456710000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -16
          Font.Name = 'Tahoma'
          Font.Style = [fsBold]
          Frame.Typ = []
          HAlign = haCenter
          Memo.UTF8W = (
            '[strPeriodo]')
          ParentFont = False
        end
        object Line5: TfrxLineView
          Align = baWidth
          AllowVectorExport = True
          Top = 60.472480000000000000
          Width = 1046.929810000000000000
          Color = clBlack
          Frame.Style = fsDouble
          Frame.Typ = [ftTop]
        end
      end
      object Memo41: TfrxMemoView
        AllowVectorExport = True
        Left = 7.559060000000000000
        Top = -7.559060000000000000
        Width = 49.133890000000000000
        Height = 15.118120000000000000
        DataSet = frmCTPHistorico.frxDBTitulosPorCedente
        DataSetName = 'Titulos'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -8
        Font.Name = 'Arial'
        Font.Style = []
        Frame.Typ = []
        ParentFont = False
      end
      object PageFooter1: TfrxPageFooter
        FillType = ftBrush
        Frame.Typ = []
        Height = 22.677180000000000000
        Top = 438.425480000000000000
        Width = 1046.929810000000000000
        object Memo36: TfrxMemoView
          Align = baLeft
          AllowVectorExport = True
          Top = 2.000000000000000000
          Width = 287.244280000000000000
          Height = 18.897650000000000000
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
        object Date: TfrxMemoView
          Align = baRight
          AllowVectorExport = True
          Left = 941.102970000000100000
          Top = 2.000000000000000000
          Width = 56.692950000000000000
          Height = 18.897650000000000000
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
        object Memo79: TfrxMemoView
          Align = baRight
          AllowVectorExport = True
          Left = 869.291900000000100000
          Top = 2.000000000000000000
          Width = 71.811070000000000000
          Height = 18.897650000000000000
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
        object Time: TfrxMemoView
          Align = baRight
          AllowVectorExport = True
          Left = 997.795920000000100000
          Top = 2.000000000000000000
          Width = 49.133890000000000000
          Height = 18.897650000000000000
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
      object GroupHeader1: TfrxGroupHeader
        FillType = ftBrush
        Frame.Typ = []
        Height = 30.236240000000000000
        Top = 196.535560000000000000
        Width = 1046.929810000000000000
        Condition = '1=1'
        object Line2: TfrxLineView
          Align = baWidth
          AllowVectorExport = True
          Width = 1046.929810000000000000
          Color = clBlack
          Frame.Typ = [ftTop]
        end
        object Memo23: TfrxMemoView
          AllowVectorExport = True
          Top = 3.779529999999994000
          Width = 56.692950000000000000
          Height = 22.677180000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Tahoma'
          Font.Style = [fsBold]
          Frame.Typ = []
          Memo.UTF8W = (
            'CONTA')
          ParentFont = False
        end
        object Memo1: TfrxMemoView
          AllowVectorExport = True
          Left = 58.472431180000000000
          Top = 3.779529999999994000
          Width = 68.031540000000000000
          Height = 22.677180000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Tahoma'
          Font.Style = [fsBold]
          Frame.Typ = []
          HAlign = haRight
          Memo.UTF8W = (
            'JANEIRO')
          ParentFont = False
        end
        object Line1: TfrxLineView
          Align = baWidth
          AllowVectorExport = True
          Top = 26.456709999999990000
          Width = 1046.929810000000000000
          Color = clBlack
          Frame.Typ = [ftTop]
        end
        object Memo10: TfrxMemoView
          AllowVectorExport = True
          Left = 136.401621180000000000
          Top = 3.779529999999994000
          Width = 68.031540000000000000
          Height = 22.677180000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Tahoma'
          Font.Style = [fsBold]
          Frame.Typ = []
          HAlign = haRight
          Memo.UTF8W = (
            'FEVEREIRO')
          ParentFont = False
        end
        object Memo16: TfrxMemoView
          AllowVectorExport = True
          Left = 214.551281180000000000
          Top = 3.779529999999994000
          Width = 68.031540000000000000
          Height = 22.677180000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Tahoma'
          Font.Style = [fsBold]
          Frame.Typ = []
          HAlign = haRight
          Memo.UTF8W = (
            'MAR'#199'O')
          ParentFont = False
        end
        object Memo18: TfrxMemoView
          AllowVectorExport = True
          Left = 292.480471180000000000
          Top = 3.779529999999994000
          Width = 68.031540000000000000
          Height = 22.677180000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Tahoma'
          Font.Style = [fsBold]
          Frame.Typ = []
          HAlign = haRight
          Memo.UTF8W = (
            'ABRIL')
          ParentFont = False
        end
        object Memo20: TfrxMemoView
          AllowVectorExport = True
          Left = 370.630131180000000000
          Top = 3.779529999999994000
          Width = 68.031540000000000000
          Height = 22.677180000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Tahoma'
          Font.Style = [fsBold]
          Frame.Typ = []
          HAlign = haRight
          Memo.UTF8W = (
            'MAIO')
          ParentFont = False
        end
        object Memo7: TfrxMemoView
          AllowVectorExport = True
          Left = 448.559321180000000000
          Top = 3.779529999999994000
          Width = 68.031540000000000000
          Height = 22.677180000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Tahoma'
          Font.Style = [fsBold]
          Frame.Typ = []
          HAlign = haRight
          Memo.UTF8W = (
            'JUNHO')
          ParentFont = False
        end
        object Memo13: TfrxMemoView
          AllowVectorExport = True
          Left = 526.708981180000000000
          Top = 3.779529999999994000
          Width = 68.031540000000000000
          Height = 22.677180000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Tahoma'
          Font.Style = [fsBold]
          Frame.Typ = []
          HAlign = haRight
          Memo.UTF8W = (
            'JULHO')
          ParentFont = False
        end
        object Memo22: TfrxMemoView
          AllowVectorExport = True
          Left = 604.638171180000000000
          Top = 3.779529999999994000
          Width = 68.031540000000000000
          Height = 22.677180000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Tahoma'
          Font.Style = [fsBold]
          Frame.Typ = []
          HAlign = haRight
          Memo.UTF8W = (
            'AGOSTO')
          ParentFont = False
        end
        object Memo24: TfrxMemoView
          AllowVectorExport = True
          Left = 682.787831180000000000
          Top = 3.779529999999994000
          Width = 68.031540000000000000
          Height = 22.677180000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Tahoma'
          Font.Style = [fsBold]
          Frame.Typ = []
          HAlign = haRight
          Memo.UTF8W = (
            'SETEMBRO')
          ParentFont = False
        end
        object Memo25: TfrxMemoView
          AllowVectorExport = True
          Left = 761.717021180000000000
          Top = 3.779529999999994000
          Width = 68.031540000000000000
          Height = 22.677180000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Tahoma'
          Font.Style = [fsBold]
          Frame.Typ = []
          HAlign = haRight
          Memo.UTF8W = (
            'OUTUBRO')
          ParentFont = False
        end
        object Memo31: TfrxMemoView
          AllowVectorExport = True
          Left = 838.866681180000000000
          Top = 3.779529999999994000
          Width = 68.031540000000000000
          Height = 22.677180000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Tahoma'
          Font.Style = [fsBold]
          Frame.Typ = []
          HAlign = haRight
          Memo.UTF8W = (
            'NOVEMBRO')
          ParentFont = False
        end
        object Memo32: TfrxMemoView
          AllowVectorExport = True
          Left = 917.795871180000000000
          Top = 3.779529999999994000
          Width = 68.031540000000000000
          Height = 22.677180000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Tahoma'
          Font.Style = [fsBold]
          Frame.Typ = []
          HAlign = haRight
          Memo.UTF8W = (
            'DEZEMBRO')
          ParentFont = False
        end
      end
      object SALDOS: TfrxMasterData
        FillType = ftBrush
        Frame.Typ = []
        Height = 17.007874020000000000
        Top = 249.448980000000000000
        Width = 1046.929810000000000000
        DataSet = frxDBSaldos
        DataSetName = 'SALDOS'
        RowCount = 0
        object Memo14: TfrxMemoView
          Align = baClient
          AllowVectorExport = True
          Width = 1046.929810000000000000
          Height = 17.007874020000000000
          Frame.Typ = []
          Fill.BackColor = clWindow
          Highlight.ApplyFont = False
          Highlight.Font.Charset = DEFAULT_CHARSET
          Highlight.Font.Color = clRed
          Highlight.Font.Height = -13
          Highlight.Font.Name = 'Arial'
          Highlight.Font.Style = []
          Highlight.Condition = '<Line#> mod 2 <> 0'
          Highlight.FillType = ftBrush
          Highlight.Fill.BackColor = 10218495
          Highlight.Frame.Typ = []
        end
        object Memo9: TfrxMemoView
          AllowVectorExport = True
          Width = 56.692950000000000000
          Height = 15.118110240000000000
          DataField = 'CONTA'
          DataSet = frxDBSaldos
          DataSetName = 'SALDOS'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Tahoma'
          Font.Style = []
          Frame.Typ = []
          Memo.UTF8W = (
            '[SALDOS."CONTA"]')
          ParentFont = False
        end
        object Memo11: TfrxMemoView
          AllowVectorExport = True
          Left = 50.913420000000000000
          Width = 75.590551180000000000
          Height = 15.118110240000000000
          DataField = 'JANEIRO'
          DataSet = frxDBSaldos
          DataSetName = 'SALDOS'
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Tahoma'
          Font.Style = []
          Frame.Typ = []
          HAlign = haRight
          Memo.UTF8W = (
            '[SALDOS."JANEIRO"]')
          ParentFont = False
        end
        object Memo12: TfrxMemoView
          AllowVectorExport = True
          Left = 128.842610000000000000
          Width = 75.590551180000000000
          Height = 15.118110240000000000
          DataField = 'FEVEREIRO'
          DataSet = frxDBSaldos
          DataSetName = 'SALDOS'
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Tahoma'
          Font.Style = []
          Frame.Typ = []
          HAlign = haRight
          Memo.UTF8W = (
            '[SALDOS."FEVEREIRO"]')
          ParentFont = False
        end
        object Memo17: TfrxMemoView
          AllowVectorExport = True
          Left = 206.992270000000000000
          Width = 75.590551180000000000
          Height = 15.118110240000000000
          DataField = 'MARCO'
          DataSet = frxDBSaldos
          DataSetName = 'SALDOS'
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Tahoma'
          Font.Style = []
          Frame.Typ = []
          HAlign = haRight
          Memo.UTF8W = (
            '[SALDOS."MARCO"]')
          ParentFont = False
        end
        object Memo19: TfrxMemoView
          AllowVectorExport = True
          Left = 284.921460000000000000
          Width = 75.590551180000000000
          Height = 15.118110240000000000
          DataField = 'ABRIL'
          DataSet = frxDBSaldos
          DataSetName = 'SALDOS'
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Tahoma'
          Font.Style = []
          Frame.Typ = []
          HAlign = haRight
          Memo.UTF8W = (
            '[SALDOS."ABRIL"]')
          ParentFont = False
        end
        object Memo21: TfrxMemoView
          AllowVectorExport = True
          Left = 363.071120000000000000
          Width = 75.590551180000000000
          Height = 15.118110240000000000
          DataField = 'MAIO'
          DataSet = frxDBSaldos
          DataSetName = 'SALDOS'
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Tahoma'
          Font.Style = []
          Frame.Typ = []
          HAlign = haRight
          Memo.UTF8W = (
            '[SALDOS."MAIO"]')
          ParentFont = False
        end
        object Memo26: TfrxMemoView
          AllowVectorExport = True
          Left = 441.000310000000000000
          Width = 75.590551180000000000
          Height = 15.118110240000000000
          DataField = 'JUNHO'
          DataSet = frxDBSaldos
          DataSetName = 'SALDOS'
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Tahoma'
          Font.Style = []
          Frame.Typ = []
          HAlign = haRight
          Memo.UTF8W = (
            '[SALDOS."JUNHO"]')
          ParentFont = False
        end
        object Memo27: TfrxMemoView
          AllowVectorExport = True
          Left = 519.149970000000000000
          Width = 75.590551180000000000
          Height = 15.118110240000000000
          DataField = 'JULHO'
          DataSet = frxDBSaldos
          DataSetName = 'SALDOS'
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Tahoma'
          Font.Style = []
          Frame.Typ = []
          HAlign = haRight
          Memo.UTF8W = (
            '[SALDOS."JULHO"]')
          ParentFont = False
        end
        object Memo28: TfrxMemoView
          AllowVectorExport = True
          Left = 597.079160000000000000
          Width = 75.590551180000000000
          Height = 15.118110240000000000
          DataField = 'AGOSTO'
          DataSet = frxDBSaldos
          DataSetName = 'SALDOS'
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Tahoma'
          Font.Style = []
          Frame.Typ = []
          HAlign = haRight
          Memo.UTF8W = (
            '[SALDOS."AGOSTO"]')
          ParentFont = False
        end
        object Memo29: TfrxMemoView
          AllowVectorExport = True
          Left = 675.228820000000000000
          Width = 75.590551180000000000
          Height = 15.118110240000000000
          DataField = 'SETEMBRO'
          DataSet = frxDBSaldos
          DataSetName = 'SALDOS'
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Tahoma'
          Font.Style = []
          Frame.Typ = []
          HAlign = haRight
          Memo.UTF8W = (
            '[SALDOS."SETEMBRO"]')
          ParentFont = False
        end
        object Memo30: TfrxMemoView
          AllowVectorExport = True
          Left = 754.158010000000000000
          Width = 75.590551180000000000
          Height = 15.118110240000000000
          DataField = 'OUTUBRO'
          DataSet = frxDBSaldos
          DataSetName = 'SALDOS'
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Tahoma'
          Font.Style = []
          Frame.Typ = []
          HAlign = haRight
          Memo.UTF8W = (
            '[SALDOS."OUTUBRO"]')
          ParentFont = False
        end
        object Memo33: TfrxMemoView
          AllowVectorExport = True
          Left = 831.307670000000000000
          Width = 75.590551180000000000
          Height = 15.118110240000000000
          DataField = 'NOVEMBRO'
          DataSet = frxDBSaldos
          DataSetName = 'SALDOS'
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Tahoma'
          Font.Style = []
          Frame.Typ = []
          HAlign = haRight
          Memo.UTF8W = (
            '[SALDOS."NOVEMBRO"]')
          ParentFont = False
        end
        object Memo34: TfrxMemoView
          AllowVectorExport = True
          Left = 910.236860000000000000
          Width = 75.590551180000000000
          Height = 15.118110240000000000
          DataField = 'DEZEMBRO'
          DataSet = frxDBSaldos
          DataSetName = 'SALDOS'
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Tahoma'
          Font.Style = []
          Frame.Typ = []
          HAlign = haRight
          Memo.UTF8W = (
            '[SALDOS."DEZEMBRO"]')
          ParentFont = False
        end
      end
      object GroupFooter1: TfrxGroupFooter
        FillType = ftBrush
        Frame.Typ = []
        Height = 41.574830000000000000
        Top = 291.023810000000000000
        Width = 1046.929810000000000000
        object Line3: TfrxLineView
          AllowVectorExport = True
          Top = 16.000000000000000000
          Width = 1046.929810000000000000
          Color = clBlack
          Frame.Typ = [ftTop]
        end
        object Memo35: TfrxMemoView
          AllowVectorExport = True
          Left = 50.913420000000000000
          Top = 19.000000000000000000
          Width = 75.590551180000000000
          Height = 15.118110240000000000
          DataSet = frxDBSaldos
          DataSetName = 'SALDOS'
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Tahoma'
          Font.Style = []
          Frame.Typ = []
          HAlign = haRight
          Memo.UTF8W = (
            '[SUM(<SALDOS."JANEIRO">,SALDOS)]')
          ParentFont = False
        end
        object Memo37: TfrxMemoView
          AllowVectorExport = True
          Top = 19.000000000000000000
          Width = 49.133890000000000000
          Height = 15.118110240000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Tahoma'
          Font.Style = [fsBold]
          Frame.Typ = []
          Memo.UTF8W = (
            'TOTAIS ')
          ParentFont = False
        end
        object Memo38: TfrxMemoView
          AllowVectorExport = True
          Left = 128.842610000000000000
          Top = 19.000000000000000000
          Width = 75.590551180000000000
          Height = 15.118110240000000000
          DataSet = frxDBSaldos
          DataSetName = 'SALDOS'
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Tahoma'
          Font.Style = []
          Frame.Typ = []
          HAlign = haRight
          Memo.UTF8W = (
            '[SUM(<SALDOS."FEVEREIRO">,SALDOS)]')
          ParentFont = False
        end
        object Memo39: TfrxMemoView
          AllowVectorExport = True
          Left = 206.992270000000000000
          Top = 19.000000000000000000
          Width = 75.590551180000000000
          Height = 15.118110240000000000
          DataSet = frxDBSaldos
          DataSetName = 'SALDOS'
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Tahoma'
          Font.Style = []
          Frame.Typ = []
          HAlign = haRight
          Memo.UTF8W = (
            '[SUM(<SALDOS."MARCO">,SALDOS)]')
          ParentFont = False
        end
        object Memo40: TfrxMemoView
          AllowVectorExport = True
          Left = 284.921460000000000000
          Top = 19.000000000000000000
          Width = 75.590551180000000000
          Height = 15.118110240000000000
          DataSet = frxDBSaldos
          DataSetName = 'SALDOS'
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Tahoma'
          Font.Style = []
          Frame.Typ = []
          HAlign = haRight
          Memo.UTF8W = (
            '[SUM(<SALDOS."ABRIL">,SALDOS)]')
          ParentFont = False
        end
        object Memo42: TfrxMemoView
          AllowVectorExport = True
          Left = 363.071120000000000000
          Top = 19.000000000000000000
          Width = 75.590551180000000000
          Height = 15.118110240000000000
          DataSet = frxDBSaldos
          DataSetName = 'SALDOS'
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Tahoma'
          Font.Style = []
          Frame.Typ = []
          HAlign = haRight
          Memo.UTF8W = (
            '[SUM(<SALDOS."MAIO">,SALDOS)]')
          ParentFont = False
        end
        object Memo43: TfrxMemoView
          AllowVectorExport = True
          Left = 441.000310000000000000
          Top = 19.000000000000000000
          Width = 75.590551180000000000
          Height = 15.118110240000000000
          DataSet = frxDBSaldos
          DataSetName = 'SALDOS'
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Tahoma'
          Font.Style = []
          Frame.Typ = []
          HAlign = haRight
          Memo.UTF8W = (
            '[SUM(<SALDOS."JUNHO">,SALDOS)]')
          ParentFont = False
        end
        object Memo44: TfrxMemoView
          AllowVectorExport = True
          Left = 519.149970000000000000
          Top = 19.000000000000000000
          Width = 75.590551180000000000
          Height = 15.118110240000000000
          DataSet = frxDBSaldos
          DataSetName = 'SALDOS'
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Tahoma'
          Font.Style = []
          Frame.Typ = []
          HAlign = haRight
          Memo.UTF8W = (
            '[SUM(<SALDOS."JULHO">,SALDOS)]')
          ParentFont = False
        end
        object Memo45: TfrxMemoView
          AllowVectorExport = True
          Left = 597.079160000000000000
          Top = 19.000000000000000000
          Width = 75.590551180000000000
          Height = 15.118110240000000000
          DataSet = frxDBSaldos
          DataSetName = 'SALDOS'
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Tahoma'
          Font.Style = []
          Frame.Typ = []
          HAlign = haRight
          Memo.UTF8W = (
            '[SUM(<SALDOS."AGOSTO">,SALDOS)]')
          ParentFont = False
        end
        object Memo46: TfrxMemoView
          AllowVectorExport = True
          Left = 675.228820000000000000
          Top = 19.000000000000000000
          Width = 75.590551180000000000
          Height = 15.118110240000000000
          DataSet = frxDBSaldos
          DataSetName = 'SALDOS'
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Tahoma'
          Font.Style = []
          Frame.Typ = []
          HAlign = haRight
          Memo.UTF8W = (
            '[SUM(<SALDOS."SETEMBRO">,SALDOS)]')
          ParentFont = False
        end
        object Memo47: TfrxMemoView
          AllowVectorExport = True
          Left = 754.158010000000000000
          Top = 19.000000000000000000
          Width = 75.590551180000000000
          Height = 15.118110240000000000
          DataSet = frxDBSaldos
          DataSetName = 'SALDOS'
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Tahoma'
          Font.Style = []
          Frame.Typ = []
          HAlign = haRight
          Memo.UTF8W = (
            '[SUM(<SALDOS."OUTUBRO">,SALDOS)]')
          ParentFont = False
        end
        object Memo48: TfrxMemoView
          AllowVectorExport = True
          Left = 831.307670000000000000
          Top = 19.000000000000000000
          Width = 75.590551180000000000
          Height = 15.118110240000000000
          DataSet = frxDBSaldos
          DataSetName = 'SALDOS'
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Tahoma'
          Font.Style = []
          Frame.Typ = []
          HAlign = haRight
          Memo.UTF8W = (
            '[SUM(<SALDOS."NOVEMBRO">,SALDOS)]')
          ParentFont = False
        end
        object Memo49: TfrxMemoView
          AllowVectorExport = True
          Left = 910.236860000000000000
          Top = 19.000000000000000000
          Width = 75.590551180000000000
          Height = 15.118110240000000000
          DataSet = frxDBSaldos
          DataSetName = 'SALDOS'
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Tahoma'
          Font.Style = []
          Frame.Typ = []
          HAlign = haRight
          Memo.UTF8W = (
            '[SUM(<SALDOS."DEZEMBRO">,SALDOS)]')
          ParentFont = False
        end
        object Line4: TfrxLineView
          Align = baWidth
          AllowVectorExport = True
          Top = 3.779530000000022000
          Width = 1046.929810000000000000
          Color = clBlack
          Frame.Typ = [ftTop]
        end
      end
      object ReportSummary1: TfrxReportSummary
        FillType = ftBrush
        Frame.Typ = []
        Height = 22.677180000000000000
        Top = 393.071120000000000000
        Width = 1046.929810000000000000
      end
    end
  end
  object frxDBSaldos: TfrxDBDataset
    UserName = 'SALDOS'
    CloseDataSource = False
    FieldAliases.Strings = (
      'ID_CONTA_BANCARIA=ID_CONTA_BANCARIA'
      'CONTA=CONTA'
      'TITULAR=TITULAR'
      'ANO=ANO'
      'JANEIRO=JANEIRO'
      'FEVEREIRO=FEVEREIRO'
      'MARCO=MARCO'
      'ABRIL=ABRIL'
      'MAIO=MAIO'
      'JUNHO=JUNHO'
      'JULHO=JULHO'
      'AGOSTO=AGOSTO'
      'SETEMBRO=SETEMBRO'
      'OUTUBRO=OUTUBRO'
      'NOVEMBRO=NOVEMBRO'
      'DEZEMBRO=DEZEMBRO')
    DataSet = qrySaldosBancarios
    BCDToCurrency = False
    Left = 872
    Top = 40
  end
  object frxpdfxprt1: TfrxPDFExport
    UseFileCache = True
    ShowProgress = True
    OverwritePrompt = False
    DataOnly = False
    OpenAfterExport = False
    PrintOptimized = False
    Outline = False
    Background = False
    HTMLTags = True
    Quality = 95
    Transparency = False
    Author = 'FastReport'
    Subject = 'FastReport PDF export'
    ProtectionFlags = [ePrint, eModify, eCopy, eAnnot]
    HideToolbar = False
    HideMenubar = False
    HideWindowUI = False
    FitWindow = False
    CenterWindow = False
    PrintScaling = False
    PdfA = False
    PDFStandard = psNone
    PDFVersion = pv17
    Left = 936
    Top = 40
  end
  object frxCSVExport1: TfrxCSVExport
    UseFileCache = True
    ShowProgress = True
    OverwritePrompt = False
    DataOnly = False
    Separator = ';'
    OEMCodepage = False
    UTF8 = False
    OpenAfterExport = False
    NoSysSymbols = True
    ForcedQuotes = False
    Left = 1000
    Top = 40
  end
  object qrySaldoDebito: TFDQuery
    Connection = dmConexao.conn
    FetchOptions.AssignedValues = [evRowsetSize]
    FetchOptions.RowsetSize = 500
    FormatOptions.AssignedValues = [fvFmtDisplayDate, fvFmtDisplayNumeric, fvFmtEditNumeric]
    FormatOptions.FmtDisplayDate = 'DD/MM/YYYY'
    FormatOptions.FmtDisplayNumeric = '###,##0.00'
    FormatOptions.FmtEditNumeric = '###,##0.00'
    SQL.Strings = (
      'select sum(CBD.valor) as SALDO,'
      '       max(cb.conta) as conta_banco,'
      '       max(cb.titular) as titular,'
      '       max(cc.conta) as conta_contbil,'
      '       max(cc.descricao) as dsc_cc'
      ''
      'FROM  conta_bancaria_debito CBD'
      
        'left outer join conta_bancaria cb on (cb.id_conta_bancaria = cbD' +
        '.id_conta_bancaria) and (CB.ID_ORGANIZACAO = CBD.ID_ORGANIZACAO)'
      
        'left outer join conta_contabil cc on (cc.id_conta_contabil = cb.' +
        'id_conta_contabil) and (CC.ID_ORGANIZACAO = CBD.ID_ORGANIZACAO)'
      ''
      ''
      ''
      'WHERE (CBD.ID_ORGANIZACAO = :PIDORGANIZACAO) AND'
      
        '      (CBD.DATA_MOVIMENTO BETWEEN :DTDATAINICIAL AND :DTDATAFINA' +
        'L) AND'
      '      (CBD.ID_CONTA_BANCARIA = :PIDCONTA)'
      ''
      '')
    Left = 792
    Top = 528
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
      end
      item
        Name = 'PIDCONTA'
        DataType = ftString
        ParamType = ptInput
        Size = 36
      end>
  end
  object qrySaldoCredito: TFDQuery
    Connection = dmConexao.conn
    FetchOptions.AssignedValues = [evRowsetSize]
    FetchOptions.RowsetSize = 500
    FormatOptions.AssignedValues = [fvFmtDisplayDate, fvFmtDisplayNumeric, fvFmtEditNumeric]
    FormatOptions.FmtDisplayDate = 'DD/MM/YYYY'
    FormatOptions.FmtDisplayNumeric = '###,##0.00'
    FormatOptions.FmtEditNumeric = '###,##0.00'
    SQL.Strings = (
      'select sum(cbc.valor) as SALDO,'
      '       max(cb.conta) as conta_banco,'
      '       max(cb.titular) as titular,'
      '       max(cc.conta) as conta_contbil,'
      '       max(cc.descricao) as dsc_cc'
      ''
      'FROM  conta_bancaria_credito cbc'
      
        'left outer join conta_bancaria cb on (cb.id_conta_bancaria = cbc' +
        '.id_conta_bancaria)'
      
        'left outer join conta_contabil cc on (cc.id_conta_contabil = cb.' +
        'id_conta_contabil)'
      ''
      'WHERE (CBC.ID_ORGANIZACAO = :PIDORGANIZACAO) AND'
      
        '      (CBC.DATA_MOVIMENTO BETWEEN :DTDATAINICIAL AND :DTDATAFINA' +
        'L) AND'
      '      (CBC.ID_CONTA_BANCARIA = :PIDCONTA)'
      ''
      ''
      '')
    Left = 680
    Top = 528
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
      end
      item
        Name = 'PIDCONTA'
        DataType = ftString
        ParamType = ptInput
        Size = 36
      end>
  end
end