unit uCedenteDAO;

interface


uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, FireDAC.Stan.Intf, FireDAC.Stan.Option, uCedenteModel,
  FireDAC.Stan.Param, FireDAC.Stan.Error, FireDAC.DatS, FireDAC.Phys.Intf,uContaContabilModel,uContaContabilDAO,
  FireDAC.DApt.Intf, FireDAC.Stan.Async, FireDAC.DApt, Data.DB,  udmConexao, uUtil, uCartaoCreditoModel, uCartaoCreditoDAO,
  FireDAC.Comp.DataSet, FireDAC.Comp.Client,   uTipoCedenteModel, uTipoCedenteDAO;


  const
   pTable : string = 'CEDENTE';



type
 TCedenteDAO = class
  private
    //class function ComandoSql(AReceber: TReceber): Boolean;

    class function getModel (query :TFDQuery) : TCedenteModel;
     class function obterCodigo: string;
  public
    {m�todos CRUD (Create, Read, Update e Delete)
    para manipula��o dos dados}
   class function Insert(value :TCedenteModel): Boolean;
    class function obterPorID(value :TCedenteModel): TCedenteModel;
    class function Update(value :TCedenteModel): Boolean;
    class function Delete(value :TCedenteModel): Boolean;

  end;

implementation

class function TCedenteDAO.obterCodigo: string;
var
qryPesquisa :TFDQuery;
cod, sqlEnd :string;
begin
dmConexao.conectarBanco;

   sqlEnd := ' SELECT  MAX ( CAST( C.CODIGO AS INTEGER) +1 ) AS CODIGO  FROM CEDENTE C WHERE 1=1 ';

 try
     qryPesquisa := TFDQuery.Create(nil);
     qryPesquisa.Close;
     qryPesquisa.Connection := dmConexao.conn;
     qryPesquisa.SQL.Clear;
     qryPesquisa.SQL.Add(sqlEnd);
     qryPesquisa.Open;


      if uUtil.Empty(qryPesquisa.FieldByName('CODIGO').AsString) then begin

       cod := '2000';

     end else begin cod := qryPesquisa.FieldByName('CODIGO').AsString; end;



 except

  raise Exception.Create('Erro ao obter c�digo ');

 end;

 Result := cod;

end;


class function TCedenteDAO.Delete(value: TCedenteModel): Boolean;
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
  qryDelete.SQL.Add('DELETE FROM CEDENTE  '  );
  qryDelete.SQL.Add('WHERE ID_ORGANIZACAO = :PIDORGANIZACAO  AND  ID_CEDENTE = :PID '  );
  qryDelete.ParamByName('PIDORGANIZACAO').AsString := value.FIDorganizacao;
  qryDelete.ParamByName('PID').AsString := value.FID;

  qryDelete.ExecSQL;
  xResp := True;


 except
 xResp := False;
 raise Exception.Create('Erro ao tentar DELETAR ' + pTable);

 end;

  Result := xResp;
end;

class function TCedenteDAO.getModel(query: TFDQuery): TCedenteModel;
var model :TCedenteModel;
 contaCtb : TContaContabilModel;
  cartao :TCartaoCreditoModel;
 tipoCedente : TTipoCedenteModel;
begin
  model     := TCedenteModel.Create;
  contaCtb  := TContaContabilModel.Create;
  cartao    := TCartaoCreditoModel.Create;
  tipoCedente := TTipoCedenteModel.Create;

  if not query.IsEmpty then begin

    try

      model.FID                     := query.FieldByName('ID_CEDENTE').AsString;
      model.FIDorganizacao          := query.FieldByName('ID_ORGANIZACAO').AsString;
      model.FIDtipoCedente          := query.FieldByName('ID_TIPO_CEDENTE').AsString;
      model.FIDendereco             := query.FieldByName('ID_ENDERECO').AsString;
      model.FIdContaContabil        := query.FieldByName('ID_CONTA_CONTABIL').AsString;
      model.FIDcontato              := query.FieldByName('ID_CONTATO').AsString;
      model.FIDbanco                := query.FieldByName('ID_BANCO').AsString;
      model.Fagencia                := query.FieldByName('AGENCIA').AsString;
      model.Fconta                  := query.FieldByName('CONTA_BANCARIA').AsString;
      model.FCodigo                 := query.FieldByName('CODIGO').AsString;
      model.Fpersonalidade          := query.FieldByName('PERSONALIDADE').AsString;
      model.FStatus                 := query.FieldByName('STATUS').AsString;
      model.FcpfCnpj                := query.FieldByName('CPFCNPJ').AsString;
      model.Fnome                   := query.FieldByName('NOME').AsString;
      model.FinscricaoMunicipal     := query.FieldByName('INSCRICAO_MUNICIPAL').AsString;
      model.FinscricaoEstadual      := query.FieldByName('INSCRICAO_ESTADUAL').AsString;
      model.FDataUltimaAtualizacao  := query.FieldByName('DATA_ULTIMA_ATUALIZACAO').AsDateTime;
      model.FDataRegistro           := query.FieldByName('DATA_REGISTRO').AsDateTime;
      model.FIDcartaoCreditoModel   := query.FieldByName('ID_CARTAO_CREDITO').AsString;
      model.Fnovo                   :=False;

          try

            contaCtb.FID            := model.FIDcontaContabil;
            contaCtb.FIDorganizacao := model.FIDorganizacao;
            model.FcontaContabil    := TContaContabilDAO.obterPorID(contaCtb);

            tipoCedente.FID         := model.FIDtipoCedente;
            tipoCedente.FIDOrganizacao := model.FIDorganizacao;
            model.FtipoCedente := TTipoCedenteDAO.obterPorID(tipoCedente);

            //cartao de credito vinculado ao cedente
            cartao.FID := model.FIDcartaoCreditoModel;
            cartao.FIDorganizacao := model.FIDorganizacao;
            model.FcartaoCredito := TCartaoCreditoDAO.obterPorID(cartao);


          except
            raise Exception.Create('Erro ao tentar obter Conta Contabil por ' + pTable);

          end;

    except
      raise Exception.Create('Erro ao tentar Converter ' + pTable);

    end;

  end;


   Result := model;

end;

class function TCedenteDAO.Insert(value: TCedenteModel): Boolean;
var
  qry: TFDQuery;
  cmdSql: string;
begin
  dmConexao.conectarBanco;
  try

     cmdSql := ' INSERT  INTO CEDENTE (ID_CEDENTE, ID_ORGANIZACAO, ID_BANCO, ' +
                    ' ID_TIPO_CEDENTE, ID_ENDERECO, ID_CONTATO, ID_CONTA_CONTABIL, ID_CARTAO_CREDITO, '+
                    ' NOME, CPFCNPJ, PERSONALIDADE, AGENCIA, CONTA_BANCARIA,CODIGO, STATUS, '+
                    ' CGA, INSCRICAO_ESTADUAL, INSCRICAO_MUNICIPAL, DATA_REGISTRO, DATA_ULTIMA_ATUALIZACAO ) '+
                    ' VALUES (:PID, :PIDORGANIZACAO, :PIDBANCO, '+
                    '         :PIDTIPO, :PIDENDERECO, :PIDCONTATO, :PIDCONTACTB, :PIDCARTAO, '+
                    '         :PNOME, :PCNPJ, :PPERSONALIDADE, :PAGENCIA, :PCONTA, :PCODIGO, :PSTATUS, '+
                    '         :PCGA, :PINSCEST, :PINSCMUN, :PDATAREGISTRO, :PDATA ) ' ;


          qry := TFDQuery.Create(nil);
          qry.Close;
          qry.Connection := dmConexao.conn;
          qry.SQL.Clear;
          qry.SQL.Add(cmdSql);




          qry.ParamByName('PID').AsString               := value.FID;
          qry.ParamByName('PIDORGANIZACAO').AsString    := value.FIDorganizacao;

          qry.ParamByName('PIDBANCO').AsString          := value.FIDbanco;
          qry.ParamByName('PIDTIPO').AsString           := value.FIDtipoCedente;
          qry.ParamByName('PIDENDERECO').AsString       := value.FIDendereco;
          qry.ParamByName('PIDCONTATO').AsString        := value.FIDcontato;
          qry.ParamByName('PIDCONTACTB').AsString       := value.FIDcontaContabil;
          qry.ParamByName('PIDCARTAO').AsString         := value.FIDcartaoCreditoModel;

          qry.ParamByName('PNOME').AsString             := UpperCase(value.Fnome);
          qry.ParamByName('PCNPJ').AsString             := value.FcpfCnpj;
          qry.ParamByName('PPERSONALIDADE').AsString    := value.Fpersonalidade;
          qry.ParamByName('PAGENCIA').AsString          := value.Fagencia;
          qry.ParamByName('PCONTA').AsString            := value.Fconta;
          qry.ParamByName('PCODIGO').AsString           := value.FCodigo;
          qry.ParamByName('PSTATUS').AsString           := value.FStatus;
          qry.ParamByName('PCGA').AsString              := value.Fcga;
          qry.ParamByName('PINSCEST').AsString          := value.FinscricaoEstadual;
          qry.ParamByName('PINSCMUN').AsString          := value.FinscricaoMunicipal;
          qry.ParamByName('PDATAREGISTRO').AsDate       := value.FDataRegistro;
          qry.ParamByName('PDATA').AsDate               := Now;

          if value.FIDcartaoCreditoModel = EmptyStr then
          begin
            qry.ParamByName('PIDCARTAO').Value := null;
          end;
          if value.FIDbanco = EmptyStr then
          begin
            qry.ParamByName('PIDBANCO').Value := null;
          end;
          if value.FIDendereco = EmptyStr then
          begin
            qry.ParamByName('PIDENDERECO').Value := null;
          end;
          if value.FIDcontato = EmptyStr then
          begin
            qry.ParamByName('PIDCONTATO').Value := null;
          end;
          if value.FIDcontaContabil = EmptyStr then
          begin
            qry.ParamByName('PIDCONTACTB').Value := null;
          end;

          if value.FCodigo = EmptyStr then
          begin
            qry.ParamByName('PCODIGO').AsString := obterCodigo;
          end;


    qry.ExecSQL;


  except
    Result := False;
    raise Exception.Create('Erro ao tentar inserir ' + pTable);
  end;

  Result := System.True;
end;

class function TCedenteDAO.obterPorID( value: TCedenteModel): TCedenteModel;
var
qryPesquisa : TFDQuery;
cmdSql:string;
model: TCedenteModel;
begin

dmConexao.conectarBanco;
qryPesquisa := TFDQuery.Create(nil);
model := TCedenteModel.Create;
try

  qryPesquisa.Close;
  qryPesquisa.Connection := dmConexao.conn;
  qryPesquisa.SQL.Clear;
  qryPesquisa.SQL.Add('SELECT * '  );
  qryPesquisa.SQL.Add('FROM CEDENTE  '  );
  qryPesquisa.SQL.Add('WHERE ID_ORGANIZACAO = :PIDORGANIZACAO  AND ID_CEDENTE = :PID '  );

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

class function TCedenteDAO.Update(value: TCedenteModel): Boolean;
var
  qry: TFDQuery;
  cmdSql: string;
begin

  dmConexao.conectarBanco;
  try

     cmdSql :=     ' UPDATE CEDENTE '  +
                          ' SET ID_TIPO_CEDENTE =     :PIDTIPO, '+
                          '     ID_ENDERECO =         :PIDENDERECO,'+
                          '     ID_CONTATO =          :PIDCONTATO,'+
                          '     NOME =                :PNOME,'+
                          '     CPFCNPJ =             :PCNPJ,'+
                          '     PERSONALIDADE =       :PPERSONALIDADE,'+
                          '     CONTA_BANCARIA =      :PCONTA, '+
                          '     AGENCIA =             :PAGENCIA,'+
                          '     ID_BANCO =            :PIDBANCO,'+
                          '     CGA =                 :PCGA,'+
                          '     INSCRICAO_ESTADUAL  = :PINSCEST,'+
                          '     ID_CONTA_CONTABIL   = :PIDCONTACTB,'+
                          '     INSCRICAO_MUNICIPAL = :PINSCMUN, '+
                          '     ID_CARTAO_CREDITO   = :PIDCARTAO,'+
                          '     STATUS              = :PSTATUS, '+
                          '     DATA_ULTIMA_ATUALIZACAO = :PDATA,'+
                          '     CODIGO              = :PCODIGO '+
                          '     WHERE (ID_CEDENTE = :PID) AND (ID_ORGANIZACAO = :PIDORGANIZACAO) ';


          qry := TFDQuery.Create(nil);
          qry.Close;
          qry.Connection := dmConexao.conn;
          qry.SQL.Clear;
          qry.SQL.Add(cmdSql);


          qry.ParamByName('PID').AsString               := value.FID;
          qry.ParamByName('PIDORGANIZACAO').AsString    := value.FIDorganizacao;

          qry.ParamByName('PIDBANCO').AsString          := value.FIDbanco;
          qry.ParamByName('PIDTIPO').AsString           := value.FIDtipoCedente;
          qry.ParamByName('PIDENDERECO').AsString       := value.FIDendereco;
          qry.ParamByName('PIDCONTATO').AsString        := value.FIDcontato;
          qry.ParamByName('PIDCONTACTB').AsString       := value.FIDcontaContabil;
          qry.ParamByName('PIDCARTAO').AsString         := value.FIDcartaoCreditoModel;

          qry.ParamByName('PNOME').AsString             := UpperCase(value.Fnome);
          qry.ParamByName('PCNPJ').AsString             := value.FcpfCnpj;
          qry.ParamByName('PPERSONALIDADE').AsString    := value.Fpersonalidade;
          qry.ParamByName('PAGENCIA').AsString          := value.Fagencia;
          qry.ParamByName('PCONTA').AsString            := value.Fconta;
          qry.ParamByName('PCODIGO').AsString           := value.FCodigo;
          qry.ParamByName('PSTATUS').AsString           := value.FStatus;
          qry.ParamByName('PCGA').AsString              := value.Fcga;
          qry.ParamByName('PINSCEST').AsString          := value.FinscricaoEstadual;
          qry.ParamByName('PINSCMUN').AsString          := value.FinscricaoMunicipal;
          qry.ParamByName('PDATA').AsDate               := Now;

          if value.FIDcartaoCreditoModel = EmptyStr then
          begin
            qry.ParamByName('PIDCARTAO').Value := null;
          end;
          if value.FIDbanco = EmptyStr then
          begin
            qry.ParamByName('PIDBANCO').Value := null;
          end;
          if value.FIDendereco = EmptyStr then
          begin
            qry.ParamByName('PIDENDERECO').Value := null;
          end;
          if value.FIDcontato = EmptyStr then
          begin
            qry.ParamByName('PIDCONTATO').Value := null;
          end;
          if value.FIDcontaContabil = EmptyStr then
          begin
            qry.ParamByName('PIDCONTACTB').Value := null;
          end;

          if value.FCodigo = EmptyStr then
          begin
            qry.ParamByName('PCODIGO').AsString := obterCodigo;
          end;

    qry.ExecSQL;

  except
    Result := False;
    raise Exception.Create('Erro ao tentar alterar ' + pTable);
  end;

  Result := System.True;
end;
end.
