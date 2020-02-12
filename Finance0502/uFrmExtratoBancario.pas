unit uFrmExtratoBancario;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.DateUtils,
  System.Classes, Vcl.Graphics, uDMExtratoBancario, uUtil, udmConexao, uDMOrganizacao,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, uFramePeriodo, uFrameContaBancaria,
  Vcl.StdCtrls, frxClass, frxDBSet, frxExportCSV, frxExportPDF, Data.DB,
  Vcl.Grids, Vcl.DBGrids, Vcl.Buttons, frxExportBaseDialog;

type
  TfrmExtratoBancario = class(TForm)
    frmContaBancaria1: TfrmContaBancaria;
    frmPeriodo1: TfrmPeriodo;
    btnImprimir: TButton;
    frxExtratoBancario: TfrxReport;
    frxPDFExport1: TfrxPDFExport;
    frxCSVExport1: TfrxCSVExport;
    frxExtrato: TfrxDBDataset;
    btnFechar: TBitBtn;
    lbl: TLabel;
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormCreate(Sender: TObject);
    procedure frmContaBancaria1cbbContaChange(Sender: TObject);
    procedure frmPeriodo1dtpDataInicialChange(Sender: TObject);
    procedure frmPeriodo1dtpDataFinalChange(Sender: TObject);
    procedure btnImprimirClick(Sender: TObject);
    procedure btnFecharClick(Sender: TObject);

  private
    FsListaIdContas : TStringList;
    idConta, idOrganizacao :string;
    saldoAnteriorRelatorio :Currency;
    procedure inicializarDM(Sender: TObject);
    procedure freeAndNilDM(Sender: TObject);
    procedure limpaPanel();
     function retornarCaminhoRelatorio: string;
    procedure inicializarVariaveisRelatorio(dtInicial, dtFinal: TDate);
    procedure exibirRelatorio(dtInicial, dtFinal: TDate);



    { Private declarations }

  public
    { Public declarations }
  end;

var
  frmExtratoBancario: TfrmExtratoBancario;

implementation

{$R *.dfm}


procedure TfrmExtratoBancario.btnFecharClick(Sender: TObject);
begin
   PostMessage(Self.Handle, WM_CLOSE, 0, 0);
end;

procedure TfrmExtratoBancario.btnImprimirClick(Sender: TObject);
var vlrSaldoAnterior, vlrCr, vlrDb : Currency;
pDataInicial, pDataFinal :TDate;
liberaRelatorio : Integer;
descConta,tipoSaldo :String;

begin
   liberaRelatorio :=0;
   tipoSaldo :='D';

  if frmPeriodo1.validarPeriodo then begin
         pDataInicial :=  StrToDate('01/01/1990');
         pDataFinal   := IncDay(frmPeriodo1.getDataInicial, -1); //pega o saldo at� o dia de ontem


     if frmContaBancaria1.cbbConta.ItemIndex >0  then begin
      idConta := FsListaIdContas[frmContaBancaria1.cbbConta.ItemIndex];
      descConta := frmContaBancaria1.cbbConta.Items[frmContaBancaria1.cbbConta.ItemIndex];
      vlrSaldoAnterior := dmExtratoBancario.obterSaldoAnterior(idOrganizacao, idConta, pDataInicial, pDataFinal);
      if vlrSaldoAnterior > 0 then
      begin
        tipoSaldo := 'C';
      end;

         pDataInicial := frmPeriodo1.getDataInicial;
         pDataFinal   := frmPeriodo1.getDataFinal ;

       liberaRelatorio := liberaRelatorio + dmExtratoBancario.obterLancamentosCredito(idOrganizacao,idConta, pDataInicial, pDataFinal);
       liberaRelatorio := liberaRelatorio + dmExtratoBancario.obterLancamentosDebito(idOrganizacao,idConta, pDataInicial, frmPeriodo1.getDataFinal );

     end;
  end;

  if ((liberaRelatorio) > 0) then
  begin

   if  dmExtratoBancario.montarTabelaTemp(IncDay(frmPeriodo1.getDataInicial, -1),'SALDO ANTERIOR DA CONTA ' + descConta , tipoSaldo, vlrSaldoAnterior)  then begin
       dmExtratoBancario.qryExtrato.Close;
       dmExtratoBancario.qryExtrato.Open;
       //ver como fazer com procedure


    exibirRelatorio( pDataInicial, pDataFinal);

   end else begin ShowMessage('N�o foi poss�vel exibir o extrato banc�rio ...'); end;


  end
  else
  begin
    ShowMessage('N�o existem dados para imprimir.');
  end


end;

procedure TfrmExtratoBancario.exibirRelatorio(dtInicial, dtFinal: TDate);
begin

  frxExtratoBancario.Clear;

  if not(frxExtratoBancario.LoadFromFile(retornarCaminhoRelatorio)) then
  begin
      ShowMessage('Relat�rio interno n�o localizado...');
  end
  else
  begin
    inicializarVariaveisRelatorio(dtInicial, dtFinal);
    frxExtratoBancario.OldStyleProgress := True;
    frxExtratoBancario.ShowProgress := True;
    frxExtratoBancario.ShowReport;
  end;

 limpaPanel;

end;

procedure TfrmExtratoBancario.FormClose(Sender: TObject; var Action: TCloseAction);
begin
 freeAndNilDM(Self);
 Action := caFree;
end;

procedure TfrmExtratoBancario.FormCreate(Sender: TObject);
begin
 inicializarDM(Self);
end;

procedure TfrmExtratoBancario.freeAndNilDM(Sender: TObject);
begin
 // nada

 if Assigned(dmExtratoBancario) then begin
    FreeAndNil(dmExtratoBancario);
 end;
end;

procedure TfrmExtratoBancario.frmContaBancaria1cbbContaChange(Sender: TObject);
var
idconta :string;
pDataInicial, pDataFinal :TDate;
begin

  if not frmPeriodo1.validarPeriodo then begin
      ShowMessage('Favor corrigir a data');
  end;

end;

procedure TfrmExtratoBancario.frmPeriodo1dtpDataFinalChange(Sender: TObject);
begin
 frmContaBancaria1.cbbConta.Enabled := True;
end;

procedure TfrmExtratoBancario.frmPeriodo1dtpDataInicialChange(Sender: TObject);
begin
 frmContaBancaria1.cbbConta.Enabled := True;
end;


procedure TfrmExtratoBancario.inicializarDM(Sender: TObject);
begin
  if not (Assigned(dmExtratoBancario)) then
  begin
    dmExtratoBancario := TdmExtratoBancario.Create(Self);
  end;

   if not (Assigned(dmOrganizacao)) then
  begin
    dmOrganizacao := TdmOrganizacao.Create(Self);
  end;


  dmConexao.conectarBanco;

  if not uUtil.Empty(TOrgAtual.getId) then begin

        iDOrganizacao := TOrgAtual.getId;
  end;

 limpaPanel;


end;


procedure TfrmExtratoBancario.inicializarVariaveisRelatorio(dtInicial,  dtFinal: TDate);
begin

  with frxExtratoBancario.Variables do
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
    Variables['strPeriodo'] :=QuotedStr( ' de  ' + DateToStr(dtInicial) + '  at�  ' + DateToStr(dtFinal));
  end;
end;

procedure TfrmExtratoBancario.limpaPanel;
begin

 FsListaIdContas := TStringList.Create;
 frmContaBancaria1.obterTodos(iDOrganizacao, frmContaBancaria1.cbbConta, FsListaIdContas);
 frmPeriodo1.inicializa(Now,Now);
 frmContaBancaria1.cbbConta.Enabled := False;

end;

function TfrmExtratoBancario.retornarCaminhoRelatorio: string;
begin
 // Result := ExtractFilePath(Application.ExeName) + '\extratoBancario.fr3';

 Result := uUtil.TPathRelatorio.getExtratoBancario;

end;

end.