unit uTPBaixaDAO;


interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, FireDAC.Stan.Intf, FireDAC.Stan.Option,
  FireDAC.Stan.Param, FireDAC.Stan.Error, FireDAC.DatS, FireDAC.Phys.Intf,  uTPBaixaModel,
  FireDAC.DApt.Intf, FireDAC.Stan.Async, FireDAC.DApt, Data.DB, uTituloPagarModel, udmConexao, uUtil,
  FireDAC.Comp.DataSet, FireDAC.Comp.Client;

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
//    class function Update(value :TTPBaixaModel): Boolean; //n�o permite alterar

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
  qryDelete.SQL.Add('DELETE FROM TITULO_PAGAR_BAIXA  '  );
  qryDelete.SQL.Add('WHERE ID_ORGANIZACAO = :PIDORGANIZACAO  AND  ID_TITULO_PAGAR_BAIXA = :PID '  );
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
try

 cmdSql := ' INSERT INTO TITULO_PAGAR_BAIXA '+
           ' (ID_TITULO_PAGAR_BAIXA, ID_ORGANIZACAO, ID_TITULO_PAGAR,'+
           ' ID_CENTRO_CUSTO, ID_LOTE_CONTABIL, ID_USUARIO, ID_RESPONSAVEL, '+
           ' VALOR_PAGO, DATA_REGISTRO, TIPO_BAIXA, ID_LOTE_PAGAMENTO ) ' +
           ' VALUES (:PID,:PIDORGANIZACAO,:PIDTITULO_PAGAR, '+
           ' :PIDCENTRO_CUSTO, :PIDLOTE_CONTABIL, :PIDUSUARIO, :PIDRESPONSAVEL, '+
           ' :PVALOR_PAGO,:PDATA_REGISTRO, :PTIPO_BAIXA,:PIDLOTE_PAGAMENTO )';

    qryInsert := TFDQuery.Create(nil);
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

    qryInsert.ExecSQL;


except
Result :=False;

raise Exception.Create('Erro ao tentar inserir TITULO Pago');

end;

 Result := System.True;
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
      tpb                         := TTPBaixaModel.Create;
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

  end;

 except
 raise Exception.Create('Erro ao tentar converter o tpb em DAO. Informe erro ao suporte. ');
 end;

  Result := tpb;

end;



end.