unit uFrmTelaSenha;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.Buttons,
  uUsuarioDAO, uUsuarioModel, udmConexao, MDModel, MDDAO, uUtil, uConstantes,
  EMsgDlg, cxGraphics, cxControls, cxLookAndFeels, cxLookAndFeelPainters,
  dxSkinsCore, dxSkinsDefaultPainters, dxStatusBar ;

type
  TfrmTelaSenha = class(TForm)
    edtPassword: TEdit;
    btnConfirma: TBitBtn;
    PempecMsg: TEvMsgDlg;
    edtUsuario: TEdit;
    lblUser: TLabel;
    dxStatusBar: TdxStatusBar;
    Label1: TLabel;
    procedure btnConfirmaClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
  private
    { Private declarations }
    sucesso : Boolean;
    autorizado : Boolean;
    function verificaSenha(senha :string) :Boolean;
    procedure limpaStatusBar;
    procedure msgStatusBar(pPosicao: Integer; msg: string);
    procedure registraMovimentacao(pOrg, pTable, pAcao, pDsc, pStatus: string);

  public
    { Public declarations }
   function getAutorizado() : Boolean;
   constructor Create(AOwner: TComponent; usuario :TUsuarioModel);  overload;


  end;

var
  frmTelaSenha: TfrmTelaSenha;

implementation

{$R *.dfm}

{ TfrmTelaSenha }

constructor TfrmTelaSenha.Create(AOwner: TComponent; usuario: TUsuarioModel);
begin
inherited Create(AOwner);
 msgStatusBar(3,'Aguardando a senha...');
  autorizado := False;
  sucesso := False;

  if usuario <> nil then
  begin

    if not uutil.Empty(usuario.Fnome) then
    begin

      edtUsuario.Text := usuario.Fnome;


    end;

  end;

end;


procedure TfrmTelaSenha.btnConfirmaClick(Sender: TObject);
begin
  msgStatusBar(3, 'Verificando autoriza��es...');
  Sleep(5000);

  if verificaSenha(edtPassword.Text) then begin

    autorizado := True;
    msgStatusBar(3, 'Registrando seu acesso na base de dados...');
    Sleep(5000);
    registraMovimentacao(uutil.TOrgAtual.getId,'MANUTENCAO','TELA MANUT',uutil.TUserAtual.getLogin + ' acessou a tela de manuten��o.', 'SUCESSO');

    PempecMsg.MsgInformation('Fun��es liberadas.' + #13 +  ' Por favor, clique no bot�o ''OK'' e  aguarde o fechamento da tela...');

  end;

    PostMessage(Self.Handle, WM_CLOSE, 0, 0);


end;

procedure TfrmTelaSenha.registraMovimentacao(pOrg, pTable, pAcao, pDsc, pStatus: string);
begin
  TMDDAO.registroMD(pOrg, pTable, pAcao, pDsc, pStatus);

end;




procedure TfrmTelaSenha.FormClose(Sender: TObject; var Action: TCloseAction);
begin
Action := caFree;
end;

function TfrmTelaSenha.getAutorizado: Boolean;
begin

Result := autorizado;

end;

function TfrmTelaSenha.verificaSenha(senha: string): Boolean;
begin

  autorizado := False;
  sucesso := False;



  if not uutil.Empty(senha) then
  begin
   senha := UpperCase(senha);

    if senha.Equals( UpperCase (uConstantes.getSenhaPadrao)) then
    begin

      autorizado := True;
      sucesso := True;

    end;

  end;

  Result := autorizado;

end;


procedure TfrmTelaSenha.limpaStatusBar;
begin
dxStatusBar.Panels[0].Text := 'Status ';
dxStatusBar.Panels[1].Text := 'Ativo.  ';
dxStatusBar.Panels[2].Text := 'Processo : ';
dxStatusBar.Panels[3].Text := ' ...  ';

end;

procedure TfrmTelaSenha.msgStatusBar(pPosicao : Integer; msg :string);
begin
dxStatusBar.Panels[pPosicao].Text := msg;
Application.ProcessMessages;
end;

end.
