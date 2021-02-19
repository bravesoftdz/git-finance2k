object frmPagamentoTitulos: TfrmPagamentoTitulos
  Left = 0
  Top = 0
  Caption = 'Pagamento de Titulos'
  ClientHeight = 604
  ClientWidth = 1092
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  KeyPreview = True
  OldCreateOrder = False
  Position = poDesktopCenter
  OnClose = FormClose
  OnCreate = FormCreate
  OnKeyDown = FormKeyDown
  PixelsPerInch = 96
  TextHeight = 13
  object dxRibbon1: TdxRibbon
    Left = 0
    Top = 0
    Width = 1092
    Height = 125
    BarManager = dxBarManager1
    ColorSchemeName = 'UserSkin'
    Contexts = <>
    TabOrder = 0
    TabStop = False
    object menuBaixaTP: TdxRibbonTab
      Active = True
      Caption = 'Baixa de t'#237'tulos a pagar'
      Groups = <
        item
          ToolbarName = 'dxBarManager1Bar1'
        end
        item
          ToolbarName = 'dxBarManager1Bar4'
        end
        item
          ToolbarName = 'dxBarManager1Bar2'
        end
        item
          ToolbarName = 'dxBarManager1Bar3'
        end>
      Index = 0
    end
  end
  object dxStatusBar: TdxStatusBar
    Left = 0
    Top = 584
    Width = 1092
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
  object dbgrdMain: TDBGrid
    Left = 0
    Top = 125
    Width = 1092
    Height = 459
    Align = alClient
    DataSource = dsTitulos
    Options = [dgTitles, dgIndicator, dgColumnResize, dgColLines, dgRowLines, dgTabs, dgRowSelect, dgConfirmDelete, dgCancelOnExit, dgTitleClick, dgTitleHotTrack]
    TabOrder = 2
    TitleFont.Charset = DEFAULT_CHARSET
    TitleFont.Color = clWindowText
    TitleFont.Height = -11
    TitleFont.Name = 'Tahoma'
    TitleFont.Style = []
    OnTitleClick = dbgrdMainTitleClick
    Columns = <
      item
        Alignment = taRightJustify
        Expanded = False
        FieldName = 'DATA_VENCIMENTO'
        Title.Alignment = taCenter
        Title.Caption = 'VENCIMENTO'
        Title.Font.Charset = DEFAULT_CHARSET
        Title.Font.Color = clWindowText
        Title.Font.Height = -11
        Title.Font.Name = 'Tahoma'
        Title.Font.Style = [fsBold]
        Width = 80
        Visible = True
      end
      item
        Alignment = taRightJustify
        Expanded = False
        FieldName = 'DOC'
        Title.Alignment = taCenter
        Title.Caption = 'DOCUMENTO'
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
        FieldName = 'FORNECEDOR'
        Title.Alignment = taCenter
        Title.Font.Charset = DEFAULT_CHARSET
        Title.Font.Color = clWindowText
        Title.Font.Height = -11
        Title.Font.Name = 'Tahoma'
        Title.Font.Style = [fsBold]
        Width = 220
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'VALOR_NOMINAL'
        Title.Alignment = taCenter
        Title.Caption = 'VALOR'
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
        FieldName = 'DSC_HIST'
        Title.Alignment = taCenter
        Title.Caption = 'HIST'#211'RICO'
        Title.Font.Charset = DEFAULT_CHARSET
        Title.Font.Color = clWindowText
        Title.Font.Height = -11
        Title.Font.Name = 'Tahoma'
        Title.Font.Style = [fsBold]
        Width = 210
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'DESCRICAO'
        Title.Alignment = taCenter
        Title.Caption = 'DESCRI'#199#195'O'
        Title.Font.Charset = DEFAULT_CHARSET
        Title.Font.Color = clWindowText
        Title.Font.Height = -11
        Title.Font.Name = 'Tahoma'
        Title.Font.Style = [fsBold]
        Width = 230
        Visible = True
      end
      item
        Alignment = taCenter
        Expanded = False
        FieldName = 'PARCELA'
        Title.Font.Charset = DEFAULT_CHARSET
        Title.Font.Color = clWindowText
        Title.Font.Height = -11
        Title.Font.Name = 'Tahoma'
        Title.Font.Style = [fsBold]
        Width = 80
        Visible = True
      end>
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
    Left = 824
    Top = 64
    PixelsPerInch = 96
    object dxBarManager1Bar1: TdxBar
      Caption = 'Pesquisar'
      CaptionButtons = <>
      DockedLeft = 0
      DockedTop = 0
      FloatLeft = 928
      FloatTop = 8
      FloatClientWidth = 0
      FloatClientHeight = 0
      ItemLinks = <
        item
          Visible = True
          ItemName = 'cxbrdtmPesquisa'
        end
        item
          Visible = True
          ItemName = 'cxBarPesquisaCedente'
        end>
      OneOnRow = False
      Row = 0
      UseOwnFont = False
      Visible = True
      WholeRow = False
    end
    object dxBarManager1Bar2: TdxBar
      Caption = 'Pagar t'#237'tulos'
      CaptionButtons = <>
      DockedLeft = 425
      DockedTop = 0
      FloatLeft = 928
      FloatTop = 8
      FloatClientWidth = 0
      FloatClientHeight = 0
      ItemLinks = <
        item
          Visible = True
          ItemName = 'dxBtnPagar'
        end>
      OneOnRow = False
      Row = 0
      UseOwnFont = False
      Visible = True
      WholeRow = False
    end
    object dxBarManager1Bar3: TdxBar
      Caption = 'Sair'
      CaptionButtons = <>
      DockedLeft = 500
      DockedTop = 0
      FloatLeft = 928
      FloatTop = 8
      FloatClientWidth = 0
      FloatClientHeight = 0
      ItemLinks = <
        item
          Visible = True
          ItemName = 'dxBtnFechar'
        end>
      OneOnRow = False
      Row = 0
      UseOwnFont = False
      Visible = True
      WholeRow = False
    end
    object dxBarManager1Bar4: TdxBar
      Caption = 'Per'#237'odo'
      CaptionButtons = <>
      DockedLeft = 200
      DockedTop = 0
      FloatLeft = 1042
      FloatTop = 8
      FloatClientWidth = 0
      FloatClientHeight = 0
      ItemLinks = <
        item
          Visible = True
          ItemName = 'dtInicial'
        end
        item
          Visible = True
          ItemName = 'dtFinal'
        end
        item
          Position = ipBeginsNewColumn
          Visible = True
          ItemName = 'dxBtnConsulta'
        end>
      OneOnRow = False
      Row = 0
      UseOwnFont = False
      Visible = True
      WholeRow = False
    end
    object cxbrdtmPesquisa: TcxBarEditItem
      Align = iaRight
      Caption = 'Documento'
      Category = 0
      Hint = 'Documento'
      Visible = ivAlways
      OnCurChange = cxbrdtmPesquisaCurChange
      Width = 120
      PropertiesClassName = 'TcxTextEditProperties'
    end
    object dxBtnFechar: TdxBarLargeButton
      Caption = 'Fechar'
      Category = 0
      Hint = 'Fechar'
      Visible = ivAlways
      OnClick = dxBtnFecharClick
    end
    object dxBtnPagar: TdxBarLargeButton
      Caption = 'Baixa'
      Category = 0
      Hint = 'Baixa de t'#237'tulos'
      Visible = ivAlways
      OnClick = dxBtnPagarClick
    end
    object dxBtnPagarAV: TdxBarLargeButton
      Caption = 'Baixa Avan'#231'ada'
      Category = 0
      Hint = 'Baixa de t'#237'tulos avan'#231'ada'
      Visible = ivAlways
      OnClick = dxBtnPagarAVClick
    end
    object cxBarPesquisaCedente: TcxBarEditItem
      Align = iaRight
      Caption = 'Fornecedor'
      Category = 0
      Hint = 'Fornecedor'
      Visible = ivAlways
      OnCurChange = cxBarPesquisaCedenteCurChange
      Width = 120
    end
    object dxBtnConsulta: TdxBarButton
      Caption = 'Consultar'
      Category = 0
      Hint = 'Consultar'
      Visible = ivAlways
      OnClick = dxBtnConsultaClick
    end
    object dtInicial: TcxBarEditItem
      Align = iaRight
      Caption = 'Inicial'
      Category = 0
      Hint = 'Inicial'
      Visible = ivAlways
      Width = 120
      PropertiesClassName = 'TcxDateEditProperties'
    end
    object dtFinal: TcxBarEditItem
      Align = iaRight
      Caption = 'Final'
      Category = 0
      Hint = 'Final'
      Visible = ivAlways
      Width = 120
      PropertiesClassName = 'TcxDateEditProperties'
    end
  end
  object dsTitulos: TDataSource
    DataSet = qryPreencheGrid
    OnDataChange = dsTitulosDataChange
    Left = 408
    Top = 240
  end
  object qryPreencheGrid: TFDQuery
    Connection = dmConexao.conn
    FormatOptions.AssignedValues = [fvFmtDisplayDate, fvFmtDisplayNumeric, fvFmtEditNumeric]
    FormatOptions.FmtDisplayDate = 'DD/MM/YYYY'
    FormatOptions.FmtDisplayNumeric = '###,##0.00'
    FormatOptions.FmtEditNumeric = '###,##0.00'
    SQL.Strings = (
      '  SELECT TP.ID_TITULO_PAGAR AS ID, '
      '         TP.NUMERO_DOCUMENTO AS DOC,       '
      '         TP.ID_ORGANIZACAO,  '
      '         TP.DESCRICAO,'
      '         TP.VALOR_NOMINAL, '
      '         TP.ID_CEDENTE,'
      '         TP.DATA_EMISSAO,'
      '         TP.DATA_VENCIMENTO, '
      '         TP.PARCELA,'
      '         C.NOME AS FORNECEDOR, '
      '         H.DESCRICAO AS DSC_HIST'
      '         '
      '  FROM TITULO_PAGAR TP'
      
        '  LEFT OUTER JOIN CEDENTE C ON (C.id_cedente = TP.id_cedente) AN' +
        'D (C.id_organizacao = TP.id_organizacao)'
      
        '  LEFT OUTER JOIN HISTORICO H ON (H.id_historico =  TP.id_histor' +
        'ico) AND (H.id_organizacao = TP.id_organizacao)'
      ''
      ' '
      ''
      'WHERE (TP.ID_ORGANIZACAO = :PIDORGANIZACAO)'
      '       AND   (TP.ID_TIPO_STATUS = '#39'ABERTO'#39')'
      
        '       AND   (TP.DATA_VENCIMENTO between :DTDINICIAL and :DTFINA' +
        'L )'
      '       ORDER BY DATA_VENCIMENTO ASC'
      ' ')
    Left = 303
    Top = 240
    ParamData = <
      item
        Name = 'PIDORGANIZACAO'
        DataType = ftString
        ParamType = ptInput
        Size = 36
      end
      item
        Name = 'DTDINICIAL'
        DataType = ftDate
        ParamType = ptInput
      end
      item
        Name = 'DTFINAL'
        DataType = ftDate
        ParamType = ptInput
      end>
  end
  object qryVerificaBaixa: TFDQuery
    Connection = dmConexao.conn
    FormatOptions.AssignedValues = [fvFmtDisplayDate, fvFmtDisplayNumeric, fvFmtEditNumeric]
    FormatOptions.FmtDisplayDate = 'DD/MM/YYYY'
    FormatOptions.FmtDisplayNumeric = '###,##0.00'
    FormatOptions.FmtEditNumeric = '###,##0.00'
    SQL.Strings = (
      'SELECT FIRST 1'
      '        TP.NUMERO_DOCUMENTO,'
      '        TP.ID_TITULO_PAGAR,'
      '        TP.VALOR_NOMINAL as VALOR_TITULO,'
      '        TP.ID_TIPO_STATUS,'
      '        TP.DESCRICAO,'
      '        TP.DATA_PAGAMENTO,'
      '        TPB.VALOR_PAGO AS VALOR_BAIXA,'
      '        TPB.ID_TITULO_PAGAR_BAIXA,'
      '        TPBCH.ID_TITULO_PAGAR_BAIXA_CHEQUE,'
      '        TPBCH.VALOR AS VALOR_CHEQUE,'
      '        TPBCH.ID_CONTA_BANCARIA_CHEQUE,'
      '        CBCH.NUMERO_CHEQUE,'
      '        CBCH.PORTADOR,'
      '        CBCHEQUE.CONTA AS CHEQUE_CONTA,'
      '        CBCHEQUE.TITULAR AS CHEQUE_TITULAR,'
      '        CBD.ID_CONTA_BANCARIA_DEBITO,'
      '        CBD.VALOR AS VALOR_BANCO,'
      '        CBD.ID_TIPO_OPERACAO_BANCARIA AS TOPER,'
      '        CB.CONTA,'
      '        CB.TITULAR,'
      '        TD.ID_TESOURARIA_DEBITO,'
      '        TD.VALOR_NOMINAL AS VALOR_CAIXA,'
      '        TD.DESCRICAO AS LANC_CAIXA,'
      '        TD.NUMERO_DOCUMENTO AS DOCCAIXA'
      ''
      'FROM TITULO_PAGAR TP'
      
        'LEFT OUTER JOIN TITULO_PAGAR_BAIXA TPB ON (TPB.ID_TITULO_PAGAR =' +
        ' TP.ID_TITULO_PAGAR AND TPB.ID_ORGANIZACAO = TP.ID_ORGANIZACAO)'
      
        'LEFT OUTER JOIN TITULO_PAGAR_BAIXA_CHEQUE TPBCH ON (TPBCH.ID_TIT' +
        'ULO_PAGAR_BAIXA = TPB.ID_TITULO_PAGAR_BAIXA AND TPBCH.ID_ORGANIZ' +
        'ACAO = TP.ID_ORGANIZACAO)'
      
        'LEFT OUTER JOIN CONTA_BANCARIA_CHEQUE CBCH ON (CBCH.ID_CONTA_BAN' +
        'CARIA_CHEQUE =  TPBCH.ID_CONTA_BANCARIA_CHEQUE AND CBCH.ID_ORGAN' +
        'IZACAO = TP.ID_ORGANIZACAO)'
      
        'LEFT OUTER JOIN CONTA_BANCARIA CBCHEQUE ON (CBCHEQUE.ID_CONTA_BA' +
        'NCARIA = CBCH.ID_CONTA_BANCARIA AND CBCHEQUE.ID_ORGANIZACAO = TP' +
        '.ID_ORGANIZACAO)'
      
        'LEFT OUTER JOIN CONTA_BANCARIA_DEBITO CBD ON (CBD.ID_TITULO_PAGA' +
        'R  = TP.ID_TITULO_PAGAR AND CBD.ID_ORGANIZACAO = TP.ID_ORGANIZAC' +
        'AO)'
      
        'LEFT OUTER JOIN CONTA_BANCARIA CB ON (CB.ID_CONTA_BANCARIA = CBD' +
        '.ID_CONTA_BANCARIA AND CB.ID_ORGANIZACAO = TP.ID_ORGANIZACAO)'
      
        'LEFT OUTER JOIN TESOURARIA_DEBITO TD ON (TD.ID_TITULO_PAGAR_BAIX' +
        'A = TPB.ID_TITULO_PAGAR_BAIXA AND TD.ID_ORGANIZACAO = TP.ID_ORGA' +
        'NIZACAO)'
      ''
      ''
      'WHERE (TP.ID_ORGANIZACAO = :PIDORGANIZACAO)'
      'AND   (TP.ID_TITULO_PAGAR = :PID)')
    Left = 959
    Top = 56
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
  object PempecMsg: TEvMsgDlg
    ButtonFont.Charset = DEFAULT_CHARSET
    ButtonFont.Color = clWindowText
    ButtonFont.Height = -11
    ButtonFont.Name = 'Tahoma'
    ButtonFont.Style = []
    MessageFont.Charset = DEFAULT_CHARSET
    MessageFont.Color = clWindowText
    MessageFont.Height = -11
    MessageFont.Name = 'Tahoma'
    MessageFont.Style = []
    Left = 680
    Top = 56
  end
end