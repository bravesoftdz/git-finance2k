unit uFrmManterTituloPagar;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics, System.DateUtils, System.Generics.Collections,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, udmConexao, uOrganizacaoModel, uDMOrganizacao,uUtil,
  uTituloPagarModel, uTituloPagarDAO, uContaContabilModel, uContaContabilDAO,
  uLoteContabilModel, uLoteContabilDAO, uLotePagamentoModel, uLotePagamentoDAO,uCentroCustoModel, uCentroCustoDAO,
    dxSkinsCore, dxSkinsDefaultPainters, cxGraphics, cxControls, uCedenteModel,uCedenteDAO,
  cxLookAndFeels, cxLookAndFeelPainters, dxRibbonSkins, uTipoStatusModel, uTipoStatusDAO,
  dxRibbonCustomizationForm, cxClasses, dxRibbon, dxBar, dxStatusBar, uHistoricoModel, uHistoricoDAO, uFuncionarioModel, uFuncionarioDAO,
  dxBarBuiltInMenu, cxPC, uFrameTP, Vcl.StdCtrls, uFrameCentroCusto,
  uFrameGeneric, uFrameHistorico, uFrameCedente, uFrameLocalPagamento,
  uFrameTipoCobranca, uFrameResponsavel, Vcl.Buttons, ENumEd, Vcl.ComCtrls;

type
  TfrmManterTituloPagar = class(TForm)
    dxBarManager1: TdxBarManager;
    dxRibbon1Tab1: TdxRibbonTab;
    dxRibbon1: TdxRibbon;
    dxBarManager1Bar1: TdxBar;
    dxBarManager1Bar2: TdxBar;
    dxBarManager1Bar3: TdxBar;
    dxBarManager1Bar4: TdxBar;
    dxBarManager1Bar6: TdxBar;
    dxBarManager1Bar7: TdxBar;
    dxBarBtnSair: TdxBarLargeButton;
    dxBtnLimpar: TdxBarLargeButton;
    dxStatusBar: TdxStatusBar;
    dxBtnNew: TdxBarLargeButton;
    dxBtnEdit: TdxBarLargeButton;
    dxBtnSave: TdxBarLargeButton;
    dxBtnDelet: TdxBarLargeButton;
    dxBarLargeButton5: TdxBarLargeButton;
    pgTitulo: TcxPageControl;
    tbBasica: TcxTabSheet;
    tbComplemento: TcxTabSheet;
    tbNotaFiscal: TcxTabSheet;
    tbRateioHistoricos: TcxTabSheet;
    tbRateioCentroCusto: TcxTabSheet;
    Label1: TLabel;
    frameTP1: TframeTP;
    frmTipoCobranca1: TfrmTipoCobranca;
    frmLocalPagto1: TfrmLocalPagto;
    frameCedente1: TframeCedente;
    frameHistorico1: TframeHistorico;
    frameCentroCusto1: TframeCentroCusto;
    frameResponsavel1: TframeResponsavel;
    edtLotePagamento: TEdit;
    edtLoteContabil: TEdit;
    Label2: TLabel;
    Label3: TLabel;
    BtnGerarDOC: TBitBtn;
    Label4: TLabel;
    edtCEDConta: TEdit;
    edtCEDReduz: TEdit;
    lblResponsavel: TLabel;
    Label5: TLabel;
    Label6: TLabel;
    edtHISTConta: TEdit;
    edtHISTReduz: TEdit;
    edtCodigoHist: TEdit;
    Label7: TLabel;
    edtValor: TEvNumEdit;
    edtDescricao: TEdit;
    Label8: TLabel;
    Label9: TLabel;
    dtPagamento: TDateTimePicker;
    dtProtocolo: TDateTimePicker;
    dtEmissao: TDateTimePicker;
    Label10: TLabel;
    Label11: TLabel;
    Label12: TLabel;
    edtParcela: TEdit;
    Label13: TLabel;
    edtStatus: TEdit;
    Label14: TLabel;
    edtValorAntecipado: TEvNumEdit;
    Label15: TLabel;
    dxBarManager1Bar5: TdxBar;
    dxBtnPagar: TdxBarLargeButton;
    dxBarManager1Bar8: TdxBar;
    dxBarManager1Bar9: TdxBar;
    dxBtnRecibo: TdxBarLargeButton;
    dxBtnEspelho: TdxBarLargeButton;
    procedure dxBarBtnSairClick(Sender: TObject);
    procedure dxBtnLimparClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure frameTP1cbbTPExit(Sender: TObject);
    procedure frameCedente1cbbcomboChange(Sender: TObject);
    procedure frameHistorico1cbbcomboChange(Sender: TObject);
    procedure BtnGerarDOCClick(Sender: TObject);
    procedure frameTP1cbbTPChange(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure dxBtnNewClick(Sender: TObject);
    procedure frameCentroCusto1cbbCentroCustoChange(Sender: TObject);
    procedure frameResponsavel1cbbcomboChange(Sender: TObject);
  private
    { Private declarations }
    pIDorganizacao :string;
    pIDusuario :string;
    tituloPagarModel  : TTituloPagarModel;
    tituloSelecionado : TTituloPagarModel; //titulo que veio da consulta
    cedenteModel      : TCedenteModel;
    historicoModel    : THistoricoModel;
    centroCustoModel  : TCentroCustoModel;
    responsavelModel  : TFuncionarioModel;
    statusModel       : TTipoStatusModel;
    modo :Integer;

    FSlistaTipoCobranca,    FSlistaIdContaContabil, FSlistaResponsavel, FSlistaLocalPagamento : TStringList;
    FSlistaCentroCusto, FSlistaHistorico, FSlistaTitulos, FSlistaCedente  : TStringList;


    procedure limparPanel;
    procedure msgStatusBar(pPosicao: Integer; msg: string);
    procedure limpaStatusBar;
    procedure carregarCombos(titulo :TTituloPagarModel) ;
    function obterLoteContabil (titulo :TTituloPagarModel) : TLoteContabilModel;
    function obterLotePagamento (titulo :TTituloPagarModel) : TLotePagamentoModel;
    function obterIndiceLista(pId :string; lista :TStringList) : Integer;
    procedure popularCedente(cedente: TCedenteModel);
    procedure popularHistorico(historico: THistoricoModel);
    procedure popularCentroCusto(centroCusto: TCentroCustoModel);
    procedure popularResponsavel(responsavel: TFuncionarioModel);
    procedure popularStatus(status: TTipoStatusModel);


  public
    { Public declarations }
  end;

var
  frmManterTituloPagar : TfrmManterTituloPagar;

  implementation

{$R *.dfm}

procedure TfrmManterTituloPagar.BtnGerarDOCClick(Sender: TObject);
var
nDOC:string;
begin
   if modo > 0 then begin

    nDOC := dmConexao.obterIdentificador(pIDorganizacao, 'TP');
    tituloPagarModel := TTituloPagarModel.Create;
    tituloPagarModel.FIDorganizacao := pIDorganizacao;
    tituloPagarModel.FID := dmConexao.obterNewID;
    tituloPagarModel.FnumeroDocumento := nDOC;
    frameTP1.Enabled := False;
    frameTP1.cbbTP.Items.Add(nDOC);
    FSlistaTitulos.Add(tituloPagarModel.FID);
    frameTP1.cbbTP.ItemIndex := obterIndiceLista(tituloPagarModel.FID, FSlistaTitulos);

    BtnGerarDOC.Enabled := False;
    dxBtnDelet.Enabled := False;
    dxBtnEdit.Enabled := False;

   end;



end;

procedure TfrmManterTituloPagar.carregarCombos (titulo :TTituloPagarModel) ;
begin

    if uutil.Empty(titulo.FID) then begin


      frameTP1.obterTodos(pIDorganizacao, frameTP1.cbbTP, FSlistaTitulos);
      frameCedente1.obterTodos(pIDorganizacao, frameCedente1.cbbcombo, FSlistaCedente);
      frameHistorico1.obterTodosPorTipo (pIDorganizacao,'P', frameHistorico1.cbbcombo, FSlistaHistorico);
      frameCentroCusto1.obterTodos(pIDorganizacao, frameCentroCusto1.cbbCentroCusto, FSlistaCentroCusto);
      frameResponsavel1.obterTodos(pIDorganizacao, frameResponsavel1.cbbcombo, FSlistaResponsavel);
      frmTipoCobranca1.obterTodos(pIDorganizacao, frmTipoCobranca1.cbbTipoCobranca, FSlistaTipoCobranca);
      frmLocalPagto1.obterTodos(pIDorganizacao, frmLocalPagto1.cbbLocalPagto, FSlistaLocalPagamento);


       frameCedente1.cbbcombo.ItemIndex             := 0;
       frameHistorico1.cbbcombo.ItemIndex           := 0;
       frameCentroCusto1.cbbCentroCusto.ItemIndex   := 0;
       frameResponsavel1.cbbcombo.ItemIndex         := 0;
       frmTipoCobranca1.cbbTipoCobranca.ItemIndex   := 0;
       frmLocalPagto1.cbbLocalPagto.ItemIndex       := 0;



    end else begin


       frameCedente1.cbbcombo.ItemIndex            := obterIndiceLista(titulo.FIDCedente, FSlistaCedente);
       frameHistorico1.cbbcombo.ItemIndex           := obterIndiceLista(titulo.FIDHistorico,FSlistaHistorico);
       frameCentroCusto1.cbbCentroCusto.ItemIndex   := obterIndiceLista(titulo.FIDCentroCusto, FSlistaCentroCusto);
       frameResponsavel1.cbbcombo.ItemIndex         := obterIndiceLista(titulo.FIDResponsavel, FSlistaResponsavel);
       frmTipoCobranca1.cbbTipoCobranca.ItemIndex   := obterIndiceLista(titulo.FIDTipoCobranca, FSlistaTipoCobranca);
       frmLocalPagto1.cbbLocalPagto.ItemIndex       := obterIndiceLista(titulo.FIDLocalPagamento, FSlistaLocalPagamento);

    end;


    frameTP1.Enabled := True;

end;

procedure TfrmManterTituloPagar.dxBarBtnSairClick(Sender: TObject);
begin
 PostMessage(Self.Handle, WM_CLOSE, 0, 0);
end;

procedure TfrmManterTituloPagar.dxBtnLimparClick(Sender: TObject);
begin
limparPanel;
end;

procedure TfrmManterTituloPagar.dxBtnNewClick(Sender: TObject);
begin
ShowMessage('botao novo');
end;

procedure TfrmManterTituloPagar.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  FreeAndNil(tituloPagarModel);
  FreeAndNil(tituloSelecionado);
  FreeAndNil(cedenteModel);
  FreeAndNil(historicoModel);
  FreeAndNil(centroCustoModel);
  FreeAndNil(responsavelModel);


  Action := caFree;
end;

procedure TfrmManterTituloPagar.FormCreate(Sender: TObject);
begin
limparPanel;


end;

procedure TfrmManterTituloPagar.FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
begin

 case key of
  vk_f2: dxBtnEdit.Click;
  vk_f4: dxBtnNew.Click;
  vk_f10: dxBtnSave.Click;
  VK_RETURN : BtnGerarDOC.Click;

  end;

  end;

procedure TfrmManterTituloPagar.popularCedente(cedente :TCedenteModel);
begin
    cedenteModel                := TCedenteModel.Create;
    cedenteModel.FIDorganizacao := cedente.FIDorganizacao;
    cedenteModel.FID            := cedente.FID;
    cedenteModel                := TCedenteDAO.obterPorID(cedente);

  if not uUtil.Empty(cedenteModel.FID) then
  begin
    if not uutil.Empty(cedenteModel.FcontaContabil.FID) then
    begin

      edtCEDConta.Text := cedenteModel.FcontaContabil.Fconta;
      edtCEDReduz.Text := cedenteModel.FcontaContabil.FcodigoReduzido;

    end
    else
    begin
      edtCEDConta.Text := 'NC';
      edtCEDReduz.Text := 'NC';
      msgStatusBar(1, 'Verifique a conta contábil do cedente/fornecedor.');
      dxBtnSave.Enabled := False;
    end;

  end;



end;

procedure TfrmManterTituloPagar.popularCentroCusto( centroCusto: TCentroCustoModel);
begin
    centroCustoModel                := TCentroCustoModel.Create;
    centroCustoModel.FIDorganizacao := centroCusto.FIDorganizacao;
    centroCustoModel.FID            := centroCusto.FID;
    centroCustoModel                := TCentroCustoDAO.obterPorID(centroCusto);

  if not uUtil.Empty(centroCustoModel.FID) then
  begin

    frameCentroCusto1.cbbCentroCusto.ItemIndex := obterIndiceLista(centroCustoModel.FID,FSlistaCentroCusto );

  end;

end;

procedure TfrmManterTituloPagar.popularHistorico(historico: THistoricoModel);
begin
    historicoModel              := THistoricoModel.Create;
    historicoModel.FIDorganizacao := historico.FIDorganizacao;
    historicoModel.FID            := historico.FID;
    historicoModel                := THistoricoDAO.obterPorID(historico);

  if not uUtil.Empty(historicoModel.FID) then
  begin
    if not uutil.Empty(historicoModel.FcontaContabil.FID) then
    begin

      edtHISTConta.Text   := historicoModel.FcontaContabil.Fconta;
      edtHISTReduz.Text   := historicoModel.FcontaContabil.FcodigoReduzido;
      edtCodigoHist.Text  := IntToStr(historicoModel.FCodigo);

    end
    else
    begin
      edtHISTConta.Text := 'NC';
      edtHISTReduz.Text := 'NC';
      msgStatusBar(1, 'Verifique a conta contábil do histórico');
      dxBtnSave.Enabled := False;
    end;

  end;


end;


procedure TfrmManterTituloPagar.popularResponsavel(responsavel: TFuncionarioModel);
begin
    responsavelModel                := TFuncionarioModel.Create;
    responsavelModel.FIDorganizacao := responsavel.FIDorganizacao;
    responsavelModel.FID            := responsavel.FID;
    responsavelModel                := TFuncionarioDAO.obterPorID(responsavel);

  end;

procedure TfrmManterTituloPagar.popularStatus(status: TTipoStatusModel);
begin
    dxBtnPagar.Enabled  := False;
    dxBtnEdit.Enabled   := False;
    dxBtnDelet.Enabled  := False;
    dxBtnNew.Enabled    := False;
    dxBtnSave.Enabled   := False;

    statusModel                     := TTipoStatusModel.Create;
    statusModel.FIDorganizacao      := status.FIDorganizacao;
    statusModel.FID                 := status.FID;
    statusModel                     := TTipoStatusDAO.obterPorID(status);

    if status.Fdescricao.Equals('ABERTO') then begin

            dxBtnPagar.Enabled  := True;
            dxBtnEdit.Enabled   := True;
            dxBtnDelet.Enabled  := True;
            dxBtnSave.Enabled   := True;

     end;


end;

procedure TfrmManterTituloPagar.frameCedente1cbbcomboChange(Sender: TObject);
begin
//if Assigned(cedenteModel) then begin FreeAndNil(cedenteModel); end;

if frameCedente1.cbbcombo.ItemIndex >0 then begin

  cedenteModel                := TCedenteModel.Create;
  cedenteModel.FID            := FSlistaCedente[frameCedente1.cbbcombo.ItemIndex];
  cedenteModel.FIDorganizacao := pIDorganizacao;
  popularCedente(cedenteModel);

 end else begin ShowMessage('Selecione um cedente.'); end;

end;

procedure TfrmManterTituloPagar.frameCentroCusto1cbbCentroCustoChange( Sender: TObject);
begin
  if frameCentroCusto1.cbbCentroCusto.ItemIndex > 0 then
  begin

   centroCustoModel                 := TCentroCustoModel.Create;
   centroCustoModel.FID             := FSlistaCentroCusto[frameCentroCusto1.cbbCentroCusto.ItemIndex];
   centroCustoModel.FIDorganizacao  := pIDorganizacao;
   popularCentroCusto(centroCustoModel);

  end
  else
  begin
    ShowMessage('Selecione um centro de custos.');

  end;


end;

procedure TfrmManterTituloPagar.frameHistorico1cbbcomboChange(Sender: TObject);
begin

if frameHistorico1.cbbcombo.ItemIndex >0 then begin

  historicoModel                := THistoricoModel.Create;
  historicoModel.FID            := FSlistaHistorico[frameHistorico1.cbbcombo.ItemIndex];
  historicoModel.FIDorganizacao := pIDorganizacao;
  popularHistorico(historicoModel);

 end else begin ShowMessage('Selecione um historico.'); end;




end;

procedure TfrmManterTituloPagar.frameResponsavel1cbbcomboChange(  Sender: TObject);
begin

if frameResponsavel1.cbbcombo.ItemIndex >0 then begin

  responsavelModel                := TFuncionarioModel.Create;
  responsavelModel.FID            := FSlistaResponsavel[frameResponsavel1.cbbcombo.ItemIndex];
  responsavelModel.FIDorganizacao := pIDorganizacao;
  popularResponsavel(responsavelModel);

 end else begin ShowMessage('Selecione um responsável.'); end;


end;

procedure TfrmManterTituloPagar.frameTP1cbbTPChange(Sender: TObject);
begin
 modo :=0; //modo de consulta

 if modo = 0  then begin
    BtnGerarDOC.Caption := 'Consultar';
  end;
end;

procedure TfrmManterTituloPagar.frameTP1cbbTPExit(Sender: TObject);
begin
tituloSelecionado := TTituloPagarModel.Create;

 if frameTP1.cbbTP.ItemIndex >0 then begin
   //verifica se tem lotes (contabil e pagametno)

   tituloSelecionado.FID := FSlistaTitulos[frameTP1.cbbTP.ItemIndex];
   tituloSelecionado.FIDorganizacao := pIDorganizacao;
   tituloSelecionado := TTituloPagarDAO.obterPorID(tituloSelecionado);
   carregarCombos(tituloSelecionado); //carrega com o objeto que vem do BD
   popularCedente(tituloSelecionado.FCedente);
   popularHistorico(tituloSelecionado.FHistorico);
   popularCentroCusto(tituloSelecionado.FCentroCustos);
   popularResponsavel(tituloSelecionado.FResponsavel);
   popularStatus(tituloSelecionado.FTipoStatus);


   edtLotePagamento.Text  := tituloSelecionado.FLotePagamento.Flote;
   edtLoteContabil.Text   := tituloSelecionado.FLoteContabil.Flote;
   edtValor.Value         := tituloSelecionado.FvalorNominal;
   edtValorAntecipado.Value := tituloSelecionado.FvalorAntecipado;
   edtParcela.Text        := tituloSelecionado.Fparcela;
   edtStatus.Text         := tituloSelecionado.FTipoStatus.Fdescricao;
   edtDescricao.Text      := tituloSelecionado.Fdescricao;
   Label10.Caption := 'Data pagamento';
   dtPagamento.DateTime   := tituloSelecionado.FdataPagamento;
   dtEmissao.DateTime     := tituloSelecionado.FdataEmissao;
   dtProtocolo.DateTime   := tituloSelecionado.FdataProtocolo;

   if tituloSelecionado.FIDTipoStatus.Equals('ABERTO') then begin
    Label10.Caption := 'Data vencimento';
    dtPagamento.DateTime   := tituloSelecionado.FdataVencimento;

    dxBtnPagar.Enabled := True;


   end;
    if tituloSelecionado.FIDTipoStatus.Equals('EXCLUIDO') then begin
    Label10.Caption := 'Data vencimento';
    dtPagamento.DateTime   := tituloSelecionado.FdataVencimento;
   end;





  end else begin ShowMessage('Selecione um título. '); end;

  if modo = 0  then begin
    BtnGerarDOC.Caption := 'Consultar';
  end;
end;

procedure TfrmManterTituloPagar.limparPanel;
begin
 modo :=1;
  BtnGerarDOC.Caption := 'Gerar';
  dxBtnPagar.Enabled := True;
 LimpaTela(Self);

 limpaStatusBar;

 if Assigned(tituloPagarModel) then begin FreeAndNil(tituloPagarModel); end;
 if Assigned(tituloSelecionado) then begin FreeAndNil(tituloSelecionado); end;

 tituloPagarModel := TTituloPagarModel.Create;
 tituloSelecionado := TTituloPagarModel.Create;
 BtnGerarDOC.Enabled := True;
 pIdOrganizacao := UUtil.TOrgAtual.getId;
 pIdUsuario :=uutil.TUserAtual.getUserId;

 carregarCombos(tituloPagarModel);
end;

procedure TfrmManterTituloPagar.limpaStatusBar;
begin
msgStatusBar(0, 'Status ');
msgStatusBar(1, 'Ativo ');

//dxStatusBar.Panels[1].Text := 'Ativo. Teclas de atalho:  [F2] = Editar  - [F4] = Novo - [F10] = Salvar  ';
end;

procedure TfrmManterTituloPagar.msgStatusBar(pPosicao: Integer; msg: string);
begin
dxStatusBar.Panels[pPosicao].Text := msg;
Application.ProcessMessages;

end;

function TfrmManterTituloPagar.obterIndiceLista(pId: string;  lista: TStringList): Integer;
var
  I: Integer;
begin
 Result :=0;

  for I := 0 to lista.Count-1 do begin
    if(lista[I].Equals(pId)) then begin
       Result := I;
       Break;
    end;

  end;

end;

function TfrmManterTituloPagar.obterLoteContabil( titulo: TTituloPagarModel): TLoteContabilModel;
var
lote :TLoteContabilModel;
begin
 lote := TLoteContabilModel.Create;

 try

   lote := TLoteContabilDAO.obterPorID(titulo.FLoteContabil);


 except
 on e: Exception do
      ShowMessage(e.Message + sLineBreak + 'Contate o suporte. Informe erro: ' );

 end;


 Result := lote;
end;

function TfrmManterTituloPagar.obterLotePagamento(titulo: TTituloPagarModel): TLotePagamentoModel;
var
lote :TLotePagamentoModel;
begin
 lote := TLotePagamentoModel.Create;

 try

   lote := TLotePagamentoDAO.obterPorID(titulo.FLotePagamento);


 except
 on e: Exception do
      ShowMessage(e.Message + sLineBreak + 'Contate o suporte. Informe erro: ' );

 end;


 Result := lote;
end;





end.


