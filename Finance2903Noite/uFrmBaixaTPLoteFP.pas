unit uFrmBaixaTPLoteFP;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics, System.DateUtils,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, ENumEd, uUtil, Data.DB,udmConexao,uFrmBaixaFPInternet,uTPBaixaInternetModel,
  cxGraphics, cxControls, cxLookAndFeels, cxLookAndFeelPainters, dxSkinsCore, uTPBaixaFPModel, uFormaPagamentoDAO,
  dxSkinsDefaultPainters, FireDAC.Stan.Intf, FireDAC.Stan.Option, uContaBancariaChequeModel,uFrmBaixaFPCheque,   FireDAC.Stan.Param, FireDAC.Stan.Error, FireDAC.DatS, FireDAC.Phys.Intf,uCedenteModel,
  FireDAC.DApt.Intf, FireDAC.Comp.DataSet, FireDAC.Comp.Client, dxStatusBar, uTituloPagarModel,uTituloPagarDAO,  uFormaPagamentoModel,
  Vcl.Grids, Vcl.DBGrids, uFrameFormaPagamento, Vcl.ComCtrls, uFrameGeneric, uTPBaixaDAO, uTPBaixaModel,uTPBaixaChequeModel,
  uFrameResponsavel, dxBarBuiltInMenu,System.Generics.Collections, cxPC, uLotePagamentoModel, uLotePagamentoDAO,
   uTituloPagarHistoricoDAO,  FireDAC.Stan.Async,
  FireDAC.DApt, uFrameTipoDeducao, EMsgDlg, Vcl.Buttons, MDDAO ;

type
    TfrmBaixaTPLoteFP = class(TForm)
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
    edtValorLote: TEvNumEdit;
    lbl7: TLabel;
    dtpPagto: TDateTimePicker;
    lbl10: TLabel;
    frameResponsavel1: TframeResponsavel;
    cxpgcntrlFP: TcxPageControl;
    tbTransfereFP: TcxTabSheet;
    btnPagamento: TButton;
    PempecMsg: TEvMsgDlg;
    dbgridMain: TDBGrid;
    dtTitulos: TDataSource;
    FDQuery1: TFDQuery;
    btnGerarLote: TBitBtn;
    edtLotePagamento: TEdit;
    Label1: TLabel;
    procedure FormCreate(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure btnSelectClick(Sender: TObject);
    procedure btnDinClick(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure btnChequeClick(Sender: TObject);
    procedure btnWEBClick(Sender: TObject);
    procedure btnLimparClick(Sender: TObject);
    procedure btnCancelarClick(Sender: TObject);
    procedure frameResponsavel1cbbcomboChange(Sender: TObject);
    procedure tbTransfereFPShow(Sender: TObject);
    procedure btnPagamentoClick(Sender: TObject);
    procedure dbgridMainTitleClick(Column: TColumn);
    procedure btnGerarLoteClick(Sender: TObject);
  private
    { Private declarations }
    baixaModel  :TTPBaixaModel;
    FSListaIDResp, FSListaIDFP :TStringList;
    FSListaIDTAC, FSListaIDTDE :TStringList;
    pIdOrganizacao :string;
    valorDevido :Currency;
    totalFP, totalAC, totalDE : Currency;
    //FListaFormasPagto: TObjectList<TTPBaixaFPModel>;
    lote : TLotePagamentoModel;
    msg :string;
    procedure createTable;
    procedure removeFP(pIndice :Integer);
    function  obterValorPago: Currency;
    procedure validarValor;
    procedure msgStatusBar(pPosicao: Integer; msg: string);
    procedure limpar;
    procedure limparForm;
    procedure preencheForm(var pTP :TTituloPagarModel);
    procedure limparAba(aba: TcxTabSheet);
    procedure atualizaValorPagar(var table : TFDMemTable) ;
    function baixarTitulo(pBaixa: TTPBaixaModel): Boolean;
  //  function  obterLoteContabil(pLote : TLoteContabilModel) : TLoteContabilModel;
    procedure carregarCombos;
    procedure insertClone(clone: TTituloPagarModel);
    procedure preencheGridMain(var pTable: TFDMemTable);
    function validarDadosLote: Boolean;
    procedure registraMovimentacao(pOrg, pTable, pAcao, pDsc, pStatus: string);

  public
    { Public declarations }
  constructor Create (AOwner :TComponent; table :TFDMemTable);

  end;

var
  frmBaixaTPLoteFP :TfrmBaixaTPLoteFP ;

implementation

{$R *.dfm}

{ TfrmBaixaTPLoteFP }

procedure TfrmBaixaTPLoteFP.btnCancelarClick(Sender: TObject);
var
isFecha : Boolean;
begin

  btnGerarLote.Enabled :=True;
  isFecha := True;

 if isFecha then begin
      btnLimpar.Click;
      PostMessage(Self.Handle, WM_CLOSE, 0, 0);
 end;

end;

procedure TfrmBaixaTPLoteFP.btnChequeClick(Sender: TObject);
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

      frmFormaPagto1.cbbcombo.ItemIndex := posicao;
      btnSelect.Click;
      btnCheque.Enabled := False;

end;

procedure TfrmBaixaTPLoteFP.btnDinClick(Sender: TObject);
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

      frmFormaPagto1.cbbcombo.ItemIndex := posicao;
      btnSelect.Click;
      btnDin.Enabled := False;

end;

function TfrmBaixaTPLoteFP.validarDadosLote :Boolean ;
var
valido : Boolean;
begin
  valido := True;
    if dtpPagto.Date > Now then begin
     valido := False;
     PempecMsg.MsgWarning('A data de pagamento n�o pode ser maior que a data de hoje.');
    end;

    if frameResponsavel1.cbbcombo.ItemIndex < 1 then begin
     valido := False;
     PempecMsg.MsgWarning('Selecione um respons�vel pelo pagto em lote.');
    end;

    if edtValorLote.Value < 1 then begin
     valido := False;
     PempecMsg.MsgWarning('O valor do lote est� incorreto. ');
    end;



 Result := valido;
end;

procedure TfrmBaixaTPLoteFP.btnGerarLoteClick(Sender: TObject);

begin
 if validarDadosLote then begin

       lote                 := TLotePagamentoModel.Create;
       lote.Fnovo           := True;
       lote.FIDorganizacao  := pIdOrganizacao;
       lote.FID             := dmConexao.obterNewID;
       lote.FIDresponsavel  := baixaModel.FIDResponsavel;
       lote.FIDusuario      := baixaModel.FIDusuario;
       lote.FdataRegistro   := Now;
       lote.FdataPagamento  := dtpPagto.Date;
       lote.Fvalor          := edtValorLote.Value;
       lote.FqtdTitPag      := (dbgridMain.DataSource.DataSet as TFDMemTable).RecordCount;
       lote.Fstatus         := 'LOTE-PAGO';
       lote.Flote           := dmConexao.obterIdentificador('',pIdOrganizacao,'LOTE_PG');
       edtLotePagamento.Text := lote.Flote;

       baixaModel.FIDlotePagamento := lote.FID;

       btnGerarLote.Enabled := False;


  tbTransfereFP.Enabled := True;


 end;

end;

procedure TfrmBaixaTPLoteFP.btnLimparClick(Sender: TObject);
begin
 limpar;

end;

procedure TfrmBaixaTPLoteFP.btnPagamentoClick(Sender: TObject);
var
sucesso : Boolean;
tituloPagar :TTituloPagarModel;
 begin
 sucesso := True;

  try

    if baixaModel.FvalorPago <> valorDevido then
    begin
     sucesso := False;
       msg :='Valor pago est� diferente do valor devido. Por favor, verifique!';
       PempecMsg.MsgInformation(msg);
    end;


    if (dbgridMain.DataSource.DataSet as TFDMemTable).RecordCount >0 then begin //tem titulos a pagar
      if (dbgrdFP.DataSource.DataSet as TFDMemTable).RecordCount > 0 then
      begin   //foram selecionadas formas de pagamento


        if not dmConexao.conn.InTransaction then
          dmConexao.conn.StartTransaction;

        try
           //salvar o lote
          sucesso := TLotePagamentoDAO.Insert(lote);


          if sucesso then
          begin

            (dbgridMain.DataSource.DataSet as TFDMemTable).First;
            while not (dbgridMain.DataSource.DataSet as TFDMemTable).Eof do
            begin

              tituloPagar := TTituloPagarModel.Create;
              tituloPagar.FIDorganizacao := pIdOrganizacao;
              tituloPagar.FID := (dbgridMain.DataSource.DataSet as TFDMemTable).FieldByName('ID_TITULO_PAGAR').AsString;
              tituloPagar := TTituloPagarDAO.obterPorID(tituloPagar);

              if not uutil.Empty(tituloPagar.FID) then
              begin

                tituloPagar.FIDTipoStatus := 'QUITADO';
                tituloPagar.Fobservacao := 'LOTE ' + lote.Flote;
                tituloPagar.FIDLotePagamento := lote.FID;
                tituloPagar.FdataUltimaAtualizacao := Now;
                tituloPagar.FdataPagamento := lote.FdataPagamento;
                baixaModel.FIDtituloPagar := tituloPagar.FID;
                baixaModel.FIDCentroCusto := tituloPagar.FIDCentroCusto;
                baixaModel.FvalorPago := tituloPagar.FvalorNominal;


                baixaModel.FID := dmConexao.obterNewID;

                if Assigned(baixaModel.FTPBaixaCheque) then
                begin
                  baixaModel.FTPBaixaCheque.FIDTPBaixa := baixaModel.FID;
                end;

                if Assigned(baixaModel.FTPBaixaWWW) then
                begin
                  baixaModel.FTPBaixaWWW.FIDTPB := baixaModel.FID;
                end;

                TTPBaixaDAO.salvarBaixa(baixaModel, tituloPagar);

                registraMovimentacao(pIDOrganizacao, 'TITULO_PAGAR', 'PAGTO LOTE TP', uutil.TUserAtual.getNameUser + ' pagou o LOTE TP ' + lote.Flote, lote.Fstatus);


              end;

              (dbgridMain.DataSource.DataSet as TFDMemTable).Next;
            end;

          end;



     // a baixa tem todas as formas de pagamento
     //  baixaModel.listaFormasPagto

          if dmConexao.conn.InTransaction then
            dmConexao.conn.CommitRetaining;
        except
          if dmConexao.conn.InTransaction then
            dmConexao.conn.RollbackRetaining;

        end;




     end;
    end;


    {

    if TTPBaixaDAO.salvarBaixa(baixaModel, tituloPagar) then
    begin
      msg :='Pagamento em lote efetuado com sucesso!';
      PempecMsg.MsgInformation(msg);

      btnLimpar.Click;
      PostMessage(Self.Handle, WM_CLOSE, 0, 0);

    end;   }

  except
    on e: Exception do
      ShowMessage(e.Message + sLineBreak + 'Contate o administrador!');
  end;

end;

///



procedure TfrmBaixaTPLoteFP.insertClone(clone :TTituloPagarModel);
begin
 dmConexao.conectarBanco;


  try

  dmConexao.conn.StartTransaction ;    //insetir o tp

      TTituloPagarDAO.Insert(clone);

  dmConexao.conn.CommitRetaining;
  except
  raise Exception.Create('Erro ao tentar clonar um titulo ');

  end;

end;

procedure TfrmBaixaTPLoteFP.btnSelectClick(Sender: TObject);
var
chequePagto :TContaBancariaChequeModel;
idFormaPagto :string;
baixaCheque  : TTPBaixaChequeModel;
baixaWWW      :TTPBaixaInternetModel;
baixaFP      : TTPBaixaFPModel;
formaPagto   : TFormaPagamentoModel;

begin

 if frmFormaPagto1.cbbcombo.ItemIndex > 0 then begin
    idFormaPagto := FSListaIDFP[frmFormaPagto1.cbbcombo.ItemIndex];
    if idFormaPagto.Equals('CHEQUE') then
    begin

     formaPagto := TFormaPagamentoModel.Create;
     formaPagto.FID := idFormaPagto;
     formaPagto.FIDorganizacao := pIdOrganizacao;
     formaPagto := TFormaPagamentoDAO.obterPorID(formaPagto);

      chequePagto                 := TContaBancariaChequeModel.Create;
      chequePagto.FIdOrganizacao  := pIdOrganizacao;
      chequePagto.FValor          := edtValorPago.Value;
      chequePagto.FIDresponsavel  := baixaModel.FIDResponsavel;
      chequePagto.Fportador       := uutil.TOrgAtual.getRazaoSocial;

      frmBaixaFPCheque := TfrmBaixaFPCheque.Create(Self, chequePagto);
      frmBaixaFPCheque.ShowModal;
      chequePagto := frmBaixaFPCheque.getCheque;
      FreeAndNil(frmBaixaFPCheque);

      if chequePagto.Fvalor > 0 then
      begin
        lote.FIDcheque := chequePagto.FID;
        lote.FIDcontaBancaria := chequePagto.FIDcontaBancaria;
        lote.FIDTOB := 'PAGTO EM CHEQUE';
        fdmFP.Open;
        fdmFP.InsertRecord([frmFormaPagto1.cbbcombo.Text + ' ' + chequePagto.FNumero, edtValorPago.Value]);
      end;

      // TITULO_PAGAR_BAIXA_CHEQUE
      baixaCheque                := TTPBaixaChequeModel.Create;
      baixaCheque.FID            := dmConexao.obterNewID;
      baixaCheque.FIDorganizacao := pIdOrganizacao;
      baixaCheque.FIDTOB         := lote.FIDTOB;
      baixaCheque.FIDTPBaixa     := baixaModel.FID;
      baixaCheque.FCheque        := chequePagto;
      baixaCheque.Fvalor         := chequePagto.FValor;
      baixaCheque.FIDCheque      := chequePagto.FID;
      baixaCheque.Fobservacao    := 'Lote ' + lote.Flote;


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
      fdmFP.InsertRecord([frmFormaPagto1.cbbcombo.Text ,  edtValorPago.Value]);

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
     baixaWWW.Fdetalhamento         := 'LOTE TP ' + lote.Flote;
     baixaWWW.FdataOperacao         := dtpPagto.DateTime;

      frmBaixaFPInternet := TfrmBaixaFPInternet.Create(Self, baixaWWW);
      frmBaixaFPInternet.ShowModal;
      baixaWWW := frmBaixaFPInternet.getBaixaWWW;
      lote.FIDcontaBancaria := baixaWWW.FIDcontaBancariaOrigem;
      lote.FIDTOB := baixaWWW.FIDTOB;


      FreeAndNil(frmBaixaFPInternet);

      if baixaWWW.Fvalor > 0 then
      begin
        fdmFP.Open;
        fdmFP.InsertRecord([frmFormaPagto1.cbbcombo.Text, edtValorPago.Value]);
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

  //  fdmFP.InsertRecord([frmFormaPagto1.cbbcombo.Text,edtValor.Value]);
//    frmFormaPagto1.cbbcombo.DeleteSelected;

   lote.FIDformaPagamento := formaPagto.FID; //s� permite uma forma de pagamento

    dbgrdFP.Refresh;
    msgStatusBar(3, formatfloat('R$ ,0.00', (valorDevido)));
    msgStatusBar(3, formatfloat('R$ ,0.00', (obterValorPago)));
    frmFormaPagto1.cbbcombo.ItemIndex := 0;
    edtValorPago.Clear;
    Application.ProcessMessages;

    edtValorPago.Value := ( valorDevido - obterValorPago );

    if obterValorPago = valorDevido then begin

      frmFormaPagto1.cbbcombo.Enabled :=False;
      btnDin.Enabled :=False;
      btnWEB.Enabled :=False;
      btnCheque.Enabled :=False;
      edtValorPago.Enabled :=False;

    end;

     //TPBAIXA
   baixaModel.FvalorPago := totalFP;

 end;

end;



procedure TfrmBaixaTPLoteFP.btnWEBClick(Sender: TObject);
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

      frmFormaPagto1.cbbcombo.ItemIndex := posicao;
      btnSelect.Click;
      btnWEB.Enabled := False;


end;

constructor TfrmBaixaTPLoteFP.Create (AOwner :TComponent; table :TFDMemTable);
begin

 inherited Create(AOwner);
  createTable;

  pIdOrganizacao := uutil.TOrgAtual.getId;

  carregarCombos;


   //tem que ser o lote e nao a baixa de um titulo

    preencheGridMain(table);

   baixaModel                   := TTPBaixaModel.Create;
   baixaModel.listaFormasPagto  := TObjectList<TTPBaixaFPModel>.Create;
   baixaModel.listaFormasPagto.Clear;

   baixaModel.FID            := dmConexao.obterNewID;
   baixaModel.FIDorganizacao := pIdOrganizacao;
   baixaModel.FIDusuario     := uutil.TUserAtual.userID;
   baixaModel.FTipoBaixa     := 'TOTAL';


  totalFP :=0;


end;


procedure TfrmBaixaTPLoteFP.preencheGridMain(var pTable :TFDMemTable);
begin


  dbgridMain.DataSource.DataSet := pTable;
  dbgridMain.Refresh;
  atualizaValorPagar(pTable);

end;


procedure TfrmBaixaTPLoteFP.preencheForm(var pTP :TTituloPagarModel);
var
qtdDateio : Integer;
begin
  qtdDateio := 0;

 {

  edtValotTP.Value  := pTP.FvalorNominal;
  edtDoc.Text       := pTP.FnumeroDocumento;
  edtDescricao.Text := pTP.Fdescricao;
  edtVcto.Text      := DateToStr(pTP.FdataVencimento);
  edtParcela.Text   := pTP.Fparcela;
  edtCedente.Text   := cedente.Fnome;
  edtCNPJ.Text      := cedente.FcpfCnpj;  }
  dtpPagto.DateTime := pTP.FdataPagamento;

  qtdDateio :=  pTP.listaHistorico.Count;

  if qtdDateio = 1  then begin
    qtdDateio :=  pTP.listaCustos.Count;
  end;



end;


procedure TfrmBaixaTPLoteFP.createTable;
begin
    fdmFP.FieldDefs.Add('DESCRICAO', ftString, 60, false);
    fdmFP.FieldDefs.Add('VALOR', ftCurrency, 0, false);
    fdmFP.FieldDefs.Add('ID_FORMA_PAGAMENTO', ftString, 36, false);
    fdmFP.CreateDataSet;

end;


procedure TfrmBaixaTPLoteFP.dbgridMainTitleClick(Column: TColumn);
begin
   (dbgridMain.DataSource.DataSet as TFDQuery).IndexFieldNames :=Column.FieldName;
end;

procedure TfrmBaixaTPLoteFP.FormClose(Sender: TObject; var Action: TCloseAction);
begin

 Action := caFree;
end;


procedure TfrmBaixaTPLoteFP.msgStatusBar(pPosicao : Integer; msg :string);
begin
dxStatusBar.Panels[pPosicao].Text := msg;
Application.ProcessMessages;
end;


procedure TfrmBaixaTPLoteFP.FormCreate(Sender: TObject);
begin
  pIdOrganizacao := uutil.TOrgAtual.getId;

  msgStatusBar(0, 'Valor devido ');
  msgStatusBar(2, 'Valor pago ');

  cxpgcntrlFP.ActivePageIndex := 0;

  tbTransfereFP.Enabled := False;
  totalFP := 0;

  dtpPagto.DateTime := Now;

end;

procedure TfrmBaixaTPLoteFP.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  case key of
    VK_F6  : btnDin.Click;
    VK_F7  : btnCheque.Click;
    VK_F8  : btnWEB.Click;
    VK_F10 : btnPagamento.Click;

  end;
end;

procedure TfrmBaixaTPLoteFP.frameResponsavel1cbbcomboChange(Sender: TObject);
begin
 if frameResponsavel1.cbbcombo.ItemIndex >0 then begin
     baixaModel.FIDResponsavel := FSListaIDResp[frameResponsavel1.cbbcombo.ItemIndex];

 end;
end;


function TfrmBaixaTPLoteFP.obterValorPago: Currency;
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

procedure TfrmBaixaTPLoteFP.removeFP(pIndice: Integer);
begin
if pIndice >0 then begin
     frmFormaPagto1.cbbcombo.DeleteSelected ;
 end;

end;

procedure TfrmBaixaTPLoteFP.tbTransfereFPShow(Sender: TObject);
begin
   msgStatusBar(2, 'Valor pago ');
   msgStatusBar(3, '0');
end;


procedure TfrmBaixaTPLoteFP.atualizaValorPagar(var table: TFDMemTable);
var
  total: Currency;
  I: Integer;
begin
  total := 0;
  table.Open;
  table.First;
  while not table.Eof do
  begin
    total := total + table.FieldByName('VALOR_NOMINAL').AsCurrency;
    table.Next;
  end;

  edtValorLote.Value := total;
  edtValorPago.Value := total;
  valorDevido := total;
  msgStatusBar(1, formatfloat('R$ ,0.00', (valorDevido)));
  Application.ProcessMessages;



end;

procedure TfrmBaixaTPLoteFP.validarValor;
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


procedure TfrmBaixaTPLoteFP.carregarCombos;
begin

  frmFormaPagto1.obterTodos(pIdOrganizacao, frmFormaPagto1.cbbcombo, FSListaIDFP);
  frmFormaPagto1.cbbcombo.Enabled := True;

  frameResponsavel1.obterTodosAtivos(pIdOrganizacao, frameResponsavel1.cbbcombo, FSListaIDResp);


end;


procedure TfrmBaixaTPLoteFP.limpar;
begin
     totalFP :=0;
     totalAC :=0;
     totalDE :=0;

   baixaModel.listaFormasPagto.Clear;


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
  carregarCombos;

  edtValorPago.Value := valorDevido;
  msgStatusBar(0, 'Valor devido ');
  msgStatusBar(2, 'Valor pago ');

  Application.ProcessMessages;
  validarValor;

end;

procedure TfrmBaixaTPLoteFP.limparForm;
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

procedure TfrmBaixaTPLoteFP.limparAba(aba :TcxTabSheet );
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

function TfrmBaixaTPLoteFP.baixarTitulo( pBaixa :TTPBaixaModel) : Boolean;
var
qtdFP :Integer;
 begin
 dmConexao.conectarBanco;
  qtdFP :=0; //indica apenas a quantidade de formas de pagamentos do tp
  qtdFP := pBaixa.listaFormasPagto.Count ;


  try
    dmConexao.conn.StartTransaction;

         {
    if not uutil.Empty(pBaixa.FTPBaixaCheque.FID) then begin //o TP tem  pagto em cheque

       TTPBaixaDAO.salvarBaixa(pBaixa, tituloPagar);

        Inc(qtdFP);

    end;

            }



    dmConexao.conn.CommitRetaining;

  except
    Result := False;
    dmConexao.conn.RollbackRetaining;

    raise Exception.Create('Erro ao tentar baixar o titulo : ' + pBaixa.FTituloPagar.FnumeroDocumento);

  end;

    Result := True;

 end;



procedure TfrmBaixaTPLoteFP.registraMovimentacao(pOrg, pTable, pAcao, pDsc, pStatus: string);
begin
  TMDDAO.registroMD(pOrg, pTable, pAcao, pDsc, pStatus);

end;



end.
