object frmManterTituloPagar: TfrmManterTituloPagar
  Left = 0
  Top = 0
  Caption = 'Manuten'#231#227'o de t'#237'tulos a pagar'
  ClientHeight = 659
  ClientWidth = 912
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
    Width = 912
    Height = 125
    BarManager = dxBarManager1
    ColorSchemeName = 'UserSkin'
    Contexts = <>
    TabOrder = 1
    TabStop = False
    object dxRibbon1Tab1: TdxRibbonTab
      Active = True
      Caption = 'T'#237'tulos a pagar'
      Groups = <
        item
        end
        item
        end
        item
          ToolbarName = 'dxBarManager1Bar1'
        end
        item
          ToolbarName = 'dxBarManager1Bar2'
        end
        item
          ToolbarName = 'dxBarManager1Bar3'
        end
        item
          ToolbarName = 'dxBarManager1Bar5'
        end
        item
          ToolbarName = 'dxBarManager1Bar4'
        end
        item
          ToolbarName = 'dxBarManager1Bar8'
        end
        item
          ToolbarName = 'dxBarManager1Bar9'
        end
        item
          ToolbarName = 'dxBarManager1Bar6'
        end
        item
          ToolbarName = 'dxBarManager1Bar7'
        end>
      Index = 0
    end
  end
  object dxStatusBar: TdxStatusBar
    Left = 0
    Top = 639
    Width = 912
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
  object pgTitulo: TcxPageControl
    Left = 0
    Top = 125
    Width = 912
    Height = 420
    Align = alTop
    TabOrder = 0
    Properties.ActivePage = tbBasica
    Properties.CustomButtons.Buttons = <>
    ExplicitLeft = 25
    ExplicitTop = 165
    ClientRectBottom = 420
    ClientRectRight = 912
    ClientRectTop = 24
    object tbBasica: TcxTabSheet
      Caption = 'Dados b'#225'sicos'
      ImageIndex = 0
      object Label1: TLabel
        Left = 555
        Top = 339
        Width = 78
        Height = 13
        Caption = 'Lote pagamento'
      end
      object Label2: TLabel
        Left = 555
        Top = 301
        Width = 61
        Height = 13
        Caption = 'Lote cont'#225'bil'
      end
      object Label3: TLabel
        Left = 25
        Top = 5
        Width = 93
        Height = 13
        Caption = 'N'#250'mero documento'
      end
      object Label4: TLabel
        Left = 271
        Top = 5
        Width = 106
        Height = 13
        Caption = 'Cedente / Fornecedor'
      end
      object Label5: TLabel
        Left = 555
        Top = 5
        Width = 83
        Height = 13
        Caption = 'Historico principal'
      end
      object Label6: TLabel
        Left = 555
        Top = 94
        Width = 67
        Height = 13
        Caption = 'Tipo cobran'#231'a'
      end
      object lblResponsavel: TLabel
        Left = 555
        Top = 131
        Width = 81
        Height = 13
        Caption = 'Local pagamento'
      end
      object Label7: TLabel
        Left = 559
        Top = 231
        Width = 82
        Height = 13
        Caption = 'Centro de custos'
      end
      object Label8: TLabel
        Left = 25
        Top = 107
        Width = 64
        Height = 13
        Caption = 'Valor a pagar'
      end
      object Label9: TLabel
        Left = 185
        Top = 107
        Width = 46
        Height = 13
        Caption = 'Descri'#231#227'o'
      end
      object Label10: TLabel
        Left = 183
        Top = 169
        Width = 80
        Height = 13
        Caption = 'Data pagamento'
      end
      object Label11: TLabel
        Left = 310
        Top = 169
        Width = 64
        Height = 13
        Caption = 'Data emiss'#227'o'
      end
      object Label12: TLabel
        Left = 431
        Top = 169
        Width = 71
        Height = 13
        Caption = 'Data protocolo'
      end
      object Label13: TLabel
        Left = 25
        Top = 169
        Width = 35
        Height = 13
        Caption = 'Parcela'
      end
      object Label14: TLabel
        Left = 25
        Top = 231
        Width = 106
        Height = 13
        Caption = 'Status  do pagamento'
      end
      object Label15: TLabel
        Left = 398
        Top = 228
        Width = 80
        Height = 13
        Caption = 'Valor antecipado'
      end
      inline frameTP1: TframeTP
        Left = 17
        Top = 24
        Width = 160
        Height = 31
        TabOrder = 0
        ExplicitLeft = 17
        ExplicitTop = 24
        ExplicitWidth = 160
        ExplicitHeight = 31
        inherited cbbTP: TComboBox
          Tag = 1
          Left = 8
          Top = 7
          Width = 150
          AutoCompleteDelay = 10000
          OnChange = frameTP1cbbTPChange
          OnExit = frameTP1cbbTPExit
          ExplicitLeft = 8
          ExplicitTop = 7
          ExplicitWidth = 150
        end
      end
      inline frmTipoCobranca1: TfrmTipoCobranca
        Left = 651
        Top = 85
        Width = 160
        Height = 31
        TabOrder = 1
        ExplicitLeft = 651
        ExplicitTop = 85
        ExplicitWidth = 160
        ExplicitHeight = 31
        inherited cbbTipoCobranca: TComboBox
          Tag = 1
          Left = 7
          Top = 9
          Width = 150
          ExplicitLeft = 7
          ExplicitTop = 9
          ExplicitWidth = 150
        end
      end
      inline frmLocalPagto1: TfrmLocalPagto
        Left = 651
        Top = 122
        Width = 160
        Height = 31
        TabOrder = 2
        ExplicitLeft = 651
        ExplicitTop = 122
        ExplicitWidth = 160
        ExplicitHeight = 31
        inherited cbbLocalPagto: TComboBox
          Tag = 1
          Left = 7
          Top = 9
          Width = 150
          ExplicitLeft = 7
          ExplicitTop = 9
          ExplicitWidth = 150
        end
      end
      inline frameCedente1: TframeCedente
        Left = 264
        Top = 29
        Width = 265
        Height = 26
        TabOrder = 3
        ExplicitLeft = 264
        ExplicitTop = 29
        ExplicitWidth = 265
        ExplicitHeight = 26
        inherited cbbcombo: TComboBox
          Tag = 1
          Left = 7
          Width = 250
          OnChange = frameCedente1cbbcomboChange
          ExplicitLeft = 7
          ExplicitWidth = 250
        end
      end
      inline frameHistorico1: TframeHistorico
        Left = 555
        Top = 31
        Width = 265
        Height = 48
        TabOrder = 5
        ExplicitLeft = 555
        ExplicitTop = 31
        ExplicitWidth = 265
        ExplicitHeight = 48
        inherited lblID: TLabel
          Left = 207
          Top = 3
          ExplicitLeft = 207
          ExplicitTop = 3
        end
        inherited cbbcombo: TComboBox
          Tag = 1
          Top = 0
          Width = 250
          OnChange = frameHistorico1cbbcomboChange
          ExplicitTop = 0
          ExplicitWidth = 250
        end
        inherited qryObterPorID: TFDQuery
          Top = 0
        end
        inherited qryObterTodos: TFDQuery
          Left = 96
          Top = 0
        end
        inherited qryObterContaContabil: TFDQuery
          Left = 160
          Top = 0
        end
      end
      inline frameCentroCusto1: TframeCentroCusto
        Left = 555
        Top = 247
        Width = 265
        Height = 31
        TabOrder = 6
        ExplicitLeft = 555
        ExplicitTop = 247
        ExplicitWidth = 265
        ExplicitHeight = 31
        inherited cbbCentroCusto: TComboBox
          Tag = 1
          Left = 5
          Top = 7
          Width = 246
          OnChange = frameCentroCusto1cbbCentroCustoChange
          ExplicitLeft = 5
          ExplicitTop = 7
          ExplicitWidth = 246
        end
        inherited qry1: TFDQuery
          Left = 80
          Top = 16
        end
      end
      inline frameResponsavel1: TframeResponsavel
        Left = 555
        Top = 170
        Width = 278
        Height = 58
        TabOrder = 11
        ExplicitLeft = 555
        ExplicitTop = 170
        ExplicitWidth = 278
        ExplicitHeight = 58
        inherited lblID: TLabel
          Left = 51
          Top = 30
          ExplicitLeft = 51
          ExplicitTop = 30
        end
        inherited lblResponsavel: TLabel
          Top = -1
          ExplicitTop = -1
        end
        inherited cbbcombo: TComboBox
          Tag = 1
          Left = 4
          Width = 246
          OnChange = frameResponsavel1cbbcomboChange
          ExplicitLeft = 4
          ExplicitWidth = 246
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
      object edtLotePagamento: TEdit
        Left = 644
        Top = 337
        Width = 161
        Height = 21
        Alignment = taRightJustify
        Color = cl3DLight
        Enabled = False
        TabOrder = 12
      end
      object edtLoteContabil: TEdit
        Left = 644
        Top = 296
        Width = 161
        Height = 21
        Alignment = taRightJustify
        Color = cl3DLight
        Enabled = False
        TabOrder = 13
      end
      object BtnGerarDOC: TBitBtn
        Left = 183
        Top = 27
        Width = 75
        Height = 25
        Caption = 'Gerar'
        TabOrder = 14
        OnClick = BtnGerarDOCClick
      end
      object edtCEDConta: TEdit
        Left = 272
        Top = 58
        Width = 134
        Height = 21
        Alignment = taRightJustify
        Color = cl3DLight
        Enabled = False
        TabOrder = 15
      end
      object edtCEDReduz: TEdit
        Left = 412
        Top = 58
        Width = 107
        Height = 21
        Alignment = taRightJustify
        Color = cl3DLight
        Enabled = False
        TabOrder = 16
      end
      object edtHISTConta: TEdit
        Left = 555
        Top = 58
        Width = 90
        Height = 21
        Alignment = taRightJustify
        Color = cl3DLight
        Enabled = False
        TabOrder = 17
      end
      object edtHISTReduz: TEdit
        Left = 651
        Top = 58
        Width = 70
        Height = 21
        Alignment = taRightJustify
        Color = cl3DLight
        Enabled = False
        TabOrder = 18
      end
      object edtCodigoHist: TEdit
        Left = 735
        Top = 58
        Width = 70
        Height = 21
        Alignment = taRightJustify
        Color = cl3DLight
        Enabled = False
        TabOrder = 19
      end
      object edtDescricao: TEdit
        Tag = 1
        Left = 185
        Top = 128
        Width = 334
        Height = 21
        TabOrder = 4
        Text = 'edtDescricao'
      end
      object dtPagamento: TDateTimePicker
        Tag = 1
        Left = 185
        Top = 191
        Width = 90
        Height = 21
        Date = 43867.433759675930000000
        Time = 43867.433759675930000000
        TabOrder = 8
      end
      object dtProtocolo: TDateTimePicker
        Tag = 1
        Left = 431
        Top = 188
        Width = 90
        Height = 21
        Date = 43867.433759675930000000
        Time = 43867.433759675930000000
        TabOrder = 10
      end
      object dtEmissao: TDateTimePicker
        Tag = 1
        Left = 310
        Top = 191
        Width = 90
        Height = 21
        Date = 43867.433759675930000000
        Time = 43867.433759675930000000
        TabOrder = 9
      end
      object edtParcela: TEdit
        Tag = 1
        Left = 25
        Top = 191
        Width = 121
        Height = 21
        TabOrder = 7
        Text = 'edtParcela'
      end
      object edtStatus: TEdit
        Left = 25
        Top = 250
        Width = 250
        Height = 21
        Color = 16776176
        Enabled = False
        TabOrder = 20
        Text = 'edtStatus'
      end
      object edtValorAntecipado: TEvNumEdit
        Left = 398
        Top = 247
        Width = 121
        Height = 21
        Color = 16776176
        Enabled = False
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clHotLight
        Font.Height = -11
        Font.Name = 'Tahoma'
        Font.Style = []
        Glyph.Data = {
          7E050000424D7E0500000000000036000000280000001A0000000D0000000100
          2000000000004805000000000000000000000000000000000000FF00FF00FF00
          FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
          FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
          FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
          FF00FF00FF00FF00FF009A6A39009767360093643400906131008C5E2F00895B
          2C0085582A00825527007F522500FF00FF00FF00FF00FF00FF00FF00FF008585
          8500828282007F7F7F007D7D7D007A7A7A007777770075757500727272006F6F
          6F00FF00FF00FF00FF00FF00FF00FF00FF009F6E3C00E3947600DC8B6A00D682
          5E00D07A5300CB724900C66B3F00C66B3F0082552700FF00FF00FF00FF00FF00
          FF00FF00FF0089898900B1B1B100A9A9A900A1A1A10099999900929292008B8B
          8B008B8B8B0072727200FF00FF00FF00FF00FF00FF00FF00FF00A2713E00FFFF
          FF00D0A08000FFFFFF00D0A08000FFFFFF00D0A08000E9D7C30085582A00FF00
          FF00FF00FF00FF00FF00FF00FF008B8B8B00FFFFFF00B7B7B700FFFFFF00B7B7
          B700FFFFFF00B7B7B700E0E0E00075757500FF00FF00FF00FF00FF00FF00FF00
          FF00A5734000E3947600DC8B6A00D6825E00D07A5300CB724900C66B3F00C66B
          3F00895B2C00FF00FF00FF00FF00FF00FF00FF00FF008D8D8D00B1B1B100A9A9
          A900A1A1A10099999900929292008B8B8B008B8B8B0077777700FF00FF00FF00
          FF00FF00FF00FF00FF00A8764200FFFFFF00D0A08000FFFFFF00D0A08000FFFF
          FF00D0A08000E9D7C3008C5E2F00FF00FF00FF00FF00FF00FF00FF00FF008F8F
          8F00FFFFFF00B7B7B700FFFFFF00B7B7B700FFFFFF00B7B7B700E0E0E0007A7A
          7A00FF00FF00FF00FF00FF00FF00FF00FF00AB794400E3947600DC8B6A00D682
          5E00D07A5300CB724900C66B3F00C66B3F0090613100FF00FF00FF00FF00FF00
          FF00FF00FF0092929200B1B1B100A9A9A900A1A1A10099999900929292008B8B
          8B008B8B8B007D7D7D00FF00FF00FF00FF00FF00FF00FF00FF00AE7B4600FFFF
          FF00D0A08000FFFFFF00D0A08000FFFFFF00D0A08000E9D7C30093643400FF00
          FF00FF00FF00FF00FF00FF00FF0093939300FFFFFF00B7B7B700FFFFFF00B7B7
          B700FFFFFF00B7B7B700E0E0E0007F7F7F00FF00FF00FF00FF00FF00FF00FF00
          FF00B17E4800E3947600DC8B6A00D6825E00D07A5300CB724900C66B3F00C66B
          3F0097673600FF00FF00FF00FF00FF00FF00FF00FF0096969600B1B1B100A9A9
          A900A1A1A10099999900929292008B8B8B008B8B8B0082828200FF00FF00FF00
          FF00FF00FF00FF00FF00B4814A00FFF9F900FFF3F300FFEDED00FFE7E700FFDC
          DC00FFD0D000FFD0D0009A6A3900FF00FF00FF00FF00FF00FF00FF00FF009999
          9900FBFBFB00F8F8F800F4F4F400F0F0F000E9E9E900E2E2E200E2E2E2008585
          8500FF00FF00FF00FF00FF00FF00FF00FF00B9854E00FFFFFF00FFF9F900FFF3
          F300FFEDED00FFE7E700FFDCDC00FFDCDC009F6E3C00FF00FF00FF00FF00FF00
          FF00FF00FF009C9C9C00FFFFFF00FBFBFB00F8F8F800F4F4F400F0F0F000E9E9
          E900E9E9E90089898900FF00FF00FF00FF00FF00FF00FF00FF00BC875000B985
          4E00B4814A00B17E4800AE7B4600AB794400A8764200A5734000A2713E00FF00
          FF00FF00FF00FF00FF00FF00FF009E9E9E009C9C9C0099999900969696009393
          9300929292008F8F8F008D8D8D008B8B8B00FF00FF00FF00FF00FF00FF00FF00
          FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
          FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
          FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
          FF00}
        ParentFont = False
        TabOrder = 21
      end
    end
    object tbComplemento: TcxTabSheet
      Caption = 'Complementar'
      ImageIndex = 1
    end
    object tbNotaFiscal: TcxTabSheet
      Caption = 'Nota Fiscal'
      ImageIndex = 2
    end
    object tbRateioHistoricos: TcxTabSheet
      Caption = 'Rateio cont'#225'bil'
      ImageIndex = 3
    end
    object tbRateioCentroCusto: TcxTabSheet
      Caption = 'Rateio Centro de Custos'
      ImageIndex = 4
    end
  end
  object edtValor: TEvNumEdit
    Tag = 1
    Left = 25
    Top = 277
    Width = 121
    Height = 21
    Glyph.Data = {
      7E050000424D7E0500000000000036000000280000001A0000000D0000000100
      2000000000004805000000000000000000000000000000000000FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF009A6A39009767360093643400906131008C5E2F00895B
      2C0085582A00825527007F522500FF00FF00FF00FF00FF00FF00FF00FF008585
      8500828282007F7F7F007D7D7D007A7A7A007777770075757500727272006F6F
      6F00FF00FF00FF00FF00FF00FF00FF00FF009F6E3C00E3947600DC8B6A00D682
      5E00D07A5300CB724900C66B3F00C66B3F0082552700FF00FF00FF00FF00FF00
      FF00FF00FF0089898900B1B1B100A9A9A900A1A1A10099999900929292008B8B
      8B008B8B8B0072727200FF00FF00FF00FF00FF00FF00FF00FF00A2713E00FFFF
      FF00D0A08000FFFFFF00D0A08000FFFFFF00D0A08000E9D7C30085582A00FF00
      FF00FF00FF00FF00FF00FF00FF008B8B8B00FFFFFF00B7B7B700FFFFFF00B7B7
      B700FFFFFF00B7B7B700E0E0E00075757500FF00FF00FF00FF00FF00FF00FF00
      FF00A5734000E3947600DC8B6A00D6825E00D07A5300CB724900C66B3F00C66B
      3F00895B2C00FF00FF00FF00FF00FF00FF00FF00FF008D8D8D00B1B1B100A9A9
      A900A1A1A10099999900929292008B8B8B008B8B8B0077777700FF00FF00FF00
      FF00FF00FF00FF00FF00A8764200FFFFFF00D0A08000FFFFFF00D0A08000FFFF
      FF00D0A08000E9D7C3008C5E2F00FF00FF00FF00FF00FF00FF00FF00FF008F8F
      8F00FFFFFF00B7B7B700FFFFFF00B7B7B700FFFFFF00B7B7B700E0E0E0007A7A
      7A00FF00FF00FF00FF00FF00FF00FF00FF00AB794400E3947600DC8B6A00D682
      5E00D07A5300CB724900C66B3F00C66B3F0090613100FF00FF00FF00FF00FF00
      FF00FF00FF0092929200B1B1B100A9A9A900A1A1A10099999900929292008B8B
      8B008B8B8B007D7D7D00FF00FF00FF00FF00FF00FF00FF00FF00AE7B4600FFFF
      FF00D0A08000FFFFFF00D0A08000FFFFFF00D0A08000E9D7C30093643400FF00
      FF00FF00FF00FF00FF00FF00FF0093939300FFFFFF00B7B7B700FFFFFF00B7B7
      B700FFFFFF00B7B7B700E0E0E0007F7F7F00FF00FF00FF00FF00FF00FF00FF00
      FF00B17E4800E3947600DC8B6A00D6825E00D07A5300CB724900C66B3F00C66B
      3F0097673600FF00FF00FF00FF00FF00FF00FF00FF0096969600B1B1B100A9A9
      A900A1A1A10099999900929292008B8B8B008B8B8B0082828200FF00FF00FF00
      FF00FF00FF00FF00FF00B4814A00FFF9F900FFF3F300FFEDED00FFE7E700FFDC
      DC00FFD0D000FFD0D0009A6A3900FF00FF00FF00FF00FF00FF00FF00FF009999
      9900FBFBFB00F8F8F800F4F4F400F0F0F000E9E9E900E2E2E200E2E2E2008585
      8500FF00FF00FF00FF00FF00FF00FF00FF00B9854E00FFFFFF00FFF9F900FFF3
      F300FFEDED00FFE7E700FFDCDC00FFDCDC009F6E3C00FF00FF00FF00FF00FF00
      FF00FF00FF009C9C9C00FFFFFF00FBFBFB00F8F8F800F4F4F400F0F0F000E9E9
      E900E9E9E90089898900FF00FF00FF00FF00FF00FF00FF00FF00BC875000B985
      4E00B4814A00B17E4800AE7B4600AB794400A8764200A5734000A2713E00FF00
      FF00FF00FF00FF00FF00FF00FF009E9E9E009C9C9C0099999900969696009393
      9300929292008F8F8F008D8D8D008B8B8B00FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
      FF00}
    TabOrder = 3
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
    Left = 760
    Top = 56
    PixelsPerInch = 96
    object dxBarManager1Bar1: TdxBar
      Caption = 'Novo'
      CaptionButtons = <>
      DockedLeft = 0
      DockedTop = 0
      FloatLeft = 946
      FloatTop = 8
      FloatClientWidth = 0
      FloatClientHeight = 0
      ItemLinks = <
        item
          Visible = True
          ItemName = 'dxBtnNew'
        end>
      OneOnRow = False
      Row = 3
      UseOwnFont = False
      Visible = True
      WholeRow = False
    end
    object dxBarManager1Bar2: TdxBar
      Caption = 'Editar'
      CaptionButtons = <>
      DockedLeft = 54
      DockedTop = 0
      FloatLeft = 946
      FloatTop = 8
      FloatClientWidth = 0
      FloatClientHeight = 0
      ItemLinks = <
        item
          Visible = True
          ItemName = 'dxBtnEdit'
        end>
      OneOnRow = False
      Row = 3
      UseOwnFont = False
      Visible = True
      WholeRow = False
    end
    object dxBarManager1Bar3: TdxBar
      Caption = 'Salvar'
      CaptionButtons = <>
      DockedLeft = 109
      DockedTop = 0
      FloatLeft = 946
      FloatTop = 8
      FloatClientWidth = 0
      FloatClientHeight = 0
      ItemLinks = <
        item
          Visible = True
          ItemName = 'dxBtnSave'
        end>
      OneOnRow = False
      Row = 3
      UseOwnFont = False
      Visible = True
      WholeRow = False
    end
    object dxBarManager1Bar4: TdxBar
      Caption = 'Excluir'
      CaptionButtons = <>
      DockedLeft = 220
      DockedTop = 0
      FloatLeft = 946
      FloatTop = 8
      FloatClientWidth = 0
      FloatClientHeight = 0
      ItemLinks = <
        item
          Visible = True
          ItemName = 'dxBtnDelet'
        end>
      OneOnRow = False
      Row = 3
      UseOwnFont = False
      Visible = True
      WholeRow = False
    end
    object dxBarManager1Bar6: TdxBar
      Caption = 'Limpar'
      CaptionButtons = <>
      DockedLeft = 414
      DockedTop = 0
      FloatLeft = 946
      FloatTop = 8
      FloatClientWidth = 0
      FloatClientHeight = 0
      ItemLinks = <
        item
          Visible = True
          ItemName = 'dxBtnLimpar'
        end>
      OneOnRow = False
      Row = 3
      UseOwnFont = False
      Visible = True
      WholeRow = False
    end
    object dxBarManager1Bar7: TdxBar
      Caption = 'Sair'
      CaptionButtons = <>
      DockedLeft = 476
      DockedTop = 0
      FloatLeft = 946
      FloatTop = 8
      FloatClientWidth = 0
      FloatClientHeight = 0
      ItemLinks = <
        item
          Visible = True
          ItemName = 'dxBarBtnSair'
        end>
      OneOnRow = False
      Row = 3
      UseOwnFont = False
      Visible = True
      WholeRow = False
    end
    object dxBarManager1Bar5: TdxBar
      Caption = 'Baixar'
      CaptionButtons = <>
      DockedLeft = 165
      DockedTop = 0
      FloatLeft = 946
      FloatTop = 8
      FloatClientWidth = 0
      FloatClientHeight = 0
      ItemLinks = <
        item
          Visible = True
          ItemName = 'dxBtnPagar'
        end>
      OneOnRow = True
      Row = 2
      UseOwnFont = False
      Visible = True
      WholeRow = False
    end
    object dxBarManager1Bar8: TdxBar
      Caption = 'Recibo'
      CaptionButtons = <>
      DockedLeft = 282
      DockedTop = 0
      FloatLeft = 946
      FloatTop = 8
      FloatClientWidth = 0
      FloatClientHeight = 0
      ItemLinks = <
        item
          Visible = True
          ItemName = 'dxBtnRecibo'
        end>
      OneOnRow = True
      Row = 1
      UseOwnFont = False
      Visible = True
      WholeRow = False
    end
    object dxBarManager1Bar9: TdxBar
      Caption = 'Espelho'
      CaptionButtons = <>
      DockedLeft = 343
      DockedTop = 0
      FloatLeft = 946
      FloatTop = 8
      FloatClientWidth = 0
      FloatClientHeight = 0
      ItemLinks = <
        item
          Visible = True
          ItemName = 'dxBtnEspelho'
        end>
      OneOnRow = True
      Row = 0
      UseOwnFont = False
      Visible = True
      WholeRow = False
    end
    object dxBarBtnSair: TdxBarLargeButton
      Caption = 'Fechar'
      Category = 0
      Hint = 'Fechar'
      Visible = ivAlways
      OnClick = dxBarBtnSairClick
    end
    object dxBtnLimpar: TdxBarLargeButton
      Caption = 'Limpar'
      Category = 0
      Hint = 'Limpar'
      Visible = ivAlways
      OnClick = dxBtnLimparClick
    end
    object dxBtnNew: TdxBarLargeButton
      Caption = 'Novo'
      Category = 0
      Hint = 'Novo'
      Visible = ivAlways
      OnClick = dxBtnNewClick
    end
    object dxBtnEdit: TdxBarLargeButton
      Caption = 'Editar'
      Category = 0
      Hint = 'Editar'
      Visible = ivAlways
    end
    object dxBtnSave: TdxBarLargeButton
      Caption = 'Salvar'
      Category = 0
      Hint = 'Salvar'
      Visible = ivAlways
    end
    object dxBtnDelet: TdxBarLargeButton
      Caption = 'Deletar'
      Category = 0
      Hint = 'Deletar'
      Visible = ivAlways
    end
    object dxBarLargeButton5: TdxBarLargeButton
      Caption = 'New Button'
      Category = 0
      Hint = 'New Button'
      Visible = ivAlways
    end
    object dxBtnPagar: TdxBarLargeButton
      Caption = 'Pagar'
      Category = 0
      Hint = 'Pagar'
      Visible = ivAlways
    end
    object dxBtnRecibo: TdxBarLargeButton
      Caption = 'Emitir Recibo'
      Category = 0
      Hint = 'Emitir Recibo'
      Visible = ivAlways
    end
    object dxBtnEspelho: TdxBarLargeButton
      Caption = 'Imprimir Espelho'
      Category = 0
      Hint = 'Imprimir Espelho'
      Visible = ivAlways
    end
  end
end