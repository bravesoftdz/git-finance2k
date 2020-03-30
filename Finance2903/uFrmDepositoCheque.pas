unit uFrmDepositoCheque;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs,uFrameContaBancaria,uContaContabilModel,udmConexao,uUtil,
  Vcl.Grids, Vcl.StdCtrls, FireDAC.Stan.Intf, FireDAC.Stan.Option,
  FireDAC.Stan.Param, FireDAC.Stan.Error, FireDAC.DatS, FireDAC.Phys.Intf,
  FireDAC.DApt.Intf, FireDAC.Stan.Async, FireDAC.DApt, Data.DB,
  FireDAC.Comp.DataSet, FireDAC.Comp.Client, Vcl.ComCtrls, Vcl.Buttons, ELab3D,
  uFrameGeneric, uFrameResponsavel, cxGraphics, cxControls, cxLookAndFeels,
  cxLookAndFeelPainters, dxSkinsCore, dxSkinsDefaultPainters, cxClasses, dxBar,
  dxStatusBar, dxRibbonSkins, dxRibbonCustomizationForm, dxRibbon ;

type
  TfrmDepositoCheque = class(TForm)
    frmContaBancaria1: TfrmContaBancaria;
    gridMain: TStringGrid;
    qryObterCheques: TFDQuery;
    lbl1: TLabel;
    edtContaContabil: TEdit;
    lbl8: TLabel;
    dtpDeposito: TDateTimePicker;
    lbl2: TLabel;
    edtDescricaoCC: TEdit;
    edtTOB: TEdit;
    lbl3: TLabel;
    edtCTACCDB: TEdit;
    lbl4: TLabel;
    qryObterTOB: TFDQuery;
    EvLabel3D1: TEvLabel3D;
    qryObterContaBancaria: TFDQuery;
    frameResponsavel1: TframeResponsavel;
    dxStatusTRF: TdxStatusBar;
    dxBarManager1: TdxBarManager;
    dxRibbon1Tab1: TdxRibbonTab;
    dxRibbon1: TdxRibbon;
    dxBarManager1Bar1: TdxBar;
    dxBarManager1Bar2: TdxBar;
    dxBtnConfirmar: TdxBarLargeButton;
    dxBarLargeButton2: TdxBarLargeButton;
    procedure FormCreate(Sender: TObject);
    procedure gridMainDrawCell(Sender: TObject; ACol, ARow: Integer;
      Rect: TRect; State: TGridDrawState);
    procedure gridMainSelectCell(Sender: TObject; ACol, ARow: Integer;
      var CanSelect: Boolean);
    procedure frmContaBancaria1cbbContaChange(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure btnFecharClick(Sender: TObject);
    procedure btnDepositarClick(Sender: TObject);
    procedure frameResponsavel1cbbcomboChange(Sender: TObject);
    procedure dxBarLargeButton2Click(Sender: TObject);
    procedure dxBtnConfirmarClick(Sender: TObject);
  private
    { Private declarations }
 pIdResponsavel, iDContaBancaria, idHistorico,idTOB,  pIdUsuario,   pIdOrganizacao :string;
    FsListaCheques, FslistaIdResponsavel, FsListaIdContas : TStringList;
    indice :Integer;



    procedure inicializarDM(Sender: TObject);
    procedure freeAndNilDM();
    procedure AlinhaCheck;
    procedure limparPanel;
    procedure AdicionarLinhasComCheckBoxes(qryCheques: TFDQuery);
    procedure Limpabuffer;
    procedure preencheGrid;
    function obterTipoOperacaoBancaria(pIdOrganizacao,
      pIdTOB: string): TFDQuery;
    function transfereChequeCaixaBanco(pIdorganizacao, pIdConta,
      pIdResponsavel: string; pDataMovimento: TDate; pValor: Currency; pQtdCheques :Integer): Boolean;

  public
    { Public declarations }
    function obterChequesDepositar(pIdOrganizacao :string):TFDQuery;

  end;

var
  frmDepositoCheque: TfrmDepositoCheque;

implementation

{$R *.dfm}

procedure TfrmDepositoCheque.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
freeAndNilDM();
 Action := caFree;
end;

procedure TfrmDepositoCheque.FormCreate(Sender: TObject);
begin
 dxBtnConfirmar.Enabled := False;

 pIdOrganizacao := uUtil.TOrgAtual.getId;
 pIdUsuario := uUtil.TUserAtual.getUserId;

 inicializarDM(Self);


end;

procedure TfrmDepositoCheque.frameResponsavel1cbbcomboChange(Sender: TObject);
begin
   if frameResponsavel1.cbbcombo.ItemIndex >0 then begin
     pIdResponsavel := FslistaIdResponsavel[frameResponsavel1.cbbcombo.ItemIndex];
 end;

end;

procedure TfrmDepositoCheque.freeAndNilDM;
begin
  //nada
end;

procedure TfrmDepositoCheque.frmContaBancaria1cbbContaChange(Sender: TObject);
var
contaContabil : TContaContabilModel;

begin
   indice :=0;
   contaContabil := TContaContabilModel.Create;
   indice :=frmContaBancaria1.cbbConta.ItemIndex;
   iDContaBancaria := FsListaIdContas[indice];

  if indice > 0 then begin
      //pegar a conta contabil
     contaContabil := frmContaBancaria1.getContaContabil(pIdOrganizacao, iDContaBancaria);
     if not (uutil.Empty(contaContabil.FConta)) then begin
        edtContaContabil.Text := contaContabil.FConta;
        edtDescricaoCC.Text   := contaContabil.FDescricao;
     end;

  end;

end;

procedure TfrmDepositoCheque.gridMainDrawCell(Sender: TObject; ACol,
  ARow: Integer; Rect: TRect; State: TGridDrawState);
var
strTemp: string;
w: integer;
liForLinha : integer;
  s : string;
  LDelta : integer;

begin

  if not (gdFixed in State) then begin
     AlinhaCheck;
  end;

  if ((gdSelected in State) or (ARow = 0)) then begin  //destacar celula/linha
    {Caso a propriedade goRowSelect seja true, as configura��es abaixo ir�o ocorrer em todas as
    celulas da linha selecionada, caso seja false, ser� aplicada somente na celula selecionada }
    gridMain.Canvas.Font.Style := gridMain.Canvas.Font.Style + [fsBold]; //Aplicando negrito
    gridMain.Canvas.Font.Color := clNavy; //Fonte azul
    gridMain.Canvas.Brush.Color := $00FFEFDF; //Fundo azulado (cor de linha selecionada)
  end;

  {Aplicar estilo zebrado}
  if (ARow > 0) then begin// testa se n�o � a primeira linha (fixa)
    if not (odd(ARow)) then begin // verifica se � par
      gridMain.Canvas.Font.Color  := clNavy;  //Fonte azul
      gridMain.Canvas.Brush.Color := $00EFEFEF; //Fundo cinza claro
    end;
  end;

     if (ACol = 2 ) and (ARow>0) then
      begin
        s     := gridMain.Cells[ACol, ARow];
        LDelta := gridMain.ColWidths[ACol] - gridMain.Canvas.TextWidth(s);
        gridMain.Canvas.TextRect(Rect, Rect.Left+LDelta, Rect.Top+2, s);
      end else
        gridMain.Canvas.TextRect(Rect, Rect.Left+2, Rect.Top+2, gridMain.Cells[ACol, ARow]);

end;


procedure TfrmDepositoCheque.gridMainSelectCell(Sender: TObject; ACol,
  ARow: Integer; var CanSelect: Boolean);
begin

  if ACol = 0 then begin
    gridMain.Options := gridMain.Options + [goEditing] - [goRangeSelect];
  end else begin
    gridMain.Options := gridMain.Options - [goEditing] + [goRangeSelect];
  end;

end;

Procedure TfrmDepositoCheque.AlinhaCheck;
var
  loCheckBoxTemp: TCheckBox;
  loRect: TRect;
  liForLinha: Integer;
begin
  for liForLinha := 1 to gridMain.RowCount do begin
    loCheckBoxTemp := (gridMain.Objects[0,liForLinha] as TCheckBox);
    if (loCheckBoxTemp <> nil) then begin
      loRect := gridMain.CellRect(0,liForLinha); // Pegando a celula para alinharmos o check

      loCheckBoxTemp.Left    := gridMain.Left + loRect.Left+2;
      loCheckBoxTemp.Top     := gridMain.Top  + loRect.Top+2;
      loCheckBoxTemp.Width   := 30;// (loRect.Right     - loRect.Left);
      loCheckBoxTemp.Height  := loRect.Bottom    - loRect.Top;
      loCheckBoxTemp.Visible := True;
    end;
  end;
end;

procedure TfrmDepositoCheque.btnDepositarClick(Sender: TObject);
var qtdChque, liForLinha :Integer;
 strValorCheque, contaBancaria, idTRBC :string;
valorCheque, totalDeposito :Currency;
sucess :Boolean;

begin
 //versao antiga 10/12/2019
 {
  totalDeposito := 0;
  qtdChque := 0;
  valorCheque := 0;
  FsListaCheques := TStringList.Create;
  FsListaCheques.Clear;

  //prenche a lista de cheques e pega alguns paramentros

   for liForLinha := 1 to (gridMain.RowCount - 1) do begin

    if (gridMain.Objects[0,liForLinha] as TCheckBox).Checked then begin

       idTRBC :=gridMain.Cells[7,liForLinha];
       gridMain.Cells[2,liForLinha];
//
         strValorCheque := StringReplace(gridMain.Cells[2,liForLinha], '.','', [rfReplaceAll]) ;
        // strValorCheque := StringReplace(strValorCheque, ',', '.', [rfReplaceAll]);
         valorCheque :=  StrToCurr(strValorCheque ) ;


       FsListaCheques.Add(idTRBC);
       totalDeposito := totalDeposito + valorCheque;
       Inc(qtdChque);

     end;

  end;


  try
    dmConexao.conectarBanco;
    if qtdChque > 0 then begin

    sucess := transfereChequeCaixaBanco(pIdOrganizacao, iDContaBancaria, pIdResponsavel, dtpDeposito.Date, totalDeposito, qtdChque);

    end else begin ShowMessage('Lista de cheques vazia.'); end;

    if (sucess) then
    begin

      limparPanel;
      ShowMessage('Dep�sito realizado  com sucesso.');
    end;

  except
    on e: Exception do
      ShowMessage(e.Message + sLineBreak);

  end;

  }
end;

procedure TfrmDepositoCheque.btnFecharClick(Sender: TObject);
begin
    limparPanel;
    PostMessage(Self.Handle, WM_CLOSE, 0, 0);
end;

procedure TfrmDepositoCheque.dxBtnConfirmarClick(Sender: TObject);
var qtdChque, liForLinha :Integer;
 strValorCheque, contaBancaria, idTRBC :string;
valorCheque, totalDeposito :Currency;
sucess :Boolean;

begin
  totalDeposito := 0;
  qtdChque := 0;
  valorCheque := 0;
  FsListaCheques := TStringList.Create;
  FsListaCheques.Clear;

  //prenche a lista de cheques e pega alguns paramentros

   for liForLinha := 1 to (gridMain.RowCount - 1) do begin

    if (gridMain.Objects[0,liForLinha] as TCheckBox).Checked then begin

       idTRBC :=gridMain.Cells[7,liForLinha];
       gridMain.Cells[2,liForLinha];
//
         strValorCheque := StringReplace(gridMain.Cells[2,liForLinha], '.','', [rfReplaceAll]) ;
        // strValorCheque := StringReplace(strValorCheque, ',', '.', [rfReplaceAll]);
         valorCheque :=  StrToCurr(strValorCheque ) ;


       FsListaCheques.Add(idTRBC);
       totalDeposito := totalDeposito + valorCheque;
       Inc(qtdChque);

     end;

  end;


  try
    dmConexao.conectarBanco;
    if qtdChque > 0 then begin

    sucess := transfereChequeCaixaBanco(pIdOrganizacao, iDContaBancaria, pIdResponsavel, dtpDeposito.Date, totalDeposito, qtdChque);

    end else begin ShowMessage('Lista de cheques vazia.'); end;

    if (sucess) then
    begin

      limparPanel;
      ShowMessage('Dep�sito realizado  com sucesso.');
    end;

  except
    on e: Exception do
      ShowMessage(e.Message + sLineBreak);

  end;


end;

procedure TfrmDepositoCheque.dxBarLargeButton2Click(Sender: TObject);
begin
    limparPanel;
    PostMessage(Self.Handle, WM_CLOSE, 0, 0);
end;

procedure TfrmDepositoCheque.inicializarDM(Sender: TObject);
begin
 dmConexao.conectarBanco;
 limparPanel;
end;


procedure TfrmDepositoCheque.limparPanel;

begin
 FsListaIdContas := TStringList.Create;
 iDContaBancaria :='';

  frmContaBancaria1.obterTodos(pIdOrganizacao, frmContaBancaria1.cbbConta, FsListaIdContas);
  frmContaBancaria1.cbbConta.ItemIndex := 0;
 // btnDepositar.Enabled := False;

  edtContaContabil.Clear;
  edtDescricaoCC.Clear;

  idHistorico := 'DEPOSITO TESOURARIA/BANCO';
  idTOB       := 'DEPOSITO TESOURARIA/BANCO';
  edtTOB.Text := idTOB;

  obterTipoOperacaoBancaria(pIdOrganizacao,idTOB);
  edtCTACCDB.Text := qryObterTOB.FieldByName('CONTA').AsString;
  dtpDeposito.DateTime := Now;

 frameResponsavel1.createComboAll('FUNCIONARIO','NOME','NOME',frameResponsavel1.cbbcombo,FslistaIdResponsavel);


 obterChequesDepositar(pIdOrganizacao);
 preencheGrid;


end;


function TfrmDepositoCheque.obterChequesDepositar(
  pIdOrganizacao: string): TFDQuery;
begin
 dmConexao.conectarBanco;
     try
      qryObterCheques.Close;
      qryObterCheques.Connection := dmConexao.conn;
      qryObterCheques.ParamByName('PIDORGANIZACAO').AsString := pIdOrganizacao;
      qryObterCheques.Open;
     except

      raise Exception.Create('Erro ao obter cheques para depositar.');

     end;

    Result := qryObterCheques;
end;

procedure TfrmDepositoCheque.preencheGrid();
begin

  gridMain.Cells[0,0] := 'MARCAR';
  gridMain.Cells[1,0] := 'CHEQUE';
  gridMain.Cells[2,0] := 'VALOR';
  gridMain.Cells[3,0] := 'DOCUMENTO';
  gridMain.Cells[4,0] := 'BANCO';
  gridMain.Cells[5,0] := 'TITULAR';
  gridMain.Cells[6,0] := 'DATA PAGTO';
  gridMain.Cells[7,0] := ''; //ID

  if qryObterCheques.RecordCount >0 then begin
    gridMain.Visible :=True;
    dxBtnConfirmar.Enabled :=True;
    AdicionarLinhasComCheckBoxes ( qryObterCheques );
  end else begin
     gridMain.Visible :=False;
     dxBtnConfirmar.Enabled := False;

  end;



end;


procedure TfrmDepositoCheque.AdicionarLinhasComCheckBoxes( qryCheques :TFDQuery  );
var
  liForLinha: Integer;
  loCheckBox: TCheckBox;
begin
  limpaBuffer; {� bom n�o esquecer de limpar controles n�o utilizados}
  qryCheques.First;
  if not qryCheques.Eof then begin


      for liForLinha := 1 to qryCheques.RecordCount do begin

        {Criando os checkbox em tempo de execu��o}
        loCheckBox         := TCheckBox.Create(Application);
        loCheckBox.Width   := 0;
        loCheckBox.Visible := false;
        loCheckBox.Caption := ' ';
        loCheckBox.Color   := clWindow;
        loCheckBox.Tag     := liForLinha;
        //Associar o evento OnClick de todos os checkbox criados a um �nico evento,
        //que chamei de OnClick, mas poderia ser qualquer nome, contanto que a
        //parte da asinatura dos parametros sejam do mesmo tipo,
        //para o caso de desejar capturar o evento para executar alguma a��o
        loCheckBox.OnClick := OnClick;
       // loCheckBox.Parent  := Panel1;
        loCheckBox.Parent  := gridMain.Parent;

        {StringGrid1.Objects[Coluna,Linha]}
        gridMain.Objects[0,liForLinha] := loCheckBox;
        gridMain.Cells  [1,liForLinha] := qryCheques.FieldByName('CHEQUE').AsString;
        gridMain.Cells  [2,liForLinha] := (FormatFloat('###,##0.00', qryCheques.FieldByName('VALOR').AsCurrency));
        gridMain.Cells  [3,liForLinha] := qryCheques.FieldByName('DOCTR').AsString;
        gridMain.Cells  [4,liForLinha] := qryCheques.FieldByName('banco').AsString;
        gridMain.Cells  [5,liForLinha] := qryCheques.FieldByName('TITULAR').AsString;
        gridMain.Cells  [6,liForLinha] := DateToStr(qryCheques.FieldByName('data_pagamento').AsDateTime);
        gridMain.Cells  [7,liForLinha] := qryCheques.FieldByName('ID').AsString;

               //gridMain.RowCount := liForLinha;
        qryCheques.Next;
      end;

       gridMain.RowCount := liForLinha;

  end;

  AlinhaCheck; // Alinhar o check na celula e exib�-lo

end;


Procedure TfrmDepositoCheque.Limpabuffer;
var
  loCheckBoxTemp: TCheckBox;
  liForLinha: Integer;
  lsRow :string;
begin
  for liForLinha := 1 to gridMain.RowCount do begin
    loCheckBoxTemp := (gridMain.Objects[0,liForLinha] as TCheckBox);

    if (loCheckBoxTemp <> nil) then begin // o objeto deve existir para poder ser destru�do
      loCheckBoxTemp.Visible   := false;
      gridMain.Objects[0,liForLinha] := nil;
    end;
  end;
end;

function TfrmDepositoCheque.obterTipoOperacaoBancaria(pIdOrganizacao, pIdTOB: string): TFDQuery;
begin
dmConexao.conectarBanco;
 try

    qryObterTOB.Close;
    qryObterTOB.Connection := dmConexao.Conn;
    qryObterTOB.ParamByName('PIDORGANIZACAO').AsString := pIdOrganizacao;
    qryObterTOB.ParamByName('PIDTOB').AsString := pIdTOB;
    qryObterTOB.Open;


 except
 raise Exception.Create('Erro ao obter TOB');

 end;


 Result := qryObterTOB;


end;



function TfrmDepositoCheque.transfereChequeCaixaBanco(pIdorganizacao, pIdConta, pIdResponsavel: string; pDataMovimento: TDate;  pValor: Currency; pQtdCheques :Integer ): Boolean;
  var
cmdUpCh, identificadorLote, descricaoTD, cmdDB, cmdCR, cmdLote, idTD, idChq, idCBC, idLOTE,  idTOB, idCedente, idHistorico :string;
 qryLoteDeposito,qryUpdateTRBC, qryDebitoCaixa, qryCreditoBanco :TFDQuery;
  I: Integer;


  begin
  Result :=False;
  dmConexao.conectarBanco;
  idCedente := uutil.TOrgAtual.getId;
  idHistorico := 'DEPOSITO TESOURARIA/BANCO';
  idTOB := 'DEPOSITO TESOURARIA/BANCO';
  //idTD := dmConexao.obterNewID;
  identificadorLote := dmConexao.obterIdentificador('',pIdOrganizacao,'LOTE_DP');
  pIdUsuario := uutil.TUserAtual.getUserId;

   try
     qryObterContaBancaria.Close;
     qryObterContaBancaria.ParamByName('PIDORGANIZACAO').AsString := pIdOrganizacao;
     qryObterContaBancaria.ParamByName('PIDCONTA').AsString := pIdConta;
     qryObterContaBancaria.Open;
     descricaoTD :=  ' DEP CH CTA ' + ' NC';

      if not qryObterContaBancaria.IsEmpty then begin
        descricaoTD :=  'DEP CH CTA ' + qryObterContaBancaria.FieldByName('CODIGO_BANCO').AsString +
                        ' - ' + qryObterContaBancaria.FieldByName('CONTA').AsString;
      end;

   except
   raise Exception.Create('Erro ao obter dados da conta banc�ria');

   end;

  dmConexao.conn.StartTransaction; //abre a transa��o

  try

   idLOTE := dmConexao.obterNewID;

   //montar o lote deposito primeiro

     cmdLote := ' INSERT INTO LOTE_DEPOSITO (ID_LOTE_DEPOSITO, ID_ORGANIZACAO, LOTE, DATA_REGISTRO, STATUS, ID_USUARIO, '+
                ' QTD_CHQ, ID_CONTA_BANCARIA, TOTAL_DEPOSITO)  ' +
                ' VALUES (:PIDLOTE,:PIDORGANIZACAO,:PLOTE,:PDTREGISTRO,:PSTATUS,:PIDUSER,:PQTD, :PIDCONTABANCO, :PVALOR )' ;

   try
    qryLoteDeposito := TFDQuery.Create(Self);
    qryLoteDeposito.Close;
    qryLoteDeposito.Connection := dmConexao.conn;
    qryLoteDeposito.SQL.Clear;
    qryLoteDeposito.SQL.Add(cmdLote);
    qryLoteDeposito.ParamByName('PIDLOTE').AsString :=idLOTE;
    qryLoteDeposito.ParamByName('PIDORGANIZACAO').AsString :=pIdOrganizacao;
    qryLoteDeposito.ParamByName('PLOTE').AsString := identificadorLote;
    qryLoteDeposito.ParamByName('PDTREGISTRO').AsDate := pDataMovimento;
    qryLoteDeposito.ParamByName('PSTATUS').AsString := 'DEPOSITADO';
    qryLoteDeposito.ParamByName('PIDUSER').AsString := pIdUsuario;
    qryLoteDeposito.ParamByName('PIDCONTABANCO').AsString := pIdConta;
    qryLoteDeposito.ParamByName('PVALOR').AsCurrency := pValor;
    qryLoteDeposito.ParamByName('PQTD').AsInteger := pQtdCheques;
    qryLoteDeposito.ExecSQL;

   except
    raise Exception.Create('Erro ao tentar criar o lote dep�sito');
   end;

  //parte do credito no banco
   idCBC := dmConexao.obterNewID;

   cmdCR :=' INSERT INTO CONTA_BANCARIA_CREDITO (ID_CONTA_BANCARIA_CREDITO, ID_LOTE_DEPOSITO, ID_ORGANIZACAO, IDENTIFICACAO , ID_CONTA_BANCARIA, '+
           ' ID_TIPO_OPERACAO_BANCARIA, ID_RESPONSAVEL, ID_USUARIO, TIPO_LANCAMENTO, DESCRICAO, VALOR,  ' +
           ' DATA_REGISTRO, DATA_MOVIMENTO ) ' +
           ' VALUES (:PIDCBC,:PIDLOTE,  :PIDORGANIZACAO, :PIDENT, :PIDCONTABANCO,:PIDTOB, :PIDRESPONSAVEL, :PIDUSER, :PTIPO, :PDESCRICAO,'+
           ' :PVALOR, :PDTREGISTRO, :PDTMOVIMENTO   ) ' ;



    qryCreditoBanco := TFDQuery.Create(Self);
    qryCreditoBanco.Close;
    qryCreditoBanco.Connection := dmConexao.conn;
    qryCreditoBanco.SQL.Clear;
    qryCreditoBanco.SQL.Add(cmdCR);
    qryCreditoBanco.ParamByName('PIDCBC').AsString :=idCBC;
    qryCreditoBanco.ParamByName('PIDLOTE').AsString :=idLOTE;

    qryCreditoBanco.ParamByName('PIDORGANIZACAO').AsString := pIdOrganizacao;
    qryCreditoBanco.ParamByName('PIDENT').AsString := dmConexao.obterIdentificador('',pIdOrganizacao,'CBC');
    qryCreditoBanco.ParamByName('PIDCONTABANCO').AsString := pIdConta;
    qryCreditoBanco.ParamByName('PIDTOB').AsString := idTOB;
    qryCreditoBanco.ParamByName('PIDRESPONSAVEL').AsString := pIdResponsavel;
    qryCreditoBanco.ParamByName('PIDUSER').AsString := pIdUsuario;
    qryCreditoBanco.ParamByName('PTIPO').AsString :='C';
    qryCreditoBanco.ParamByName('PDESCRICAO').AsString := descricaoTD + ' LOTE ' + identificadorLote ;
    qryCreditoBanco.ParamByName('PVALOR').AsCurrency := pValor;
    qryCreditoBanco.ParamByName('PDTREGISTRO').AsDate := Now;
    qryCreditoBanco.ParamByName('PDTMOVIMENTO').AsDate := pDataMovimento;
    qryCreditoBanco.ExecSQL;


    for I := 0 to FsListaCheques.Count - 1 do begin

       idChq := FsListaCheques[I];

     cmdUpCh :=  ' UPDATE TITULO_RECEBER_BAIXA_CHEQUE ' +
                 '  SET  ID_LOTE_DEPOSITO = :PIDLOTE, ID_TIPO_STATUS = ''DEPOSITADO'', '+
                 '  DATA_DEPOSITO = :PDTMOVIMENTO, LOTE_DEPOSITO = :PLOTE ' +
                 '  WHERE (ID_TITULO_RECEBER_BAIXA_CHEQUE = :PIDCHEQUE )  AND (ID_ORGANIZACAO = :PIDORGANIZACAO ) ';


        qryUpdateTRBC := TFDQuery.Create(Self);
        qryUpdateTRBC.Close;
        qryUpdateTRBC.Connection := dmConexao.conn;
        qryUpdateTRBC.SQL.Clear;
        qryUpdateTRBC.SQL.Add(cmdUpCh);
        qryUpdateTRBC.ParamByName('PIDCHEQUE').AsString :=idChq;
        qryUpdateTRBC.ParamByName('PIDLOTE').AsString :=idLOTE;
        qryUpdateTRBC.ParamByName('PIDORGANIZACAO').AsString := pIdOrganizacao;
        qryUpdateTRBC.ParamByName('PDTMOVIMENTO').AsDate := pDataMovimento;
        qryUpdateTRBC.ParamByName('PLOTE').AsString := identificadorLote;


       qryUpdateTRBC.ExecSQL;

    end;


   dmConexao.conn.CommitRetaining; //fecha a transacao
   dmConexao.conectarBanco;
   Result := True;
  except
   dmConexao.conn.RollbackRetaining;
   raise Exception.Create('Erro ao transferir da tesouraria para o banco.');
  end;
end;




end.
