object dmConexao: TdmConexao
  OldCreateOrder = False
  Height = 412
  Width = 510
  object Conn: TFDConnection
    Params.Strings = (
      'User_Name=sysdba'
      'Password=masterkey'
      'Protocol=TCPIP'
      'Server=127.0.0.1'
      'Port=3050'
      'Database=D:\Clientes\Imap\FINANCE.FDB'
      'DriverID=FB')
    FetchOptions.AssignedValues = [evMode, evRowsetSize, evCursorKind, evDetailDelay]
    FormatOptions.AssignedValues = [fvDefaultParamDataType, fvFmtDisplayDateTime, fvFmtDisplayDate, fvFmtDisplayTime, fvFmtDisplayNumeric, fvFmtEditNumeric]
    FormatOptions.FmtDisplayDateTime = 'DD/MM/YYY hh:mm:ss'
    FormatOptions.FmtDisplayDate = 'DD/MM/YYY'
    FormatOptions.FmtDisplayTime = 'hh:mm:ss'
    FormatOptions.FmtDisplayNumeric = '###,##0.00'
    FormatOptions.FmtEditNumeric = '###,##0.00'
    ResourceOptions.AssignedValues = [rvCmdExecMode, rvAutoReconnect]
    ResourceOptions.AutoReconnect = True
    UpdateOptions.AssignedValues = [uvRefreshMode]
    LoginPrompt = False
    Left = 40
    Top = 40
  end
  object FDGUIxErrorDialog1: TFDGUIxErrorDialog
    Provider = 'Forms'
    Left = 264
    Top = 336
  end
  object FDGUIxWaitCursor1: TFDGUIxWaitCursor
    Provider = 'Forms'
    ScreenCursor = gcrHourGlass
    Left = 160
    Top = 336
  end
  object FDPhysFBDriverLink1: TFDPhysFBDriverLink
    Left = 48
    Top = 336
  end
  object ConnMega: TFDConnection
    Params.Strings = (
      'User_Name=sysdba'
      'Password=masterkey'
      'Database=D:\Clientes\MEGA\MEGA.FDB'
      'Protocol=127.0.0.1'
      'Port=3050'
      'DriverID=FB')
    FetchOptions.AssignedValues = [evMode, evDetailDelay]
    FormatOptions.AssignedValues = [fvFmtDisplayDate, fvFmtDisplayNumeric, fvFmtEditNumeric]
    ResourceOptions.AssignedValues = [rvCmdExecMode, rvAutoReconnect]
    ResourceOptions.AutoReconnect = True
    LoginPrompt = False
    Left = 168
    Top = 40
  end
  object qryEstacoesConectadas: TFDQuery
    Connection = Conn
    SQL.Strings = (
      'SELECT DISTINCT'
      '  MA.MON$ATTACHMENT_ID AS ID,'
      '  MA.MON$REMOTE_PROTOCOL AS PROTOCOLO,'
      '  MA.MON$REMOTE_ADDRESS AS ENDERECO,'
      '  MA.MON$REMOTE_PROCESS AS PROCESSO'
      'FROM'
      '  MON$ATTACHMENTS MA'
      'WHERE'
      '  (MA.MON$ATTACHMENT_ID <> CURRENT_CONNECTION)'
      '')
    Left = 296
    Top = 40
  end
  object qryObterGUID: TFDQuery
    Connection = Conn
    SQL.Strings = (
      'select createguid() as newID from rdb$database')
    Left = 32
    Top = 112
  end
end
