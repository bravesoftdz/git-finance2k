unit uDMEspelhoTR;

interface

uses
  System.SysUtils, System.Classes, FireDAC.Stan.Intf, FireDAC.Stan.Option,Vcl.Forms,
  FireDAC.Stan.Param, FireDAC.Stan.Error, FireDAC.DatS, FireDAC.Phys.Intf, uUtil,
  FireDAC.DApt.Intf, FireDAC.Stan.Async, FireDAC.DApt, Data.DB, udmConexao, uDMOrganizacao,
  FireDAC.Comp.DataSet, FireDAC.Comp.Client, frxClass, frxDBSet, frxExportImage,
  frxExportRTF, frxExportCSV, frxExportPDF, frxExportBaseDialog;

type
  TdmEspelhoTR = class(TDataModule)
    frxDBTitulos: TfrxDBDataset;
    frxTRROVDB: TfrxDBDataset;
    frxTRPROVCR: TfrxDBDataset;
    qryTRPROVCR: TFDQuery;
    qryTRPROVDB: TFDQuery;
    dsDetalhesTR: TDataSource;
    frxDBTRQuitados: TfrxDBDataset;
    frxDBTRBCaixa: TfrxDBDataset;
    frxTRBAcrescimo: TfrxDBDataset;
    frxTRBDeducao: TfrxDBDataset;
    frxDBTRB: TfrxDBDataset;
    frxTRBCheque: TfrxDBDataset;
    qryTRQuitados: TFDQuery;
    qryObterTRBaixaPorTitulo: TFDQuery;
    qryBaixaTRCaixa: TFDQuery;
    qryBaixaTRCheque: TFDQuery;
    qryTRBAcrescimos: TFDQuery;
    qryTRBDeducao: TFDQuery;
    qryTRBHistorico: TFDQuery;
    frxTRBHistorico: TfrxDBDataset;
    frxEspelhoTR: TfrxReport;
    qryObterTRBBanco: TFDQuery;
    qrySacado: TFDQuery;
    qryObterPorNumeroDocumento: TFDQuery;
    frxSacado: TfrxDBDataset;
    qryRateioCentroCustos: TFDQuery;
    frxCentroCustos: TfrxDBDataset;
    qryLoteRecebto: TFDQuery;
    frxLoteRcbto: TfrxDBDataset;
    frxTRBBanco: TfrxDBDataset;
    frxPDFExport1: TfrxPDFExport;
    frxCSVExport1: TfrxCSVExport;
    procedure dsDetalhesTRDataChange(Sender: TObject; Field: TField);
  private
    { Private declarations }

   dtInicial, dtFinal : TDate;

  public
    { Public declarations }
    procedure inicializarDM(Sender: TObject);
    function retornarCaminhoRelatorio: string;
    procedure inicializarVariaveisRelatorio(dtInicial, dtFinal: TDate);
    procedure exibirRelatorio(pDataInicial, pDataFinal: TDate);

    //TR PRovisionado
    function obterPorNumeroDocumento(pIdOrganizacao, pNumDoc: string): Boolean;
    function obterTRProvCR(pIdOrganizacao,pIdTituloReceber : string ): Boolean;
    function obterTRProvDB(pIdOrganizacao,pIdTituloReceber : string ): Boolean;
    function obterRateioCentroCusto(pIdOrganizacao,pIdTituloReceber : string ): Boolean;

    //TP BAIXA
    function obterTRQuitados(pIdOrganizacao, pIdStatus: string; pDataInicial, pDataFinal: TDate): Boolean;
    function obterTRBaixaPorTitulo(pIdOrganizacao, pIdtituloReceber: String): Boolean;
    function obterTRBAC(pIdOrganizacao, pIdTRB : String): Boolean;
    function obterTRBDE(pIdOrganizacao, pIdTRB : String): Boolean;

    function obterTRBCaixa(pIdOrganizacao, pIdTRB: String): Boolean;
    function obterTRBCheque(pIdOrganizacao, pIdTRB  : String): Boolean;
    function obterTRBBanco(pIdOrganizacao, pIdTRB  : String): Boolean;

    function obterTRBHistorico(pIdorganizacao, tituloReceberQuitado : string): Boolean;
    function obterCdentePorID(pIdorganizacao, idSacado : string): Boolean;
    function obterqryLoteRecebimento(pIdorganizacao, idLote : string): Boolean;

  end;

var
  dmEspelhoTR: TdmEspelhoTR;

implementation

{%CLASSGROUP 'Vcl.Controls.TControl'}

{$R *.dfm}

function TdmEspelhoTR.retornarCaminhoRelatorio: string;
begin
   Result := uutil.TPathRelatorio.getContasReceberEspelho;
end;

procedure  TdmEspelhoTR.inicializarDM(Sender: TObject);
begin

  if not(Assigned(dmOrganizacao)) then
  begin
    dmOrganizacao := TdmOrganizacao.Create(Self);
  end ;

end;

procedure TdmEspelhoTR.inicializarVariaveisRelatorio(dtInicial, dtFinal: TDate);
begin

  with   frxEspelhoTR.Variables do
  begin

    Variables['strRazaoSocial'] :=
      QuotedStr(dmOrganizacao.qryDadosEmpresa.FieldByName('RAZAO_SOCIAL')
      .AsString);
    Variables['strCNPJ'] :=
      QuotedStr(dmOrganizacao.qryDadosEmpresa.FieldByName('CNPJ').AsString);
    Variables['strEndereco'] :=
      QuotedStr(dmOrganizacao.qryDadosEmpresa.FieldByName('ENDERECO').AsString);
    Variables['strCEP'] :=
      QuotedStr(dmOrganizacao.qryDadosEmpresa.FieldByName('CEP').AsString);
    Variables['strCidade'] :=
      QuotedStr(dmOrganizacao.qryDadosEmpresa.FieldByName('CIDADE').AsString);
    Variables['strUF'] :=
      QuotedStr(dmOrganizacao.qryDadosEmpresa.FieldByName('UF').AsString);
    Variables['strPeriodo'] :=QuotedStr( ' de  ' + DateToStr(dtInicial) + '  at�  ' + DateToStr(dtFinal));



    // Variables['strTipo'] := QuotedStr(tipo); // muda a depender do lancamento

  end;

end;


procedure TdmEspelhoTR.dsDetalhesTRDataChange(Sender: TObject; Field: TField);
var
pIdOrganizacao, pIdSacado, pIdTituloReceber,pIdLote, pIdTRB :string;
begin
//pegar os dados dos detalhe
 pIdOrganizacao   := qryObterPorNumeroDocumento.FieldByName('ID_ORGANIZACAO').AsString;
 pIdSacado        := qryObterPorNumeroDocumento.FieldByName('ID_SACADO').AsString;
 pIdTituloReceber := qryObterPorNumeroDocumento.FieldByName('ID_TITULO_RECEBER').AsString;
 dtInicial        := qryObterPorNumeroDocumento.FieldByName('DATA_EMISSAO').AsDateTime;
 dtFinal          := dtInicial;


 obterTRProvDB(pIdOrganizacao,pIdTituloReceber);
 obterCdentePorID(pIdOrganizacao, pIdSacado);
 obterRateioCentroCusto(pIdOrganizacao,pIdTituloReceber);

  if obterTRBaixaPorTitulo(pIdOrganizacao,pIdTituloReceber) then begin
      pIdTRB  := qryObterTRBaixaPorTitulo.FieldByName('ID_TITULO_RECEBER_BAIXA').AsString;
   //   pIdLote := qryObterTRBaixaPorTitulo.FieldByName('ID_LOTE_PAGAMENTO').AsString;
      obterTRBAC(pIdOrganizacao,pIdTRB);
      obterTRBDE(pIdOrganizacao,pIdTRB);
      obterqryLoteRecebimento(pIdOrganizacao,pIdLote);
      obterTRBCaixa(pIdOrganizacao,pIdTRB);
      obterTRBCheque(pIdOrganizacao,pIdTRB);
      obterTRBBanco(pIdOrganizacao,pIdTRB);

  end;

end;

Procedure TdmEspelhoTR.exibirRelatorio(pDataInicial, pDataFinal: TDate);
begin

         frxEspelhoTR.Clear;
  if not(frxEspelhoTR.LoadFromFile(retornarCaminhoRelatorio)) then
  begin
    ///dasa
  end
  else
  begin
    inicializarVariaveisRelatorio(dtInicial, dtFinal); //verficar essa data
    frxEspelhoTR.OldStyleProgress := True;
    frxEspelhoTR.ShowProgress := True;
    frxEspelhoTR.ShowReport;

    end;
end;


function  TdmEspelhoTR.obterTRProvCR(pIdOrganizacao,pIdTituloReceber : string ): Boolean;
begin
  Result := false;

  qryTRPROVCR.Close;
  qryTRPROVCR.Connection := dmConexao.Conn;
  qryTRPROVCR.ParamByName('PIDORGANIZACAO').AsString := pIdOrganizacao;
  qryTRPROVCR.ParamByName('PID').AsString := pIdTituloReceber;
  qryTRPROVCR.Open;

  Result := not qryTRPROVCR.IsEmpty;

end;


function TdmEspelhoTR.obterTRProvDB(pIdOrganizacao,pIdTituloReceber : string ): Boolean;
begin
  Result := false;

  qryTRPROVDB.Close;
  qryTRPROVDB.Connection := dmConexao.Conn;
  qryTRPROVDB.ParamByName('PIDORGANIZACAO').AsString := pIdOrganizacao;
  qryTRPROVDB.ParamByName('PID').AsString := pIdTituloReceber;
  qryTRPROVDB.Open;


  Result := not qryTRPROVDB.IsEmpty;

end;



function TdmEspelhoTR.obterTRQuitados(pIdOrganizacao, pIdStatus: string; pDataInicial, pDataFinal: TDate): Boolean;
var auxSql :string;
begin
  Result := false;

  qryTRQuitados.Close;
  qryTRQuitados.Connection := dmConexao.Conn;
  qryTRQuitados.ParamByName('pIdOrganizacao').AsString := pIdOrganizacao;
  qryTRQuitados.ParamByName('pIdStatus').AsString := pIdStatus;
  qryTRQuitados.ParamByName('pDataInicial').AsDate := pDataInicial;
  qryTRQuitados.ParamByName('pDataFinal').AsDate := pDataFinal;
//  auxSql := QuotedStr(qry1.SQL.Text); S� PARA TESTE
  qryTRQuitados.Open;

  Result := not qryTRQuitados.IsEmpty;

end;

function TdmEspelhoTR.obterTRBCaixa(pIdOrganizacao, pIdTRB: String): Boolean;
begin
  Result := false;
  //obtem os TP pago pela tesouraria
  try
    qryBaixaTRCaixa.Close;
    qryBaixaTRCaixa.Connection := dmConexao.Conn;
    qryBaixaTRCaixa.ParamByName('PIDORGANIZACAO').AsString :=  pIdOrganizacao;
    qryBaixaTRCaixa.ParamByName('PIDTRB').AsString := pIdTRB;
    qryBaixaTRCaixa.Open;
  except
  raise(Exception).Create('Erro ao tentar consultar tesouraria ' );
  end;

  Result := not qryBaixaTRCaixa.IsEmpty;

end;

function TdmEspelhoTR.obterTRBCheque(pIdOrganizacao, pIdTRB  : String): Boolean;
begin

  Result := false;
  try
    qryBaixaTRCheque.Close;
    qryBaixaTRCheque.Connection := dmConexao.Conn;
    qryBaixaTRCheque.ParamByName('PIDORGANIZACAO').AsString := pIdOrganizacao;
    qryBaixaTRCheque.ParamByName('PIDTRB').AsString :=pIdTRB;
    qryBaixaTRCheque.Open;
  except
  raise(Exception).Create('Erro ao tentar consultar do cheque ' );
  end;

  Result := not qryBaixaTRCheque.IsEmpty;
end;

function TdmEspelhoTR.obterTRBBanco(pIdOrganizacao, pIdTRB  : String): Boolean;

begin
  Result := false;

  TRY
    qryObterTRBBanco.Close;
    qryObterTRBBanco.Connection := dmConexao.Conn;
    qryObterTRBBanco.ParamByName('PIDORGANIZACAO').AsString :=   pIdOrganizacao;
    qryObterTRBBanco.ParamByName('PIDTRB').AsString := pIdTRB;
    qryObterTRBBanco.Open;
  except
  raise(Exception).Create('Erro ao tentar consultar dados no banco ' );
  end;

  Result := not qryObterTRBBanco.IsEmpty;

end;

function TdmEspelhoTR.obterCdentePorID(pIdorganizacao,
  idSacado: string): Boolean;
begin
try

      qrySacado.Close;
      qrySacado.Connection := dmConexao.Conn;
      qrySacado.ParamByName('PIDORGANIZACAO').AsString := pIdOrganizacao;
      qrySacado.ParamByName('PID').AsString := idSacado;

      qrySacado.Open;

  except
  raise(Exception).Create('Erro ao tentar consultar o Cliente ' );
  end;

  Result := not qrySacado.IsEmpty;
end;

function TdmEspelhoTR.obterqryLoteRecebimento(pIdorganizacao,
  idLote: string): Boolean;
begin
 try
      qryLoteRecebto.Close;
      qryLoteRecebto.Connection := dmConexao.Conn;
      qryLoteRecebto.ParamByName('PIDORGANIZACAO').AsString := pIdOrganizacao;
      qryLoteRecebto.ParamByName('PIDLOTE').AsString := idLote;

      qryLoteRecebto.Open;

 except

  raise(Exception).Create('Erro ao tentar consultar Lote Pagamento ' );

 end;

  Result := not qryLoteRecebto.IsEmpty;


end;

function TdmEspelhoTR.obterPorNumeroDocumento(pIdOrganizacao,
  pNumDoc: string): Boolean;
begin
 try
      qryObterPorNumeroDocumento.Close;
      qryObterPorNumeroDocumento.Connection := dmConexao.Conn;
      qryObterPorNumeroDocumento.ParamByName('PIDORGANIZACAO').AsString := pIdOrganizacao;
      qryObterPorNumeroDocumento.ParamByName('PNUMDOC').AsString := pNumDoc;

      qryObterPorNumeroDocumento.Open;
    {  dtInicial := qryObterPorNumeroDocumento.FieldByName('DATA_EMISSAO').AsDateTime;
      dtFinal := dtInicial;   }
  except

  raise(Exception).Create('Erro ao tentar consultar o TP DOC ' + pNumDoc );


  end;

  Result := not qryObterPorNumeroDocumento.IsEmpty;
end;

function TdmEspelhoTR.obterRateioCentroCusto(pIdOrganizacao,
  pIdTituloReceber: string): Boolean;
begin
 try

      qryRateioCentroCustos.Close;
      qryRateioCentroCustos.Connection := dmConexao.Conn;
      qryRateioCentroCustos.ParamByName('PIDORGANIZACAO').AsString := pIdOrganizacao;
      qryRateioCentroCustos.ParamByName('PID').AsString := pIdTituloReceber;

      qryRateioCentroCustos.Open;

  except

  raise(Exception).Create('Erro ao tentar consultar o rateio de custos ....');


  end;

  Result := not qryRateioCentroCustos.IsEmpty;
end;

function TdmEspelhoTR.obterTRBAC(pIdOrganizacao, pIdTRB : String): Boolean;
begin

  Result := false;
  try
      qryTRBAcrescimos.Close;
      qryTRBAcrescimos.Connection := dmConexao.Conn;
      qryTRBAcrescimos.ParamByName('PIDORGANIZACAO').AsString := pIdOrganizacao;
      qryTRBAcrescimos.ParamByName('PIDTRB').AsString := pIdTRB;
      qryTRBAcrescimos.Open;
  except

  raise(Exception).Create('Erro ao tentar obter os acr�scimos ....');


  end;
  Result := not qryTRBAcrescimos.IsEmpty;
end;




function TdmEspelhoTR.obterTRBaixaPorTitulo(pIdOrganizacao, pIdtituloReceber: String): Boolean;
begin
 Result := false;

 try
      qryObterTRBaixaPorTitulo.Close;
      qryObterTRBaixaPorTitulo.Connection := dmConexao.Conn;
      qryObterTRBaixaPorTitulo.ParamByName('PIDORGANIZACAO').AsString :=  pIdOrganizacao;
      qryObterTRBaixaPorTitulo.ParamByName('PID').AsString :=  pIdtituloReceber;
      qryObterTRBaixaPorTitulo.Open;
 except

  raise(Exception).Create('Erro ao tentar obter baixa de titulos  ....');

 end;

  Result := not qryObterTRBaixaPorTitulo.IsEmpty;

end;


function TdmEspelhoTR.obterTRBDE(pIdOrganizacao, pIdTRB
  : String): Boolean;
begin

  Result := false;
  try
      qryTRBDeducao.Close;
      qryTRBDeducao.Connection := dmConexao.Conn;
      qryTRBDeducao.ParamByName('PIDORGANIZACAO').AsString := pIdOrganizacao;
      qryTRBDeducao.ParamByName('PIDTRB').AsString :=
        pIdTRB;
      qryTRBDeducao.Open;
  except

  raise(Exception).Create('Erro ao tentar obter dedu��es  ....');

 end;

  Result := not qryTRBDeducao.IsEmpty;
end;


function TdmEspelhoTR.obterTRBHistorico(pIdorganizacao, tituloReceberQuitado :string): Boolean;
begin
  Result := false;

  if not qryTRBHistorico.Connection.Connected then
  begin
    qryTRBHistorico.Connection := dmConexao.Conn;
  end;

  qryTRBHistorico.Close;
  qryTRBHistorico.ParamByName('PIDTR').AsString := tituloReceberQuitado;
  qryTRBHistorico.ParamByName('pIdOrganizacao').AsString := pIdorganizacao;

  qryTRBHistorico.Open();

  Result := not qryTRBHistorico.IsEmpty;

end;



end.
