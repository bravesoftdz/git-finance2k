unit uFrmBaixaFP;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics, System.DateUtils,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, ENumEd, uUtil, Data.DB,udmConexao,uFrmBaixaFPInternet,uTPBaixaInternetModel,
  cxGraphics, cxControls, cxLookAndFeels, cxLookAndFeelPainters, dxSkinsCore, uDMBaixaTP,uTPBaixaFPModel, uFormaPagamentoDAO,
  dxSkinsDefaultPainters, FireDAC.Stan.Intf, FireDAC.Stan.Option, uContaBancariaChequeModel,uFrmBaixaFPCheque,   FireDAC.Stan.Param, FireDAC.Stan.Error, FireDAC.DatS, FireDAC.Phys.Intf,uCedenteModel,
  FireDAC.DApt.Intf, FireDAC.Comp.DataSet, FireDAC.Comp.Client, dxStatusBar, uTituloPagarModel,uTituloPagarDAO,  uFormaPagamentoModel,
  Vcl.Grids, Vcl.DBGrids, uFrameFormaPagamento, Vcl.ComCtrls, uFrameGeneric, uTPBaixaDAO, uTPBaixaModel,uTPBaixaChequeModel,
  uFrameResponsavel, dxBarBuiltInMenu,System.Generics.Collections, cxPC, uLoteContabilModel, uLoteContabilDAO;

type
  TfrmBaixaFP = class(TForm)
    frmFormaPagto1: TfrmFormaPagto;
    edtValorPago: TEvNumEdit;
    lbl1: TLabel;
    lbl2: TLabel;
    btnSelect: TButton;
    dbgrdFP: TDBGrid;
    dxStatusBar: TdxStatusBar;
    fdmFP: TFDMemTable;
    dsGridFP: TDataSource;
    btnDin: TButton;
    btnCheque: TButton;
    btnWEB: TButton;
    btnLimpar: TButton;
    btnCancelar: TButton;
    edtDoc: TEdit;
    cbbTipoPagto: TComboBox;
    edtDescricao: TEdit;
    edtVcto: TEdit;
    edtParcela: TEdit;
    edtValotTP: TEvNumEdit;
    edtCedente: TEdit;
    lbl3: TLabel;
    lbl4: TLabel;
    lbl5: TLabel;
    lbl6: TLabel;
    lbl7: TLabel;
    lbl8: TLabel;
    lbl9: TLabel;
    dtpPagto: TDateTimePicker;
    lbl10: TLabel;
    frameResponsavel1: TframeResponsavel;
    edtCNPJ: TEdit;
    lbl11: TLabel;
    cxpgcntrlFP: TcxPageControl;
    tbTransfereFP: TcxTabSheet;
    tbTransfereAC: TcxTabSheet;
    tbTransfereDE: TcxTabSheet;
    btnPagamento: TButton;
    edtLoteContabil: TEdit;
    procedure FormCreate(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure btnSelectClick(Sender: TObject);
    procedure btnDinClick(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure btnChequeClick(Sender: TObject);
    procedure btnWEBClick(Sender: TObject);
    procedure btnLimparClick(Sender: TObject);
    procedure btnCancelarClick(Sender: TObject);
    procedure cbbTipoPagtoChange(Sender: TObject);
    procedure frameResponsavel1cbbcomboChange(Sender: TObject);
    procedure dtpPagtoChange(Sender: TObject);
    procedure tbTransfereFPShow(Sender: TObject);
    procedure btnPagamentoClick(Sender: TObject);
  private
    { Private declarations }
    baixaModel  :TTPBaixaModel;
    FSListaIDResp, FSListaIDFP :TStringList;
    pIdOrganizacao :string;
    valorDevido :Currency;
    totalFP, totalAC, totalDE : Currency;
    cheque : TContaBancariaChequeModel;
    tituloPagar :TTituloPagarModel;
    FListaFormasPagto: TObjectList<TTPBaixaFPModel>;
    lote : TLoteContabilModel;
    procedure createTable;
    procedure removeFP(pIndice :Integer);
    function  obterValorPago: Currency;
    procedure validarValor;
    procedure msgStatusBar(pPosicao: Integer; msg: string);
    procedure limpar;
    procedure limparForm;
    procedure preencheForm(pTitulo :TTituloPagarModel);
    procedure limparAba(aba: TcxTabSheet);
    procedure atualizaValoPagar;
    function baixarTitulo(pBaixa: TTPBaixaModel): Boolean;
   function  obterLoteContabil(pLote : TLoteContabilModel) : TLoteContabilModel;

  public
    { Public declarations }
  constructor Create (AOwner :TComponent; pTitulo :TTituloPagarModel);

  end;

var
  frmBaixa :TfrmBaixaFP ;

implementation

{$R *.dfm}

{ TfrmBaixaFP2 }

procedure TfrmBaixaFP.btnCancelarClick(Sender: TObject);
begin
  btnLimpar.Click;
 PostMessage(Self.Handle, WM_CLOSE, 0, 0);
end;

procedure TfrmBaixaFP.btnChequeClick(Sender: TObject);
var
 posicao, I: Integer;
begin
      posicao := 0;

      for I := 0 to FSListaIDFP.Count - 1 do
      begin
        if FSListaIDFP[I].Equals('CHEQUE') then
        begin
          posicao := I;
          Break;
        end;
      end;

      frmFormaPagto1.cbbFormaPagto.ItemIndex := posicao;
      btnSelect.Click;
      btnCheque.Enabled := False;

end;

procedure TfrmBaixaFP.btnDinClick(Sender: TObject);
var
 posicao, I: Integer;
begin
      posicao := 0;

      for I := 0 to FSListaIDFP.Count - 1 do
      begin
        if FSListaIDFP[I].Equals('ESPECIE') then
        begin
          posicao := I;
          Break;
        end;
      end;

      frmFormaPagto1.cbbFormaPagto.ItemIndex := posicao;
      btnSelect.Click;
      btnDin.Enabled := False;

end;

procedure TfrmBaixaFP.btnLimparClick(Sender: TObject);
begin
 limpar;

end;

procedure TfrmBaixaFP.btnPagamentoClick(Sender: TObject);
 begin
  try

    if baixaModel.FvalorPago <> valorDevido then
    begin
      ShowMessage('Valor pago est� diferente do valor devido. Verifique!');
    end;

    //falta list a de AC e lista de DE
    { baixa de TP pago em cheque
    1 - altera o TP (DATA_ULTIMA_ATUALIZACAO, DATA_PAGAMENTO)
    2 - salva o TPB
    3 - salva o TPB_FP
    4 - salva o TPB_Cheque
    5 - altera o cheque ( ID_TIPO_STATUS, VALOR, DATA_EMISSAO, OBSERVACAO,PORTADOR,  DATA_PREVISAO_COMPENSACAO, QTD_IMPRESSAO )
    6 - salvar CBD  }

    if TTPBaixaDAO.salvarBaixa(baixaModel, tituloPagar) then
    begin
      ShowMessage('Titulo pago com sucesso...');
      btnCancelar.Click;
    end;

  except
    on e: Exception do
      ShowMessage(e.Message + sLineBreak + 'Contate o administrador!');
  end;

end;

///

procedure TfrmBaixaFP.btnSelectClick(Sender: TObject);
var
chequePagto :TContaBancariaChequeModel;
idFormaPagto :string;
baixaCheque  : TTPBaixaChequeModel;
baixaWWW      :TTPBaixaInternetModel;
baixaFP      : TTPBaixaFPModel;
formaPagto   : TFormaPagamentoModel;

begin
   tbTransfereAC.Enabled := False;
   tbTransfereDE.Enabled := False;

 if frmFormaPagto1.cbbFormaPagto.ItemIndex >0 then begin
    idFormaPagto := FSListaIDFP[frmFormaPagto1.cbbFormaPagto.ItemIndex];

    if idFormaPagto.Equals('CHEQUE') then
    begin

     formaPagto := TFormaPagamentoModel.Create;
     formaPagto.FID := idFormaPagto;
     formaPagto.FIDorganizacao := pIdOrganizacao;
     formaPagto := TFormaPagamentoDAO.obterPorID(formaPagto);

      chequePagto                 := TContaBancariaChequeModel.Create;
      chequePagto.FIdOrganizacao  := pIdOrganizacao;
      chequePagto.FValor          := edtValorPago.Value;
      chequePagto.FPortador       := edtCedente.Text;
      chequePagto.FIDresponsavel  := baixaModel.FIDResponsavel;

      frmBaixaFPCheque := TfrmBaixaFPCheque.Create(Self, chequePagto);
      frmBaixaFPCheque.ShowModal;
      chequePagto := frmBaixaFPCheque.getCheque;
   //   FreeAndNil(frmBaixaFPCheque);

      if chequePagto.Fvalor > 0 then
      begin
        fdmFP.Open;
        fdmFP.InsertRecord([frmFormaPagto1.cbbFormaPagto.Text + ' ' + chequePagto.FNumero, edtValorPago.Value]);
      end;

      // TITULO_PAGAR_BAIXA_CHEQUE
      baixaCheque                := TTPBaixaChequeModel.Create;
      baixaCheque.FID            := dmConexao.obterNewID;
      baixaCheque.FIDorganizacao := pIdOrganizacao;
      baixaCheque.FIDTOB         := 'PAGTO EM CHEQUE';
      baixaCheque.FIDTPBaixa     := baixaModel.FID;
      baixaCheque.FCheque        := chequePagto;
      baixaCheque.Fvalor         := chequePagto.FValor;
      //doc + datas

     // TITULO_PAGAR_BAIXA_FP
     baixaFP := TTPBaixaFPModel.Create;
     baixaFP.FID := dmConexao.obterNewID;
     baixaFP.FIDorganizacao := pIdOrganizacao;
     baixaFP.FFormaPagamento := formaPagto;
     baixaFP.FValor := baixaCheque.Fvalor;
     baixaFP.FIDTPBaixa := baixaModel.FID;

      totalFP := totalFP + baixaFP.FValor ;

     baixaModel.AdicionarFP(baixaFP); //coloca esse pagto dentro do model de baixa
     baixaModel.FTPBaixaCheque := baixaCheque;   //seta o cheque na baixa
    end;


    if idFormaPagto.Equals('ESPECIE') then
    begin

     formaPagto := TFormaPagamentoModel.Create;
     formaPagto.FID := idFormaPagto;
     formaPagto.FIDorganizacao := pIdOrganizacao;
     formaPagto := TFormaPagamentoDAO.obterPorID(formaPagto);

      fdmFP.Open;
      fdmFP.InsertRecord([frmFormaPagto1.cbbFormaPagto.Text ,  edtValorPago.Value]);

     // TITULO_PAGAR_BAIXA_FP
     baixaFP := TTPBaixaFPModel.Create;
     baixaFP.FID := dmConexao.obterNewID;
     baixaFP.FIDorganizacao := pIdOrganizacao;
     baixaFP.FFormaPagamento := formaPagto;
     baixaFP.FValor := edtValorPago.Value; //ver isso
     baixaFP.FIDTPBaixa := baixaModel.FID;

     totalFP := totalFP + baixaFP.FValor;

     baixaModel.AdicionarFP(baixaFP); //coloca esse pagto dentro do model de baixa

    end;

    if idFormaPagto.Equals('INTERNET BANK') then
    begin

     formaPagto := TFormaPagamentoModel.Create;
     formaPagto.FID := idFormaPagto;
     formaPagto.FIDorganizacao := pIdOrganizacao;
     formaPagto := TFormaPagamentoDAO.obterPorID(formaPagto);

     baixaWWW                       := TTPBaixaInternetModel.Create;
     baixaWWW.FIDorganizacao        := pIdOrganizacao;
     baixaWWW.FID                   := dmConexao.obterNewID;
     baixaWWW.Fvalor                := edtValorPago.Value;
     baixaWWW.FIDTPB                := baixaModel.FID;
     baixaWWW.Fdetalhamento         := 'PG TP ' + tituloPagar.FnumeroDocumento ;
     baixaWWW.FIDbancoDestino       := tituloPagar.FCedente.FIDbanco;
     baixaWWW.FcontaDestino         := tituloPagar.FCedente.Fconta;
     baixaWWW.FagenciaDestino       := tituloPagar.FCedente.Fagencia;
     baixaWWW.FnomeCorrentista      := tituloPagar.FCedente.Fnome;
     baixaWWW.Fpersonalidade        := tituloPagar.FCedente.Fpersonalidade;
     baixaWWW.FCPCFCNPJCorrentista  := tituloPagar.FCedente.FcpfCnpj;
     baixaWWW.FdataOperacao         := dtpPagto.DateTime;

      frmBaixaFPInternet := TfrmBaixaFPInternet.Create(Self, baixaWWW);
      frmBaixaFPInternet.ShowModal;
      baixaWWW := frmBaixaFPInternet.getBaixaWWW;

      if baixaWWW.Fvalor > 0 then
      begin
        fdmFP.Open;
        fdmFP.InsertRecord([frmFormaPagto1.cbbFormaPagto.Text, edtValorPago.Value]);
      end;

     // TITULO_PAGAR_BAIXA_FP
     baixaFP := TTPBaixaFPModel.Create;
     baixaFP.FID := dmConexao.obterNewID;
     baixaFP.FIDorganizacao := pIdOrganizacao;
     baixaFP.FFormaPagamento := formaPagto;
     baixaFP.FValor := edtValorPago.Value; //ver isso
     baixaFP.FIDTPBaixa := baixaModel.FID;

     totalFP := totalFP + baixaFP.FValor;

     baixaModel.AdicionarFP(baixaFP); //coloca esse pagto dentro do model de baixa
     baixaModel.FTPBaixaWWW := baixaWWW;

    end;

  //  fdmFP.InsertRecord([frmFormaPagto1.cbbFormaPagto.Text,edtValor.Value]);
//    frmFormaPagto1.cbbFormaPagto.DeleteSelected;
    dbgrdFP.Refresh;
    msgStatusBar(3, formatfloat('R$ ,0.00', (valorDevido)));
    msgStatusBar(3, formatfloat('R$ ,0.00', (obterValorPago)));
    frmFormaPagto1.cbbFormaPagto.ItemIndex := 0;
    edtValorPago.Clear;
    Application.ProcessMessages;

    edtValorPago.Value := ( valorDevido - obterValorPago );

    if obterValorPago = valorDevido then begin

      frmFormaPagto1.cbbFormaPagto.Enabled :=False;
      btnDin.Enabled :=False;
      btnWEB.Enabled :=False;
      btnCheque.Enabled :=False;
      edtValorPago.Enabled :=False;

    end;


     //TPBAIXA
   baixaModel.FvalorPago := totalFP; // ver se est� pegando valor principal + ac + de



 end;

end;

procedure TfrmBaixaFP.btnWEBClick(Sender: TObject);
var
 posicao, I: Integer;
begin
      posicao := 0;

      for I := 0 to FSListaIDFP.Count - 1 do
      begin
        if FSListaIDFP[I].Equals('INTERNET BANK') then
        begin
          posicao := I;
          Break;
        end;
      end;

      frmFormaPagto1.cbbFormaPagto.ItemIndex := posicao;
      btnSelect.Click;
      btnWEB.Enabled := False;


end;

procedure TfrmBaixaFP.cbbTipoPagtoChange(Sender: TObject);
begin


 if cbbTipoPagto.ItemIndex >= 0 then begin

    baixaModel.FTipoBaixa := cbbTipoPagto.Text;

 end;
end;

constructor TfrmBaixaFP.Create(AOwner: TComponent; pTitulo :TTituloPagarModel);
begin
 inherited Create(AOwner);
  createTable;
  pIdOrganizacao := uutil.TOrgAtual.getId;

  tituloPagar := TTituloPagarModel.Create;
  tituloPagar := TTituloPagarDAO.obterPorID(pTitulo);



  if not uUtil.Empty(tituloPagar.FID) then begin

  tituloPagar.FdataUltimaAtualizacao := Now;
  tituloPagar.FdataPagamento := Now;
  tituloPagar.FIDTipoStatus  := 'QUITADO';

   baixaModel                := TTPBaixaModel.Create;

   baixaModel.listaFormasPagto := TObjectList<TTPBaixaFPModel>.Create;
   baixaModel.listaFormasPagto.Clear;

   baixaModel.FID            := dmConexao.obterNewID;
   baixaModel.FIDorganizacao := pIdOrganizacao;
   baixaModel.FTituloPagar   := tituloPagar;
   baixaModel.FIDtituloPagar := tituloPagar.FID;
   baixaModel.FIDCentroCusto := tituloPagar.FIDCentroCusto;
   baixaModel.FIDusuario     := uutil.TUserAtual.getUserId;
   baixaModel.FTipoBaixa     := 'TOTAL';

   preencheForm(tituloPagar);


  end;
  msgStatusBar(1,formatfloat('R$ ,0.00', (tituloPagar.FvalorNominal)));
  edtValorPago.MinValue := 0.1;
  edtValorPago.MaxValue := tituloPagar.FvalorNominal;
  valorDevido := tituloPagar.FvalorNominal ;


  frmFormaPagto1.obterTodos(pIdOrganizacao, frmFormaPagto1.cbbFormaPagto, FSListaIDFP);
  frmFormaPagto1.cbbFormaPagto.Enabled := True;
  frameResponsavel1.obterTodos(pIdOrganizacao, frameResponsavel1.cbbcombo, FSListaIDResp);

  edtValorPago.Value := (valorDevido);


  cbbTipoPagto.ItemIndex := 0;
  totalAC :=0;
  totalFP :=0;
  totalDE :=0;



end;

function  TfrmBaixaFP.obterLoteContabil(pLote : TLoteContabilModel) : TLoteContabilModel;
begin
 lote := TLoteContabilModel.Create;

 lote := TLoteContabilDAO.obterPorMes(pLote);

 Result := lote;

end;

procedure TfrmBaixaFP.preencheForm(pTitulo :TTituloPagarModel);
var
cedente :TCedenteModel;
begin
  cedente := TCedenteModel.Create;
  cedente := dmBaixaTP.obterCedente(pTitulo);

  edtValotTP.Value  := pTitulo.FvalorNominal;
  edtDoc.Text       := pTitulo.FnumeroDocumento;
  edtDescricao.Text := pTitulo.Fdescricao;
  edtVcto.Text      := DateToStr(pTitulo.FdataVencimento);
  edtParcela.Text   := pTitulo.Fparcela;
  edtCedente.Text   := cedente.Fnome;
  edtCNPJ.Text      := cedente.FcpfCnpj;
  dtpPagto.DateTime := Now;


end;


procedure TfrmBaixaFP.createTable;
begin

  if not Assigned(dmBaixaTP) then
  begin
    dmBaixaTP := TdmBaixaTP.Create(Self, pIdOrganizacao);
  end;

    fdmFP.FieldDefs.Add('DESCRICAO', ftString, 60, false);
    fdmFP.FieldDefs.Add('VALOR', ftCurrency, 0, false);
    fdmFP.FieldDefs.Add('ID_FORMA_PAGAMENTO', ftString, 36, false);
    fdmFP.CreateDataSet;


end;


procedure TfrmBaixaFP.dtpPagtoChange(Sender: TObject);
var
  validarData :Integer;
begin

  //se movimento < hoje = -1
  // se movimento > hoje =  1
  validarData := compareDate(dtpPagto.Date, now);

  baixaModel.FdataRegistro := Now;
  tituloPagar.FdataUltimaAtualizacao := Now;
  tituloPagar.FdataPagamento := dtpPagto.Date;
  tituloPagar.FIDTipoStatus  := 'QUITADO';

  if validarData = 1 then
  begin // a data do pagto � maior que a data de hoje

    ShowMessage(' a data do pagamento n�o pode ser maior que a data de hoje...');
    msgStatusBar(1, 'Data pagamento incorreta.');
    dtpPagto.Date := Now;
    dtpPagto.SetFocus;
  end else begin
   atualizaValoPagar;
   msgStatusBar(1, CurrToStr(totalFP));
  end;



end;

procedure TfrmBaixaFP.FormClose(Sender: TObject; var Action: TCloseAction);
begin
 if Assigned(dmBaixaTP) then
  begin
    FreeAndNil(dmBaixaTP);
  end;

 Action := caFree;
end;



procedure TfrmBaixaFP.msgStatusBar(pPosicao : Integer; msg :string);
begin
dxStatusBar.Panels[pPosicao].Text := msg;
Application.ProcessMessages;
end;



procedure TfrmBaixaFP.FormCreate(Sender: TObject);
begin

 pIdOrganizacao := uutil.TOrgAtual.getId;

  if not Assigned(dmBaixaTP) then
  begin
    dmBaixaTP := TdmBaixaTP.Create(Self, pIdOrganizacao);
  end;

  msgStatusBar(0, 'Valor devido ');
  msgStatusBar(2, 'Valor pago ');


  cxpgcntrlFP.ActivePageIndex :=0;

  tbTransfereFP.Enabled := False;

totalAC :=0;
totalFP :=0;
totalDE :=0;

dtpPagto.DateTime := Now;

end;

procedure TfrmBaixaFP.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  case key of
    VK_F6  : btnDin.Click;
    VK_F7  : btnCheque.Click;
    VK_F8  : btnWEB.Click;
    VK_F10 : btnPagamento.Click;

  end;
end;

procedure TfrmBaixaFP.frameResponsavel1cbbcomboChange(Sender: TObject);
begin
 if frameResponsavel1.cbbcombo.ItemIndex >0 then begin
    baixaModel.FIDResponsavel := FSListaIDResp[frameResponsavel1.cbbcombo.ItemIndex];
     tbTransfereFP.Enabled := True;
 end;



end;


function TfrmBaixaFP.obterValorPago: Currency;
var
total :Currency;
  I: Integer;
begin
 total :=0;
 fdmFP.Open;
 fdmFP.First;
 while not fdmFP.Eof do begin

 total := total + fdmFP.FieldByName('VALOR').AsCurrency;

 fdmFP.Next;
 end;


  Result := total;

end;

procedure TfrmBaixaFP.removeFP(pIndice: Integer);
begin
if pIndice >0 then begin

     frmFormaPagto1.cbbFormaPagto.DeleteSelected ;

 end;

end;

procedure TfrmBaixaFP.tbTransfereFPShow(Sender: TObject);
begin
 atualizaValoPagar;

end;

procedure TfrmBaixaFP.atualizaValoPagar;
begin

edtValorPago.Value := valorDevido + totalAC + totalDE;

end;

procedure TfrmBaixaFP.validarValor;
begin
  btnSelect.Enabled := False;
  frmFormaPagto1.Enabled := False;
  edtValorPago.Enabled := False;

  if obterValorPago < valorDevido then
  begin

    btnSelect.Enabled := True;
    frmFormaPagto1.Enabled := True;
    edtValorPago.Enabled := True;
  end;

end;


procedure TfrmBaixaFP.limpar;
begin
     totalFP :=0;
     totalAC :=0;
     totalDE :=0;

   baixaModel.listaFormasPagto.Clear;

    tbTransfereAC.Enabled := True;
    tbTransfereDE.Enabled := True;

  fdmFP.Open;
  fdmFP.First;
  while not fdmFP.Eof do
  begin
    fdmFP.Delete;
    fdmFP.Next;
  end;

  dbgrdFP.DataSource.DataSet.Close;
  dbgrdFP.Refresh;
  btnDin.Enabled := True;
  btnCheque.Enabled := True;
  btnWEB.Enabled := True;
  msgStatusBar(3, '0');
  frmFormaPagto1.obterTodos(pIdOrganizacao, frmFormaPagto1.cbbFormaPagto, FSListaIDFP);
  frmFormaPagto1.cbbFormaPagto.Enabled := True;
  frameResponsavel1.obterTodos(pIdOrganizacao, frameResponsavel1.cbbcombo, FSListaIDResp);

  edtValorPago.Value := (valorDevido);
  msgStatusBar(0, 'Valor devido ');
  msgStatusBar(2, 'Valor pago ');

  cbbTipoPagto.ItemIndex := 0;

  Application.ProcessMessages;
  validarValor;

end;



procedure TfrmBaixaFP.limparForm;
var
 i: Integer;
begin


  for i := 0 to Self.ComponentCount - 1 do
  begin
    if Components[i] is TCustomEdit then
    begin
         (Components[i] as TCustomEdit).Clear;
    end;

    if Components[i] is TEdit then
    begin
         TEdit(Components[i]).Clear;
    end;

     if Components[i] is TComboBox then
    begin
       TComboBox(Components[i]).ItemIndex := 0;
    end;

   end;


end;

procedure TfrmBaixaFP.limparAba(aba :TcxTabSheet );
var
 j, i: Integer;
begin
 // limpa os componentes da aba q chegou

  for i := 0 to Self.ComponentCount - 1 do
  begin
    if Components[i] is TCustomEdit then
    begin
       if TCustomEdit(Components[i]).Parent = aba then
         (Components[i] as TCustomEdit).Clear;
    end;

    if Components[i] is TEdit then
    begin
      if TEdit(Components[i]).Parent = aba then
         TEdit(Components[i]).Clear;
    end;

     if Components[i] is TComboBox then
    begin
       TComboBox(Components[i]).ItemIndex := 0;
    if TComboBox(Components[i]).Parent = aba then
      // TComboBox(Components[i]).Clear;
      TComboBox(Components[i]).ItemIndex := 0;
    end;

   end;


end;

function TfrmBaixaFP.baixarTitulo( pBaixa :TTPBaixaModel) : Boolean;
var
qtdFP :Integer;
 begin
 dmConexao.conectarBanco;
  qtdFP :=0; //indica apenas a quantidade de formas de pagamentos do tp
  qtdFP := pBaixa.listaFormasPagto.Count ;


  try
    dmConexao.conn.StartTransaction;

    //falta list a de AC e lista de DE


    { baixa de TP pago em cheque
    1 - altera o TP (DATA_ULTIMA_ATUALIZACAO, DATA_PAGAMENTO)
    2 - salva o TPB
    3 - salva o TPB_FP
    4 - salva o TPB_Cheque
    5 - altera o cheque ( ID_TIPO_STATUS, VALOR, DATA_EMISSAO, OBSERVACAO,PORTADOR,  DATA_PREVISAO_COMPENSACAO, QTD_IMPRESSAO )
    6 - salvar CBD
    }

    if not uutil.Empty(pBaixa.FTPBaixaCheque.FID) then begin //o TP tem  pagto em cheque

       TTPBaixaDAO.salvarBaixa(pBaixa, tituloPagar);

        Inc(qtdFP);

    end;





    dmConexao.conn.CommitRetaining;

  except
    Result := False;
    dmConexao.conn.RollbackRetaining;

    raise Exception.Create('Erro ao tentar baixar o titulo : ' + pBaixa.FTituloPagar.FnumeroDocumento);

  end;

    Result := True;

 end;



end.