object frmManterTOB: TfrmManterTOB
  Left = 0
  Top = 0
  Caption = 'Detalhes'
  ClientHeight = 594
  ClientWidth = 784
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
  object lbl1: TLabel
    Left = 352
    Top = 208
    Width = 67
    Height = 13
    Caption = 'C'#243'd. reduzido'
  end
  object lbl2: TLabel
    Left = 352
    Top = 156
    Width = 116
    Height = 13
    Caption = 'Descri'#231#227'o conta cont'#225'bil'
  end
  object lbl3: TLabel
    Left = 527
    Top = 208
    Width = 69
    Height = 13
    Caption = 'Conta cont'#225'bil'
  end
  object lbl4: TLabel
    Left = 31
    Top = 220
    Width = 91
    Height = 13
    Caption = 'Opera'#231#227'o banc'#225'ria'
  end
  object lbl5: TLabel
    Left = 526
    Top = 242
    Width = 70
    Height = 13
    Caption = 'C'#243'digo padr'#227'o'
  end
  object dxRibbon1: TdxRibbon
    Left = 0
    Top = 0
    Width = 784
    Height = 125
    BarManager = dxBarManager1
    ColorSchemeName = 'UserSkin'
    Contexts = <>
    TabOrder = 3
    TabStop = False
    object dxRibbon1Tab1: TdxRibbonTab
      Active = True
      Caption = 'Manuten'#231#227'o de tipos de opera'#231#245'es banc'#225'rias'
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
          ToolbarName = 'dxBarManager1Bar3'
        end>
      Index = 0
    end
  end
  object dxStatusBar: TdxStatusBar
    Left = 0
    Top = 574
    Width = 784
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
    ExplicitTop = 503
  end
  inline frmContaContabil1: TfrmContaContabil
    Left = 24
    Top = 152
    Width = 308
    Height = 62
    TabOrder = 6
    ExplicitLeft = 24
    ExplicitTop = 152
    inherited cbbContaContabil: TComboBox
      Color = clMoneyGreen
      OnChange = frmContaContabil1cbbContaContabilChange
    end
  end
  object dbgrd1: TDBGrid
    Left = 0
    Top = 281
    Width = 784
    Height = 293
    Align = alBottom
    DataSource = dsGrid
    Options = [dgTitles, dgIndicator, dgColumnResize, dgColLines, dgRowLines, dgTabs, dgRowSelect, dgCancelOnExit, dgTitleClick, dgTitleHotTrack]
    TabOrder = 7
    TitleFont.Charset = DEFAULT_CHARSET
    TitleFont.Color = clWindowText
    TitleFont.Height = -11
    TitleFont.Name = 'Tahoma'
    TitleFont.Style = []
    OnTitleClick = dbgrd1TitleClick
    Columns = <
      item
        Expanded = False
        FieldName = 'DESCRICAO'
        Title.Alignment = taCenter
        Title.Caption = 'TIPO OPERA'#199#195'O BANC'#193'RIA'
        Title.Font.Charset = DEFAULT_CHARSET
        Title.Font.Color = clWindowText
        Title.Font.Height = -11
        Title.Font.Name = 'Tahoma'
        Title.Font.Style = [fsBold]
        Width = 400
        Visible = True
      end
      item
        Alignment = taCenter
        Expanded = False
        FieldName = 'CODIGO'
        Title.Alignment = taCenter
        Title.Caption = 'COD_PADR'#195'O'
        Title.Font.Charset = DEFAULT_CHARSET
        Title.Font.Color = clWindowText
        Title.Font.Height = -11
        Title.Font.Name = 'Tahoma'
        Title.Font.Style = [fsBold]
        Width = 120
        Visible = True
      end
      item
        Alignment = taRightJustify
        Expanded = False
        FieldName = 'CODREDUZ'
        Title.Alignment = taCenter
        Title.Caption = 'COD_REDUZI'
        Title.Font.Charset = DEFAULT_CHARSET
        Title.Font.Color = clWindowText
        Title.Font.Height = -11
        Title.Font.Name = 'Tahoma'
        Title.Font.Style = [fsBold]
        Width = 120
        Visible = True
      end
      item
        Alignment = taRightJustify
        Expanded = False
        FieldName = 'TIPO'
        Title.Alignment = taCenter
        Title.Font.Charset = DEFAULT_CHARSET
        Title.Font.Color = clWindowText
        Title.Font.Height = -11
        Title.Font.Name = 'Tahoma'
        Title.Font.Style = [fsBold]
        Width = 80
        Visible = True
      end>
  end
  object edtDescricaoConta: TEdit
    Left = 352
    Top = 175
    Width = 369
    Height = 21
    AutoSelect = False
    AutoSize = False
    Color = clMoneyGreen
    Enabled = False
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'Tahoma'
    Font.Style = [fsBold]
    ParentFont = False
    TabOrder = 8
  end
  object edtCODREDUZ: TEdit
    Left = 430
    Top = 204
    Width = 67
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
    TabOrder = 9
  end
  object edtContaContabil: TEdit
    Left = 608
    Top = 204
    Width = 113
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
    TabOrder = 5
  end
  object edtDescicao: TEdit
    Left = 31
    Top = 239
    Width = 290
    Height = 21
    Color = cl3DLight
    TabOrder = 0
    Text = 'edtDescicao'
  end
  object cbbTipo: TComboBox
    Left = 352
    Top = 239
    Width = 145
    Height = 21
    Color = cl3DLight
    TabOrder = 1
    Text = 'cbbTipo'
    Items.Strings = (
      '>>Selecione<<'
      'Geral'
      'Pagamentos'
      'Recebimentos'
      'Dedu'#231#245'es'
      'Acr'#233'scimos'
      'Caixa')
  end
  object edtCodHistPadrao: TEdit
    Left = 608
    Top = 239
    Width = 113
    Height = 21
    Alignment = taRightJustify
    Color = cl3DLight
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'Tahoma'
    Font.Style = [fsBold]
    ParentFont = False
    TabOrder = 2
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
      DockedLeft = 440
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
      Caption = 'Descri'#231#227'o'
      Category = 0
      Hint = 'Descri'#231#227'o'
      Visible = ivAlways
      OnCurChange = cxbrdtmPesquisaCurChange
      PropertiesClassName = 'TcxTextEditProperties'
    end
  end
  object dsGrid: TDataSource
    AutoEdit = False
    DataSet = qryPreencheGrid
    OnDataChange = dsGridDataChange
    Left = 168
    Top = 373
  end
  object qryPreencheGrid: TFDQuery
    Connection = dmConexao.conn
    SQL.Strings = (
      'SELECT H.ID_TIPO_OPERACAO_BANCARIA,'
      '       H.ID_ORGANIZACAO,'
      '       H.DESCRICAO,'
      '       H.TIPO,'
      '       H.CODIGO,'
      '       H.ID_CONTA_CONTABIL,'
      '       CC.CONTA, CC.CODREDUZ'
      ''
      ''
      'FROM TIPO_OPERACAO_BANCARIA H'
      
        'LEFT OUTER JOIN CONTA_CONTABIL CC ON (CC.ID_CONTA_CONTABIL = H.I' +
        'D_CONTA_CONTABIL)'
      ''
      'WHERE (H.ID_ORGANIZACAO = :PIDORGANIZACAO)'
      ''
      'ORDER BY H.DESCRICAO')
    Left = 264
    Top = 376
    ParamData = <
      item
        Name = 'PIDORGANIZACAO'
        DataType = ftString
        ParamType = ptInput
        Size = 36
      end>
  end
end
