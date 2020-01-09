unit uFrameBanco;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, udmConexao, uUtil,
  Vcl.Graphics, Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls,
  FireDAC.Stan.Intf, FireDAC.Stan.Option, FireDAC.Stan.Param,
  FireDAC.Stan.Error, FireDAC.DatS, FireDAC.Phys.Intf, FireDAC.DApt.Intf,
  FireDAC.Stan.Async, FireDAC.DApt, Data.DB, FireDAC.Comp.DataSet,
  FireDAC.Comp.Client;

type
  TfrmBanco = class(TFrame)
    cbbBanco: TComboBox;
  private
    { Private declarations }
    pIdOrganizacao : string;
    FsListaIdBanco : TStringList;

  public
    { Public declarations }

    function obterLista(pIdOrganizacao: string): TFDQuery;
    function obterPorID(pIdOrganizacao, pIdBanco: string): TFDQuery;
    function obterTodos(pIdOrganizacao: string; var combo: TComboBox; var listaID: TStringList): boolean;
    procedure limpaFrame;
  end;

implementation

{$R *.dfm}



function TfrmBanco.obterLista(pIdOrganizacao: string): TFDQuery;
var
 lista :TFDQuery;
cmd :string;
begin

  dmConexao.conectarBanco;
  try
    cmd := ' SELECT  B.ID_BANCO, B.CODIGO_BANCO, B.NOME_BANCO, B.SIGLA_BANCO, B.ID_ORGANIZACAO '+
           ' FROM BANCO B  WHERE ( B.ID_ORGANIZACAO = :PIDORGANIZACAO ) ORDER BY B.NOME_BANCO';

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


function TfrmBanco.obterPorID(pIdOrganizacao,  pIdBanco: string): TFDQuery;
var
qryObter :TFDQuery;
cmd :string;
begin

  dmConexao.conectarBanco;
  try


    cmd := ' SELECT B.ID_BANCO,   ' +
           ' B.ID_ORGANIZACAO, ' +
           ' B.CODIGO_BANCO,      ' +
           ' B.NOME_BANCO ,         ' +
           ' B.SIGLA_BANCO          ' +
           ' FROM BANCO B ' +
           ' WHERE ( B.ID_ORGANIZACAO = :PIDORGANIZACAO ) AND (B.ID_BANCO = :PID)';

   qryObter := TFDQuery.Create(Self);
   qryObter.Close;
   qryObter.Connection := dmConexao.conn;
   qryObter.SQL.Clear;
   qryObter.SQL.Add(cmd);
   qryObter.ParamByName('PIDORGANIZACAO').AsString := pIdOrganizacao;
   qryObter.ParamByName('PID').AsString := pIdBanco;
   qryObter.Open;

  except
  raise Exception.Create('Erro ao obter BANCO por ID');

  end;


  Result := qryObter;

end;

function TfrmBanco.obterTodos(pIdOrganizacao: string; var combo: TComboBox; var listaID: TStringList): boolean;
var
qryObterTodos :TFDQuery;
 cmd :string;
begin

   cmd := ' SELECT (B.NOME_BANCO) AS DSC, B.ID_BANCO '+
          ' FROM BANCO B WHERE (B.ID_ORGANIZACAO = :PIDORGANIZACAO)';


  dmConexao.conectarBanco;
  pIdOrganizacao := uUtil.TOrgAtual.getId;

  listaID := TStringList.Create;
  listaID.Clear;
  listaID.Add('Sem ID');
   combo.Clear;
   combo.Items.Add('<<< Selecione um banco  >>>');

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
          listaID.Add(qryObterTodos.FieldByName('ID_BANCO').AsString);
          qryObterTodos.Next;
        end;
      qryObterTodos.Close;
      combo.ItemIndex := 0;

   end;

end;



procedure TfrmBanco.limpaFrame;
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
