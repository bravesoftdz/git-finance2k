unit MDDAO;

interface


uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, FireDAC.Stan.Intf, FireDAC.Stan.Option,
  FireDAC.Stan.Param, FireDAC.Stan.Error, FireDAC.DatS, FireDAC.Phys.Intf, FireDAC.DApt.Intf, FireDAC.Stan.Async,
  FireDAC.DApt, Data.DB,  udmConexao, uUtil, MDModel,uOrganizacaoDAO, uOrganizacaoModel,
  FireDAC.Comp.DataSet, FireDAC.Comp.Client;


  const
   pTable : string = 'MOVIMENTO_DIARIO';

type
 TMDDAO = class
  private
     class function getModel (query :TFDQuery) : TMDModel;
     class function obterCodigo: string;

  public
    class function registroMD(pOrg, pTable, pAcao, pDsc, pStatus: string): Boolean; overload;
    class function registroMD(value :TMDModel): Boolean; overload;


    class function Insert(value :TMDModel): Boolean;
    class function obterPorID(value :TMDModel): TMDModel;
    class function Delete(value :TMDModel): Boolean;

  end;

implementation

class function TMDDAO.obterCodigo: string;
var
qryPesquisa :TFDQuery;
cod, sqlEnd :string;
begin
dmConexao.conectarBanco;

   sqlEnd := ' SELECT  MAX ( CAST( C.CODIGO AS INTEGER) +1 ) AS CODIGO  FROM MOVIMENTO_DIARIO  C WHERE 1=1 ';

 try
     qryPesquisa := TFDQuery.Create(nil);
     qryPesquisa.Close;
     qryPesquisa.Connection := dmConexao.conn;
     qryPesquisa.SQL.Clear;
     qryPesquisa.SQL.Add(sqlEnd);
     qryPesquisa.Open;


      if uUtil.Empty(qryPesquisa.FieldByName('CODIGO').AsString) then begin
       cod := '1';
     end else begin cod := qryPesquisa.FieldByName('CODIGO').AsString; end;

 except

  raise Exception.Create('Erro ao obter c�digo ');

 end;

 Result := cod;

end;


class function TMDDAO.Delete(value: TMDModel): Boolean;
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
  qryDelete.SQL.Add('DELETE FROM MOVIMENTO_DIARIO   '  );
  qryDelete.SQL.Add('WHERE ID_ORGANIZACAO = :PIDORGANIZACAO  AND  ID_MOVIMENTO_DIARIO  = :PID '  );
  qryDelete.ParamByName('PIDORGANIZACAO').AsString := value.FIDorganizacao;
  qryDelete.ParamByName('PID').AsString := value.FID;

   qryDelete.ExecSQL;
  if qryDelete.RowsAffected >0 then begin sucesso := True; end;


 except
 sucesso := False;
 raise Exception.Create('Erro ao tentar DELETAR ' + pTable);

 end;

  Result := sucesso;
end;

class function TMDDAO.getModel(query: TFDQuery): TMDModel;
var model :TMDModel;

begin
  model     := TMDModel.Create;

  if not query.IsEmpty then begin

    try

      model.FID                     := query.FieldByName('ID_MOVIMENTO_DIARIO').AsString;
      model.FIDorganizacao          := query.FieldByName('ID_ORGANIZACAO').AsString;
      model.FDataRegistro           := query.FieldByName('DATA_REGISTRO').AsDateTime;
      model.FIDusuario              := query.FieldByName('ID_USUARIO').AsInteger;
      model.FnumeroMovimento        := query.FieldByName('NUMERO_MOVIMENTO').AsInteger;
      model.FvalorOperacao          := query.FieldByName('VALOR_OPERACAO').AsCurrency;
      model.Facao                   := query.FieldByName('ACAO').AsString;
      model.FipEstacao              := query.FieldByName('IP_ESTACAO').AsString;
      model.Fserver                 := query.FieldByName('NOME_SERVER').AsString;
      model.Festacao                := query.FieldByName('NOME_ESTACAO').AsString;
      model.Fstatus                 := query.FieldByName('STATUS').AsString;
      model.Fdescricao              := query.FieldByName('DESCRICAO').AsString;
      model.Fobjeto                 := query.FieldByName('OBJETO').AsString;
      model.Fcodigo                 := query.FieldByName('CODIGO').AsString;

      model.Fnovo                   :=False;

    except
      raise Exception.Create('Erro ao tentar Converter ' + pTable);

    end;

  end;


   Result := model;

end;

class function TMDDAO.Insert(value: TMDModel): Boolean;
var
  qry: TFDQuery;
  cmdSql: string;
  sucesso :Boolean;
begin
sucesso := False;
qry := TFDQuery.Create(nil);
  dmConexao.conectarBanco;

  try

     cmdSql := ' INSERT INTO MOVIMENTO_DIARIO '+
               ' (ID_MOVIMENTO_DIARIO, ID_ORGANIZACAO,ID_USUARIO,  ' +
               ' NUMERO_MOVIMENTO, DATA_REGISTRO, CODIGO, OBJETO, DESCRICAO, '+
               ' ACAO, VALOR_OPERACAO, STATUS, NOME_ESTACAO, '+
               ' NOME_SERVER, IP_ESTACAO, DATA_OPERACAO ) '+
               ' VALUES (:PID, :PIDORGANIZACAO, :PIDUSER, '+
               ' :PNUMERO_MOVIMENTO, :PDATA_REGISTRO, :PCODIGO, :POBJETO, :PDESCRICAO, '+
               ' :PACAO, :PVALOR_OPERACAO, :PSTATUS, :PNOME_ESTACAO, ' +
               ' :PNOME_SERVER, :PIP_ESTACAO, :PDATA_OPERACAO ) ' ;


          qry.Close;
          qry.Connection := dmConexao.conn;
          qry.SQL.Clear;
          qry.SQL.Add(cmdSql);

          qry.ParamByName('PID').AsString                 := value.FID;
          qry.ParamByName('PIDORGANIZACAO').AsString      := value.FIDorganizacao;
          qry.ParamByName('PIDUSER').AsInteger            := value.FIDusuario;
          qry.ParamByName('PNUMERO_MOVIMENTO').AsInteger  := (value.FnumeroMovimento);
          qry.ParamByName('PCODIGO').AsString             := value.Fcodigo;
          qry.ParamByName('POBJETO').AsString             := value.Fobjeto;
          qry.ParamByName('PDESCRICAO').AsString          := value.Fdescricao;
          qry.ParamByName('PACAO').AsString               := value.Facao;
          qry.ParamByName('PSTATUS').AsString             := value.Fstatus;
          qry.ParamByName('PNOME_ESTACAO').AsString       := value.Festacao;
          qry.ParamByName('PNOME_SERVER').AsString        := value.Fserver;
          qry.ParamByName('PIP_ESTACAO').AsString         := value.FipEstacao;
          qry.ParamByName('PVALOR_OPERACAO').AsCurrency   := value.FvalorOperacao;
          qry.ParamByName('PDATA_REGISTRO').AsDateTime    := Now;
          qry.ParamByName('PDATA_OPERACAO').AsDateTime    := Now;

          if value.FCodigo = EmptyStr then
          begin
            qry.ParamByName('PCODIGO').AsString := obterCodigo;
          end;


    qry.ExecSQL;
   if qry.RowsAffected >0 then begin sucesso := True; end;

  except
    Result := sucesso;
    raise Exception.Create('Erro ao tentar inserir ' + pTable);
  end;

  Result := System.True;
end;

class function TMDDAO.obterPorID( value: TMDModel): TMDModel;
var
qryPesquisa : TFDQuery;
cmdSql:string;
model: TMDModel;
begin

dmConexao.conectarBanco;
qryPesquisa := TFDQuery.Create(nil);
model := TMDModel.Create;
try

  qryPesquisa.Close;
  qryPesquisa.Connection := dmConexao.conn;
  qryPesquisa.SQL.Clear;
  qryPesquisa.SQL.Add('SELECT * '  );
  qryPesquisa.SQL.Add('FROM MOVIMENTO_DIARIO   '  );
  qryPesquisa.SQL.Add('WHERE ID_ORGANIZACAO = :PIDORGANIZACAO  AND ID_MOVIMENTO_DIARIO  = :PID '  );

  qryPesquisa.ParamByName('PIDORGANIZACAO').AsString := value.FIdOrganizacao;
  qryPesquisa.ParamByName('PID').AsString := value.FID;
  qryPesquisa.Open;

  if not qryPesquisa.IsEmpty then begin


      model := getModel(qryPesquisa);  end;


except
raise Exception.Create('Erro ao tentar obter ' + pTable );

end;

 Result := model;
end;

class function TMDDAO.registroMD(pOrg, pTable, pAcao, pDsc, pStatus: string): Boolean;
var
org : TOrganizacaoModel;
md :TMDModel;
begin
  org := TOrganizacaoModel.Create;
  org.FID := pOrg;
  org :=  TOrganizacaoDAO.obterPorID(org);

   md                   := TMDModel.Create;
   md.FID               := dmConexao.obterNewID;
   md.FIDorganizacao    := org.FID;
   md.FIDusuario        := uutil.TUserAtual.userID;
   md.FdataRegistro     := Now;
   md.FvalorOperacao    := 0;
   md.Fcodigo           := '0';
   md.Facao             := pAcao;
   md.Fobjeto           := pTable;
   md.Fdescricao        := pDsc;
   md.Fstatus           := pStatus;
   md.Festacao          := uutil.GetComputerNetName;
   md.FipEstacao        := uUtil.GetIp;
   md.Fserver           := org.FNAMESERVERBD  + ' IP ' + org.FIPSERVERBD;

  if not uUtil.Empty(org.FID) then begin
   md.FnumeroMovimento  := StrToInt(dmConexao.obterIdentificador('',md.FIDorganizacao,'MD'));
   Insert(md);
  end;

end;

class function TMDDAO.registroMD(value :TMDModel): Boolean;
var
org : TOrganizacaoModel;
md :TMDModel;
begin
  org := TOrganizacaoModel.Create;
  org.FID := value.FIDorganizacao;
  org :=  TOrganizacaoDAO.obterPorID(org);
   md                   := TMDModel.Create;
   md.FID               := dmConexao.obterNewID;
   md.FIDorganizacao    := org.FID;
   md.FIDusuario        := uutil.TUserAtual.userID;
   md.FdataRegistro     := Now;
   md.FvalorOperacao    := 0;
   md.Fcodigo           := '0';
   md.Facao             := value.Facao;
   md.Fobjeto           := value.Fobjeto;
   md.Fdescricao        := value.Fdescricao;
   md.Fstatus           := value.Fstatus;
   md.Festacao          := uutil.GetComputerNetName;
   md.FipEstacao        := uUtil.GetIp;
   md.Fserver           := org.FNAMESERVERBD  + ' IP ' + org.FIPSERVERBD;

  if not uUtil.Empty(org.FID) then begin
   md.FnumeroMovimento  := StrToInt(dmConexao.obterIdentificador('',md.FIDorganizacao,'MD'));
   Insert(md);
  end;

end;

end.
