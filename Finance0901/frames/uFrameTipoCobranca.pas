unit uFrameTipoCobranca;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, udmConexao, uUtil,
  Vcl.Graphics, Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls,
  FireDAC.Stan.Intf, FireDAC.Stan.Option, FireDAC.Stan.Param, uTipoCobrancaModel,
  FireDAC.Stan.Error, FireDAC.DatS, FireDAC.Phys.Intf, FireDAC.DApt.Intf,
  FireDAC.Stan.Async, FireDAC.DApt, Data.DB, FireDAC.Comp.DataSet,
  FireDAC.Comp.Client;

type
  TfrmTipoCobranca = class(TFrame)
    cbbTipoCobranca: TComboBox;
  private
    { Private declarations }
    pIdOrganizacao : string;
    FsListaIdBanco : TStringList;

  public
    { Public declarations }

    function obterLista(pIdOrganizacao: string): TFDQuery;
    function obterPorID(pTipo :TTipoCobrancaModel): TTipoCobrancaModel;
    function obterTodos(pIdOrganizacao: string; var combo: TComboBox; var listaID: TStringList): boolean;
    procedure limpaFrame;
  end;

implementation

{$R *.dfm}



function TfrmTipoCobranca.obterLista(pIdOrganizacao: string): TFDQuery;
var
 lista :TFDQuery;
cmd :string;
begin
  dmConexao.conectarBanco;
  try
    cmd :=  ' SELECT E.ID_TIPO_COBRANCA, E.ID_ORGANIZACAO,E.DESCRICAO ' +
            ' FROM TIPO_COBRANCA E  ' +
            ' WHERE (E.ID_ORGANIZACAO = :PIDORGANIZACAO) ' +
            '  ORDER BY E.DESCRICAO ';

   lista := TFDQuery.Create(Self);
   lista.Close;
   lista.Connection := dmConexao.conn;
   lista.SQL.Clear;
   lista.SQL.Add(cmd);
   lista.ParamByName('PIDORGANIZACAO').AsString := pIdOrganizacao;
   lista.Open;
   lista.Last;

  except
  raise Exception.Create('Erro ao obter lista de TIPO COBRAN�A');

  end;

  Result := lista;

end;


function TfrmTipoCobranca.obterPorID(pTipo :TTipoCobrancaModel): TTipoCobrancaModel;
var
  qryObter: TFDQuery;
  cmd: string;
  tipo: TTipoCobrancaModel;
begin
  tipo := TTipoCobrancaModel.Create;
  dmConexao.conectarBanco;
  try
    cmd := ' SELECT TC.ID_TIPO_COBRANCA, TC.ID_ORGANIZACAO, TC.DESCRICAO FROM TIPO_COBRANCA TC WHERE (TC.ID_ORGANIZACAO = :PIDORGANIZACAO) AND  (TC.ID_TIPO_COBRANCA = :PID) ';

    qryObter := TFDQuery.Create(Self);
    qryObter.Close;
    qryObter.Connection := dmConexao.conn;
    qryObter.SQL.Clear;
    qryObter.SQL.Add(cmd);
    qryObter.ParamByName('PIDORGANIZACAO').AsString := pTipo.FIDorganizacao;
    qryObter.ParamByName('PID').AsString := pTipo.FID;
    qryObter.Open;

    if not qryObter.IsEmpty then
    begin

      tipo.FID            := qryObter.FieldByName('ID_TIPO_COBRANCA').AsString;
      tipo.FIDorganizacao := qryObter.FieldByName('ID_ORGANIZACAO').AsString;
      tipo.FDescricao     := qryObter.FieldByName('DESCRICAO').AsString;

    end;

  except
    raise Exception.Create('Erro ao obter TIPO COB por ID');

  end;

  Result := tipo;

end;

function TfrmTipoCobranca.obterTodos(pIdOrganizacao: string; var combo: TComboBox; var listaID: TStringList): boolean;
var
qryObterTodos :TFDQuery;
 cmd :string;
begin

   cmd := ' SELECT E.ID_TIPO_COBRANCA,' +
          ' E.DESCRICAO ' +
          ' FROM TIPO_COBRANCA E  ' +
          ' WHERE (E.ID_ORGANIZACAO = :PIDORGANIZACAO) ' +
          ' ORDER BY E.DESCRICAO ';


  dmConexao.conectarBanco;
  pIdOrganizacao := uUtil.TOrgAtual.getId;

  listaID := TStringList.Create;
  listaID.Clear;
  listaID.Add('Sem ID');
   combo.Clear;
   combo.Items.Add('<<< Selecione um TIPO  >>>');

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
          combo.Items.Add(qryObterTodos.FieldByName('DESCRICAO').AsString);
          listaID.Add(qryObterTodos.FieldByName('ID_TIPO_COBRANCA').AsString);
          qryObterTodos.Next;
        end;
      qryObterTodos.Close;
      combo.ItemIndex := 0;

   end;

end;



procedure TfrmTipoCobranca.limpaFrame;
var
i :Integer;
begin

// limpa os componentes da aba q chegou

  for i := 0 to Self.ComponentCount - 1 do
  begin
    if Components[i] is TCustomEdit then
    begin
         (Components[i] as TCustomEdit).Clear;
    end;

    if Components[i] is TEdit then
    begin

         TEdit(Components[i]).Clear;
    end;

     if Components[i] is TComboBox then
    begin

     // TComboBox(Components[i]).Clear;
      TComboBox(Components[i]).ItemIndex := 0;
    end;

   end;
end;


end.
