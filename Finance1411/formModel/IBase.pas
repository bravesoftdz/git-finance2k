unit IBase;

interface

uses
   Vcl.Forms, Controls, SysUtils, Classes, SqlExpr, Variants, DB, ComObj,
   Util, ELibFnc, Constants,
   FireDAC.Comp.Client, Vcl.Dialogs, udmConexao,
   uVarGlobais
// , udmIBase
   ;

type
  {Tipo de parametro utilizado pelo m�todo Post da Interface ITable}
  TdsStatus = (dsInserir, dsAtualizar, dsExcluir);
  {O tipo de backup que o usu�rio ser� obrigado a tirar ap�s a utliza��o do
  m�todo Post da Interface ITable}
//  TTipoBackup = (bkNenhum, bkGeral, bkPessoa, bkAmbos);
  TTipoBackup = (bkNenhum, bkPessoa);

type
  EValidate = class(Exception);

  EImpFiscal = class(Exception);

  EAcessDeny = class(Exception);

  EDBException = class(Exception)
  private
//Roberto
    FoConn: TFDConnection;
  public
    constructor Create(const lcMsg: string; loConn: TFDConnection); virtual;
    property Conn: TFDConnection read FoConn;

    class function isPK(e: exception): boolean; // primary key constraint
    class function isFK(e: exception): boolean; // foreign key constraint
    class function isUK(e: exception): boolean; // unique constraint
    class function isCK(e: exception): boolean; // check constraint
    class function isNW(e: exception): boolean; // network erro
    class procedure RaiseDBError(e: exception; conn: TFDConnection);
  end;

  EPKException = class(EDBException);
  EFKException = class(EDBException);
  EUKException = class(EDBException);
  ECKException = class(EDBException);
  ENWException = class(EDBException);

  TField = class
  private
    FoValue: Variant;
    FcName : String;
    FoType : DB.TFieldType;
  protected
    function get_AsInteger: Integer;
    function get_AsFloat: Double;
    function get_AsDate: TDateTime;
    function get_AsString: String;
    function get_AsValue: Variant;
    function get_AsCurrency: Currency;
    function get_AsBoolean: Boolean;
    function get_AsSmallInt: SmallInt;
    function get_AsLongWord: Cardinal;
    function get_AsLargInt: Int64;

    procedure set_AsInteger(Value: Integer);
    procedure set_AsFloat(Value: Double);
    procedure set_AsDate(Value: TDateTime);
    procedure set_AsString(Value: String);
    procedure set_AsValue(Value: Variant);
    procedure set_AsCurrency(Value: Currency);
    procedure set_AsBoolean(Value: Boolean);
    procedure set_AsSmallInt(Value: SmallInt);
    procedure set_AsLongWord(Value: Cardinal);
    procedure set_AsLargInt(Value: Int64);
  public
    constructor Create(Field: String; FieldType: TFieldType); virtual;

    property Name      : String        read FcName         write FcName;
    property Fieldtype : DB.TFieldType read FoType         write FoType;
    property AsInteger : Integer       read get_AsInteger  write set_AsInteger;
    property AsFloat   : Double        read get_AsFloat    write set_AsFloat;
    property AsDate    : TDateTime     read get_AsDate     write set_AsDate;
    property AsString  : String        read get_AsString   write set_AsString;
    property AsValue   : Variant       read get_AsValue    write set_AsValue;
    property AsCurrency: Currency      read get_AsCurrency write set_AsCurrency;
    property AsBoolean : Boolean       read get_AsBoolean  write set_AsBoolean;
    property AsSmallInt: SmallInt      read get_AsSmallInt write set_AsSmallInt;
    property AsLongWord: Cardinal      read get_AsLongWord write set_AsLongWord;
    property AsLargInt : Int64         read get_AsLargInt  write set_AsLargInt;
  end;

  TFieldType = (ftVarChar, ftDate, ftNumber);

  TFieldSearch = class
  private
    FcName: String;
    FcDesc: String;
    FoFieldType: TFieldType;
    FoSearch: Boolean; //Se esse campo ser� mostrado no combobox do form de pesquisa (FormSeach
  public
    property Name: String read FcName write FcName;
    property Desc: String read FcDesc write FcDesc;
    property FieldType: TFieldType read FoFieldType write FoFieldType;
    property Search: Boolean read FoSearch write FoSearch;
  end;

  ITable = interface
    function canInsert(): Boolean;
    function canUpdate(): Boolean;
    function canDelete(): Boolean;
    procedure Assign(loObj: ITable);
    function ShowModal: ITable;

    function get_Master: ITable;
    procedure set_Master(Value: ITable);

    function get_IndexField: String;
    procedure set_IndexField(psIndexField: String);

    function get_ListaCampos: TStringList;

    function LoadData(laKeyFields: Array of String): Boolean;
    function FieldByName(lcField: String): TField;
    function Post(pdsStatus: TdsStatus; pTipoBackup: TTipoBackup = bkNenhum): Boolean;
    function Gerador: String;

    property MasterTable: ITable read get_Master write set_Master;
    property IndexField: String read get_IndexField write set_IndexField;
    property ListaCampos: TStringList read get_ListaCampos;
  end;

  TTableBase = class(TInterfacedObject, ITable)
  private
//  Roberto
    FoConn  : TFDConnection;
    FcTabela: String;
    FoLista : TList;
    FoListaCampos: TStringList;
//    FoConteudoCampos: TStringList;
    FoMaster: ITable;
    FsIndexField: string;

    procedure GravaFlagBackup(psIdPessoa: string; pdsStatus: TdsStatus; pTipoBackup: TTipoBackup = bkNenhum);
  protected
    function canInsert(): Boolean; virtual; abstract;
    function canUpdate(): Boolean; virtual; abstract;
    function canDelete(): Boolean; virtual; abstract;
    function ShowModal: ITable; virtual; abstract;

    function get_Master: ITable; virtual;
    procedure set_Master(Value: ITable); virtual;

    function get_IndexField: String; virtual;
    procedure set_IndexField(psIndexField: String); virtual;

    function get_ListaCampos: TStringList; virtual;

    procedure doLoadList(); virtual;

    constructor Create(Conn: TFDConnection; Tabela: String); virtual;

    function doGerador(): String; virtual;

    function Gerador: String; virtual; abstract;

    //function GetValueFields(pdsStatus: TdsStatus; var psLog: string;
      //psCampo,psConteudoCampo: String): String;

    {Converte o cont�udo de um campo, qualquer que seja o tipo e valor para uma
    string. Recebe a posi��o do campo em FoLista e retorna o cont�udo do campo
    como uma string.}
    function ConteudoCampoToStr(piIndiceCampo: Integer): String;
  public
    destructor Destroy; override;

    procedure Assign(loObj: ITable); virtual;
    function FieldByName(lcField: String): TField; virtual;
    function LoadData(laKeyFields: Array of String): boolean; virtual;
    function Post(pdsStatus: TdsStatus; pTipoBackup: TTipoBackup = bkNenhum): Boolean;

    property Conn: TFDConnection read FoConn;
    property Tabela: String read FcTabela;
    property ListaCampos: TStringList read FoListaCampos;
    {para master detail}
    property MasterTable: ITable read get_Master write set_Master;

  end;

  IProvider = interface
    function Insert: Boolean;
    function Update: Boolean;
    function Delete: Boolean;

    function get_conn: TFDConnection;
    procedure set_conn(Value: TFDConnection);

    function get_ITable: ITable;
    procedure set_ITable(Value: ITable);

    property Conn: TFDConnection read get_conn write set_conn;

    property Table: ITable read get_ITable write set_ITable;
  end;

  TProviderBase = class(TInterfacedObject, IProvider)
  private
    FoConn: TFDConnection;
    FoTable: ITable;
    FNameTable: string;
  protected
    function get_conn: TFDConnection;
    procedure set_conn(Value: TFDConnection);

    function get_ITable: itable; virtual;
    procedure set_ITable(Value: itable); virtual;

    function doInsert: Boolean; virtual; abstract;
    function doUpdate: Boolean; virtual; abstract;
    function doDelete: Boolean; virtual; abstract;
  public
    function Insert: Boolean; virtual;
    function Update: Boolean; virtual;
    function Delete: Boolean; virtual;

    property Conn: TFDConnection read get_conn write set_conn;
    property Table: ITable read get_ITable write set_ITable;
  end;

implementation

{ TProviderBase }

function TProviderBase.Delete: Boolean;
begin
  try
    if not Table.canDelete then
      raise EValidate.Create('Par�metros Insuficientes!');

    result := doDelete;
  except
    on e: exception do
      begin
      EDBException.RaiseDBError(e, Conn);

      raise;
      end;
  end;
end;

function TProviderBase.get_conn: TFDConnection;
begin
  result := FoConn;
end;

function TProviderBase.get_ITable: itable;
begin
  result := FoTable;
end;

function TProviderBase.Insert: Boolean;
begin
  try
    if not Table.canInsert then
      raise EValidate.Create('Par�metros Insuficientes!');

    result := doInsert;
  except
    on e: exception do
      begin
      EDBException.RaiseDBError(e, Conn);

      raise;
      end;
  end;
end;

procedure TProviderBase.set_conn(Value: TFDConnection);
begin
  FoConn := Value;
end;

procedure TProviderBase.set_ITable(Value: itable);
begin
  FoTable := Value;
end;

function TProviderBase.Update: Boolean;
begin
  try
    if not Table.canUpdate then
      raise EValidate.Create('Par�metros Insuficientes!');

    result := doUpdate;
  except
    on e: exception do
      begin
      EDBException.RaiseDBError(e, Conn);

      raise;
      end;
  end;
end;

{ EDBException }

constructor EDBException.Create(const lcMsg: string; loConn: TFDConnection);
begin
  inherited Create(lcMsg);
  FoConn := loConn;
end;

class function EDBException.isCK(e: exception): boolean;
begin
  result := Pos('CHECK', UpperCase(e.Message)) > 0;
end;

class function EDBException.isFK(e: exception): boolean;
begin
  result := Pos('FOREIGN', UpperCase(e.Message)) > 0;
end;

class function EDBException.isNW(e: exception): boolean;
begin
  result := Pos('NETWORK', UpperCase(e.Message)) > 0;
end;

class function EDBException.isPK(e: exception): boolean;
begin
  result := Pos('KEY VIOLATION', UpperCase(e.Message)) > 0;
end;

class function EDBException.isUK(e: exception): boolean;
begin
  result := Pos('UNIQUE', UpperCase(e.Message)) > 0;
end;

class procedure EDBException.RaiseDBError(e: exception; conn: TFDConnection);
begin
  if EDBException.isPK(e) then
    raise EPKException.Create(e.Message, Conn);

  if EDBException.isFK(e) then
    raise EFKException.Create(e.Message, Conn);

  if EDBException.isCK(e) then
    raise ECKException.Create(e.Message, Conn);

  if EDBException.isUK(e) then
    raise EUKException.Create(e.Message, Conn);

  if EDBException.isNW(e) then
    raise ENWException.Create(e.Message, Conn);
end;

{ TField }

constructor TField.Create;
begin
  inherited Create;
  FcName  := Field;
  FoType  := FieldType;
  FoValue := NULL;
end;

function TField.get_AsBoolean: Boolean;
begin
  if (FoValue = null) then begin
    Result := False;
  end else begin
    Result := False;
    TryStrToBool(FoValue,Result);
  end;
end;

function TField.get_AsCurrency: Currency;
begin
  if (FoValue = null) then begin
    Result := 0;
  end else begin
    Result := 0;
    TryStrToCurr(FoValue,Result);
  end;
end;

function TField.get_AsDate: TDateTime;
begin
  if (FoValue = null) then begin
    Result := 0;
  end else begin
    Result := 0;
    TryStrToDateTime(FoValue,Result);
  end;
  if (Result = TP_DATA_EMPTY) then begin
    Result := 0;
  end;
end;

function TField.get_AsFloat: Double;
begin
  if (FoValue = null) then begin
    Result := 0;
  end else begin
    Result := 0;
    TryStrToFloat(FoValue,Result);
  end;
end;

function TField.get_AsInteger: Integer;
begin
  if (FoValue = null) then begin
    Result := 0;
  end else begin
    Result := 0;
    TryStrToInt(FoValue,Result);
  end;
end;

function TField.get_AsLargInt: Int64;
begin
  Result := 0;
  if (FoValue <> null) then begin
    Result := 0;
    TryStrToInt64(FoValue,Result);
  end;
end;

function TField.get_AsLongWord: Cardinal;
var
  liValor: Int64;
begin
  if (FoValue = null) then begin
    Result := 0;
  end else begin
    liValor := 0;
    TryStrToInt64(FoValue,liValor);
    Result := Abs(liValor);
  end;
end;

function TField.get_AsSmallInt: SmallInt;
var
  liValor: Integer;
begin
  if (FoValue = null) then begin
    Result := 0;
  end else begin
    liValor := 0;
    TryStrToInt(FoValue,liValor);
    Result := liValor;
  end;
end;

function TField.get_AsString: String;
begin
  if (FoValue = null) then begin
    Result := '';
  end else begin
    result := FoValue;
  end;
end;

function TField.get_AsValue: Variant;
begin
  if (FoValue = null) then begin
    Result := '';
  end else begin
    result := FoValue;
  end;
end;

procedure TField.set_AsBoolean(Value: Boolean);
begin
  FoValue := Value;
end;

procedure TField.set_AsCurrency(Value: Currency);
begin
  FoValue := Value;
end;

procedure TField.set_AsDate(Value: TDateTime);
begin
  FoValue := Value;
end;

procedure TField.set_AsFloat(Value: Double);
begin
  FoValue := Value;
end;

procedure TField.set_AsInteger(Value: Integer);
begin
  FoValue := Value;
end;

procedure TField.set_AsLargInt(Value: Int64);
begin
  FoValue := Value;
end;

procedure TField.set_AsLongWord(Value: Cardinal);
begin
  FoValue := Value;
end;

procedure TField.set_AsSmallInt(Value: SmallInt);
begin
  FoValue := Value;
end;

procedure TField.set_AsString(Value: String);
begin
  FoValue := Value;
end;

procedure TField.set_ASValue(Value: Variant);
begin
  FoValue := Value;
end;

{ TTableBase }

procedure TTableBase.Assign(loObj: ITable);
var
  lnCont : Integer;
  loField: TField;
begin
  for lnCont := 0 to FoLista.Count - 1 do begin
    // campo I do loop
    loField := TField(FoLista[lnCont]);
    // copiando o conte�do do objeto loObj para dentro da nossa classe
    Self.FieldByName(loField.Name).AsValue := loObj.FieldByName(loField.Name).AsValue;
    Self.FieldByName(loField.Name).FoType  := loObj.FieldByName(loField.Name).FoType;
  end;
end;

function TTableBase.ConteudoCampoToStr(piIndiceCampo: Integer): String;
begin
//  if (TField(FoLista.Items[piIndiceCampo]).FoType in [DB.ftDate,DB.ftDateTime,DB.ftTimeStamp]) then begin
//    {Desabilita o EurekaLog para evitar o delay quando ocorre uma exce��o.
//    � necess�rio a unit ExceptionLog7}
//    SetEurekaLogStateInThread(0,False);
//    try
//      if (FieldByName(lsCampo).AsDate = TP_DATA_EMPTY) then begin
//        RlsSqlParte2     := lsSqlParte2+'NULL';
//        lsConteudoCampo := '';
//      end else if (TField(FoLista.Items[piIndiceCampo]).FoType in [DB.ftDateTime,DB.ftTimeStamp]) then begin
//        lsSqlParte2     := lsSqlParte2+QuotedStr(FormatDateTime('dd.mm.yyyy hh:nn:ss',FieldByName(lsCampo).AsDate));
//        lsConteudoCampo := lsSqlParte2+QuotedStr(FormatDateTime('dd.mm.yyyy hh:nn:ss',FieldByName(lsCampo).AsDate));
//      end else begin
//        lsSqlParte2     := lsSqlParte2+QuotedStr(FormatDateTime('dd.mm.yyyy',FieldByName(lsCampo).AsDate));
//        lsConteudoCampo := lsSqlParte2+QuotedStr(FormatDateTime('dd.mm.yyyy',FieldByName(lsCampo).AsDate));
//      end;
//    except
//      lsSqlParte2     := lsSqlParte2+'NULL';
//      lsConteudoCampo := '';
//    end;
//    {Habilita o EurekaLog}
//    SetEurekaLogStateInThread(0,True);
//  end else if (TField(FoLista.Items[piIndiceCampo]).FoType in [DB.ftInteger,DB.ftSmallint]) then begin
//    if (UpperCase(FieldByName(lsCampo).AsString) = 'TRUE') then begin
//      liValor := -1;
//    end else if (UpperCase(FieldByName(lsCampo).AsString) = 'FALSE') then begin
//      liValor := 0;
//    end else begin
//      liValor := 0;
//      TryStrToInt64(FieldByName(lsCampo).AsString,liValor);
//    end;
//    lsSqlParte2 := lsSqlParte2+QuotedStr(IntToStr(liValor));
//    if (liValor = 0) then begin
//      lsConteudoCampo := 'Falso';
//    end else begin
//      lsConteudoCampo := 'Verdadeiro';
//    end;
//  end else if (TField(FoLista.Items[piIndiceCampo]).FoType in [DB.ftFloat,DB.ftCurrency,DB.ftFMTBcd]) then begin
//    ldblValor := 0;
//    TryStrToCurr(FieldByName(lsCampo).AsString,ldblValor);
//    lsSqlParte2     := lsSqlParte2+QuotedStr(StrSubst(CurrToStr(ldblValor),',','.',0));
//    lsConteudoCampo := CurrToStr(ldblValor);
//  end else if (Trim(FieldByName(lsCampo).AsString) = '') then begin
//    lsSqlParte2     := lsSqlParte2+'NULL';
//    lsConteudoCampo := '';
//  end else begin
//    lsSqlParte2     := lsSqlParte2+QuotedStr(FieldByName(lsCampo).AsValue);
//    lsConteudoCampo := FieldByName(lsCampo).AsValue;
//  end;
end;

constructor TTableBase.Create(Conn: TFDConnection; Tabela: String);
begin
  inherited Create;
  FoConn           := Conn;
  FcTabela         := Tabela;
  FoLista          := TList.Create;
  FoListaCampos    := TStringList.Create;
//  FoConteudoCampos := TStringList.Create;
  doLoadList;
end;

destructor TTableBase.Destroy;
var
  lnCont: Integer;
begin
  for lnCont := FoLista.Count - 1 downto 0 do begin
    TField(FoLista[lnCont]).Free;
    FoLista[lnCont] := nil;
  end;

  FoLista.Pack;
  FoLista := nil;
  FreeAndNil(FoListaCampos);
//  FreeAndNil(FoConteudoCampos);

  inherited;
end;

function TTableBase.doGerador(): String;
//var
//  loQry  : TSQLQuery;
begin
  result := CreateClassID;
  {
  loQry := TSQLQuery.Create(nil);
  try
    loQry.SQLConnection := Conn;
    loQry.SQL.Text := 'SELECT * FROM SP_GET_GERADOR('+ QuotedStr(lcGerador) +')';
    loQry.Open;
    result := loQry.Fields[0].asInteger;
  finally
    loQry.Close;
    FreeAndNil(loQry);
  end;
  }
end;

procedure TTableBase.doLoadList;
var
  loQry  : TFDQuery;
  lnCont : Integer;
  liFor: Integer;
begin
  loQry := TFDQuery.Create(nil);
  try
    loQry.Connection := FoConn;
    loQry.SQL.Text := 'SELECT FIRST 1 * FROM ' + FcTabela;
    loQry.Open;

    for lnCont := 0 to loQry.FieldCount - 1 do begin
      FoLista.Add(TField.Create(UpperCase(loQry.Fields[lnCont].FieldName),loQry.Fields[lnCont].DataType));
      FoListaCampos.Add(UpperCase(loQry.Fields[lnCont].FieldName));
    end;

  finally
    FreeAndNil(loQry);
  end;
end;

function TTableBase.FieldByName(lcField: String): TField;
var
  lnCont: Integer;
begin
  result := nil;

  lnCont := FoListaCampos.IndexOf(UpperCase(lcField));
  if lnCont >= 0 then begin
    result := TField(FoLista[lnCont]);
  end;

//  for lnCont := 0 to FoLista.Count - 1 do begin
////    if trim(UpperCase(TField(FoLista[lnCont]).Name)) = trim(UpperCase(lcField)) then begin
//    if TField(FoLista[lnCont]).Name = UpperCase(lcField) then begin
//      result := TField(FoLista[lnCont]);
//      break;
//    end;
//  end;

  if result = nil then begin
    raise EDBException.Create('Campo ' + lcField + ' n�o foi encontrado na tabela ' + FcTabela, Conn);
  end;

end;

//function TTableBase.GetValueFields(pdsStatus: TdsStatus; var psLog: string;
//      psCampo,psConteudoCampo: String): String;
//var
//  lsCampo,lsConteudoCampo: string;
//  lvConteudoAtual,lvConteudoAnteriorCampo: Variant;
//  liForCampo: Integer;
//begin
//  Result  := '';
//  lsCampo := '';
//
//  if (pdsStatus = dsAtualizar) then begin
//    dmConexao.qryPesquisaConteudoAnteriorCampo.Close;
//    dmConexao.qryPesquisaConteudoAnteriorCampo.SQL.Clear;
//    dmConexao.qryPesquisaConteudoAnteriorCampo.SQL.Add('SELECT * FROM '+FcTabela+' WHERE ID_PFUNCIONARIO = '+FieldByName('ID_'+FcTabela).AsString);
//    dmConexao.qryPesquisaConteudoAnteriorCampo.Open;
//  end;
//
//  for liForCampo := 0 to FoLista.Count-1 do begin
//    lsCampo                 := TField(FoLista.Items[liForCampo]).FcName;
//    if (pdsStatus = dsAtualizar) then begin
//      lvConteudoAnteriorCampo := dmConexao.qryPesquisaConteudoAnteriorCampo.FieldByName(lsCampo).AsVariant;
//    end;
//    lvConteudoAtual         := FieldByName(lsCampo).get_AsValue;
//
//    if (Copy(psCampo,1,2) = 'ID_') then begin
//      if (pdsStatus in ([dsInserir,dsExcluir])) then begin
//        Result := Format('%-20s = %s ',[ 'ID' , psConteudoCampo ] ) + sLineBreak;
//      end;
//    end else begin
//      if (FcTabela = 'PLANCAMENTOS_PROVISORIOS') then begin
//        if (psCampo <> 'FK_EVENTO_PARAMETRO') then begin
//          if (psCampo = 'FK_PESSOA') then begin
//            lsCampo         := 'EMPRESA';
//            lsConteudoCampo := psConteudoCampo;
//          end else if (psCampo = 'FK_FUNCIONARIO') then begin
//            lsCampo := 'FUNCION�RIO';
//
//            dmConexao.qryPesquisaFk.Close;
//            dmConexao.qryPesquisaFk.SQL.Clear;
//            dmConexao.qryPesquisaFk.SQL.Add('SELECT MATRICULA,NOME FROM PFUNCIONARIO WHERE ID_PFUNCIONARIO = '+lvConteudoAtual);
//            dmConexao.qryPesquisaFk.Open;
//            lsConteudoCampo := IntToStr(dmConexao.qryPesquisaFk.FieldByName('MATRICULA').AsInteger)+'-'+dmConexao.qryPesquisaFk.FieldByName('NOME').AsString;
//          end else if (psCampo = 'FK_EVENTO') then begin
//            lsCampo := 'FUNCION�RIO';
//
//            dmConexao.qryPesquisaFk.Close;
//            dmConexao.qryPesquisaFk.SQL.Clear;
//            dmConexao.qryPesquisaFk.SQL.Add('SELECT MATRICULA,NOME FROM PEVENTOS WHERE ID_PEVENTOS = '+psConteudoCampo);
//            dmConexao.qryPesquisaFk.Open;
//            lsConteudoCampo := dmConexao.qryPesquisaFk.FieldByName('TIPO').AsString+IntToStr(dmConexao.qryPesquisaFk.FieldByName('CODIGO').AsInteger);
//
//          end else if (psCampo = 'DATA_INICIAL') then begin
//            lsCampo         := 'DATA INICIAL';
//            lsConteudoCampo := psConteudoCampo;
//          end else if (psCampo = 'DATA_FINAL') then begin
//            lsCampo         := 'DATA FINAL';
//            lsConteudoCampo := psConteudoCampo;
//          end else if (psCampo = 'EXCLUI_MEDIA') then begin
//            lsCampo         := 'EXCLUI M�DIA';
//            lsConteudoCampo := psConteudoCampo;
//          end else if (psCampo = 'EXCLUI_FERIAS') then begin
//            lsCampo         := 'EXCLUI F�RIAS';
//            lsConteudoCampo := psConteudoCampo;
//          end else if (psCampo = 'DIFERENCA') then begin
//            lsCampo         := 'DIFEREN�A';
//            lsConteudoCampo := psConteudoCampo;
//          end else if (psCampo = 'DIFERENCA') then begin
//            lsCampo         := 'DIFEREN�A';
//            lsConteudoCampo := psConteudoCampo;
//          end else begin
//            lsCampo         := psCampo;
//            lsConteudoCampo := psConteudoCampo;
//          end;
//        end;
//      end;
//
//      if (lsCampo <> '') then begin
////        try
//          if (pdsStatus in ([dsInserir,dsExcluir])) then begin
//            Result := Result + Format('%-20s = %s ',[ lsCampo , psConteudoCampo ] ) + sLineBreak;
////          end else begin
////            try Result := Result + Format('%s||%s||%s',[FieldNAme, AFields[ Aux ] , Value ] ) + #13#10; except end;
//          end;
////        except
////        end;
//      end;
//
//    end;
//  end;
//end;

function TTableBase.get_IndexField: String;
begin
  Result := FsIndexField;
end;

function TTableBase.get_ListaCampos: TStringList;
begin
  Result := FoListaCampos;
end;

function TTableBase.get_Master: ITable;
begin
  result := FoMaster;
end;

procedure TTableBase.GravaFlagBackup(psIdPessoa: string; pdsStatus: TdsStatus;
  pTipoBackup: TTipoBackup);
var
  loQry: TFDQuery;
  lsPrograma,lsTblBackup: string;
begin
  loQry := TFDQuery.Create(nil);
  try
    loQry.Connection := Conn;

      if (pTipoBackup = bkPessoa) then begin
        lsPrograma := UpperCase(ChangeFileExt(rInfoAplicacao.sNomeExe,''));
        if (lsPrograma = 'MEGAPESSOAL') then begin
          lsTblBackup := 'PBACKUP';
        end else if (lsPrograma = 'MEGACONTABIL') then begin
          lsTblBackup := 'CBACKUP';
        end else if (lsPrograma = 'MEGAFISCAL') then begin
          lsTblBackup := 'FBACKUP';
        end;
      end;
      loQry.SQL.Clear;
      loQry.SQL.Add('UPDATE OR INSERT INTO '+lsTblBackup+' (FK_PESSOA,USUARIO,ESTACAO,IP) ');
      loQry.SQL.Add('VALUES (:pIdPessoa,:pUsuario,:pEstacao,:pIP) ');
      loQry.SQL.Add('MATCHING (FK_PESSOA)');
      loQry.ParamByName('pIdPessoa').AsString  := psIdPessoa;
      loQry.ExecSQL();
  finally
    FreeAndNil(loQry);
  end;
end;

function TTableBase.LoadData(laKeyFields: array of String): boolean;
var
  loQry  : TFDQuery;
  lnCont : Integer;
  lcField: string;
  ltType : DB.TFieldType;
begin
  Result := false;
  loQry := TFDQuery.Create(nil);
  try
    loQry.Connection := FoConn;
    loQry.SQL.Text := 'SELECT * FROM ' + FcTabela + ' WHERE 1=1';

    for lnCont := Low(laKeyFields) to High(laKeyFields) do begin
      lcField := laKeyFields[lnCont];
      loQry.SQL.Add(' AND ' + lcField + ' = :' + lcField);
      loQry.ParamByName(lcField).Value := FieldByName(lcField).AsValue;
    end;
    loQry.Open;

    // verifica se algum registro foi localizado
    result := not loQry.isEmpty;

    if not result then begin
      // inicializa tudo como NULL
      for lnCont := 0 to FoLista.Count - 1 do begin
        lcField := TField(FoLista[lnCont]).Name;
        Self.FieldByName(lcField).AsValue := null
      end;
    end;

    // carga em todos os campos, caso tenha encontrado Algo
    if result then begin
      for lnCont := 0 to FoLista.Count - 1 do begin
        lcField := TField(FoLista[lnCont]).Name;
        ltType  := loQry.FieldByname(lcField).DataType;

        if loQry.FieldByname(lcField).IsNull then begin
          Self.FieldByName(lcField).AsValue := null;
        end else if ltType in [DB.ftTimeStamp] then begin
          Self.FieldByName(lcField).AsDate := EncodeDate(loQry.FieldByname(lcField).AsSQLTimeStamp.Year,
                                                         loQry.FieldByname(lcField).AsSQLTimeStamp.Month,
                                                         loQry.FieldByname(lcField).AsSQLTimeStamp.Day);
        end else begin
          Self.FieldByName(lcField).AsValue := loQry.FieldByname(lcField).Value;
        end;
      end;
    end;
  finally
    FreeAndNil(loQry);
  end;
end;

function TTableBase.Post(pdsStatus: TdsStatus; pTipoBackup: TTipoBackup = bkNenhum): Boolean;
var
  liFor,liPosicaoTabela: Integer;
  lsSqlParte1,lsSqlParte2,lsSql,lsNomeCampo,lsConteudoCampo,
  lsConteudoAnteriorCampo,lsTipoCampo,lsLog: String;
  lbVirgula,lbAlterado: Boolean;
  ldData: TDateTime;
  ldblValor: Currency;
  liValor: Int64;
begin
  Result := False;

//  if (not Assigned(dmIBase)) then begin
//    dmIBase := TdmIBase.Create(nil);
//    dmConexao.qryLog                          .Connection := Conn;
//    dmConexao.qryPost                         .Connection := Conn;
//    dmConexao.qryPesquisaFk                   .Connection := Conn;
//    dmConexao.qryPesquisaConteudoAnteriorCampo.Connection := Conn;
//  end;

  try
    try
      if (pdsStatus in ([dsInserir,dsAtualizar])) then begin
        if (pdsStatus = dsInserir) then begin
          lsSqlParte1 := 'INSERT INTO '+FcTabela+'(';
          lsSqlParte2 := 'VALUES(';
        end else begin
          lsSqlParte1 := 'UPDATE '+FcTabela+' SET ';
        end;
        lbVirgula  := False;
        lbAlterado := False; {lbAlterado guarda informa��o se algum campo do registro foi alterado}

        for liFor := 0 to FoLista.Count-1 do begin
          lsNomeCampo := TField(FoLista.Items[liFor]).FcName;
          if lbVirgula then begin
            if (pdsStatus = dsInserir) then begin
              lsSqlParte1 := lsSqlParte1+',';
            end;
            lsSqlParte2 := lsSqlParte2+',';
          end else begin
            lbVirgula := True;
          end;
          if (pdsStatus = dsInserir) then begin
            lsSqlParte1 := lsSqlParte1+lsNomeCampo;
          end else begin
            lsSqlParte2 := lsSqlParte2+lsNomeCampo+' = ';
          end;
          {Cont�udo do campo (Inser��o ou atualiza��o)}
          if (TField(FoLista.Items[liFor]).FoType in [DB.ftDate,DB.ftDateTime,DB.ftTimeStamp]) then begin
            {Desabilita o EurekaLog para evitar o delay quando ocorre uma exce��o.
            � necess�rio a unit ExceptionLog7}
            //SetEurekaLogStateInThread(0,False);
            try
              if (FieldByName(lsNomeCampo).AsDate = TP_DATA_EMPTY) then
              begin
                lsSqlParte2 := lsSqlParte2 + 'NULL';
                lsConteudoCampo := '';
              end
              else if (TField(FoLista.Items[liFor]).FoType in [DB.ftDateTime, DB.ftTimeStamp]) then
              begin
                lsSqlParte2 := lsSqlParte2 + QuotedStr(FormatDateTime('dd.mm.yyyy hh:nn:ss', FieldByName(lsNomeCampo).AsDate));
                lsConteudoCampo := FormatDateTime('dd.mm.yyyy hh:nn:ss', FieldByName(lsNomeCampo).AsDate);
              end
              else
              begin
                lsSqlParte2 := lsSqlParte2 + QuotedStr(FormatDateTime('dd.mm.yyyy', FieldByName(lsNomeCampo).AsDate));
                lsConteudoCampo := FormatDateTime('dd.mm.yyyy', FieldByName(lsNomeCampo).AsDate);
              end;
              if (FieldByName(lsNomeCampo).AsDate < TP_DATA_INICIAL) or (FieldByName(lsNomeCampo).AsDate >= TP_DATA_MAXIMA_LIMITE) then
              begin
                lsConteudoCampo := '';
              end;
            except
              lsSqlParte2     := lsSqlParte2+'NULL';
              lsConteudoCampo := '';
            end;
            {Habilita o EurekaLog}
          end else if (TField(FoLista.Items[liFor]).FoType = DB.ftBoolean) then begin
            if (FieldByName(lsNomeCampo).AsBoolean) then begin
              liValor := -1;
            end else begin
              liValor := 0;
            end;
            lsSqlParte2 := lsSqlParte2+QuotedStr(IntToStr(liValor));
            if (liValor = 0) then begin
              lsConteudoCampo := 'Falso';
            end else begin
              lsConteudoCampo := 'Verdadeiro';
            end;
          end else if (TField(FoLista.Items[liFor]).FoType in [DB.ftLargeint,DB.ftLongWord,DB.ftInteger,DB.ftSmallint]) then begin
            {Se o campo foi utilizado na tela de cadastro com AsBoolean, ent�o,
            com AsString ele retorna verdadeiro ou falso, enquanto que com
            AsInteger retorna sempre falso. Portanto, � necess�rio testar antes os
            campos DB.ftInteger e DB.ftSmallint se retornam TRUE/FALSE.}
            if (UpperCase(FieldByName(lsNomeCampo).AsString) = 'TRUE') then begin
              liValor := -1;
              lsConteudoCampo := 'Verdadeiro';
            end else if (UpperCase(FieldByName(lsNomeCampo).AsString) = 'FALSE') then begin
              liValor := 0;
              lsConteudoCampo := 'Falso';
            end else begin
              liValor := 0;
              TryStrToInt64(FieldByName(lsNomeCampo).AsString,liValor);
              lsConteudoCampo := IntToStr(liValor);
            end;
            lsSqlParte2 := lsSqlParte2+IntToStr(liValor);
          end else if (TField(FoLista.Items[liFor]).FoType in [DB.ftFloat,DB.ftCurrency,DB.ftBCD,DB.ftFMTBcd]) then begin
            ldblValor := 0;
            TryStrToCurr(FieldByName(lsNomeCampo).AsString,ldblValor);
//            lsSqlParte2     := lsSqlParte2+QuotedStr(StrSubst(CurrToStr(ldblValor),',','.',0));
            lsSqlParte2     := lsSqlParte2+StrSubst(CurrToStr(ldblValor),',','.',0);
            lsConteudoCampo := CurrToStr(ldblValor);
          end else if (Trim(FieldByName(lsNomeCampo).AsString) = '') then begin
            lsSqlParte2     := lsSqlParte2+'NULL';
            lsConteudoCampo := '';
          end else begin
            lsSqlParte2     := lsSqlParte2+QuotedStr(FieldByName(lsNomeCampo).AsValue);
            lsConteudoCampo := FieldByName(lsNomeCampo).AsValue;
          end;

          end;
       // end; //fim do IF  pdsStatus mudado RAnan 09.12.16


        if (pdsStatus = dsInserir) then begin
          lsSql := lsSqlParte1+') '+lsSqlParte2+')';
         end else begin
          lsSql := lsSqlParte1+lsSqlParte2+' WHERE '+'ID_'+FcTabela+' = '+QuotedStr(FieldByName('ID_'+FcTabela).AsString);
        end;


        dmConexao.qryPost.Close;
        dmConexao.qryPost.SQL.Clear;
        dmConexao.qryPost.SQL.Add(lsSql);
        dmConexao.qryPost.ExecSQL;

        Result := True;

    end else if (pdsStatus = dsExcluir) then begin

        lsSql := 'DELETE FROM '+FcTabela+' WHERE '+'ID_'+FcTabela+' = '+QuotedStr(FieldByName('ID_'+FcTabela).AsString);


        dmConexao.qryPost.Close;
        dmConexao.qryPost.SQL.Clear;
        dmConexao.qryPost.SQL.Add(lsSql);
        dmConexao.qryPost.ExecSQL;

        lbVirgula := False;

        Result := True;
      end;

  {Bloqueado at� a defini��o de como realmente ser� o controle de backup. Neste
  momento estou implementando via trigger.}
  //    if ((pTipoBackup <> TTipoBackup.bkNenhum) and (lsIdPessoa <> '')) then begin
  //      GravaFlagBackup(lsIdPessoa,pdsStatus,pTipoBackup);
  //    end;
    except on e: Exception do
      begin
        TUtilConexaoFireDac.RollBack(TUtilConexaoFireDac.getConn);
        ShowMessage('Erro na grava��o: '+e.Message+'. Contacte a '+rInfoEmpresa.sNomeAbreviado);
        raise;
      end;
    end;
  finally
//    if (Assigned(dmIBase)) then begin
//      FreeAndNil(dmIBase);
//    end;
  end;
end;





//function TTableBase.Post(pdsStatus: TdsStatus; pTipoBackup: TTipoBackup = bkNenhum): Boolean;
//var
//  liFor: Integer;
//  lsSqlParte1,lsSqlParte2,lsSql,lsCampo,lsConteudoCampo,lsTipoCampo,lsLog: String;
//  lbVirgula: Boolean;
//  ldData: TDateTime;
//  ldblValor: Currency;
//  liValor: Int64;
//  loQryExecucao: TSQLQuery;
//  lofdQryExecucao: TFDQuery;
//begin
//  Result := False;
//
//  {Grava utilizando o FireDac}
//  if (rInfoConexao.bFireDac) then begin
//    lofdQryExecucao := TFDQuery.Create(nil);
//    lofdQryExecucao.Connection := TUtilConexaoFireDac.getConn;
//  end else begin
//    loQryExecucao := TSQLQuery.Create(nil);
//    loQryExecucao.SQLConnection := TUtil.getConn;
//  end;
//
//  if (not Assigned(dmIBase)) then begin
//    dmIBase := TdmIBase.Create(nil);
//  end;
//
//  try
//    if (pdsStatus in ([dsInserir,dsAtualizar])) then begin
////      dmIBase.qryPost.SQL.Text := 'SELECT * FROM ' + FcTabela+' WHERE ID_'+FcTabela+' = '+FieldByName('ID_'+FcTabela).AsString;
////
////      for liFor := 0 to FoLista.Count-1 do begin
////        lsCampo := TField(FoLista.Items[liFor]).FcName;
//
//      if (pdsStatus = dsInserir) then begin
//        lsSqlParte1 := 'INSERT INTO '+FcTabela+'(';
//        lsSqlParte2 := 'VALUES(';
//      end else begin
//        lsSqlParte1 := 'UPDATE '+FcTabela+' SET ';
//      end;
//
//      lbVirgula := False;
//
//      for liFor := 0 to FoLista.Count-1 do begin
//        lsCampo := TField(FoLista.Items[liFor]).FcName;
//        if lbVirgula then begin
//          if (pdsStatus = dsInserir) then begin
//            lsSqlParte1 := lsSqlParte1+',';
//          end;
//          lsSqlParte2 := lsSqlParte2+',';
//          lsLog       := lsLog + sLineBreak;
//        end else begin
//          lbVirgula := True;
//        end;
//        if (pdsStatus = dsInserir) then begin
//          lsSqlParte1 := lsSqlParte1+lsCampo;
//        end else begin
//          lsSqlParte2 := lsSqlParte2+lsCampo+' = ';
//        end;
//
//        if (TField(FoLista.Items[liFor]).FoType in [DB.ftDate,DB.ftDateTime,DB.ftTimeStamp]) then begin
//          {Desabilita o EurekaLog para evitar o delay quando ocorre uma exce��o.
//          � necess�rio a unit ExceptionLog7}
//          SetEurekaLogStateInThread(0,False);
//          try
//            if (FieldByName(lsCampo).AsDate = TP_DATA_EMPTY) then begin
//              lsSqlParte2     := lsSqlParte2+'NULL';
//              lsConteudoCampo := '';
//            end else if (TField(FoLista.Items[liFor]).FoType in [DB.ftDateTime,DB.ftTimeStamp]) then begin
//              lsSqlParte2     := lsSqlParte2+QuotedStr(FormatDateTime('dd.mm.yyyy hh:nn:ss',FieldByName(lsCampo).AsDate));
//              lsConteudoCampo := lsSqlParte2+QuotedStr(FormatDateTime('dd.mm.yyyy hh:nn:ss',FieldByName(lsCampo).AsDate));
//            end else begin
//              lsSqlParte2     := lsSqlParte2+QuotedStr(FormatDateTime('dd.mm.yyyy',FieldByName(lsCampo).AsDate));
//              lsConteudoCampo := lsSqlParte2+QuotedStr(FormatDateTime('dd.mm.yyyy',FieldByName(lsCampo).AsDate));
//            end;
//          except
//            lsSqlParte2     := lsSqlParte2+'NULL';
//            lsConteudoCampo := '';
//          end;
//          {Habilita o EurekaLog}
//          SetEurekaLogStateInThread(0,True);
//        end else if (TField(FoLista.Items[liFor]).FoType in [DB.ftInteger,DB.ftSmallint]) then begin
//          if (UpperCase(FieldByName(lsCampo).AsString) = 'TRUE') then begin
//            liValor := -1;
//          end else if (UpperCase(FieldByName(lsCampo).AsString) = 'FALSE') then begin
//            liValor := 0;
//          end else begin
//            liValor := 0;
//            TryStrToInt64(FieldByName(lsCampo).AsString,liValor);
//          end;
//          lsSqlParte2 := lsSqlParte2+QuotedStr(IntToStr(liValor));
//          if (liValor = 0) then begin
//            lsConteudoCampo := 'Falso';
//          end else begin
//            lsConteudoCampo := 'Verdadeiro';
//          end;
//        end else if (TField(FoLista.Items[liFor]).FoType in [DB.ftFloat,DB.ftCurrency,DB.ftFMTBcd]) then begin
//          ldblValor := 0;
//          TryStrToCurr(FieldByName(lsCampo).AsString,ldblValor);
//          lsSqlParte2     := lsSqlParte2+QuotedStr(StrSubst(CurrToStr(ldblValor),',','.',0));
//          lsConteudoCampo := CurrToStr(ldblValor);
//        end else if (Trim(FieldByName(lsCampo).AsString) = '') then begin
//          lsSqlParte2     := lsSqlParte2+'NULL';
//          lsConteudoCampo := '';
//        end else begin
//          lsSqlParte2     := lsSqlParte2+QuotedStr(FieldByName(lsCampo).AsValue);
//          lsConteudoCampo := FieldByName(lsCampo).AsValue;
//        end;
//        if (CompareStr(getEnvironmentVariable('WS_LOGIN'),'ATIVO') = 0) then begin
//          lsLog := lsLog+GetValueFields(pdsStatus,lsLog,lsCampo,lsConteudoCampo);
//        end;
//
////        if (pdsStatus = dsAtualizar) then begin
////          lsLog := lsLog + lsCampo+'||||'+lsConteudoCampo;
////        end;
//      end;
//      if (pdsStatus = dsInserir) then begin
//        lsSql := lsSqlParte1+') '+lsSqlParte2+')';
//      end else begin
//        lsSql := lsSqlParte1+lsSqlParte2+' WHERE '+'ID_'+FcTabela+' = '+QuotedStr(FieldByName('ID_'+FcTabela).AsString);
//      end;
//
//      dmIBase.qryPost.Close;
//      dmIBase.qryPost.SQL.Clear;
//      dmIBase.qryPost.SQL.Add(lsSql);
//      dmIBase.qryPost.ExecSQL;
//
////      if (rInfoConexao.bFireDac) then begin
////        lofdqryExecucao.SQL.Clear;
////        lofdqryExecucao.SQL.Add(lsSql);
////        lofdqryExecucao.ExecSQL();
////      end else begin
////        loQryExecucao.SQL.Clear;
////        loQryExecucao.SQL.Add(lsSql);
////        loQryExecucao.ExecSQL();
////      end;
//      Result := True;
//
//      if (CompareStr(getEnvironmentVariable('WS_LOGIN'),'ATIVO') = 0) then begin
//        dmIBase.UCHist_DataSet1.AddHistory(rInfoAplicacao.sNomeExe,
//          Screen.ActiveCustomForm.Name ,
//          Screen.ActiveCustomForm.Caption ,
//          iif(pdsStatus = dsInserir,dmConexao.UCControlHistorico1.HistoryMsg.Evento_Insert,dmConexao.UCControlHistorico1.HistoryMsg.Evento_Edit),
//          lsLog,
////        GetValueFields(dsExcluir),
//          FcTabela,
//          rInfoLogin.sIdUCUsuario);
//      end;
//    end else if (pdsStatus = dsExcluir) then begin
//      lsSql := 'DELETE FROM '+FcTabela+' WHERE '+'ID_'+FcTabela+' = '+QuotedStr(FieldByName('ID_'+FcTabela).AsString);
//
//      dmIBase.qryPost.Close;
//      dmIBase.qryPost.SQL.Clear;
//      dmIBase.qryPost.SQL.Add(lsSql);
//      dmIBase.qryPost.ExecSQL;
//
//      if (CompareStr(getEnvironmentVariable('WS_LOGIN'),'ATIVO') = 0) then begin
//        dmIBase.UCHist_DataSet1.AddHistory(rInfoAplicacao.sNomeExe,
//          Screen.ActiveCustomForm.Name ,
//          Screen.ActiveCustomForm.Caption ,
//          dmConexao.UCControlHistorico1.HistoryMsg.Evento_Delete,
//          'ID_'+FcTabela+' = '+FieldByName('ID_'+FcTabela).AsString,
//          FcTabela,
//          rInfoLogin.sIdUCUsuario);
//
////      if (rInfoConexao.bFireDac) then begin
////        lofdQryExecucao.SQL.Clear;
////        lofdQryExecucao.SQL.Add(lsSql);
////        lofdQryExecucao.ExecSQL();
////      end else begin
////        loQryExecucao.SQL.Clear;
////        loQryExecucao.SQL.Add(lsSql);
////        loQryExecucao.ExecSQL();
////      end;
//      Result := True;
//    end;
//
//{Bloqueado at� a defini��o de como realmente ser� o controle de backup. Neste
//momento estou implementando via trigger.}
////    if ((pTipoBackup <> TTipoBackup.bkNenhum) and (lsIdPessoa <> '')) then begin
////      GravaFlagBackup(lsIdPessoa,pdsStatus,pTipoBackup);
////    end;
//
//  finally
//    if (Assigned(dmIBase)) then begin
//      FreeAndNil(dmIBase);
//    end;
//
//    if (rInfoConexao.bFireDac) then begin
//      FreeAndNil(lofdQryExecucao);
//    end else begin
//      FreeAndNil(loQryExecucao);
//    end;
//  end;
//end;



procedure TTableBase.set_IndexField(psIndexField: String);
begin
  FsIndexField := psIndexField;
end;

procedure TTableBase.set_Master(Value: ITable);
begin
  FoMaster := Value;
end;

end.


