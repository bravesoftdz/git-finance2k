object frmBaixaTRFPInternet: TfrmBaixaTRFPInternet
  Left = 0
  Top = 0
  Caption = 'Recebimento de t'#237'tulo por Bank Line'
  ClientHeight = 318
  ClientWidth = 634
  Color = 10930928
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  Position = poOwnerFormCenter
  OnClose = FormClose
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 13
  object lbl1: TLabel
    Left = 300
    Top = 32
    Width = 24
    Height = 13
    Caption = 'Valor'
  end
  object lbl2: TLabel
    Left = 439
    Top = 32
    Width = 23
    Height = 13
    Caption = 'Data'
  end
  object lbl3: TLabel
    Left = 55
    Top = 148
    Width = 54
    Height = 13
    Caption = 'Correntista'
  end
  object lbl4: TLabel
    Left = 55
    Top = 93
    Width = 67
    Height = 13
    Caption = 'Banco destino'
  end
  object lbl5: TLabel
    Left = 300
    Top = 93
    Width = 38
    Height = 13
    Caption = 'Ag'#234'ncia'
  end
  object lbl6: TLabel
    Left = 439
    Top = 93
    Width = 29
    Height = 13
    Caption = 'Conta'
  end
  object lbl7: TLabel
    Left = 439
    Top = 148
    Width = 67
    Height = 13
    Caption = 'Personalidade'
  end
  object lblCPFCNPJ: TLabel
    Left = 439
    Top = 203
    Width = 19
    Height = 13
    Caption = 'CPF'
  end
  object lbl8: TLabel
    Left = 55
    Top = 203
    Width = 67
    Height = 13
    Caption = 'Detalhamento'
  end
  inline frmContaBancaria1: TfrmContaBancaria
    Left = 39
    Top = 32
    Width = 233
    Height = 45
    TabOrder = 0
    ExplicitLeft = 39
    ExplicitTop = 32
    ExplicitWidth = 233
    ExplicitHeight = 45
    inherited cbbConta: TComboBox
      OnChange = frmContaBancaria1cbbContaChange
    end
    inherited qryObterTodos: TFDQuery
      Left = 136
      Top = 24
    end
    inherited qryObterContaContabil: TFDQuery
      Left = 40
      Top = 24
    end
  end
  object edtValor: TEvNumEdit
    Left = 300
    Top = 51
    Width = 108
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
    TabOrder = 1
  end
  object dtpEmissao: TDateTimePicker
    Left = 439
    Top = 51
    Width = 127
    Height = 21
    Date = 43839.750266064820000000
    Time = 43839.750266064820000000
    TabOrder = 2
  end
  object edtPortador: TEdit
    Left = 55
    Top = 172
    Width = 353
    Height = 21
    TabOrder = 3
    Text = 'edtPortador'
  end
  object btnConfirmaCh: TButton
    Left = 193
    Top = 266
    Width = 100
    Height = 33
    Caption = 'Confirmar'
    TabOrder = 4
    OnClick = btnConfirmaChClick
  end
  object btnCancelar: TButton
    Left = 308
    Top = 266
    Width = 100
    Height = 33
    Caption = 'Cancelar'
    TabOrder = 5
    OnClick = btnCancelarClick
  end
  inline frmBanco1: TfrmBanco
    Left = 39
    Top = 110
    Width = 233
    Height = 35
    TabOrder = 6
    ExplicitLeft = 39
    ExplicitTop = 110
    ExplicitWidth = 233
    inherited cbbBanco: TComboBox
      Left = 16
      Width = 206
      OnChange = frmBanco1cbbBancoChange
      ExplicitLeft = 16
      ExplicitWidth = 206
    end
  end
  object edtAgencia: TEdit
    Left = 302
    Top = 113
    Width = 106
    Height = 21
    TabOrder = 7
    Text = 'edtAgencia'
  end
  object edtConta: TEdit
    Left = 439
    Top = 113
    Width = 127
    Height = 21
    TabOrder = 8
    Text = 'edtAgencia'
  end
  object cbbPersonalidade: TComboBox
    Tag = 1
    Left = 439
    Top = 172
    Width = 127
    Height = 21
    Color = 12891332
    TabOrder = 9
    Text = 'cbbPersonalidade'
    OnChange = cbbPersonalidadeChange
    Items.Strings = (
      '<<Selecione>>'
      'P F'
      'P J')
  end
  object edtCNPJCPF: TEdit
    Tag = 1
    Left = 439
    Top = 228
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
    TabOrder = 10
  end
  object edtDetalhamento: TEdit
    Left = 55
    Top = 228
    Width = 353
    Height = 21
    TabOrder = 11
    Text = 'edtPortador'
  end
end
