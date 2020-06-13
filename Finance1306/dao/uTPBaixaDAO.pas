unit uTPBaixaDAO;


interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, FireDAC.Stan.Intf, FireDAC.Stan.Option,System.Math,
  FireDAC.Stan.Param, FireDAC.Stan.Error, FireDAC.DatS, FireDAC.Phys.Intf,  uTPBaixaModel, uTPBaixaInternetModel, uTPBaixaInternetDAO,
  FireDAC.DApt.Intf, FireDAC.Stan.Async, FireDAC.DApt, Data.DB, uTituloPagarModel, udmConexao, uUtil,
  FireDAC.Comp.DataSet, FireDAC.Comp.Client,uTPBaixaChequeModel, uContaBancariaChequeModel, uContaBancariaChequeDAO,
  System.Generics.Collections, uTPBaixaFPModel, uTPBaixaFPDAO, uTPBaixaChequeDAO,uContaBancariaDBModel, uContaBancariaDebitoDAO,
  uTituloPagarDAO, uTPBaixaDEDAO, uTPBaixaDEModel, uTPBaixaACModel,uTPBaixaACDAO, uTesourariaDBModel, uTesourariaDBDAO,
  uTituloPagarHistoricoModel, uTituloPagarCentroCustoModel,   uTituloPagarHistoricoDAO, uTituloPagarCentroCustoDAO,
   uOrganizacaoDAO, uOrganizacaoModel,  MDModel,MDDAO, uLotePagamentoModel, uLotePagamentoDAO, uFormaPagamentoDAO, uFormaPagamentoModel;

   const
   pTable : string = 'TITULO_PAGAR_BAIXA';

type
 TTPBaixaDAO = class
  private
    class function getTPB (query :TFDQuery) : TTPBaixaModel;
    class function registroMD(value: TTPBaixaModel; pAcao, pDsc,
      pStatus: string): Boolean; static;

  public
    {m�todos CRUD (Create, Read, Update e Delete)
    para manipula��o dos dados}

    class function Insert(value :TTPBaixaModel): Boolean;
    class function obterPorTP(value :TTPBaixaModel): TTPBaixaModel;
    class function obterPorID (value :TTPBaixaModel): TTPBaixaModel;
    class function Delete(value :TTPBaixaModel): Boolean;
    class function DeletePorTP(value :TTPBaixaModel): Boolean;
    class function ajustaRateioCC(value :TTPBaixaModel): Boolean;

    class function cancelarBaixa (titulo : TTituloPagarModel ): Boolean;
    class function salvarBaixa (baixa :TTPBaixaModel; titulo : TTituloPagarModel ): Boolean;
    class function salvarBaixaLote (lote :TLotePagamentoModel; baixa :TTPBaixaModel; titulo : TTituloPagarModel ): Boolean;
    class function salvarBaixaTitulos(lote: TLotePagamentoModel; formaPagto : TFormaPagamentoModel; baixaGenerica :TTPBaixaModel; titulos: TStringlist): Boolean;

  end;

implementation

{ TTPBaixaDAO }

class function TTPBaixaDAO.ajustaRateioCC(value: TTPBaixaModel): Boolean;
var
I : Integer;
diferenca,soma :Currency;
begin
soma :=0;
 //funcao para somar os valores dos centros de custos e fechar com o valor pago

    for I := 0 to value.FTituloPagar.listaCustos.Count - 1 do
    begin

      soma := soma + value.FTituloPagar.listaCustos[I].Fvalor;

    end;

    if soma <> value.FvalorPago then
    begin

      diferenca := soma - value.FvalorPago;
      value.FTituloPagar.listaCustos[0].Fvalor := value.FTituloPagar.listaCustos[0].Fvalor + diferenca;
      TTituloPagarCentroCustoDAO.Update(value.FTituloPagar.listaCustos[0]);

    end;

end;

class function TTPBaixaDAO.cancelarBaixa(titulo: TTituloPagarModel): Boolean;
var
  formaPagto    : TTPBaixaFPModel;
  acrescimo     : TTPBaixaACModel;
  deducao       : TTPbaixaDEModel;
  pagtoCheque   : TTPBaixaChequeModel;
  pagtoWWW      : TTPBaixaInternetModel;
  cheque        : TContaBancariaChequeModel;
  contaBancoDB  : TContaBancariaDBModel;
  debitoCaixa   : TTesourariaDBModel;
  baixa :TTPBaixaModel;

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


  if not dmConexao.conn.InTransaction then
    dmConexao.conn.StartTransaction;

  try
// dmConexao.conn.StartTransaction;

 // Atualizar o TP
   if TTituloPagarDAO.Update(titulo) then begin

     baixa  := TTPBaixaModel.Create;
     baixa.FTituloPagar := titulo;
     baixa.FIDtituloPagar := titulo.FID;
     baixa.FIDorganizacao := titulo.FIDorganizacao;
     baixa := obterPorTP(baixa);

      if not uutil.Empty(baixa.FID) then
      begin

        formaPagto    := TTPBaixaFPModel.Create;
        formaPagto.FIDTPBaixa := baixa.FID;
        formaPagto.FIDorganizacao := titulo.FIDorganizacao;

        acrescimo     := TTPBaixaACModel.Create;
        acrescimo.FIDtituloPagarBaixa := baixa.FID;
        acrescimo.FIDorganizacao := titulo.FIDorganizacao;

        deducao       := TTPbaixaDEModel.Create;
        deducao.FIDtituloPagarBaixa := baixa.FID;
        deducao.FIDorganizacao := titulo.FIDorganizacao;

        pagtoCheque   := TTPBaixaChequeModel.Create;
        pagtoCheque.FIDTPBaixa := baixa.FID;
        pagtoCheque.FIDorganizacao := titulo.FIDorganizacao;

        pagtoWWW      := TTPBaixaInternetModel.Create;
        pagtoWWW.FIDTPB := baixa.FID;
        pagtoWWW.FIDorganizacao := titulo.FIDorganizacao;

        contaBancoDB  := TContaBancariaDBModel.Create;
        contaBancoDB.FIDTP := titulo.FID;
        contaBancoDB.FIDorganizacao := titulo.FIDorganizacao;

        debitoCaixa   := TTesourariaDBModel.Create;
        debitoCaixa.FIDTPB := baixa.FID;
        debitoCaixa.FIDorganizacao := titulo.FIDorganizacao;

        TTPBaixaACDAO.deletePorTPBaixa(acrescimo); //deleta os AC
        TTPBaixaDEDAO.deletePorTPBaixa(deducao); //deleta os DE
        TTPBaixaChequeDAO.deletePorTPBaixa(pagtoCheque); //deleta pagto em cheque
        TTPBaixaInternetDAO.deletePorTPBaixa(pagtoWWW);
        TContaBancariaDebitoDAO.deleteTodosPorTP(contaBancoDB);
        TTesourariaDBDAO.deleteTodosPorTPB(debitoCaixa);
        TTPBaixaFPDAO.deleteTodosPorTPB(formaPagto);

        Delete(baixa);

      end;

    end;

    if dmConexao.conn.InTransaction then
      dmConexao.conn.CommitRetaining;

  except
    if dmConexao.conn.InTransaction then
    begin
      dmConexao.conn.RollbackRetaining;
    end;
    Result := System.FAlse;
    raise Exception.Create('Erro ao tentar o cancelamento da baixa do titulo ' + titulo.FnumeroDocumento);
  end;

  Result := System.True;

end;

class function TTPBaixaDAO.Delete(value: TTPBaixaModel): Boolean;
var
qryDelete : TFDQuery;
sucesso :Boolean;
begin
sucesso := False;
 dmConexao.conectarBanco;
 qryDelete := TFDQuery.Create(nil);

  try
    try

      qryDelete.Close;
      qryDelete.Connection := dmConexao.conn;
      qryDelete.SQL.Clear;
      qryDelete.SQL.Add(' DELETE FROM TITULO_PAGAR_BAIXA  ');
      qryDelete.SQL.Add(' WHERE ID_ORGANIZACAO = :PIDORGANIZACAO  AND  ID_TITULO_PAGAR_BAIXA = :PID ');
      qryDelete.ParamByName('PIDORGANIZACAO').AsString := value.FIDorganizacao;
      qryDelete.ParamByName('PID').AsString := value.FID;

      qryDelete.ExecSQL;
      if qryDelete.RowsAffected > 0 then begin sucesso := True; {  dmConexao.conn.CommitRetaining;} end;

      Result := sucesso;

    except
      sucesso := False;
     // dmConexao.conn.RollbackRetaining;
      raise Exception.Create('Erro ao tentar DELETAR TITULO PAGO');

    end;


  finally
    if Assigned(qryDelete) then
    begin
      FreeAndNil(qryDelete);
    end;
  end;
end;



class function TTPBaixaDAO.DeletePorTP(value: TTPBaixaModel): Boolean;
var
qryDelete : TFDQuery;
sucesso :Boolean;
begin
sucesso := False;
 dmConexao.conectarBanco;
 qryDelete := TFDQuery.Create(nil);

  try
    try

      qryDelete.Close;
      qryDelete.Connection := dmConexao.conn;
      qryDelete.SQL.Clear;
      qryDelete.SQL.Add(' DELETE FROM TITULO_PAGAR_BAIXA  ');
      qryDelete.SQL.Add(' WHERE ID_ORGANIZACAO = :PIDORGANIZACAO  AND  ID_TITULO_PAGAR = :PID ');
      qryDelete.ParamByName('PIDORGANIZACAO').AsString := value.FIDorganizacao;
      qryDelete.ParamByName('PID').AsString := value.FIDtituloPagar;

      qryDelete.ExecSQL;
      if qryDelete.RowsAffected > 0 then begin sucesso := True; { dmConexao.conn.CommitRetaining; } end;

      Result := sucesso;

    except
      sucesso := False;
     // dmConexao.conn.RollbackRetaining;
      raise Exception.Create('Erro ao tentar DELETAR TITULO Pago');

    end;


  finally
    if Assigned(qryDelete) then
    begin
      FreeAndNil(qryDelete);
    end;
  end;
end;


class function TTPBaixaDAO.Insert(value: TTPBaixaModel): Boolean;
var
qryInsert : TFDQuery;
cmdSql :string;
sucesso : Boolean;
begin
 sucesso := False;
  dmConexao.conectarBanco;
  qryInsert := TFDQuery.Create(nil);

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
    qryInsert.ParamByName('PIDUSUARIO').AsInteger                  := value.FIDUsuario;
    qryInsert.ParamByName('PIDRESPONSAVEL').AsString              := value.FIDResponsavel;
    qryInsert.ParamByName('PIDLOTE_CONTABIL').AsString            := value.FIDLoteContabil;
    qryInsert.ParamByName('PIDCENTRO_CUSTO').AsString             := value.FIDCentroCusto;
    qryInsert.ParamByName('PTIPO_BAIXA').AsString                 := value.FtipoBaixa;
    qryInsert.ParamByName('PIDLOTE_PAGAMENTO').AsString           := value.FIDlotePagamento;
    qryInsert.ParamByName('PDATA_REGISTRO').AsDateTime            := Now;
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

    if qryInsert.RowsAffected > 0 then
    begin
      registroMD(value, 'BX TP', 'Baixa do TP ' + value.FTituloPagar.FnumeroDocumento + ' ' + value.FTituloPagar.Fdescricao, 'PAGO');
      sucesso := True;
    end;


    Result := sucesso;
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
qryPesquisa := TFDQuery.Create(nil);
tpb := TTPBaixaModel.Create;

try

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
 qryPesquisa := TFDQuery.Create(nil);
 tpb                         := TTPBaixaModel.Create;

try

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
percentRateio, valorAcumulado, valorExtra, valorAC, valorDE, valorNominal, valorAntecipado :Currency;

atualizarRateioCC, sucesso : Boolean;

begin
 sucesso := False;
  qtdRateioH :=0;
  qtdRateioC  :=0;
  valorAC := 0;
  valorDE := 0;
  valorExtra :=0;
  valorAcumulado := 0;
  percentRateio :=0;
  I:=0;
  valorNominal     := titulo.FvalorNominal ;
  dmConexao.conectarBanco;
 atualizarRateioCC := False;

  if not dmConexao.conn.InTransaction then
    dmConexao.conn.StartTransaction;

  try
// dmConexao.conn.StartTransaction;


    if Insert(baixa) then begin
        //inserido os acrescimos

          for A := 0 to baixa.listaAcrescimo.Count - 1 do
          begin
            acrescimo := TTPBaixaACModel.Create;
            acrescimo := baixa.listaAcrescimo[A];
            TTPBaixaACDAO.Insert(acrescimo);
            valorAC := valorAC + acrescimo.Fvalor;
          end;


        //inserido as deducoes

          for D := 0 to baixa.listaDeducao.Count - 1 do
          begin
            deducao := TTPBaixaDEModel.Create;
            deducao := baixa.listaDeducao[D];
            TTPBaixaDEDAO.Insert(deducao);
            valorDE := valorDE + deducao.Fvalor;

          end;


         for FP   := 0 to baixa.listaFormasPagto.Count -1 do begin
            if baixa.listaFormasPagto[FP].FFormaPagamento.FID.Equals('CHEQUE') then begin

              titulo.FdataPagamento := baixa.FTPBaixaCheque.FCheque.FdataEmissao;
              //TPBAIXA_CHEQUE   //SALVA O TPBAIXA_FP
              formaPagto                  :=  TTPBaixaFPModel.Create;
              formaPagto.FIDorganizacao   :=  baixa.FIDorganizacao;
              formaPagto.FID              := dmConexao.obterNewID;
              formaPagto.FIDTPBaixa       :=  baixa.FID;


              formaPagto.FValor           :=  baixa.listaFormasPagto[FP].FValor;
              if not uUtil.Empty(titulo.FIDLotePagamento) then begin //o valor muda qdo o titulo � pago em lote.
                 formaPagto.FValor           :=  titulo.FvalorNominal;
              end;

              formaPagto.FFormaPagamento  :=  baixa.listaFormasPagto[FP].FFormaPagamento;

               if TTPBaixaFPDAO.Insert(formaPagto) then begin
               //PAGAMENTO REALIZADO EM CHEQUE
                pagtoCheque := TTPBaixaChequeModel.Create;
                pagtoCheque := baixa.FTPBaixaCheque;
                pagtoCheque.FIDCheque := baixa.FTPBaixaCheque.FIDCheque; //colocado em 04/03.
                pagtoCheque.FIDTPBaixa := baixa.FID;

                sucesso := TTPBaixaChequeDAO.Insert(pagtoCheque);
                if sucesso  then begin

                cheque := TContaBancariaChequeModel.Create;
                cheque := pagtoCheque.FCheque;

                 sucesso := TContaBancariaChequeDAO.Update(cheque);
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
            formaPagto.FID              :=  dmConexao.obterNewID; //  baixa.listaFormasPagto[FP].FID;
           // formaPagto.FIDTPBaixa       :=  baixa.listaFormasPagto[FP].FIDTPBaixa;
            formaPagto.FIDTPBaixa       :=  baixa.FID;
            formaPagto.FValor           :=  baixa.listaFormasPagto[FP].FValor;

            if not uUtil.Empty(titulo.FIDLotePagamento) then begin
                 formaPagto.FValor           :=  titulo.FvalorNominal;
              end;

            formaPagto.FFormaPagamento  :=  baixa.listaFormasPagto[FP].FFormaPagamento;

           if TTPBaixaFPDAO.Insert(formaPagto) then begin
              //PAGAMENTO REALIZADO via banco online
              // TITULO_RECEBER_BAIXA_INTERNET
               pagtoWWW := TTPBaixaInternetModel.Create;
               pagtoWWW := baixa.FTPBaixaWWW;
               pagtoWWW.FID := dmConexao.obterNewID;
               pagtoWWW.FIDTPB := baixa.FID;

                TTPBaixaInternetDAO.Insert(pagtoWWW);

               //CBD
               contaBancoDB                   := TContaBancariaDBModel.Create;
               contaBancoDB.FIDorganizacao    := baixa.FIDorganizacao;
               contaBancoDB.FID               := dmConexao.obterNewID;
               contaBancoDB.Fidentificacao    := dmConexao.obterIdentificador('',baixa.FIDorganizacao,'CBD');
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


             sucesso :=   TContaBancariaDebitoDAO.Insert(contaBancoDB);


           end;

          end; // fim da FP via bank line

         end;


         for FP := 0 to baixa.listaFormasPagto.Count -1 do begin

            //ESPECIE
            if baixa.listaFormasPagto[FP].FFormaPagamento.FID.Equals('ESPECIE') then begin
              //TPBAIXA_CHEQUE   //SALVA O TPBAIXA_FP
              formaPagto                  :=  TTPBaixaFPModel.Create;
              formaPagto.FIDorganizacao   :=  baixa.FIDorganizacao;
              formaPagto.FID              :=  dmConexao.obterNewID; //  baixa.listaFormasPagto[FP].FID;
             // formaPagto.FIDTPBaixa       :=  baixa.listaFormasPagto[FP].FIDTPBaixa;
              formaPagto.FIDTPBaixa       :=  baixa.FID;
              formaPagto.FValor           :=  baixa.listaFormasPagto[FP].FValor;

              if not uUtil.Empty(titulo.FIDLotePagamento) then begin
                 formaPagto.FValor           :=  titulo.FvalorNominal;
              end;

              formaPagto.FFormaPagamento  :=  baixa.listaFormasPagto[FP].FFormaPagamento;

              if TTPBaixaFPDAO.Insert(formaPagto) then
              begin
                //PAGAMENTO REALIZADO via CAIXA
                 //TESOURARIA_DEBITO
                debitoCaixa                   := TTesourariaDBModel.Create;
                debitoCaixa.FIDorganizacao    := baixa.FIDorganizacao;
                debitoCaixa.FID               := dmConexao.obterNewID;
                debitoCaixa.FnumeroDocumento  := dmConexao.obterIdentificador('',baixa.FIDorganizacao, 'TD');
                debitoCaixa.FIDHistorico      := 'PAGTO TITULO ESPECIE';
                debitoCaixa.FIDResponsavel    := baixa.FIDResponsavel;
                debitoCaixa.FIDUsuario        := baixa.FIDusuario;
                debitoCaixa.FIDCedente        := titulo.FIDCedente;
                debitoCaixa.FIDTPB            := baixa.FID;
                debitoCaixa.FvalorNominal     := formaPagto.FValor;
                debitoCaixa.Fdescricao        := ' TIT ' + titulo.FnumeroDocumento + ' ' + titulo.Fdescricao;
                debitoCaixa.FtipoLancamento   := 'D';
                debitoCaixa.FdataRegistro     := Now;
                debitoCaixa.FdataContabil     := titulo.FdataPagamento;
                debitoCaixa.FdataMovimento    := titulo.FdataPagamento;

               sucesso :=   TTesourariaDBDAO.Insert(debitoCaixa);
              end;
            end; // fim da FP via tesouraria
      end;
        // Atualizar ou Inserir o TP
      if sucesso then
      begin

        if TTituloPagarDAO.Update(titulo) then
        begin
          sucesso := True;
          valorExtra := valorAC - valorDE;
          atualizarRateioCC := True; //deixar assim e depois testar. Ranan em 11/06


        end; //IF UPDATE TP

        //atualizar o rateio de centro de custos

        if atualizarRateioCC then
        begin

          for I := 0 to titulo.listaCustos.Count - 1 do
          begin
            percentRateio := RoundTo((titulo.listaCustos[I].Fvalor / titulo.FvalorNominal), -2);

            titulo.listaCustos[I].Fvalor := RoundTo(( percentRateio * baixa.FvalorPago ),-2);

            if I = (titulo.listaCustos.Count - 1) then
            begin

              titulo.listaCustos[I].Fvalor := baixa.FvalorPago - valorAcumulado;

            end;

            sucesso := TTituloPagarCentroCustoDAO.Update(titulo.listaCustos[I]);

            valorAcumulado := valorAcumulado + titulo.listaCustos[I].Fvalor;

          end;

           ajustaRateioCC(baixa);// n�o ativado
           valorAcumulado :=0;

        end;

      end;

    end; //if INSERT BAIXA


    if dmConexao.conn.InTransaction then
      dmConexao.conn.CommitRetaining;

  except
    if dmConexao.conn.InTransaction then
    begin
      dmConexao.conn.RollbackRetaining;
    end;

    sucesso := System.FAlse;
    raise Exception.Create('Erro ao tentar o pagamento do titulo ' + titulo.FnumeroDocumento);

  end;

  Result := sucesso;

end;


class function TTPBaixaDAO.salvarBaixaLote(lote: TLotePagamentoModel; baixa: TTPBaixaModel; titulo: TTituloPagarModel): Boolean;
var
  formaPagto    : TTPBaixaFPModel;
  acrescimo     : TTPBaixaACModel;
  deducao       : TTPbaixaDEModel;
  pagtoCheque   : TTPBaixaChequeModel;
  pagtoWWW      : TTPBaixaInternetModel;
  cheque        : TContaBancariaChequeModel;
  contaBancoDB  : TContaBancariaDBModel;
  debitoCaixa   : TTesourariaDBModel;
  loteAux : TLotePagamentoModel;

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

  if not dmConexao.conn.InTransaction then
    dmConexao.conn.StartTransaction;

  try

    loteAux := TLotePagamentoDAO.obterPorID(lote);

    if uutil.Empty(loteAux.FID) then
    begin
      lote.Flote := dmConexao.obterIdentificador('', titulo.FIDorganizacao, 'LOTE_PG');
      TLotePagamentoDAO.Insert(lote);

      if lote.FIDformaPagamento.Equals('CHEQUE') then    begin

        cheque := TContaBancariaChequeModel.Create;
        cheque := baixa.FTPBaixaCheque.FCheque;

       // TContaBancariaChequeDAO.Update(cheque);

        TContaBancariaChequeDAO.compensar(cheque);


      end;

    end;


    if not uutil.Empty(lote.FID) then
    begin
 // Atualizar ou Inserir o TP
      titulo.Fobservacao := 'LOTE ' + lote.Flote;
      titulo.FIDLotePagamento := lote.FID;
      titulo.FdataPagamento := lote.FdataPagamento;

      if TTituloPagarDAO.Update(titulo) then
      begin
     //TPBAIXA
        if Insert(baixa) then
        begin
        //inserido os acrescimos


          for A := 0 to baixa.listaAcrescimo.Count - 1 do
          begin
            acrescimo := TTPBaixaACModel.Create;
            acrescimo := baixa.listaAcrescimo[A];
            TTPBaixaACDAO.Insert(acrescimo);
          end;

        //inserido as deducoes

          for D := 0 to baixa.listaDeducao.Count - 1 do
          begin
            deducao := TTPBaixaDEModel.Create;
            deducao := baixa.listaDeducao[D];
            TTPBaixaDEDAO.Insert(deducao);
          end;


         for FP   := 0 to baixa.listaFormasPagto.Count -1 do begin
            if baixa.listaFormasPagto[FP].FFormaPagamento.FID.Equals('CHEQUE') then begin
              //TPBAIXA_CHEQUE   //SALVA O TPBAIXA_FP
              formaPagto                  :=  TTPBaixaFPModel.Create;
              formaPagto.FIDorganizacao   :=  baixa.FIDorganizacao;
              formaPagto.FID              := dmConexao.obterNewID; //  baixa.listaFormasPagto[FP].FID;
      //        formaPagto.FIDTPBaixa       :=  baixa.listaFormasPagto[FP].FIDTPBaixa; mudado em 23/03 pq do pagto em lote
              formaPagto.FIDTPBaixa       :=  baixa.FID;

              formaPagto.FValor           :=  baixa.listaFormasPagto[FP].FValor;
              if not uUtil.Empty(titulo.FIDLotePagamento) then begin //o valro muda qdo o titulo � pago em lote.
                 formaPagto.FValor           :=  titulo.FvalorNominal;
              end;

              formaPagto.FFormaPagamento  :=  baixa.listaFormasPagto[FP].FFormaPagamento;

               if TTPBaixaFPDAO.Insert(formaPagto) then begin
               //PAGAMENTO REALIZADO EM CHEQUE
                pagtoCheque := TTPBaixaChequeModel.Create;
                pagtoCheque := baixa.FTPBaixaCheque;
                pagtoCheque.FID := dmConexao.obterNewID;
                pagtoCheque.FIDCheque   := baixa.FTPBaixaCheque.FIDCheque; //colocado em 04/03.
                pagtoCheque.FIDTPBaixa  := baixa.FID;
                pagtoCheque.Fvalor      := titulo.FvalorNominal;

                TTPBaixaChequeDAO.Insert(pagtoCheque);

               end;

            end; // fim da FP em cheque
         end;




         for FP := 0 to baixa.listaFormasPagto.Count -1 do begin
          // INTERNET BANK

           if baixa.listaFormasPagto[FP].FFormaPagamento.FID.Equals('INTERNET BANK') then begin
            //TPBAIXA_CHEQUE   //SALVA O TPBAIXA_FP
            formaPagto                  :=  TTPBaixaFPModel.Create;
            formaPagto.FIDorganizacao   :=  baixa.FIDorganizacao;
            formaPagto.FID              :=  dmConexao.obterNewID; //  baixa.listaFormasPagto[FP].FID;
           // formaPagto.FIDTPBaixa       :=  baixa.listaFormasPagto[FP].FIDTPBaixa;
            formaPagto.FIDTPBaixa       :=  baixa.FID;
            formaPagto.FValor           :=  baixa.listaFormasPagto[FP].FValor;

            if not uUtil.Empty(titulo.FIDLotePagamento) then begin
                 formaPagto.FValor           :=  titulo.FvalorNominal;
              end;

            formaPagto.FFormaPagamento  :=  baixa.listaFormasPagto[FP].FFormaPagamento;

           if TTPBaixaFPDAO.Insert(formaPagto) then begin
              //PAGAMENTO REALIZADO via banco online
              // TITULO_RECEBER_BAIXA_INTERNET
               pagtoWWW := TTPBaixaInternetModel.Create;
               pagtoWWW := baixa.FTPBaixaWWW;
               pagtoWWW.FID := dmConexao.obterNewID;
               pagtoWWW.FIDTPB := baixa.FID;
               pagtoWWW.Fvalor := titulo.FvalorNominal;

                TTPBaixaInternetDAO.Insert(pagtoWWW);

               //CBD
               contaBancoDB                   := TContaBancariaDBModel.Create;
               contaBancoDB.FIDorganizacao    := baixa.FIDorganizacao;
               contaBancoDB.FID               := dmConexao.obterNewID;
               contaBancoDB.Fidentificacao    := dmConexao.obterIdentificador('',baixa.FIDorganizacao,'CBD');
               contaBancoDB.FIDusuario        := baixa.FIDusuario;
               contaBancoDB.FIDResponsavel    := baixa.FIDResponsavel;
               contaBancoDB.FIDTOB            := pagtoWWW.FIDTOB;
               contaBancoDB.FIDTP             := titulo.FID;
               contaBancoDB.FtipoLancamento   := 'D' ;
               contaBancoDB.Fdescricao        := 'PAGTO DOC ' + titulo.FnumeroDocumento ;
               contaBancoDB.FIDcontaBancaria  := pagtoWWW.FIDcontaBancariaOrigem;
               contaBancoDB.Fvalor            := titulo.FvalorNominal;
               contaBancoDB.FdataMovimento    := pagtoWWW.FdataOperacao;
               contaBancoDB.FdataRegistro     := Now;


                TContaBancariaDebitoDAO.Insert(contaBancoDB);


           end;

          end; // fim da FP via bank line

         end;


         for FP := 0 to baixa.listaFormasPagto.Count -1 do begin

            //ESPECIE
            if baixa.listaFormasPagto[FP].FFormaPagamento.FID.Equals('ESPECIE') then begin
              //TPBAIXA_CHEQUE   //SALVA O TPBAIXA_FP
              formaPagto                  :=  TTPBaixaFPModel.Create;
              formaPagto.FIDorganizacao   :=  baixa.FIDorganizacao;
              formaPagto.FID              :=  dmConexao.obterNewID; //  baixa.listaFormasPagto[FP].FID;
             // formaPagto.FIDTPBaixa       :=  baixa.listaFormasPagto[FP].FIDTPBaixa;
              formaPagto.FIDTPBaixa       :=  baixa.FID;
              formaPagto.FValor           :=  baixa.listaFormasPagto[FP].FValor;

              if not uUtil.Empty(titulo.FIDLotePagamento) then begin
                 formaPagto.FValor           :=  titulo.FvalorNominal;
              end;

              formaPagto.FFormaPagamento  :=  baixa.listaFormasPagto[FP].FFormaPagamento;

              if TTPBaixaFPDAO.Insert(formaPagto) then
              begin
                //PAGAMENTO REALIZADO via CAIXA
                 //TESOURARIA_DEBITO
                debitoCaixa                   := TTesourariaDBModel.Create;
                debitoCaixa.FIDorganizacao    := baixa.FIDorganizacao;
                debitoCaixa.FID               := dmConexao.obterNewID;
                debitoCaixa.FnumeroDocumento  := dmConexao.obterIdentificador('',baixa.FIDorganizacao, 'TD');
                debitoCaixa.FIDHistorico      := 'PAGTO TITULO ESPECIE';
                debitoCaixa.FIDResponsavel    := baixa.FIDResponsavel;
                debitoCaixa.FIDUsuario        := baixa.FIDusuario;
                debitoCaixa.FIDCedente        := titulo.FIDCedente;
                debitoCaixa.FIDTPB            := baixa.FID;
                debitoCaixa.FvalorNominal     := formaPagto.FValor;
                debitoCaixa.Fdescricao        := ' TIT ' + titulo.FnumeroDocumento + ' ' + titulo.Fdescricao;
                debitoCaixa.FtipoLancamento   := 'D';
                debitoCaixa.FdataRegistro     := Now;
                debitoCaixa.FdataContabil     := titulo.FdataPagamento;
                debitoCaixa.FdataMovimento    := titulo.FdataPagamento;

                  TTesourariaDBDAO.Insert(debitoCaixa);
              end;
            end; // fim da FP via tesouraria
        end;
    end;     //if INSERT BAIXA
   end; //IF UPDATE TP
   end;

    if dmConexao.conn.InTransaction then
      dmConexao.conn.CommitRetaining;

  except
    if dmConexao.conn.InTransaction then
    begin
      dmConexao.conn.RollbackRetaining;
    end;
    Result := System.FAlse;
    raise Exception.Create('Erro ao tentar o pagamento do titulo ' + titulo.FnumeroDocumento);
  end;


  Result := System.True;

end;


class function TTPBaixaDAO.salvarBaixaTitulos(lote: TLotePagamentoModel; formaPagto: TFormaPagamentoModel; baixaGenerica :TTPBaixaModel; titulos: TStringlist): Boolean;
var
  baixaFormaPagto    : TTPBaixaFPModel; //ver
  acrescimo     : TTPBaixaACModel;
  deducao       : TTPbaixaDEModel;
  pagtoCheque   : TTPBaixaChequeModel;
  pagtoWWW      : TTPBaixaInternetModel;
  cheque        : TContaBancariaChequeModel;
  contaBancoDB  : TContaBancariaDBModel;
  debitoCaixa   : TTesourariaDBModel;

 tituloPagar : TTituloPagarModel;
  A,D,FP : Integer;
listaHistorico :  TObjectList<TTituloPagarHistoricoModel>;
listaCustos    :  TObjectList<TTituloPagarCentroCustoModel>;
historico : TTituloPagarHistoricoModel  ;
centroCusto : TTituloPagarCentroCustoModel;
 qtdRateioC, qtdRateioH, I :Integer;
 valorNominal, valorAntecipado :Currency;
sucesso, sucessoPGCheque : Boolean;


baixaFP : TTPBaixaFPModel;

begin
sucesso := False;
sucessoPGCheque :=  False;
  qtdRateioH :=0;
  qtdRateioC  :=0;

  //valorNominal     := titulo.FvalorNominal ;
  dmConexao.conectarBanco;

  if not dmConexao.conn.InTransaction then
    dmConexao.conn.StartTransaction;

  try

    if titulos.Count >0 then begin //s� processa com a lista tendo 1 titulo

        lote.Flote := dmConexao.obterIdentificador('', lote.FIDorganizacao, 'LOTE_PG');
        sucesso := TLotePagamentoDAO.Insert(lote); //faz CommitRetaining. Retorna TRUE se foi inserido.

      for I := 0 to titulos.Count-1 do begin

        tituloPagar := TTituloPagarModel.Create;
        tituloPagar.FIDorganizacao := lote.FIDorganizacao;
        tituloPagar.FID := titulos.Strings[I];
        tituloPagar := TTituloPagarDAO.obterPorID(tituloPagar);

        if not uUtil.Empty(tituloPagar.FID) then begin


        tituloPagar.FIDTipoStatus := 'QUITADO';
        tituloPagar.Fobservacao := 'LOTE ' + lote.Flote;
        tituloPagar.FIDLotePagamento := lote.FID;
        tituloPagar.FdataPagamento := lote.FdataPagamento;
        tituloPagar.FdataUltimaAtualizacao := Now;

        end;

        baixaGenerica.FID := dmConexao.obterNewID;
        baixaGenerica.FIDtituloPagar := tituloPagar.FID;
        baixaGenerica.FIDCentroCusto := tituloPagar.FIDCentroCusto;
        baixaGenerica.FvalorPago := tituloPagar.FvalorNominal;
        baixaGenerica.FTituloPagar := tituloPagar;


          // TITULO_PAGAR_BAIXA_FP
        baixaFP := TTPBaixaFPModel.Create;
        baixaFP.FID := dmConexao.obterNewID;
        baixaFP.FIDorganizacao := uutil.TOrgAtual.getId;
        baixaFP.FFormaPagamento := formaPagto;
        baixaFP.FValor := tituloPagar.FvalorNominal;
        baixaFP.FIDTPBaixa := baixaGenerica.FID;

               //TPBAIXA
          if Insert(baixaGenerica) then
          begin

            for FP := 0 to baixaGenerica.listaFormasPagto.Count - 1 do
            begin
              if baixaGenerica.listaFormasPagto[FP].FFormaPagamento.FID.Equals('CHEQUE') then
              begin
              //TPBAIXA_CHEQUE   //SALVA O TPBAIXA_FP
                baixaFormaPagto := TTPBaixaFPModel.Create;
                baixaFormaPagto.FIDorganizacao := baixaGenerica.FIDorganizacao;
                baixaFormaPagto.FID := dmConexao.obterNewID; //  baixa.listaFormasPagto[FP].FID;
      //        baixaFormaPagto.FIDTPBaixa       :=  baixa.listaFormasPagto[FP].FIDTPBaixa; mudado em 23/03 pq do pagto em lote
                baixaFormaPagto.FIDTPBaixa := baixaGenerica.FID;

                baixaFormaPagto.FValor := baixaGenerica.listaFormasPagto[FP].FValor;
                if not uUtil.Empty(tituloPagar.FIDLotePagamento) then
                begin //o valro muda qdo o titulo � pago em lote.
                  baixaFormaPagto.FValor := tituloPagar.FvalorNominal;
                end;

                baixaFormaPagto.FFormaPagamento := baixaGenerica.listaFormasPagto[FP].FFormaPagamento;

                if TTPBaixaFPDAO.Insert(baixaFormaPagto) then
                begin
                 //PAGAMENTO REALIZADO EM CHEQUE
                  pagtoCheque := TTPBaixaChequeModel.Create;
                  pagtoCheque := baixaGenerica.FTPBaixaCheque;
                  pagtoCheque.FID := dmConexao.obterNewID;
                  pagtoCheque.FIDorganizacao := baixaGenerica.FIDorganizacao;
                  pagtoCheque.FIDTOB := lote.FIDTOB;
                  pagtoCheque.FCheque := baixaGenerica.FTPBaixaCheque.FCheque;
                  pagtoCheque.FIDCheque := baixaGenerica.FTPBaixaCheque.FIDCheque; //colocado em 04/03.
                  pagtoCheque.FIDTPBaixa := baixaGenerica.FID;
                  pagtoCheque.Fvalor := baixaGenerica.FTPBaixaCheque.FValor;
                  pagtoCheque.Fobservacao := 'Lote ' + lote.Flote;

                 sucessoPGCheque := TTPBaixaChequeDAO.Insert(pagtoCheque);

                end;

              end; // fim da FP em cheque
            end;

            for FP := 0 to baixaGenerica.listaFormasPagto.Count - 1 do
            begin
          // INTERNET BANK

              if baixaGenerica.listaFormasPagto[FP].FFormaPagamento.FID.Equals('INTERNET BANK') then
              begin
            //TPBAIXA_CHEQUE   //SALVA O TPBAIXA_FP
                baixaFormaPagto := TTPBaixaFPModel.Create;
                baixaFormaPagto.FIDorganizacao := baixaGenerica.FIDorganizacao;
                baixaFormaPagto.FID := dmConexao.obterNewID; //  baixa.listaFormasPagto[FP].FID;
           // baixaFormaPagto.FIDTPBaixa       :=  baixa.listaFormasPagto[FP].FIDTPBaixa;
                baixaFormaPagto.FIDTPBaixa := baixaGenerica.FID;
                baixaFormaPagto.FValor := baixaGenerica.listaFormasPagto[FP].FValor;

                if not uUtil.Empty(tituloPagar.FIDLotePagamento) then
                begin
                  baixaFormaPagto.FValor := tituloPagar.FvalorNominal;
                end;

                baixaFormaPagto.FFormaPagamento := baixaGenerica.listaFormasPagto[FP].FFormaPagamento;

                if TTPBaixaFPDAO.Insert(baixaFormaPagto) then
                begin
              //PAGAMENTO REALIZADO via banco online
              // TITULO_RECEBER_BAIXA_INTERNET
                  pagtoWWW := TTPBaixaInternetModel.Create;
                  pagtoWWW := baixaGenerica.FTPBaixaWWW;
                  pagtoWWW.FID := dmConexao.obterNewID;
                  pagtoWWW.FIDTPB := baixaGenerica.FID;
                  pagtoWWW.Fvalor := tituloPagar.FvalorNominal;

                  TTPBaixaInternetDAO.Insert(pagtoWWW);

               //CBD
                  contaBancoDB := TContaBancariaDBModel.Create;
                  contaBancoDB.FIDorganizacao := baixaGenerica.FIDorganizacao;
                  contaBancoDB.FID := dmConexao.obterNewID;
                  contaBancoDB.Fidentificacao := dmConexao.obterIdentificador('', baixaGenerica.FIDorganizacao, 'CBD');
                  contaBancoDB.FIDusuario := baixaGenerica.FIDusuario;
                  contaBancoDB.FIDResponsavel := baixaGenerica.FIDResponsavel;
                  contaBancoDB.FIDTOB := pagtoWWW.FIDTOB;
                  contaBancoDB.FIDTP := tituloPagar.FID;
                  contaBancoDB.FtipoLancamento := 'D';
                  contaBancoDB.Fdescricao := 'PAGTO DOC ' + tituloPagar.FnumeroDocumento;
                  contaBancoDB.FIDcontaBancaria := pagtoWWW.FIDcontaBancariaOrigem;
                  contaBancoDB.Fvalor := tituloPagar.FvalorNominal;
                  contaBancoDB.FdataMovimento := pagtoWWW.FdataOperacao;
                  contaBancoDB.FdataRegistro := Now;

                  TContaBancariaDebitoDAO.Insert(contaBancoDB);

                end;

              end; // fim da FP via bank line

            end;

            for FP := 0 to baixaGenerica.listaFormasPagto.Count - 1 do
            begin

            //ESPECIE
              if baixaGenerica.listaFormasPagto[FP].FFormaPagamento.FID.Equals('ESPECIE') then
              begin
              //   //SALVA O TPBAIXA_FP
                baixaFormaPagto := TTPBaixaFPModel.Create;
                baixaFormaPagto.FIDorganizacao := baixaGenerica.FIDorganizacao;
                baixaFormaPagto.FID := dmConexao.obterNewID;
                baixaFormaPagto.FIDTPBaixa := baixaGenerica.FID;
                baixaFormaPagto.FValor := tituloPagar.FvalorNominal;

                baixaFormaPagto.FFormaPagamento := baixaGenerica.listaFormasPagto[FP].FFormaPagamento;

                if TTPBaixaFPDAO.Insert(baixaFormaPagto) then
                begin
                //PAGAMENTO REALIZADO via CAIXA
                 //TESOURARIA_DEBITO
                  debitoCaixa := TTesourariaDBModel.Create;
                  debitoCaixa.FIDorganizacao := baixaGenerica.FIDorganizacao;
                  debitoCaixa.FID := dmConexao.obterNewID;
                  debitoCaixa.FnumeroDocumento := dmConexao.obterIdentificador('', baixaGenerica.FIDorganizacao, 'TD');
                  debitoCaixa.FIDHistorico := 'PAGTO TITULO ESPECIE';
                  debitoCaixa.FIDResponsavel := baixaGenerica.FIDResponsavel;
                  debitoCaixa.FIDUsuario := baixaGenerica.FIDusuario;
                  debitoCaixa.FIDCedente := tituloPagar.FIDCedente;
                  debitoCaixa.FIDTPB := baixaGenerica.FID;
                  debitoCaixa.FvalorNominal := baixaFormaPagto.FValor;
                  debitoCaixa.Fdescricao := ' TIT ' + tituloPagar.FnumeroDocumento + ' ' + tituloPagar.Fdescricao;
                  debitoCaixa.FtipoLancamento := 'D';
                  debitoCaixa.FdataRegistro := Now;
                  debitoCaixa.FdataContabil := tituloPagar.FdataPagamento;
                  debitoCaixa.FdataMovimento := tituloPagar.FdataPagamento;

                  TTesourariaDBDAO.Insert(debitoCaixa);
                end;
              end; // fim da FP via tesouraria
          end;

          if TTituloPagarDAO.Update(tituloPagar) then
          begin
            sucesso := True;
          end; //IF UPDATE TP

        end;  //if INSERT BAIXA

      end;


      if sucessoPGCheque then   //s� compensa se tudo funcionar
      begin
        if lote.FIDformaPagamento.Equals('CHEQUE') then
        begin
          cheque := TContaBancariaChequeModel.Create;


          if not uutil.Empty(baixaGenerica.FTPBaixaCheque.FCheque.FID) then
          begin

            cheque := baixaGenerica.FTPBaixaCheque.FCheque;
            // TContaBancariaChequeDAO.Update(cheque);
            cheque.FpagtoLote := True;  //evita que a compensa��o inicie nova transcao
            TContaBancariaChequeDAO.compensar(cheque);


          end
          else
          begin
            raise Exception.Create('Erro ao tentar compensar o cheque. ');
          end;

        end;
      end;


      if dmConexao.conn.InTransaction then
        dmConexao.conn.CommitRetaining;
    end; // IF titulos.count >0

  except
    if dmConexao.conn.InTransaction then
    begin
      dmConexao.conn.RollbackRetaining;
    end;
    Result := System.FAlse;
    raise Exception.Create('Erro ao tentar o pagamento do titulo ' + tituloPagar.FnumeroDocumento);
  end;


  Result := System.True;

end;




class function TTPBaixaDAO.getTPB(query: TFDQuery): TTPBaixaModel;
var
tpb: TTPBaixaModel;
begin
  tpb := TTPBaixaModel.Create;
 try

  if not query.IsEmpty then begin

      tpb.FID                     := query.FieldByName('ID_TITULO_PAGAR_BAIXA').AsString;
      tpb.FIDorganizacao          := query.FieldByName('ID_ORGANIZACAO').AsString;
      tpb.FIDCentroCusto          := query.FieldByName('ID_CENTRO_CUSTO').AsString;
      tpb.FIDusuario              := query.FieldByName('ID_USUARIO').AsInteger;
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


class function TTPBaixaDAO.registroMD(value: TTPBaixaModel; pAcao, pDsc,pStatus: string): Boolean;
var
md :TMDModel;
org : TOrganizacaoModel;
begin
  org := TOrganizacaoModel.Create;
  org.FID := value.FIDorganizacao;
  org :=  TOrganizacaoDAO.obterPorID(org);

   md                   := TMDModel.Create;
   md.FID               := dmConexao.obterNewID;
   md.FIDorganizacao    := uUtil.TOrgAtual.getId;
   md.FIDusuario        := uutil.TUserAtual.userID;
   md.FdataRegistro     := uutil.getDataServer;
   md.FvalorOperacao    := value.FvalorPago;
   md.FnumeroMovimento  := StrToInt(dmConexao.obterIdentificador('',md.FIDorganizacao,'MD'));
   md.Fcodigo           := value.FTituloPagar.FnumeroDocumento;
   md.Facao             := pAcao;
   md.Fobjeto           := pTable;
   md.Fdescricao        := pDsc;
   md.Fstatus           := pStatus;
   md.Festacao          := uutil.GetComputerNetName;
   md.FipEstacao        := uUtil.GetIp;
   md.Fserver           := org.FNAMESERVERBD  + ' IP ' + org.FIPSERVERBD;

   TMDDAO.Insert(md);

end;







end.
