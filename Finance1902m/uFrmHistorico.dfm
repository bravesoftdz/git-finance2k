object frmHistorico: TfrmHistorico
  Left = 0
  Top = 0
  Caption = 'Lintagem de hist'#243'ricos'
  ClientHeight = 594
  ClientWidth = 854
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
  object dbgrd1: TDBGrid
    Left = 0
    Top = 125
    Width = 854
    Height = 449
    Align = alClient
    DataSource = ds1
    Options = [dgTitles, dgIndicator, dgColLines, dgRowLines, dgTabs, dgRowSelect, dgConfirmDelete, dgCancelOnExit, dgTitleClick, dgTitleHotTrack]
    ReadOnly = True
    TabOrder = 0
    TitleFont.Charset = DEFAULT_CHARSET
    TitleFont.Color = clWindowText
    TitleFont.Height = -11
    TitleFont.Name = 'Tahoma'
    TitleFont.Style = []
    Columns = <
      item
        Expanded = False
        FieldName = 'CODIGO'
        Title.Alignment = taCenter
        Title.Font.Charset = DEFAULT_CHARSET
        Title.Font.Color = clWindowText
        Title.Font.Height = -11
        Title.Font.Name = 'Tahoma'
        Title.Font.Style = [fsBold]
        Width = 100
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'DESCRICAO_HISTORICO'
        Title.Alignment = taCenter
        Title.Caption = 'HIST'#211'RICO'
        Title.Font.Charset = DEFAULT_CHARSET
        Title.Font.Color = clWindowText
        Title.Font.Height = -11
        Title.Font.Name = 'Tahoma'
        Title.Font.Style = [fsBold]
        Width = 240
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'TIPO'
        Title.Alignment = taCenter
        Title.Font.Charset = DEFAULT_CHARSET
        Title.Font.Color = clWindowText
        Title.Font.Height = -11
        Title.Font.Name = 'Tahoma'
        Title.Font.Style = [fsBold]
        Width = 50
        Visible = True
      end
      item
        Alignment = taRightJustify
        Expanded = False
        FieldName = 'CONTA'
        Title.Alignment = taCenter
        Title.Font.Charset = DEFAULT_CHARSET
        Title.Font.Color = clWindowText
        Title.Font.Height = -11
        Title.Font.Name = 'Tahoma'
        Title.Font.Style = [fsBold]
        Width = 120
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'DESCRICAO_CONTA'
        Title.Alignment = taCenter
        Title.Caption = 'CONTA CONT'#193'BIL'
        Title.Font.Charset = DEFAULT_CHARSET
        Title.Font.Color = clWindowText
        Title.Font.Height = -11
        Title.Font.Name = 'Tahoma'
        Title.Font.Style = [fsBold]
        Width = 200
        Visible = True
      end
      item
        Alignment = taRightJustify
        Expanded = False
        FieldName = 'CODIGO_REDUZ'
        Title.Alignment = taCenter
        Title.Caption = 'C'#211'D. REDUZ'
        Title.Font.Charset = DEFAULT_CHARSET
        Title.Font.Color = clWindowText
        Title.Font.Height = -11
        Title.Font.Name = 'Tahoma'
        Title.Font.Style = [fsBold]
        Width = 100
        Visible = True
      end>
  end
  object rgTipos: TRadioGroup
    Left = 344
    Top = 51
    Width = 463
    Height = 46
    Caption = 'Tipos'
    ItemIndex = 0
    Items.Strings = (
      'Nenhum'
      'Centro de Custo'
      'Opera'#231#227'o banc'#225'ria'
      'Todos')
    TabOrder = 1
  end
  object dxStatusBar: TdxStatusBar
    Left = 0
    Top = 574
    Width = 854
    Height = 20
    Panels = <
      item
        PanelStyleClassName = 'TdxStatusBarTextPanelStyle'
        Width = 100
      end
      item
        PanelStyleClassName = 'TdxStatusBarTextPanelStyle'
        Width = 200
      end
      item
        PanelStyleClassName = 'TdxStatusBarTextPanelStyle'
        Width = 100
      end
      item
        PanelStyleClassName = 'TdxStatusBarTextPanelStyle'
        Width = 200
      end>
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'Tahoma'
    Font.Style = []
  end
  object dxRibbon1: TdxRibbon
    Left = 0
    Top = 0
    Width = 854
    Height = 125
    BarManager = dxBarManager1
    ColorSchemeName = 'UserSkin'
    Contexts = <>
    TabOrder = 3
    TabStop = False
    object dxRibbon1Tab1: TdxRibbonTab
      Active = True
      Caption = 'Lista Hist'#243'ricos'
      Groups = <
        item
          ToolbarName = 'dxBarManager1Bar1'
        end
        item
          ToolbarName = 'dxBarManager1Bar2'
        end>
      Index = 0
    end
  end
  object qryObterHistoricos: TFDQuery
    Connection = dmConexao.conn
    SQL.Strings = (
      'SELECT H.ID_HISTORICO,'
      '       H.ID_ORGANIZACAO,'
      '       H.DESCRICAO AS DESCRICAO_HISTORICO,'
      '       H.TIPO, '
      '       H.CODIGO,'
      '       H.DESCRICAO_REDUZIDA, '
      '       CC.CONTA, '
      '       CC.DESCRICAO AS DESCRICAO_CONTA, '
      '       CC.CODREDUZ AS CODIGO_REDUZ'
      ''
      'FROM HISTORICO H'
      
        'LEFT OUTER JOIN CONTA_CONTABIL CC ON (CC.ID_CONTA_CONTABIL = H.I' +
        'D_CONTA_CONTABIL) AND (CC.ID_ORGANIZACAO = H.ID_ORGANIZACAO) '
      ''
      'WHERE (H.ID_ORGANIZACAO = :PIDORGANIZACAO) '
      ''
      'ORDER BY H.CODIGO DESC'
      ''
      '')
    Left = 16
    Top = 434
    ParamData = <
      item
        Name = 'PIDORGANIZACAO'
        DataType = ftString
        ParamType = ptInput
        Size = 36
      end>
  end
  object ds1: TDataSource
    DataSet = qryObterHistoricos
    Left = 320
    Top = 312
  end
  object frxRepHistorico: TfrxReport
    Version = '6.3.7'
    DotMatrixReport = False
    IniFile = '\Software\Fast Reports'
    PreviewOptions.Buttons = [pbPrint, pbLoad, pbSave, pbExport, pbZoom, pbFind, pbOutline, pbPageSetup, pbTools, pbEdit, pbNavigator, pbExportQuick, pbCopy, pbSelection]
    PreviewOptions.Zoom = 1.000000000000000000
    PrintOptions.Printer = 'Padr'#227'o'
    PrintOptions.PrintOnSheet = 0
    ReportOptions.CreateDate = 43784.577237638900000000
    ReportOptions.LastChange = 43791.515224421300000000
    ScriptLanguage = 'PascalScript'
    StoreInDFM = False
    Left = 144
    Top = 434
  end
  object frxDBHistorico: TfrxDBDataset
    UserName = 'Historico'
    CloseDataSource = False
    FieldAliases.Strings = (
      'ID_HISTORICO=ID_HISTORICO'
      'ID_ORGANIZACAO=ID_ORGANIZACAO'
      'DESCRICAO_HISTORICO=DESCRICAO_HISTORICO'
      'TIPO=TIPO'
      'CODIGO=CODIGO'
      'DESCRICAO_REDUZIDA=DESCRICAO_REDUZIDA'
      'CONTA=CONTA'
      'DESCRICAO_CONTA=DESCRICAO_CONTA'
      'CODIGO_REDUZ=CODIGO_REDUZ')
    DataSet = qryObterHistoricos
    BCDToCurrency = False
    Left = 272
    Top = 434
  end
  object qryObterCC: TFDQuery
    Connection = dmConexao.conn
    SQL.Strings = (
      'SELECT CC.ID_CENTRO_CUSTO,'
      '       CC.DESCRICAO,'
      '       CC.CODIGO,'
      '       CC.SIGLA'
      ''
      'FROM CENTRO_CUSTO CC'
      ''
      'WHERE (CC.ID_ORGANIZACAO = :PIDORGANIZACAO) '
      ''
      'ORDER BY CC.DESCRICAO'
      ''
      '')
    Left = 400
    Top = 434
    ParamData = <
      item
        Name = 'PIDORGANIZACAO'
        DataType = ftString
        ParamType = ptInput
        Size = 36
      end>
  end
  object frxDBCC: TfrxDBDataset
    UserName = 'CENTRO_CUSTO'
    CloseDataSource = False
    FieldAliases.Strings = (
      'ID_CENTRO_CUSTO=ID_CENTRO_CUSTO'
      'DESCRICAO=DESCRICAO'
      'CODIGO=CODIGO'
      'SIGLA=SIGLA')
    DataSet = qryObterCC
    BCDToCurrency = False
    Left = 528
    Top = 434
  end
  object qryObterTOB: TFDQuery
    Connection = dmConexao.conn
    SQL.Strings = (
      'SELECT TOB.id_tipo_operacao_bancaria,'
      '       TOB.id_organizacao,'
      '       TOB.descricao,'
      '       TOB.tipo,'
      '       TOB.codigo,'
      '       TOB.id_conta_contabil,'
      '       CC.conta,'
      '       CC.descricao AS DSC_CONTA,'
      '       CC.codreduz'
      ''
      'FROM TIPO_OPERACAO_BANCARIA TOB'
      
        'LEFT OUTER JOIN conta_contabil CC ON (CC.id_conta_contabil = TOB' +
        '.id_conta_contabil) AND (CC.id_organizacao = TOB.id_organizacao)'
      ''
      'WHERE (TOB.ID_ORGANIZACAO = :PIDORGANIZACAO)'
      ''
      'ORDER BY TOB.DESCRICAO')
    Left = 656
    Top = 434
    ParamData = <
      item
        Name = 'PIDORGANIZACAO'
        DataType = ftString
        ParamType = ptInput
        Size = 36
      end>
  end
  object frxTOB: TfrxDBDataset
    UserName = 'TOB'
    CloseDataSource = False
    FieldAliases.Strings = (
      'ID_TIPO_OPERACAO_BANCARIA=ID_TIPO_OPERACAO_BANCARIA'
      'ID_ORGANIZACAO=ID_ORGANIZACAO'
      'DESCRICAO=DESCRICAO'
      'TIPO=TIPO'
      'CODIGO=CODIGO'
      'ID_CONTA_CONTABIL=ID_CONTA_CONTABIL'
      'CONTA=CONTA'
      'DSC_CONTA=DSC_CONTA'
      'CODREDUZ=CODREDUZ')
    DataSet = qryObterTOB
    BCDToCurrency = False
    Left = 784
    Top = 434
  end
  object dxBarManager1: TdxBarManager
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -12
    Font.Name = 'Segoe UI'
    Font.Style = []
    Categories.Strings = (
      'Default')
    Categories.ItemsVisibles = (
      2)
    Categories.Visibles = (
      True)
    PopupMenuLinks = <>
    UseSystemFont = True
    Left = 296
    Top = 64
    PixelsPerInch = 96
    object dxBarManager1Bar1: TdxBar
      Caption = 'Imprimir'
      CaptionButtons = <>
      DockedLeft = 0
      DockedTop = 0
      FloatLeft = 880
      FloatTop = 8
      FloatClientWidth = 0
      FloatClientHeight = 0
      ItemLinks = <
        item
          Visible = True
          ItemName = 'dxBarBtnImprimir'
        end>
      OneOnRow = False
      Row = 0
      UseOwnFont = False
      Visible = True
      WholeRow = False
    end
    object dxBarManager1Bar2: TdxBar
      Caption = 'Fechar'
      CaptionButtons = <>
      DockedLeft = 71
      DockedTop = 0
      FloatLeft = 880
      FloatTop = 8
      FloatClientWidth = 0
      FloatClientHeight = 0
      ItemLinks = <
        item
          Visible = True
          ItemName = 'dxBarBtnFechar'
        end>
      OneOnRow = False
      Row = 0
      UseOwnFont = False
      Visible = True
      WholeRow = False
    end
    object dxBarBtnFechar: TdxBarLargeButton
      Caption = 'Fechar'
      Category = 0
      Hint = 'Fechar'
      Visible = ivAlways
      OnClick = dxBarBtnFecharClick
    end
    object dxBarBtnImprimir: TdxBarLargeButton
      Caption = 'Imprimir'
      Category = 0
      Hint = 'Imprimir'
      Visible = ivAlways
      OnClick = dxBarBtnImprimirClick
    end
  end
end
