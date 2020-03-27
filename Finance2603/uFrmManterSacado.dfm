object frmManterSacado: TfrmManterSacado
  Left = 0
  Top = 0
  Caption = 'Detalhes'
  ClientHeight = 621
  ClientWidth = 841
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
    Width = 841
    Height = 125
    BarManager = dxBarManager1
    ColorSchemeName = 'UserSkin'
    Contexts = <>
    TabOrder = 1
    TabStop = False
    object dxRibbon1Tab1: TdxRibbonTab
      Active = True
      Caption = 'Manuten'#231#227'o de sacados'
      Groups = <
        item
          Caption = 'Novo'
          ToolbarName = 'dxBarManager1Bar2'
        end
        item
          ToolbarName = 'dxBarManager1Bar1'
        end
        item
          ToolbarName = 'dxBarSalvar'
        end
        item
          ToolbarName = 'dxBarManager1Bar4'
        end
        item
          ToolbarName = 'dxBarManager1Bar5'
        end
        item
          ToolbarName = 'dxBarManager1Bar6'
        end
        item
          ToolbarName = 'dxBarManager1Bar3'
        end>
      Index = 0
    end
  end
  object dxStatusBar: TdxStatusBar
    Left = 0
    Top = 601
    Width = 841
    Height = 20
    Panels = <
      item
        PanelStyleClassName = 'TdxStatusBarTextPanelStyle'
      end
      item
        PanelStyleClassName = 'TdxStatusBarTextPanelStyle'
      end>
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'Tahoma'
    Font.Style = []
  end
  object dbgrd1: TDBGrid
    Left = 19
    Top = 407
    Width = 805
    Height = 186
    DataSource = dsGridMain
    Options = [dgTitles, dgIndicator, dgColumnResize, dgColLines, dgRowLines, dgTabs, dgRowSelect, dgCancelOnExit, dgTitleClick, dgTitleHotTrack]
    TabOrder = 3
    TitleFont.Charset = DEFAULT_CHARSET
    TitleFont.Color = clWindowText
    TitleFont.Height = -11
    TitleFont.Name = 'Tahoma'
    TitleFont.Style = []
    OnTitleClick = dbgrd1TitleClick
    Columns = <
      item
        Expanded = False
        FieldName = 'NOME'
        Width = 300
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'TELEFONE'
        Width = 80
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'TIPO'
        Title.Alignment = taCenter
        Width = 150
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'CPFCNPJ'
        Width = 150
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'CODIGO'
        Title.Alignment = taCenter
        Title.Caption = 'C'#211'DIGO'
        Width = 80
        Visible = True
      end>
  end
  object cxpgcntrlPage: TcxPageControl
    Left = 0
    Top = 125
    Width = 841
    Height = 276
    Align = alTop
    TabOrder = 0
    Properties.ActivePage = tbTransfereSacado
    Properties.CustomButtons.Buttons = <>
    ClientRectBottom = 276
    ClientRectRight = 841
    ClientRectTop = 24
    object tbTransfereSacado: TcxTabSheet
      Caption = 'Sacado'
      ImageIndex = 0
      OnShow = tbTransfereSacadoShow
      object lbl1: TLabel
        Left = 551
        Top = 28
        Width = 57
        Height = 13
        Caption = 'Tipo sacado'
      end
      object lbl2: TLabel
        Left = 19
        Top = 28
        Width = 72
        Height = 13
        Caption = 'Sacado/Cliente'
      end
      object lblCPFCNPJ: TLabel
        Left = 19
        Top = 104
        Width = 19
        Height = 13
        Caption = 'CPF'
      end
      object lbl5: TLabel
        Left = 407
        Top = 28
        Width = 67
        Height = 13
        Caption = 'Personalidade'
      end
      object lbl3: TLabel
        Left = 240
        Top = 104
        Width = 68
        Height = 13
        Caption = 'Insc. Estadual'
      end
      object lbl11: TLabel
        Left = 153
        Top = 104
        Width = 33
        Height = 13
        Caption = 'C'#243'digo'
      end
      object lbl24: TLabel
        Left = 735
        Top = 28
        Width = 31
        Height = 13
        Caption = 'Status'
      end
      object lbl25: TLabel
        Left = 407
        Top = 104
        Width = 63
        Height = 13
        Caption = 'Data registro'
      end
      object edtCNPJCPF: TEdit
        Tag = 1
        Left = 19
        Top = 129
        Width = 127
        Height = 21
        Alignment = taRightJustify
        Color = 12891332
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'Tahoma'
        Font.Style = [fsBold]
        ParentFont = False
        TabOrder = 3
        OnExit = edtCNPJCPFExit
      end
      object edtNomeSacado: TEdit
        Tag = 1
        Left = 19
        Top = 55
        Width = 340
        Height = 21
        Color = 12891332
        TabOrder = 0
        Text = 'edtNomeSacado'
      end
      object cbbPersonalidade: TComboBox
        Tag = 1
        Left = 407
        Top = 55
        Width = 119
        Height = 21
        Color = 12891332
        TabOrder = 1
        Text = 'cbbPersonalidade'
        OnChange = cbbPersonalidadeChange
        Items.Strings = (
          '<<Selecione>>'
          'P F'
          'P J')
      end
      object edtInscEstadual: TEdit
        Left = 240
        Top = 129
        Width = 119
        Height = 21
        Color = 12891332
        TabOrder = 5
      end
      object edtCodigo: TEdit
        Left = 153
        Top = 129
        Width = 79
        Height = 21
        Color = 12891332
        TabOrder = 4
      end
      object edtStatus: TEdit
        Tag = 1
        Left = 735
        Top = 55
        Width = 79
        Height = 21
        Color = 12891332
        TabOrder = 2
      end
      object dtpRegistro: TDateTimePicker
        Left = 407
        Top = 129
        Width = 114
        Height = 21
        Date = 43821.494080520830000000
        Time = 43821.494080520830000000
        TabOrder = 6
      end
      inline frmTipoSacado1: TfrmTipoSacado
        Left = 539
        Top = 54
        Width = 185
        Height = 36
        TabOrder = 7
        ExplicitLeft = 539
        ExplicitTop = 54
        ExplicitWidth = 185
        ExplicitHeight = 36
        inherited cbbcombo: TComboBox
          Tag = 1
          Left = 7
          Width = 168
          OnChange = frmTipoSacado1cbbcomboChange
          ExplicitLeft = 7
          ExplicitWidth = 168
        end
      end
    end
    object tbTransfereEndereco: TcxTabSheet
      Caption = 'Endere'#231'o'
      ImageIndex = 1
      OnExit = tbTransfereEnderecoExit
      OnShow = tbTransfereEnderecoShow
      object lbl13: TLabel
        Left = 19
        Top = 146
        Width = 33
        Height = 13
        Caption = 'Estado'
      end
      object lbl14: TLabel
        Left = 228
        Top = 146
        Width = 33
        Height = 13
        Caption = 'Cidade'
      end
      object lbl15: TLabel
        Left = 485
        Top = 146
        Width = 28
        Height = 13
        Caption = 'Bairro'
      end
      object lbl16: TLabel
        Left = 485
        Top = 86
        Width = 19
        Height = 13
        Caption = 'CEP'
      end
      object lbl17: TLabel
        Left = 19
        Top = 18
        Width = 55
        Height = 13
        Caption = 'Logradouro'
      end
      object lbl18: TLabel
        Left = 485
        Top = 18
        Width = 37
        Height = 13
        Caption = 'N'#250'mero'
      end
      object lbl19: TLabel
        Left = 19
        Top = 86
        Width = 65
        Height = 13
        Caption = 'Complemento'
      end
      inline frmEstado1: TfrmEstado
        Left = 7
        Top = 165
        Width = 195
        Height = 36
        TabOrder = 4
        ExplicitLeft = 7
        ExplicitTop = 165
        ExplicitWidth = 195
        ExplicitHeight = 36
        inherited lblID: TLabel
          Left = 131
          Top = 33
          ExplicitLeft = 131
          ExplicitTop = 33
        end
        inherited cbbcombo: TComboBox
          Width = 174
          Color = clInfoBk
          OnChange = frmEstado1cbbcomboChange
          ExplicitWidth = 174
        end
        inherited qryObterPorID: TFDQuery
          Left = 24
          Top = 24
        end
        inherited qryObterTodos: TFDQuery
          Left = 88
          Top = 24
        end
      end
      inline frmCidade1: TfrmCidade
        Left = 215
        Top = 165
        Width = 250
        Height = 36
        TabOrder = 5
        ExplicitLeft = 215
        ExplicitTop = 165
        ExplicitWidth = 250
        ExplicitHeight = 36
        inherited cbbcombo: TComboBox
          Width = 244
          Color = clInfoBk
          OnChange = frmCidade1cbbcomboChange
          ExplicitWidth = 244
        end
      end
      inline frmBairro1: TfrmBairro
        Left = 471
        Top = 165
        Width = 254
        Height = 36
        TabOrder = 6
        ExplicitLeft = 471
        ExplicitTop = 165
        ExplicitHeight = 36
        inherited cbbcombo: TComboBox
          Top = 6
          Width = 231
          Color = clInfoBk
          OnChange = frmBairro1cbbcomboChange
          ExplicitTop = 6
          ExplicitWidth = 231
        end
      end
      object edtCEP: TEdit
        Left = 485
        Top = 111
        Width = 113
        Height = 21
        Alignment = taRightJustify
        Color = clInfoBk
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'Tahoma'
        Font.Style = [fsBold]
        ParentFont = False
        TabOrder = 3
      end
      object edtLogradouro: TEdit
        Left = 19
        Top = 47
        Width = 417
        Height = 21
        Color = clInfoBk
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'Tahoma'
        Font.Style = [fsBold]
        ParentFont = False
        TabOrder = 0
      end
      object edtNumero: TEdit
        Left = 485
        Top = 47
        Width = 113
        Height = 21
        Alignment = taRightJustify
        Color = clInfoBk
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'Tahoma'
        Font.Style = [fsBold]
        ParentFont = False
        TabOrder = 1
      end
      object edtComplemento: TEdit
        Left = 19
        Top = 111
        Width = 417
        Height = 21
        Color = clInfoBk
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'Tahoma'
        Font.Style = [fsBold]
        ParentFont = False
        TabOrder = 2
      end
    end
    object tbTransfereContato: TcxTabSheet
      Caption = 'Contato'
      ImageIndex = 2
      OnShow = tbTransfereContatoShow
      object lbl9: TLabel
        Left = 19
        Top = 18
        Width = 33
        Height = 13
        Caption = 'Celular'
      end
      object lbl10: TLabel
        Left = 270
        Top = 22
        Width = 65
        Height = 13
        Caption = 'Telefone Fixo'
      end
      object lbl12: TLabel
        Left = 19
        Top = 90
        Width = 28
        Height = 13
        Caption = 'E-mail'
      end
      object edtCelular: TEdit
        Left = 19
        Top = 45
        Width = 208
        Height = 21
        Color = clHighlightText
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'Tahoma'
        Font.Style = [fsBold]
        ParentFont = False
        TabOrder = 0
        OnExit = edtCelularExit
      end
      object edtTelFixo: TEdit
        Left = 270
        Top = 45
        Width = 208
        Height = 21
        Color = clHighlightText
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'Tahoma'
        Font.Style = [fsBold]
        ParentFont = False
        TabOrder = 1
        OnExit = edtCelularExit
      end
      object edtEmail: TEdit
        Left = 19
        Top = 119
        Width = 315
        Height = 21
        Color = clHighlightText
        TabOrder = 2
      end
    end
    object tbTransfereContaBancaria: TcxTabSheet
      Caption = 'Conta Banc'#225'ria'
      ImageIndex = 3
      OnShow = tbTransfereContaBancariaShow
      object lblAge: TLabel
        Left = 261
        Top = 28
        Width = 38
        Height = 26
        Caption = 'Ag'#234'ncia'#13#10
      end
      object lbl6: TLabel
        Left = 384
        Top = 28
        Width = 29
        Height = 13
        Caption = 'Conta'
      end
      object lbl7: TLabel
        Left = 19
        Top = 28
        Width = 29
        Height = 13
        Caption = 'Banco'
      end
      object lbl23: TLabel
        Left = 19
        Top = 81
        Width = 96
        Height = 13
        Caption = 'Bancos cadastrados'
      end
      object edtAgencia: TEdit
        Left = 261
        Top = 53
        Width = 90
        Height = 21
        Alignment = taCenter
        Color = clScrollBar
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'Tahoma'
        Font.Style = [fsBold]
        ParentFont = False
        TabOrder = 0
      end
      object edtConta: TEdit
        Left = 384
        Top = 53
        Width = 143
        Height = 21
        Alignment = taCenter
        Color = clScrollBar
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'Tahoma'
        Font.Style = [fsBold]
        ParentFont = False
        TabOrder = 2
      end
      object dbgrdBanco: TDBGrid
        Left = 19
        Top = 109
        Width = 438
        Height = 116
        DataSource = dsBanco
        Options = [dgTitles, dgIndicator, dgColLines, dgRowLines, dgTabs, dgRowSelect, dgConfirmDelete, dgCancelOnExit, dgTitleClick, dgTitleHotTrack]
        TabOrder = 1
        TitleFont.Charset = DEFAULT_CHARSET
        TitleFont.Color = clWindowText
        TitleFont.Height = -11
        TitleFont.Name = 'Tahoma'
        TitleFont.Style = []
        OnTitleClick = dbgrdBancoTitleClick
        Columns = <
          item
            Expanded = False
            FieldName = 'NOME_BANCO'
            Title.Caption = 'BANCO'
            Width = 300
            Visible = True
          end
          item
            Expanded = False
            FieldName = 'CODIGO_BANCO'
            Title.Caption = 'C'#211'DIGO'
            Width = 100
            Visible = True
          end
          item
            Expanded = False
            FieldName = 'ID_BANCO'
            Visible = False
          end>
      end
      inline frmBanco1: TfrmBanco
        Left = 3
        Top = 49
        Width = 245
        Height = 26
        TabOrder = 3
        ExplicitLeft = 3
        ExplicitTop = 49
        ExplicitWidth = 245
        ExplicitHeight = 26
        inherited cbbBanco: TComboBox
          Left = 15
          Width = 203
          Color = clScrollBar
          ExplicitLeft = 15
          ExplicitWidth = 203
        end
      end
    end
    object tbTransfereContaContabil: TcxTabSheet
      Caption = 'Conta Cont'#225'bil'
      ImageIndex = 4
      OnShow = tbTransfereContaContabilShow
      object lbl20: TLabel
        Left = 338
        Top = 19
        Width = 80
        Height = 13
        Caption = 'C'#243'digo Reduzido'
      end
      object lbl21: TLabel
        Left = 465
        Top = 19
        Width = 32
        Height = 13
        Caption = 'Conta '
      end
      object edtCODREDUZ: TEdit
        Left = 338
        Top = 42
        Width = 90
        Height = 21
        Alignment = taCenter
        Color = clMoneyGreen
        Enabled = False
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'Tahoma'
        Font.Style = [fsBold]
        ParentFont = False
        TabOrder = 0
      end
      object edtContaContabil: TEdit
        Left = 465
        Top = 42
        Width = 141
        Height = 21
        Alignment = taRightJustify
        Color = clMoneyGreen
        Enabled = False
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'Tahoma'
        Font.Style = [fsBold]
        ParentFont = False
        TabOrder = 2
      end
      inline frmContaContabil1: TfrmContaContabil
        Left = 16
        Top = 19
        Width = 321
        Height = 62
        TabOrder = 1
        ExplicitLeft = 16
        ExplicitTop = 19
        ExplicitWidth = 321
        inherited lbl1: TLabel
          Left = 3
          Top = -3
          ExplicitLeft = 3
          ExplicitTop = -3
        end
        inherited cbbContaContabil: TComboBox
          Tag = 1
          Left = 3
          Width = 302
          Color = clMoneyGreen
          OnChange = frmContaContabil1cbbContaContabilChange
          ExplicitLeft = 3
          ExplicitWidth = 302
        end
      end
    end
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
    Left = 664
    Top = 56
    PixelsPerInch = 96
    object dxBarManager1Bar1: TdxBar
      Caption = 'Editar'
      CaptionButtons = <>
      DockedLeft = 54
      DockedTop = 0
      FloatLeft = 818
      FloatTop = 8
      FloatClientWidth = 0
      FloatClientHeight = 0
      ItemLinks = <
        item
          Visible = True
          ItemName = 'dxBtnEditar'
        end>
      OneOnRow = False
      Row = 0
      UseOwnFont = False
      Visible = True
      WholeRow = False
    end
    object dxBarSalvar: TdxBar
      Caption = 'Salvar'
      CaptionButtons = <>
      DockedLeft = 109
      DockedTop = 0
      FloatLeft = 818
      FloatTop = 8
      FloatClientWidth = 0
      FloatClientHeight = 0
      ItemLinks = <
        item
          Visible = True
          ItemName = 'dxBtnSalvar'
        end>
      OneOnRow = False
      Row = 0
      UseOwnFont = False
      Visible = True
      WholeRow = False
    end
    object dxBarManager1Bar2: TdxBar
      Caption = 'Custom 1'
      CaptionButtons = <>
      DockedLeft = 0
      DockedTop = 0
      FloatLeft = 818
      FloatTop = 8
      FloatClientWidth = 0
      FloatClientHeight = 0
      ItemLinks = <
        item
          Visible = True
          ItemName = 'dxBtnNovo'
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
      DockedLeft = 494
      DockedTop = 0
      FloatLeft = 818
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
      Caption = 'Excluir'
      CaptionButtons = <>
      DockedLeft = 165
      DockedTop = 0
      FloatLeft = 818
      FloatTop = 8
      FloatClientWidth = 0
      FloatClientHeight = 0
      ItemLinks = <
        item
          Visible = True
          ItemName = 'dxBtnDeletar'
        end>
      OneOnRow = False
      Row = 0
      UseOwnFont = False
      Visible = True
      WholeRow = False
    end
    object dxBarManager1Bar5: TdxBar
      Caption = 'Pesquisar'
      CaptionButtons = <>
      DockedLeft = 227
      DockedTop = 0
      FloatLeft = 818
      FloatTop = 8
      FloatClientWidth = 0
      FloatClientHeight = 0
      ItemLinks = <
        item
          UserDefine = [udWidth]
          UserWidth = 144
          Visible = True
          ItemName = 'cxbrdtmPesquisa'
        end>
      OneOnRow = False
      Row = 0
      UseOwnFont = False
      Visible = True
      WholeRow = False
    end
    object dxBarManager1Bar6: TdxBar
      Caption = 'Limpar'
      CaptionButtons = <>
      DockedLeft = 432
      DockedTop = 0
      FloatLeft = 871
      FloatTop = 8
      FloatClientWidth = 0
      FloatClientHeight = 0
      ItemLinks = <
        item
          Visible = True
          ItemName = 'dxBtnLimpar'
        end>
      OneOnRow = False
      Row = 0
      UseOwnFont = False
      Visible = True
      WholeRow = False
    end
    object dxBtnEditar: TdxBarLargeButton
      Caption = 'Editar'#13#10
      Category = 0
      Hint = 'Editar'#13#10' registro. F2'
      Visible = ivAlways
      OnClick = dxBtnEditarClick
    end
    object dxBtnSalvar: TdxBarLargeButton
      Caption = 'Salvar'
      Category = 0
      Hint = 'Salvar registro. F10'
      Visible = ivAlways
      OnClick = dxBtnSalvarClick
    end
    object dxBtnNovo: TdxBarLargeButton
      Caption = 'Novo'
      Category = 0
      Hint = 'Novo registro. F4'
      Visible = ivAlways
      OnClick = dxBtnNovoClick
    end
    object dxBtnFechar: TdxBarLargeButton
      Caption = 'Fechar'
      Category = 0
      Hint = 'Fechar'
      Visible = ivAlways
      OnClick = dxBtnFecharClick
    end
    object dxBtnDeletar: TdxBarLargeButton
      Caption = 'Deletar'
      Category = 0
      Hint = 'Deletar'
      Visible = ivAlways
      OnClick = dxBtnDeletarClick
    end
    object cxbrdtmPesquisa: TcxBarEditItem
      Caption = 'Sacados'
      Category = 0
      Hint = 'Sacado'
      Visible = ivAlways
      OnCurChange = cxbrdtmPesquisaCurChange
      PropertiesClassName = 'TcxTextEditProperties'
    end
    object dxBtnLimpar: TdxBarLargeButton
      Caption = 'Limpar'
      Category = 0
      Hint = 'Limpar'
      Visible = ivAlways
      OnClick = dxBtnLimparClick
    end
  end
  object dsGridMain: TDataSource
    AutoEdit = False
    DataSet = qryPreencheGrid
    OnDataChange = dsGridMainDataChange
    Left = 416
    Top = 461
  end
  object qryPreencheGrid: TFDQuery
    Connection = dmConexao.conn
    SQL.Strings = (
      ' SELECT C.ID_SACADO, '
      '        C.ID_ORGANIZACAO,'
      '        C.ID_TIPO_SACADO, '
      '        TC.DESCRICAO AS TIPO, '
      '        C.ID_ENDERECO,'
      '        C.ID_CONTATO, '
      '        C.NOME, '
      '        C.CPFCNPJ,'
      '        C.PERSONALIDADE, '
      '        C.CONTA_BANCARIA,'
      '        C.AGENCIA, '
      '        C.ID_BANCO, '
      '        C.INSCRICAO_ESTADUAL,  '
      '        C.ID_CONTA_CONTABIL,'
      '        C.DATA_REGISTRO, '
      '        C.STATUS, '
      '        C.DATA_ULTIMA_ATUALIZACAO, '
      '        C.CODIGO,'
      '        CTO.TELEFONE,'
      '        CTO.CELULAR'
      'FROM SACADO C'
      ''
      
        'INNER JOIN CONTATO CTO ON (CTO.ID_CONTATO = C.ID_CONTATO) AND (C' +
        'TO.ID_ORGANIZACAO = C.ID_ORGANIZACAO)'
      
        'INNER JOIN TIPO_SACADO TC ON (TC.ID_TIPO_SACADO = C.ID_TIPO_SACA' +
        'DO) AND (TC.ID_ORGANIZACAO = C.ID_ORGANIZACAO)'
      ''
      'WHERE ( C.ID_ORGANIZACAO = :PIDORGANIZACAO ) '
      ''
      'ORDER BY C.NOME   ')
    Left = 544
    Top = 464
    ParamData = <
      item
        Name = 'PIDORGANIZACAO'
        DataType = ftString
        ParamType = ptInput
        Size = 36
      end>
  end
  object dsBanco: TDataSource
    AutoEdit = False
    DataSet = qryGridBanco
    OnDataChange = dsBancoDataChange
    Left = 144
    Top = 525
  end
  object qryGridBanco: TFDQuery
    Connection = dmConexao.conn
    SQL.Strings = (
      'SELECT  B.ID_BANCO, B.CODIGO_BANCO, B.NOME_BANCO, B.SIGLA_BANCO'
      ''
      'FROM BANCO B  WHERE ( B.ID_ORGANIZACAO = :PIDORGANIZACAO ) '
      ''
      'ORDER BY B.NOME_BANCO ;')
    Left = 76
    Top = 533
    ParamData = <
      item
        Name = 'PIDORGANIZACAO'
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
    Left = 744
    Top = 56
  end
end
