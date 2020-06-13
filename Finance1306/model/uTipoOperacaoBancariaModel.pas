unit uTipoOperacaoBancariaModel;

interface
{

CREATE TABLE TIPO_OPERACAO_BANCARIA (
    ID_TIPO_OPERACAO_BANCARIA  VARCHAR(36) NOT NULL,
    ID_ORGANIZACAO             VARCHAR(36) NOT NULL,
    DESCRICAO                  VARCHAR(30) NOT NULL,
    TIPO                       INTEGER,
    CODIGO                     INTEGER,
    ID_CONTA_CONTABIL          VARCHAR(36)

); }
uses
  Windows, Messages, Classes, SysUtils,uContaContabilModel, uOrganizacaoModel;

type
  TTipoOperacaoBancariaModel = class(TObject)
  private

    FFID: String;
    FFIDorganizacao: string;
    FFdescricao :string;
    FFIDcontaContabil :string;
    FFcontaContabil :TContaContabilModel;
    FFOrganizacao :TOrganizacaoModel;
    FFtipo :Integer;
    FFcodigo :Integer;


    function getFFcodigo: Integer;
    function getFFcontaContabil: TContaContabilModel;
    function getFFdescricao: string;
    function getFFID: String;
    function getFFIDcontaContabil: string;
    function getFFIDorganizacao: string;
    function getFFOrganizacao: TOrganizacaoModel;
    function getFFtipo: Integer;
    procedure SetFFcodigo(const Value: Integer);
    procedure SetFFcontaContabil(const Value: TContaContabilModel);
    procedure SetFFdescricao(const Value: string);
    procedure SetFFID(const Value: String);
    procedure SetFFIDcontaContabil(const Value: string);
    procedure SetFFIDorganizacao(const Value: string);
    procedure SetFFOrganizacao(const Value: TOrganizacaoModel);
    procedure SetFFtipo(const Value: Integer);

    public

    property FID: String  read getFFID   write   SetFFID  ;
    property FIDorganizacao: string  read getFFIDorganizacao   write   SetFFIDorganizacao  ;
    property Fdescricao :string  read getFFdescricao   write   SetFFdescricao  ;
    property FIDcontaContabil :string  read getFFIDcontaContabil   write   SetFFIDcontaContabil  ;
    property FcontaContabil :TContaContabilModel  read getFFcontaContabil   write   SetFFcontaContabil  ;
    property FOrganizacao :TOrganizacaoModel  read getFFOrganizacao   write   SetFFOrganizacao  ;
    property Ftipo :Integer  read getFFtipo   write   SetFFtipo  ;
    property Fcodigo :Integer  read getFFcodigo   write   SetFFcodigo  ;

    constructor Create;
    destructor Destroy; override;
  end;


implementation


{ TTipoOperacaoBancariaModel }

constructor TTipoOperacaoBancariaModel.Create;
begin

end;

destructor TTipoOperacaoBancariaModel.Destroy;
begin

  inherited;
end;

function TTipoOperacaoBancariaModel.getFFcodigo: Integer;
begin
Result :=  FFcodigo;
end;

function TTipoOperacaoBancariaModel.getFFcontaContabil: TContaContabilModel;
begin
  Result :=  FFcontaContabil;
end;

function TTipoOperacaoBancariaModel.getFFdescricao: string;
begin
  Result :=  FFdescricao;
end;

function TTipoOperacaoBancariaModel.getFFID: String;
begin
  Result :=  FFID;
end;

function TTipoOperacaoBancariaModel.getFFIDcontaContabil: string;
begin
  Result :=  FFIDcontaContabil;
end;

function TTipoOperacaoBancariaModel.getFFIDorganizacao: string;
begin
  Result :=  FFIDorganizacao;
end;

function TTipoOperacaoBancariaModel.getFFOrganizacao: TOrganizacaoModel;
begin
 Result :=  FFOrganizacao;
end;

function TTipoOperacaoBancariaModel.getFFtipo: Integer;
begin
 Result :=  FFtipo;
end;

procedure TTipoOperacaoBancariaModel.SetFFcodigo(const Value: Integer);
begin
  FFcodigo :=  Value;
end;

procedure TTipoOperacaoBancariaModel.SetFFcontaContabil(
  const Value: TContaContabilModel);
begin
    FFcontaContabil :=  Value;
end;

procedure TTipoOperacaoBancariaModel.SetFFdescricao(const Value: string);
begin
    FFdescricao :=  Value;
end;

procedure TTipoOperacaoBancariaModel.SetFFID(const Value: String);
begin
   FFID :=  Value;
end;

procedure TTipoOperacaoBancariaModel.SetFFIDcontaContabil(const Value: string);
begin
    FFIDcontaContabil :=  Value;
end;

procedure TTipoOperacaoBancariaModel.SetFFIDorganizacao(const Value: string);
begin
    FFIDorganizacao :=  Value;
end;

procedure TTipoOperacaoBancariaModel.SetFFOrganizacao(
  const Value: TOrganizacaoModel);
begin
    FFOrganizacao :=  Value;
end;

procedure TTipoOperacaoBancariaModel.SetFFtipo(const Value: Integer);
begin
    FFtipo :=  Value;
end;

end.
