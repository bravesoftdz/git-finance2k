unit uTituloPagarDAO;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, FireDAC.Stan.Intf, FireDAC.Stan.Option,  uCedenteModel, uCedenteDAO,
  FireDAC.Stan.Param, FireDAC.Stan.Error, FireDAC.DatS, FireDAC.Phys.Intf,System.Generics.Collections,
  FireDAC.DApt.Intf, FireDAC.Stan.Async, FireDAC.DApt, Data.DB, uTituloPagarModel, udmConexao, uUtil, uTipoStatusModel, uTipoStatusDAO,
  FireDAC.Comp.DataSet, uTituloPagarHistoricoModel, uTituloPagarHistoricoDAO, uLoteContabilModel, uLoteContabilDAO,
  uTituloPagarCentroCustoModel , uTituloPagarCentroCustoDAO, uLotePagamentoModel, uLotePagamentoDAO,uNotaFiscalEntradaModel, uNotaFiscalEntradaDAO,
  uCentroCustoModel, uCentroCustoDAO, uHistoricoModel, uHistoricoDAO, uFuncionarioModel, uFuncionarioDAO,
  FireDAC.Comp.Client;

type
 TTituloPagarDAO = class
  private

   class function getTP (query :TFDQuery) : TTituloPagarModel;

  public
    {m�todos CRUD (Create, Read, Update e Delete)
    para manipula��o dos dados}


    class function Insert(titulo :TTituloPagarModel): Boolean;
    class function existFilhos(titulo :TTituloPagarModel): Boolean;

    class function obterPorID(titulo :TTituloPagarModel): TTituloPagarModel;
    class function obterTodosPorStatus(titulo :TTituloPagarModel): TFDQuery;
    class function obterTodosFilhos(titulo :TTituloPagarModel): TFDQuery;


    class function obterPorNumeroDocumento(titulo :TTituloPagarModel): TTituloPagarModel;
    class function Delete(titulo :TTituloPagarModel): Boolean;
    class function Update(titulo :TTituloPagarModel): Boolean;
    class function particionar(tituloNovo, tituloAntigo :TTituloPagarModel): Boolean;
    class function obterTodosPagar(pDataInicio, pDataFim :TDateTime; pIDorganizacao :string ) :  TObjectList<TTituloPagarModel>;
    class function obterTodosPagosPorLote(titulo :TTituloPagarModel ) :  TFDQuery;

    class function obterRateioHistorico(titulo :TTituloPagarModel) :  TObjectList<TTituloPagarHistoricoModel>;
    class function obterRateioCC(titulo :TTituloPagarModel)        :  TObjectList<TTituloPagarCentroCustoModel>;

  end;
implementation
{ TTituloPagarDAO }
class function TTituloPagarDAO.Delete(titulo: TTituloPagarModel): Boolean;
var
qryDelete : TFDQuery;
xResp :Boolean;
begin
xResp := False;
 dmConexao.conectarBanco;
 qryDelete := TFDQuery.Create(nil);

 try

 try


  qryDelete.Close;
  qryDelete.Connection := dmConexao.conn;
  qryDelete.SQL.Clear;
  qryDelete.SQL.Add('DELETE FROM TITULO_PAGAR  '  );
  qryDelete.SQL.Add('WHERE ID_ORGANIZACAO = :PIDORGANIZACAO  AND  ID_TITULO_PAGAR = :PID '  );
  qryDelete.ParamByName('PIDORGANIZACAO').AsString := titulo.FIDorganizacao;
  qryDelete.ParamByName('PID').AsString := titulo.FID;

  qryDelete.ExecSQL;
  xResp := True;
    //o comit fica na transacao

 except
 xResp := False;
 raise Exception.Create('Erro ao tentar DELETAR TITULO');

 end;

  Result := xResp;

  finally
    if Assigned(qryDelete) then
    begin
      FreeAndNil(qryDelete);
    end;
  end;

end;

class function TTituloPagarDAO.Insert(titulo: TTituloPagarModel): Boolean;
var
qryInsert : TFDQuery;
cmdSql :string;
begin
 dmConexao.conectarBanco;
 qryInsert := TFDQuery.Create(nil);

  try
    try
     cmdSql := ' INSERT INTO TITULO_PAGAR '+
     ' (ID_TITULO_PAGAR, ID_ORGANIZACAO, '+
     ' ID_HISTORICO, ID_CEDENTE, ID_TIPO_COBRANCA,'+
     ' ID_RESPONSAVEL, ID_LOCAL_PAGAMENTO, ID_TIPO_STATUS,'+
     ' ID_CENTRO_CUSTO, ID_TITULO_GERADOR, ID_NOTA_FISCAL_ENTRADA,' +
     ' NUMERO_DOCUMENTO, DESCRICAO, DATA_REGISTRO, DATA_EMISSAO, '+
     ' DATA_PROTOCOLO, DATA_VENCIMENTO, PREVISAO_CARTORIO,'+
     ' VALOR_NOMINAL, MOEDA, CARTEIRA, CODIGO_BARRAS, CONTRATO, PARCELA, '+
     ' OBSERVACAO, VALOR_ANTECIPADO, ID_USUARIO, ID_LOTE_PAGAMENTO,'+
     ' DATA_ULTIMA_ATUALIZACAO, ID_CONTA_CONTABIL_CREDITO, ID_CONTA_CONTABIL_DEBITO, '+
     ' REGISTRO_PROVISAO ) '+
     ' VALUES (:PIDTITULO_PAGAR,:PIDORGANIZACAO, '+
     ' :PIDHISTORICO,:PIDCEDENTE, :PIDTIPO_COBRANCA, '+
     ' :PIDRESPONSAVEL, :PIDLOCAL_PAGAMENTO, :PIDTIPO_STATUS, '+
     ' :PIDCENTRO_CUSTO, :PIDTITULO_GERADOR, :PIDNOTA_FISCAL_ENTRADA, '+
     ' :PNUMERO_DOCUMENTO, :PDESCRICAO, :PDATA_REGISTRO, :PDATA_EMISSAO, '+
     ' :PDATA_PROTOCOLO, :PDATA_VENCIMENTO, :PPREVISAO_CARTORIO, '+
     ' :PVALOR_NOMINAL, :PMOEDA, :PCARTEIRA, :PCODIGO_BARRAS, :PCONTRATO, :PPARCELA, '+
     ' :POBSERVACAO, :PVALOR_ANTECIPADO, :PIDUSUARIO, :PIDLOTE_PAGAMENTO, '+
     ' :PDATA_ULTIMA_ATUALIZACAO, :PIDCONTA_CONTABIL_CREDITO, :PIDCONTA_CONTABIL_DEBITO, '+
     ' :PREGISTRO_PROVISAO ) ' ;


//INSERT INTO TITULO_PAGAR (ID_TITULO_PAGAR, ID_ORGANIZACAO, ID_HISTORICO, ID_CEDENTE, ID_TIPO_COBRANCA, ID_RESPONSAVEL, ID_LOCAL_PAGAMENTO, ID_TIPO_STATUS, ID_CENTRO_CUSTO, ID_TITULO_GERADOR, ID_NOTA_FISCAL_ENTRADA, NUMERO_DOCUMENTO, DESCRICAO, DATA_REGISTRO, DATA_EMISSAO, DATA_PROTOCOLO, DATA_VENCIMENTO, DATA_PAGAMENTO, PREVISAO_CARTORIO, VALOR_NOMINAL, MOEDA, CARTEIRA, CODIGO_BARRAS, CONTRATO, PARCELA, OBSERVACAO, VALOR_ANTECIPADO, ID_USUARIO, CONTA_CONTABIL_DEBITO, DIGITO_CONTA_CONTABIL_CREDITO, CONTA_CONTABIL_CREDITO, DIGITO_CONTA_CONTABIL_DEBITO, ID_LOTE_PAGAMENTO, DATA_ULTIMA_ATUALIZACAO, ID_LOTE_CONTABIL, ID_CONTA_CONTABIL_CREDITO, ID_CONTA_CONTABIL_DEBITO, IS_PROVISAO, REGISTRO_PROVISAO, ID_CONTA_BANCARIA_CHEQUE, ID_LOTE_TPB, ID_PATRIMONIO) VALUES ('001fc610-922f-11e7-9692-c8891287143d', 'imap', 'c74779d0-5930-11e4-9920-c11c8813c2aa', '12f393c0-9e1d-11e3-bb78-b212b7f7fbca', '01d758e0-c7d3-11dd-a1cf-c27fb35dd52c', 'fcebc640-d4a5-11e4-a71a-8bddf59bc0eb', '3686be50-c7d3-11dd-a1cf-c27fb35dd52c', 'QUITADO', '176b0d00-9afa-11e3-b9a3-b909de21f15b', NULL, NULL, '2017050917505', 'COMP 08/2017', '5-SEP-2017', '5-SEP-2017', '5-SEP-2017', '20-SEP-2017', '20-SEP-2017', '9-SEP-2017', 283.04, 'REAL', '', '     .     .     .            .', '', '5 / 8', 'Pagto atraves do lote n�mero : 2109201701', 0, 43, NULL, NULL, NULL, NULL, '6014b6e0-9ebc-11e7-b928-9ac0874f587b', '21-SEP-2017', NULL, NULL, '64C94EBE-BACA-42CF-8EE6-709209507136', 0, NULL, NULL, NULL, NULL);

    qryInsert.Close;
    qryInsert.Connection := dmConexao.conn;
    qryInsert.SQL.Clear;
    qryInsert.SQL.Add(cmdSql);
    qryInsert.ParamByName('PIDTITULO_PAGAR').AsString             := titulo.FID;
    qryInsert.ParamByName('PIDORGANIZACAO').AsString              := titulo.FIDorganizacao;
    qryInsert.ParamByName('PIDUSUARIO').AsString                  := titulo.FIDUsuario;
    qryInsert.ParamByName('PIDRESPONSAVEL').AsString              := titulo.FIDResponsavel;
//    qryInsert.ParamByName('PIDLOTE_CONTABIL').AsString            := titulo.FIDLoteContabil;
    qryInsert.ParamByName('PIDHISTORICO').AsString                := titulo.FIDHistorico;
    qryInsert.ParamByName('PIDCEDENTE').AsString                  := titulo.FIDCedente;
//    qryInsert.ParamByName('PIDLOTE_TPB').AsString                 := titulo.FIDLoteTPB;
    qryInsert.ParamByName('PIDTIPO_COBRANCA').AsString            := titulo.FIDTipoCobranca;
    qryInsert.ParamByName('PIDLOCAL_PAGAMENTO').AsString          := titulo.FIDLocalPagamento;
    qryInsert.ParamByName('PIDTIPO_STATUS').AsString              := titulo.FIDTipoStatus;
    qryInsert.ParamByName('PIDCENTRO_CUSTO').AsString             := titulo.FIDCentroCusto;
    qryInsert.ParamByName('PIDNOTA_FISCAL_ENTRADA').AsString      := titulo.FIDNotaFiscalEntrada;
    qryInsert.ParamByName('PIDTITULO_GERADOR').AsString           := titulo.FIDTituloPagarAnterior;
    qryInsert.ParamByName('PIDLOTE_PAGAMENTO').AsString           := titulo.FIDLotePagamento;
    qryInsert.ParamByName('PIDCONTA_CONTABIL_DEBITO').AsString    := titulo.FIDContaContabilDebito;
    qryInsert.ParamByName('PIDCONTA_CONTABIL_CREDITO').AsString   := titulo.FIDContaContabilCredito;
//    qryInsert.ParamByName('PIDCONTA_BANCARIA_CHEQUE').AsString    := titulo.FIDCBChequeVinculado;
    qryInsert.ParamByName('PDESCRICAO').AsString                  := titulo.Fdescricao;
    qryInsert.ParamByName('POBSERVACAO').AsString                 := titulo.Fobservacao;
    qryInsert.ParamByName('PPARCELA').AsString                    := titulo.Fparcela;
    qryInsert.ParamByName('PCONTRATO').AsString                   := titulo.Fcontrato;
    qryInsert.ParamByName('PCODIGO_BARRAS').AsString              := titulo.FcodigoBarras;
    qryInsert.ParamByName('PCARTEIRA').AsString                   := titulo.Fcarteira;
    qryInsert.ParamByName('PMOEDA').AsString                      := titulo.Fmoeda;
    qryInsert.ParamByName('PREGISTRO_PROVISAO').AsString          := titulo.FregistroProvisao;
    qryInsert.ParamByName('PNUMERO_DOCUMENTO').AsString           := titulo.FnumeroDocumento;

    qryInsert.ParamByName('PDATA_REGISTRO').AsDateTime            := titulo.FdataRegistro;
    qryInsert.ParamByName('PDATA_ULTIMA_ATUALIZACAO').AsDateTime  := titulo.FdataUltimaAtualizacao;
    qryInsert.ParamByName('PPREVISAO_CARTORIO').AsDateTime        := titulo.FprevisaoCartorio;
//    qryInsert.ParamByName('PDATA_PAGAMENTO').AsDateTime           := titulo.FdataPagamento;
    qryInsert.ParamByName('PDATA_VENCIMENTO').AsDateTime          := titulo.FdataVencimento;
    qryInsert.ParamByName('PDATA_PROTOCOLO').AsDateTime           := titulo.FdataProtocolo;
    qryInsert.ParamByName('PDATA_EMISSAO').AsDateTime             := titulo.FdataEmissao;

    qryInsert.ParamByName('PVALOR_NOMINAL').AsCurrency            := titulo.FvalorNominal;
    qryInsert.ParamByName('PVALOR_ANTECIPADO').AsCurrency         := titulo.FvalorAntecipado;

    if uUtil.Empty(titulo.FIDContaContabilDebito) then
    begin
      qryInsert.ParamByName('PIDCONTA_CONTABIL_DEBITO').Value := null;
     end;
    if uUtil.Empty(titulo.FIDContaContabilCredito) then
    begin
      qryInsert.ParamByName('PIDCONTA_CONTABIL_CREDITO').Value := null;
     end;
    if uUtil.Empty(titulo.FIDTituloPagarAnterior) then
    begin
      qryInsert.ParamByName('PIDTITULO_GERADOR').Value := null;
     end;
    if uUtil.Empty(titulo.FIDNotaFiscalEntrada) then
    begin
      qryInsert.ParamByName('PIDNOTA_FISCAL_ENTRADA').Value := null;
     end;
    {
    if uUtil.Empty(titulo.FIDLoteContabil) then
    begin
      qryInsert.ParamByName('PIDLOTE_CONTABIL').Value := null;
     end;
    if uUtil.Empty(titulo.FIDLoteTPB) then
    begin
      qryInsert.ParamByName('PIDLOTE_TPB').Value := null;
    end;

      if uUtil.Empty(titulo.FIDCBChequeVinculado) then
    begin
      qryInsert.ParamByName('PIDCONTA_BANCARIA_CHEQUE').Value := null;
    end;

    }
    if uUtil.Empty(titulo.FIDLotePagamento) then
    begin
      qryInsert.ParamByName('PIDLOTE_PAGAMENTO').Value := null;
    end;
     if uUtil.Empty(titulo.FregistroProvisao) then
    begin
      qryInsert.ParamByName('PREGISTRO_PROVISAO').Value := null;
    end;


    qryInsert.ExecSQL;

    except
      Result := False;

      raise Exception.Create('Erro ao tentar inserir TITULO');

    end;

    Result := System.True;
  finally
    if Assigned(qryInsert) then
    begin
      FreeAndNil(qryInsert);
    end;
  end;
end;

class function TTituloPagarDAO.obterPorID(titulo: TTituloPagarModel): TTituloPagarModel;
var
qryPesquisa : TFDQuery;
tituloPagar: TTituloPagarModel;

begin
dmConexao.conectarBanco;

tituloPagar := TTituloPagarModel.Create;
qryPesquisa := TFDQuery.Create(nil);

try

  qryPesquisa.Close;
  qryPesquisa.Connection := dmConexao.conn;
  qryPesquisa.SQL.Clear;
  qryPesquisa.SQL.Add('SELECT * '  );
  qryPesquisa.SQL.Add('FROM TITULO_PAGAR  '  );
  qryPesquisa.SQL.Add('WHERE ID_ORGANIZACAO = :PIDORGANIZACAO  AND  ID_TITULO_PAGAR = :PID '  );

  qryPesquisa.ParamByName('PIDORGANIZACAO').AsString := titulo.FIDorganizacao;
  qryPesquisa.ParamByName('PID').AsString := titulo.FID;
  qryPesquisa.Open;

  if not qryPesquisa.IsEmpty then begin


      tituloPagar := getTP(qryPesquisa);

  end;


except
raise Exception.Create('Erro ao tentar obter TITULO');

end;

 Result := tituloPagar;
end;

class function TTituloPagarDAO.obterPorNumeroDocumento(titulo: TTituloPagarModel): TTituloPagarModel;
var
qryPesquisa : TFDQuery;
tituloPagar: TTituloPagarModel;

begin
dmConexao.conectarBanco;
 qryPesquisa := TFDQuery.Create(nil);
 tituloPagar := TTituloPagarModel.Create;


try

  qryPesquisa.Close;
  qryPesquisa.Connection := dmConexao.conn;
  qryPesquisa.SQL.Clear;
  qryPesquisa.SQL.Add('SELECT * '  );
  qryPesquisa.SQL.Add('FROM TITULO_PAGAR  '  );
  qryPesquisa.SQL.Add('WHERE ID_ORGANIZACAO = :PIDORGANIZACAO  AND NUMERO_DOCUMENTO = :PDOC '  );

  qryPesquisa.ParamByName('PIDORGANIZACAO').AsString := titulo.FIDorganizacao;
  qryPesquisa.ParamByName('PDOC').AsString := titulo.FnumeroDocumento;
  qryPesquisa.Open;

  if not qryPesquisa.IsEmpty then begin


      tituloPagar := getTP(qryPesquisa);

  end;


except
raise Exception.Create('Erro ao tentar obter TITULO');

end;

 Result := tituloPagar;
end;

class function TTituloPagarDAO.obterRateioCC(titulo: TTituloPagarModel): TObjectList<TTituloPagarCentroCustoModel>;
var
qryPesquisa : TFDQuery;
centroCusto: TTituloPagarCentroCustoModel;
I :Integer;
 listaCC : TObjectList<TTituloPagarCentroCustoModel> ;
 cmd :string;

begin
  listaCC := TObjectList<TTituloPagarCentroCustoModel>.Create;
  listaCC.clear;

  dmConexao.conectarBanco;
try


    cmd := ' SELECT * FROM TITULO_PAGAR_RATEIO_CC TPH ' +
           ' WHERE (TPH.ID_ORGANIZACAO = :PIDORGANIZACAO) AND (TPH.ID_TITULO_PAGAR = :PIDTP)';

  qryPesquisa := TFDQuery.Create(nil);
  qryPesquisa.Close;
  qryPesquisa.Connection := dmConexao.conn;
  qryPesquisa.SQL.Clear;
  qryPesquisa.SQL.Add(cmd);


  qryPesquisa.ParamByName('PIDORGANIZACAO').AsString  := titulo.FIDorganizacao;
  qryPesquisa.ParamByName('PIDTP').AsString           := titulo.FID;

  qryPesquisa.Open;

  if not qryPesquisa.IsEmpty then begin
         qryPesquisa.First;

     while not qryPesquisa.Eof do begin

       centroCusto := TTituloPagarCentroCustoModel.Create;
       centroCusto.FID            := qryPesquisa.FieldByName('ID_TITULO_PAGAR_RATEIO_CC').AsString;
       centroCusto.FIDorganizacao := qryPesquisa.FieldByName('ID_ORGANIZACAO').AsString;
       centroCusto := TTituloPagarCentroCustoDAO.obterPorID(centroCusto);

        listaCC.Add(TTituloPagarCentroCustoModel.Create);

        I := listaCC.Count -1;

        listaCC[I].FID                := centroCusto.FID;
        listaCC[I].FIDorganizacao     := centroCusto.FIDorganizacao;
        listaCC[I].FIDCentroCusto     := centroCusto.FIDCentroCusto;
        listaCC[I].FIDTP              := centroCusto.FIDTP;
        listaCC[I].Fvalor             := centroCusto.Fvalor;

       qryPesquisa.Next;
     end;

  end;


except
raise Exception.Create('Erro ao tentar obter RATEIO CENTRO DE CUSTOS');

end;

 Result := listaCC;
end;

class function TTituloPagarDAO.obterRateioHistorico( titulo: TTituloPagarModel): TObjectList<TTituloPagarHistoricoModel>;
var
qryPesquisa : TFDQuery;
historico: TTituloPagarHistoricoModel;
I :Integer;
 listaHistorico : TObjectList<TTituloPagarHistoricoModel> ;
 cmd :string;

begin
  listaHistorico := TObjectList<TTituloPagarHistoricoModel>.Create;
  listaHistorico.clear;

  dmConexao.conectarBanco;
try

    cmd := ' SELECT * FROM TITULO_PAGAR_HISTORICO TPH ' +
           ' WHERE (TPH.ID_ORGANIZACAO = :PIDORGANIZACAO) AND (TPH.ID_TITULO_PAGAR = :PIDTP)';

  qryPesquisa := TFDQuery.Create(nil);
  qryPesquisa.Close;
  qryPesquisa.Connection := dmConexao.conn;
  qryPesquisa.SQL.Clear;
  qryPesquisa.SQL.Add(cmd);

  qryPesquisa.ParamByName('PIDORGANIZACAO').AsString  := titulo.FIDorganizacao;
  qryPesquisa.ParamByName('PIDTP').AsString           := titulo.FID;

  qryPesquisa.Open;

  if not qryPesquisa.IsEmpty then begin
         qryPesquisa.First;


     while not qryPesquisa.Eof do begin

       historico := TTituloPagarHistoricoModel.Create;
       historico.FID            := qryPesquisa.FieldByName('ID_TITULO_PAGAR_HISTORICO').AsString;
       historico.FIDorganizacao := qryPesquisa.FieldByName('ID_ORGANIZACAO').AsString;
       historico := TTituloPagarHistoricoDAO.obterPorID(historico);


        listaHistorico.Add(TTituloPagarHistoricoModel.Create);

        I := listaHistorico.Count -1;

        listaHistorico[I].FID                     := historico.FID;
        listaHistorico[I].FIDorganizacao          := historico.FIDorganizacao;
        listaHistorico[I].FIDContaContabilDebito  := historico.FIDContaContabilDebito;
        listaHistorico[I].FIDHistorico            := historico.FIDHistorico;
        listaHistorico[I].FIDTP                   := historico.FIDTP;
        listaHistorico[I].Fvalor                  := historico.Fvalor;
        listaHistorico[I].FHistorico              := historico.FHistorico;


       qryPesquisa.Next;
     end;

  end;


except
raise Exception.Create('Erro ao tentar obter RATEIO HISTORICO');

end;

 Result := listaHistorico
end;


class function TTituloPagarDAO.obterTodosFilhos( titulo: TTituloPagarModel): TFDQuery;
var
qryPesquisa : TFDQuery;
cmd :string;

begin
dmConexao.conectarBanco;
try
   cmd := 'SELECT *  FROM TITULO_PAGAR  WHERE ID_ORGANIZACAO = :PIDORGANIZACAO  AND ID_TITULO_GERADOR = :PFILHO' ;


  qryPesquisa := TFDQuery.Create(nil);
  qryPesquisa.Close;
  qryPesquisa.Connection := dmConexao.conn;
  qryPesquisa.SQL.Clear;
  qryPesquisa.SQL.Add(cmd);
  qryPesquisa.ParamByName('PIDORGANIZACAO').AsString := titulo.FIDorganizacao;
  qryPesquisa.ParamByName('PFILHO').AsString := titulo.FID;

  qryPesquisa.Open;


except
raise Exception.Create('Erro ao tentar obter FILHOS por TP');

end;

 Result := qryPesquisa;
end;

class function TTituloPagarDAO.obterTodosPagar(pDataInicio, pDataFim :TDateTime; pIDorganizacao :string ) :  TObjectList<TTituloPagarModel>;
var
qryPesquisa : TFDQuery;
tituloPagar: TTituloPagarModel;
I :Integer;
 listaTP : TObjectList<TTituloPagarModel> ;
 cmd :string;

begin
  listaTP := TObjectList<TTituloPagarModel>.Create;
  listaTP.clear;
  dmConexao.conectarBanco;
try

    cmd := ' SELECT * FROM TITULO_PAGAR '+
           ' WHERE (ID_ORGANIZACAO = :PIDORGANIZACAO)  '+
           ' AND (DATA_VENCIMENTO BETWEEN :pDTINICIO AND :pDTFINAL )' +
           ' AND (ID_TIPO_STATUS = ''ABERTO'') '+
           ' AND (REGISTRO_PROVISAO IS NULL) '+
           ' ORDER BY DATA_EMISSAO DESC ';



  qryPesquisa := TFDQuery.Create(nil);
  qryPesquisa.Close;
  qryPesquisa.Connection := dmConexao.conn;
  qryPesquisa.SQL.Clear;
  qryPesquisa.SQL.Add(cmd);


  qryPesquisa.ParamByName('PIDORGANIZACAO').AsString  := pIDorganizacao;
  qryPesquisa.ParamByName('pDTINICIO').AsDateTime     := pDataInicio;
  qryPesquisa.ParamByName('pDTFINAL').AsDateTime      := pDataFim;

  qryPesquisa.Open;

  if not qryPesquisa.IsEmpty then begin
         qryPesquisa.First;

     while not qryPesquisa.Eof do begin

       tituloPagar := TTituloPagarModel.Create;
       tituloPagar.FID            := qryPesquisa.FieldByName('ID_TITULO_PAGAR').AsString;
       tituloPagar.FIDorganizacao := qryPesquisa.FieldByName('ID_ORGANIZACAO').AsString;
       tituloPagar := TTituloPagarDAO.obterPorID(tituloPagar);


        listaTP.Add(TTituloPagarModel.Create);

        I := listaTP.Count -1;

        listaTP[I].FID              := tituloPagar.FID;
        listaTP[I].FIDorganizacao   := tituloPagar.FIDorganizacao;
        listaTP[I].FvalorNominal    := tituloPagar.FvalorNominal;
        listaTP[I].FCedente         := tituloPagar.FCedente;
        listaTP[I].FdataEmissao     := tituloPagar.FdataEmissao;
        listaTP[I].FnumeroDocumento := tituloPagar.FnumeroDocumento;




       qryPesquisa.Next;
     end;

  end;


except
raise Exception.Create('Erro ao tentar obter TITULOS EM ABERTO');

end;

 Result := listaTP
end;

class function TTituloPagarDAO.obterTodosPagosPorLote( titulo: TTituloPagarModel): TFDQuery;
var
qryPesquisa : TFDQuery;
cmd :string;

begin
dmConexao.conectarBanco;
qryPesquisa := TFDQuery.Create(nil);

try
   cmd := ' SELECT TP.ID_TITULO_PAGAR,'+
          ' TP.NUMERO_DOCUMENTO, '+
          ' TP.valor_nominal,  '+
          ' TP.DESCRICAO,    '+
          ' TP.id_lote_pagamento,    '+
          ' C.nome,  C.id_cedente    '+
          ' FROM TITULO_PAGAR TP    '+
          ' LEFT OUTER JOIN CEDENTE C ON (C.ID_CEDENTE = TP.ID_CEDENTE) AND (C.ID_ORGANIZACAO = TP.ID_ORGANIZACAO) '+
          ' WHERE TP.ID_ORGANIZACAO = :PIDORGANIZACAO  AND TP.ID_LOTE_PAGAMENTO = :PIDLOTE ' +
          ' ORDER BY TP.VALOR_NOMINAL ' ;


  qryPesquisa.Close;
  qryPesquisa.Connection := dmConexao.conn;
  qryPesquisa.SQL.Clear;
  qryPesquisa.SQL.Add(cmd);
  qryPesquisa.ParamByName('PIDORGANIZACAO').AsString := titulo.FIDorganizacao;
  qryPesquisa.ParamByName('PIDLOTE').AsString := titulo.FIDLotePagamento;


  qryPesquisa.Open;


except

raise Exception.Create('Erro ao tentar obter TITULO POR LOTE PAGTO');

end;

 Result := qryPesquisa;
end;


class function TTituloPagarDAO.obterTodosPorStatus( titulo: TTituloPagarModel): TFDQuery;
var
qryPesquisa : TFDQuery;
cmd :string;

begin
dmConexao.conectarBanco;
try
   cmd := 'SELECT *  FROM TITULO_PAGAR  WHERE ID_ORGANIZACAO = :PIDORGANIZACAO  AND ID_TIPO_STATUS = :PSTATUS ' ;


  qryPesquisa := TFDQuery.Create(nil);
  qryPesquisa.Close;
  qryPesquisa.Connection := dmConexao.conn;
  qryPesquisa.SQL.Clear;
  qryPesquisa.SQL.Add(cmd);
  qryPesquisa.ParamByName('PIDORGANIZACAO').AsString := titulo.FIDorganizacao;
  qryPesquisa.ParamByName('PSTATUS').AsString := titulo.FIDTipoStatus;


   if titulo.FIDTipoStatus.Equals('QUITADO') then begin

   cmd := 'SELECT *  FROM TITULO_PAGAR  WHERE ID_ORGANIZACAO = :PIDORGANIZACAO '+
          ' AND ID_LOTE_CONTABIL IS NULL '+
        // SABER PQ ESSA DATA  ' AND DATA_PAGAMENTO > ''01.01.2019'' '+
          ' AND ID_TIPO_STATUS IN (''QUITADO'', ''PARCIAL'')' ;

      qryPesquisa := TFDQuery.Create(nil);
      qryPesquisa.Close;
      qryPesquisa.Connection := dmConexao.conn;
      qryPesquisa.SQL.Clear;
      qryPesquisa.SQL.Add(cmd);
      qryPesquisa.ParamByName('PIDORGANIZACAO').AsString := titulo.FIDorganizacao;

   end;




  qryPesquisa.Open;


except
raise Exception.Create('Erro ao tentar obter TITULO POR STATUS');

end;

 Result := qryPesquisa;
end;


class function TTituloPagarDAO.particionar(tituloNovo,  tituloAntigo: TTituloPagarModel): Boolean;
begin
   Result := System.False;
  try
    dmConexao.conn.StartTransaction;

    if Update(tituloAntigo) then
    begin
      Insert(tituloNovo);
    end;

    dmConexao.conn.CommitRetaining;

  except
    dmConexao.conn.RollbackRetaining;
    raise Exception.Create('Erro ao tentar particionar o TP ' + tituloAntigo.FnumeroDocumento);

  end;

  Result := System.True;

end;

class function TTituloPagarDAO.Update(titulo: TTituloPagarModel): Boolean;
var
qryUpdate : TFDQuery;
cmdSql :string;
begin
dmConexao.conectarBanco;
qryUpdate := TFDQuery.Create(nil);
  try

    try

cmdSql := ' UPDATE TITULO_PAGAR '+
            ' SET ID_HISTORICO                = :PIDHISTORICO, '+
            ' ID_CEDENTE                      = :PIDCEDENTE, '+
            ' ID_TIPO_COBRANCA                = :PIDTIPO_COBRANCA, '+
            ' ID_RESPONSAVEL                  = :PIDRESPONSAVEL, '+
            ' ID_LOCAL_PAGAMENTO              = :PIDLOCAL_PAGAMENTO,'+
            ' ID_TIPO_STATUS                  = :PIDTIPO_STATUS, '+
            ' ID_CENTRO_CUSTO                 = :PIDCENTRO_CUSTO,'+
            ' ID_TITULO_GERADOR               = :PIDTITULO_GERADOR,'+
            ' ID_NOTA_FISCAL_ENTRADA          = :PIDNOTA_FISCAL_ENTRADA,'+
            ' NUMERO_DOCUMENTO                = :PNUMERO_DOCUMENTO, '+
            ' DESCRICAO                       = :PDESCRICAO, '+
            ' DATA_REGISTRO                   = :PDATA_REGISTRO, '+
            ' DATA_EMISSAO                    = :PDATA_EMISSAO, '+
            ' DATA_PROTOCOLO                  = :PDATA_PROTOCOLO,'+
            ' DATA_VENCIMENTO                 = :PDATA_VENCIMENTO,'+
            ' DATA_PAGAMENTO                  = :PDATA_PAGAMENTO,'+
            ' PREVISAO_CARTORIO               = :PPREVISAO_CARTORIO,'+
            ' DATA_ULTIMA_ATUALIZACAO         = :PDATA_ULTIMA_ATUALIZACAO,'+
            ' VALOR_NOMINAL                   = :PVALOR_NOMINAL, '+
            ' MOEDA                           = :PMOEDA, '+
            ' CARTEIRA                        = :PCARTEIRA, '+
            ' CODIGO_BARRAS                   = :PCODIGO_BARRAS, '+
            ' CONTRATO                        = :PCONTRATO, '+
            ' PARCELA                         = :PPARCELA, '+
            ' OBSERVACAO                      = :POBSERVACAO, '+
            ' VALOR_ANTECIPADO                = :PVALOR_ANTECIPADO, '+
            ' ID_LOTE_CONTABIL                = :PIDLOTE_CONTABIL, '+
            ' ID_USUARIO                      = :PIDUSUARIO, '+
            ' ID_LOTE_PAGAMENTO               = :PIDLOTE_PAGAMENTO, '+
            ' ID_CONTA_BANCARIA_CHEQUE        = :PIDCONTA_BANCARIA_CHEQUE, '+
            ' ID_CONTA_CONTABIL_CREDITO       = :PIDCONTA_CONTABIL_CREDITO, '+
            ' ID_CONTA_CONTABIL_DEBITO        = :PIDCONTA_CONTABIL_DEBITO, '+
            ' REGISTRO_PROVISAO               = :PREGISTRO_PROVISAO, '+
            ' ID_LOTE_TPB                     = :PIDLOTE_TPB '+

         ' WHERE (ID_TITULO_PAGAR = :PID ) AND (ID_ORGANIZACAO = :PIDORGANIZACAO ) ' ;



    qryUpdate.Close;
    qryUpdate.Connection := dmConexao.conn;
    qryUpdate.SQL.Clear;
    qryUpdate.SQL.Add(cmdSql);
    qryUpdate.ParamByName('PID').AsString                         := titulo.FID;
    qryUpdate.ParamByName('PIDORGANIZACAO').AsString              := titulo.FIDorganizacao;
    qryUpdate.ParamByName('PIDUSUARIO').AsString                  := titulo.FIDUsuario;
    qryUpdate.ParamByName('PIDRESPONSAVEL').AsString              := titulo.FIDResponsavel;
    qryUpdate.ParamByName('PIDLOTE_CONTABIL').AsString            := titulo.FIDLoteContabil;
    qryUpdate.ParamByName('PIDHISTORICO').AsString                := titulo.FIDHistorico;
    qryUpdate.ParamByName('PIDCEDENTE').AsString                  := titulo.FIDCedente;
    qryUpdate.ParamByName('PIDLOTE_TPB').AsString                 := titulo.FIDLoteTPB;
    qryUpdate.ParamByName('PIDTIPO_COBRANCA').AsString            := titulo.FIDTipoCobranca;
    qryUpdate.ParamByName('PIDLOCAL_PAGAMENTO').AsString          := titulo.FIDLocalPagamento;
    qryUpdate.ParamByName('PIDTIPO_STATUS').AsString              := titulo.FIDTipoStatus;
    qryUpdate.ParamByName('PIDCENTRO_CUSTO').AsString             := titulo.FIDCentroCusto;
    qryUpdate.ParamByName('PIDNOTA_FISCAL_ENTRADA').AsString      := titulo.FIDNotaFiscalEntrada;
    qryUpdate.ParamByName('PIDTITULO_GERADOR').AsString           := titulo.FIDTituloPagarAnterior;
    qryUpdate.ParamByName('PIDLOTE_PAGAMENTO').AsString           := titulo.FIDLotePagamento;
    qryUpdate.ParamByName('PIDCONTA_CONTABIL_DEBITO').AsString    := titulo.FIDContaContabilDebito;
    qryUpdate.ParamByName('PIDCONTA_CONTABIL_CREDITO').AsString   := titulo.FIDContaContabilCredito;
    qryUpdate.ParamByName('PIDCONTA_BANCARIA_CHEQUE').AsString    := titulo.FIDCBChequeVinculado;

    qryUpdate.ParamByName('PDESCRICAO').AsString                  := titulo.Fdescricao;
    qryUpdate.ParamByName('POBSERVACAO').AsString                 := titulo.Fobservacao;
    qryUpdate.ParamByName('PPARCELA').AsString                    := titulo.Fparcela;
    qryUpdate.ParamByName('PCONTRATO').AsString                   := titulo.Fcontrato;
    qryUpdate.ParamByName('PCODIGO_BARRAS').AsString              := titulo.FcodigoBarras;
    qryUpdate.ParamByName('PCARTEIRA').AsString                   := titulo.Fcarteira;
    qryUpdate.ParamByName('PMOEDA').AsString                      := titulo.Fmoeda;
    qryUpdate.ParamByName('PREGISTRO_PROVISAO').AsString          := titulo.FregistroProvisao;
    qryUpdate.ParamByName('PNUMERO_DOCUMENTO').AsString           := titulo.FnumeroDocumento;

    qryUpdate.ParamByName('PDATA_REGISTRO').AsDateTime            := titulo.FdataRegistro;
    qryUpdate.ParamByName('PDATA_ULTIMA_ATUALIZACAO').AsDateTime  := titulo.FdataUltimaAtualizacao;
    qryUpdate.ParamByName('PPREVISAO_CARTORIO').AsDateTime        := titulo.FprevisaoCartorio;
    qryUpdate.ParamByName('PDATA_PAGAMENTO').AsDateTime           := titulo.FdataPagamento;
    qryUpdate.ParamByName('PDATA_VENCIMENTO').AsDateTime          := titulo.FdataVencimento;
    qryUpdate.ParamByName('PDATA_PROTOCOLO').AsDateTime           := titulo.FdataProtocolo;
    qryUpdate.ParamByName('PDATA_EMISSAO').AsDateTime             := titulo.FdataEmissao;

    qryUpdate.ParamByName('PVALOR_NOMINAL').AsCurrency            := titulo.FvalorNominal;
    qryUpdate.ParamByName('PVALOR_ANTECIPADO').AsCurrency         := titulo.FvalorAntecipado;

    if uUtil.Empty(titulo.FIDContaContabilDebito) then
    begin
      qryUpdate.ParamByName('PIDCONTA_CONTABIL_DEBITO').Value := null;
     end;
    if uUtil.Empty(titulo.FIDContaContabilCredito) then
    begin
      qryUpdate.ParamByName('PIDCONTA_CONTABIL_CREDITO').Value := null;
     end;
    if uUtil.Empty(titulo.FIDTituloPagarAnterior) then
    begin
      qryUpdate.ParamByName('PIDTITULO_GERADOR').Value := null;
     end;
    if uUtil.Empty(titulo.FIDNotaFiscalEntrada) then
    begin
      qryUpdate.ParamByName('PIDNOTA_FISCAL_ENTRADA').Value := null;
     end;
    if uUtil.Empty(titulo.FIDLoteContabil) then
    begin
      qryUpdate.ParamByName('PIDLOTE_CONTABIL').Value := null;
     end;
    if uUtil.Empty(titulo.FIDLoteTPB) then
    begin
      qryUpdate.ParamByName('PIDLOTE_TPB').Value := null;
    end;
    if uUtil.Empty(titulo.FIDLotePagamento) then
    begin
      qryUpdate.ParamByName('PIDLOTE_PAGAMENTO').Value := null;
    end;

    if uUtil.Empty(titulo.FIDCBChequeVinculado) then
    begin
      qryUpdate.ParamByName('PIDCONTA_BANCARIA_CHEQUE').Value := null;
    end;

    if uUtil.Empty(titulo.FregistroProvisao) then
    begin
      qryUpdate.ParamByName('PREGISTRO_PROVISAO').Value := null;
    end;

    qryUpdate.ExecSQL;
    dmConexao.conn.CommitRetaining;

    except
      Result := False;
      dmConexao.conn.RollbackRetaining;

      raise Exception.Create('Erro ao tentar alterar TITULO');

    end;

    Result := System.True;
  finally
    if Assigned(qryUpdate) then
    begin
      FreeAndNil(qryUpdate);
    end;
  end;


end;

class function TTituloPagarDAO.existFilhos(titulo: TTituloPagarModel): Boolean;
var
qryPesquisa : TFDQuery;
cmd :string;

begin
Result := False;

dmConexao.conectarBanco;
try
   cmd := 'SELECT  ID_TITULO_PAGAR  FROM TITULO_PAGAR  WHERE ID_ORGANIZACAO = :PIDORGANIZACAO  AND ID_TITULO_GERADOR = :PFILHO' ;


  qryPesquisa := TFDQuery.Create(nil);
  qryPesquisa.Close;
  qryPesquisa.Connection := dmConexao.conn;
  qryPesquisa.SQL.Clear;
  qryPesquisa.SQL.Add(cmd);
  qryPesquisa.ParamByName('PIDORGANIZACAO').AsString := titulo.FIDorganizacao;
  qryPesquisa.ParamByName('PFILHO').AsString := titulo.FID;

  qryPesquisa.Open;


except
raise Exception.Create('Erro ao tentar consultar o filho do TP');

end;

 Result := not qryPesquisa.IsEmpty;

end;


class function TTituloPagarDAO.getTP(query: TFDQuery): TTituloPagarModel;
var
tituloPagar     : TTituloPagarModel;
cedente         : TCedenteModel;
loteContabil    : TLoteContabilModel;
lotePagto       : TLotePagamentoModel;
historico       : THistoricoModel;
centroCusto     : TCentroCustoModel;
responsavel     : TFuncionarioModel;
status          : TTipoStatusModel;
notafiscal      : TNotaFiscalEntradaModel;

begin
  tituloPagar     := TTituloPagarModel.Create;
  cedente         := TCedenteModel.Create;
  loteContabil    := TLoteContabilModel.Create ;
  lotePagto       := TLotePagamentoModel.Create ;
  historico       := THistoricoModel.Create ;
  centroCusto     := TCentroCustoModel.Create ;
  responsavel     := TFuncionarioModel.Create ;
  status          := TTipoStatusModel.Create;
  notafiscal      := TNotaFiscalEntradaModel.Create;


  tituloPagar.listaHistorico := TObjectList<TTituloPagarHistoricoModel>.Create;
  tituloPagar.listaCustos := TObjectList<TTituloPagarCentroCustoModel>.Create;


  if not query.IsEmpty then begin

      tituloPagar.FID                     := query.FieldByName('ID_TITULO_PAGAR').AsString;
      tituloPagar.FIDorganizacao          := query.FieldByName('ID_ORGANIZACAO').AsString;
      tituloPagar.FIDusuario              := query.FieldByName('ID_USUARIO').AsString;
      tituloPagar.FIDResponsavel          := query.FieldByName('ID_RESPONSAVEL').AsString;
      tituloPagar.FIDloteContabil         := query.FieldByName('ID_LOTE_CONTABIL').AsString;
      tituloPagar.FIDLoteTPB              := query.FieldByName('ID_LOTE_TPB').AsString;
      tituloPagar.FIDHistorico            := query.FieldByName('ID_HISTORICO').AsString;
      tituloPagar.FIDCedente              := query.FieldByName('ID_CEDENTE').AsString;
      tituloPagar.FIDTipoCobranca         := query.FieldByName('ID_TIPO_COBRANCA').AsString;
      tituloPagar.FIDLocalPagamento       := query.FieldByName('ID_LOCAL_PAGAMENTO').AsString;
      tituloPagar.FIDTipoStatus           := query.FieldByName('ID_TIPO_STATUS').AsString;
      tituloPagar.FIDCentroCusto          := query.FieldByName('ID_CENTRO_CUSTO').AsString;
      tituloPagar.FIDNotaFiscalEntrada    := query.FieldByName('ID_NOTA_FISCAL_ENTRADA').AsString;
      tituloPagar.FIDTituloPagarAnterior  := query.FieldByName('ID_TITULO_GERADOR').AsString;
      tituloPagar.FIDLotePagamento        := query.FieldByName('ID_LOTE_PAGAMENTO').AsString;
      tituloPagar.FIDContaContabilDebito  := query.FieldByName('ID_CONTA_CONTABIL_DEBITO').AsString;
      tituloPagar.FIDContaContabilCredito := query.FieldByName('ID_CONTA_CONTABIL_CREDITO').AsString;
      tituloPagar.FIDCBChequeVinculado    := query.FieldByName('ID_CONTA_BANCARIA_CHEQUE').AsString;
      tituloPagar.Fdescricao              := query.FieldByName('DESCRICAO').AsString;
      tituloPagar.Fobservacao             := query.FieldByName('OBSERVACAO').AsString;
      tituloPagar.Fparcela                := query.FieldByName('PARCELA').AsString;
      tituloPagar.Fcontrato               := query.FieldByName('CONTRATO').AsString;
      tituloPagar.FcodigoBarras           := query.FieldByName('CODIGO_BARRAS').AsString;
      tituloPagar.Fcarteira               := query.FieldByName('CARTEIRA').AsString;
      tituloPagar.Fmoeda                  := query.FieldByName('MOEDA').AsString;
      tituloPagar.FregistroProvisao       := query.FieldByName('REGISTRO_PROVISAO').AsString;
      tituloPagar.FnumeroDocumento        := query.FieldByName('NUMERO_DOCUMENTO').AsString;

      tituloPagar.FdataRegistro           := query.FieldByName('DATA_REGISTRO').AsDateTime;
      tituloPagar.FdataUltimaAtualizacao  := query.FieldByName('DATA_ULTIMA_ATUALIZACAO').AsDateTime;
      tituloPagar.FprevisaoCartorio       := query.FieldByName('PREVISAO_CARTORIO').AsDateTime;
      tituloPagar.FdataPagamento          := query.FieldByName('DATA_PAGAMENTO').AsDateTime;
      tituloPagar.FdataVencimento         := query.FieldByName('DATA_VENCIMENTO').AsDateTime;
      tituloPagar.FdataProtocolo          := query.FieldByName('DATA_PROTOCOLO').AsDateTime;
      tituloPagar.FdataEmissao            := query.FieldByName('DATA_EMISSAO').AsDateTime;

      tituloPagar.FvalorNominal           := query.FieldByName('VALOR_NOMINAL').AsCurrency;
      tituloPagar.FvalorAntecipado        := query.FieldByName('VALOR_ANTECIPADO').AsCurrency;




    try

      cedente.FID            := tituloPagar.FIDCedente;
      cedente.FIDorganizacao := tituloPagar.FIDorganizacao;
      tituloPagar.FCedente   := TCedenteDAO.obterPorID(cedente);


      tituloPagar.listaHistorico.Clear;
      tituloPagar.listaHistorico := obterRateioHistorico(tituloPagar);

      tituloPagar.listaCustos.Clear;
      tituloPagar.listaCustos := obterRateioCC(tituloPagar);


      lotePagto.FID               := tituloPagar.FIDLotePagamento;
      lotePagto.FIDorganizacao    := tituloPagar.FIDorganizacao;
      tituloPagar.FLotePagamento  := TLotePagamentoDAO.obterPorID(lotePagto);


      loteContabil.FID            := tituloPagar.FIDLoteContabil;
      loteContabil.FIDorganizacao := tituloPagar.FIDorganizacao;
      tituloPagar.FLoteContabil   := TLoteContabilDAO.obterPorID(loteContabil);

      if uutil.Empty(loteContabil.FID) then begin
        if not uutil.Empty(tituloPagar.FIDLoteTPB) then begin

          loteContabil.FID            := tituloPagar.FIDLoteTPB;
          loteContabil.FIDorganizacao := tituloPagar.FIDorganizacao;
          tituloPagar.FLoteContabil   := TLoteContabilDAO.obterPorID(loteContabil);

        end;

      end;


      historico.FID               := tituloPagar.FIDHistorico;
      historico.FIdOrganizacao    := tituloPagar.FIDorganizacao;
      tituloPagar.FHistorico      := THistoricoDAO.obterPorID(historico);

      centroCusto.FID             := tituloPagar.FIDCentroCusto;
      centroCusto.FIdOrganizacao  := tituloPagar.FIDorganizacao;
      tituloPagar.FCentroCustos   := TCentroCustoDAO.obterPorID(centroCusto);


      responsavel.FID             := tituloPagar.FIDResponsavel;
      responsavel.FIdOrganizacao  := tituloPagar.FIDorganizacao;
      tituloPagar.FResponsavel    := TFuncionarioDAO.obterPorID(responsavel);

      status.FID                  := tituloPagar.FIDTipoStatus;
      status.FIdOrganizacao       := tituloPagar.FIDorganizacao;
      tituloPagar.FTipoStatus     := TTipoStatusDAO.obterPorID(status);

      notafiscal.FID              := tituloPagar.FIDNotaFiscalEntrada;
      notafiscal.FIDorganizacao   := tituloPagar.FIDorganizacao;
      tituloPagar.FNotaFiscalEntrada := TNotaFiscalEntradaDAO.obterPorID(notafiscal);



    except
      raise Exception.Create('Erro ao tentar obter detalhes por TP.');

    end;



  end;


  Result := tituloPagar;

end;
end.