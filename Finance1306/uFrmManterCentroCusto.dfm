object frmManterCentroCusto: TfrmManterCentroCusto
  Left = 0
  Top = 0
  Caption = 'Detalhes'
  ClientHeight = 578
  ClientWidth = 581
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
    Top = 140
    Width = 33
    Height = 13
    Caption = 'C'#243'digo'
  end
  object lbl3: TLabel
    Left = 455
    Top = 140
    Width = 22
    Height = 13
    Caption = 'Sigla'
  end
  object lbl4: TLabel
    Left = 15
    Top = 140
    Width = 133
    Height = 13
    Caption = 'Descri'#231#227'o Centro de Custos'
  end
  object dxRibbon1: TdxRibbon
    Left = 0
    Top = 0
    Width = 581
    Height = 125
    BarManager = dxBarManager1
    ColorSchemeName = 'UserSkin'
    Contexts = <>
    TabOrder = 3
    TabStop = False
    ExplicitWidth = 784
    object dxRibbon1Tab1: TdxRibbonTab
      Active = True
      Caption = 'Manuten'#231#227'o de Centro de Custos'
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
    Top = 558
    Width = 581
    Height = 20
    Panels = <
      item
        PanelStyleClassName = 'TdxStatusBarTextPanelStyle'
        Width = 100
      end
      item
        PanelStyleClassName = 'TdxStatusBarTextPanelStyle'
        Width = 300
      end>
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'Tahoma'
    Font.Style = []
    ExplicitTop = 574
    ExplicitWidth = 784
  end
  object dbgrd1: TDBGrid
    Left = 0
    Top = 200
    Width = 581
    Height = 358
    Align = alBottom
    DataSource = dsMain
    Options = [dgTitles, dgIndicator, dgColumnResize, dgColLines, dgRowLines, dgTabs, dgRowSelect, dgCancelOnExit, dgTitleClick, dgTitleHotTrack]
    TabOrder = 5
    TitleFont.Charset = DEFAULT_CHARSET
    TitleFont.Color = clWindowText
    TitleFont.Height = -11
    TitleFont.Name = 'Tahoma'
    TitleFont.Style = []
    OnTitleClick = dbgrd1TitleClick
    Columns = <
      item
        Expanded = False
        FieldName = 'ID_CENTRO_CUSTO'
        Title.Alignment = taCenter
        Title.Font.Charset = DEFAULT_CHARSET
        Title.Font.Color = clWindowText
        Title.Font.Height = -11
        Title.Font.Name = 'Tahoma'
        Title.Font.Style = [fsBold]
        Visible = False
      end
      item
        Expanded = False
        FieldName = 'DESCRICAO'
        Title.Alignment = taCenter
        Title.Font.Charset = DEFAULT_CHARSET
        Title.Font.Color = clWindowText
        Title.Font.Height = -11
        Title.Font.Name = 'Tahoma'
        Title.Font.Style = [fsBold]
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'CODIGO'
        Title.Alignment = taCenter
        Title.Font.Charset = DEFAULT_CHARSET
        Title.Font.Color = clWindowText
        Title.Font.Height = -11
        Title.Font.Name = 'Tahoma'
        Title.Font.Style = [fsBold]
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'SIGLA'
        Title.Alignment = taCenter
        Title.Font.Charset = DEFAULT_CHARSET
        Title.Font.Color = clWindowText
        Title.Font.Height = -11
        Title.Font.Name = 'Tahoma'
        Title.Font.Style = [fsBold]
        Visible = True
      end>
  end
  object edtCodigo: TEdit
    Tag = 1
    Left = 352
    Top = 164
    Width = 67
    Height = 21
    Alignment = taCenter
    Color = clMoneyGreen
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'Tahoma'
    Font.Style = [fsBold]
    ParentFont = False
    TabOrder = 1
  end
  object edtSigla: TEdit
    Tag = 1
    Left = 455
    Top = 164
    Width = 113
    Height = 21
    Alignment = taRightJustify
    Color = clMoneyGreen
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'Tahoma'
    Font.Style = [fsBold]
    ParentFont = False
    TabOrder = 2
  end
  object edtCentroCusto: TEdit
    Tag = 1
    Left = 15
    Top = 164
    Width = 290
    Height = 21
    Color = cl3DLight
    TabOrder = 0
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
    Left = 472
    Top = 288
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
      DockedLeft = 502
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
      DockedLeft = 440
      DockedTop = 0
      FloatLeft = 818
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
      Caption = 'Descri'#231#227'o'
      Category = 0
      Hint = 'Descri'#231#227'o'
      Visible = ivAlways
      OnCurChange = cxbrdtmPesquisaCurChange
      Width = 120
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
  object dsMain: TDataSource
    AutoEdit = False
    DataSet = qryPreencheGrid
    OnDataChange = dsMainDataChange
    Left = 168
    Top = 373
  end
  object qryPreencheGrid: TFDQuery
    Connection = dmConexao.conn
    SQL.Strings = (
      
        'SELECT * FROM CENTRO_CUSTO C  WHERE (C.ID_ORGANIZACAO = :PIDORGA' +
        'NIZACAO) ORDER BY C.DESCRICAO'
      ''
      ''
      '')
    Left = 264
    Top = 376
    ParamData = <
      item
        Name = 'PIDORGANIZACAO'
        DataType = ftString
        ParamType = ptInput
        Size = 36
      end>
    object qryPreencheGridID_CENTRO_CUSTO: TStringField
      FieldName = 'ID_CENTRO_CUSTO'
      Origin = 'ID_CENTRO_CUSTO'
      ProviderFlags = [pfInUpdate, pfInWhere, pfInKey]
      Required = True
      Size = 36
    end
    object qryPreencheGridID_ORGANIZACAO: TStringField
      FieldName = 'ID_ORGANIZACAO'
      Origin = 'ID_ORGANIZACAO'
      ProviderFlags = [pfInUpdate, pfInWhere, pfInKey]
      Required = True
      Size = 36
    end
    object qryPreencheGridDESCRICAO: TStringField
      FieldName = 'DESCRICAO'
      Origin = 'DESCRICAO'
      Required = True
      Size = 60
    end
    object qryPreencheGridCODIGO: TIntegerField
      FieldName = 'CODIGO'
      Origin = 'CODIGO'
    end
    object qryPreencheGridSIGLA: TStringField
      FieldName = 'SIGLA'
      Origin = 'SIGLA'
    end
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
    Left = 400
    Top = 280
  end
end
