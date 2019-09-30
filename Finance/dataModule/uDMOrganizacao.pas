unit uDMOrganizacao;

interface

uses
  System.SysUtils, System.Variants, System.Classes,uUtil,
  FireDAC.Stan.Intf, FireDAC.Stan.Option, FireDAC.Stan.Param,
  FireDAC.Stan.Error, FireDAC.DatS, FireDAC.Phys.Intf, FireDAC.DApt.Intf,
  FireDAC.Stan.Async, FireDAC.DApt, Data.DB, FireDAC.Comp.DataSet,
  FireDAC.Comp.Client, FireDAC.UI.Intf, FireDAC.Comp.ScriptCommands, udmConexao,
  FireDAC.Stan.Util, FireDAC.Comp.Script;

type
  TdmOrganizacao = class(TDataModule)
    qryDadosEmpresa: TFDQuery;
    qryLoadOrgs: TFDQuery;
    qryOrganizacoes: TFDQuery;
    qryValidaLogin: TFDQuery;
    dtsOrganizacao: TDataSource;
    qryPreencheCombo: TFDQuery;
    qryDataServer: TFDQuery;
  private
    { Private declarations }
    procedure inicializarDM(Sender: TObject);
    procedure freeAndNilDM(Sender: TObject);
  public
    { Public declarations }
    function carregarOrganizacoes: Boolean;
    function carregarDadosEmpresa(pIdOrganizacao: string): Boolean;
    function obterListaOrganizacoes: TStringList;
    function preencheCombo(): Boolean;
    function obterCNPJOrganizacao():String;
    function obterDataServidor(): TDateTime;

  end;

var
  dmOrganizacao: TdmOrganizacao;

implementation

{ %CLASSGROUP 'Vcl.Controls.TControl' }

{$R *.dfm}

function TdmOrganizacao.carregarDadosEmpresa(pIdOrganizacao: string): Boolean;
begin
  try
      qryDadosEmpresa.Connection := dmConexao.Conn;
      qryDadosEmpresa.Close;
      qryDadosEmpresa.ParamByName('PIDORGANIZACAO').AsString := pIdOrganizacao;
      qryDadosEmpresa.Open;
  except
    raise(Exception).Create('Problemas ao carregar organizações.. ');
  end;

  Result := not qryDadosEmpresa.IsEmpty;
end;

function TdmOrganizacao.carregarOrganizacoes: Boolean;
begin
 try
    qryOrganizacoes.Connection := dmConexao.Conn;
    qryOrganizacoes.Close;
    qryOrganizacoes.Open;

 except
    raise(Exception).Create('Problemas ao carregar organizações.. ');
  end;


  Result := not qryOrganizacoes.IsEmpty;
end;

procedure TdmOrganizacao.freeAndNilDM(Sender: TObject);
begin
 //nada
end;

procedure TdmOrganizacao.inicializarDM(Sender: TObject);
begin
  //nada

end;

function TdmOrganizacao.obterCNPJOrganizacao: String;
begin
  Result := qryOrganizacoes.FieldByName('CNPJ').AsString ;
end;

function TdmOrganizacao.obterDataServidor: TDateTime;
var
data : TDateTime;
begin
  data := Now;
  try
      qryDataServer.Close;
      qryDataServer.Connection := dmConexao.Conn;
      qryDataServer.Open;

      data := qryDataServer.Fields[0].AsVariant;

      uUtil.setDataServer(data); //seta a data atual no sistema

  except
    raise(Exception).Create('Problemas ao carregar organizações.. ');
  end;

  Result := data;

end;

function TdmOrganizacao.obterListaOrganizacoes: TStringList;
var
  listaIdOrganizacoes: TStringList;
begin

  listaIdOrganizacoes := TStringList.Create;
  listaIdOrganizacoes.Clear;
  qryOrganizacoes.First;
  while not qryOrganizacoes.Eof do
  begin
    listaIdOrganizacoes.Add(qryOrganizacoes.FieldByName('NOME')
      .AsString);
    listaIdOrganizacoes.Add(qryOrganizacoes.FieldByName
      ('ID_ORGANIZACAO').AsString);
    qryOrganizacoes.Next;
  end;
  qryOrganizacoes.Close;

  Result := listaIdOrganizacoes;

end;


function TdmOrganizacao.preencheCombo(): Boolean;
var
cmd : String;
begin

  Result := false;
  cmd :=' SELECT O.razao_social, '+
        ' O.id_organizacao       '+
        ' FROM ORGANIZACAO O     '+
        ' WHERE ATIVA =1 '+
        ' ORDER BY  O.data_atualizacao desc ;';
    try

    qryPreencheCombo.Close;
    //qryPreencheCombo.SQL.Clear;
    //qryPreencheCombo.SQL.Add(cmd);
    qryPreencheCombo.Connection := dmConexao.Conn;
    qryPreencheCombo.Open;
   except
    raise(Exception).Create('Problemas ao carregar organizações.. ');
  end;

    Result := not qryPreencheCombo.IsEmpty;

end;


end.
