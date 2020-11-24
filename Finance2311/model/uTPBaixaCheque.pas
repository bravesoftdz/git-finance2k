unit uTPBaixaCheque;

uses
  Windows, Messages, Classes, SysUtils,uOrganizacaoModel;

type
  TCBDebitoModel = class(TObject)
  private
    FFID: string;
    FFIDorganizacao: string;
    FFOrganizacao: TOrganizacaoModel;

    FFIDcontaBancaria: string;
    FFIDTOB: string;
    FFIDTituloPagar: string;
    FFIDResponsavel: string;
    FFIDcontaBancariaCheque: string;
    FFIDusuario: string;
    FFIDloteContabil: string;
    FFIdentificacao: string;
    FFdescricao: string;
    FFobservacao: string;
    FFTipoLancamento: string;
    FFdataRegistro: TDateTime;
    FFdataMovimento: TDateTime;
    FFvalor: Currency;



    function getFFOrganizacao : TOrganizacaoModel;
    function getFFIDorganizacao: string;
    function getFFID: string;

    function getFFIDcontaBancaria: string;
    function getFFIDTOB: string;
    function getFFIDTituloPagar: string;
    function getFFIDcontaBancariaCheque: string;
    function getFFIdentificacao: string;
    function getFFIDResponsavel: string;
    function getFFIDusuario: string;
    function getFFIDloteContabil: string;

    function getFFdescricao: string;
    function getFFobservacao: string;
    function getFFTipoLancamento: string;

    function getFFvalor: Currency;

    function getFFDataRegistro :TDateTime;
    function getFFdataMovimento :TDateTime;


    procedure SetFForganizacao(const Value: TOrganizacaoModel);
    procedure setFFID(const Value: string);
    procedure setFFIDorganizacao(const Value: string);
    procedure setFFIDcontaBancaria(const Value: string);
    procedure setFFIDTOB(const Value: string);
    procedure setFFIDTituloPagar(const Value: string);
    procedure setFFIDResponsavel(const Value: string);
    procedure setFFIDcontaBancariaCheque(const Value: string);
    procedure setFFIDusuario(const Value: string);
    procedure setFFIDloteContabil(const Value: string);
    procedure setFFIdentificacao(const Value: string);
    procedure setFFdescricao(const Value: string);
    procedure setFFobservacao(const Value: string);
    procedure setFFTipoLancamento(const Value: string);
    procedure setFFdataRegistro(const Value: TDateTime);
    procedure setFFdataMovimento(const Value: TDateTime);
    procedure setFFvalor(const Value: Currency);




  public

    property FID: string read getFFID write SetFFID;
    property FIDorganizacao: string read getFFIDorganizacao write SetFFIDorganizacao;
    property Forganizacao: TOrganizacaoModel read getFFOrganizacao write SetFForganizacao;
    property FIDcontaBancaria: string read getFFIDcontaBancaria write SetFFIDcontaBancaria;
    property FIDTOB: string read getFFIDTOB write SetFFIDTOB;
    property FIDTituloPagar: string read getFFIDTituloPagar write SetFFIDTituloPagar;
    property FIDResponsavel: string read getFFIDResponsavel write SetFFIDResponsavel;
    property FIDcontaBancariaCheque: string read getFFIDcontaBancariaCheque write SetFFIDcontaBancariaCheque;
    property FIDusuario: string read getFFIDusuario write SetFFIDusuario;
    property FIDloteContabil: string read getFFIDloteContabil write SetFFIDloteContabil;
    property FIdentificacao: string read getFFIdentificacao write SetFFIdentificacao;
    property Fdescricao: string read getFFdescricao write SetFFdescricao;
    property Fobservacao: string read getFFobservacao write SetFFobservacao;
    property FTipoLancamento: string read getFFTipoLancamento write SetFFTipoLancamento;
    property FdataRegistro: TDateTime read getFFdataRegistro write setFFdataRegistro;
    property FdataMovimento: TDateTime read getFFdataMovimento write SetFFdataMovimento;
    property Fvalor: Currency read getFFvalor write setFFvalor;



      Constructor Create;

  end;
end.
