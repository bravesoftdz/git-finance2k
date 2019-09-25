unit uFrmRelatorioPagamentosHistorico;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants,
  System.Classes, Vcl.Graphics, uDMCombos, uDMCedenteConsulta, uUtil,
  uDMContasPagar,udmConexao,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.ComCtrls, Vcl.StdCtrls, Vcl.Buttons,
  Data.DB, Vcl.Grids, Vcl.DBGrids, uDmRelTPHistorico, udmOrganizacao, frxClass,
  uDMRelatorioPagamentoHistorico,
  EFrmLab, frxDBSet, frxExportCSV, frxExportPDF, FireDAC.Stan.Intf,
  FireDAC.Stan.Option, FireDAC.Stan.Param, FireDAC.Stan.Error, FireDAC.DatS,
  FireDAC.Phys.Intf, FireDAC.DApt.Intf, FireDAC.Stan.Async, FireDAC.DApt,
  FireDAC.Comp.DataSet, FireDAC.Comp.Client;

type
  TfrmCTPHistorico = class(TForm)
    cbxComboFornecedor: TComboBox;
    Label2: TLabel;
    dtDataInicial: TDateTimePicker;
    Label3: TLabel;
    dtDataFinal: TDateTimePicker;
    Label7: TLabel;
    cbxOrdem: TComboBox;
    Label1: TLabel;
    Label4: TLabel;
    Label5: TLabel;
    btnConsultar: TButton;
    btnImprimir: TBitBtn;
    dbgTitulos: TDBGrid;
    lblTotalDeb: TEvFrameLabel;
    lblTotalPago: TEvFrameLabel;
    lblSaldo: TEvFrameLabel;
    frxDBCedente: TfrxDBDataset;
    frxRelTitulosPorCedente: TfrxReport;
    frxDBTitulosPorCedente: TfrxDBDataset;
    frxPDFExport1: TfrxPDFExport;
    frxCSVExport1: TfrxCSVExport;
    qryTitulosPorFornecedor: TFDQuery;
    ds1: TDataSource;
    lbl1: TLabel;
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormCreate(Sender: TObject);
    procedure cbxComboFornecedorChange(Sender: TObject);
    procedure btnConsultarClick(Sender: TObject);
    procedure btnImprimirClick(Sender: TObject);


  private
    { Private declarations }
    FsListaIdFornecedor: TStringList;
    idCedente: String;
    pDataInicial: TDate;
    pDataFinal: TDate;
    procedure exibirRelatorio(tipo: Integer);
    procedure inicializarDM(Sender: TObject);
    procedure freeAndNilDM(Sender: TObject);
    function retornarCaminhoRelatorio(tipo: Integer): string;
    function retornarCampoOrdenacao: string;
    function validarFormulario: boolean;
    procedure carregaComboCedente;
    function obterTitulosPorFornecedor(pIdOrganizacao, pIdCedente, campoOrdem: string; dtDataInicial, dtDataFinal: TDateTime): Boolean;
    procedure inicializarVariaveisRelatorio(dtInicial, dtFinal: TDate) ;

  public
    { Public declarations }
  end;

var
  frmCTPHistorico: TfrmCTPHistorico;

implementation

{$R *.dfm}

procedure TfrmCTPHistorico.btnConsultarClick(Sender: TObject);
var
  valorDebito, valorCredito: Currency;
begin

     pDataInicial :=  StrToDate(FormatDateTime('dd"/"mm"/"yyyy', dtDataInicial.Date));
     pDataFinal :=  StrToDate(FormatDateTime('dd"/"mm"/"yyyy', dtDataFinal.Date));

  inicializarDM(Self);
  if (cbxComboFornecedor.ItemIndex > (-1)) then
  begin
    if validarFormulario then
    begin
      valorDebito := dmContasPagar.obterTotalPorFornecedor(TOrgAtual.getId,idCedente,pDataInicial,pDataFinal);
      lblTotalDeb.Caption := FormatCurr('#,,0.00', valorDebito);

      valorCredito := dmContasPagar.obterTotalQuitadoPorFornecedor(TOrgAtual.getId, idCedente,pDataInicial,pDataFinal);
      lblTotalPago.Caption := FormatCurr('#,,0.00', valorCredito);

      lblSaldo.Caption := FormatCurr('#,,0.00', (valorDebito - valorCredito));

      if obterTitulosPorFornecedor(TOrgAtual.getId, idCedente,
        retornarCampoOrdenacao, pDataInicial,pDataFinal)
      then
      begin

         ds1.DataSet :=qryTitulosPorFornecedor;
         dbgTitulos.DataSource := ds1;
       // dbgTitulos.DataSource := nil;
        //dbgTitulos.DataSource := dmContasPagar.dtsTitulosPagarAll;
      end;

    end;
  end;
end;

procedure TfrmCTPHistorico.btnImprimirClick(Sender: TObject);
begin

  if validarFormulario then
  begin

    dmOrganizacao.carregarDadosEmpresa(TOrgAtual.getId);
    { dmContasPagar.obterTitulosPorFornecedor(TOrgAtual.getId, idCedente,
      dtDataInicial.DateTime, dtDataFinal.DateTime); }

    if dmCedenteConsulta.obterCedentePorId(TOrgAtual.getId,idCedente) then
    begin
      dmCedenteConsulta.dtsCedentePorID.DataSet :=dmCedenteConsulta.qryObterCedentePorID;

      if obterTitulosPorFornecedor(TOrgAtual.getId, idCedente,
        retornarCampoOrdenacao,pDataInicial,pDataFinal)
      then
      begin

        dmContasPagar.dtsTitulosPagarAll.DataSet := qryTitulosPorFornecedor;
        if not(dmContasPagar.dataSourceIsEmpty(ds1))
        then
        begin
          //tipo 1 = relTitulosPorCedenteDetalhado.fr3
          exibirRelatorio(1); //
        end;
      end;
    end;
  end;
end;

procedure TfrmCTPHistorico.carregaComboCedente;
begin
  dmCombos.listaFornecedor(cbxComboFornecedor, FsListaIdFornecedor);

end;

procedure TfrmCTPHistorico.cbxComboFornecedorChange(Sender: TObject);
begin
  inicializarDM(Self);

  if cbxComboFornecedor.ItemIndex < 0 then
  begin
    cbxComboFornecedor.Text := '';
  end;

  if validarFormulario then
  begin
    if cbxComboFornecedor.ItemIndex > (-1) then
      idCedente := FsListaIdFornecedor[cbxComboFornecedor.ItemIndex];
    begin
      dmCedenteConsulta.obterCedentePorId(TOrgAtual.getId, idCedente);

    end;
  end;

end;

function TfrmCTPHistorico.retornarCampoOrdenacao: string;
begin
  case cbxOrdem.ItemIndex of
    0:
      Result := 'TP.VALOR_NOMINAL';
    1:
      Result := 'TP.DATA_VENCIMENTO';
    2:
      Result := 'TP.DATA_PAGAMENTO';

  end;
end;

procedure TfrmCTPHistorico.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  freeAndNilDM(Self);
  Action := caFree;
end;

procedure TfrmCTPHistorico.FormCreate(Sender: TObject);
begin
  inicializarDM(Self);
  carregaComboCedente;
  cbxOrdem.ItemIndex := 0;
  dtDataInicial.DateTime := now;
  dtDataFinal.DateTime := now;

end;

procedure TfrmCTPHistorico.freeAndNilDM(Sender: TObject);
begin
  if (Assigned(dmRelTPHistorico)) then
  begin
    FreeAndNil(dmRelTPHistorico);
  end;

  if (Assigned(dmOrganizacao)) then
  begin
    FreeAndNil(dmOrganizacao);
  end;

  if (Assigned(dmCombos)) then
  begin
    FreeAndNil(dmCombos);
  end;

  if (Assigned(dmCedenteConsulta)) then
  begin
    FreeAndNil(dmCedenteConsulta);
  end;

  if (Assigned(dmContasPagar)) then
  begin
    FreeAndNil(dmContasPagar);
  end;

  if (Assigned(dmRelTPDetalhado)) then
  begin
    FreeAndNil(dmRelTPDetalhado);
  end;

end;

procedure TfrmCTPHistorico.inicializarDM(Sender: TObject);
begin
  { uDMCombos, uDMCedenteConsulta,uDMContasPagar,
    uDmRelTPHistorico, udmOrganizacao, uDMRelatorioPagamentoHistorico,
  }

    if not(Assigned(dmConexao)) then
  begin
    dmConexao := TdmConexao.Create(Self);
    dmConexao.conectarBanco
  end;


  if not(Assigned(dmOrganizacao)) then
  begin
    dmOrganizacao := TdmOrganizacao.Create(Self);
  end;

  if not(Assigned(dmContasPagar)) then
  begin
    dmContasPagar := TdmContasPagar.Create(Self);
  end;

  if not(Assigned(dmRelTPHistorico)) then
  begin
    dmRelTPHistorico := TdmRelTPHistorico.Create(Self);
  end;

  if not(Assigned(dmCombos)) then
  begin
    dmCombos := TdmCombos.Create(Self);
  end;

  if not(Assigned(dmCedenteConsulta)) then
  begin
    dmCedenteConsulta := TdmCedenteConsulta.Create(Self);
  end;

  if not(Assigned(dmRelTPDetalhado)) then
  begin
    dmRelTPDetalhado := TdmRelTPDetalhado.Create(Self);
  end;

end;

function TfrmCTPHistorico.retornarCaminhoRelatorio(tipo: Integer): string;
begin

  case tipo of
    0:
      Result := ExtractFilePath(Application.ExeName) +
        'relTitulosPorCedenteDetalhado.fr3';
    1:
      Result := ExtractFilePath(Application.ExeName) +
        'relTitulosPorCedenteDetalhado.fr3';
  end;

end;

function TfrmCTPHistorico.validarFormulario: boolean;
var
  valido: boolean;
begin
  valido := false;

  if not(TOrgAtual.getId = '') then
  begin
    valido := true;
  end;

  Result := valido;
end;


procedure TfrmCTPHistorico.inicializarVariaveisRelatorio(dtInicial, dtFinal: TDate) ;
begin
  with frxRelTitulosPorCedente.Variables do
  begin
    Variables['strRazaoSocial'] :=
      QuotedStr(dmOrganizacao.qryDadosEmpresa.FieldByName('RAZAO_SOCIAL')
      .AsString);
    Variables['strCNPJ'] :=
      QuotedStr(dmOrganizacao.qryDadosEmpresa.FieldByName('CNPJ').AsString);
    Variables['strEndereco'] :=
      QuotedStr(dmOrganizacao.qryDadosEmpresa.FieldByName('ENDERECO').AsString);
    Variables['strCEP'] :=
      QuotedStr(dmOrganizacao.qryDadosEmpresa.FieldByName('CEP').AsString);
    Variables['strCidade'] :=
      QuotedStr(dmOrganizacao.qryDadosEmpresa.FieldByName('CIDADE').AsString);
    Variables['strUF'] :=    QuotedStr(dmOrganizacao.qryDadosEmpresa.FieldByName('UF').AsString);
    Variables['strPeriodo'] :=QuotedStr( ' de  ' + DateToStr(dtInicial) + '  at�  ' + DateToStr(dtFinal));
    Variables['strTipoStatus'] := 'TODOS';

  end;
end;

function TfrmCTPHistorico.obterTitulosPorFornecedor(pIdOrganizacao, pIdCedente,
  campoOrdem: string; dtDataInicial, dtDataFinal: TDateTime): Boolean;
  var cmd :string;
begin
cmd := ' SELECT TP.ID_TITULO_PAGAR, TP.ID_ORGANIZACAO, TP.VALOR_NOMINAL, TP.NUMERO_DOCUMENTO, TP.DATA_EMISSAO, '+
       ' TP.DATA_VENCIMENTO, TP.DATA_PAGAMENTO, TP.DESCRICAO, TP.PARCELA, TP.ID_TIPO_STATUS, H.descricao AS HISTORICO, CC.descricao AS CENTRO_C ' +
       ' FROM  TITULO_PAGAR TP ' +
       ' LEFT OUTER JOIN HISTORICO H ON (H.ID_HISTORICO = TP.ID_HISTORICO) AND (H.id_organizacao = TP.id_organizacao) ' +
       ' LEFT OUTER JOIN centro_custo CC ON (CC.ID_CENTRO_CUSTO = TP.id_centro_custo) AND ( CC.id_organizacao = TP.id_organizacao) ' +
       ' WHERE (TP.ID_CEDENTE = :PIDCEDENTE) AND ' +
       ' (TP.ID_TIPO_STATUS in ' + '(''ABERTO'',''QUITADO'',''PARCIAL'')) AND ' +
       ' (TP.ID_ORGANIZACAO = :PIDORGANIZACAO) AND ' +
       ' (TP.DATA_EMISSAO BETWEEN :DTDATAINICIAL AND :DTDATAFINAL) ' +
       ' ORDER BY ' + campoOrdem;


  qryTitulosPorFornecedor.Close;
  qryTitulosPorFornecedor.Connection := dmConexao.Conn;
  qryTitulosPorFornecedor.SQL.Clear;
  qryTitulosPorFornecedor.SQL.Add(cmd);

  qryTitulosPorFornecedor.ParamByName('PIDORGANIZACAO').AsString := pIdOrganizacao;
  qryTitulosPorFornecedor.ParamByName('PIDCEDENTE').AsString := pIdCedente;
  qryTitulosPorFornecedor.ParamByName('DTDATAINICIAL').AsString := FormatDateTime('mm/dd/yyyy', dtDataInicial);
  qryTitulosPorFornecedor.ParamByName('DTDATAFINAL').AsString := FormatDateTime('mm/dd/yyyy', dtDataFinal);

  qryTitulosPorFornecedor.Open;

     cmd := qryTitulosPorFornecedor.FieldByName('HISTORICO').AsString;

  Result := not qryTitulosPorFornecedor.IsEmpty;
end;

procedure TfrmCTPHistorico.exibirRelatorio(tipo: Integer);
begin
  frxRelTitulosPorCedente.Clear;
  if not(frxRelTitulosPorCedente.LoadFromFile(retornarCaminhoRelatorio(tipo)))
  then
  begin

  end
  else
  begin
    inicializarVariaveisRelatorio(pDataInicial, pDataFinal);
    frxRelTitulosPorCedente.OldStyleProgress := true;
    frxRelTitulosPorCedente.ShowProgress := true;
    frxRelTitulosPorCedente.ShowReport;

  end;
end;

end.
