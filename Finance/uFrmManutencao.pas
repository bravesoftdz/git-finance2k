unit uFrmManutencao;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants,
  System.Classes, Vcl.Graphics, udmConexao,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.ComCtrls, Vcl.StdCtrls, Vcl.Buttons,
  uDMContasPagarManter, uUTil, Data.DB, FireDAC.Stan.Intf, FireDAC.Stan.Option,
  FireDAC.Stan.Param, FireDAC.Stan.Error, FireDAC.DatS, FireDAC.Phys.Intf,
  FireDAC.DApt.Intf, FireDAC.Stan.Async, FireDAC.DApt, FireDAC.Comp.DataSet,
  FireDAC.Comp.Client, Vcl.Grids, Vcl.DBGrids, uFrameOrganizacoes,
  uFrameBDTables, uFrameProgressBar;

type
  TfrmManutencao = class(TForm)
    PageControl1: TPageControl;
    tbsTP: TTabSheet;
    tbsTR: TTabSheet;
    btnDeletarExcluidos: TBitBtn;
    dbgrd1: TDBGrid;
    ds1: TDataSource;
    tsTabelas: TTabSheet;
    frameOrgs: TframeOrg;
    frameBDTables: TfrmBDTables;
    btn1: TButton;
    lbl1: TLabel;
    qryQtdRegistros: TFDQuery;
    dbgrd2: TDBGrid;
    lbl2: TLabel;
    ds2: TDataSource;
    btnAjustaDataEmissaoTP: TButton;
    qryTodosTP: TFDQuery;
    qryAjustaDataEmissao: TFDQuery;
    framePB1: TframePB;
    qryDeletaTP: TFDQuery;
    procedure btnDeletarExcluidosClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure btnAlterNumDocClick(Sender: TObject);
    procedure btn1Click(Sender: TObject);
    procedure tsTabelasShow(Sender: TObject);
    procedure frameBDTablesds1DataChange(Sender: TObject; Field: TField);
    procedure btnAjustaDataEmissaoTPClick(Sender: TObject);
  private
    { Private declarations }
    idOrganizacao: String;
    procedure inicializarDM(Sender: TObject);
    procedure ObterQtdRegistro(pTable : string);
    function ObterTodosTitulosPagar(pIdOrganizacao :string): TFDQuery;
    function AjustarDataEmissaoTP(query :TFDQuery):boolean;
    function deletaTP(pIdOrganizacao,pID :string) :boolean;

  public
    { Public declarations }
  end;

var
  frmManutencao: TfrmManutencao;

implementation

{$R *.dfm}
{ TfrmManutencao }



procedure TfrmManutencao.btn1Click(Sender: TObject);
begin
frameBDTables.obterTabelas;
frameBDTables.dbgrd1.SelectedIndex :=1;
frameBDTables.dbgrd1.SetFocus;
end;

procedure TfrmManutencao.btnAjustaDataEmissaoTPClick(Sender: TObject);
begin

   if( AjustarDataEmissaoTP(ObterTodosTitulosPagar(TOrgAtual.getId))) then begin
    framePB1.lblProgressBar.Visible :=True;
    framePB1.lblProgressBar.Caption := 'Processo conclu�do...';
   end;

  end;


procedure TfrmManutencao.btnAlterNumDocClick(Sender: TObject);
begin
// abre uma tela com dados do titulo a ser alterado

end;

procedure TfrmManutencao.btnDeletarExcluidosClick(Sender: TObject);
var
 idTP, tipoStatus: String;
 qtd :Integer;
begin
  idOrganizacao := TOrgAtual.getId;
  tipoStatus := 'EXCLUIDO';
  try
    framePB1.Visible :=True;
    framePB1.progressBar(1,qtd);
    ObterTodosTitulosPagar(idOrganizacao);
    qryTodosTP.First;
    qtd := qryTodosTP.RecordCount;

    if (qtd >0 ) then begin
       while not qryTodosTP.Eof do begin
         tipoStatus := qryTodosTP.FieldByName('ID_TIPO_STATUS').AsString;
         idTP       :=  qryTodosTP.FieldByName('ID_TITULO_PAGAR').AsString;

         if tipoStatus.Equals('EXCLUIDO') then begin
          if (deletaTP(idOrganizacao,idTP)) then begin
          framePB1.progressBar(1,qtd);
          Application.ProcessMessages;
          end;
         end;

         qryTodosTP.Next;
       end;
        dmConexao.Conn.CommitRetaining;
    end;
      ObterTodosTitulosPagar(idOrganizacao);
      dbgrd1.DataSource := ds1;
      dbgrd1.DataSource.DataSet := qryTodosTP;
      ShowMessage('Processo conclu�do... ');
  Except
     framePB1.Visible :=false;
    raise Exception.Create
      ('Problemas ao tentar deletar titulos a pagar. ERRO: FRM_DEL_TP - 1');

  end;

end;

function TfrmManutencao.deletaTP(pIdOrganizacao, pID: string): boolean;
begin

 if not (Assigned(dmConexao)) then
  begin
    dmConexao := TdmConexao.Create(Self);
    dmConexao.conectarBanco;
  end ;

  qryDeletaTP.Close;
  qryDeletaTP.Connection := dmConexao.Conn;
  qryDeletaTP.SQL.Clear;
  qryDeletaTP.SQL.Add('execute procedure sp_del_tp(:PID,:PIDORGANIZACAO)');
  qryDeletaTP.ParamByName('PID').AsString := pID;
  qryDeletaTP.ParamByName('PIDORGANIZACAO').AsString := pidOrganizacao;

  try
    qryDeletaTP.ExecSQL;
  Except
    raise Exception.Create
      ('Problemas ao tentar deletar registros. Erro : DELTP-2');
  end;

  dmConexao.Conn.CommitRetaining;

   Result := System.True;
end;

procedure TfrmManutencao.FormCreate(Sender: TObject);
begin
inicializarDM(Self);
framePB1.Visible := False;
framePB1.lblProgressBar.Visible :=False;
ObterTodosTitulosPagar(TOrgAtual.getId);

end;

procedure TfrmManutencao.frameBDTablesds1DataChange(Sender: TObject;
  Field: TField);
  var
  table: string;

begin
table := frameBDTables.dbgrd1.DataSource.DataSet.FieldByName('TABELA').AsString;

ObterQtdRegistro(table);

end;

procedure TfrmManutencao.inicializarDM(Sender: TObject);
begin

 if not (Assigned(dmConexao)) then
  begin
    dmConexao := TdmConexao.Create(Self);
    dmConexao.conectarBanco;
  end ;


  if not(Assigned(dmContasPagarManter)) then
  begin
    dmContasPagarManter := TdmContasPagarManter.Create(Self);
  end  ;

end;


procedure TfrmManutencao.tsTabelasShow(Sender: TObject);
begin
frameOrgs.listar(Self);

end;


function TfrmManutencao.AjustarDataEmissaoTP(query :TFDQuery):boolean;
  var
  qtd :Integer;
begin
    qtd:=0;
    framePB1.Visible :=True;
    framePB1.progressBar(1, query.RecordCount);
    Application.ProcessMessages;
    Sleep(2000);

 if dmConexao.conectarBanco then
    begin
      try
      query.Open();
      query.First;
        while not (query.Eof) do begin
                  qtd :=qtd + 1;
                  qryAjustaDataEmissao.Close;
                  qryAjustaDataEmissao.Connection := dmConexao.Conn;
                  qryAjustaDataEmissao.ParamByName('PIDORGANIZACAO').AsString := query.FieldByName('ID_ORGANIZACAO').AsString;
                  qryAjustaDataEmissao.ParamByName('PIDTP').AsString := query.FieldByName('ID_TITULO_PAGAR').AsString;
                  qryAjustaDataEmissao.ParamByName('PDATA').AsDate := query.FieldByName('DATA_REGISTRO').AsDateTime;

            qryAjustaDataEmissao.ExecSQL;
            dbgrd1.DataSource.DataSet :=query;
            query.Next;

            framePB1.progressBar(1, query.RecordCount);
            if(qtd mod 2 = 0) then begin
              Application.ProcessMessages;
            end;
        end;

      except
        dmConexao.Conn.RollbackRetaining;
        raise Exception.Create('Erro ao tentar ajustar datas dos Titulos ');

      end;
       dmConexao.Conn.CommitRetaining;
       ShowMessage('Processo conclu�do...');

    end;

    Result :=System.True;

end;




function TfrmManutencao.ObterTodosTitulosPagar(pIdOrganizacao :string): TFDQuery;
begin

if not (Assigned(dmConexao)) then
  begin
    dmConexao := TdmConexao.Create(Self);
    dmConexao.conectarBanco;
  end ;

    qryTodosTP.Close;
    qryTodosTP.Connection := dmConexao.Conn;
    qryTodosTP.ParamByName('PIDORGANIZACAO').AsString := PIDORGANIZACAO;
    qryTodosTP.Open;

    Result := qryTodosTP;
end;



procedure TfrmManutencao.ObterQtdRegistro(pTable :string);
var
cmd : String;
begin
   cmd :=' SELECT count(*) as REGISTROS '+
        '  FROM  ' +  pTable +
        '  WHERE 1=1 ;' ;


  if dmConexao.conectarBanco then
  begin

    qryQtdRegistros.Close;
    if not qryQtdRegistros.Connection.Connected then
    begin
      qryQtdRegistros.Connection := dmConexao.Conn;
    end;
    qryQtdRegistros.SQL.Clear;
    qryQtdRegistros.SQL.Add(cmd);
    qryQtdRegistros.Open;


  end;
end;






end.
