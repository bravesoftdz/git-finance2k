unit uCartaoCreditoModel;


interface

uses
  Windows, Messages, Classes, SysUtils,uOrganizacaoModel;

type
  TCartaoCreditoModel = class(TObject)
  private
    FFID: string;
    FFIDorganizacao :string;
    FFCartao :string;
    FFNumero :string;
    FFDiaVencimento: string;
    FFTitular: string;
    FFCodigoSeguranca: string;
    FFBandeira: string;
    FFDiaCompra: string;
    FFOrganizacao :TOrganizacaoModel;
    FFDataValidade: TDateTime;
    FFLimite: Currency;


    function getFFOrganizacao : TOrganizacaoModel;
    function getFFID: string;
    function getFFIDorganizacao: string;
    function getFFCartao: string;
    function getFFNumero: string;
    function getFFDiaVencimento: string;
    function getFFTitular: string;
    function getFFCodigoSeguranca: string;
    function getFFBandeira: string;
    function getFFDiaCompra: string;
    function getFFDataValidade: TDateTime;
    function getFFLimite: Currency;
    procedure SetFBandeira(const Value: string);
    procedure SetFCartao(const Value: string);
    procedure SetFCodigoSeguranca(const Value: string);
    procedure SetFDataValidade(const Value: TDateTime);
    procedure SetFDiaCompra(const Value: string);
    procedure SetFDiaVencimento(const Value: string);
    procedure SetFID(const Value: string);
    procedure SetFIDorganizacao(const Value: string);
    procedure SetFLimite(const Value: Currency);
    procedure SetFNumero(const Value: string);
    procedure SetForganizacao(const Value: TOrganizacaoModel);
    procedure SetFTitular(const Value: string);



  public

    property FDataValidade: TDateTime read getFFDataValidade write SetFDataValidade;
    property FLimite: Currency read getFFLimite write SetFLimite;

    property FDiaCompra: string read getFFDiaCompra write SetFDiaCompra ;
    property FBandeira: string read getFFBandeira write SetFBandeira;


    property FCodigoSeguranca: string read getFFCodigoSeguranca write SetFCodigoSeguranca;

    property  FID: string read getFFID write SetFID;
    property FIDorganizacao: string read getFFIDorganizacao write SetFIDorganizacao;
    property Forganizacao: TOrganizacaoModel read getFFOrganizacao write SetForganizacao;

    property FTitular: string read getFFTitular write SetFTitular;
    property FDiaVencimento: string read getFFDiaVencimento write SetFDiaVencimento;
    property FNumero: string read getFFNumero write SetFNumero;
    property FCartao: string read getFFCartao write SetFCartao;

   Constructor Create;

  end;


implementation


{ TCartaoCreditoModel }

constructor TCartaoCreditoModel.Create;
begin
//nada

end;

function TCartaoCreditoModel.getFFBandeira: string;
begin
 Result := FFBandeira;
end;

function TCartaoCreditoModel.getFFCartao: string;
begin
  Result := FFCartao;
end;

function TCartaoCreditoModel.getFFCodigoSeguranca: string;
begin
 Result := FFCodigoSeguranca;
end;

function TCartaoCreditoModel.getFFDataValidade: TDateTime;
begin
 Result := FFDataValidade;
end;

function TCartaoCreditoModel.getFFDiaCompra: string;
begin
   Result := FFDiaCompra;
end;

function TCartaoCreditoModel.getFFDiaVencimento: string;
begin
   Result := FFDiaVencimento;
end;

function TCartaoCreditoModel.getFFID: string;
begin
 Result := FFID;

end;

function TCartaoCreditoModel.getFFIDorganizacao: string;
begin
 Result := FFIDorganizacao;

end;

function TCartaoCreditoModel.getFFLimite: Currency;
begin
    Result := FFLimite;
end;

function TCartaoCreditoModel.getFFNumero: string;
begin
 Result := FFNumero;

end;

function TCartaoCreditoModel.getFFOrganizacao: TOrganizacaoModel;
begin
      Result := FFOrganizacao;
end;

function TCartaoCreditoModel.getFFTitular: string;
begin
 Result := FFTitular;
end;

procedure TCartaoCreditoModel.SetFBandeira(const Value: string);
begin
  FFBandeira :=Value;

end;

procedure TCartaoCreditoModel.SetFCartao(const Value: string);
begin
FFCartao :=Value;
end;

procedure TCartaoCreditoModel.SetFCodigoSeguranca(const Value: string);
begin
  FFCodigoSeguranca :=Value;
end;

procedure TCartaoCreditoModel.SetFDataValidade(const Value: TDateTime);
begin
FFDataValidade :=Value;

end;

procedure TCartaoCreditoModel.SetFDiaCompra(const Value: string);
begin
 FFDiaCompra :=Value;
end;

procedure TCartaoCreditoModel.SetFDiaVencimento(const Value: string);
begin
 FFDiaVencimento :=Value;
end;

procedure TCartaoCreditoModel.SetFID(const Value: string);
begin
  FFID :=Value;
end;

procedure TCartaoCreditoModel.SetFIDorganizacao(const Value: string);
begin
FFIDorganizacao :=Value;

end;

procedure TCartaoCreditoModel.SetFLimite(const Value: Currency);
begin
FFLimite :=Value;

end;

procedure TCartaoCreditoModel.SetFNumero(const Value: string);
begin
 FFNumero :=Value;
end;

procedure TCartaoCreditoModel.SetForganizacao(const Value: TOrganizacaoModel);
begin
FFOrganizacao :=Value;

end;

procedure TCartaoCreditoModel.SetFTitular(const Value: string);
begin
FFTitular := Value
end;

end.

