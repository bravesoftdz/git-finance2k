object frmExtratoBancario: TfrmExtratoBancario
  Left = 0
  Top = 0
  Caption = 'Emiss'#227'o de Extrato Banc'#225'rio'
  ClientHeight = 203
  ClientWidth = 879
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -16
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  Position = poDesktopCenter
  OnClose = FormClose
  OnCreate = FormCreate
  PixelsPerInch = 144
  TextHeight = 19
  inline frmContaBancaria1: TfrmContaBancaria
    Left = 400
    Top = 35
    Width = 243
    Height = 169
    TabOrder = 0
    ExplicitLeft = 400
    ExplicitTop = 35
    ExplicitHeight = 169
    inherited cbbConta: TComboBox
      Top = 25
      OnChange = frmContaBancaria1cbbContaChange
      ExplicitTop = 25
    end
    inherited qryObterTodos: TFDQuery
      Left = 144
      Top = 88
    end
    inherited qryObterContaContabil: TFDQuery
      Top = 88
    end
  end
  inline frmPeriodo1: TfrmPeriodo
    Left = 18
    Top = 32
    Width = 351
    Height = 97
    TabOrder = 1
    ExplicitLeft = 18
    ExplicitTop = 32
    ExplicitWidth = 351
    ExplicitHeight = 97
    inherited lbl1: TLabel
      Top = 3
      ExplicitTop = 3
    end
    inherited lbl2: TLabel
      Left = 186
      Top = 3
      ExplicitLeft = 186
      ExplicitTop = 3
    end
    inherited dtpDataInicial: TDateTimePicker
      Top = 28
      Width = 130
      Height = 30
      OnChange = frmPeriodo1dtpDataInicialChange
      ExplicitTop = 28
      ExplicitWidth = 130
      ExplicitHeight = 30
    end
    inherited dtpDataFinal: TDateTimePicker
      Left = 186
      Top = 28
      Width = 130
      Height = 30
      OnChange = frmPeriodo1dtpDataFinalChange
      ExplicitLeft = 186
      ExplicitTop = 28
      ExplicitWidth = 130
      ExplicitHeight = 30
    end
  end
  object btnImprimir: TButton
    Left = 664
    Top = 61
    Width = 150
    Height = 30
    Caption = 'Imprimir'
    TabOrder = 2
    OnClick = btnImprimirClick
  end
  object frxExtratoBancario: TfrxReport
    Version = '5.3.14'
    DataSet = frxExtrato
    DataSetName = 'EXTRATO'
    DotMatrixReport = False
    IniFile = '\Software\Fast Reports'
    PreviewOptions.Buttons = [pbPrint, pbLoad, pbSave, pbExport, pbZoom, pbFind, pbOutline, pbPageSetup, pbTools, pbEdit, pbNavigator, pbExportQuick]
    PreviewOptions.Zoom = 1.000000000000000000
    PrintOptions.Printer = 'Default'
    PrintOptions.PrintOnSheet = 0
    ReportOptions.CreateDate = 42573.413464710600000000
    ReportOptions.LastChange = 43761.866405787030000000
    ScriptLanguage = 'PascalScript'
    StoreInDFM = False
    Left = 64
    Top = 128
  end
  object frxPDFExport1: TfrxPDFExport
    UseFileCache = True
    ShowProgress = True
    OverwritePrompt = False
    DataOnly = False
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
    Left = 784
    Top = 128
  end
  object frxCSVExport1: TfrxCSVExport
    UseFileCache = True
    ShowProgress = True
    OverwritePrompt = False
    DataOnly = False
    Separator = ';'
    OEMCodepage = False
    UTF8 = False
    NoSysSymbols = True
    ForcedQuotes = False
    Left = 680
    Top = 128
  end
  object frxExtrato: TfrxDBDataset
    UserName = 'EXTRATO'
    CloseDataSource = False
    FieldAliases.Strings = (
      'DATA=DATA'
      'VALOR=VALOR'
      'DETALHAMENTO=DETALHAMENTO'
      'TIPO=TIPO')
    DataSet = dmExtratoBancario.qryExtrato
    BCDToCurrency = False
    Left = 208
    Top = 128
  end
end
