unit uTesourariaCRDAO;

interface
 {
ID_TESOURARIA_CREDITO           VARCHAR(36) NOT NULL,
    ID_ORGANIZACAO                  VARCHAR(36) NOT NULL,
    ID_HISTORICO                    VARCHAR(36),
    ID_RESPONSAVEL                  VARCHAR(36),
    ID_SACADO                       VARCHAR(36),
    ID_TITULO_RECEBER_BAIXA_CHEQUE  VARCHAR(36),
    ID_TITULO_RECEBER_BAIXA         VARCHAR(36),
    ID_USUARIO                      NUMERIC(5,0),
    ID_LOTE_CONTABIL                VARCHAR(36),
    ID_CONTA_BANCARIA_DEBITO        VARCHAR(36)

    DATA_REGISTRO                   DATE,
    DATA_CONTABIL                   DATE,
    DATA_MOVIMENTO                  DATE NOT NULL,
    VALOR_NOMINAL                   NUMERIC(10,2) NOT NULL,

    OBSERVACAO                      VARCHAR(200),
    NUMERO_DOCUMENTO                VARCHAR(40),
    DESCRICAO                       VARCHAR(120),
    TIPO_LANCAMENTO                 VARCHAR(1) NOT NULL

}

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, FireDAC.Stan.Intf, FireDAC.Stan.Option,uTPBaixaModel, uFuncionarioModel, uSacadoModel, uSacadoDAO,
  FireDAC.Stan.Param, FireDAC.Stan.Error, FireDAC.DatS, FireDAC.Phys.Intf,uUsuarioModel, uUsuarioDAO,
  uLoteContabilModel, uLoteContabilDAO, uContaBancariaDBModel, uContaBancariaDebitoDAO, uTesourariaCRModel, uTRBaixaChequeModel, uTRBaixaChequeDAO,
  FireDAC.DApt.Intf, FireDAC.Stan.Async, FireDAC.DApt, Data.DB, uHistoricoModel, uHistoricoDAO, udmConexao, uUtil,
  FireDAC.Comp.DataSet, FireDAC.Comp.Client;


  const
   pTable : string = 'TESOURARIA_CREDITO';
type
 TTesourariaCRDAO = class
  private
    class function getModel (query :TFDQuery) : TTesourariaCRModel;
  public
    {m�todos CRUD (Create, Read, Update e Delete)
    para manipula��o dos dados}
    class function Insert(value :TTesourariaCRModel): Boolean;
    class function obterPorID(value :TTesourariaCRModel): TTesourariaCRModel;
    class function Delete(value :TTesourariaCRModel): Boolean;
    class function deleteTodosPorTRB(value :TTesourariaCRModel): Boolean;

  end;

implementation

class function TTesourariaCRDAO.Delete(value: TTesourariaCRModel): Boolean;
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
      qryDelete.SQL.Add('DELETE FROM ' + pTable);
      qryDelete.SQL.Add('WHERE ID_ORGANIZACAO = :PIDORGANIZACAO  AND  ID_' + pTable + ' = :PID ');
      qryDelete.ParamByName('PIDORGANIZACAO').AsString := value.FIDorganizacao;
      qryDelete.ParamByName('PID').AsString := value.FID;

      qryDelete.ExecSQL;
      if qryDelete.RowsAffected >0 then begin  sucesso := True; end;

    except
      sucesso := False;
      raise Exception.Create('Erro ao tentar DELETAR ' + pTable);

    end;

    Result := sucesso;

  finally
    if Assigned(qryDelete) then
    begin
      FreeAndNil(qryDelete);
    end;
  end;


end;

class function TTesourariaCRDAO.deleteTodosPorTRB(value: TTesourariaCRModel): Boolean;
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
      qryDelete.SQL.Add('DELETE FROM ' + pTable);
      qryDelete.SQL.Add('WHERE ID_ORGANIZACAO = :PIDORGANIZACAO  AND  ID_TITULO_RECEBER_BAIXA = :PID ');
      qryDelete.ParamByName('PIDORGANIZACAO').AsString := value.FIDorganizacao;
      qryDelete.ParamByName('PID').AsString := value.FIDTRB;

      qryDelete.ExecSQL;
      if qryDelete.RowsAffected >0 then begin  sucesso := True; end;

    except
      sucesso := False;
      raise Exception.Create('Erro ao tentar DELETAR ' + pTable);

    end;

    Result := sucesso;
  finally
    if Assigned(qryDelete) then
    begin
      FreeAndNil(qryDelete);
    end;
  end;


end;

class function TTesourariaCRDAO.getModel(query: TFDQuery): TTesourariaCRModel;
var model :TTesourariaCRModel;
cContaDebito : TContaBancariaDBModel ;
sacado : TSacadoModel;
loteContabil : TLoteContabilModel;

begin
  model                       := TTesourariaCRModel.Create;
  model.FSacado               := TSacadoModel.Create;
  model.FContaBancariaDebito  := TContaBancariaDBModel.Create;
  model.FLoteContabil         := TLoteContabilModel.Create;
  model.FHistorico            := THistoricoModel.Create;
  model.FCheque               := TTRBaixaChequeModel.Create;



  if not query.IsEmpty then begin

    try

      model.FID                     := query.FieldByName('ID_TESOURARIA_CREDITO').AsString;
      model.FIDorganizacao          := query.FieldByName('ID_ORGANIZACAO').AsString;
      model.FIDTRB                  := query.FieldByName('ID_TITULO_RECEBER_BAIXA').AsString;
      model.FIDHistorico            := query.FieldByName('ID_HISTORICO').AsString;
      model.FIDResponsavel          := query.FieldByName('ID_RESPONSAVEL').AsString;
      model.FIDSacado               := query.FieldByName('ID_SACADO').AsString;
      model.FIDUsuario              := query.FieldByName('ID_USUARIO').AsInteger;
      model.FIDLoteContabil         := query.FieldByName('ID_LOTE_CONTABIL').AsString;
      model.FIDcheque               := query.FieldByName('ID_TITULO_RECEBER_BAIXA_CHEQUE').AsString;
      model.FIDcontaBancariaDebito  := query.FieldByName('ID_CONTA_BANCARIA_DEBITO').AsString;
      model.FvalorNominal           := query.FieldByName('VALOR_NOMINAL').AsCurrency;
      model.Fobservacao             := query.FieldByName('OBSERVACAO').AsString;
      model.FtipoLancamento         := query.FieldByName('TIPO_LANCAMENTO').AsString;
      model.Fdescricao              := query.FieldByName('DESCRICAO').AsString;
      model.FnumeroDocumento        := query.FieldByName('NUMERO_DOCUMENTO').AsString;
      model.FdataRegistro           := query.FieldByName('DATA_REGISTRO').AsDateTime;
      model.FdataContabil           := query.FieldByName('DATA_CONTABIL').AsDateTime;
      model.FdataMovimento := query.FieldByName('DATA_MOVIMENTO').AsDateTime;

      model.FContaBancariaDebito.FID := model.FIDcontaBancariaDebito;
      model.FContaBancariaDebito.FIDOrganizacao := model.FIDOrganizacao;
      model.FContaBancariaDebito := TContaBancariaDebitoDAO.obterPorID(model.FContaBancariaDebito);

      model.FSacado.FID := model.FIDSacado;
      model.FSacado.FIDOrganizacao := model.FIDOrganizacao;
      model.FSacado := TSacadoDAO.obterPorID(model.FSacado);

      model.FLoteContabil.FID := model.FIDLoteContabil;
      model.FLoteContabil.FIDOrganizacao := model.FIDOrganizacao;
      model.FLoteContabil := TLoteContabilDAO.obterPorID(model.FLoteContabil);

      model.FCheque.FID := model.FIDcheque;
      model.FCheque.FIDorganizacao := model.FIDOrganizacao;
      model.FCheque := TTRBaixaChequeDAO.obterPorID(model.FCheque);

      model.FHistorico.FID := model.FIDHistorico;
      model.FHistorico.FIdOrganizacao := model.FIDorganizacao;
      model.FHistorico := THistoricoDAO.obterPorID(model.FHistorico);


    except
      raise Exception.Create('Erro ao tentar Converter ' + pTable);

    end;

  end;


   Result := model;

end;

class function TTesourariaCRDAO.Insert(value: TTesourariaCRModel): Boolean;
var
  qryInsert: TFDQuery;
  cmdDB: string;
  sucesso : Boolean;

begin
  sucesso := False;
  dmConexao.conectarBanco;
  qryInsert := TFDQuery.Create(nil);
  try


     cmdDB := ' INSERT INTO TESOURARIA_CREDITO ' +
              ' (ID_TESOURARIA_CREDITO, ID_ORGANIZACAO, ID_HISTORICO, ID_RESPONSAVEL,ID_SACADO, ' +
              ' ID_USUARIO, NUMERO_DOCUMENTO, DESCRICAO, DATA_REGISTRO, DATA_CONTABIL, DATA_MOVIMENTO, VALOR_NOMINAL, '+
              ' TIPO_LANCAMENTO,  ID_CONTA_BANCARIA_DEBITO, ID_TITULO_RECEBER_BAIXA, ID_TITULO_RECEBER_BAIXA_CHEQUE, '+
              ' OBSERVACAO)  '+
              ' VALUES (:PID,:PIDORGANIZACAO,:PIDHIST,:PIDRESPONSAVEL,:PIDSACADO, '+
              ' :PIDUSER,:PNUMDOC, :PDESCRICAO, :PDTREGISTRO, :PDTCONTABIL, :PDTMOVIMENTO, :PVALOR, :PTIPO, :PIDCONTABANCO, '+
              ' :PIDTITULO_RECEBER_BAIXA, :PCHEQUE, :POBSERVACAO   ) ' ;



    qryInsert.Close;
    qryInsert.Connection := dmConexao.conn;
    qryInsert.SQL.Clear;
    qryInsert.SQL.Add(cmdDB);
    qryInsert.ParamByName('PID').AsString :=value.FID;
    qryInsert.ParamByName('PIDORGANIZACAO').AsString := value.FIDorganizacao;
    qryInsert.ParamByName('PIDHIST').AsString := value.FIDHistorico;
    qryInsert.ParamByName('PIDRESPONSAVEL').AsString := value.FIDResponsavel;
    qryInsert.ParamByName('PIDSACADO').AsString := value.FIDSacado;
    qryInsert.ParamByName('PIDUSER').AsInteger := value.FIDUsuario;
    qryInsert.ParamByName('PIDCONTABANCO').AsString := value.FIDcontaBancariaDebito;
    qryInsert.ParamByName('PIDTITULO_RECEBER_BAIXA').AsString := value.FIDTRB;
    qryInsert.ParamByName('PCHEQUE').AsString := value.FIDcheque;
    qryInsert.ParamByName('PTIPO').AsString :=value.FtipoLancamento;
    qryInsert.ParamByName('PNUMDOC').AsString := value.FnumeroDocumento;
    qryInsert.ParamByName('PDESCRICAO').AsString := value.Fdescricao;
    qryInsert.ParamByName('PDTREGISTRO').AsDate := value.FdataRegistro;
    qryInsert.ParamByName('PDTCONTABIL').AsDate := value.FdataContabil;
    qryInsert.ParamByName('PDTMOVIMENTO').AsDate := value.FdataMovimento;
    qryInsert.ParamByName('PVALOR').AsCurrency := value.FvalorNominal   ;
    qryInsert.ParamByName('POBSERVACAO').AsString := value.Fobservacao;


    if uUtil.Empty(value.FID) then
    begin
      qryInsert.ParamByName('PID').AsString := dmConexao.obterNewID;
    end;

    if uUtil.Empty(value.FnumeroDocumento) then
    begin
      qryInsert.ParamByName('PNUMDOC').AsString := dmConexao.obterIdentificador('',value.FIDorganizacao, 'TC');
     end;

    if uUtil.Empty(value.FIDTRB) then
    begin
      qryInsert.ParamByName('PIDTITULO_RECEBER_BAIXA').Value := null;
    end;

     if uUtil.Empty(value.FIDcheque) then
    begin
      qryInsert.ParamByName('PCHEQUE').Value := null;
    end;

    if uUtil.Empty(value.FIDcontaBancariaDebito) then
    begin
      qryInsert.ParamByName('PIDCONTABANCO').Value := null;
    end;

    if value.FIDUsuario = 0 then
    begin
      qryInsert.ParamByName('PIDUSER').Value := uUtil.TUserAtual.getUserId;
    end;

    if uUtil.Empty(value.FIDSacado) then
    begin
      qryInsert.ParamByName('PIDSACADO').Value := null;
    end;

    if value.FdataRegistro < IncMonth(Now, -24) then //na pode ser menor que o ano
    begin
     qryInsert.ParamByName('PDTREGISTRO').AsDate      := Now;
    end;

    qryInsert.ExecSQL;

    if qryInsert.RowsAffected > 0 then
    begin
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

class function TTesourariaCRDAO.obterPorID( value: TTesourariaCRModel): TTesourariaCRModel;
var
qryPesquisa : TFDQuery;
cmdSql:string;
model: TTesourariaCRModel;
begin
  dmConexao.conectarBanco;
  qryPesquisa := TFDQuery.Create(nil);
  model := TTesourariaCRModel.Create;

  try

    try

      qryPesquisa.Close;
      qryPesquisa.Connection := dmConexao.conn;
      qryPesquisa.SQL.Clear;
      qryPesquisa.SQL.Add('SELECT * ');
      qryPesquisa.SQL.Add('FROM ' + pTable);
      qryPesquisa.SQL.Add('WHERE (ID_ORGANIZACAO = :PIDORGANIZACAO ) AND  ID_' + pTable + ' = :PID ');

      qryPesquisa.ParamByName('PID').AsString := value.FID;
      qryPesquisa.ParamByName('PIDORGANIZACAO').AsString := value.FIDorganizacao;

      qryPesquisa.Open;

      if not qryPesquisa.IsEmpty then
      begin
        model := getModel(qryPesquisa);
      end;

    except
      raise Exception.Create('Erro ao tentar obter ' + pTable);

    end;

    Result := model;

  finally
    if Assigned(qryPesquisa) then
    begin
      FreeAndNil(qryPesquisa);
    end;
  end;

end;


end.
