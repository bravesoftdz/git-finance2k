unit uTPBaixaDAO;


interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, FireDAC.Stan.Intf, FireDAC.Stan.Option,
  FireDAC.Stan.Param, FireDAC.Stan.Error, FireDAC.DatS, FireDAC.Phys.Intf,  uTPBaixaModel, uTPBaixaInternetModel, uTPBaixaInternetDAO,
  FireDAC.DApt.Intf, FireDAC.Stan.Async, FireDAC.DApt, Data.DB, uTituloPagarModel, udmConexao, uUtil,
  FireDAC.Comp.DataSet, FireDAC.Comp.Client,uTPBaixaChequeModel, uContaBancariaChequeModel, uContaBancariaChequeDAO,
  System.Generics.Collections, uTPBaixaFPModel, uTPBaixaFPDAO, uTPBaixaChequeDAO,uContaBancariaDBModel, uContaBancariaDebitoDAO,
  uTituloPagarDAO, uTPBaixaDEDAO, uTPBaixaDEModel, uTPBaixaACModel,uTPBaixaACDAO, uTesourariaDBModel, uTesourariaDBDAO,
  uTituloPagarHistoricoModel, uTituloPagarCentroCustoModel,   uTituloPagarHistoricoDAO, uTituloPagarCentroCustoDAO  ;


type
 TTPBaixaDAO = class
  private
    class function getTPB (query :TFDQuery) : TTPBaixaModel;
  public
    {m�todos CRUD (Create, Read, Update e Delete)
    para manipula��o dos dados}

    class function Insert(value :TTPBaixaModel): Boolean;
    class function obterPorTP(value :TTPBaixaModel): TTPBaixaModel;
    class function obterPorID (value :TTPBaixaModel): TTPBaixaModel;
    class function Delete(value :TTPBaixaModel): Boolean;
    class function salvarBaixa (baixa :TTPBaixaModel; titulo : TTituloPagarModel ): Boolean;

  end;

implementation

{ TTPBaixaDAO }

class function TTPBaixaDAO.Delete(value: TTPBaixaModel): Boolean;
var
qryDelete : TFDQuery;
xResp :Boolean;
begin
xResp := False;
 dmConexao.conectarBanco;
 try

  qryDelete := TFDQuery.Create(nil);
  qryDelete.Close;
  qryDelete.Connection := dmConexao.conn;
  qryDelete.SQL.Clear;
  qryDelete.SQL.Add(' DELETE FROM TITULO_PAGAR_BAIXA  '  );
  qryDelete.SQL.Add(' WHERE ID_ORGANIZACAO = :PIDORGANIZACAO  AND  ID_TITULO_PAGAR_BAIXA = :PID '  );
  qryDelete.ParamByName('PIDORGANIZACAO').AsString := value.FIDorganizacao;
  qryDelete.ParamByName('PID').AsString := value.FID;

  qryDelete.ExecSQL;
  xResp := True;
    //o comit fica na transacao

 except
 xResp := False;
 raise Exception.Create('Erro ao tentar DELETAR TITULO Pago');

 end;

  Result := xResp;
end;
class function TTPBaixaDAO.Insert(value: TTPBaixaModel): Boolean;
var
qryInsert : TFDQuery;
cmdSql :string;
begin
  dmConexao.conectarBanco;
  qryInsert := TFDQuery.Create(nil);

  try
    try

   cmdSql := ' INSERT INTO TITULO_PAGAR_BAIXA '+
           ' (ID_TITULO_PAGAR_BAIXA, ID_ORGANIZACAO, ID_TITULO_PAGAR,'+
           ' ID_CENTRO_CUSTO, ID_LOTE_CONTABIL, ID_USUARIO, ID_RESPONSAVEL, '+
           ' VALOR_PAGO, DATA_REGISTRO, TIPO_BAIXA, ID_LOTE_PAGAMENTO ) ' +
           ' VALUES (:PID,:PIDORGANIZACAO,:PIDTITULO_PAGAR, '+
           ' :PIDCENTRO_CUSTO, :PIDLOTE_CONTABIL, :PIDUSUARIO, :PIDRESPONSAVEL, '+
           ' :PVALOR_PAGO,:PDATA_REGISTRO, :PTIPO_BAIXA,:PIDLOTE_PAGAMENTO )';


    qryInsert.Close;
    qryInsert.Connection := dmConexao.conn;
    qryInsert.SQL.Clear;
    qryInsert.SQL.Add(cmdSql);
    qryInsert.ParamByName('PID').AsString                         := value.FID;
    qryInsert.ParamByName('PIDTITULO_PAGAR').AsString             := value.FIDtituloPagar;
    qryInsert.ParamByName('PIDORGANIZACAO').AsString              := value.FIDorganizacao;
    qryInsert.ParamByName('PIDUSUARIO').AsString                  := value.FIDUsuario;
    qryInsert.ParamByName('PIDRESPONSAVEL').AsString              := value.FIDResponsavel;
    qryInsert.ParamByName('PIDLOTE_CONTABIL').AsString            := value.FIDLoteContabil;
    qryInsert.ParamByName('PIDCENTRO_CUSTO').AsString             := value.FIDCentroCusto;
    qryInsert.ParamByName('PTIPO_BAIXA').AsString                 := value.FtipoBaixa;
    qryInsert.ParamByName('PIDLOTE_PAGAMENTO').AsString           := value.FIDlotePagamento;
    qryInsert.ParamByName('PDATA_REGISTRO').AsDateTime            := value.FdataRegistro;
    qryInsert.ParamByName('PVALOR_PAGO').AsCurrency               := value.FvalorPago;

      if uUtil.Empty(value.FIDloteContabil) then
      begin
        qryInsert.ParamByName('PIDLOTE_CONTABIL').Value := null;
      end;

      if uUtil.Empty(value.FIDtituloPagar) then
      begin
        qryInsert.ParamByName('PIDTITULO_PAGAR').AsString := value.FTituloPagar.FID;
      end;

      if uUtil.Empty(value.FIDlotePagamento) then
      begin
        qryInsert.ParamByName('PIDLOTE_PAGAMENTO').Value := null;
      end;

      qryInsert.ExecSQL;

    except
      Result := False;
      raise Exception.Create('Erro ao tentar inserir TITULO Pago');
    end;
    Result := System.True;
  finally
    if Assigned(qryInsert) then
    begin
      FreeAndNil(qryInsert);
    end;
  end;

end;

class function TTPBaixaDAO.obterPorID(value: TTPBaixaModel): TTPBaixaModel;
var
qryPesquisa : TFDQuery;
tpb: TTPBaixaModel;
begin
dmConexao.conectarBanco;
try
  qryPesquisa := TFDQuery.Create(nil);
  qryPesquisa.Close;
  qryPesquisa.Connection := dmConexao.conn;
  qryPesquisa.SQL.Clear;
  qryPesquisa.SQL.Add('SELECT * '  );
  qryPesquisa.SQL.Add('FROM TITULO_PAGAR_BAIXA  '  );
  qryPesquisa.SQL.Add('WHERE ID_ORGANIZACAO = :PIDORGANIZACAO  AND  ID_TITULO_PAGAR_BAIXA = :PID '  );

  qryPesquisa.ParamByName('PIDORGANIZACAO').AsString := value.FIDorganizacao;
  qryPesquisa.ParamByName('PID').AsString := value.FID;
  qryPesquisa.Open;

  if not qryPesquisa.IsEmpty then begin
      tpb := TTPBaixaModel.Create;
      tpb := getTPB(qryPesquisa);
  end;


except
raise Exception.Create('Erro ao tentar obter TITULO PAGO ID');

end;

 Result := tpb;
end;


class function TTPBaixaDAO.obterPorTP(value: TTPBaixaModel): TTPBaixaModel;
var
qryPesquisa : TFDQuery;
tpb: TTPBaixaModel;
begin
dmConexao.conectarBanco;
try
  qryPesquisa := TFDQuery.Create(nil);
  qryPesquisa.Close;
  qryPesquisa.Connection := dmConexao.conn;
  qryPesquisa.SQL.Clear;
  qryPesquisa.SQL.Add('SELECT * '  );
  qryPesquisa.SQL.Add('FROM TITULO_PAGAR_BAIXA  '  );
  qryPesquisa.SQL.Add('WHERE ID_ORGANIZACAO = :PIDORGANIZACAO  AND  ID_TITULO_PAGAR = :PIDTP '  );

  qryPesquisa.ParamByName('PIDORGANIZACAO').AsString := value.FIDorganizacao;
  qryPesquisa.ParamByName('PIDTP').AsString := value.FIDtituloPagar;
  qryPesquisa.Open;

  if not qryPesquisa.IsEmpty then begin
      tpb                         := TTPBaixaModel.Create;
      tpb := getTPB(qryPesquisa);
  end;

except
raise Exception.Create('Erro ao tentar obter TITULO PAGO IDTP');

end;

 Result := tpb;
end;


class function TTPBaixaDAO.salvarBaixa(baixa: TTPBaixaModel; titulo: TTituloPagarModel): Boolean;
var
  formaPagto    : TTPBaixaFPModel;
  acrescimo     : TTPBaixaACModel;
  deducao       : TTPbaixaDEModel;
  pagtoCheque   : TTPBaixaChequeModel;
  pagtoWWW      : TTPBaixaInternetModel;
  cheque        : TContaBancariaChequeModel;
  contaBancoDB  : TContaBancariaDBModel;
  debitoCaixa   : TTesourariaDBModel;

  A,D,FP : Integer;
listaHistorico :  TObjectList<TTituloPagarHistoricoModel>;
listaCustos    :  TObjectList<TTituloPagarCentroCustoModel>;
historico : TTituloPagarHistoricoModel  ;
centroCusto : TTituloPagarCentroCustoModel;
 qtdRateioC, qtdRateioH, I :Integer;
 valorNominal, valorAntecipado :Currency;

begin
  qtdRateioH :=0;
  qtdRateioC  :=0;
  I:=0;
  valorNominal     := titulo.FvalorNominal ;


 dmConexao.conectarBanco;

try
 dmConexao.conn.StartTransaction;

  //TPBAIXA
  try
     Insert(baixa);
  except
   raise Exception.Create('Erro ao tentar inserir TPB');
  end;

  //TP
  try
   qtdRateioH := titulo.listaHistorico.Count;
   qtdRateioC := titulo.listaCustos.Count;

   for I := 0 to qtdRateioH -1  do begin

     historico := TTituloPagarHistoricoModel.Create;
     historico.FID                    := titulo.listaHistorico[I].FID;
     historico.FIDorganizacao         := titulo.listaHistorico[I].FIDorganizacao;
     historico.FIDHistorico           := titulo.listaHistorico[I].FIDHistorico;
     historico.FIDContaContabilDebito := titulo.listaHistorico[I].FIDContaContabilDebito;
     historico.FIDTP                  := titulo.FID;
     historico.Fvalor                 := valorNominal;

     titulo.listaHistorico.Clear;
     titulo.AdicionarHST(historico);
     try
     // atualiza o historico TP
      TTituloPagarHistoricoDAO.Update(titulo.listaHistorico[0]);
     except
     raise Exception.Create('Erro ao tentar atualizar o historico do TP');


     end;


   end;

   for I := 0 to qtdRateioC -1  do begin

     centroCusto                        := TTituloPagarCentroCustoModel.Create;

     centroCusto.FID                    := titulo.listaCustos[I].FID;
     centroCusto.FIDorganizacao         := titulo.listaCustos[I].FIDorganizacao;
     centroCusto.FIDCentroCusto         := titulo.listaCustos[I].FIDCentroCusto;
     centroCusto.FIDTP                  := titulo.FID;
     centroCusto.Fvalor                 := valorNominal;
     titulo.listaCustos.Clear;
     titulo.AdicionarCC(centroCusto);
     try
     //  atualiza o centro custo
      TTituloPagarCentroCustoDAO.Update(titulo.listaCustos[0]);
     except
     raise Exception.Create('Erro ao tentar atualizar o centro de custo do TP');

     end;

   end;

   TTituloPagarDAO.Update(titulo);

  except
   raise Exception.Create('Erro ao tentar alterar TP');
  end;

   //inserido os acrescimos
   for A := 0 to baixa.listaAcrescimo.Count -1 do begin

       acrescimo     := TTPBaixaACModel.Create;
       acrescimo     := baixa.listaAcrescimo[A];

        try
            TTPBaixaACDAO.Insert(acrescimo);
          except
            raise Exception.Create('Erro ao tentar inserir acrescimo');
          end;

   end;


    //inserido os acrescimos
   for D := 0 to baixa.listaDeducao.Count -1 do begin

       deducao     := TTPBaixaDEModel.Create;
       deducao     := baixa.listaDeducao[D];

        try
            TTPBaixaDEDAO.Insert(deducao);
          except
            raise Exception.Create('Erro ao tentar inserir dedu��o');
          end;

   end;

  for FP   := 0 to baixa.listaFormasPagto.Count -1 do begin
      if baixa.listaFormasPagto[FP].FFormaPagamento.FID.Equals('CHEQUE') then begin
        //TPBAIXA_CHEQUE   //SALVA O TPBAIXA_FP
        formaPagto                  :=  TTPBaixaFPModel.Create;
        formaPagto.FIDorganizacao   :=  baixa.FIDorganizacao;
        formaPagto.FID              :=  baixa.listaFormasPagto[FP].FID;
        formaPagto.FIDTPBaixa       :=  baixa.listaFormasPagto[FP].FIDTPBaixa;
        formaPagto.FValor           :=  baixa.listaFormasPagto[FP].FValor;
        formaPagto.FFormaPagamento  :=  baixa.listaFormasPagto[FP].FFormaPagamento;

       if TTPBaixaFPDAO.Insert(formaPagto) then begin

       //PAGAMENTO REALIZADO EM CHEQUE
           pagtoCheque := TTPBaixaChequeModel.Create;
           pagtoCheque := baixa.FTPBaixaCheque;

          try
            TTPBaixaChequeDAO.Insert(pagtoCheque);
          except
            raise Exception.Create('Erro ao tentar inserir TPBCheque');
          end;

           cheque      := TContaBancariaChequeModel.Create;
           cheque      := pagtoCheque.FCheque;

            try
             TContaBancariaChequeDAO.Update(cheque);
          except
            raise Exception.Create('Erro ao tentar emitir o cheque');
         end;

       end;

      end; // fim da FP em cheque
   end;



        for FP := 0 to baixa.listaFormasPagto.Count -1 do begin
      // INTERNET BANK

       if baixa.listaFormasPagto[FP].FFormaPagamento.FID.Equals('INTERNET BANK') then begin
        //TPBAIXA_CHEQUE   //SALVA O TPBAIXA_FP
        formaPagto                  :=  TTPBaixaFPModel.Create;
        formaPagto.FIDorganizacao   :=  baixa.FIDorganizacao;
        formaPagto.FID              :=  baixa.listaFormasPagto[FP].FID;
        formaPagto.FIDTPBaixa       :=  baixa.listaFormasPagto[FP].FIDTPBaixa;
        formaPagto.FValor           :=  baixa.listaFormasPagto[FP].FValor;
        formaPagto.FFormaPagamento  :=  baixa.listaFormasPagto[FP].FFormaPagamento;

       if TTPBaixaFPDAO.Insert(formaPagto) then begin
          //PAGAMENTO REALIZADO via banco online
          // TITULO_RECEBER_BAIXA_INTERNET
           pagtoWWW := TTPBaixaInternetModel.Create;
           pagtoWWW := baixa.FTPBaixaWWW;
           pagtoWWW.FID := dmConexao.obterNewID;
           pagtoWWW.FIDTPB := baixa.FID;


          try
            TTPBaixaInternetDAO.Insert(pagtoWWW);
          except
            raise Exception.Create('Erro ao tentar inserir TPBWWW');
          end;

           //CBD
           contaBancoDB                   := TContaBancariaDBModel.Create;
           contaBancoDB.FIDorganizacao    := baixa.FIDorganizacao;
           contaBancoDB.FID               := dmConexao.obterNewID;
           contaBancoDB.Fidentificacao    := dmConexao.obterIdentificador(baixa.FIDorganizacao,'CBD');
           contaBancoDB.FIDusuario        := baixa.FIDusuario;
           contaBancoDB.FIDResponsavel    := baixa.FIDResponsavel;
           contaBancoDB.FIDTOB            := pagtoWWW.FIDTOB;
           contaBancoDB.FIDTP             := titulo.FID;
           contaBancoDB.FtipoLancamento   := 'D' ;
           contaBancoDB.Fdescricao        := 'PAGTO DOC ' + titulo.FnumeroDocumento ;
           contaBancoDB.FIDcontaBancaria  := pagtoWWW.FIDcontaBancariaOrigem;
           contaBancoDB.Fvalor            := pagtoWWW.Fvalor;
           contaBancoDB.FdataMovimento    := pagtoWWW.FdataOperacao;
           contaBancoDB.FdataRegistro     := Now;

          try
            TContaBancariaDebitoDAO.Insert(contaBancoDB);
          except
            raise Exception.Create('Erro ao tentar lanc�ar o d�bito na conta banc�ria');
          end;


       end;

      end; // fim da FP via bank line

     end;

   for FP := 0 to baixa.listaFormasPagto.Count -1 do begin

      //ESPECIE
      if baixa.listaFormasPagto[FP].FFormaPagamento.FID.Equals('ESPECIE') then begin
        //TPBAIXA_CHEQUE   //SALVA O TPBAIXA_FP
        formaPagto                  :=  TTPBaixaFPModel.Create;
        formaPagto.FIDorganizacao   :=  baixa.FIDorganizacao;
        formaPagto.FID              :=  baixa.listaFormasPagto[FP].FID;
        formaPagto.FIDTPBaixa       :=  baixa.listaFormasPagto[FP].FIDTPBaixa;
        formaPagto.FValor           :=  baixa.listaFormasPagto[FP].FValor;
        formaPagto.FFormaPagamento  :=  baixa.listaFormasPagto[FP].FFormaPagamento;

        if TTPBaixaFPDAO.Insert(formaPagto) then
        begin
          //PAGAMENTO REALIZADO via CAIXA
           //TESOURARIA_DEBITO
          debitoCaixa := TTesourariaDBModel.Create;
          debitoCaixa.FIDorganizacao := baixa.FIDorganizacao;
          debitoCaixa.FID := dmConexao.obterNewID;
          debitoCaixa.FnumeroDocumento := dmConexao.obterIdentificador(baixa.FIDorganizacao, 'TD');
          debitoCaixa.FIDHistorico := 'PAGTO TITULO ESPECIE';
          debitoCaixa.FIDResponsavel := baixa.FIDResponsavel;
          debitoCaixa.FIDUsuario := baixa.FIDusuario;
          debitoCaixa.FIDCedente := titulo.FIDCedente;
          debitoCaixa.FIDTPB := baixa.FID;
          debitoCaixa.FvalorNominal := formaPagto.FValor;
          debitoCaixa.Fdescricao := ' TIT ' + titulo.FnumeroDocumento + ' ' + titulo.Fdescricao;
          debitoCaixa.FtipoLancamento := 'D';
          debitoCaixa.FdataRegistro := Now;
          debitoCaixa.FdataContabil := titulo.FdataPagamento;
          debitoCaixa.FdataMovimento := titulo.FdataPagamento;


          try
            TTesourariaDBDAO.Insert(debitoCaixa);
          except
            raise Exception.Create('Erro ao tentar lanc�ar o d�bito na tesouraria ');
          end;

        end;

      end; // fim da FP via tesouraria


  end;

  dmConexao.conn.CommitRetaining;

except
  Result := System.FAlse;
 dmConexao.conn.RollbackRetaining;
 raise Exception.Create('Erro ao tentar o pagamento do titulo ' + titulo.FnumeroDocumento );
end;
//PEGAR LISTA DE fp
   //LISTA DE AC
   //LISTA DE DE
    { baixa de TP pago em cheque
    1 - altera o TP (DATA_ULTIMA_ATUALIZACAO, DATA_PAGAMENTO)
    2 - salva o TPB
    3 - salva o TPB_FP
    4 - salva o TPB_Cheque
    5 - altera o cheque ( ID_TIPO_STATUS, VALOR, DATA_EMISSAO, OBSERVACAO,PORTADOR,  DATA_PREVISAO_COMPENSACAO, QTD_IMPRESSAO )
    6 - salvar CBD
    }


     Result := System.True;

end;

class function TTPBaixaDAO.getTPB(query: TFDQuery): TTPBaixaModel;
var
tpb: TTPBaixaModel;
begin
  tpb := TTPBaixaModel.Create;
 try

  if not query.IsEmpty then begin

      tpb                         := TTPBaixaModel.Create;
      tpb.FID                     := query.FieldByName('ID_TITULO_PAGAR_BAIXA').AsString;
      tpb.FIDorganizacao          := query.FieldByName('ID_ORGANIZACAO').AsString;
      tpb.FIDCentroCusto          := query.FieldByName('ID_CENTRO_CUSTO').AsString;
      tpb.FIDusuario              := query.FieldByName('ID_USUARIO').AsString;
      tpb.FIDResponsavel          := query.FieldByName('ID_RESPONSAVEL').AsString;
      tpb.FIDloteContabil         := query.FieldByName('ID_LOTE_CONTABIL').AsString;
      tpb.FIDlotePagamento        := query.FieldByName('ID_LOTE_PAGAMENTO').AsString;
      tpb.FIDtituloPagar          := query.FieldByName('ID_TITULO_PAGAR').AsString; //ver como montar o objeto
      tpb.FtipoBaixa              := query.FieldByName('TIPO_BAIXA').AsString;
      tpb.FdataRegistro           := query.FieldByName('DATA_REGISTRO').AsDateTime;
      tpb.FvalorPago              := query.FieldByName('VALOR_PAGO').AsCurrency;


     //preencher as cole��es

   // property listaFormasPagto: TObjectList<TTPBaixaFPModel> read FListaFormasPagto  write FListaFormasPagto;

   // property listaDeducao: TObjectList<TTPBaixaDEModel> read FlistaDeducao  write FlistaDeducao;
   // property listaAcrescimo: TObjectList<TTPBaixaACModel> read FlistaAcrescimo  write FlistaAcrescimo;







  end;

 except
 raise Exception.Create('Erro ao tentar converter o tpb em DAO. Informe erro ao suporte. ');
 end;

  Result := tpb;

end;



end.