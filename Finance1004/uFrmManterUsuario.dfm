object frmManterUsuario: TfrmManterUsuario
  Left = 0
  Top = 0
  Caption = 'Usu'#225'rio'
  ClientHeight = 523
  ClientWidth = 842
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
    Left = 7
    Top = 157
    Width = 27
    Height = 13
    Caption = 'Nome'
  end
  object lbl2: TLabel
    Left = 9
    Top = 196
    Width = 25
    Height = 13
    Caption = 'Login'
  end
  object dxRibbon1: TdxRibbon
    Left = 0
    Top = 0
    Width = 842
    Height = 125
    BarManager = dxBarManager1
    ColorSchemeName = 'UserSkin'
    Contexts = <>
    TabOrder = 6
    TabStop = False
    ExplicitWidth = 784
    object dxRibbon1Tab1: TdxRibbonTab
      Active = True
      Caption = 'Manuten'#231#227'o de usu'#225'rios'
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
          ToolbarName = 'dxBarManager1Bar7'
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
    Top = 503
    Width = 842
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
    ExplicitWidth = 784
  end
  object dbgrd1: TDBGrid
    Left = 40
    Top = 236
    Width = 425
    Height = 253
    DataSource = dsMain
    Options = [dgTitles, dgIndicator, dgColumnResize, dgColLines, dgRowLines, dgTabs, dgRowSelect, dgCancelOnExit, dgTitleClick, dgTitleHotTrack]
    TabOrder = 8
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
        Width = 200
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'LOGIN'
        Width = 150
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'ID_USUARIO'
        Visible = False
      end>
  end
  object edtLogin: TEdit
    Left = 40
    Top = 193
    Width = 297
    Height = 21
    TabOrder = 1
    Text = 'edtLogin'
  end
  object edtNome: TEdit
    Left = 40
    Top = 154
    Width = 297
    Height = 21
    TabOrder = 0
    Text = 'Edit1'
  end
  object chkAtivo: TCheckBox
    Left = 368
    Top = 156
    Width = 73
    Height = 17
    Caption = 'Ativo'
    TabOrder = 2
  end
  object chkAdm: TCheckBox
    Left = 368
    Top = 195
    Width = 97
    Height = 17
    Caption = 'Administrador'
    TabOrder = 3
  end
  object chkLA: TCheckBox
    Left = 475
    Top = 156
    Width = 126
    Height = 17
    Caption = 'Login autom'#225'tico'
    TabOrder = 4
  end
  object chkContador: TCheckBox
    Left = 475
    Top = 195
    Width = 126
    Height = 17
    Caption = 'Contador'
    TabOrder = 5
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
    Left = 632
    Top = 344
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
      Row = 1
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
      Row = 1
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
      Row = 1
      UseOwnFont = False
      Visible = True
      WholeRow = False
    end
    object dxBarManager1Bar3: TdxBar
      Caption = 'Sair'
      CaptionButtons = <>
      DockedLeft = 566
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
      Row = 1
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
      Row = 1
      UseOwnFont = False
      Visible = True
      WholeRow = False
    end
    object dxBarManager1Bar5: TdxBar
      Caption = 'Pesquisar'
      CaptionButtons = <>
      DockedLeft = 290
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
      Row = 1
      UseOwnFont = False
      Visible = True
      WholeRow = False
    end
    object dxBarManager1Bar6: TdxBar
      Caption = 'Limpar'
      CaptionButtons = <>
      DockedLeft = 504
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
      Row = 1
      UseOwnFont = False
      Visible = True
      WholeRow = False
    end
    object dxBarManager1Bar7: TdxBar
      Caption = 'Senha'
      CaptionButtons = <>
      DockedLeft = 227
      DockedTop = 0
      FloatLeft = 878
      FloatTop = 8
      FloatClientWidth = 0
      FloatClientHeight = 0
      ItemLinks = <
        item
          Visible = True
          ItemName = 'dxBtnResetSenha'
        end>
      OneOnRow = True
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
      Caption = 'Nome'
      Category = 0
      Hint = 'Usu'#225'rio'
      Visible = ivAlways
      OnCurChange = cxbrdtmPesquisaCurChange
      Glyph.SourceDPI = 96
      Glyph.Data = {
        89504E470D0A1A0A0000000D49484452000000100000001008060000001FF3FF
        610000001974455874536F6674776172650041646F626520496D616765526561
        647971C9653C0000000F744558745469746C6500456D706C6F7965653B440C58
        C3000002B049444154785E85926F4895571CC73F8F79BDD7AE37AFC9B5E276C3
        91E9D2B4503335DAA645DDC1DC6853485B63B4BB11495652BD28B0A0207BB546
        AF267BD5C6C031119C6C2C31419B1B634E2DC54811C3FE28625A797D9EE79CE7
        7AF242C583507E0F5FCEEFC5E1F3FB1EF86A4A29ECFAA9261961A99285885625
        2DB5575A600A6E48A17EB6241D752D33D815CB1209A94AFC5BF67D1FD812DC14
        C82A4501A3BDEDA1C1BFFFF860A0FBCF6F800E6C8A6189220B546DC80E6ECAC8
        CF437BD64C78E824DE48236B92659A696A9F03CB24301C65E343C3FCF36B038F
        C61E204504B707123C0B48938F00DE9AC030E2BD0971FF52FA999FEA4BC5549F
        DFC69E323FBE9478A4A1252E0B78381DA9E8EB9C316E34E95C3BF71FDFD50DD0
        DA344B67DBAC39FE547EB12CE0DBF607B79423A1E7BDF210472FD472B07A3FEF
        6E0E303327067F1F9DFBEB8D8013F5D7D1342D16F0DC9DD6C687BA5AB93734C9
        E8C0F0A2C7985A9134017817DF382BBE3ACD6BD97AE0F4A7A6671F3C7EB13BF8
        7583BA7CEA88BA5A99A72E7F9CA50E7DB8471556D4AB6079A83F31C9F73EE006
        A21D7A9D20362D2B3FB3FC706DC789C3078A2CCBC29956C88ECA2A520B0AD0D7
        662385C9B1235FE6949455FE96E45B570838EC5F706F2DDA5D5BBA3337396773
        2A9694A4A76DA4B917DAA6D6535C988B30056121D89A93E9F1BF93791248B2F7
        C093B8DAB72B736380B9F03C420802FE757CFA4910DD30081B2652DE8ECE389C
        71385C9EED8017987C0570B9E2DD6BD724AFA2A6FE26A696C2A1733711FA3CA6
        1EC69C0F2374C1B5862E0E94678116B31A58694F004A113D77469E90979F8161
        4AF4459B8B8ECED2B4E8696F418874A46529C0B203668707FFFFF1CC95859052
        6EBA6FF521741DD3788E886E37E689480394A2B1B195E9C7F77F01A6B003DA9A
        7E380B5C055C0080F6D2D86EFA4710C004300DF002DC033055FB48D5EE000000
        0049454E44AE426082}
      PropertiesClassName = 'TcxTextEditProperties'
    end
    object dxBtnLimpar: TdxBarLargeButton
      Caption = 'Limpar'
      Category = 0
      Hint = 'Limpar'
      Visible = ivAlways
      OnClick = dxBtnLimparClick
    end
    object dxBtnResetSenha: TdxBarLargeButton
      Caption = 'Resetar'
      Category = 0
      Hint = 'Resetar'
      Visible = ivAlways
      OnClick = dxBtnResetSenhaClick
    end
  end
  object dsMain: TDataSource
    AutoEdit = False
    DataSet = qryPreencheGrid
    OnDataChange = dsMainDataChange
    Left = 520
    Top = 373
  end
  object qryPreencheGrid: TFDQuery
    Active = True
    Connection = dmConexao.conn
    SQL.Strings = (
      'SELECT U.NOME, U.LOGIN, U.ID_USUARIO'
      ''
      'FROM USUARIO U'
      ''
      'WHERE 1=1 '
      ''
      'ORDER BY U.NOME'
      ''
      ''
      '')
    Left = 520
    Top = 312
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
    Left = 632
    Top = 256
  end
  object obterIDUSER: TFDQuery
    Connection = dmConexao.conn
    SQL.Strings = (
      'SELECT MAX(ID_USUARIO)+1 AS NEWID FROM USUARIO WHERE   1=1 ;')
    Left = 512
    Top = 256
  end
end
