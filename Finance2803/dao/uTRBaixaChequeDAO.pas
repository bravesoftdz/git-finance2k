unit uTRBaixaChequeDAO;

interface
{
CREATE TABLE TITULO_RECEBER_BAIXA_CHEQUE (
    ID_TITULO_RECEBER_BAIXA_CHEQUE  VARCHAR(36) NOT NULL,
    ID_ORGANIZACAO                  VARCHAR(36) NOT NULL,
    ID_TITULO_RECEBER_BAIXA         VARCHAR(36),
    ID_BANCO                        VARCHAR(36),
    ID_LOTE_DEPOSITO                VARCHAR(36),
    ID_TIPO_STATUS                  VARCHAR(36)
    VALOR                           NUMERIC(10,2) NOT NULL,
    NUMERO_CHEQUE                   VARCHAR(10),
    CONTA                           VARCHAR(20),
    AGENCIA                         VARCHAR(10),
    TITULAR                         VARCHAR(60),
    CPFCNPJ                         VARCHAR(20),
    PERSONALIDADE                   VARCHAR(2),
    LOTE_DEPOSITO                   VARCHAR(111),
    DATA_DEPOSITO                   DATE,
    DATA_DEVOLUCAO                  DATE,
    DATA_PROTOCOLO                  DATE,

);
}


uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, FireDAC.Stan.Intf, FireDAC.Stan.Option, uTRBaixaChequeModel,
  FireDAC.Stan.Param, FireDAC.Stan.Error, FireDAC.DatS, FireDAC.Phys.Intf,
  FireDAC.DApt.Intf, FireDAC.Stan.Async, FireDAC.DApt, Data.DB, udmConexao, uUtil,
  uBancoDAO, uBancoModel,uTipoStatusDAO, uTipoStatusModel,
  FireDAC.Comp.DataSet, FireDAC.Comp.Client;

type
 TTRBaixaChequeDAO = class
  private
    class function getModel (query :TFDQuery) : TTRBaixaChequeModel;

  public

    class function Insert(value :TTRBaixaChequeModel): Boolean;
    class function Update(value :TTRBaixaChequeModel): Boolean;
    class function obterPorID (value :TTRBaixaChequeModel): TTRBaixaChequeModel;
    class function obterTodosPorBaixa (value :TTRBaixaChequeModel): TFDQuery;
    class function DeletePorBaixa(value :TTRBaixaChequeModel): Boolean;
    class function Delete(value :TTRBaixaChequeModel): Boolean;


  end;


implementation

class function TTRBaixaChequeDAO.Delete(value: TTRBaixaChequeModel): Boolean;
var
  qryDelete: TFDQuery;
  sucesso: Boolean;
begin
  sucesso := False;
  dmConexao.conectarBanco;
 qryDelete := TFDQuery.Create(nil);
 try
  try
    qryDelete.Close;
    qryDelete.Connection := dmConexao.conn;
    qryDelete.SQL.Clear;
    qryDelete.SQL.Add('DELETE FROM TITULO_RECEBER_BAIXA_CHEQUE  ');
    qryDelete.SQL.Add('WHERE ID_ORGANIZACAO = :PIDORGANIZACAO  AND  ID_TITULO_RECEBER_BAIXA_CHEQUE = :PID ');
    qryDelete.ParamByName('PIDORGANIZACAO').AsString := value.FIDorganizacao;
    qryDelete.ParamByName('PID').AsString := value.FID;

    qryDelete.ExecSQL;
    if qryDelete.RowsAffected >0 then begin sucesso := True; end;
     Result := sucesso;

  except
    sucesso := False;
    raise Exception.Create('Erro ao tentar DELETAR ' + pTable);

  end;

 finally
   if Assigned(qryDelete) then begin
      FreeAndNil(qryDelete);
   end;
 end;
end;

class function TTRBaixaChequeDAO.DeletePorBaixa(value: TTRBaixaChequeModel): Boolean;
var
  qryDelete: TFDQuery;
  sucesso: Boolean;
begin
  sucesso := False;
  dmConexao.conectarBanco;
  qryDelete := TFDQuery.Create(nil);

 try
  try
    qryDelete.Close;
    qryDelete.Connection := dmConexao.conn;
    qryDelete.SQL.Clear;
    qryDelete.SQL.Add('DELETE FROM TITULO_RECEBER_BAIXA_CHEQUE  ');
    qryDelete.SQL.Add('WHERE ID_ORGANIZACAO = :PIDORGANIZACAO  AND  ID_TITULO_RECEBER_BAIXA = :PID ');
    qryDelete.ParamByName('PIDORGANIZACAO').AsString := value.FIDorganizacao;
    qryDelete.ParamByName('PID').AsString := value.FIDTRBaixa;

    qryDelete.ExecSQL;
    if qryDelete.RowsAffected >0 then begin sucesso := True; end;
     Result := sucesso;

  except
    sucesso := False;
    raise Exception.Create('Erro ao tentar DELETAR ' + pTable);

  end;

 finally
   if Assigned(qryDelete) then begin
      FreeAndNil(qryDelete);
   end;
 end;
end;

class function TTRBaixaChequeDAO.getModel( query: TFDQuery): TTRBaixaChequeModel;
var
trbCheque: TTRBaixaChequeModel;
banco : TBancoModel;
status : TTipoStatusModel;

begin
     trbCheque  := TTRBaixaChequeModel.Create;
     banco := TBancoModel.Create;
     status := TTipoStatusModel.Create;

 try

  if not query.IsEmpty then begin

      trbCheque.FID             := query.FieldByName('ID_TITULO_RECEBER_BAIXA_CHEQUE').AsString;
      trbCheque.FIDorganizacao  := query.FieldByName('ID_ORGANIZACAO').AsString;
      trbCheque.FIDTRBaixa      := query.FieldByName('ID_TITULO_RECEBER_BAIXA').AsString;
      trbCheque.FIDbanco        := query.FieldByName('ID_BANCO').AsString;
      trbCheque.FIDloteDeposito := query.FieldByName('ID_LOTE_DEPOSITO').AsString;
      trbCheque.FIDtipoStatus   := query.FieldByName('ID_TIPO_STATUS').AsString;
      trbCheque.FloteDeposito   := query.FieldByName('LOTE_DEPOSITO').AsString;
      trbCheque.Fpersonalidade  := query.FieldByName('PERSONALIDADE').AsString;
      trbCheque.Fcpfcnpj        := query.FieldByName('CPFCNPJ').AsString;
      trbCheque.Ftitular        := query.FieldByName('TITULAR').AsString;
      trbCheque.Fagencia        := query.FieldByName('AGENCIA').AsString;
      trbCheque.Fconta          := query.FieldByName('CONTA').AsString;
      trbCheque.FnumeroCheque   := query.FieldByName('NUMERO_CHEQUE').AsString;
      trbCheque.FdataProtocolo  := query.FieldByName('DATA_PROTOCOLO').AsDateTime;
      trbCheque.FdataDevolucao  := query.FieldByName('DATA_DEVOLUCAO').AsDateTime;
      trbCheque.FdataDeposito   := query.FieldByName('DATA_DEPOSITO').AsDateTime;
      trbCheque.FValor          := query.FieldByName('VALOR').AsCurrency;


      banco.FID := trbCheque.FIDbanco;
      banco := TBancoDAO.obterPorID(banco);
      trbCheque.Fbanco := banco;

      status.FID := trbCheque.FIDtipoStatus;
      status.FIDorganizacao := trbCheque.FIDorganizacao;
      trbCheque.Fstatus := status;

  end;

 except
 raise Exception.Create('Erro ao obter TITULO_RECEBER_BAIXA_CHEQUE');


 end;


  Result := trbCheque;

end;

class function TTRBaixaChequeDAO.Insert(value: TTRBaixaChequeModel): Boolean;
var
qryInsert : TFDQuery;
cmdSql :string;
sucesso : Boolean;
begin
sucesso := False;
dmConexao.conectarBanco;
qryInsert := TFDQuery.Create(nil);

  cmdSql := ' INSERT INTO TITULO_RECEBER_BAIXA_CHEQUE '+
            ' (ID_TITULO_RECEBER_BAIXA_CHEQUE, ID_ORGANIZACAO, '+
            ' ID_TITULO_RECEBER_BAIXA, ID_BANCO, ID_TIPO_STATUS, '+
            ' NUMERO_CHEQUE, VALOR,  CONTA, AGENCIA, TITULAR, '+
            ' CPFCNPJ, PERSONALIDADE, DATA_PROTOCOLO ) ' +
            ' VALUES (:PID, :PIDORGANIZACAO, :PIDTRB, :PIDBANCO, :PIDSTATUS, ' +
            ' :PNUMERO_CHEQUE, :PVALOR,  :PCONTA, :PAGENCIA, :PTITULAR, '+
            ' :PCPFCNPJ, :PPERSONA, :PDATA_PROTOCOLO )';

  try

    try
      qryInsert.Close;
      qryInsert.Connection := dmConexao.conn;
      qryInsert.SQL.Clear;
      qryInsert.SQL.Add(cmdSql);
      qryInsert.ParamByName('PID').AsString             := value.FID;
      qryInsert.ParamByName('PIDORGANIZACAO').AsString  := value.FIDorganizacao;
      qryInsert.ParamByName('PCPFCNPJ').AsString        := value.Fcpfcnpj;
      qryInsert.ParamByName('PPERSONA').AsString        := value.Fpersonalidade;
      qryInsert.ParamByName('PIDTRB').AsString          := value.FIDTRBaixa;
      qryInsert.ParamByName('PIDBANCO').AsString        := value.FIDbanco;
      qryInsert.ParamByName('PIDSTATUS').AsString       := value.FIDtipoStatus;
      qryInsert.ParamByName('PNUMERO_CHEQUE').AsString  := value.FnumeroCheque;
      qryInsert.ParamByName('PCONTA').AsString          := value.Fconta;
      qryInsert.ParamByName('PAGENCIA').AsString        := value.Fagencia;
      qryInsert.ParamByName('PTITULAR').AsString        := value.Ftitular;
      qryInsert.ParamByName('PVALOR').AsCurrency        := value.FValor;
      qryInsert.ParamByName('PDATA_PROTOCOLO').AsDate   := value.FdataProtocolo;

      qryInsert.ExecSQL;
      if qryInsert.RowsAffected >0 then begin sucesso := True; end;

      Result := sucesso;

    except
      raise Exception.Create('Erro ao gravar dados do cheque recebido.');

    end;

  finally
    if Assigned(qryInsert) then
    begin
      FreeAndNil(qryInsert);
    end;
  end;

end;

class function TTRBaixaChequeDAO.obterPorID( value: TTRBaixaChequeModel): TTRBaixaChequeModel;
var
qryPesquisa : TFDQuery;
cmdSql:string;
trbCheque: TTRBaixaChequeModel;
begin
dmConexao.conectarBanco;
  trbCheque   := TTRBaixaChequeModel.Create;
  qryPesquisa := TFDQuery.Create(nil);


  qryPesquisa.Close;
  qryPesquisa.Connection := dmConexao.conn;
  qryPesquisa.SQL.Clear;
  qryPesquisa.SQL.Add('SELECT * '  );
  qryPesquisa.SQL.Add('FROM TITULO_RECEBER_BAIXA_CHEQUE  '  );
  qryPesquisa.SQL.Add('WHERE ID_ORGANIZACAO = :PIDORGANIZACAO  AND  ID_TITULO_RECEBER_BAIXA_CHEQUE = :PID '  );

  qryPesquisa.ParamByName('PIDORGANIZACAO').AsString := value.FIDorganizacao;
  qryPesquisa.ParamByName('PID').AsString := value.FID;
  qryPesquisa.Open;

  if not qryPesquisa.IsEmpty then begin
      trbCheque   := getModel(qryPesquisa) ;
  end;


 Result := trbCheque;
end;



class function TTRBaixaChequeDAO.obterTodosPorBaixa( value: TTRBaixaChequeModel): TFDQuery;
var
qryPesquisa : TFDQuery;
cmdSql:string;
begin
  dmConexao.conectarBanco;

  qryPesquisa := TFDQuery.Create(nil);
  qryPesquisa.Close;
  qryPesquisa.Connection := dmConexao.conn;
  qryPesquisa.SQL.Clear;
  qryPesquisa.SQL.Add('SELECT * '  );
  qryPesquisa.SQL.Add('FROM TITULO_RECEBER_BAIXA_CHEQUE  '  );
  qryPesquisa.SQL.Add('WHERE ID_ORGANIZACAO = :PIDORGANIZACAO  AND  ID_TITULO_RECEBER_BAIXA = :PID '  );

  qryPesquisa.ParamByName('PIDORGANIZACAO').AsString := value.FIDorganizacao;
  qryPesquisa.ParamByName('PID').AsString := value.FIDTRBaixa;
  qryPesquisa.Open;


 Result := qryPesquisa;

end;
class function TTRBaixaChequeDAO.Update(value: TTRBaixaChequeModel): Boolean;
var
qry : TFDQuery;
cmdSql :string;
sucesso : Boolean;
begin
sucesso := False;
dmConexao.conectarBanco;
qry := TFDQuery.Create(nil);

  cmdSql := ' UPDATE TITULO_RECEBER_BAIXA_CHEQUE '+
            '  SET ID_TITULO_RECEBER_BAIXA = :PIDTRB, '+
            '      DATA_PROTOCOLO = :PDATA_PROTOCOLO, '+
            '      VALOR = :PVALOR, '+
            '      NUMERO_CHEQUE =:PNUMERO_CHEQUE, '+
            '      ID_BANCO = :PIDBANCO, '+
            '      CONTA = :PCONTA, '+
            '      AGENCIA = :PAGENCIA, '+
            '      TITULAR = :PTITULAR, '+
            '      CPFCNPJ = :PCPFCNPJ, '+
            '      PERSONALIDADE = :PPERSONA, '+
            '      ID_TIPO_STATUS = :PIDSTATUS, '+
            '      LOTE_DEPOSITO = :PLOTE_DEPOSITO,'+
            '      DATA_DEPOSITO = :PDATADEPOSITO,'+
            '      ID_LOTE_DEPOSITO = :PIDLOTE_DEPOSITO, '+
            '      DATA_DEVOLUCAO = :PDATADEVOLUCAO '+
            '  WHERE (ID_TITULO_RECEBER_BAIXA_CHEQUE = :PID ) AND (ID_ORGANIZACAO = :PIDORGANIZACAO)';


  try

    try
      qry.Close;
      qry.Connection := dmConexao.conn;
      qry.SQL.Clear;
      qry.SQL.Add(cmdSql);
      qry.ParamByName('PID').AsString             := value.FID;
      qry.ParamByName('PIDORGANIZACAO').AsString  := value.FIDorganizacao;
      qry.ParamByName('PCPFCNPJ').AsString        := value.Fcpfcnpj;
      qry.ParamByName('PPERSONA').AsString        := value.Fpersonalidade;
      qry.ParamByName('PIDTRB').AsString          := value.FIDTRBaixa;
      qry.ParamByName('PIDBANCO').AsString        := value.FIDbanco;
      qry.ParamByName('PIDSTATUS').AsString       := value.FIDtipoStatus;
      qry.ParamByName('PNUMERO_CHEQUE').AsString  := value.FnumeroCheque;
      qry.ParamByName('PCONTA').AsString          := value.Fconta;
      qry.ParamByName('PAGENCIA').AsString        := value.Fagencia;
      qry.ParamByName('PTITULAR').AsString        := value.Ftitular;
      qry.ParamByName('PIDLOTE_DEPOSITO').AsString := value.FIDloteDeposito;
      qry.ParamByName('PLOTE_DEPOSITO').AsString   := value.FloteDeposito;
      qry.ParamByName('PVALOR').AsCurrency        := value.FValor;
      qry.ParamByName('PDATA_PROTOCOLO').AsDate   := value.FdataProtocolo;
      qry.ParamByName('PDATADEPOSITO').AsDate     := value.FdataDeposito;
      qry.ParamByName('PDATADEVOLUCAO').AsDate    := value.FdataDevolucao;

      qry.ExecSQL;
      if qry.RowsAffected >0 then begin sucesso := True; end;

      Result := sucesso;

    except
      raise Exception.Create('Erro ao alterar dados do cheque recebido.');

    end;

  finally
    if Assigned(qry) then
    begin
      FreeAndNil(qry);
    end;
  end;

end;
end.
