unit uDMContasReceber;

interface

uses
  System.SysUtils, System.Classes, udmConexao, FireDAC.Stan.Intf,
  FireDAC.Stan.Option, FireDAC.Stan.Param, FireDAC.Stan.Error, FireDAC.DatS,
  FireDAC.Phys.Intf, FireDAC.DApt.Intf, FireDAC.Stan.Async, FireDAC.DApt,
  Data.DB, FireDAC.Comp.DataSet, FireDAC.Comp.Client;

type
  TdmContasReceber = class(TDataModule)
    qryObterTRPendentes: TFDQuery;
    dtsPendentesImportados: TDataSource;
    qryDelPendentesAll: TFDQuery;
  private
    { Private declarations }
  public
    { Public declarations }
    function obterTRPendentesImportados(pIdOrganizacao: String): Boolean;
    function deletePendentesAll(pIdOrganizacao: String): Boolean;
    function dataSourceIsEmpty(var dts: TDataSource): Boolean;

  end;

var
  dmContasReceber: TdmContasReceber;

implementation

{ %CLASSGROUP 'Vcl.Controls.TControl' }

{$R *.dfm}
{ TdmContasReceber }

function TdmContasReceber.dataSourceIsEmpty(var dts: TDataSource): Boolean;
begin
  Result := dts.DataSet.IsEmpty;
end;

function TdmContasReceber.deletePendentesAll(pIdOrganizacao: String): Boolean;
begin
  Result := false;
  qryDelPendentesAll.Close;
  if not qryDelPendentesAll.Connection.Connected then
  begin
    qryDelPendentesAll.Connection := dmConexao.Conn;
  end;
  qryDelPendentesAll.ParamByName('pIdOrganizacao').AsString := pIdOrganizacao;

  qryDelPendentesAll.ExecSQL;

  Result := System.True;

end;

function TdmContasReceber.obterTRPendentesImportados(pIdOrganizacao
  : String): Boolean;

begin
  Result := false;

  qryObterTRPendentes.Close;
  if not qryObterTRPendentes.Connection.Connected then
  begin
    qryObterTRPendentes.Connection := dmConexao.Conn;
  end;
  qryObterTRPendentes.ParamByName('pIdOrganizacao').AsString := pIdOrganizacao;
  qryObterTRPendentes.Open;

  Result := not qryObterTRPendentes.IsEmpty;

end;

end.
