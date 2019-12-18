unit uFrmSaldoContas;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, uUtil, udmConexao, uFrameContaBancaria,
  Data.DB, Vcl.Grids, Vcl.DBGrids, FireDAC.Stan.Intf, FireDAC.Stan.Option, System.DateUtils,
  FireDAC.Stan.Param, FireDAC.Stan.Error, FireDAC.DatS, FireDAC.Phys.Intf, System.StrUtils,
  FireDAC.DApt.Intf, FireDAC.Stan.Async, FireDAC.DApt, FireDAC.Comp.DataSet,uDMOrganizacao,
  FireDAC.Comp.Client, uFramePeriodo,
  frxClass, frxDBSet, frxExportCSV,
  frxExportPDF, Vcl.ExtCtrls, frxExportBaseDialog, Vcl.Buttons, cxGraphics,
  cxControls, cxLookAndFeels, cxLookAndFeelPainters, dxSkinsCore,
  dxSkinsDefaultPainters, dxStatusBar;

type
  TfrmSaldoContas = class(TForm)
    frmContaBancaria1: TfrmContaBancaria;
    dbgrd1: TDBGrid;
    dsSaldo: TDataSource;
    qryObterConta: TFDQuery;
    qrySaldosBancarios: TFDQuery;
    btnProcessarSaldo: TButton;
    qryObterTodasContas: TFDQuery;
    qryLimpaDataset: TFDQuery;
    qryPreparaDataset: TFDQuery;
    qryInsereSaldoConta: TFDQuery;
    frmPeriodo1: TfrmPeriodo;
    btnImprimir: TButton;
    frxRelatorioSaldos: TfrxReport;
    frxDBSaldos: TfrxDBDataset;
    frxpdfxprt1: TfrxPDFExport;
    frxCSVExport1: TfrxCSVExport;
    pnl1: TPanel;
    btn1: TBitBtn;
    qrySaldoDebito: TFDQuery;
    qrySaldoCredito: TFDQuery;
    dxStatusBar: TdxStatusBar;
    procedure FormCreate(Sender: TObject);
    procedure btnProcessarSaldoClick(Sender: TObject);
    procedure btnImprimirClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure dbgrd1DrawColumnCell(Sender: TObject; const Rect: TRect; DataCol: Integer; Column: TColumn; State: TGridDrawState);
    procedure dsSaldoDataChange(Sender: TObject; Field: TField);
    procedure btn1Click(Sender: TObject);
    procedure frmContaBancaria1cbbContaChange(Sender: TObject);

  private
    { Private declarations }
     FsListaIdContas : TStringList;
    idConta, idOrganizacao :string;
    pDataInicial, pDataFinal :TDate;

    function obterTodosSaldos(pIdOrganizacao :string): Boolean;
    function obterSaldoPorConta(pIdOrganizacao,pIdConta :string): Boolean;
    function limpaDataSet() : Boolean;
    function preparaDataSet(pIdConta,pAno :string): Boolean;
    procedure preparaDadosExibir(pIdOrganizacao, pIdConta: String);
    function insereSaldos(piDconta, pMes :string; pValorSaldo :Currency): Boolean;

    procedure preencheComboAno();
    procedure limpaPanel;
    procedure exibirRelatorioSaldos(dtInicial, dtFinal: TDate);
    procedure inicializarVariaveisRelatorio(dtInicial, dtFinal: TDate);
    function retornarCaminhoRelatorio: string;
    procedure alinharColsGrid(pDbGrid: TDBGrid; qtdCol :Integer);

    //usando
    function obterSaldoAnterior(pIdOrganizacao, pIDConta: string; pDataInicial,
      pDataFinal: TDate): Currency;
    function obterSaldoPorContaCredito(pIdOrganizacao, pIDConta: string;
      pDataInicial, pDataFinal: TDate): Currency;
    function obterSaldoPorContaDebito(pIdOrganizacao, pIDConta: string;
      pDataInicial, pDataFinal: TDate): Currency;
    procedure limpaStatusBar;
    procedure msgStatusBar(pPosicao: Integer; msg: string);




  public
    { Public declarations }
  end;

var
  frmSaldoContas: TfrmSaldoContas;

implementation

{$R *.dfm}

procedure TfrmSaldoContas.alinharColsGrid(pDbGrid: TDBGrid; qtdCol :Integer);
var
  I: Integer;
begin
  //alinha apenas os titulos das colunas
  //recebe o DBGRID e a quantidade de colunas que ele possu


  for I := 0 to qtdCol-1 do begin
     pDbGrid.Columns[I].Title.alignment := taCenter;
  end;

end;

procedure TfrmSaldoContas.btn1Click(Sender: TObject);
begin
   PostMessage(Self.Handle, WM_CLOSE, 0, 0);
end;

procedure TfrmSaldoContas.btnImprimirClick(Sender: TObject);
begin
 pDataInicial :=  frmPeriodo1.getDataInicial;
 pDataFinal   := frmPeriodo1.getDataFinal;

  if (qrySaldosBancarios.RecordCount > 0) then
  begin
    exibirRelatorioSaldos(pDataInicial, pDataFinal);
    limpaPanel;
  end
  else
  begin
    btnImprimir.Enabled := false;
    ShowMessage('N�o existem dados para imprimir.');
  end;

  msgStatusBar(1,'Relat�rio sendo impresso.');

end;



procedure TfrmSaldoContas.exibirRelatorioSaldos( dtInicial, dtFinal: TDate);
begin

  frxRelatorioSaldos.Clear;

  if not(frxRelatorioSaldos.LoadFromFile(retornarCaminhoRelatorio)) then
  begin

  end
  else
  begin
    inicializarVariaveisRelatorio(dtInicial, dtFinal);
    frxRelatorioSaldos.OldStyleProgress := True;
    frxRelatorioSaldos.ShowProgress := True;
    frxRelatorioSaldos.ShowReport;
  end;
end;


function TfrmSaldoContas.retornarCaminhoRelatorio: string;
begin
    Result := uUtil.TPathRelatorio.getRelatorioSaldos;
end;


procedure TfrmSaldoContas.inicializarVariaveisRelatorio(dtInicial, dtFinal: TDate);
begin

  with frxRelatorioSaldos.Variables do
  begin


    if dmOrganizacao.qryDadosEmpresa.RecordCount < 1 then begin

       dmOrganizacao.carregarDadosOrganizacao(idOrganizacao);

    end;


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
    Variables['strUF'] :=
      QuotedStr(dmOrganizacao.qryDadosEmpresa.FieldByName('UF').AsString);
    Variables['strPeriodo'] :=QuotedStr( FormatDateTime('yyyy', pDataInicial));
  end;

end;

procedure TfrmSaldoContas.btnProcessarSaldoClick(Sender: TObject);
var
aux :Integer;
idConta, itemPedido : string;
begin
  pDataInicial :=  frmPeriodo1.getDataInicial;
  pDataFinal   := frmPeriodo1.getDataFinal;
  idConta := FsListaIdContas[frmContaBancaria1.cbbConta.ItemIndex];
  dbgrd1.DataSource.DataSet.Close;
  btnProcessarSaldo.Enabled := False;
  msgStatusBar(1,'Processando...');

    // descConta := frmContaBancaria1.cbbConta.Items[frmContaBancaria1.cbbConta.ItemIndex];
  if ((idConta.Equals('0')) or (idConta.Equals('Sem ID'))) then
  begin //nao foi escolhida uma conta v�lida e ent�o precisa trazer de todas

    obterTodosSaldos(idOrganizacao);
  end
  else
  begin
  //passou uma conta especifica
    if frmContaBancaria1.cbbConta.ItemIndex > 0 then
    begin
      obterSaldoPorConta(idOrganizacao, idConta);
    end
    else
    begin

      obterTodosSaldos(idOrganizacao);

    end;
  end;

    msgStatusBar(1,'Saldos processados. Prontos para impress�o.');

end;

procedure TfrmSaldoContas.dbgrd1DrawColumnCell(Sender: TObject;
  const Rect: TRect; DataCol: Integer; Column: TColumn; State: TGridDrawState);
var
  pValor :Currency;

begin

 pValor := qrySaldosBancarios.FieldByName('JANEIRO').AsCurrency ;


  if (( qrySaldosBancarios.RecNo  mod  2) = 0)  then begin //se for linha par.. printa

      dbgrd1.Canvas.Brush.Color := clSilver;
  end;

  alinharColsGrid(dbgrd1, dbgrd1.Columns.Count);

  //  navega com setas e mantem efeito de linha selecionada

  if Rect.Top = TStringGrid(dbgrd1).CellRect(0, TStringGrid(dbgrd1).Row).Top then
 begin
  dbgrd1.Canvas.FillRect(Rect);
  dbgrd1.Canvas.Font.Color := clWhite;
  dbgrd1.Canvas.Brush.Color := clHighlight;
  dbgrd1.DefaultDrawDataCell(Rect, Column.Field, State)
 end;



   dbgrd1.DefaultDrawColumnCell(Rect,DataCol,Column,State);
end;


procedure TfrmSaldoContas.dsSaldoDataChange(Sender: TObject; Field: TField);
begin
  {Remove barra horizontal do DBgrid1}
   ShowScrollBar(dbgrd1.handle, SB_VERT, False);

end;

procedure TfrmSaldoContas.FormClose(Sender: TObject; var Action: TCloseAction);
begin

 Action := caFree; // sempre como ultimo comando

end;

procedure TfrmSaldoContas.FormCreate(Sender: TObject);
begin

  dmConexao.conectarBanco;

  if not uUtil.Empty(TOrgAtual.getId) then begin
      idOrganizacao := TOrgAtual.getId;
  end;


  if not Assigned(dmOrganizacao) then begin
    dmOrganizacao := TdmOrganizacao.Create(self);
  end;

  limpaPanel;



end;

procedure TfrmSaldoContas.frmContaBancaria1cbbContaChange(Sender: TObject);
begin
 if frmContaBancaria1.cbbConta.ItemIndex > (-2) then begin
    btnProcessarSaldo.Enabled := True;
 end;
end;

function TfrmSaldoContas.insereSaldos(piDconta, pMes: string;  pValorSaldo: Currency): Boolean;
var
cmdSql :string;
begin
  dmConexao.conectarBanco;

cmdSql :=   ' UPDATE CONTA_BANCARIA_SALDO ' +
            ' SET ' + pMes  + ' = :PVALOR WHERE ID_CONTA_BANCARIA = :PIDCONTA ' ;

  try


    qryInsereSaldoConta.Close;
    qryInsereSaldoConta.Connection := dmConexao.conn;
    qryInsereSaldoConta.SQL.Clear;
    qryInsereSaldoConta.SQL.Add(cmdSql);

    qryInsereSaldoConta.ParamByName('PIDCONTA').AsString := piDconta;
    qryInsereSaldoConta.ParamByName('PVALOR').AsCurrency := pValorSaldo;
    qryInsereSaldoConta.ExecSQL;

    dmConexao.conn.CommitRetaining;

  except

  raise Exception.Create('Erro ao tentar inserir o saldo ');

  end;



end;

procedure TfrmSaldoContas.preencheComboAno;
var
dataHoje :TDateTime;
anoAtual: Integer;
  I: Integer;

begin
  dataHoje := uutil.getDataServer;
  anoAtual := StrToInt(FormatDateTime('yyyy', dataHoje));

end;


function TfrmSaldoContas.limpaDataSet: Boolean;
begin
  dmConexao.conectarBanco;

  try

    qryLimpaDataset.Close;
    qryLimpaDataset.Connection := dmConexao.conn;
    qryLimpaDataset.ExecSQL;

    dmConexao.conn.CommitRetaining;

  except
  raise Exception.Create('Erro ao tentar limpar a tabela de saldos...');

  end;

      Result := System.True;

end;

function TfrmSaldoContas.preparaDataSet(pIdConta, pAno: string): Boolean;
begin

 dmConexao.conectarBanco;

 try

   qryPreparaDataset.Close;
   qryPreparaDataset.Connection := dmConexao.conn;
   qryPreparaDataset.ParamByName('PIDCONTA').AsString :=pIdConta;
   qryPreparaDataset.ParamByName('PANO').AsString :=Pano;
   qryPreparaDataset.ExecSQL;


   dmConexao.conn.CommitRetaining;
   Result := System.True;

 except
  Result := System.False;
  dmConexao.conn.RollbackRetaining;

 raise Exception.Create('Erro ao preparar a tabela de base');


 end;


    Result := System.True;

end;

procedure TfrmSaldoContas.limpaPanel;
begin

 FsListaIdContas := TStringList.Create;

 frmContaBancaria1.obterTodos(idOrganizacao, frmContaBancaria1.cbbConta, FsListaIdContas);
 frmContaBancaria1.cbbConta.Items.Add('TODAS AS CONTAS ');
 FsListaIdContas.Add('0');

 frmPeriodo1.inicializa(Now, Now );
 pDataInicial :=  frmPeriodo1.getDataInicial;
 pDataFinal   := frmPeriodo1.getDataFinal;
 btnImprimir.Enabled := False;
 limpaStatusBar;

 btnProcessarSaldo.Enabled := True;

end;




function TfrmSaldoContas.obterSaldoPorConta(pIdOrganizacao, pIdConta: string): Boolean;
var
pAno :string;
begin
// fazer igual fez na obter todos... s� que por conta
   msgStatusBar(1,'Processando...');
   dmConexao.conectarBanco;
   limpaDataSet;  //deleta tudo que estiver na tabela do saldo


if frmContaBancaria1.cbbConta.ItemIndex >0 then begin
  pAno := FormatDateTime('yyyy', frmPeriodo1.getDataInicial);
  idConta := FsListaIdContas[frmContaBancaria1.cbbConta.ItemIndex];
  preparaDataSet(idConta, pAno);
  preparaDadosExibir(idOrganizacao, idConta );

end;


end;

function TfrmSaldoContas.obterTodosSaldos(pIdOrganizacao: string): Boolean;
var
pConta, pCampo, pMes,pAno,idConta :string;
vlrSaldoAnterior, vlrGlobal, vlrCR, vlrDB, vlrSaldo :Currency;
 anoAnt, I: Integer;
  pDataInicial, pDataFinal, pDataAnterior :string;
  dtInicial, dtFinal :TDate;

begin
  msgStatusBar(1,'Processando...');
  pAno := FormatDateTime('yyyy', frmPeriodo1.getDataInicial);

 if uUtil.Empty(pAno)  then begin pAno := FormatDateTime('yyyy', uUtil.getDataServer); end; 

   anoAnt := StrToInt(pAno) - 1;

   dmConexao.conectarBanco;
   limpaDataSet;  //deleta tudo que estiver na tabela do saldo

  try
   qryObterTodasContas.Close;
   qryObterTodasContas.Connection := dmConexao.conn;
   qryObterTodasContas.ParamByName('PIDORGANIZACAO').AsString := pIdOrganizacao;
   qryObterTodasContas.Open;
   qryObterTodasContas.First;

  except
  raise Exception.Create('Erro ao tentar obter todas as contas banc�rias... ');

  end;

  if qryObterTodasContas.RecordCount >0  then begin
     btnImprimir.Enabled := True;
     qryObterTodasContas.First;

      //insere as contas existentes para o ano determinado
      while not qryObterTodasContas.Eof do begin
           idConta := qryObterTodasContas.FieldByName('ID_CONTA_BANCARIA').AsString;
           preparaDataSet(idConta, pAno);
           qryObterTodasContas.Next;
      end;

      //alterar a tupla preparada acima
      // com o saldo encontrado para o mes determinado
      qryObterTodasContas.First;
      while not qryObterTodasContas.Eof do begin

         idConta := qryObterTodasContas.FieldByName('ID_CONTA_BANCARIA').AsString;
         preparaDadosExibir(idOrganizacao, idConta );

         qryObterTodasContas.Next;

      end;



  end;



end;



function TfrmSaldoContas.obterSaldoAnterior(pIdOrganizacao, pIDConta: string;   pDataInicial, pDataFinal: TDate): Currency;
  var
  valorDB, valorCR,  vlrSaldo : Currency;
  pDataInicio: TDate  ;
begin
   valorDB :=0; valorCR :=0;  vlrSaldo :=0;
   pDataInicio :=  StrToDate('01/01/1990');


  try

      valorDB := obterSaldoPorContaDebito(pIdOrganizacao, pIDConta, pDataInicio,IncDay(pDataInicial, -1));
      valorCR := obterSaldoPorContaCredito(pIdOrganizacao, pIDConta, pDataInicio,IncDay(pDataInicial, -1));

      vlrSaldo := valorCR - valorDB;


  except

  raise Exception.Create('Erro ao obter saldo anterior...');

  end;

   Result := vlrSaldo;
end;



function TfrmSaldoContas.obterSaldoPorContaDebito(pIdOrganizacao, pIDConta: string;   pDataInicial, pDataFinal: TDate): Currency;
  var
  valor : Currency;
begin

  valor :=0;

    dmConexao.conectarBanco;
    try

      qrySaldoDebito.Close;
      qrySaldoDebito.Connection := dmConexao.conn;
      qrySaldoDebito.ParamByName('PIDORGANIZACAO').AsString := pIdOrganizacao;
      qrySaldoDebito.ParamByName('PIDCONTA').AsString       := pIDConta ;
      qrySaldoDebito.ParamByName('DTDATAINICIAL').AsDate    := pDataInicial;
      qrySaldoDebito.ParamByName('DTDATAFINAL').AsDate      := pDataFinal;
      qrySaldoDebito.Open;

      if not qrySaldoDebito.IsEmpty then
       valor := qrySaldoDebito.FieldByName('SALDO').AsCurrency;

        except
    raise Exception.Create('Erro ao obter saldo d�bito ');
    end;

     Result := valor;
end;


function TfrmSaldoContas.obterSaldoPorContaCredito(pIdOrganizacao, pIDConta: string;
  pDataInicial, pDataFinal: TDate): Currency;
  var
  valor : Currency;
begin

  valor :=0;


    dmConexao.conectarBanco;
    try

      qrySaldoCredito.Close;
      qrySaldoCredito.Connection := dmConexao.conn;
      qrySaldoCredito.ParamByName('PIDORGANIZACAO').AsString := pIdOrganizacao;
      qrySaldoCredito.ParamByName('PIDCONTA').AsString       := pIDConta ;
      qrySaldoCredito.ParamByName('DTDATAINICIAL').AsDate    := pDataInicial;
      qrySaldoCredito.ParamByName('DTDATAFINAL').AsDate      := pDataFinal;
      qrySaldoCredito.Open;

      if not qrySaldoCredito.IsEmpty then
       valor := qrySaldoCredito.FieldByName('SALDO').AsCurrency;



    except
    raise Exception.Create('Erro ao obter saldo cr�dito ');
    end;

    Result := valor;

end;

procedure TfrmSaldoContas.preparaDadosExibir(pIdOrganizacao, pIdConta :String );
var
pConta, pCampo, pMes,pAno,idConta :string;
vlrSaldoAnterior, vlrGlobal, vlrCR, vlrDB, vlrSaldo :Currency;
 anoAnt, I: Integer;
  pDataInicial, pDataFinal, pDataAnterior :string;
  dtInicial, dtFinal :TDate;

begin
  pAno := FormatDateTime('yyyy', frmPeriodo1.getDataInicial);
  idConta := pIdConta;

 if uUtil.Empty(pAno)  then begin pAno := FormatDateTime('yyyy', uUtil.getDataServer); end;

   anoAnt := StrToInt(pAno) - 1;


 //fazer isso para o ano inteiro. A cada mes em separado

           vlrCR :=0; vlrDB :=0; vlrGlobal :=0; vlrSaldo :=0;

            if  (StrToInt(FormatDateTime('mm',now))) >= 1 then begin

                  pMes := '01'; pCampo := 'JANE';
                  pDataInicial  := '01'  + '/'+ pMes + '/' + pAno;
                  dtFinal := EndOfTheMonth(StrToDate(pDataInicial ));
                  pDataFinal    := FormatDateTime('dd',dtFinal)  + '/'+ pMes + '/' + pAno;


                  vlrSaldoAnterior := obterSaldoAnterior(idOrganizacao, idConta, StrToDate(pDataInicial), StrToDate(pDataFinal));
                  vlrDB := obterSaldoPorContaDebito(pIdOrganizacao, idConta, StrToDate(pDataInicial), StrToDate(pDataFinal));
                  vlrCR := obterSaldoPorContaCredito(pIdOrganizacao, idConta, StrToDate(pDataInicial), StrToDate(pDataFinal));

                  vlrSaldo := vlrSaldoAnterior + (vlrCR - vlrDB);
                  insereSaldos(idConta,pCampo,vlrSaldo );

            end;

             vlrCR :=0; vlrDB :=0;  vlrSaldo :=0;

            if  (StrToInt(FormatDateTime('mm',now))) >= 2 then begin


                  pMes := '02'; pCampo := 'FEVE';
                  pDataInicial := '01' +'/'+pMes+'/'+pAno;
                  dtFinal := EndOfTheMonth(StrToDate(pDataInicial ));
                  pDataFinal    := FormatDateTime('dd',dtFinal)  + '/'+ pMes + '/' + pAno;
                  vlrSaldoAnterior := obterSaldoAnterior(idOrganizacao, idConta, StrToDate(pDataInicial), StrToDate(pDataFinal));
                  vlrDB := obterSaldoPorContaDebito(pIdOrganizacao, idConta, StrToDate(pDataInicial), StrToDate(pDataFinal));
                  vlrCR := obterSaldoPorContaCredito(pIdOrganizacao, idConta, StrToDate(pDataInicial), StrToDate(pDataFinal));

                  vlrSaldo := vlrSaldoAnterior + (vlrCR - vlrDB);
                  insereSaldos(idConta,pCampo,vlrSaldo );

             end;


             vlrCR :=0; vlrDB :=0; vlrSaldo :=0;

            if  (StrToInt(FormatDateTime('mm',now))) >= 3 then begin


                pMes := '03'; pCampo := 'MARC';
                pDataInicial := '01' +'/'+pMes+'/'+pAno;
                dtFinal := EndOfTheMonth(StrToDate(pDataInicial ));
                pDataFinal    := FormatDateTime('dd',dtFinal)  + '/'+ pMes + '/' + pAno;
                  vlrSaldoAnterior := obterSaldoAnterior(idOrganizacao, idConta, StrToDate(pDataInicial), StrToDate(pDataFinal));
                  vlrDB := obterSaldoPorContaDebito(pIdOrganizacao, idConta, StrToDate(pDataInicial), StrToDate(pDataFinal));
                  vlrCR := obterSaldoPorContaCredito(pIdOrganizacao, idConta, StrToDate(pDataInicial), StrToDate(pDataFinal));

                  vlrSaldo := vlrSaldoAnterior + (vlrCR - vlrDB);
                  insereSaldos(idConta,pCampo,vlrSaldo );

             end;


               vlrCR :=0; vlrDB :=0;  vlrSaldo :=0;

            if  (StrToInt(FormatDateTime('mm',now))) >= 4 then begin

                pMes := '04'; pCampo := 'ABRI';
                pDataInicial := '01' +'/'+pMes+'/'+pAno;
                dtFinal := EndOfTheMonth(StrToDate(pDataInicial ));
                pDataFinal    := FormatDateTime('dd',dtFinal)  + '.'+ pMes + '.' + pAno;
               pDataFinal    := FormatDateTime('dd',dtFinal)  + '/'+ pMes + '/' + pAno;
                  vlrSaldoAnterior := obterSaldoAnterior(idOrganizacao, idConta, StrToDate(pDataInicial), StrToDate(pDataFinal));
                  vlrDB := obterSaldoPorContaDebito(pIdOrganizacao, idConta, StrToDate(pDataInicial), StrToDate(pDataFinal));
                  vlrCR := obterSaldoPorContaCredito(pIdOrganizacao, idConta, StrToDate(pDataInicial), StrToDate(pDataFinal));

                  vlrSaldo := vlrSaldoAnterior + (vlrCR - vlrDB);
                  insereSaldos(idConta,pCampo,vlrSaldo );

             end;

               vlrCR :=0; vlrDB :=0; vlrSaldo :=0;

            if  (StrToInt(FormatDateTime('mm',now))) >= 5 then begin

                pMes := '05'; pCampo := 'MAIO';
                pDataInicial := '01' +'/'+pMes+'/'+pAno;
                dtFinal := EndOfTheMonth(StrToDate(pDataInicial ));
               pDataFinal    := FormatDateTime('dd',dtFinal)  + '/'+ pMes + '/' + pAno;
                  vlrSaldoAnterior := obterSaldoAnterior(idOrganizacao, idConta, StrToDate(pDataInicial), StrToDate(pDataFinal));
                  vlrDB := obterSaldoPorContaDebito(pIdOrganizacao, idConta, StrToDate(pDataInicial), StrToDate(pDataFinal));
                  vlrCR := obterSaldoPorContaCredito(pIdOrganizacao, idConta, StrToDate(pDataInicial), StrToDate(pDataFinal));

                  vlrSaldo := vlrSaldoAnterior + (vlrCR - vlrDB);
                  insereSaldos(idConta,pCampo,vlrSaldo );

             end;

           vlrCR :=0; vlrDB :=0; vlrSaldo :=0;

            if  (StrToInt(FormatDateTime('mm',now))) >= 6 then begin

                pMes := '06'; pCampo := 'JUNH';
                pDataInicial := '01' +'/'+pMes+'/'+pAno;
                dtFinal := EndOfTheMonth(StrToDate(pDataInicial ));
                pDataFinal    := FormatDateTime('dd',dtFinal)  + '/'+ pMes + '/' + pAno;
                  vlrSaldoAnterior := obterSaldoAnterior(idOrganizacao, idConta, StrToDate(pDataInicial), StrToDate(pDataFinal));
                  vlrDB := obterSaldoPorContaDebito(pIdOrganizacao, idConta, StrToDate(pDataInicial), StrToDate(pDataFinal));
                  vlrCR := obterSaldoPorContaCredito(pIdOrganizacao, idConta, StrToDate(pDataInicial), StrToDate(pDataFinal));

                  vlrSaldo := vlrSaldoAnterior + (vlrCR - vlrDB);
                  insereSaldos(idConta,pCampo,vlrSaldo );

             end;


               vlrCR :=0; vlrDB :=0; vlrSaldo :=0;

            if  (StrToInt(FormatDateTime('mm',now))) >= 7 then begin

                pMes := '07'; pCampo := 'JULH';
                pDataInicial := '01' +'/'+pMes+'/'+pAno;
                dtFinal := EndOfTheMonth(StrToDate(pDataInicial ));
                pDataFinal    := FormatDateTime('dd',dtFinal)  + '/'+ pMes + '/' + pAno;
                  vlrSaldoAnterior := obterSaldoAnterior(idOrganizacao, idConta, StrToDate(pDataInicial), StrToDate(pDataFinal));
                  vlrDB := obterSaldoPorContaDebito(pIdOrganizacao, idConta, StrToDate(pDataInicial), StrToDate(pDataFinal));
                  vlrCR := obterSaldoPorContaCredito(pIdOrganizacao, idConta, StrToDate(pDataInicial), StrToDate(pDataFinal));

                  vlrSaldo := vlrSaldoAnterior + (vlrCR - vlrDB);
                  insereSaldos(idConta,pCampo,vlrSaldo );

             end;

               vlrCR :=0; vlrDB :=0; vlrSaldo :=0;

            if  (StrToInt(FormatDateTime('mm',now))) >= 8 then begin

                pMes := '08'; pCampo := 'AGOS';
                pDataInicial := '01' +'/'+pMes+'/'+pAno;
                dtFinal := EndOfTheMonth(StrToDate(pDataInicial ));
                pDataFinal    := FormatDateTime('dd',dtFinal)  + '/'+ pMes + '/' + pAno;
                  vlrSaldoAnterior := obterSaldoAnterior(idOrganizacao, idConta, StrToDate(pDataInicial), StrToDate(pDataFinal));
                  vlrDB := obterSaldoPorContaDebito(pIdOrganizacao, idConta, StrToDate(pDataInicial), StrToDate(pDataFinal));
                  vlrCR := obterSaldoPorContaCredito(pIdOrganizacao, idConta, StrToDate(pDataInicial), StrToDate(pDataFinal));

                  vlrSaldo := vlrSaldoAnterior + (vlrCR - vlrDB);
                  insereSaldos(idConta,pCampo,vlrSaldo );

             end;




               vlrCR :=0; vlrDB :=0; vlrSaldo :=0;

            if  (StrToInt(FormatDateTime('mm',now))) >= 9 then begin

                pMes := '09'; pCampo := 'SETE';
                pDataInicial := '01' +'/'+pMes+'/'+pAno;
                dtFinal := EndOfTheMonth(StrToDate(pDataInicial ));
              pDataFinal    := FormatDateTime('dd',dtFinal)  + '/'+ pMes + '/' + pAno;
                  vlrSaldoAnterior := obterSaldoAnterior(idOrganizacao, idConta, StrToDate(pDataInicial), StrToDate(pDataFinal));
                  vlrDB := obterSaldoPorContaDebito(pIdOrganizacao, idConta, StrToDate(pDataInicial), StrToDate(pDataFinal));
                  vlrCR := obterSaldoPorContaCredito(pIdOrganizacao, idConta, StrToDate(pDataInicial), StrToDate(pDataFinal));

                  vlrSaldo := vlrSaldoAnterior + (vlrCR - vlrDB);
                  insereSaldos(idConta,pCampo,vlrSaldo );

             end;




              vlrCR :=0; vlrDB :=0; vlrSaldo :=0;

            if  (StrToInt(FormatDateTime('mm',now))) >= 10 then begin

                pMes := '10'; pCampo := 'OUTU';
                pDataInicial := '01' +'/'+pMes+'/'+pAno;
                dtFinal := EndOfTheMonth(StrToDate(pDataInicial ));
                pDataFinal    := FormatDateTime('dd',dtFinal)  + '/'+ pMes + '/' + pAno;
                  vlrSaldoAnterior := obterSaldoAnterior(idOrganizacao, idConta, StrToDate(pDataInicial), StrToDate(pDataFinal));
                  vlrDB := obterSaldoPorContaDebito(pIdOrganizacao, idConta, StrToDate(pDataInicial), StrToDate(pDataFinal));
                  vlrCR := obterSaldoPorContaCredito(pIdOrganizacao, idConta, StrToDate(pDataInicial), StrToDate(pDataFinal));

                  vlrSaldo := vlrSaldoAnterior + (vlrCR - vlrDB);
                  insereSaldos(idConta,pCampo,vlrSaldo );

             end;

               vlrCR :=0; vlrDB :=0; vlrSaldo :=0;

            if  (StrToInt(FormatDateTime('mm',now))) >= 11 then begin

                pMes := '11'; pCampo := 'NOVE';
                pDataInicial := '01' +'/'+pMes+'/'+pAno;
                dtFinal := EndOfTheMonth(StrToDate(pDataInicial ));
                 pDataFinal    := FormatDateTime('dd',dtFinal)  + '/'+ pMes + '/' + pAno;
                  vlrSaldoAnterior := obterSaldoAnterior(idOrganizacao, idConta, StrToDate(pDataInicial), StrToDate(pDataFinal));
                  vlrDB := obterSaldoPorContaDebito(pIdOrganizacao, idConta, StrToDate(pDataInicial), StrToDate(pDataFinal));
                  vlrCR := obterSaldoPorContaCredito(pIdOrganizacao, idConta, StrToDate(pDataInicial), StrToDate(pDataFinal));

                  vlrSaldo := vlrSaldoAnterior + (vlrCR - vlrDB);
                  insereSaldos(idConta,pCampo,vlrSaldo );

             end;

              vlrCR :=0; vlrDB :=0; vlrSaldo :=0;

           if  (StrToInt(FormatDateTime('mm',now))) >= 12 then begin

                vlrCR :=0; vlrDB :=0; vlrSaldo :=0;
                pMes := '12'; pCampo := 'DEZE';
                pDataInicial := '01' +'/'+pMes+'/'+pAno;
                dtFinal := EndOfTheMonth(StrToDate(pDataInicial ));
                pDataFinal    := FormatDateTime('dd',dtFinal)  + '/'+ pMes + '/' + pAno;
                  vlrSaldoAnterior := obterSaldoAnterior(idOrganizacao, idConta, StrToDate(pDataInicial), StrToDate(pDataFinal));
                  vlrDB := obterSaldoPorContaDebito(pIdOrganizacao, idConta, StrToDate(pDataInicial), StrToDate(pDataFinal));
                  vlrCR := obterSaldoPorContaCredito(pIdOrganizacao, idConta, StrToDate(pDataInicial), StrToDate(pDataFinal));

                  vlrSaldo := vlrSaldoAnterior + (vlrCR - vlrDB);
                  insereSaldos(idConta,pCampo,vlrSaldo );

           end;


   qrySaldosBancarios.Close;
   qrySaldosBancarios.Connection := dmConexao.conn;
   qrySaldosBancarios.Open;

   if not qrySaldosBancarios.IsEmpty then begin

     btnImprimir.Enabled := True;
   end else begin      btnImprimir.Enabled := False; end;

end;


procedure TfrmSaldoContas.limpaStatusBar;
begin
dxStatusBar.Panels[0].Text := 'Status ';
dxStatusBar.Panels[1].Text := 'Escolha uma conta banc�ria caso deseje ou clique em processar para todas! ';
end;

procedure TfrmSaldoContas.msgStatusBar(pPosicao : Integer; msg :string);
begin
dxStatusBar.Panels[pPosicao].Text := msg;
Application.ProcessMessages;
end;

end.
