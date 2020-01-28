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
    class function validarLogin(value: TUsuarioModel): Boolean;
    class function registrarAcesso (value: TUsuarioModel): Boolean;
    class function alterarSenha (value: TUsuarioModel): Boolean;
    class function resetSenha (value: TUsuarioModel): Boolean;



  end;


implementation

class function TUsuarioDAO.validarLogin (value :TUsuarioModel) : Boolean;
var
qryValidarUsuario : TFDQuery;

userWindows, ipHost, nameHost, cmdSql : string;

begin
 dmConexao.conectarBanco;

  try

          qryValidarUsuario := TFDQuery.Create(nil);
          qryValidarUsuario.Close;
          qryValidarUsuario.Connection := dmConexao.Conn;
          qryValidarUsuario.SQL.Clear;
          qryValidarUsuario.SQL.Add('SELECT * FROM USUARIO  '  );
          qryValidarUsuario.SQL.Add('WHERE (ID_USUARIO = :PID) AND (upper(LOGIN) = :PLOGIN)  AND (SENHA = :PSENHA) '  );

          qryValidarUsuario.ParamByName('PID').AsInteger := value.FID;
          qryValidarUsuario.ParamByName('PLOGIN').AsString :=UpperCase(value.Flogin);
          qryValidarUsuario.ParamByName('PSENHA').AsString := MD5String(value.Fsenha);
          qryValidarUsuario.Open;

          userWindows  := qryValidarUsuario.FieldByName('USER_WINDOWS').AsString ;
          ipHost       := qryValidarUsuario.FieldByName('IP_HOST').AsString ;
          nameHost     := qryValidarUsuario.FieldByName('NAME_HOST').AsString ;

        if not qryValidarUsuario.IsEmpty then begin

          if uUtil.Empty(userWindows) then begin

            userWindows := uUtil.GetUserFromWindows;
            ipHost      := uutil.GetIp;
            nameHost    := uutil.GetComputerNetName;

            value := TUsuarioModel.Create;
            value := TUsuarioDAO.getModel(qryValidarUsuario);
            if not uutil.Empty(value.Flogin) then begin

              value.FuserWindows  := userWindows;
              value.FipHost       := ipHost;
              value.FnameHost     := nameHost;
               TUsuarioDAO.Update(value);
             end;

          end;
        end;






      except
    raise(Exception).Create('Problemas ao consultar dados do usu�rio para validar... ');
  end;


 Result := not qryValidarUsuario.IsEmpty;

end;

class function TUsuarioDAO.alterarSenha(value: TUsuarioModel): Boolean;
var
qryUpdatePass : TFDQuery;
cmdSql : string;
begin
 dmConexao.conectarBanco;

  try
          qryUpdatePass := TFDQuery.Create(nil);
          qryUpdatePass.Close;
          qryUpdatePass.Connection := dmConexao.Conn;
          qryUpdatePass.SQL.Clear;
          qryUpdatePass.SQL.Add('UPDATE  USUARIO SET SENHA = :PSENHA  '  );
          qryUpdatePass.SQL.Add('WHERE (ID_USUARIO = :PID) AND (LOGIN = :PLOGIN) '  );

          qryUpdatePass.ParamByName('PID').AsInteger := value.FID;
          qryUpdatePass.ParamByName('PLOGIN').AsString := value.Flogin;
          qryUpdatePass.ParamByName('PSENHA').AsString := MD5String(value.Fsenha);

          qryUpdatePass.ExecSQL;



    except
    raise(Exception).Create('Problemas ao alterar senha do usu�rio ');
  end;


 Result := System.True;
end;

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
      model.FuserWindows      := query.FieldByName('USER_WINDOWS').AsString;
      model.FnameHost         := query.FieldByName('NAME_HOST').AsString;
      model.FipHost           := query.FieldByName('IP_HOST').AsString;
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
               ' ATIVO, ID_ORGANIZACAO, EH_ADMINISTRADOR, USER_WINDOWS,NAME_HOST, IP_HOST  ) '+
               ' VALUES (:PID, :PLOGIN, :PNOME, :PSENHA, :PATIVO, :PIDORGANIZACAO, :PADM, :PUSER_WINDOWS, :PNAME_HOST, :PIP_HOST  )' ;



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
    qry.ParamByName('PUSER_WINDOWS').AsString := value.FuserWindows;
    qry.ParamByName('PNAME_HOST').AsString := value.FnameHost;
    qry.ParamByName('PIP_HOST').AsString := value.FipHost;

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

class function TUsuarioDAO.registrarAcesso(value: TUsuarioModel): Boolean;
var
qryUpdate : TFDQuery;
cmdSql : string;
begin
 dmConexao.conectarBanco;

  try

     cmdSql :=  ' UPDATE USUARIO '+
                ' SET ATIVO         = :PATIVO, '+
                ' USER_WINDOWS      = :PUSER_WINDOWS, '+
                ' NAME_HOST         = :PNAME_HOST, '+
                ' IP_HOST           = :PIP_HOST, '+
                ' ULTIMO_ACESSO     = :PNOW '+
                ' WHERE (ID_USUARIO = :PID) ' ;


    qryUpdate := TFDQuery.Create(nil);
    qryUpdate.Close;
    qryUpdate.Connection := dmConexao.conn;
    qryUpdate.SQL.Clear;
    qryUpdate.SQL.Add(cmdSql);

    qryUpdate.ParamByName('PID').AsInteger := value.FID;
    qryUpdate.ParamByName('PNOW').AsDateTime := Now;
    qryUpdate.ParamByName('PUSER_WINDOWS').AsString := value.FuserWindows;
    qryUpdate.ParamByName('PNAME_HOST').AsString := value.FnameHost;
    qryUpdate.ParamByName('PIP_HOST').AsString := value.FipHost;
    qryUpdate.ParamByName('PATIVO').AsInteger := 1;
    qryUpdate.ExecSQL;


    except
    raise(Exception).Create('Problemas ao registrar acesso do usu�rio ');
  end;


 Result := System.True;
end;

class function TUsuarioDAO.resetSenha(value: TUsuarioModel): Boolean;
var
qryUpdatePass : TFDQuery;
cmdSql : string;
begin
 dmConexao.conectarBanco;

  try
          qryUpdatePass := TFDQuery.Create(nil);
          qryUpdatePass.Close;
          qryUpdatePass.Connection := dmConexao.Conn;
          qryUpdatePass.SQL.Clear;
          qryUpdatePass.SQL.Add('UPDATE  USUARIO SET SENHA = :PSENHA'  );
          qryUpdatePass.SQL.Add('WHERE (ID_USUARIO = :PID) AND (LOGIN = :PLOGIN) '  );

          qryUpdatePass.ParamByName('PID').AsInteger := value.FID;
          qryUpdatePass.ParamByName('PLOGIN').AsString := value.Flogin;
          qryUpdatePass.ParamByName('PSENHA').AsString := MD5String('123456');

          qryUpdatePass.ExecSQL;



    except
    raise(Exception).Create('Problemas ao resetar senha do usu�rio ');
  end;


 Result := System.True;
end;

class function TUsuarioDAO.Update(value: TUsuarioModel): Boolean;
var
  qryUpdate: TFDQuery;
  cmdSql: string;
begin

  dmConexao.conectarBanco;
  try

     cmdSql :=  ' UPDATE USUARIO '+
                ' SET LOGIN         = :PLOGIN, '+
                ' NOME              = :PNOME, '+
              //  ' SENHA             = :PSENHA, '+
                ' ATIVO             = :PATIVO, '+
                ' USER_WINDOWS      = :PUSER_WINDOWS, '+
                ' NAME_HOST         = :PNAME_HOST, '+
                ' IP_HOST           = :PIP_HOST, '+
                ' ID_ORGANIZACAO    = :PIDORGANIZACAO,'+
                ' EH_ADMINISTRADOR  = :PADM '+
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
//    qryUpdate.ParamByName('PSENHA').AsString := value.Fsenha; funcao reset senha e outra pra mudar senha
    qryUpdate.ParamByName('PUSER_WINDOWS').AsString := value.FuserWindows;
    qryUpdate.ParamByName('PNAME_HOST').AsString := value.FnameHost;
    qryUpdate.ParamByName('PIP_HOST').AsString := value.FipHost;

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