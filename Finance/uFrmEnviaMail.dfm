object frmEnviaMail: TfrmEnviaMail
  Left = 0
  Top = 0
  Caption = 'Envio de e-mail'
  ClientHeight = 594
  ClientWidth = 610
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
  object Label1: TLabel
    Left = 59
    Top = 171
    Width = 34
    Height = 16
    Caption = 'Para '
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -13
    Font.Name = 'Tahoma'
    Font.Style = [fsBold]
    ParentFont = False
  end
  object lblCC: TLabel
    Left = 58
    Top = 209
    Width = 35
    Height = 16
    Caption = 'C'#243'pia'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -13
    Font.Name = 'Tahoma'
    Font.Style = [fsBold]
    ParentFont = False
    Visible = False
  end
  object Label2: TLabel
    Left = 24
    Top = 361
    Width = 69
    Height = 16
    Caption = 'Mensagem'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -13
    Font.Name = 'Tahoma'
    Font.Style = [fsBold]
    ParentFont = False
  end
  object Label3: TLabel
    Left = 52
    Top = 513
    Width = 41
    Height = 16
    Caption = 'Anexo'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -13
    Font.Name = 'Tahoma'
    Font.Style = [fsBold]
    ParentFont = False
  end
  object Label4: TLabel
    Left = 39
    Top = 265
    Width = 54
    Height = 16
    Caption = 'Assunto'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -13
    Font.Name = 'Tahoma'
    Font.Style = [fsBold]
    ParentFont = False
  end
  object dxRibbon1: TdxRibbon
    Left = 0
    Top = 0
    Width = 610
    Height = 125
    BarManager = dxBarManager1
    ColorSchemeName = 'UserSkin'
    Contexts = <>
    TabOrder = 4
    TabStop = False
    object dxRibbon1Tab1: TdxRibbonTab
      Active = True
      Caption = 'Cliente de e-mail'
      Groups = <
        item
          ToolbarName = 'dxBarManager1Bar1'
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
    Width = 610
    Height = 20
    Panels = <
      item
        PanelStyleClassName = 'TdxStatusBarTextPanelStyle'
        PanelStyle.Alignment = taCenter
        Width = 60
      end
      item
        PanelStyleClassName = 'TdxStatusBarTextPanelStyle'
        Width = 60
      end
      item
        PanelStyleClassName = 'TdxStatusBarTextPanelStyle'
        Width = 60
      end
      item
        PanelStyleClassName = 'TdxStatusBarTextPanelStyle'
        Width = 60
      end>
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'Tahoma'
    Font.Style = []
  end
  object edtDestino: TEdit
    Left = 106
    Top = 170
    Width = 329
    Height = 21
    TabOrder = 0
  end
  object edtDestinoCopia: TEdit
    Left = 106
    Top = 208
    Width = 329
    Height = 21
    TabOrder = 6
    OnExit = edtDestinoCopiaExit
  end
  object btnCC: TBitBtn
    Left = 467
    Top = 168
    Width = 49
    Height = 25
    Hint = 'Coloca mensagem em c'#243'pa'
    Caption = '+'
    Glyph.Data = {
      36040000424D3604000000000000360000002800000010000000100000000100
      2000000000000004000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00020000000D000000180000000E000000030000000000000000000000010000
      0004000000070000000A0000000B0000000D0000000D00000010000000160000
      0021271713826D4034FF1E110E810000001B0000000D00000004000000040E38
      297E134F37B414593DD212583BDB126441FF105D3DFF0C462DDD444A39EC5648
      3BED8B6758FDCABAB2FF5C3529FB3B241BC22A1813930000000D00000006278A
      63FF3BAA82FF2FA377FF2B9E73FF2A9E72FF25986AFF1D825BFF7B6F5DFFD5C6
      C0FFE2D8D4FFE0D5CFFFE1D7D4FFAE978EFF4E2F26D50000001000000004267B
      5BD555BB98FF63CDAAFF41BA8FFF33AE83FF30A97BFF2F9F76FF50896DFFAF91
      86FFF1ECE8FF825747FFE5DCD5FF89665AFF1E130F6C0000000C000000010511
      0D201D5D459F339774F85BC2A1FF43B48CFF3EAF87FF45AA87FF867C6AFEDBCC
      C7FFE9E0DDFFFFFFFFFFDDD1CAFFD6C7C1FF603F34D20000000D000000000000
      000100000003040D0A212A705BDA3B7289FF336981FF236E57F9576E5AF97676
      64FFA68574FFEDE5E2FFA48273FE706456E13D2B248400000008000000000000
      00000000000000000013345978DB7DA4CDFF588BC1FF285A7BFF379373FF389D
      79FF558C70FFB08C7DFF52856AFF155D43FD0101011600000001000000000000
      0000000000020203041F5379ACF9BDE0F5FF8BC2EBFF335D97FF4DA489FF49B5
      8FFF4BB18EFF51AA8EFF308567FF144E39C10101010B00000000000000000000
      00000000000517335FC05C80B0FFCAE8F6FF94C6E9FF375D95FF38657FFF77C3
      ADFF6DBEA4FF276B56D70F2A21670101010D0000000200000000000000000000
      000000000006205090F64F7CB1FF517CAFFF2C5088FF325D98FF1B3D77FF355A
      90FF30607BF60A0B0B2E01010107000000010000000000000000000000000000
      000000000003255A9AE66C9DD0FE5C8CC1FF76A5D3FF5385BEFF1F4683FF74B5
      EBFF4374AFFF1621326E0303030A000000000000000000000000000000000000
      0000000000010C1F3249255B92C22E6EB0E62F72B8FA2B5D9BF36990BAFF8BC7
      F2FF5A8EC4FF20385EC205050511000000000000000000000000000000000000
      00000000000000000001000000020000000304040410264F88FA82A5C8FF497A
      ACFF38669DFF1C447AFB06060716000000000000000000000000000000000000
      00000000000000000000000000000000000002020207285795F54577B1FE5F95
      CFFF4C85C5FF24528FFF05080B1A000000000000000000000000000000000000
      0000000000000000000000000000000000000101010211253D61295892D62F68
      AAF726568DD81328437301010103000000000000000000000000}
    TabOrder = 3
    OnClick = btnCCClick
  end
  object memo: TMemo
    Left = 106
    Top = 307
    Width = 329
    Height = 158
    Lines.Strings = (
      '')
    TabOrder = 1
  end
  object edtAnexo: TEdit
    Left = 106
    Top = 512
    Width = 329
    Height = 21
    TabOrder = 2
  end
  object btnAnexo: TBitBtn
    Left = 467
    Top = 510
    Width = 49
    Height = 25
    Caption = 'Anexo'
    TabOrder = 7
    OnClick = btnAnexoClick
  end
  object edtAssunto: TEdit
    Left = 106
    Top = 260
    Width = 329
    Height = 21
    TabOrder = 8
  end
  object btnNetOFF: TBitBtn
    Left = 8
    Top = 131
    Width = 25
    Height = 25
    Caption = ' '
    Glyph.Data = {
      36040000424D3604000000000000360000002800000010000000100000000100
      2000000000000004000000000000000000000000000000000000000000000000
      00000000000000000001000000070000000D0000001100000012000000110000
      000D000000070000000100000000000000000000000000000000000000000000
      0001000000040000000D09053B6915097EC2190CA4EF1D0CB2FF180BA3EF1408
      7EC209043A6A0000000E00000004000000010000000000000000000000010000
      000503020F27170E7CBC201AC3FF1D2CE3FF1B34F4FF1B35FBFF1A31F4FF1B27
      E3FF1C16C1FF150A7ABD02010F29000000050000000100000000000000040504
      1A352319ABEB242EDCFF223FFBFF203DFCFF1F3CFBFF1F3AFBFF1E3AFBFF1D3A
      FAFF1D36F8FF1E27DAFF1E12A7EC0302112B000000040000000001000210231A
      9BD72B38E3FF2A47FDFF2744FDFF2642FCFF2542FBFF2441FBFF2341FCFF2240
      FBFF213EFBFF213BFBFF212DE1FF190F7EBB0000000D00000001120F476C3332
      D1FF2F4CFEFF2E4DFDFF2E4BFDFF2C49FCFF2C48FCFF2A48FDFF2A47FDFF2946
      FCFF2543FCFF2542FBFF2441FBFF2928CBFF0E0940690000000525218DBD3949
      EBFF3552FDFF3553FFFF3350FFFF324FFEFF304DFEFF2F4CFEFF2E4BFDFF2D4A
      FDFF2D48FCFF2C48FCFF2B45FDFF2D3BE7FF1F1887BF0000000A362FBCED3C55
      FAFF3C57FFFF3958FFFF3755FEFF3755FEFF3653FEFF3553FFFF3451FFFF3350
      FFFF324FFFFF304DFEFF2F4CFEFF2F48F7FF2C25B2EB0000000B3F3BD1FF4561
      FEFF415EFFFF405EFFFF3E5CFFFF3D5AFFFF3C5AFFFF3A57FFFF3A57FFFF3956
      FEFF3855FFFF3653FEFF3552FDFF3753FEFF342FC3FA0000000B3E3DC2EC526C
      FAFF4664FFFF4663FFFF4561FFFF4361FFFF415EFFFF415EFFFF405DFFFF3E5B
      FFFF3D5AFFFF3C59FFFF3A57FFFF435EFAFF3630BAEA0000000A333499BA5A6D
      F1FF4D6AFFFF4C68FFFF4B67FFFF4A66FFFF4965FFFF4764FFFF4563FFFF4561
      FFFF4360FFFF425FFFFF405EFFFF5060EFFF2E2B93BC000000071B1B4E62555C
      E5FF5F7BFFFF506DFFFF4F6DFFFF4E6AFFFF4E68FFFF4C69FFFF4B68FFFF4A68
      FFFF4A66FFFF4866FFFF5571FFFF4E52E0FF1817496200000003010103094042
      B3D06474F1FF6480FFFF5472FFFF526FFFFF526EFFFF526EFFFF516EFFFF4F6D
      FFFF4F6BFFFF5D79FFFF5D6DF0FF323294B50000000700000001000000010C0C
      202A4C51CEEA6372F0FF708BFEFF607DFFFF5976FFFF5572FFFF5873FFFF5D7A
      FFFF6B85FEFF606DEEFF474AC9E9070715200000000200000000000000000000
      00010707131B3B3D9CB25D64E9FF6C80F6FF758CFCFF7791FFFF738CFCFF6B7E
      F6FF5960E7FF383A9AB30707131C000000020000000000000000000000000000
      000000000001000000031A1B44503335889B4548B5CC5559E1F94447B4CC3235
      879B191A43510000000400000001000000000000000000000000}
    TabOrder = 9
  end
  object btnNetON: TBitBtn
    Left = 578
    Top = 131
    Width = 25
    Height = 25
    Glyph.Data = {
      36040000424D3604000000000000360000002800000010000000100000000100
      2000000000000004000000000000000000000000000000000000000000000000
      00000000000000000001000000070000000D0000001100000012000000110000
      000D000000070000000100000000000000000000000000000000000000000000
      0001000000040000000D0E241B691E4D39C226644AEF296D51FF256449EF1D4D
      38C20D241A6A0000000E00000004000000010000000000000000000000010000
      0005040907271D4D3ABC328063FF46AC8BFF4EC19DFF51CAA5FF4DC19CFF43AB
      89FF317F61FF1D4A38BD04090729000000050000000100000000000000040610
      0C35296A52EB42A181FF51C9A4FF4DC8A2FF4AC7A0FF47C59FFF49C6A0FF4CC7
      A1FF4FC8A2FF3F9F7EFF29674EEC040A082B0000000400000000010101102560
      49D747AA8AFF53CBA7FF4DC8A3FF4BC8A1FF4AC7A1FF4AC7A1FF49C6A0FF49C6
      9FFF4AC7A1FF50C9A3FF43A686FF1E4D3ABB0000000D00000001122C216C3F8E
      72FF57CDAAFF4FCAA4FF4DC9A4FF4DC9A4FF4DC9A3FF4CC8A3FF4CC8A3FF4BC8
      A2FF4AC7A1FF4BC8A2FF51CAA6FF3C8B6EFF0F271E6900000005245743BD52B4
      95FF56CDA9FF50CBA7FF51CBA6FF50CBA5FF4FCAA5FF4FC9A5FF4EC9A5FF4EC9
      A4FF4DC8A3FF4CC8A3FF50CAA4FF4DB091FF215340BF0000000A2F745AED5CC9
      A9FF55CEAAFF53CDA9FF52CDA8FF52CCA8FF52CCA7FF51CBA7FF50CAA6FF4FCB
      A6FF4FCAA6FF4FCAA5FF50CBA5FF56C6A5FF2C6E55EB0000000B368165FF68D3
      B5FF56CEABFF56CEABFF55CDABFF55CDABFF54CDAAFF53CDAAFF53CCA8FF52CC
      A8FF51CCA8FF51CBA7FF51CAA7FF61CFB0FF317A5DFA0000000B34785FEC73D2
      B7FF59D0AEFF58CFADFF57CFADFF57CFADFF57CFABFF55CEACFF56CEABFF55CE
      ABFF54CDAAFF53CDA9FF54CEA9FF6DCFB2FF2F735AEA0000000A285F4BBA73C3
      ACFF60D2B2FF5AD0AFFF59D0AEFF59D0AEFF59D0AEFF58D0AEFF57CFACFF57CF
      ADFF56CEABFF56CEABFF5ACFADFF6FC0A8FF265B48BC0000000715302662539F
      86FF7DDDC4FF5DD3B2FF5BD2B0FF5BD2B0FF5BD1B0FF5AD1B0FF5AD0AFFF59D0
      AEFF59D0AEFF59D1ADFF79DAC0FF509C82FF132D236200000003010201092F6F
      59D077C2ACFF84DFC7FF60D3B4FF5DD2B2FF5DD3B2FF5DD2B1FF5CD2B1FF5CD1
      B0FF5DD2B1FF81DEC4FF74BFAAFF275C48B50000000700000001000000010914
      102A3B8269EA6FBAA3FF97E4D0FF78DCC1FF66D7B7FF5FD4B3FF65D6B6FF77DB
      BFFF94E3CFFF6DB8A2FF377D65E9060D0A200000000200000000000000000000
      0001050C091B2A604DB2509E84FF84CCB7FF9AE1CFFFA5EBDAFF9AE1CFFF82CC
      B7FF4F9D83FF295F4CB3050C091C000000020000000000000000000000000000
      00000000000100000003122A22502454439B31705ACC3D8B6FF931705ACC2454
      439B122A22510000000400000001000000000000000000000000}
    TabOrder = 10
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
    Left = 352
    Top = 72
    PixelsPerInch = 96
    object dxBarManager1Bar1: TdxBar
      Caption = 'Enviar'
      CaptionButtons = <>
      DockedLeft = 0
      DockedTop = 0
      FloatLeft = 669
      FloatTop = 8
      FloatClientWidth = 0
      FloatClientHeight = 0
      ItemLinks = <
        item
          Visible = True
          ItemName = 'dxBarBtnEnviar'
        end>
      OneOnRow = False
      Row = 0
      UseOwnFont = False
      Visible = True
      WholeRow = False
    end
    object dxBarManager1Bar3: TdxBar
      Caption = 'Fechar'
      CaptionButtons = <>
      DockedLeft = 57
      DockedTop = 0
      FloatLeft = 669
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
    object dxBarBtnEnviar: TdxBarLargeButton
      Caption = 'Enviar'
      Category = 0
      Hint = 'Enviar'
      Visible = ivAlways
      OnClick = dxBarBtnEnviarClick
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
    Left = 472
    Top = 72
  end
end