unit uFrmSaldoContas;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, uUtil, udmConexao, uFrameContaBancaria,
  Data.DB, Vcl.Grids, Vcl.DBGrids, FireDAC.Stan.Intf, FireDAC.Stan.Option, System.DateUtils,
  FireDAC.Stan.Param, FireDAC.Stan.Error, FireDAC.DatS, FireDAC.Phys.Intf, System.StrUtils,
  FireDAC.DApt.Intf, FireDAC.Stan.Async, FireDAC.DApt, FireDAC.Comp.DataSet,uDMOrganizacao,
  FireDAC.Comp.Client, uFramePeriodo, frxClass, frxDBSet, frxExportCSV,
  frxExportPDF, Vcl.ExtCtrls;

type
  TfrmSaldoContas = class(TForm)
    frmContaBancaria1: TfrmContaBancaria;
    dbgrd1: TDBGrid;
    dsSaldo: TDataSource;
    qryCRTodasPeriodo: TFDQuery;
    qryObterConta: TFDQuery;
    qrySaldosBancarios: TFDQuery;
    btnProcessarSaldo: TButton;
    qryObterTodasContas: TFDQuery;
    qryDBTodasPeriodo: TFDQuery;
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
    procedure FormCreate(Sender: TObject);
    procedure btnProcessarSaldoClick(Sender: TObject);
    procedure btnImprimirClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure dbgrd1DrawColumnCell(Sender: TObject; const Rect: TRect; DataCol: Integer; Column: TColumn; State: TGridDrawState);
    procedure dsSaldoDataChange(Sender: TObject; Field: TField);

  private
    { Private declarations }
     FsListaIdContas : TStringList;
    idConta, idOrganizacao :string;
    pDataInicial, pDataFinal :TDate;

    function obterTodosSaldos(pIdOrganizacao :string): Boolean;
    function obterSaldoPorCOnta(pIdOrganizacao,pIdConta :string): Boolean;
    function obterCreditoContas(pIdOrganizacao, pIdConta, pDataInicial, pDataFinal :String): Currency;
    function limpaDataSet() : Boolean;
    function preparaDataSet(pIdConta,pAno :string): Boolean;
    function insereSaldos(piDconta, pMes :string; pValorSaldo :Currency): Boolean;



    procedure preencheComboAno();
    procedure limpaPanel;
    function obterDebitoContas(pIdOrganizacao, pIdConta, pDataInicial,  pDataFinal: String): Currency;
    procedure exibirRelatorioSaldos(dtInicial, dtFinal: TDate);
    procedure inicializarVariaveisRelatorio(dtInicial, dtFinal: TDate);
    function retornarCaminhoRelatorio: string;
    procedure alinharColsGrid(pDbGrid: TDBGrid; qtdCol :Integer);



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
  end



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

    // descConta := frmContaBancaria1.cbbConta.Items[frmContaBancaria1.cbbConta.ItemIndex];

 if ( (idConta.Equals('0')) OR (idConta.Equals('Sem ID')) )  then begin //nao foi escolhida uma conta v�lida e ent�o precisa trazer de todas

   obterTodosSaldos(idOrganizacao);
 end else begin
  //passou uma conta especifica

    ShowMessage('Rotina em testes.  Ser�o apresentadas toads as contas banc�rias ...');
       obterTodosSaldos(idOrganizacao);

 end;

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

 if Assigned(dmOrganizacao) then begin
     FreeAndNil(dmOrganizacao);
 end;

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

 except
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



end;

function TfrmSaldoContas.obterCreditoContas(pIdOrganizacao, pIdConta,   pDataInicial, pDataFinal: String): Currency;
  var
  valorCredito :Currency;
begin

  valorCredito :=0;
  dmConexao.conectarBanco;

  qryCRTodasPeriodo.Close;
  qryCRTodasPeriodo.Connection := dmConexao.conn;
  qryCRTodasPeriodo.ParamByName('PIDORGANIZACAO').AsString := pIdOrganizacao;
  qryCRTodasPeriodo.ParamByName('PDATAINICIAL').AsString := pDataInicial;
  qryCRTodasPeriodo.ParamByName('PDATAFINAL').AsString := pDataFinal;
  qryCRTodasPeriodo.ParamByName('PIDCONTA').AsString :=pIdConta;
  qryCRTodasPeriodo.Open;
  qryCRTodasPeriodo.First;


  while not qryCRTodasPeriodo.Eof do begin

    valorCredito := valorCredito + qryCRTodasPeriodo.FieldByName('VALOR_CR').AsCurrency;

           qryCRTodasPeriodo.Next;

  end;


   Result := valorCredito;



end;


function TfrmSaldoContas.obterDebitoContas(pIdOrganizacao, pIdConta,   pDataInicial, pDataFinal: String): Currency;
  var
  valorDebito :Currency;
begin

  valorDebito :=0;
  dmConexao.conectarBanco;

  qryDBTodasPeriodo.Close;
  qryDBTodasPeriodo.Connection := dmConexao.conn;
  qryDBTodasPeriodo.ParamByName('PIDORGANIZACAO').AsString := pIdOrganizacao;
  qryDBTodasPeriodo.ParamByName('PDATAINICIAL').AsString := pDataInicial;
  qryDBTodasPeriodo.ParamByName('PDATAFINAL').AsString := pDataFinal;
  qryDBTodasPeriodo.ParamByName('PIDCONTA').AsString :=pIdConta;
  qryDBTodasPeriodo.Open;
  qryDBTodasPeriodo.First;


  while not qryDBTodasPeriodo.Eof do begin

    valorDebito := valorDebito + qryDBTodasPeriodo.FieldByName('VALOR_DB').AsCurrency;

    qryDBTodasPeriodo.Next;

  end;


   Result := valorDebito;

end;


function TfrmSaldoContas.obterSaldoPorCOnta(pIdOrganizacao, pIdConta: string): Boolean;
begin
// fazer igual fez na obter todos... s� que por conta


end;

function TfrmSaldoContas.obterTodosSaldos(pIdOrganizacao: string): Boolean;
var
pCampo, pMes,pAno,idConta :string;
vlrGlobal, vlrCR, vlrDB, vlrSaldo :Currency;
 anoAnt, I: Integer;
  pDataInicial, pDataFinal, pDataAnterior :string;
  dtInicial, dtFinal :TDate;

begin
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

      qryObterTodasContas.First;
      while not qryObterTodasContas.Eof do begin
           idConta := qryObterTodasContas.FieldByName('ID_CONTA_BANCARIA').AsString;
           preparaDataSet(idConta, pAno);
           btnImprimir.Enabled := True;
           qryObterTodasContas.Next;
      end;


      qryObterTodasContas.First;
      while not qryObterTodasContas.Eof do begin

         idConta := qryObterTodasContas.FieldByName('ID_CONTA_BANCARIA').AsString;

        //fazer isso para o ano inteiro. A cada mes em separado

         for I := 1 to 12 do begin

           vlrCR :=0; vlrDB :=0; vlrSaldo :=0;

             if I = 1  then begin
                pMes := '01'; pCampo := 'JANE';
                pDataInicial  := '01'  + '/'+ pMes + '/' + pAno;
                dtFinal := EndOfTheMonth(StrToDate(pDataInicial ));
                pDataFinal    := FormatDateTime('dd',dtFinal)  + '.'+ pMes + '.' + pAno;

                pDataAnterior := '31' +'.12.' + IntToStr(anoAnt);

               vlrGlobal :=  (obterCreditoContas(pIdOrganizacao, idConta, '01.01.1900', pDataAnterior ) - obterDebitoContas(pIdOrganizacao, idConta, '01.01.1900', pDataAnterior ));

               vlrCR   := obterCreditoContas(pIdOrganizacao, idConta, pDataInicial, pDataFinal  );
               vlrDB   := obterDebitoContas(pIdOrganizacao, idConta, pDataInicial, pDataFinal  );

                 vlrSaldo := (vlrCR - vlrDB);
                 vlrSaldo := vlrGlobal + vlrSaldo;

                insereSaldos(idConta,pCampo,vlrSaldo );

             end;


              if I = 2  then begin
                pMes := '02'; pCampo := 'FEVE';
                pDataInicial := '01' +'/'+pMes+'/'+pAno;
                dtFinal := EndOfTheMonth(StrToDate(pDataInicial ));
                pDataFinal    := FormatDateTime('dd',dtFinal)  + '.'+ pMes + '.' + pAno;


                pDataAnterior := '31' +'.12.' + IntToStr(anoAnt);

                vlrGlobal :=  (obterCreditoContas(pIdOrganizacao, idConta, '01.01.1900', pDataAnterior ) - obterDebitoContas(pIdOrganizacao, idConta, '01.01.1900', pDataAnterior ));

               vlrCR   := obterCreditoContas(pIdOrganizacao, idConta, pDataInicial, pDataFinal  );
               vlrDB   := obterDebitoContas(pIdOrganizacao, idConta, pDataInicial, pDataFinal  );

                 vlrSaldo := (vlrCR - vlrDB);
                 vlrSaldo := vlrGlobal + vlrSaldo;
                insereSaldos(idConta,pCampo,vlrSaldo );

             end;


              if I = 3  then begin
                pMes := '03'; pCampo := 'MARC';
                pDataInicial := '01' +'/'+pMes+'/'+pAno;
                dtFinal := EndOfTheMonth(StrToDate(pDataInicial ));
                pDataFinal    := FormatDateTime('dd',dtFinal)  + '.'+ pMes + '.' + pAno;


                pDataAnterior := '31' +'.12.' + IntToStr(anoAnt);

                vlrGlobal :=  (obterCreditoContas(pIdOrganizacao, idConta, '01.01.1900', pDataAnterior ) - obterDebitoContas(pIdOrganizacao, idConta, '01.01.1900', pDataAnterior ));

               vlrCR   := obterCreditoContas(pIdOrganizacao, idConta, pDataInicial, pDataFinal  );
               vlrDB   := obterDebitoContas(pIdOrganizacao, idConta, pDataInicial, pDataFinal  );
                vlrSaldo := (vlrCR - vlrDB);
                vlrSaldo := vlrGlobal + vlrSaldo;

                insereSaldos(idConta,pCampo,vlrSaldo );

             end;


              if I = 4  then begin
                pMes := '04'; pCampo := 'ABRI';
                pDataInicial := '01' +'/'+pMes+'/'+pAno;
                dtFinal := EndOfTheMonth(StrToDate(pDataInicial ));
                pDataFinal    := FormatDateTime('dd',dtFinal)  + '.'+ pMes + '.' + pAno;
                pDataAnterior := '31' +'.12.' + IntToStr(anoAnt);

                vlrGlobal :=  (obterCreditoContas(pIdOrganizacao, idConta, '01.01.1900', pDataAnterior ) - obterDebitoContas(pIdOrganizacao, idConta, '01.01.1900', pDataAnterior ));

               vlrCR   := obterCreditoContas(pIdOrganizacao, idConta, pDataInicial, pDataFinal  );
               vlrDB   := obterDebitoContas(pIdOrganizacao, idConta, pDataInicial, pDataFinal  );
               vlrSaldo := (vlrCR - vlrDB);
               vlrSaldo := vlrGlobal + vlrSaldo;
               insereSaldos(idConta,pCampo,vlrSaldo );

             end;


              if I = 5  then begin
                pMes := '05'; pCampo := 'MAIO';
                pDataInicial := '01' +'/'+pMes+'/'+pAno;
                dtFinal := EndOfTheMonth(StrToDate(pDataInicial ));
                pDataFinal    := FormatDateTime('dd',dtFinal)  + '.'+ pMes + '.' + pAno;
                pDataAnterior := '31' +'.12.' + IntToStr(anoAnt);

                vlrGlobal :=  (obterCreditoContas(pIdOrganizacao, idConta, '01.01.1900', pDataAnterior ) - obterDebitoContas(pIdOrganizacao, idConta, '01.01.1900', pDataAnterior ));

               vlrCR   := obterCreditoContas(pIdOrganizacao, idConta, pDataInicial, pDataFinal  );
               vlrDB   := obterDebitoContas(pIdOrganizacao, idConta, pDataInicial, pDataFinal  );
               vlrSaldo := (vlrCR - vlrDB);
               vlrSaldo := vlrGlobal + vlrSaldo;
               insereSaldos(idConta,pCampo,vlrSaldo );

             end;



              if I = 6  then begin
                pMes := '06'; pCampo := 'JUNH';
                pDataInicial := '01' +'/'+pMes+'/'+pAno;
                dtFinal := EndOfTheMonth(StrToDate(pDataInicial ));
                pDataFinal    := FormatDateTime('dd',dtFinal)  + '.'+ pMes + '.' + pAno;


                pDataAnterior := '31' +'.12.' + IntToStr(anoAnt);

                vlrGlobal :=  (obterCreditoContas(pIdOrganizacao, idConta, '01.01.1900', pDataAnterior ) - obterDebitoContas(pIdOrganizacao, idConta, '01.01.1900', pDataAnterior ));

               vlrCR   := obterCreditoContas(pIdOrganizacao, idConta, pDataInicial, pDataFinal  );
               vlrDB   := obterDebitoContas(pIdOrganizacao, idConta, pDataInicial, pDataFinal  );
               vlrSaldo := (vlrCR - vlrDB);
               vlrSaldo := vlrGlobal + vlrSaldo;

                insereSaldos(idConta,pCampo,vlrSaldo );

             end;


            if  (StrToInt(FormatDateTime('mm',now))) > I then begin

              if I = 7  then begin
                pMes := '07'; pCampo := 'JULH';
                pDataInicial := '01' +'/'+pMes+'/'+pAno;
                dtFinal := EndOfTheMonth(StrToDate(pDataInicial ));
                pDataFinal    := FormatDateTime('dd',dtFinal)  + '.'+ pMes + '.' + pAno;

                pDataAnterior := '31' +'.12.' + IntToStr(anoAnt);

                vlrGlobal :=  (obterCreditoContas(pIdOrganizacao, idConta, '01.01.1900', pDataAnterior ) - obterDebitoContas(pIdOrganizacao, idConta, '01.01.1900', pDataAnterior ));

               vlrCR   := obterCreditoContas(pIdOrganizacao, idConta, pDataInicial, pDataFinal  );
               vlrDB   := obterDebitoContas(pIdOrganizacao, idConta, pDataInicial, pDataFinal  );
               vlrSaldo := (vlrCR - vlrDB);
               vlrSaldo := vlrGlobal + vlrSaldo;

                insereSaldos(idConta,pCampo,vlrSaldo );

             end;


             end;


           if  (StrToInt(FormatDateTime('mm',now))) > I then begin

              if I = 8  then begin
                pMes := '08'; pCampo := 'AGOS';
                pDataInicial := '01' +'/'+pMes+'/'+pAno;
                dtFinal := EndOfTheMonth(StrToDate(pDataInicial ));
                pDataFinal    := FormatDateTime('dd',dtFinal)  + '.'+ pMes + '.' + pAno;

                pDataAnterior := '31' +'.12.' + IntToStr(anoAnt);

                vlrGlobal :=  (obterCreditoContas(pIdOrganizacao, idConta, '01.01.1900', pDataAnterior ) - obterDebitoContas(pIdOrganizacao, idConta, '01.01.1900', pDataAnterior ));

               vlrCR   := obterCreditoContas(pIdOrganizacao, idConta, pDataInicial, pDataFinal  );
               vlrDB   := obterDebitoContas(pIdOrganizacao, idConta, pDataInicial, pDataFinal  );

                vlrSaldo := (vlrCR - vlrDB);
                vlrSaldo := vlrGlobal + vlrSaldo;
                insereSaldos(idConta,pCampo,vlrSaldo );

             end;


              end;


            if  (StrToInt(FormatDateTime('mm',now))) > I then begin

              if I = 9  then begin
                pMes := '09'; pCampo := 'SETE';
                pDataInicial := '01' +'/'+pMes+'/'+pAno;
                dtFinal := EndOfTheMonth(StrToDate(pDataInicial ));
                pDataFinal    := FormatDateTime('dd',dtFinal)  + '.'+ pMes + '.' + pAno;

                pDataAnterior := '31' +'.12.' + IntToStr(anoAnt);

                vlrGlobal :=  (obterCreditoContas(pIdOrganizacao, idConta, '01.01.1900', pDataAnterior ) - obterDebitoContas(pIdOrganizacao, idConta, '01.01.1900', pDataAnterior ));

               vlrCR   := obterCreditoContas(pIdOrganizacao, idConta, pDataInicial, pDataFinal  );
               vlrDB   := obterDebitoContas(pIdOrganizacao, idConta, pDataInicial, pDataFinal  );

                 vlrSaldo := (vlrCR - vlrDB);
                 vlrSaldo := vlrGlobal + vlrSaldo;
                insereSaldos(idConta,pCampo,vlrSaldo );

             end;

              end;


            if  (StrToInt(FormatDateTime('mm',now))) > I then begin

             if I = 10  then begin
                pMes := '10'; pCampo := 'OUTU';
                pDataInicial := '01' +'/'+pMes+'/'+pAno;
                dtFinal := EndOfTheMonth(StrToDate(pDataInicial ));
                pDataFinal    := FormatDateTime('dd',dtFinal)  + '.'+ pMes + '.' + pAno;

                pDataAnterior := '31' +'.12.' + IntToStr(anoAnt);

                vlrGlobal :=  (obterCreditoContas(pIdOrganizacao, idConta, '01.01.1900', pDataAnterior ) - obterDebitoContas(pIdOrganizacao, idConta, '01.01.1900', pDataAnterior ));

               vlrCR   := obterCreditoContas(pIdOrganizacao, idConta, pDataInicial, pDataFinal  );
               vlrDB   := obterDebitoContas(pIdOrganizacao, idConta, pDataInicial, pDataFinal  );

                 vlrSaldo := (vlrCR - vlrDB);
                 vlrSaldo := vlrGlobal + vlrSaldo;
                insereSaldos(idConta,pCampo,vlrSaldo );

             end;
           end;


           if  (StrToInt(FormatDateTime('mm',now))) >= I then begin

              if I = 11  then begin
                pMes := '11'; pCampo := 'NOVE';
                pDataInicial := '01' +'/'+pMes+'/'+pAno;
                dtFinal := EndOfTheMonth(StrToDate(pDataInicial ));
                pDataFinal    := FormatDateTime('dd',dtFinal)  + '.'+ pMes + '.' + pAno;

                pDataAnterior := '31' +'.12.' + IntToStr(anoAnt);

                vlrGlobal :=  (obterCreditoContas(pIdOrganizacao, idConta, '01.01.1900', pDataAnterior ) - obterDebitoContas(pIdOrganizacao, idConta, '01.01.1900', pDataAnterior ));

               vlrCR   := obterCreditoContas(pIdOrganizacao, idConta, pDataInicial, pDataFinal  );
               vlrDB   := obterDebitoContas(pIdOrganizacao, idConta, pDataInicial, pDataFinal  );
                 vlrSaldo := (vlrCR - vlrDB);
                 vlrSaldo := vlrGlobal + vlrSaldo;

                insereSaldos(idConta,pCampo,vlrSaldo );

             end;
             end;

           if  (StrToInt(FormatDateTime('mm',now))) > I then begin

              if I = 12  then begin
                pMes := '12'; pCampo := 'DEZE';
                pDataInicial := '01' +'/'+pMes+'/'+pAno;
                dtFinal := EndOfTheMonth(StrToDate(pDataInicial ));
                pDataFinal    := FormatDateTime('dd',dtFinal)  + '.'+ pMes + '.' + pAno;

                pDataAnterior := '31' +'.12.' + IntToStr(anoAnt);

                vlrGlobal :=  (obterCreditoContas(pIdOrganizacao, idConta, '01.01.1900', pDataAnterior ) - obterDebitoContas(pIdOrganizacao, idConta, '01.01.1900', pDataAnterior ));

               vlrCR   := obterCreditoContas(pIdOrganizacao, idConta, pDataInicial, pDataFinal  );
               vlrDB   := obterDebitoContas(pIdOrganizacao, idConta, pDataInicial, pDataFinal  );

                 vlrSaldo := (vlrCR - vlrDB);
                 vlrSaldo := vlrGlobal + vlrSaldo;

                insereSaldos(idConta,pCampo,vlrSaldo );

             end;

           end;




         end;


       qryObterTodasContas.Next;

      end;



  end;



   qrySaldosBancarios.Close;
   qrySaldosBancarios.Connection := dmConexao.conn;
   qrySaldosBancarios.Open;




end;

end.
