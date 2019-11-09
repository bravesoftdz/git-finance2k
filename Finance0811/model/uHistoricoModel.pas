unit uHistoricoModel;

interface

uses
  Windows, Messages, Classes, SysUtils, uContaContabilModel;

type
  THistoricoModel = class(TObject)
  private
    FFIdOrganizcao :string;
    FFContaContabil: TContaContabilModel;
    FFIdContaContabil :string;
    FFDescricao: string;
    FFIdHistorico: string;
    FFTipo : string;
    FFProduto :string;
    FFCodigo : Integer;


    procedure SetFContaContabil(const Value: TContaContabilModel);
    procedure SetFDescricao(const Value: string);
    procedure SetFIdHistorico(const Value: string);
    property FIdHistorico: string read FFIdHistorico write SetFIdHistorico;
    property FDescricao: string read FFDescricao write SetFDescricao;
    property FContaContabil: TContaContabilModel read FFContaContabil write SetFContaContabil;


  end;

implementation

{ THistoricoModel }

procedure THistoricoModel.SetFContaContabil(const Value: TContaContabilModel);
begin
  FFContaContabil := Value;
end;

procedure THistoricoModel.SetFDescricao(const Value: string);
begin
  FFDescricao := Value;
end;

procedure THistoricoModel.SetFIdHistorico(const Value: string);
begin
  FFIdHistorico := Value;
end;

end.


