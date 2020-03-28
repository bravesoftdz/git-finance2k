unit uDMCedenteConsulta;

interface

uses
  System.SysUtils, System.Classes, udmConexao, FireDAC.Stan.Intf,
  FireDAC.Stan.Option, FireDAC.Stan.Param, FireDAC.Stan.Error, FireDAC.DatS,
  FireDAC.Phys.Intf, FireDAC.DApt.Intf, FireDAC.Stan.Async, FireDAC.DApt,
  Data.DB, FireDAC.Comp.DataSet, FireDAC.Comp.Client;

type
  TdmCedenteConsulta = class(TDataModule)
    qryPreencheCombo: TFDQuery;
    qryObterCedentePorID: TFDQuery;
    dtsPreencheGrid: TDataSource;
    dtsCedentePorID: TDataSource;
    procedure DataModuleCreate(Sender: TObject);
  private
    { Private declarations }
    procedure inicializarDM(Sender: TObject);
    procedure freeAndNilDM(Sender: TObject);
  public
    { Public declarations }
    function preencheCombo(pIdOrganizacao: String): Boolean;
    function obterCedentePorId(pIdOrganizacao, pIdCedente: String): Boolean;

  end;

var
  dmCedenteConsulta: TdmCedenteConsulta;
  cmd: String;

implementation

{ %CLASSGROUP 'Vcl.Controls.TControl' }

{$R *.dfm}

procedure TdmCedenteConsulta.DataModuleCreate(Sender: TObject);
begin
inicializarDM(Self);
end;

procedure TdmCedenteConsulta.freeAndNilDM(Sender: TObject);
begin
  if (Assigned(dmConexao)) then
  begin
    FreeAndNil(dmConexao);
  end;
end;

procedure TdmCedenteConsulta.inicializarDM(Sender: TObject);
begin
  if not(Assigned(dmConexao)) then
  begin
    dmConexao := TdmConexao.Create(Self);
  end;
end;

function TdmCedenteConsulta.obterCedentePorId(pIdOrganizacao,
  pIdCedente: String): Boolean;
begin

  Result := false;
  cmd := ' SELECT * FROM CEDENTE C ' +
    ' WHERE (C.ID_ORGANIZACAO = :pIdOrganizacao) ' + ' AND ' +
    '(C.ID_CEDENTE = :pIdCedente)';

  if dmConexao.conectarBanco then
  begin

    qryObterCedentePorID.Close;
    if not qryObterCedentePorID.Connection.Connected then
    begin
      qryObterCedentePorID.Connection := dmConexao.Conn;
    end;
    qryObterCedentePorID.SQL.Clear;
    qryObterCedentePorID.SQL.Add(cmd);
    qryObterCedentePorID.ParamByName('pIdOrganizacao').AsString :=
      pIdOrganizacao;
    qryObterCedentePorID.ParamByName('pIdCedente').AsString := pIdCedente;
    qryObterCedentePorID.Open;

    Result := not qryObterCedentePorID.IsEmpty;
  end;

end;

function TdmCedenteConsulta.preencheCombo(pIdOrganizacao: String): Boolean;

begin

  Result := false;
  cmd := 'SELECT C.NOME,C.ID_CEDENTE FROM CEDENTE C ' +
    ' WHERE ( C.ID_ORGANIZACAO = :pIdOrganizacao ) ' + ' ORDER BY C.NOME;';

  if dmConexao.conectarBanco then
  begin

    qryPreencheCombo.Close;
    if not qryPreencheCombo.Connection.Connected then
    begin
      qryPreencheCombo.Connection := dmConexao.Conn;
    end;
    qryPreencheCombo.SQL.Clear;
    qryPreencheCombo.SQL.Add(cmd);
    qryPreencheCombo.ParamByName('pIdOrganizacao').AsString := pIdOrganizacao;
    qryPreencheCombo.Open;

    Result := not qryPreencheCombo.IsEmpty;
  end;
end;

end.
