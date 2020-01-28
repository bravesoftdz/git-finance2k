unit uUsuarioDAO;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, FireDAC.Stan.Intf, FireDAC.Stan.Option,
  FireDAC.Stan.Param, FireDAC.Stan.Error, FireDAC.DatS, FireDAC.Phys.Intf,uMD5,
  FireDAC.DApt.Intf, FireDAC.Stan.Async, FireDAC.DApt, Data.DB, udmConexao, uUtil,
  FireDAC.Comp.DataSet, FireDAC.Comp.Client, uUsuarioModel;

  const
   pTable : string = 'USUARIO';

type
 TUsuarioDAO = class
  private


    class function getModel (query :TFDQuery) : TUsuarioModel;
  public
    {m�todos CRUD (Create, Read, Update e Delete)
    para manipula��o dos dados}
    class function Insert(value :TUsuarioModel): Boolean;
    class function obterPorID(value :TUsuarioModel): TUsuarioModel;
    class function Update(value :TUsuarioModel): Boolean;
    class function Delete(value :TUsuarioModel): Boolean;

  end;


implementation

class function TUsuarioDAO.Delete(value: TUsuarioModel): Boolean;
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
  qryDelete.SQL.Add('DELETE FROM USUARIO  '  );
  qryDelete.SQL.Add('WHERE ID_ORGANIZACAO = :PIDORGANIZACAO  AND  ID_USUARIO = :PID '  );
  qryDelete.ParamByName('PIDORGANIZACAO').AsString := value.FIDorganizacao;
  qryDelete.ParamByName('PID').AsInteger := value.FID;

  qryDelete.ExecSQL;
  xResp := True;


 except
 xResp := False;
 raise Exception.Create('Erro ao tentar DELETAR ' + pTable);

 end;

  Result := xResp;
end;

class function TUsuarioDAO.getModel(query: TFDQuery): TUsuarioModel;
var model :TUsuarioModel;

begin

  if not query.IsEmpty then begin

    try

      model                   := TUsuarioModel.Create;
      model.FID               := query.FieldByName('ID_USUARIO').AsInteger;
      model.FIDorganizacao    := query.FieldByName('ID_ORGANIZACAO').AsString;
      model.Fadmin            := query.FieldByName('EH_ADMINISTRADOR').AsInteger;
      model.Fativo            := query.FieldByName('ATIVO').AsInteger;
      model.Flogin            := query.FieldByName('LOGIN').AsString;
      model.Fnome             := query.FieldByName('NOME').AsString;
      model.Fsenha            := query.FieldByName('SENHA').AsString;
      model.FultimoAcesso     := query.FieldByName('ULTIMO_ACESSO').AsDateTime;

    except
      raise Exception.Create('Erro ao tentar Converter ' + pTable);

    end;


  end;


   Result := model;

end;

class function TUsuarioDAO.Insert(value: TUsuarioModel): Boolean;
var
  qry: TFDQuery;
  cmdSql: string;
begin

  dmConexao.conectarBanco;
  try

     cmdSql := ' INSERT INTO USUARIO ' +
               ' (ID_USUARIO, LOGIN, NOME, SENHA, '+
               ' ATIVO, ID_ORGANIZACAO, EH_ADMINISTRADOR ) '+
               ' VALUES (:PID, :PLOGIN, :PNOME, :PSENHA, :PATIVO, :PIDORGANIZACAO, :PADM  )' ;

    qry := TFDQuery.Create(nil);
    qry.Close;
    qry.Connection := dmConexao.conn;
    qry.SQL.Clear;
    qry.SQL.Add(cmdSql);
    qry.ParamByName('PID').AsInteger := value.FID;
    qry.ParamByName('PIDORGANIZACAO').AsString := value.FIDorganizacao;
    qry.ParamByName('PLOGIN').AsString := value.Flogin;
    qry.ParamByName('PNOME').AsString := value.Fnome;
    qry.ParamByName('PSENHA').AsString := MD5String(value.Fsenha);

    qry.ParamByName('PATIVO').AsInteger := value.Fativo;
    qry.ParamByName('PADM').AsInteger := value.Fadmin;


    qry.ExecSQL;

  except
    Result := False;
    raise Exception.Create('Erro ao tentar inserir ' + pTable);
  end;

  Result := System.True;
end;

class function TUsuarioDAO.obterPorID( value: TUsuarioModel): TUsuarioModel;
var
qryPesquisa : TFDQuery;
cmdSql:string;
model: TUsuarioModel;
begin

dmConexao.conectarBanco;
try
  qryPesquisa := TFDQuery.Create(nil);
  qryPesquisa.Close;
  qryPesquisa.Connection := dmConexao.conn;
  qryPesquisa.SQL.Clear;
  qryPesquisa.SQL.Add('SELECT * '  );
  qryPesquisa.SQL.Add('FROM USUARIO  '  );
  qryPesquisa.SQL.Add('WHERE ID_USUARIO = :PID '  );

  qryPesquisa.ParamByName('PID').AsInteger := value.FID;
  qryPesquisa.Open;

  if not qryPesquisa.IsEmpty then begin

      model := TUsuarioModel.Create;
      model := getModel(qryPesquisa);  end;


except
raise Exception.Create('Erro ao tentar obter ' + pTable );

end;

 Result := model;
end;

class function TUsuarioDAO.Update(value: TUsuarioModel): Boolean;
var
  qryUpdate: TFDQuery;
  cmdSql: string;
begin

  dmConexao.conectarBanco;
  try

     cmdSql :=  ' UPDATE USUARIO '+
                ' SET LOGIN = :PLOGIN, '+
                ' NOME = :PNOME, '+
                ' SENHA = :PSENHA, '+ // USO DO MD5
                ' ATIVO = :PATIVO, '+
                ' ID_ORGANIZACAO =  :PIDORGANIZACAO,'+
                ' EH_ADMINISTRADOR = :PADM '+
                ' WHERE (ID_USUARIO = :PID) ' ;


    qryUpdate := TFDQuery.Create(nil);
    qryUpdate.Close;
    qryUpdate.Connection := dmConexao.conn;
    qryUpdate.SQL.Clear;
    qryUpdate.SQL.Add(cmdSql);
    qryUpdate.ParamByName('PID').AsInteger := value.FID;
    qryUpdate.ParamByName('PIDORGANIZACAO').AsString := value.FIDorganizacao;
    qryUpdate.ParamByName('PLOGIN').AsString := value.Flogin;
    qryUpdate.ParamByName('PNOME').AsString := value.Fnome;
    qryUpdate.ParamByName('PSENHA').AsString := MD5String(value.Fsenha);

    qryUpdate.ParamByName('PATIVO').AsInteger := value.Fativo;
    qryUpdate.ParamByName('PADM').AsInteger := value.Fadmin;


    qryUpdate.ExecSQL;

  except
    Result := False;
    raise Exception.Create('Erro ao tentar alterar ' + pTable);
  end;

  Result := System.True;
end;
end.