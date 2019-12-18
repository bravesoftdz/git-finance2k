unit uFrameContaContabil;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes,
  uContaContabilModel, udmConexao, uUtil,
  Vcl.Graphics, Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls,
  FireDAC.Stan.Intf, FireDAC.Stan.Option, FireDAC.Stan.Param,
  FireDAC.Stan.Error, FireDAC.DatS, FireDAC.Phys.Intf, FireDAC.DApt.Intf,
  FireDAC.Stan.Async, FireDAC.DApt, Data.DB, FireDAC.Comp.DataSet,
  FireDAC.Comp.Client;

type
  TfrmContaContabil = class(TFrame)
    cbbContaContabil: TComboBox;
    lbl1: TLabel;
  private
    { Private declarations }
    pIdOrganizacao : string;
    FsListaIdCC : TStringList;

  public
    { Public declarations }

function obterTodos(pIdOrganizacao: string; var combo: TComboBox; var listaID: TStringList): boolean;
function obterLista(pIdOrganizacao: string): TFDQuery;

function obterPorCodigo(pIdOrganizacao, pCodigoReduzido: string ) : TContaContabilModel;
function obterPorID (pIdOrganizacao, pIdConta: string ) : TContaContabilModel;

  end;

implementation

{$R *.dfm}

function TfrmContaContabil.obterLista(pIdOrganizacao: string): TFDQuery;
var
lista :TFDQuery;
cmd :string;
begin

  dmConexao.conectarBanco;
  try
    cmd := ' SELECT CC.ID_CONTA_CONTABIL   ' +
           ' CC.ID_ORGANIZACAO ' +
           ' CC.DESCRICAO      ' +
           ' CC.CONTA          ' +
           ' CC.DGVER          ' +
           ' CC.CODREDUZ       ' +
           ' CC.DGREDUZ        ' +
           ' CC.INSCMF         ' +
           ' CC.TIPO           ' +
           ' CC.GRAU           ' +
           ' CC.ORDEM_DIPJ     ' +
           ' CC.RELACIONAMENTO ' +
           ' CC.NATUREZA       ' +
           ' CC.DATA_REGISTRO  ' +
           ' FROM CONTA_CONTABIL CC ' +
           ' WHERE ( CC.ID_ORGANIZACAO = :PIDORGANIZACAO )';

   lista := TFDQuery.Create(Self);
   lista.Close;
   lista.Connection := dmConexao.conn;
   lista.SQL.Clear;
   lista.SQL.Add(cmd);
   lista.ParamByName('PIDORGANIZACAO').AsString := pIdOrganizacao;
   lista.Open;
   lista.Last;

  except
  raise Exception.Create('Erro ao obter lista de contas');

  end;

  Result := lista;

end;

function TfrmContaContabil.obterPorCodigo(pIdOrganizacao,  pCodigoReduzido: string): TContaContabilModel;
var
conta :TContaContabilModel;
qryObter :TFDQuery;
cmd :string;
begin

  dmConexao.conectarBanco;
  try
     cmd := ' SELECT CC.ID_CONTA_CONTABIL,   ' +
           ' CC.ID_ORGANIZACAO, ' +
           ' CC.DESCRICAO,      ' +
           ' CC.CONTA ,         ' +
           ' CC.DGVER,          ' +
           ' CC.CODREDUZ,       ' +
           ' CC.DGREDUZ ,       ' +
           ' CC.INSCMF ,        ' +
           ' CC.TIPO  ,         ' +
           ' CC.GRAU  ,         ' +
           ' CC.ORDEM_DIPJ,     ' +
           ' CC.RELACIONAMENTO, ' +
           ' CC.NATUREZA   ,    ' +
           ' CC.DATA_REGISTRO  ' +
           ' FROM CONTA_CONTABIL CC ' +
           ' WHERE ( CC.ID_ORGANIZACAO = :PIDORGANIZACAO ) AND (CC.CODREDUZ = :PCODIGO)';

   qryObter := TFDQuery.Create(Self);
   qryObter.Close;
   qryObter.Connection := dmConexao.conn;
   qryObter.SQL.Clear;
   qryObter.SQL.Add(cmd);
   qryObter.ParamByName('PIDORGANIZACAO').AsString := pIdOrganizacao;
   qryObter.ParamByName('PCODIGO').AsString := pCodigoReduzido;
   qryObter.Open;

   if not qryObter.IsEmpty then begin

        conta :=TContaContabilModel.Create;
        conta.SetFCodigoReduzido(qryObter.FieldByName('CODREDUZ').AsString);
        conta.SetFConta(qryObter.FieldByName('CONTA').AsString);
        conta.SetFDescricao(qryObter.FieldByName('DESCRICAO').AsString);
        conta.SetFDgReduz(qryObter.FieldByName('DGREDUZ').AsString);
        conta.SetFDgVer(qryObter.FieldByName('DGVER').AsString);
        conta.SetFIdContaContabil(qryObter.FieldByName('ID_CONTA_CONTABIL').AsString);
        conta.SetFIdOrganizacao(qryObter.FieldByName('ID_ORGANIZACAO').AsString);
        //talvez precise completar os outros campos

   end;



  except
  raise Exception.Create('Erro ao obter CC por Codigo');

  end;

  Result := conta;
end;

function TfrmContaContabil.obterPorID(pIdOrganizacao,  pIdConta: string): TContaContabilModel;
var
conta :TContaContabilModel;
qryObter :TFDQuery;
cmd :string;
begin

  dmConexao.conectarBanco;
  try
    cmd := ' SELECT CC.ID_CONTA_CONTABIL,   ' +
           ' CC.ID_ORGANIZACAO, ' +
           ' CC.DESCRICAO,      ' +
           ' CC.CONTA ,         ' +
           ' CC.DGVER,          ' +
           ' CC.CODREDUZ,       ' +
           ' CC.DGREDUZ ,       ' +
           ' CC.INSCMF ,        ' +
           ' CC.TIPO  ,         ' +
           ' CC.GRAU  ,         ' +
           ' CC.ORDEM_DIPJ,     ' +
           ' CC.RELACIONAMENTO, ' +
           ' CC.NATUREZA   ,    ' +
           ' CC.DATA_REGISTRO  ' +
           ' FROM CONTA_CONTABIL CC ' +
           ' WHERE ( CC.ID_ORGANIZACAO = :PIDORGANIZACAO ) AND (CC.ID_CONTA_CONTABIL = :PID)';

   qryObter := TFDQuery.Create(Self);
   qryObter.Close;
   qryObter.Connection := dmConexao.conn;
   qryObter.SQL.Clear;
   qryObter.SQL.Add(cmd);
   qryObter.ParamByName('PIDORGANIZACAO').AsString := pIdOrganizacao;
   qryObter.ParamByName('PID').AsString := pIdConta;
   qryObter.Open;

   if not qryObter.IsEmpty then begin

        conta :=TContaContabilModel.Create;
        conta.SetFCodigoReduzido(qryObter.FieldByName('CODREDUZ').AsString);
        conta.SetFConta(qryObter.FieldByName('CONTA').AsString);
        conta.SetFDescricao(qryObter.FieldByName('DESCRICAO').AsString);
        conta.SetFDgReduz(qryObter.FieldByName('DGREDUZ').AsString);
        conta.SetFDgVer(qryObter.FieldByName('DGVER').AsString);
        conta.SetFIdContaContabil(qryObter.FieldByName('ID_CONTA_CONTABIL').AsString);
        conta.SetFIdOrganizacao(qryObter.FieldByName('ID_ORGANIZACAO').AsString);
        //talvez precise completar os outros campos

   end;

    qryObter.Close;

  except
  raise Exception.Create('Erro ao obter CC por ID');

  end;


  Result := conta;

end;

function TfrmContaContabil.obterTodos(pIdOrganizacao: string; var combo: TComboBox; var listaID: TStringList): boolean;
var
qryObterTodos :TFDQuery;
 cmd :string;
begin

   cmd := ' SELECT (CC.DESCRICAO ||'' - '' ||  CC.CODREDUZ ) AS DSC, CC.ID_CONTA_CONTABIL '+
          ' FROM CONTA_CONTABIL CC WHERE (CC.ID_ORGANIZACAO = :PIDORGANIZACAO)';


  dmConexao.conectarBanco;
  pIdOrganizacao := uUtil.TOrgAtual.getId;

  listaID := TStringList.Create;
  listaID.Clear;
  listaID.Add('Sem ID');
   combo.Clear;
   combo.Items.Add('<<< Selecione uma Conta  >>>');

   qryObterTodos := TFDQuery.Create(Self);
   qryObterTodos.Close;
   qryObterTodos.Connection := dmConexao.conn;
   qryObterTodos.SQL.Clear;
   qryObterTodos.SQL.Add(cmd);

   qryObterTodos.ParamByName('PIDORGANIZACAO').AsString := pIdOrganizacao;
   qryObterTodos.Open;

   if not qryObterTodos.IsEmpty then begin
          qryObterTodos.First;

      while not qryObterTodos.Eof do
        begin
          combo.Items.Add(qryObterTodos.FieldByName('DSC').AsString);
          listaID.Add(qryObterTodos.FieldByName('ID_CONTA_CONTABIL').AsString);
          qryObterTodos.Next;
        end;
      qryObterTodos.Close;
      combo.ItemIndex := 0;

   end;

end;


end.
