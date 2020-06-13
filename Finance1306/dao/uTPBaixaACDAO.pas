unit uTPBaixaACDAO;

interface


uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, FireDAC.Stan.Intf, FireDAC.Stan.Option,uTPBaixaACModel,System.Generics.Collections,
  FireDAC.Stan.Param, FireDAC.Stan.Error, FireDAC.DatS, FireDAC.Phys.Intf,uTipoAcrescimoModel,uTipoAcrescimoDAO,
  FireDAC.DApt.Intf, FireDAC.Stan.Async, FireDAC.DApt, Data.DB, uHistoricoModel, uHistoricoDAO, udmConexao, uUtil,
  FireDAC.Comp.DataSet, FireDAC.Comp.Client;


  const
   pTable : string = 'TITULO_PAGAR_BAIXA_AC';



type
 TTPBaixaACDAO = class
  private
    class function getModel (query :TFDQuery) : TTPBaixaACModel;
  public
    {m�todos CRUD (Create, Read, Update e Delete)
    para manipula��o dos dados}
    class function Insert(value :TTPBaixaACModel): Boolean;
    class function obterPorID(value :TTPBaixaACModel): TTPBaixaACModel;
    class function obterListaACPorBaixa(idBaixa :string) : TFDQuery;
    class function Update(value :TTPBaixaACModel): Boolean;
    class function Delete(value :TTPBaixaACModel): Boolean;
    class function deletePorTPBaixa(value :TTPBaixaACModel): Boolean;


  end;

implementation

class function TTPBaixaACDAO.Delete(value: TTPBaixaACModel): Boolean;
var
qry : TFDQuery;
sucesso :Boolean;
begin
  sucesso := False;
  dmConexao.conectarBanco;
  qry := TFDQuery.Create(nil);

  try
    try

      qry.Close;
      qry.Connection := dmConexao.conn;
      qry.SQL.Clear;
      qry.SQL.Add('DELETE FROM ' + pTable);
      qry.SQL.Add('WHERE ID_ORGANIZACAO = :PIDORGANIZACAO  AND  ID_' + pTable + ' = :PID ');
      qry.ParamByName('PIDORGANIZACAO').AsString := value.FIDorganizacao;
      qry.ParamByName('PID').AsString := value.FID;

      qry.ExecSQL;

      if qry.RowsAffected > 0 then
      begin
        sucesso := True;
      end;

      dmConexao.conn.CommitRetaining;

      Result := sucesso;

    except
      dmConexao.conn.RollbackRetaining;
      sucesso := False;
      raise Exception.Create('Erro ao tentar DELETAR ' + pTable);

    end;

  finally
    if Assigned(qry) then
    begin
      FreeAndNil(qry);
    end;
  end;
end;

class function TTPBaixaACDAO.deletePorTPBaixa(value: TTPBaixaACModel): Boolean;
var
qryDelete : TFDQuery;
sucesso :Boolean;
begin
sucesso := False;

 dmConexao.conectarBanco;
 try

  qryDelete := TFDQuery.Create(nil);
  qryDelete.Close;
  qryDelete.Connection := dmConexao.conn;
  qryDelete.SQL.Clear;
  qryDelete.SQL.Add('DELETE FROM '+pTable     );
  qryDelete.SQL.Add('WHERE ID_ORGANIZACAO = :PIDORGANIZACAO  AND  ID_TITULO_PAGAR_BAIXA = :PID '  );
  qryDelete.ParamByName('PIDORGANIZACAO').AsString := value.FIDorganizacao;
  qryDelete.ParamByName('PID').AsString := value.FIDtituloPagarBaixa;

  qryDelete.ExecSQL;

  if qryDelete.RowsAffected >0  then begin

    sucesso := True;

   end;


 except
 sucesso := False;
 raise Exception.Create('Erro ao tentar DELETAR ' + pTable);

 end;

  Result := sucesso;
end;

class function TTPBaixaACDAO.getModel(query: TFDQuery): TTPBaixaACModel;
var model :TTPBaixaACModel;

begin
  model                     := TTPBaixaACModel.Create;
  model.FtipoAcrescimo                := TTipoAcrescimoModel.Create;

  if not query.IsEmpty then begin

    try


      model.FID                 := query.FieldByName('ID_TITULO_PAGAR_BAIXA_AC').AsString;
      model.FIDorganizacao      := query.FieldByName('ID_ORGANIZACAO').AsString;
      model.FIDtituloPagarBaixa := query.FieldByName('ID_TITULO_PAGAR_BAIXA').AsString;
      model.FIDtipoAcrescimo    := query.FieldByName('ID_TIPO_ACRESCIMO').AsString;
      model.Fvalor              := query.FieldByName('VALOR').AsCurrency;

        try


          model.FtipoAcrescimo.FID            := model.FIDtipoAcrescimo;
          model.FtipoAcrescimo.FIDOrganizacao := model.FIDOrganizacao;
          model.FtipoAcrescimo                := TTipoAcrescimoDAO.obterPorID(model.FtipoAcrescimo);

          // model.FtituloPagarBaixa

        except
          raise Exception.Create('Erro ao tentar obter Conta Contabil por ' + pTable);

        end;

    except
      raise Exception.Create('Erro ao tentar Converter ' + pTable);

    end;

  end;


   Result := model;

end;

class function TTPBaixaACDAO.Insert(value: TTPBaixaACModel): Boolean;
var
  qry: TFDQuery;
  cmdSql: string;
begin

  dmConexao.conectarBanco;
  qry := TFDQuery.Create(nil);
  try


     cmdSql :=  ' INSERT INTO TITULO_PAGAR_BAIXA_AC '+
                ' (ID_TITULO_PAGAR_BAIXA_AC, ID_ORGANIZACAO, ID_TITULO_PAGAR_BAIXA, ID_TIPO_ACRESCIMO, VALOR ) '+
                ' VALUES (:PID, :PIDORGANIZACAO, :PIDBAIXA,:PIDTIPO_AC, :PVALOR ) ';



    qry.Close;
    qry.Connection := dmConexao.conn;
    qry.SQL.Clear;
    qry.SQL.Add(cmdSql);
    qry.ParamByName('PID').AsString                   := value.FID;
    qry.ParamByName('PIDORGANIZACAO').AsString        := value.FIDorganizacao;
    qry.ParamByName('PIDTIPO_AC').AsString            := value.FIDtipoAcrescimo;
    qry.ParamByName('PIDBAIXA').AsString              := value.FIDtituloPagarBaixa;
    qry.ParamByName('PVALOR').AsCurrency              := value.Fvalor ;
    qry.ExecSQL;


  Result := System.True;
  finally
    if Assigned(qry) then
    begin
      FreeAndNil(qry);
    end;
  end;


end;

class function TTPBaixaACDAO.obterListaACPorBaixa(idBaixa: string): TFDQuery;
var
qryPesquisa : TFDQuery;
cmdSql:string;
model: TTPBaixaACModel;
begin
dmConexao.conectarBanco;
try
  qryPesquisa := TFDQuery.Create(nil);
  qryPesquisa.Close;
  qryPesquisa.Connection := dmConexao.conn;
  qryPesquisa.SQL.Clear;
  qryPesquisa.SQL.Add('SELECT * '  );
  qryPesquisa.SQL.Add('FROM ' + pTable  );
  qryPesquisa.SQL.Add('WHERE (ID_ORGANIZACAO = :PIDORGANIZACAO ) AND  ID_TITULO_PAGAR_BAIXA  = :PID '  );

  qryPesquisa.ParamByName('PID').AsString := idBaixa;
  qryPesquisa.ParamByName('PIDORGANIZACAO').AsString := uutil.TOrgAtual.getId;

  qryPesquisa.Open;


except
raise Exception.Create('Erro ao tentar obter ' + pTable );

end;

 Result := qryPesquisa;
end;


class function TTPBaixaACDAO.obterPorID( value: TTPBaixaACModel): TTPBaixaACModel;
var
qryPesquisa : TFDQuery;
cmdSql:string;
model: TTPBaixaACModel;
begin

dmConexao.conectarBanco;
try
  qryPesquisa := TFDQuery.Create(nil);
  qryPesquisa.Close;
  qryPesquisa.Connection := dmConexao.conn;
  qryPesquisa.SQL.Clear;
  qryPesquisa.SQL.Add('SELECT * '  );
  qryPesquisa.SQL.Add('FROM ' + pTable  );
  qryPesquisa.SQL.Add('WHERE (ID_ORGANIZACAO = :PIDORGANIZACAO ) AND  ID_'+pTable+ ' = :PID '  );

  qryPesquisa.ParamByName('PID').AsString := value.FID;
  qryPesquisa.ParamByName('PIDORGANIZACAO').AsString := value.FIDorganizacao;

  qryPesquisa.Open;

  if not qryPesquisa.IsEmpty then begin

      model := TTPBaixaACModel.Create;
      model := getModel(qryPesquisa);  end;


except
raise Exception.Create('Erro ao tentar obter ' + pTable );

end;

 Result := model;
end;




class function TTPBaixaACDAO.Update(value: TTPBaixaACModel): Boolean;
var
  qry: TFDQuery;
  cmdSql: string;
begin
  dmConexao.conectarBanco;
  qry := TFDQuery.Create(nil);

  try

    try

     cmdSql := ' UPDATE TITULO_PAGAR_BAIXA_AC '+
               ' SET ID_TITULO_PAGAR_BAIXA = :PIDBAIXA, '+
               '     ID_TIPO_ACRESCIMO = :PIDTIPO_AC,'+
               '     VALOR = :PVALOR '+
               ' WHERE (ID_TITULO_PAGAR_BAIXA_AC = :PID) AND (ID_ORGANIZACAO = :PIDORGANIZACAO) ';


    qry.Close;
    qry.Connection := dmConexao.conn;
    qry.SQL.Clear;
    qry.SQL.Add(cmdSql);
    qry.ParamByName('PID').AsString                   := value.FID;
    qry.ParamByName('PIDORGANIZACAO').AsString        := value.FIDorganizacao;
    qry.ParamByName('PIDTIPO_AC').AsString            := value.FIDtipoAcrescimo;
    qry.ParamByName('PIDBAIXA').AsString              := value.FIDtituloPagarBaixa;
    qry.ParamByName('PVALOR').AsCurrency              := value.Fvalor ;
    qry.ExecSQL;

    except
      Result := False;
      raise Exception.Create('Erro ao tentar alterar ' + pTable);
    end;

    Result := System.True;
  finally
    if Assigned(qry) then
    begin
      FreeAndNil(qry);
    end;
  end;

end;

end.

