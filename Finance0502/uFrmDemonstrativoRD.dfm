object frmDemonstrativoRD: TfrmDemonstrativoRD
  Left = 0
  Top = 0
  Caption = 'Demonstrativo de Receitas e Despesas por Centro de Custos'
  ClientHeight = 586
  ClientWidth = 828
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
  object lbl1: TLabel
    Left = 8
    Top = 152
    Width = 176
    Height = 13
    Caption = 'RECEITAS POR CENTRO DE CUSTOS'
  end
  object lbl2: TLabel
    Left = 420
    Top = 152
    Width = 177
    Height = 13
    Caption = 'DESPESAS POR CENTRO DE CUSTOS'
  end
  inline frmPeriodo1: TfrmPeriodo
    Left = 8
    Top = 32
    Width = 281
    Height = 57
    TabOrder = 0
    ExplicitLeft = 8
    ExplicitTop = 32
    ExplicitWidth = 281
    ExplicitHeight = 57
    inherited lbl1: TLabel
      Top = 3
      ExplicitTop = 3
    end
    inherited lbl2: TLabel
      Top = 3
      ExplicitTop = 3
    end
    inherited dtpDataInicial: TDateTimePicker
      Top = 22
      ExplicitTop = 22
    end
    inherited dtpDataFinal: TDateTimePicker
      Top = 22
      ExplicitTop = 22
    end
  end
  object dbgrdReceitas: TDBGrid
    Left = 8
    Top = 184
    Width = 400
    Height = 377
    DataSource = dsReceitas
    TabOrder = 1
    TitleFont.Charset = DEFAULT_CHARSET
    TitleFont.Color = clWindowText
    TitleFont.Height = -11
    TitleFont.Name = 'Tahoma'
    TitleFont.Style = []
    Columns = <
      item
        Expanded = False
        FieldName = 'CENTRO_CUSTOS'
        Title.Caption = 'CENTRO DE CUSTOS'
        Width = 275
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'VALOR_RECEITA'
        Title.Caption = 'TOTAL DAS RECEITAS'
        Width = 90
        Visible = True
      end>
  end
  object dbgrdDespesas: TDBGrid
    Left = 420
    Top = 184
    Width = 400
    Height = 377
    DataSource = dsDespesas
    TabOrder = 2
    TitleFont.Charset = DEFAULT_CHARSET
    TitleFont.Color = clWindowText
    TitleFont.Height = -11
    TitleFont.Name = 'Tahoma'
    TitleFont.Style = []
    Columns = <
      item
        Expanded = False
        FieldName = 'CENTRO_CUSTOS'
        Title.Caption = 'CENTRO  DE CUSTOS'
        Width = 275
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'VALOR_DESPESA'
        Title.Caption = 'TOTAL DAS DESPESAS'
        Width = 90
        Visible = True
      end>
  end
  object btnConfirma: TButton
    Left = 316
    Top = 33
    Width = 141
    Height = 25
    Caption = 'Consultar'
    TabOrder = 3
    OnClick = btnConfirmaClick
  end
  object btnImprimir: TButton
    Left = 316
    Top = 64
    Width = 141
    Height = 25
    Caption = 'Imprimir'
    TabOrder = 4
    OnClick = btnImprimirClick
  end
  object edtValorDespesa: TEdit
    Left = 611
    Top = 145
    Width = 190
    Height = 24
    Alignment = taRightJustify
    Enabled = False
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clRed
    Font.Height = -13
    Font.Name = 'Tahoma'
    Font.Style = [fsBold]
    ParentFont = False
    TabOrder = 5
  end
  object edtValorReceita: TEdit
    Left = 200
    Top = 145
    Width = 190
    Height = 24
    Alignment = taRightJustify
    Enabled = False
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clBlue
    Font.Height = -13
    Font.Name = 'Tahoma'
    Font.Style = [fsBold]
    ParentFont = False
    TabOrder = 6
  end
  object btnFechar: TBitBtn
    Left = 316
    Top = 95
    Width = 141
    Height = 25
    Caption = 'Fechar'
    TabOrder = 7
    OnClick = btnFecharClick
  end
  object dsReceitas: TDataSource
    DataSet = dmRD.qryReceitas
    Left = 168
    Top = 352
  end
  object dsDespesas: TDataSource
    DataSet = dmRD.qryDespesas
    Left = 536
    Top = 344
  end
end
