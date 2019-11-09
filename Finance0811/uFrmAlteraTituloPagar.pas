unit uFrmAlteraTituloPagar;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Data.DB, Vcl.Grids, Vcl.DBGrids,uUtil,
  Vcl.StdCtrls, FireDAC.Stan.Intf, FireDAC.Stan.Option, FireDAC.Stan.Param, udmConexao,
  FireDAC.Stan.Error, FireDAC.DatS, FireDAC.Phys.Intf, FireDAC.DApt.Intf,
  FireDAC.Stan.Async, FireDAC.DApt, FireDAC.Comp.DataSet, FireDAC.Comp.Client;

type
  TfrmAlteraNumDocTP = class(TForm)
    btnConsulta: TButton;
    dbgrdTP: TDBGrid;
    dsPreencheGrid: TDataSource;
    qryObterTodos: TFDQuery;
    procedure FormCreate(Sender: TObject);
    procedure btnConsultaClick(Sender: TObject);
  private
    { Private declarations }
    idOrganizacao : string;
    codigoErro :string;
    procedure inicializarDM(Sender: TObject);
    function obterTodos(pIdOrganizacao: string): Boolean;
  public
    { Public declarations }
  end;

var
  frmAlteraNumDocTP: TfrmAlteraNumDocTP;

implementation

{$R *.dfm}


function TfrmAlteraNumDocTP.obterTodos(pIdOrganizacao: string): Boolean;
begin
codigoErro := 'AlteraTP-01';
   try
      qryObterTodos.Close;
      qryObterTodos.Connection := dmConexao.Conn;
      qryObterTodos.ParamByName('PIDORGANIZACAO').AsString := pIdOrganizacao;
      qryObterTodos.Open;
  except

  raise(Exception).Create('Erro ao tentar Obter todos os TPs ' + codigoErro );

  end;
  Result := not qryObterTodos.IsEmpty;
end;



procedure TfrmAlteraNumDocTP.btnConsultaClick(Sender: TObject);
begin
dbgrdTP.DataSource.DataSet.Next;
dbgrdTP.Refresh;

ShowMessage('Dados atualizados com sucesso');

end;

procedure TfrmAlteraNumDocTP.FormCreate(Sender: TObject);
begin
  inicializarDM(Self);
end;

procedure TfrmAlteraNumDocTP.inicializarDM(Sender: TObject);
begin

idOrganizacao := TOrgAtual.getId;
obterTodos(idOrganizacao);

//

end;

end.
