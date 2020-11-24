unit uDMCombos;

interface

uses
  System.SysUtils, System.Classes, Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.ComCtrls,
  Vcl.StdCtrls, udmConexao, uDMOrganizacao,uDMExportaFinance, uDMCedenteConsulta, uDMUsuarioConsulta, uUtil, Data.DB;

type
  TdmCombos = class(TDataModule)
    DTSCedente: TDataSource;
    DTSOrganizacao: TDataSource;
    DTSUsuario: TDataSource;
    dsLoteContabil: TDataSource;
    procedure DataModuleDestroy(Sender: TObject);
  private
    procedure inicializarDM(Sender: TObject);
    procedure freeAndNilDM(Sender: TObject);
  public
    { Public declarations }
    procedure listaFornecedor(var combo: TComboBox; var listaID: TStringList);
    procedure listaOrganizacao(var combo: TComboBox; var listaID: TStringList);
    procedure listaUsuario(var combo: TComboBox; var listaID: TStringList);
    procedure listaLoteContabil(var combo: TComboBox; var listaID: TStringList);


  end;

var
  dmCombos: TdmCombos;

implementation

{ %CLASSGROUP 'Vcl.Controls.TControl' }

{$R *.dfm}
{ TDataModule1 }

procedure TdmCombos.DataModuleDestroy(Sender: TObject);
begin
  freeAndNilDM(Self);
end;

procedure TdmCombos.freeAndNilDM(Sender: TObject);
var
  i: Integer;
begin

  if (Assigned(dmCedenteConsulta)) then
  begin
    FreeAndNil(dmCedenteConsulta);
  end;

end;

procedure TdmCombos.inicializarDM(Sender: TObject);
begin

  if not (Assigned(dmCedenteConsulta)) then
  begin
    dmCedenteConsulta := TdmCedenteConsulta.Create(Self);
  end;

  if not (Assigned(dmConexao)) then
  begin
    dmConexao := TdmConexao.Create(Self);
  end;

  if not (Assigned(dmOrganizacao)) then
  begin
    dmOrganizacao := TdmOrganizacao.Create(Self);
  end;

  if not (Assigned(dmUsuarioConsulta)) then
  begin
    dmUsuarioConsulta := TdmUsuarioConsulta.Create(Self);
  end;

end;

procedure TdmCombos.listaFornecedor(var combo: TComboBox; var listaID: TStringList);
begin

  if not (Assigned(dmCedenteConsulta)) then
  begin
    dmCedenteConsulta := TdmCedenteConsulta.Create(Self);
  end;

  listaID := TStringList.Create;
  listaID.Clear;
  listaID.Add('Sem ID');
  combo.Clear;
  combo.Items.Add('<<< Selecione  >>>');
  dmCedenteConsulta.preencheCombo(TOrgAtual.getId);
  dmCedenteConsulta.qryPreencheCombo.First;
  while not dmCedenteConsulta.qryPreencheCombo.Eof do
  begin
    combo.Items.Add(dmCedenteConsulta.qryPreencheCombo.FieldByName('NOME').AsString);
    listaID.Add(dmCedenteConsulta.qryPreencheCombo.FieldByName('ID_CEDENTE').AsString);
    dmCedenteConsulta.qryPreencheCombo.Next;
  end;
  dmCedenteConsulta.qryPreencheCombo.Close;
  combo.ItemIndex := 0;
  FreeAndNil(dmCedenteConsulta);
end;

procedure TdmCombos.listaLoteContabil(var combo: TComboBox;
  var listaID: TStringList);
begin
//lote
   if not (Assigned(dmExportaFinance)) then
  begin
    dmExportaFinance := TdmExportaFinance.Create(Self);
  end;

  listaID := TStringList.Create;
  listaID.Clear;
  listaID.Add('Sem ID');
  combo.Clear;
  combo.Items.Add('<<< LOTES   >>>');
  dmExportaFinance.preencheComboLoteContabil(uUtil.TOrgAtual.getId, '');
  dmExportaFinance.qryObterTodosLoteContabil.First;
  while not dmExportaFinance.qryObterTodosLoteContabil.Eof do
  begin
    combo.Items.Add(dmExportaFinance.qryObterTodosLoteContabil.FieldByName('LOTE').AsString);
    listaID.Add(dmExportaFinance.qryObterTodosLoteContabil.FieldByName('ID_LOTE_CONTABIL').AsString);
    dmExportaFinance.qryObterTodosLoteContabil.Next;
  end;
  dmExportaFinance.qryObterTodosLoteContabil.Close;
  combo.ItemIndex := 0;

end;

procedure TdmCombos.listaOrganizacao(var combo: TComboBox; var listaID: TStringList);
begin

  if not (Assigned(dmOrganizacao)) then
  begin
    dmOrganizacao := TdmOrganizacao.Create(Self);
  end;

  listaID := TStringList.Create;
  listaID.Clear;
  listaID.Add('Sem ID');
  combo.Clear;
  combo.Items.Add('<<< Selecione uma Empresa  >>>');
  dmOrganizacao.preencheCombo;
  dmOrganizacao.qryPreencheCombo.First;
  while not dmOrganizacao.qryPreencheCombo.Eof do
  begin
    combo.Items.Add(dmOrganizacao.qryPreencheCombo.FieldByName('RAZAO_SOCIAL').AsString);
    listaID.Add(dmOrganizacao.qryPreencheCombo.FieldByName('ID_ORGANIZACAO').AsString);
    dmOrganizacao.qryPreencheCombo.Next;
  end;
  dmOrganizacao.qryPreencheCombo.Close;
  combo.ItemIndex := 0;
  // FreeAndNil(dmOrganizacao);
end;

procedure TdmCombos.listaUsuario(var combo: TComboBox; var listaID: TStringList);
begin

  listaID := TStringList.Create;
  listaID.Clear;
  listaID.Add('Sem ID');
  combo.Clear;
  combo.Items.Add('<<< Selecione um Usu�rio  >>>');
  dmUsuarioConsulta.preencheCombo();
  dmUsuarioConsulta.qryPreencheCombo.First;
  while not dmUsuarioConsulta.qryPreencheCombo.Eof do
  begin
    combo.Items.Add(dmUsuarioConsulta.qryPreencheCombo.FieldByName('NOME').AsString);
    listaID.Add(dmUsuarioConsulta.qryPreencheCombo.FieldByName('ID').AsString);
    dmUsuarioConsulta.qryPreencheCombo.Next;
  end;
  dmUsuarioConsulta.qryPreencheCombo.Close;
  combo.ItemIndex := 0;

end;

end.


