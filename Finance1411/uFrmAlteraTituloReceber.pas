unit uFrmAlteraTituloReceber;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  udmConexao,  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Data.DB, Vcl.Grids, Vcl.DBGrids,
  Vcl.StdCtrls, FireDAC.Stan.Intf, FireDAC.Stan.Option, FireDAC.Stan.Param,
  FireDAC.Stan.Error, FireDAC.DatS, FireDAC.Phys.Intf, FireDAC.DApt.Intf, uUtil,
  FireDAC.Stan.Async, FireDAC.DApt, FireDAC.Comp.DataSet, FireDAC.Comp.Client;

type
  TfrmAlteraNumDocTR = class(TForm)
    dbgrdTR: TDBGrid;
    btnConsulta: TButton;
    qryObterTR: TFDQuery;
    ds1: TDataSource;
    procedure FormCreate(Sender: TObject);
    procedure btnConsultaClick(Sender: TObject);
  private
    { Private declarations }
     procedure inicializarDM(Sender: TObject);
     procedure obterTitulos(pIdOrganizacao :string);

  public
    { Public declarations }
  end;

var
  frmAlteraNumDocTR: TfrmAlteraNumDocTR;

implementation

{$R *.dfm}

procedure TfrmAlteraNumDocTR.btnConsultaClick(Sender: TObject);
begin
dbgrdTR.DataSource.DataSet.Next;
dbgrdTR.Refresh;

ShowMessage('Dados atualizados com sucesso');
end;

procedure TfrmAlteraNumDocTR.FormCreate(Sender: TObject);
begin
  inicializarDM(Self);
end;


procedure TfrmAlteraNumDocTR.inicializarDM(Sender: TObject);
begin


  if not (Assigned(dmConexao)) then
  begin
    dmConexao := TdmConexao.Create(Self);
         dmConexao.conectarBanco;
  end;

   obterTitulos(TOrgAtual.getId);

end;

procedure TfrmAlteraNumDocTR.obterTitulos(pIdOrganizacao: string);
begin
dmConexao.conectarBanco;

    try
         qryObterTR.Close;
         qryObterTR.Connection := dmConexao.conn;
         qryObterTR.ParamByName('PIDORG').AsString := pIdOrganizacao;
         qryObterTR.Open;
         qryObterTR.Last;
         qryObterTR.First;

   except
       raise(Exception).Create('Problemas ao tentar obter TITULOS A RECEBER  ');
   end;

end;

end.
