unit uFrameOrganizacoes;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes,
  Vcl.Graphics, Vcl.Controls, Vcl.Forms, Vcl.Dialogs,uDMCombos, udmConexao, uDMOrganizacao,
  Vcl.StdCtrls;

type
  TframeOrg = class(TFrame)
    cbbOrg: TComboBox;
    lbl1: TLabel;
  private
    { Private declarations }
  procedure listaOrganizacao(var combo: TComboBox; var listaID: TStringList);

    procedure inicializarDM(Sender: TObject);
    procedure freeAndNilDM(Sender: TObject);
  public
    { Public declarations }
    FsListaIdOrganizacoes: TStringList;
  procedure listar(Sender: TObject);
  procedure retiraOrganizacao(var combo: TComboBox; var listaID: TStringList; indice :Integer);


  end;

implementation

{$R *.dfm}

{ TFrame1 }

procedure TframeOrg.freeAndNilDM(Sender: TObject);
begin
if not (Assigned(dmConexao)) then
  begin
    dmConexao := TdmConexao.Create(Self);
  end;

  if not (Assigned(dmOrganizacao)) then
  begin
    dmOrganizacao := TdmOrganizacao.Create(Self);
  end;


  if not (Assigned(dmCombos)) then
  begin
    dmCombos := TdmCombos.Create(Self);
  end;



end;

procedure TframeOrg.inicializarDM(Sender: TObject);
begin

end;

procedure TframeOrg.listaOrganizacao(var combo: TComboBox;
  var listaID: TStringList);
begin

  if dmConexao.conectarBanco then
  begin
    if dmOrganizacao.carregarOrganizacoes then
    begin
      dmCombos.listaOrganizacao(cbbOrg, FsListaIdOrganizacoes);
    end;

  end;


end;



procedure TframeOrg.listar(Sender: TObject);
begin
listaOrganizacao(cbbOrg, FsListaIdOrganizacoes);
end;

procedure TframeOrg.retiraOrganizacao(var combo: TComboBox;
  var listaID: TStringList; indice :Integer);
begin
combo.Items.Delete(indice);
FsListaIdOrganizacoes.Delete(indice);

end;

end.
