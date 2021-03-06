unit uLoteContabilModel;

interface
{

CREATE TABLE LOTE_CONTABIL (
    ID_LOTE_CONTABIL  VARCHAR(36) NOT NULL,
    ID_ORGANIZACAO    VARCHAR(36) NOT NULL,
    LOTE              VARCHAR(30),
    STATUS            VARCHAR(30),
    TIPO_LANCAMENTO   VARCHAR(80),
    TIPO_TABLE        VARCHAR(200),
    DATA_REGISTRO     DATE,
    DATA_ATUALIZACAO  DATE NOT NULL,
    PERIODO_INICIAL   DATE,
    PERIODO_FINAL     DATE,
    QTD_REGISTROS     SMALLINT,
    VALOR_DB          NUMERIC(10,2),
    VALOR_CR          NUMERIC(10,2),
    ID_USUARIO        NUMERIC(5,0)

);



}
uses
  Windows, Messages, Classes, SysUtils, uUsuarioModel, uOrganizacaoModel;

type
  TLoteContabilModel = class(TObject)
  private

    FFID: string;
    FFIDorganizacao: string;
    FFlote: string;
    FFstatus: string;
    FFtipoLancamento: string;
    FFtipoTable: string;
    FFIDusuario: Integer;
    FFusuario: TUsuarioModel;
    FFdataRegistro: TDateTime;
    FFdataAtualizacao: TDateTime;
    FFperiodoInicial: TDateTime;
    FFperiodoFinal: TDateTime;
    FFqtdRegistros: Integer;
    FFvalorDB: Currency;
    FFvalorCR: Currency;


    function getFFdataAtualizacao: TDateTime;
    function getFFdataRegistro: TDateTime;
    function getFFID: string;
    function getFFIDorganizacao: string;
    function getFFIDusuario: Integer;
    function getFFlote: string;
    function getFFperiodoFinal: TDateTime;
    function getFFperiodoInicial: TDateTime;
    function getFFqtdRegistros: Integer;
    function getFFstatus: string;
    function getFFtipoLancamento: string;
    function getFFtipoTable: string;
    function getFFusuario: TUsuarioModel;
    function getFFvalorCR: Currency;
    function getFFvalorDB: Currency;


    procedure SetFFdataAtualizacao(const Value: TDateTime);
    procedure SetFFdataRegistro(const Value: TDateTime);
    procedure SetFFID(const Value: string);
    procedure SetFFIDorganizacao(const Value: string);
    procedure SetFFIDusuario(const Value: Integer);
    procedure SetFFlote(const Value: string);
    procedure SetFFperiodoFinal(const Value: TDateTime);
    procedure SetFFperiodoInicial(const Value: TDateTime);
    procedure SetFFqtdRegistros(const Value: Integer);
    procedure SetFFstatus(const Value: string);
    procedure SetFFtipoLancamento(const Value: string);
    procedure SetFFtipoTable(const Value: string);
    procedure SetFFusuario(const Value: TUsuarioModel);
    procedure SetFFvalorCR(const Value: Currency);
    procedure SetFFvalorDB(const Value: Currency);

    public


    property FID: string read getFFID   write   SetFFID ;
    property FIDorganizacao: string read getFFIDorganizacao   write   SetFFIDorganizacao ;
    property Flote: string read getFFlote   write   SetFFlote ;
    property Fstatus: string read getFFstatus   write   SetFFstatus ;
    property FtipoLancamento: string read getFFtipoLancamento   write   SetFFtipoLancamento ;
    property FtipoTable: string read getFFtipoTable   write   SetFFtipoTable ;
    property FIDusuario: Integer read getFFIDusuario   write   SetFFIDusuario ;
    property Fusuario: TUsuarioModel read getFFusuario   write   SetFFusuario ;
    property FdataRegistro: TDateTime read getFFdataRegistro   write   SetFFdataRegistro ;
    property FdataAtualizacao: TDateTime read getFFdataAtualizacao   write   SetFFdataAtualizacao ;
    property FperiodoInicial: TDateTime read getFFperiodoInicial   write   SetFFperiodoInicial ;
    property FperiodoFinal: TDateTime read getFFperiodoFinal   write   SetFFperiodoFinal ;
    property FqtdRegistros: Integer read getFFqtdRegistros   write   SetFFqtdRegistros ;
    property FvalorDB: Currency read getFFvalorDB   write   SetFFvalorDB ;
    property FvalorCR: Currency read getFFvalorCR   write   SetFFvalorCR ;

    constructor Create;
    destructor Destroy; override;

  end;


implementation

{ TLoteContabilModel }

constructor TLoteContabilModel.Create;
begin

end;

destructor TLoteContabilModel.Destroy;
begin

  inherited;
end;

function TLoteContabilModel.getFFdataAtualizacao: TDateTime;
begin
Result :=  FFdataAtualizacao;
end;

function TLoteContabilModel.getFFdataRegistro: TDateTime;
begin
  Result :=  FFdataRegistro;
end;

function TLoteContabilModel.getFFID: string;
begin
   Result :=  FFID;
end;

function TLoteContabilModel.getFFIDorganizacao: string;
begin
  Result :=  FFIDorganizacao;
end;

function TLoteContabilModel.getFFIDusuario: Integer;
begin
  Result :=  FFIDusuario;
end;

function TLoteContabilModel.getFFlote: string;
begin
 Result :=  FFlote;
end;

function TLoteContabilModel.getFFperiodoFinal: TDateTime;
begin
  Result :=  FFperiodoFinal;
end;

function TLoteContabilModel.getFFperiodoInicial: TDateTime;
begin
  Result :=  FFperiodoInicial;
end;

function TLoteContabilModel.getFFqtdRegistros: Integer;
begin
  Result :=  FFqtdRegistros;
end;

function TLoteContabilModel.getFFstatus: string;
begin
  Result :=  FFstatus;
end;

function TLoteContabilModel.getFFtipoLancamento: string;
begin
  Result :=  FFtipoLancamento;
end;

function TLoteContabilModel.getFFtipoTable: string;
begin
 Result :=  FFtipoTable;
end;

function TLoteContabilModel.getFFusuario: TUsuarioModel;
begin
   Result :=  FFusuario;
end;

function TLoteContabilModel.getFFvalorCR: Currency;
begin
   Result :=  FFvalorCR;
end;

function TLoteContabilModel.getFFvalorDB: Currency;
begin
  Result :=  FFvalorDB;
end;

procedure TLoteContabilModel.SetFFdataAtualizacao(const Value: TDateTime);
begin
   FFdataAtualizacao := Value;
end;

procedure TLoteContabilModel.SetFFdataRegistro(const Value: TDateTime);
begin
      FFdataRegistro := Value;
end;

procedure TLoteContabilModel.SetFFID(const Value: string);
begin
      FFID := Value;
end;

procedure TLoteContabilModel.SetFFIDorganizacao(const Value: string);
begin
      FFIDorganizacao := Value;
end;

procedure TLoteContabilModel.SetFFIDusuario(const Value: Integer);
begin
     FFIDusuario := Value;
end;

procedure TLoteContabilModel.SetFFlote(const Value: string);
begin
     FFlote := Value;
end;

procedure TLoteContabilModel.SetFFperiodoFinal(const Value: TDateTime);
begin
      FFperiodoFinal := Value;
end;

procedure TLoteContabilModel.SetFFperiodoInicial(const Value: TDateTime);
begin
    FFperiodoInicial := Value;
end;

procedure TLoteContabilModel.SetFFqtdRegistros(const Value: Integer);
begin
     FFqtdRegistros := Value;
end;

procedure TLoteContabilModel.SetFFstatus(const Value: string);
begin
      FFstatus := Value;
end;

procedure TLoteContabilModel.SetFFtipoLancamento(const Value: string);
begin
    FFtipoLancamento := Value;
end;

procedure TLoteContabilModel.SetFFtipoTable(const Value: string);
begin
     FFtipoTable := Value;
end;

procedure TLoteContabilModel.SetFFusuario(const Value: TUsuarioModel);
begin
    FFusuario := Value;
end;

procedure TLoteContabilModel.SetFFvalorCR(const Value: Currency);
begin
     FFvalorCR := Value;
end;

procedure TLoteContabilModel.SetFFvalorDB(const Value: Currency);
begin
      FFvalorDB := Value;
end;

end.
