unit uTituloReceberCentroCustoModel;

interface
{
CREATE TABLE TITULO_RECEBER_RATEIO_CC (
    ID_TITULO_RECEBER_RATEIO_CC  VARCHAR(36) NOT NULL,
    ID_ORGANIZACAO               VARCHAR(36) NOT NULL,
    ID_CENTRO_CUSTO              VARCHAR(36),
    ID_TITULO_RECEBER            VARCHAR(36),
    VALOR                        NUMERIC(10,2)
);
    }

uses
  Windows, Dialogs, Messages, Classes, uCentroCustoModel, SysUtils;

type
  TTituloReceberCentroCustoModel = class(TObject)
  private

    FFID: string;
    FFIDorganizacao: string;
    FFIDCentroCusto: string;
    FFCentroCusto: TCentroCustoModel;
    FFIDTR: string;
    FFvalor : Currency;
    FFnovo : Boolean;
    procedure SetFFCentroCusto(const Value: TCentroCustoModel);
    procedure SetFFID(const Value: string);
    procedure SetFFIDCentroCusto(const Value: string);
    procedure SetFFIDorganizacao(const Value: string);
    procedure SetFFIDTR(const Value: string);
    procedure SetFFvalor(const Value: Currency);


    public

    property FID: string                      read FFID                     write SetFFID  ;
    property FIDorganizacao: string           read FFIDorganizacao          write SetFFIDorganizacao  ;
    property FIDCentroCusto: string           read FFIDCentroCusto          write SetFFIDCentroCusto  ;
    property FIDTR: string                    read FFIDTR                   write SetFFIDTR  ;
    property Fvalor : Currency                read FFvalor                  write SetFFvalor  ;
    property FCentroCusto: TCentroCustoModel  read FFCentroCusto            write SetFFCentroCusto  ;
    property Fnovo :Boolean                   read FFnovo                   write FFnovo      ;

    constructor Create;

  end;

implementation



{ TTituloReceberCentroCustoModel }

constructor TTituloReceberCentroCustoModel.Create;
begin
FFnovo := True;
end;

procedure TTituloReceberCentroCustoModel.SetFFCentroCusto(
  const Value: TCentroCustoModel);
begin
  FFCentroCusto := Value;
end;

procedure TTituloReceberCentroCustoModel.SetFFID(const Value: string);
begin
  FFID := Value;
end;

procedure TTituloReceberCentroCustoModel.SetFFIDCentroCusto(
  const Value: string);
begin
  FFIDCentroCusto := Value;
end;

procedure TTituloReceberCentroCustoModel.SetFFIDorganizacao(
  const Value: string);
begin
  FFIDorganizacao := Value;
end;

procedure TTituloReceberCentroCustoModel.SetFFIDTR(const Value: string);
begin
  FFIDTR := Value;
end;

procedure TTituloReceberCentroCustoModel.SetFFvalor(const Value: Currency);
begin
  FFvalor := Value;
end;

end.
