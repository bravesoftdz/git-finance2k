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
  dxBarBuiltInMenu, cxPC, uFrameTP, Vcl.StdCtrls, uFrameCentroCusto, uTituloPagarHistoricoDAO,
  uFrameGeneric, uFrameHistorico, uFrameCedente, uFrameLocalPagamento,  uFrmEspelhoTP,uFrmBaixaFP, uFrmReciboTP,
  uFrameTipoCobranca, uFrameResponsavel, Vcl.Buttons, ENumEd, Vcl.ComCtrls,uTituloPagarHistoricoModel,
  uTituloPagarCentroCustoModel, uTituloPagarCentroCustoDAO, uNotaFiscalEntradaModel, uNotaFiscalEntradaDAO,
  Data.DB, Vcl.Grids, Vcl.DBGrids, FireDAC.Stan.Intf, FireDAC.Stan.Option,
  FireDAC.Stan.Param, FireDAC.Stan.Error, FireDAC.DatS, FireDAC.Phys.Intf,
  FireDAC.DApt.Intf, FireDAC.Stan.Async, FireDAC.DApt, FireDAC.Comp.DataSet, uFrmTituloPagarParcelado,
  FireDAC.Comp.Client, uFrameTipoNotaFiscal;

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
    gridRateioHist: TDBGrid;
    dbgridHistorico: TDBGrid;
    dsHistorico: TDataSource;
    qryPreencheGridHistorico: TFDQuery;
    frameHistorico2: TframeHistorico;
    fdmHistorico: TFDMemTable;
    dsFdmHistorico: TDataSource;
    btnLimparRateioHist: TButton;
    btnSelectTHST: TButton;
    edtValorRateioHist: TEvNumEdit;
    EdtTotalRateioHist: TEvNumEdit;
    Label16: TLabel;
    edtValorTP: TEvNumEdit;
    Label17: TLabel;
    edtDifHistorico: TEvNumEdit;
    Label18: TLabel;
    frameCentroCusto2: TframeCentroCusto;
    edtValorRateioCC: TEvNumEdit;
    btnSelectTCC: TButton;
    gridRateioCC: TDBGrid;
    dbgridCC: TDBGrid;
    dsCentroCusto: TDataSource;
    fdmCentroCusto: TFDMemTable;
    qryPreencheGridCentroC: TFDQuery;
    Label19: TLabel;
    edtValorTPCC: TEvNumEdit;
    Label20: TLabel;
    edtTotalRateioCC: TEvNumEdit;
    Label21: TLabel;
    edtDifRateioCC: TEvNumEdit;
    btnLimparRateioCC: TButton;
    dsFdmCC: TDataSource;
    Label22: TLabel;
    dtPrevisaoCartorio: TDateTimePicker;
    Label23: TLabel;
    edtUltimoUpdate: TEdit;
    edtCodigoBarras: TEdit;
    Label24: TLabel;
    edtCarteira: TEdit;
    edtContrato: TEdit;
    Label25: TLabel;
    Label26: TLabel;
    Label27: TLabel;
    edtObervacao: TEdit;
    frmTipoNF1: TfrmTipoNF;
    edtValorNF: TEvNumEdit;
    edtValorISS: TEvNumEdit;
    edtBaseCalculo: TEvNumEdit;
    dtNFEmissao: TDateTimePicker;
    dtNFProtocolo: TDateTimePicker;
    dtNFRetencaoISS: TDateTimePicker;
    edtNFObservacao: TEdit;
    edtNFNumero: TEdit;
    edtNFDescricao: TEdit;
    edtNFAliquotaISS: TEdit;
    edtNFSerie: TEdit;
    edtNFSubSerie: TEdit;
    Label28: TLabel;
    Label29: TLabel;
    Label30: TLabel;
    Label31: TLabel;
    Label32: TLabel;
    Label33: TLabel;
    Label34: TLabel;
    Label35: TLabel;
    Label36: TLabel;
    Label37: TLabel;
    Label38: TLabel;
    Label39: TLabel;
    Label40: TLabel;
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
    procedure dxBtnEspelhoClick(Sender: TObject);
    procedure dxBtnPagarClick(Sender: TObject);
    procedure dxBtnReciboClick(Sender: TObject);
    procedure btnLimparRateioHistClick(Sender: TObject);
    procedure btnSelectTHSTClick(Sender: TObject);
    procedure tbRateioHistoricosShow(Sender: TObject);
    procedure edtValorRateioHistChange(Sender: TObject);
    procedure edtValorChange(Sender: TObject);
    procedure frameHistorico2cbbcomboChange(Sender: TObject);
    procedure btnSelectTCCClick(Sender: TObject);
    procedure tbRateioCentroCustoShow(Sender: TObject);
    procedure btnLimparRateioCCClick(Sender: TObject);
    procedure edtValorRateioCCChange(Sender: TObject);
    procedure dtPagamentoChange(Sender: TObject);
    procedure edtCarteiraChange(Sender: TObject);
    procedure tbComplementoExit(Sender: TObject);
    procedure frmTipoNF1cbbTipoNFChange(Sender: TObject);
    procedure tbNotaFiscalExit(Sender: TObject);
    procedure dxBtnSaveClick(Sender: TObject);
  private
    { Private declarations }
   pIDNotaFiscal, pIDTipoNotaFiscal, pIDorganizacao :string;
    pIDusuario :string;
    FRateioHistorico: TObjectList<TTituloPagarHistoricoModel>;
    FRateioCustos: TObjectList<TTituloPagarCentroCustoModel>;

    tituloPagarModel  : TTituloPagarModel;
    tituloSelecionado : TTituloPagarModel; //titulo que veio da consulta
    cedenteModel      : TCedenteModel;
    historicoModel    : THistoricoModel;
    centroCustoModel  : TCentroCustoModel;
    responsavelModel  : TFuncionarioModel;
    statusModel       : TTipoStatusModel;
    modo :Integer;

    FSlistaTipoCobranca,    FSlistaIdContaContabil, FSlistaResponsavel, FSlistaLocalPagamento : TStringList;
    FSlistaCentroCusto, FSlistaTipoNF, FSlistaHistorico, FSlistaTitulos, FSlistaCedente  : TStringList;


    procedure limparPanel;
    procedure msgStatusBar(pPosicao: Integer; msg: string);
    procedure limpaStatusBar;
    procedure carregarCombos(titulo :TTituloPagarModel) ;
    function obterLoteContabil (value :TLoteContabilModel) : TLoteContabilModel;
    function obterLotePagamento (value :TLotePagamentoModel) : TLotePagamentoModel;
    function obterIndiceLista(pId :string; lista :TStringList) : Integer;
    procedure popularCedente(cedente: TCedenteModel);
    procedure popularHistorico(historico: THistoricoModel);
    procedure popularCentroCusto(centroCusto: TCentroCustoModel);
    procedure popularResponsavel(responsavel: TFuncionarioModel);
    procedure popularStatus(status: TTipoStatusModel);
    procedure preencheGridHistorico;
    procedure preencheGridCedntroC;

    procedure createTable;
    function obterValorRateioHistorico: Currency;
    procedure limpaRateioHistorico;
    function atualizarRateio(pTipo: string): Currency;
    procedure preencheAbaRateioHistorico(      listaH: TObjectList<TTituloPagarHistoricoModel>);
    procedure preencheAbaBasica(titulo: TTituloPagarModel);
    procedure preencheAbaRateioCC(listaCC: TObjectList<TTituloPagarCentroCustoModel>);
    function obterValorRateioCC: Currency;
    procedure limpaRateioCC;
    procedure StatusBotoes(value: Integer);
    procedure preencheDatas(titulo: TTituloPagarModel);
    procedure preencheAbaComplementar(titulo: TTituloPagarModel);
    procedure preencheAbaNotaFiscal(nota: TNotaFiscalEntradaModel);


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
dtVenctoCartaoCredito : TDateTime;
begin
    StatusBotoes(0);

   if modo > 0 then begin  //0 consulta - 1 ou mais titulo novo

   dxBtnSave.Enabled :=True;
   dxBtnNew.Enabled :=True;
   dxBtnPagar.Enabled :=True;

    nDOC := dmConexao.obterIdentificador(pIDorganizacao, 'TP');

    tituloPagarModel := TTituloPagarModel.Create;
    tituloPagarModel.FIDorganizacao := pIDorganizacao;
    tituloPagarModel.FID := dmConexao.obterNewID;
    tituloPagarModel.FnumeroDocumento := nDOC;
    tituloPagarModel.FIDTipoStatus := 'ABERTO';
    tituloPagarModel.listaHistorico := TObjectList<TTituloPagarHistoricoModel>.Create;
    tituloPagarModel.listaCustos := TObjectList<TTituloPagarCentroCustoModel>.Create;
    tituloPagarModel.listaHistorico.Clear;
    tituloPagarModel.listaCustos.Clear;
    tituloPagarModel.Fparcela := '1';
    frameTP1.cbbTP.Items.Add(nDOC);
    FSlistaTitulos.Add(tituloPagarModel.FID);
    frameTP1.cbbTP.ItemIndex := obterIndiceLista(tituloPagarModel.FID, FSlistaTitulos);

    edtStatus.Text                              := tituloPagarModel.FIDTipoStatus;
    edtParcela.Text                             := tituloPagarModel.Fparcela;
    edtDescricao.Text                           := 'PG REF: ' ;
    edtUltimoUpdate.Text                        := DateToStr(now);
    frmTipoCobranca1.cbbTipoCobranca.ItemIndex  := 1;
    frmLocalPagto1.cbbLocalPagto.ItemIndex      := FSlistaLocalPagamento.Count -1;

   end;



end;

procedure TfrmManterTituloPagar.btnLimparRateioCCClick(Sender: TObject);
begin
 limpaRateioCC;
 frameCentroCusto2.cbbCentroCusto.ItemIndex := frameCentroCusto1.cbbCentroCusto.ItemIndex;
 edtValorRateioCC.Enabled := True;
 edtValorRateioCC.SetFocus;
  //obs lembrar de setar o CC  principal novamente.

  atualizarRateio('C');
end;

procedure TfrmManterTituloPagar.btnLimparRateioHistClick(Sender: TObject);
begin

  limpaRateioHistorico;
  frameHistorico2.cbbcombo.ItemIndex           := 0;
  gridRateioHist.Refresh;
  edtValorRateioHist.Clear;

   frameHistorico2.cbbcombo.ItemIndex := frameHistorico1.cbbcombo.ItemIndex;
   edtValorRateioHist.Enabled := True;
   edtValorRateioHist.SetFocus;


  //obs lembrar de setar o historico principal novamente.

  atualizarRateio('H');
end;


procedure TfrmManterTituloPagar.limpaRateioHistorico;
begin
  fdmHistorico.Open;
  fdmHistorico.First;
  while not fdmHistorico.Eof do
  begin
    fdmHistorico.Delete;
    fdmHistorico.Next;
  end;
    gridRateioHist.DataSource.DataSet.Close;
    gridRateioHist.Refresh;

 {  if Assigned(tituloPagarModel.listaHistorico) then begin
     tituloPagarModel.listaHistorico.Clear;
   end;  }

   frameHistorico2.cbbcombo.ItemIndex :=0;
   edtValorRateioHist.Clear;
   atualizarRateio('H');

    //obs lembrar de setar o historico principal novamente.
end;

procedure TfrmManterTituloPagar.limpaRateioCC;
begin
  fdmCentroCusto.Open;
  fdmCentroCusto.First;
  while not fdmCentroCusto.Eof do
  begin
    fdmCentroCusto.Delete;
    fdmCentroCusto.Next;
  end;
    gridRateioCC.DataSource.DataSet.Close;
    gridRateioCC.Refresh;


 {  if Assigned(tituloPagarModel.listaHistorico) then begin
     tituloPagarModel.listaHistorico.Clear;
   end;  }

   frameCentroCusto2.cbbCentroCusto.ItemIndex :=0;
   edtValorRateioCC.Clear;
   atualizarRateio('C');

    //obs lembrar de setar o CC principal novamente.
end;



function TfrmManterTituloPagar.atualizarRateio(pTipo :string) : Currency;
var
totalRateio : Currency;
begin
  totalRateio:=0;
  if pTipo.Equals('H') then
  begin //atualiza saldo do rateio historico
    totalRateio := obterValorRateioHistorico;
    EdtTotalRateioHist.Value := totalRateio  ;
    edtDifHistorico.Value := edtValor.Value - totalRateio; //total do titulo menos o total do rateio

  end;

  totalRateio:=0;
  if pTipo.Equals('C') then
  begin //atualiza saldo do rateio CC
    totalRateio := obterValorRateioCC;
    edtTotalRateioCC.Value := totalRateio  ;
    edtDifRateioCC.Value := edtValor.Value - totalRateio; //total do titulo menos o total do rateio

  end;


end;

function TfrmManterTituloPagar.obterValorRateioCC: Currency;
var
total :Currency;
  I: Integer;
begin
 total :=0;
 fdmCentroCusto.Open;
 fdmCentroCusto.First;
 while not fdmCentroCusto.Eof do begin

 total := total + fdmCentroCusto.FieldByName('VALOR').AsCurrency;

 fdmCentroCusto.Next;
 end;


  Result := total;

end;


function TfrmManterTituloPagar.obterValorRateioHistorico: Currency;
var
total :Currency;
  I: Integer;
begin
 total :=0;
 fdmHistorico.Open;
 fdmHistorico.First;
 while not fdmHistorico.Eof do begin

 total := total + fdmHistorico.FieldByName('VALOR').AsCurrency;

 fdmHistorico.Next;
 end;


  Result := total;

end;



procedure TfrmManterTituloPagar.createTable;
begin

    fdmHistorico.FieldDefs.Add('DESCRICAO', ftString, 60, false);
    fdmHistorico.FieldDefs.Add('VALOR', ftCurrency, 0, false);
    fdmHistorico.FieldDefs.Add('ID_HISTORICO', ftString, 36, false);
    fdmHistorico.CreateDataSet;

    fdmCentroCusto.FieldDefs.Add('DESCRICAO', ftString, 60, false);
    fdmCentroCusto.FieldDefs.Add('VALOR', ftCurrency, 0, false);
    fdmCentroCusto.FieldDefs.Add('ID_CENTRO_CUSTO', ftString, 36, false);
    fdmCentroCusto.CreateDataSet;


end;


procedure TfrmManterTituloPagar.btnSelectTCCClick(Sender: TObject);
var
  rateioCC: TTituloPagarCentroCustoModel;
  ccValidado: Boolean;
begin
  //botao seleciona novo centro de custo
  //cria novo rateio

  rateioCC := TTituloPagarCentroCustoModel.Create;
  ccValidado := False;

  centroCustoModel := TCentroCustoModel.Create;
  centroCustoModel.FIDorganizacao := pIDorganizacao;
  centroCustoModel.FID := FSlistaCentroCusto[frameCentroCusto2.cbbCentroCusto.ItemIndex];
  centroCustoModel := TCentroCustoDAO.obterPorID(centroCustoModel);

  if uUtil.Empty(centroCustoModel.FID) then
  begin
    ShowMessage('O centro de custo n�o pode ser utilizado. Poss�vel problema com a consulta . ');
    frameCentroCusto2.cbbCentroCusto.ItemIndex := 0;
  end
  else
  begin
    ccValidado := True;
  end;

  if ccValidado then
  begin
    rateioCC.FIDorganizacao := pIDorganizacao;
    rateioCC.FID := dmConexao.obterNewID;
    rateioCC.FIDCentroCusto := centroCustoModel.FID;
    rateioCC.FIDTP := tituloPagarModel.FID;
    rateioCC.Fvalor := edtValorRateioCC.Value;
    rateioCC.FCentroCusto := centroCustoModel;

    tituloPagarModel.AdicionarCC(rateioCC);
    fdmCentroCusto.Open;
    fdmCentroCusto.InsertRecord([centroCustoModel.FDescricao, edtValorRateioCC.Value]);
    edtTotalRateioCC.Value := obterValorRateioCC;

    frameCentroCusto2.cbbCentroCusto.ItemIndex := 0;
    edtValorRateioCC.Value := 0;
    btnSelectTCC.Enabled := False;

  end;

  atualizarRateio('C');
end;

procedure TfrmManterTituloPagar.btnSelectTHSTClick(Sender: TObject);
 var
 rateioHistorico  : TTituloPagarHistoricoModel;
 hstValidado : Boolean;

begin
  rateioHistorico := TTituloPagarHistoricoModel.Create;

  hstValidado := False;

  // falta acrescentar historicoModel rateio na consulta .. no modo 0

   if modo = 0 then begin

     /// ver a lista de historico
     ///  ver se abaRateio nao est� fazendo


   end;


 if modo > 0 then begin //titulo novo

  if edtValorRateioHist.Value > 0 then
  begin

      historicoModel                := THistoricoModel.Create;
      historicoModel.FID            := FSlistaHistorico[frameHistorico2.cbbcombo.ItemIndex];
      historicoModel.FIDorganizacao := pIDorganizacao;
      historicoModel := THistoricoDAO.obterPorID(historicoModel);

    if uutil.Empty(historicoModel.FIdContaContabil) then
    begin
      ShowMessage('O hist�rico n�o pode ser utilizado. Poss�vel problema no campo conta cont�bil. ');
      frameHistorico2.cbbcombo.ItemIndex := 0;

    end
    else
    begin
      hstValidado := True;
    end;

      rateioHistorico.FID                     := dmConexao.obterNewID;
      rateioHistorico.FIDorganizacao          := pIDorganizacao;
      rateioHistorico.FIDHistorico            := historicoModel.FID;
      rateioHistorico.FIDContaContabilDebito  := historicoModel.FIdContaContabil;
      rateioHistorico.FIDTP                   := tituloPagarModel.FID;
      rateioHistorico.Fvalor                  := edtValorRateioHist.Value;

      if hstValidado then begin

      tituloPagarModel.AdicionarHST(rateioHistorico);
      fdmHistorico.Open;
      fdmHistorico.InsertRecord([historicoModel.FDescricao, edtValorRateioHist.Value]);
      EdtTotalRateioHist.Value := obterValorRateioHistorico;

      frameHistorico2.cbbcombo.ItemIndex := 0;
      edtValorRateioHist.Value := 0;
      btnSelectTHST.Enabled := False;


      end;



  end;

 end;



  atualizarRateio('H');

end;

procedure TfrmManterTituloPagar.carregarCombos (titulo :TTituloPagarModel) ;
begin

    if uutil.Empty(titulo.FID) then begin


      frameTP1.obterTodos(pIDorganizacao, frameTP1.cbbTP, FSlistaTitulos);
      frameCedente1.obterTodos(pIDorganizacao, frameCedente1.cbbcombo, FSlistaCedente);
      frameHistorico1.obterTodosPorTipo (pIDorganizacao,'P', frameHistorico1.cbbcombo, FSlistaHistorico);
      frameCentroCusto1.obterTodos(pIDorganizacao, frameCentroCusto1.cbbCentroCusto, FSlistaCentroCusto);

      frameResponsavel1.obterTodosAtivos(pIDorganizacao, frameResponsavel1.cbbcombo, FSlistaResponsavel);

      frmTipoCobranca1.obterTodos(pIDorganizacao, frmTipoCobranca1.cbbTipoCobranca, FSlistaTipoCobranca);
      frmLocalPagto1.obterTodos(pIDorganizacao, frmLocalPagto1.cbbLocalPagto, FSlistaLocalPagamento);
      frameHistorico2.obterTodosPorTipo (pIDorganizacao,'P', frameHistorico2.cbbcombo, FSlistaHistorico);
      frameCentroCusto2.obterTodos(pIDorganizacao, frameCentroCusto2.cbbCentroCusto, FSlistaCentroCusto);
      frmTipoNF1.obterTodos(pIDorganizacao, frmTipoNF1.cbbTipoNF, FSlistaTipoNF);



       frameCedente1.cbbcombo.ItemIndex             := 0;
       frameHistorico1.cbbcombo.ItemIndex           := 0;
       frameHistorico2.cbbcombo.ItemIndex           := 0;
       frameCentroCusto1.cbbCentroCusto.ItemIndex   := 0;
       frameCentroCusto2.cbbCentroCusto.ItemIndex   := 0;
       frameResponsavel1.cbbcombo.ItemIndex         := 0;
       frmTipoCobranca1.cbbTipoCobranca.ItemIndex   := 0;
       frmLocalPagto1.cbbLocalPagto.ItemIndex       := 0;
       frmTipoNF1.cbbTipoNF.ItemIndex               := 0;



    end else begin


       frameCedente1.cbbcombo.ItemIndex             := obterIndiceLista(titulo.FIDCedente, FSlistaCedente);
       frameHistorico1.cbbcombo.ItemIndex           := obterIndiceLista(titulo.FIDHistorico,FSlistaHistorico);
       frameHistorico2.cbbcombo.ItemIndex           := obterIndiceLista(titulo.FIDHistorico,FSlistaHistorico);
       frameCentroCusto1.cbbCentroCusto.ItemIndex   := obterIndiceLista(titulo.FIDCentroCusto, FSlistaCentroCusto);
       frameCentroCusto2.cbbCentroCusto.ItemIndex   := obterIndiceLista(titulo.FIDCentroCusto, FSlistaCentroCusto);
       frameResponsavel1.cbbcombo.ItemIndex         := obterIndiceLista(titulo.FIDResponsavel, FSlistaResponsavel);
       frmTipoCobranca1.cbbTipoCobranca.ItemIndex   := obterIndiceLista(titulo.FIDTipoCobranca, FSlistaTipoCobranca);
       frmLocalPagto1.cbbLocalPagto.ItemIndex       := obterIndiceLista(titulo.FIDLocalPagamento, FSlistaLocalPagamento);
       frmTipoNF1.cbbTipoNF.ItemIndex              := obterIndiceLista(titulo.FIDNotaFiscalEntrada, FSlistaTipoNF);


    end;


    frameTP1.Enabled := True;

end;

procedure TfrmManterTituloPagar.preencheGridCedntroC;
begin
try
    qryPreencheGridCentroC.Close;
    qryPreencheGridCentroC.Connection := dmConexao.conn;
    qryPreencheGridCentroC.ParamByName('PIDORGANIZACAO').AsString := pIDorganizacao;
    qryPreencheGridCentroC.Open;

 except
 raise Exception.Create('Erro ao consultar a tabela de centro de custos.');

 end;

    dbgridCC.Refresh;

end;



procedure TfrmManterTituloPagar.preencheGridHistorico;
begin
 try
    qryPreencheGridHistorico.Close;
    qryPreencheGridHistorico.Connection := dmConexao.conn;
    qryPreencheGridHistorico.ParamByName('PIDORGANIZACAO').AsString := pIDorganizacao;
    qryPreencheGridHistorico.ParamByName('PTIPO').AsString := 'P';
    qryPreencheGridHistorico.Open;

 except
 raise Exception.Create('Erro ao consultar a tabela de historicos.');

 end;

    dbgridHistorico.Refresh;

end;


procedure TfrmManterTituloPagar.tbComplementoExit(Sender: TObject);
begin
 //setando a complementar no titulo
 tituloPagarModel.FcodigoBarras     := edtCodigoBarras.Text;
 tituloPagarModel.Fcontrato         := edtContrato.Text;
 tituloPagarModel.Fcarteira         := edtCarteira.Text;
 tituloPagarModel.Fobservacao       := edtObervacao.Text;
 tituloPagarModel.FprevisaoCartorio := dtPrevisaoCartorio.DateTime;

end;

procedure TfrmManterTituloPagar.tbNotaFiscalExit(Sender: TObject);
var
notaFiscal :TNotaFiscalEntradaModel;
begin

  notaFiscal :=TNotaFiscalEntradaModel.Create;

  if not uutil.Empty( edtNFNumero.Text ) then begin


  notaFiscal.FIDorganizacao := pIDorganizacao;
  notaFiscal.FID  := dmConexao.obterNewID;
  notaFiscal.FdataRegistro := Now;

  if not uUtil.Empty(tituloPagarModel.FIDNotaFiscalEntrada) then begin
     notaFiscal.FIDorganizacao := pIDorganizacao;
     notaFiscal.FID  := tituloPagarModel.FIDNotaFiscalEntrada;
     notaFiscal.FdataRegistro := tituloPagarModel.FdataRegistro;
    end;

    pIDNotaFiscal := notaFiscal.FID;

    notaFiscal.FIDresponsavel := tituloPagarModel.FIDResponsavel;
    notaFiscal.FIDtipoNotaFiscal := pIDTipoNotaFiscal;
    notaFiscal.FIDusuario := StrToInt(uutil.TUserAtual.getUserId);
    notaFiscal.Fnumero := edtNFNumero.Text;
    notaFiscal.Fdescricao := edtNFDescricao.Text;
    notaFiscal.Fobservacao := edtNFObservacao.Text;
    notaFiscal.Fserie := edtNFSerie.Text;
    notaFiscal.FsubSerie := edtNFSubSerie.Text;
    notaFiscal.FaliquotaISS := edtNFAliquotaISS.Text;
    notaFiscal.FdataRetenncaoISS := dtNFRetencaoISS.Date;
    notaFiscal.FdataEmissao := dtNFEmissao.Date;
    notaFiscal.FdataProtocolo := dtNFProtocolo.Date;
    notaFiscal.Fvalor := edtValorNF.Value;
    notaFiscal.FvalorISS := edtValorISS.Value;

    tituloPagarModel.FIDNotaFiscalEntrada := notaFiscal.FID;
    tituloPagarModel.FNotaFiscalEntrada := notaFiscal;

  end;

end;


procedure TfrmManterTituloPagar.tbRateioCentroCustoShow(Sender: TObject);
begin
preencheGridCedntroC;
end;

procedure TfrmManterTituloPagar.tbRateioHistoricosShow(Sender: TObject);
begin
 preencheGridHistorico;
end;

procedure TfrmManterTituloPagar.StatusBotoes(value :Integer);
var i :Integer;
ativar : Boolean;
begin
 ativar := True;   /// 1 = ativa e 0 = desativa

 if value = 0 then begin //desativar
   ativar := False;
 end;

  for i := 0 to Self.ComponentCount - 1 do
  begin
    if Self.Components[i] is TdxBarLargeButton then
    begin
      (Self.Components[i] as TdxBarLargeButton).Enabled := ativar;
    end;

  end;

  dxBtnLimpar.Enabled := True;
  dxBarBtnSair.Enabled := True;

end;

procedure TfrmManterTituloPagar.dtPagamentoChange(Sender: TObject);
begin
 dtPrevisaoCartorio.Date := IncMonth(dtPagamento.Date, 1);

    if modo = 1 then
    begin

      if dtPagamento.Date > Now then
      begin
        dxBtnPagar.Enabled := False;
        Label10.Caption := 'Data provis�o';
      end
      else
      begin
      Label10.Caption := 'Data pagamento';
        dxBtnPagar.Enabled := True;
      end;

    end;



end;

procedure TfrmManterTituloPagar.dxBarBtnSairClick(Sender: TObject);
begin
 PostMessage(Self.Handle, WM_CLOSE, 0, 0);
end;

procedure TfrmManterTituloPagar.dxBtnEspelhoClick(Sender: TObject);
begin

  try
    formEspeloTP := TformEspeloTP.Create(Self, tituloPagarModel.FnumeroDocumento);
    formEspeloTP.ShowModal;
    FreeAndNil(formEspeloTP);

  except
    on e: Exception do
      ShowMessage(e.Message + sLineBreak + 'Contate o suporte.  ' );
  end;



end;

procedure TfrmManterTituloPagar.dxBtnLimparClick(Sender: TObject);
begin
limparPanel;
limpaRateioHistorico;
limpaRateioCC;

end;

procedure TfrmManterTituloPagar.dxBtnNewClick(Sender: TObject);
begin
ShowMessage('botao novo');
end;

procedure TfrmManterTituloPagar.dxBtnPagarClick(Sender: TObject);
var
pTitulo : TTituloPagarModel;
begin
pTitulo := TTituloPagarModel.Create;

 if not uutil.Empty(tituloSelecionado.FID) then begin
   pTitulo := tituloSelecionado;
 end;

 if not uutil.Empty(tituloPagarModel.FID) then begin
   pTitulo := tituloPagarModel;
 end;


 try
    frmBaixa := TFrmBaixaFP.Create(Self,pTitulo);
    frmBaixa.ShowModal;
    FreeAndNil(frmBaixa);

  except
    on e: Exception do
      ShowMessage(e.Message + sLineBreak + 'Contate o suporte. Informe erro: ' + ' TfrmBaixaFP ' );
  end;

  LimpaTela(Self);


end;

procedure TfrmManterTituloPagar.dxBtnReciboClick(Sender: TObject);
begin

  try
      frmReciboTP := TFrmReciboTP.Create(Self, tituloPagarModel.FID);
      frmReciboTP.ShowModal;
      FreeAndNil(frmReciboTP);

  except on e: Exception do
    ShowMessage(e.Message + sLineBreak + 'Contate o administrador!');
  end;
end;

procedure TfrmManterTituloPagar.dxBtnSaveClick(Sender: TObject);
begin
 //abre a tela de provisionamento de titulos

 // montar o objeto

  tituloPagarModel.FvalorNominal  := edtValor.Value;
  tituloPagarModel.Fparcela       := edtParcela.Text;
  tituloPagarModel.Fdescricao     := edtDescricao.Text;

  tituloPagarModel.FIDorganizacao := pIDorganizacao;
  tituloPagarModel.FIDHistorico   := FSlistaHistorico[frameHistorico1.cbbcombo.ItemIndex];
  tituloPagarModel.FIDCedente     := FSlistaCedente[frameCedente1.cbbcombo.ItemIndex];
  tituloPagarModel.FIDTipoCobranca := FSlistaTipoCobranca[frmTipoCobranca1.cbbTipoCobranca.ItemIndex];
  tituloPagarModel.FIDLocalPagamento := FSlistaLocalPagamento[frmLocalPagto1.cbbLocalPagto.ItemIndex] ;






 frmTituloPagarParcelado := TFrmTituloPagarParcelado.Create(Self, tituloPagarModel);
 frmTituloPagarParcelado.ShowModal;
 FreeAndNil(frmTituloPagarParcelado);

 //testar se esse TP foi cadastrado e ai limpar.. se nao, deixa os dadoa na tela.

 dxBtnLimpar.Click;
end;

procedure TfrmManterTituloPagar.edtCarteiraChange(Sender: TObject);
begin
tituloPagarModel.Fcarteira := edtCarteira.Text;
end;

procedure TfrmManterTituloPagar.edtValorChange(Sender: TObject);
begin
edtValorTP.Value := edtValor.Value;
edtValorTPCC.Value := edtValor.Value;
edtValorNF.Value := edtValor.Value;
end;

procedure TfrmManterTituloPagar.edtValorRateioCCChange(Sender: TObject);
begin

if edtValorRateioCC.Value > 0 then begin
btnSelectTCC.Enabled := True;
end;
end;

procedure TfrmManterTituloPagar.edtValorRateioHistChange(Sender: TObject);
begin

if edtValorRateioHist.Value > 0 then begin
btnSelectTHST.Enabled := True;
end;
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
var
vctoCartao : string;
diaHoje, diaCompra, diaVcto : Integer;

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
      msgStatusBar(1, 'Verifique a conta cont�bil do cedente/fornecedor.');
      dxBtnSave.Enabled := False;
    end;

  end;

  if not uUtil.Empty(cedenteModel.FIDcartaoCreditoModel) then begin
    diaCompra :=StrToInt(cedenteModel.FcartaoCredito.FDiaCompra);
    diaVcto   := StrToInt(cedenteModel.FcartaoCredito.FDiaVencimento);
    diaHoje   := DayOf(Now);

    vctoCartao := IntToStr(diaVcto) + '/' + IntToStr(MonthOf(IncMonth(Now, 0))) + '/' + IntToStr(yearOf(Now));


      if diaHoje >= diaCompra then
      begin
        vctoCartao := IntToStr(diaVcto) + '/' +IntToStr(MonthOf(IncMonth(Now, 1))) + '/' + IntToStr(yearOf(Now));

      end;


      dtPagamento.Date := StrToDate(vctoCartao);

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
    historicoModel                 := THistoricoModel.Create;
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
      msgStatusBar(1, 'Verifique a conta cont�bil do hist�rico');
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

   StatusBotoes(0);
   {
    dxBtnPagar.Enabled  := False;
    dxBtnEdit.Enabled   := False;
    dxBtnDelet.Enabled  := False;
    dxBtnNew.Enabled    := False;
    dxBtnSave.Enabled   := False;
    dxBtnRecibo.Enabled := True;   }


    statusModel                     := TTipoStatusModel.Create;
    statusModel.FIDorganizacao      := status.FIDorganizacao;
    statusModel.FID                 := status.FID;
    statusModel                     := TTipoStatusDAO.obterPorID(status);
    dxBtnEspelho.Enabled    := True;
    dxBtnRecibo.Enabled     := True;


    if status.Fdescricao.Equals('ABERTO') then begin

            dxBtnPagar.Enabled      := True;
            dxBtnEdit.Enabled       := True;
            dxBtnDelet.Enabled      := True;
            dxBtnSave.Enabled       := True;
            dxBtnEspelho.Enabled    := True;
            dxBtnRecibo.Enabled := False; //N�o permite emitir recibo com TP aberto

    end;



  if status.Fdescricao.Equals('EXCLUIDO') then
  begin
    StatusBotoes(0);
  end;




end;

procedure TfrmManterTituloPagar.frameCedente1cbbcomboChange(Sender: TObject);
begin
//if Assigned(cedenteModel) then begin FreeAndNil(cedenteModel); end;

if frameCedente1.cbbcombo.ItemIndex >0 then begin

  cedenteModel                := TCedenteModel.Create;
  cedenteModel.FID            := FSlistaCedente[frameCedente1.cbbcombo.ItemIndex];
  cedenteModel.FIDorganizacao := pIDorganizacao;
  cedenteModel := TCedenteDAO.obterPorID(cedenteModel);

  popularCedente(cedenteModel);

 end else begin ShowMessage('Selecione um cedente.'); end;

end;

procedure TfrmManterTituloPagar.frameCentroCusto1cbbCentroCustoChange( Sender: TObject);
var
rateioCC : TTituloPagarCentroCustoModel;
begin

  if frameCentroCusto1.cbbCentroCusto.ItemIndex > 0 then
  begin

   centroCustoModel                 := TCentroCustoModel.Create;
   centroCustoModel.FID             := FSlistaCentroCusto[frameCentroCusto1.cbbCentroCusto.ItemIndex];
   centroCustoModel.FIDorganizacao  := pIDorganizacao;
   popularCentroCusto(centroCustoModel);

    rateioCC := TTituloPagarCentroCustoModel.Create;
    rateioCC.FIDorganizacao := pIDorganizacao;
    rateioCC.FID := dmConexao.obterNewID;
    rateioCC.FIDCentroCusto := centroCustoModel.FID;
    rateioCC.FIDTP := tituloPagarModel.FID;
    rateioCC.Fvalor := edtValor.Value;
    rateioCC.FCentroCusto := centroCustoModel;

    tituloPagarModel.listaCustos.Clear; //zera todos os historicos existentes.. tem que refazer o rateio
    tituloPagarModel.AdicionarCC(rateioCC);
    fdmCentroCusto.Open;
    fdmCentroCusto.InsertRecord([centroCustoModel.FDescricao, edtValor.Value]);

  end
  else
  begin
    ShowMessage('Selecione um centro de custos.');

  end;





end;

procedure TfrmManterTituloPagar.frameHistorico1cbbcomboChange(Sender: TObject);
var
rateioHistorico : TTituloPagarHistoricoModel;
hstValidado : Boolean;
J :Integer;
begin

   hstValidado := False;
   limpaRateioHistorico; //sempre limpa a lista do TP

      historicoModel                := THistoricoModel.Create;
      historicoModel.FID            := FSlistaHistorico[frameHistorico1.cbbcombo.ItemIndex];
      historicoModel.FIDorganizacao := pIDorganizacao;
      popularHistorico(historicoModel);

      rateioHistorico                         := TTituloPagarHistoricoModel.Create;
      rateioHistorico.FID                     := dmConexao.obterNewID;
      rateioHistorico.FIDorganizacao          := pIDorganizacao;
      rateioHistorico.FIDHistorico            := historicoModel.FID;
      rateioHistorico.FIDContaContabilDebito  := historicoModel.FIdContaContabil;
      rateioHistorico.FIDTP                   := tituloPagarModel.FID;
      rateioHistorico.Fvalor                  := edtValor.Value; //valor total do TP

      tituloPagarModel.listaHistorico.Clear; //zera todos os historicos existentes.. tem que refazer o rateio
      tituloPagarModel.AdicionarHST(rateioHistorico);

      fdmHistorico.Open;
      fdmHistorico.InsertRecord([historicoModel.FDescricao, edtValor.Value]);


  atualizarRateio('H');

end;

procedure TfrmManterTituloPagar.frameHistorico2cbbcomboChange(Sender: TObject);
begin


  if frameHistorico2.cbbcombo.ItemIndex > 0 then
  begin

    edtValorRateioHist.Enabled := True;
  end
  else
  begin
    edtValorRateioHist.Enabled := False;
  end;


end;

procedure TfrmManterTituloPagar.frameResponsavel1cbbcomboChange(  Sender: TObject);
begin

if frameResponsavel1.cbbcombo.ItemIndex >0 then begin

  responsavelModel                := TFuncionarioModel.Create;
  responsavelModel.FID            := FSlistaResponsavel[frameResponsavel1.cbbcombo.ItemIndex];
  responsavelModel.FIDorganizacao := pIDorganizacao;
  popularResponsavel(responsavelModel);

 end else begin ShowMessage('Selecione um respons�vel.'); end;


end;

procedure TfrmManterTituloPagar.frameTP1cbbTPChange(Sender: TObject);
begin
 limpaRateioHistorico;
 limpaRateioCC;
 modo :=0; //modo de consulta

 if modo = 0  then begin
    BtnGerarDOC.Caption := 'Consultar';
    BtnGerarDOC.Enabled := True;
  end;
end;

procedure TfrmManterTituloPagar.frameTP1cbbTPExit(Sender: TObject);
begin
  limpaRateioHistorico;
  limpaRateioCC;
  StatusBotoes(0);



tituloSelecionado := TTituloPagarModel.Create;


 if frameTP1.cbbTP.ItemIndex >0 then begin
   //verifica se tem lotes (contabil e pagametno)
   //titulo veio da consulta

   tituloSelecionado.FID := FSlistaTitulos[frameTP1.cbbTP.ItemIndex];
   tituloSelecionado.FIDorganizacao := pIDorganizacao;
   tituloPagarModel := TTituloPagarDAO.obterPorID(tituloSelecionado);
   FreeAndNil(tituloSelecionado);

        if not uutil.Empty(tituloPagarModel.FID) then
        begin

          preencheAbaBasica(tituloPagarModel);
          preencheDatas(tituloPagarModel);
          preencheAbaComplementar(tituloPagarModel);
          carregarCombos(tituloPagarModel); //carrega com o objeto que vem do BD
          popularCedente(tituloPagarModel.FCedente);
          popularHistorico(tituloPagarModel.FHistorico);
          preencheAbaRateioHistorico(tituloPagarModel.listaHistorico);
          preencheAbaNotaFiscal(tituloPagarModel.FNotaFiscalEntrada);
          preencheAbaRateioCC(tituloPagarModel.listaCustos);
          popularCentroCusto(tituloPagarModel.FCentroCustos);
          popularResponsavel(tituloPagarModel.FResponsavel);
          popularStatus(tituloPagarModel.FTipoStatus);



        end;


  end else begin ShowMessage('Selecione um t�tulo. '); end;

  if modo = 0  then begin
    BtnGerarDOC.Caption := 'Consultar';
  end;
end;

procedure TfrmManterTituloPagar.frmTipoNF1cbbTipoNFChange(Sender: TObject);
begin
  if frmTipoNF1.cbbTipoNF.ItemIndex > 0 then
  begin

    pIDTipoNotaFiscal := FSlistaTipoNF[frmTipoNF1.cbbTipoNF.ItemIndex];

  end;
end;

procedure TfrmManterTituloPagar.preencheAbaComplementar(titulo : TTituloPagarModel);
begin
 edtUltimoUpdate.Text     := DateToStr(titulo.FdataUltimaAtualizacao);
 dtPrevisaoCartorio.Date  := (titulo.FprevisaoCartorio);
 edtCodigoBarras.Text     := titulo.FcodigoBarras;
 edtContrato.Text         := titulo.Fcontrato;
 edtCarteira.Text         := titulo.Fcarteira;
 edtObervacao.Text        := titulo.Fobservacao;


end;

procedure TfrmManterTituloPagar.preencheAbaBasica(titulo : TTituloPagarModel);
var
loteCC : TLoteContabilModel;
lotePP : TLotePagamentoModel;
begin
   loteCC := TLoteContabilModel.Create;
   lotePP := TLotePagamentoModel.Create;

   edtLotePagamento.Clear;
   edtLoteContabil.Clear;

   loteCC := obterLoteContabil(titulo.FLoteContabil);
   lotePP := obterLotePagamento(titulo.FLotePagamento);

   if not uutil.Empty(loteCC.FID) then begin
     edtLoteContabil.Text   := 'DATA '+ DateToStr(titulo.FLoteContabil.FdataRegistro) + ' LOTE :' + titulo.FLoteContabil.Flote;
   end;

   if not uutil.Empty(lotePP.FID) then begin
     edtLotePagamento.Text   :=  titulo.FLotePagamento.Flote;
   end;

   edtValor.Value           := titulo.FvalorNominal;
   edtValorAntecipado.Value := titulo.FvalorAntecipado;
   edtParcela.Text          := titulo.Fparcela;
   edtStatus.Text           := titulo.FTipoStatus.Fdescricao;
   edtDescricao.Text        := titulo.Fdescricao;

   FreeAndNil(loteCC);
   FreeAndNil(lotePP);


end;

procedure TfrmManterTituloPagar.preencheDatas(titulo : TTituloPagarModel);
begin

   Label10.Caption := 'Data pagamento';
   dtPagamento.DateTime     := titulo.FdataPagamento;
   dtEmissao.DateTime       := titulo.FdataEmissao;
   dtProtocolo.DateTime     := titulo.FdataProtocolo;
   dtPrevisaoCartorio.DateTime := titulo.FprevisaoCartorio;
   edtUltimoUpdate.Text        := DateToStr(titulo.FdataUltimaAtualizacao);

   if titulo.FIDTipoStatus.Equals('ABERTO') then begin
    Label10.Caption := 'Data vencimento';
    dtPagamento.DateTime   := titulo.FdataVencimento;
    dxBtnPagar.Enabled := True;
   end;
    if titulo.FIDTipoStatus.Equals('EXCLUIDO') then begin
    Label10.Caption := 'Data vencimento';
    dtPagamento.DateTime   := titulo.FdataVencimento;
   end;

end;

procedure TfrmManterTituloPagar.preencheAbaRateioCC(listaCC :TObjectList<TTituloPagarCentroCustoModel>);
 var
I :Integer;
centroCusto : TCentroCustoModel;
TPCCModel : TTituloPagarCentroCustoModel;
begin
  for I := 0 to listaCC.Count-1 do begin

        TPCCModel := TTituloPagarCentroCustoModel.Create;
        TPCCModel := TTituloPagarCentroCustoModel(listaCC[I]);
        TPCCModel := TTituloPagarCentroCustoDAO.obterPorID(TPCCModel);

     fdmCentroCusto.Open;
     fdmCentroCusto.InsertRecord([TPCCModel.FCentroCusto.FDescricao, TPCCModel.Fvalor]);

   end;

  atualizarRateio('C');


end;

procedure TfrmManterTituloPagar.preencheAbaNotaFiscal(nota :TNotaFiscalEntradaModel);
begin

 if not uUtil.Empty(nota.FID) then begin
     frmTipoNF1.cbbTipoNF.ItemIndex := obterIndiceLista(nota.FIDtipoNotaFiscal, FSlistaTipoNF);


   edtNFObservacao.Text     := nota.Fobservacao;
   edtNFNumero.Text         := nota.Fnumero;
   edtNFDescricao.Text      := nota.Fdescricao;
   edtNFAliquotaISS.Text    := nota.FaliquotaISS;
   edtNFSerie.Text          := nota.Fserie;
   edtNFSubSerie.Text       := nota.FsubSerie;
   dtNFEmissao.Date         := nota.FdataEmissao;
   dtNFProtocolo.Date       := nota.FdataProtocolo;
   dtNFRetencaoISS.Date     := nota.FdataRetenncaoISS;
   edtValor.Value           := nota.Fvalor;
   edtBaseCalculo.Value     := nota.FbaseCalculoISS;
   edtValorISS.Value        := nota.FvalorISS;

   pIDTipoNotaFiscal := nota.FIDtipoNotaFiscal;
   pIDNotaFiscal := nota.FID;


 end;



end;


procedure TfrmManterTituloPagar.preencheAbaRateioHistorico(listaH :TObjectList<TTituloPagarHistoricoModel>);
var
I :Integer;
historico : THistoricoModel;
TPHModel : TTituloPagarHistoricoModel;

 listaX :TObjectList<TTituloPagarHistoricoModel>;
begin
  {
  tituloPagar.listaHistorico := TObjectList<TTituloPagarHistoricoModel>.Create;
  tituloPagar.listaCustos := TObjectList<TTituloPagarCentroCustoModel>.Create; }
  listaX :=TObjectList<TTituloPagarHistoricoModel>.Create;
  listaX := listaH;

  limpaRateioHistorico;

   for I := 0 to listaX.Count-1 do begin

        TPHModel := TTituloPagarHistoricoModel.Create;
        TPHModel := TTituloPagarHistoricoModel(listaX[I]);
        TPHModel := TTituloPagarHistoricoDAO.obterPorID(TPHModel);

     fdmHistorico.Open;
     fdmHistorico.InsertRecord([TPHModel.FHistorico.FDescricao, TPHModel.Fvalor]);

   end;

  atualizarRateio('H');

end;


procedure TfrmManterTituloPagar.limparPanel;
begin
  modo :=1;//modo de titulo novo. altera quando clica no combo de TP para pesquisar TP existente

  BtnGerarDOC.Caption := 'Gerar';
  dxBtnPagar.Enabled := True;
 // LimpaTela(Self); dando erro

 limpaStatusBar;

 if Assigned(tituloPagarModel) then begin FreeAndNil(tituloPagarModel); end;

 tituloPagarModel := TTituloPagarModel.Create;
 BtnGerarDOC.Enabled := True;
 pIdOrganizacao := UUtil.TOrgAtual.getId;
 pIdUsuario :=uutil.TUserAtual.getUserId;

 carregarCombos(tituloPagarModel);


  pgTitulo.ActivePageIndex :=0;
  btnSelectTHST.Enabled := False; //tb rateio historico
  edtValorRateioHist.Enabled := False; //tb rateio historico
  btnSelectTCC.Enabled := False; //tb rateio CC
  edtValorRateioCC.Enabled := False; //tb rateio CC

  LimpaTela(Self);

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

function TfrmManterTituloPagar.obterLoteContabil( value: TLoteContabilModel): TLoteContabilModel;
var
lote :TLoteContabilModel;
begin
 lote := TLoteContabilModel.Create;

 try

   lote := TLoteContabilDAO.obterPorID(value);

 except
 on e: Exception do
      ShowMessage(e.Message + sLineBreak + 'Contate o suporte. Informe erro: ' );

 end;


 Result := lote;
end;

function TfrmManterTituloPagar.obterLotePagamento(value: TLotePagamentoModel): TLotePagamentoModel;
var
lote :TLotePagamentoModel;
begin
 lote := TLotePagamentoModel.Create;

 try

   lote := TLotePagamentoDAO.obterPorID(value);


 except
 on e: Exception do
      ShowMessage(e.Message + sLineBreak + 'Contate o suporte. Informe erro: ' );

 end;


 Result := lote;
end;





end.


