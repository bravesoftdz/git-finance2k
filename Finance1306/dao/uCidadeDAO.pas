unit uCidadeDAO;

interface


uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, FireDAC.Stan.Intf, FireDAC.Stan.Option,uCidadeModel,
  FireDAC.Stan.Param, FireDAC.Stan.Error, FireDAC.DatS, FireDAC.Phys.Intf, uEstadoModel, uEstadoDAO,
  FireDAC.DApt.Intf, FireDAC.Stan.Async, FireDAC.DApt, Data.DB, udmConexao, uUtil,
  FireDAC.Comp.DataSet, FireDAC.Comp.Client,Vcl.StdCtrls;

  const
   pTable : string = 'CIDADE';

type
 TCidadeDAO = class
  private
    //class function ComandoSql(AReceber: TReceber): Boolean;

    class function getModel (query :TFDQuery) : TCidadeModel;
  public
    {m�todos CRUD (Create, Read, Update e Delete)
    para manipula��o dos dados}
   class function Insert(value :TCidadeModel): Boolean;
    class function obterPorID(value :TCidadeModel): TCidadeModel;
    class function Update(value :TCidadeModel): Boolean;
    class function Delete(value :TCidadeModel): Boolean;

  end;

implementation

class function TCidadeDAO.Delete(value: TCidadeModel): Boolean;
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
      qryDelete.SQL.Add('DELETE FROM CIDADE  ');
      qryDelete.SQL.Add('WHERE ID_CIDADE = :PID ');
      qryDelete.ParamByName('PID').AsString := value.FID;

      qryDelete.ExecSQL;

      if qryDelete.RowsAffected > 0 then
      begin
        sucesso := True;
      end;

      sucesso := True;

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

class function TCidadeDAO.getModel(query: TFDQuery): TCidadeModel;
var model :TCidadeModel;
 estado : TEstadoModel;
begin
  estado := TEstadoModel.Create;
  model := TCidadeModel.Create;

  if not query.IsEmpty then begin

    try

      model.FID        := query.FieldByName('ID_CIDADE').AsString;
      model.FIDestado  := query.FieldByName('ID_ESTADO').AsString;
      model.Fcidade    := query.FieldByName('CIDADE').AsString;
      model.Fcodigo    := query.FieldByName('CODIGO').AsInteger;
      model.Fnovo      := False;


      estado.FID := model.FIDestado;
      model.Festado := TEstadoDAO.obterPorID(estado);

    except
      raise Exception.Create('Erro ao tentar Converter ' + pTable);

    end;

  end;


   Result := model;

end;

class function TCidadeDAO.Insert(value: TCidadeModel): Boolean;
var
  qry: TFDQuery;
  cmdSql: string;
  sucesso :Boolean;
begin
 sucesso := False;
  dmConexao.conectarBanco;
  qry := TFDQuery.Create(nil);
  try
    try

     cmdSql :=  ' INSERT INTO CIDADE (ID_CIDADE, CODIGO, CIDADE, ID_ESTADO) ' +
                ' VALUES (:PID,:PCODIGO; :PCIDADE, :PID_ESTADO)';


    qry.Close;
    qry.Connection := dmConexao.conn;
    qry.SQL.Clear;
    qry.SQL.Add(cmdSql);
    qry.ParamByName('PID').AsString         := value.FID;
    qry.ParamByName('PID_ESTADO').AsString  := value.FIDestado;
    qry.ParamByName('PCIDADE').AsString     := value.Fcidade;
    qry.ParamByName('PCODIGO').AsInteger    := value.Fcodigo;

    qry.ExecSQL;

     if qry.RowsAffected >0 then begin

        sucesso := True;
     end;

    except
      Result := sucesso;
      raise Exception.Create('Erro ao tentar inserir ' + pTable);
    end;

    Result := sucesso
  finally
    if Assigned(qry) then
    begin
      FreeAndNil(qry);
    end;
  end;
end;

class function TCidadeDAO.obterPorID( value: TCidadeModel): TCidadeModel;
var
qryPesquisa : TFDQuery;
cmdSql:string;
model: TCidadeModel;
begin

dmConexao.conectarBanco;
qryPesquisa := TFDQuery.Create(nil);
model := TCidadeModel.Create;

try

  qryPesquisa.Close;
  qryPesquisa.Connection := dmConexao.conn;
  qryPesquisa.SQL.Clear;
  qryPesquisa.SQL.Add('SELECT * '  );
  qryPesquisa.SQL.Add('FROM CIDADE  '  );
  qryPesquisa.SQL.Add('WHERE ID_CIDADE = :PID '  );

  qryPesquisa.ParamByName('PID').AsString := value.FID;
  qryPesquisa.Open;

  if not qryPesquisa.IsEmpty then begin

      model := getModel(qryPesquisa);  end;


except
raise Exception.Create('Erro ao tentar obter ' + pTable );

end;

 Result := model;
end;

class function TCidadeDAO.Update(value: TCidadeModel): Boolean;
var
  qry: TFDQuery;
  cmdSql: string;

 sucesso :Boolean;
begin
 sucesso := False;

  dmConexao.conectarBanco;
  qry := TFDQuery.Create(nil);
  try
    try



     cmdSql := ' UPDATE CIDADE '+
               ' SET CODIGO = :PCODIGO,'+
               '     CIDADE = :PCIDADE,   '+
               '     ID_ESTADO = :PID_ESTADO '+
               ' WHERE (ID_CIDADE = :PID)' ;

        qry.Close;
        qry.Connection := dmConexao.conn;
        qry.SQL.Clear;
        qry.SQL.Add(cmdSql);
        qry.ParamByName('PID').AsString         := value.FID;
        qry.ParamByName('PID_ESTADO').AsString  := value.FIDestado;
        qry.ParamByName('PCIDADE').AsString     := value.Fcidade;
        qry.ParamByName('PCODIGO').AsInteger    := value.Fcodigo;

    qry.ExecSQL;

     if qry.RowsAffected >0 then begin

        sucesso := True;
     end;

    except
      Result := sucesso;
      raise Exception.Create('Erro ao tentar ALTERAR ' + pTable);
    end;
    Result := sucesso
  finally
    if Assigned(qry) then
    begin
      FreeAndNil(qry);
    end;
  end;
end;
end.
