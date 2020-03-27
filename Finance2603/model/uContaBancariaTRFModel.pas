unit uContaBancariaTRFModel;

interface
{
CREATE TABLE CONTA_BANCARIA_TRANSFERENCIA (
    ID_CONTA_BANCARIA_TRANSFERENCIA  VARCHAR(36) NOT NULL,
    ID_ORGANIZACAO                   VARCHAR(36) NOT NULL,
    ID_CONTA_BANCARIA_CREDITO        VARCHAR(36),
    ID_CONTA_BANCARIA_DEBITO         VARCHAR(36),
    ID_TIPO_OPERACAO_BANCARIA        VARCHAR(36),
    ID_RESPONSAVEL                   VARCHAR(36),
    OBSERVACAO                       VARCHAR(60),
    IDENTIFICACAO                    VARCHAR(36),
     VALOR                            NUMERIC(10,2),
    ID_USUARIO                       NUMERIC(5,0),
    DATA_REGISTRO                    DATE,
    DATA_MOVIMENTO                   DATE,
  ID_LOTE_CONTABIL                 VARCHAR(36)
);
   }

uses
  Windows, Messages, Classes, SysUtils,uContaBancariaModel,uLoteContabilModel, uFuncionarioModel, uContaBancariaDBModel,uContaBancariaCRModel,
  uTipoOperacaoBancariaModel,uUsuarioModel, uOrganizacaoModel,uOrganizacaoDAO;

type
  TContaBancariaTRFModel = class(TObject)
  private
    FFID: string;
    FFIDorganizacao: string;
    FFIDResponsavel: string;
    FFIDTOB: string;
    FFIDcontaBancariaCR: string;
    FFIDcontaBancariaDB: string;
    FFIDloteContabil: string;
    FFobservacao: string;
    FFidentificacao: string;
    FFIDusuario: Integer;
    FFvalor: Currency;
    FFdataRegistro: TDateTime;
    FFdataMovimento: TDateTime;
    FFnovo : Boolean;

    FFtipoLancamento: string;
    FFdescricao: string;

   //Objetos
       FFOrganizacao        : TOrganizacaoModel;
       FFcontaBancariaCR    : TContaBancariaCRModel;
       FFcontaBancariaDB    : TContaBancariaDBModel;
       FFtipoOperacao       : TTipoOperacaoBancariaModel;
       FFresponsavel        : TFuncionarioModel;
       FFloteContabil       : TLoteContabilModel;
       FFusuario            : TUsuarioModel;


    procedure SetFdataMovimento(const Value: TDateTime);
    procedure SetFdataRegistro(const Value: TDateTime);
    procedure SetFFcontaBancariaCR(const Value: TContaBancariaCRModel);
    procedure SetFFcontaBancariaDB(const Value: TContaBancariaDBModel);
    procedure SetFFIDcontaBancariaCR(const Value: string);
    procedure SetFFIDcontaBancariaDB(const Value: string);
    procedure SetFFloteContabil(const Value: TLoteContabilModel);
    procedure SetFFresponsavel(const Value: TFuncionarioModel);
    procedure SetFFtipoOperacao(const Value: TTipoOperacaoBancariaModel);
    procedure SetFFusuario(const Value: TUsuarioModel);
    procedure SetFID(const Value: string);
    procedure SetFidentificacao(const Value: string);
    procedure SetFIDloteContabil(const Value: string);
    procedure SetFIDorganizacao(const Value: string);
    procedure SetFIDResponsavel(const Value: string);
    procedure SetFIDTOB(const Value: string);
    procedure SetFIDusuario(const Value: Integer);
    procedure SetFobservacao(const Value: string);
    procedure SetForganizacao(const Value: TOrganizacaoModel);
    procedure SetFvalor(const Value: Currency);

  public

    property FID: string                read FFID                 write SetFID;
    property FIDorganizacao: string     read FFIDorganizacao      write SetFIDorganizacao;
    property FIDusuario: Integer        read FFIDusuario          write SetFIDusuario;
    property FIDResponsavel: string     read FFIDResponsavel      write SetFIDResponsavel;
    property FIDTOB: string             read FFIDTOB              write SetFIDTOB;
    property FIDcontaBancariaCR: string read FFIDcontaBancariaCR  write SetFFIDcontaBancariaCR;
    property FIDcontaBancariaDB: string read FFIDcontaBancariaDB  write SetFFIDcontaBancariaDB;
    property FIDloteContabil: string    read FFIDloteContabil     write SetFIDloteContabil;
    property Fobservacao: string        read FFobservacao         write SetFobservacao;
    property Fidentificacao: string     read FFidentificacao      write SetFidentificacao;
    property Fvalor: Currency           read FFvalor              write SetFvalor;
    property FdataRegistro: TDateTime   read FFdataRegistro       write SetFdataRegistro;
    property FdataMovimento: TDateTime  read FFdataMovimento      write SetFdataMovimento;

     //Objetos
       property Forganizacao        : TOrganizacaoModel           read FFOrganizacao        write   SetForganizacao;
       property FcontaBancariaCR    : TContaBancariaCRModel       read FFcontaBancariaCR    write   SetFFcontaBancariaCR  ;
       property FcontaBancariaDB    : TContaBancariaDBModel       read FFcontaBancariaDB    write   SetFFcontaBancariaDB  ;
       property FtipoOperacao       : TTipoOperacaoBancariaModel  read FFtipoOperacao       write   SetFFtipoOperacao  ;
       property Fresponsavel        : TFuncionarioModel           read FFresponsavel        write   SetFFresponsavel  ;
       property FloteContabil       : TLoteContabilModel          read FFloteContabil       write   SetFFloteContabil  ;
       property Fusuario            : TUsuarioModel               read FFusuario            write   SetFFusuario  ;
       property Fnovo :Boolean                                    read FFnovo               write   FFnovo;


    constructor Create;
    destructor Destroy; override;
  end;

implementation
{ TContaBancariaTRFModel }
constructor TContaBancariaTRFModel.Create;
begin
  FFnovo := True;
end;

destructor TContaBancariaTRFModel.Destroy;
begin
   FreeAndNil(FFloteContabil);
   FreeAndNil(FFresponsavel);
   FreeAndNil(FFtipoOperacao);
   FreeAndNil(FFcontaBancariaDB);
   FreeAndNil(FFcontaBancariaCR);
   FreeAndNil(FFOrganizacao);
   FreeAndNil(FFusuario);

  inherited;
end;

procedure TContaBancariaTRFModel.SetFdataMovimento(const Value: TDateTime);
begin
  FFdataMovimento := Value;
end;

procedure TContaBancariaTRFModel.SetFdataRegistro(const Value: TDateTime);
begin
  FFdataRegistro := Value;
end;

procedure TContaBancariaTRFModel.SetFFcontaBancariaCR(
  const Value: TContaBancariaCRModel);
begin
  FFcontaBancariaCR := Value;
end;

procedure TContaBancariaTRFModel.SetFFcontaBancariaDB(
  const Value: TContaBancariaDBModel);
begin
  FFcontaBancariaDB := Value;
end;

procedure TContaBancariaTRFModel.SetFFIDcontaBancariaCR(const Value: string);
begin
  FFIDcontaBancariaCR := Value;
end;

procedure TContaBancariaTRFModel.SetFFIDcontaBancariaDB(const Value: string);
begin
  FFIDcontaBancariaDB := Value;
end;

procedure TContaBancariaTRFModel.SetFFloteContabil(
  const Value: TLoteContabilModel);
begin
  FFloteContabil := Value;
end;

procedure TContaBancariaTRFModel.SetFFresponsavel(
  const Value: TFuncionarioModel);
begin
  FFresponsavel := Value;
end;

procedure TContaBancariaTRFModel.SetFFtipoOperacao(
  const Value: TTipoOperacaoBancariaModel);
begin
  FFtipoOperacao := Value;
end;

procedure TContaBancariaTRFModel.SetFFusuario(const Value: TUsuarioModel);
begin
  FFusuario := Value;
end;

procedure TContaBancariaTRFModel.SetFID(const Value: string);
begin
  FFID := Value;
end;

procedure TContaBancariaTRFModel.SetFidentificacao(const Value: string);
begin
  FFidentificacao := Value;
end;

procedure TContaBancariaTRFModel.SetFIDloteContabil(const Value: string);
begin
  FFIDloteContabil := Value;
end;

procedure TContaBancariaTRFModel.SetFIDorganizacao(const Value: string);
begin
  FFIDorganizacao := Value;
end;

procedure TContaBancariaTRFModel.SetFIDResponsavel(const Value: string);
begin
  FFIDResponsavel := Value;
end;

procedure TContaBancariaTRFModel.SetFIDTOB(const Value: string);
begin
  FFIDTOB := Value;
end;

procedure TContaBancariaTRFModel.SetFIDusuario(const Value: Integer);
begin
  FFIDusuario := Value;
end;

procedure TContaBancariaTRFModel.SetFobservacao(const Value: string);
begin
  FFobservacao := Value;
end;

procedure TContaBancariaTRFModel.SetForganizacao(
  const Value: TOrganizacaoModel);
begin
  FFOrganizacao := Value;
end;

procedure TContaBancariaTRFModel.SetFvalor(const Value: Currency);
begin
  FFvalor := Value;
end;


end.
