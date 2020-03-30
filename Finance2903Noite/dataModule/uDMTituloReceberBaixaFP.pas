unit uDMTituloReceberBaixaFP;

interface

uses
  System.SysUtils, System.Classes, FireDAC.Stan.Intf, FireDAC.Stan.Option,
  FireDAC.Stan.Param, FireDAC.Stan.Error, FireDAC.DatS, FireDAC.Phys.Intf,
  FireDAC.DApt.Intf, FireDAC.Stan.Async, FireDAC.DApt, Data.DB,
  FireDAC.Comp.DataSet, FireDAC.Comp.Client, udmConexao;

type
  TdmTRBFP = class(TDataModule)
    qryObterPorTRB: TFDQuery;
  private
    { Private declarations }
    procedure inicializarDM(Sender: TObject);
  public
    { Public declarations }
    function obterPorTRB(pIdOrganizacao, pIdTitutloReceberBaixa
      : String): Boolean;
  end;

var
  dmTRBFP: TdmTRBFP;

implementation

{ %CLASSGROUP 'Vcl.Controls.TControl' }

{$R *.dfm}

procedure TdmTRBFP.inicializarDM(Sender: TObject);
begin

  if not(Assigned(dmConexao)) then
  begin
    dmConexao := TdmConexao.Create(Self);
  end
  else
  begin
    dmConexao.conectarBanco;
    dmConexao.conectarMega;
  end;
end;

function TdmTRBFP.obterPorTRB(pIdOrganizacao, pIdTitutloReceberBaixa
  : String): Boolean;
begin

  Result := false;

  inicializarDM(Self);

  if not qryObterPorTRB.Connection.Connected then
  begin
    qryObterPorTRB.Connection := dmConexao.Conn;
  end;

  qryObterPorTRB.Close;

  qryObterPorTRB.ParamByName('pIdOrganizacao').AsString := pIdOrganizacao;
  qryObterPorTRB.ParamByName('PIDTITULORECEBERBAIXA').AsString :=
    pIdTitutloReceberBaixa;
  qryObterPorTRB.Open;

  Result := not qryObterPorTRB.IsEmpty;
end;

end.
