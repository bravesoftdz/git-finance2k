unit uFrmTelaImpressaoLotePagamento;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs,uUtil,uLotePagamentoModel, uLotePagamentoDAO,
  udmConexao, Data.DB, FireDAC.Stan.Intf, FireDAC.Stan.Option,  System.Generics.Collections, uTituloPagarModel, uTituloPagarDAO,
  FireDAC.Stan.Param, FireDAC.Stan.Error, FireDAC.DatS, FireDAC.Phys.Intf,uDMOrganizacao,
  FireDAC.DApt.Intf, FireDAC.Stan.Async, FireDAC.DApt, FireDAC.Comp.DataSet,
  FireDAC.Comp.Client, Vcl.Grids, Vcl.DBGrids, Vcl.StdCtrls, frxClass, frxDBSet,
  dxSkinsCore, dxSkinsDefaultPainters, cxTextEdit, dxBar, cxBarEditItem,
  cxClasses, cxGraphics, cxControls, cxLookAndFeels, cxLookAndFeelPainters,
  dxRibbonSkins, dxRibbonCustomizationForm, dxRibbon;

type
  TfmTelaImpressaoLotePagamento = class(TForm)
    dbgrdMain: TDBGrid;
    dsDbGrid: TDataSource;
    qryPreencheDBGrid: TFDQuery;
    qryObterTitulos: TFDQuery;
    frxRelLotePagamento: TfrxReport;
    frxDBLote: TfrxDBDataset;
    frxDBTitulo: TfrxDBDataset;
    dxBarManager1: TdxBarManager;
    dxBtnEditar: TdxBarLargeButton;
    dxBtnSalvar: TdxBarLargeButton;
    dxBtnImprimir: TdxBarLargeButton;
    dxBtnFechar: TdxBarLargeButton;
    dxBtnDeletar: TdxBarLargeButton;
    cxbrdtmPesquisa: TcxBarEditItem;
    dxBtnImprime: TdxBarLargeButton;
    dxBtnImpimir: TdxBarLargeButton;
    dxRibbon1Tab1: TdxRibbonTab;
    dxRibbon1: TdxRibbon;
    dxBarManager1Bar2: TdxBar;
    dxBarManager1Bar4: TdxBar;
    dxBarManager1Bar6: TdxBar;
    dxBtnFechar1: TdxBarLargeButton;
    dxBarImprimir: TdxBarLargeButton;
    cxbrdtmLote: TcxBarEditItem;
    qryLote: TFDQuery;
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormCreate(Sender: TObject);
    procedure btnSairClick(Sender: TObject);
    procedure dsDbGridDataChange(Sender: TObject; Field: TField);
    procedure dxBtnFechar1Click(Sender: TObject);
    procedure dxBarImprimirClick(Sender: TObject);
    procedure dbgrdMainTitleClick(Column: TColumn);
    procedure cxbrdtmLoteCurChange(Sender: TObject);

  private
    { Private declarations }
    pIDlote, pIDorganizacao, pLote :string;
    lotePagamento : TLotePagamentoModel;
    function preencheGrid: Boolean;
    procedure obterTitulosPorLote(pLote :string);
    procedure exibirRelatorio(tipo: Integer);
    procedure inicializarVariaveisRelatorio(dtInicial, dtFinal: TDate);


  public
    { Public declarations }
  end;

var
  fmTelaImpressaoLotePagamento: TfmTelaImpressaoLotePagamento;

implementation

{$R *.dfm}

procedure TfmTelaImpressaoLotePagamento.btnSairClick(Sender: TObject);
begin
 PostMessage(Self.Handle, WM_CLOSE, 0, 0);
end;

procedure TfmTelaImpressaoLotePagamento.cxbrdtmLoteCurChange(Sender: TObject);
begin
dbgrdMain.DataSource.DataSet.Locate('LOTE',UpperCase(cxbrdtmLote.CurEditValue),[loPartialKey]);
end;

procedure TfmTelaImpressaoLotePagamento.dbgrdMainTitleClick(Column: TColumn);
begin

(dbgrdMain.DataSource.DataSet as TFDQuery).IndexFieldNames :=Column.FieldName;

end;


procedure TfmTelaImpressaoLotePagamento.dsDbGridDataChange(Sender: TObject;   Field: TField);

begin
  pIDorganizacao   := (dbgrdMain.DataSource.DataSet as TFDQuery).FieldByName('ID_ORGANIZACAO').AsString;
  pIDlote          := (dbgrdMain.DataSource.DataSet as TFDQuery).FieldByName('ID_LOTE_PAGAMENTO').AsString;



 lotePagamento := TLotePagamentoModel.Create;
 lotePagamento.FIDorganizacao := pIDorganizacao;
 lotePagamento.FID := pIDlote;
 lotePagamento := TLotePagamentoDAO.obterPorID(lotePagamento)   ;

  qryLote.Close;
  qryLote.ParamByName('PID').AsString := pIDlote;
  qryLote.ParamByName('PIDORGANIZACAO').AsString := pIDorganizacao;
  qryLote.Open;

  obterTitulosPorLote(pIDlote);

end;

procedure TfmTelaImpressaoLotePagamento.dxBarImprimirClick(Sender: TObject);
begin

  if not qryLote.IsEmpty then begin

     exibirRelatorio(1);

 end;

end;

procedure TfmTelaImpressaoLotePagamento.dxBtnFechar1Click(Sender: TObject);
begin
 PostMessage(Self.Handle, WM_CLOSE, 0, 0);
end;

procedure TfmTelaImpressaoLotePagamento.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
Action := caFree;
end;

procedure TfmTelaImpressaoLotePagamento.FormCreate(Sender: TObject);
begin
dmConexao.conectarBanco;
 pIDorganizacao := uUtil.TOrgAtual.getId;
 preencheGrid;
end;

procedure TfmTelaImpressaoLotePagamento.obterTitulosPorLote(pLote :string);
var
 titulo : TTituloPagarModel;
cmd :string;

begin
  titulo := TTituloPagarModel.Create;
  titulo.FIDorganizacao := pIDorganizacao;
  titulo.FIDLotePagamento := pLote;
  dmConexao.conectarBanco;

try
   cmd := ' SELECT TP.ID_TITULO_PAGAR,'+
          ' TP.NUMERO_DOCUMENTO, '+
          ' TP.valor_nominal,  '+
          ' TP.DESCRICAO,    '+
          ' TP.id_lote_pagamento,    '+
          ' C.nome,  C.id_cedente    '+
          ' FROM TITULO_PAGAR TP    '+
          ' LEFT OUTER JOIN CEDENTE C ON (C.ID_CEDENTE = TP.ID_CEDENTE) AND (C.ID_ORGANIZACAO = TP.ID_ORGANIZACAO) '+
          ' WHERE TP.ID_ORGANIZACAO = :PIDORGANIZACAO  AND TP.ID_LOTE_PAGAMENTO = :PIDLOTE ' +
          ' ORDER BY TP.VALOR_NOMINAL ' ;


  qryObterTitulos.Close;
  qryObterTitulos.Connection := dmConexao.conn;
  qryObterTitulos.SQL.Clear;
  qryObterTitulos.SQL.Add(cmd);
  qryObterTitulos.ParamByName('PIDORGANIZACAO').AsString := titulo.FIDorganizacao;
  qryObterTitulos.ParamByName('PIDLOTE').AsString := titulo.FIDLotePagamento;
  qryObterTitulos.Open;


except

raise Exception.Create('Erro ao tentar obter TITULO POR LOTE PAGTO');

end;
end;



function TfmTelaImpressaoLotePagamento.preencheGrid : Boolean;
begin

dmConexao.conectarBanco;

 qryPreencheDBGrid.Close;
 qryPreencheDBGrid.Connection := dmConexao.conn;
 qryPreencheDBGrid.ParamByName('PIDORGANIZACAO').AsString :=  pIDorganizacao;
 qryPreencheDBGrid.Open;

 Result := System.True;

end;

procedure TfmTelaImpressaoLotePagamento.exibirRelatorio(tipo: Integer);
var
 retornarCaminhoRelatorio :string;
begin

retornarCaminhoRelatorio := uUtil.TPathRelatorio.getRelatorioLotePagamento;
frxRelLotePagamento.Clear;
  if not(frxRelLotePagamento.LoadFromFile(retornarCaminhoRelatorio))
  then
  begin

  end
  else
  begin
    inicializarVariaveisRelatorio(now, now);
    frxRelLotePagamento.OldStyleProgress := true;
    frxRelLotePagamento.ShowProgress := true;
    frxRelLotePagamento.ShowReport;

  end;
end;



procedure TfmTelaImpressaoLotePagamento.inicializarVariaveisRelatorio(dtInicial, dtFinal: TDate) ;
begin
  with frxRelLotePagamento.Variables do
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
    Variables['strExtenso'] :=   QuotedStr('0');
    Variables['strValidate'] :=   QuotedStr('');

  end;
end;



end.
