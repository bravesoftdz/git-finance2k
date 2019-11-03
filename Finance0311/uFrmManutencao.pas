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
    dbgrdMain: TDBGrid;
    dsPreencheGrid: TDataSource;
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
    FDSDeletaTP: TFDStoredProc;
    qryObterFilhosTP: TFDQuery;
    qryRemoveFilhoTP: TFDQuery;
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
    function obterFilhosPorTP(pIdOrganizacao,pIdTP :string): boolean;
    function removeFilhosTP(pIdOrganizacao,pIdTPFilho :string): boolean;


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
 gerador, idTP, tipoStatus: String;
I, aux, qtd :Integer;
listaExcluidos :TStringList;

begin
  idOrganizacao := TOrgAtual.getId;
  tipoStatus := 'EXCLUIDO';
  framePB1.Visible :=True;

  listaExcluidos := TStringList.Create;

  aux := 0;
  qtd := qryTodosTP.RecordCount;

  //preecnhe a lista de excluidos
    TFDQuery(dbgrdMain.DataSource.DataSet).Close;
    TFDQuery(dbgrdMain.DataSource.DataSet).Connection := dmConexao.Conn;
    TFDQuery(dbgrdMain.DataSource.DataSet).SQL.Clear;
    TFDQuery(dbgrdMain.DataSource.DataSet).SQL.Add(' SELECT * FROM TITULO_PAGAR TP ' +
                       ' WHERE (TP.ID_ORGANIZACAO =:PIDORGANIZACAO) AND ' +
                       ' (TP.ID_TIPO_STATUS = ''EXCLUIDO'') AND '+
                       ' (TP.ID_TITULO_GERADOR IS NULL) ' );
    TFDQuery(dbgrdMain.DataSource.DataSet).ParamByName('PIDORGANIZACAO').AsString := idOrganizacao;
    TFDQuery(dbgrdMain.DataSource.DataSet).Open;


    qtd := TFDQuery(dbgrdMain.DataSource.DataSet).RecordCount;

   TFDQuery(dbgrdMain.DataSource.DataSet).First;
   while not TFDQuery(dbgrdMain.DataSource.DataSet).Eof do begin

    if(( TFDQuery(dbgrdMain.DataSource.DataSet).FieldByName('ID_TIPO_STATUS').AsString).Equals(tipoStatus)) then begin

      listaExcluidos.Add(TFDQuery(dbgrdMain.DataSource.DataSet).FieldByName('ID_TITULO_PAGAR').AsString);
      Inc(aux);

    end;

    TFDQuery(dbgrdMain.DataSource.DataSet).Next;

   end;

   //tirando as rela��es de pai e filho dos titulos excluidos

   if listaExcluidos.Count >0  then begin

     for I := 0 to listaExcluidos.Count -1 do begin
           idTP  := listaExcluidos[I];
          if obterFilhosPorTP(idOrganizacao, idTP) then  begin
               qryObterFilhosTP.First;
                 while not qryObterFilhosTP.Eof do begin
                  removeFilhosTP(idOrganizacao,qryObterFilhosTP.FieldByName('ID_TITULO_PAGAR').AsString);
                  qryObterFilhosTP.Next;
                 end;
           end;
     end;
   end;


 // ObterTodosTitulosPagar(idOrganizacao);

  qtd := TFDQuery(dbgrdMain.DataSource.DataSet).RecordCount;


  try
    if (qtd >0 ) then begin
      try
                 TFDQuery(dbgrdMain.DataSource.DataSet).First;
       while not TFDQuery(dbgrdMain.DataSource.DataSet).Eof do begin
         tipoStatus := TFDQuery(dbgrdMain.DataSource.DataSet).FieldByName('ID_TIPO_STATUS').AsString;
         idTP       := TFDQuery(dbgrdMain.DataSource.DataSet).FieldByName('ID_TITULO_PAGAR').AsString;

          deletaTP(idOrganizacao,idTP);
          framePB1.progressBar(1,qtd);
          Application.ProcessMessages;
          TFDQuery(dbgrdMain.DataSource.DataSet).Next;
       end;
      Except
          raise Exception.Create
            ('Problemas ao tentar DELETAR_TP ');
        end;

    end;

      ObterTodosTitulosPagar(idOrganizacao);
      qtd := qryTodosTP.RecordCount;
      Application.ProcessMessages;
      framePB1.Visible :=false;
      ShowMessage('   Processo conclu�do...   ');
  Except
     raise Exception.Create
      ('Problemas ao tentar deletar alguns lan�amentos . ERRO: FRM_DEL_TP-1 TP DOC >>  ' + qryTodosTP.FieldByName('NUMERO_DOCUMENTO').AsString);
  end;

end;

function TfrmManutencao.deletaTP(pIdOrganizacao, pID: string): boolean;
begin

     try
         FDSDeletaTP.StoredProcName :='sp_del_tp';
         FDSDeletaTP.Prepare;
         FDSDeletaTP.ParamByName('ID_ORGANIZACAO').AsString := pIdOrganizacao;
         FDSDeletaTP.ParamByName('ID_TITULO_PAGAR').AsString := pID;
         FDSDeletaTP.ExecProc;

         dmConexao.Conn.CommitRetaining;

     except
          dmConexao.Conn.RollbackRetaining;
          raise Exception.Create('Erro ao tentar Deletar Titulos (SP_DEL_TP)');

     end;

   Result := System.True;
end;

procedure TfrmManutencao.FormCreate(Sender: TObject);
begin
inicializarDM(Self);
framePB1.Visible := False;
framePB1.lblProgressBar.Visible :=False;
idOrganizacao := TOrgAtual.getId;
ObterTodosTitulosPagar(idOrganizacao);

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
//nada


end;


function TfrmManutencao.obterFilhosPorTP(pIdOrganizacao,  pIdTP: string): boolean;
begin

     try
           qryObterFilhosTP.Close;
           qryObterFilhosTP.Connection := dmConexao.Conn;
           qryObterFilhosTP.ParamByName('PIDORGANIZACAO').AsString :=pIdOrganizacao;
           qryObterFilhosTP.ParamByName('PIDGERADOR').AsString     :=pIdTP;
           qryObterFilhosTP.Open();

     except
      raise Exception.Create('Erro ao tentar Obter Filhos por TP');

     end;


      Result := not qryObterFilhosTP.IsEmpty; //se encotrar filhos retorna true
//fim
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
            dbgrdMain.DataSource.DataSet :=query;
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

    Result :=System.True;

end;




function TfrmManutencao.ObterTodosTitulosPagar(pIdOrganizacao :string): TFDQuery;
begin
    qryTodosTP.Close;
    qryTodosTP.Connection := dmConexao.Conn;
    qryTodosTP.SQL.Clear;
    qryTodosTP.SQL.Add(' SELECT * FROM TITULO_PAGAR TP WHERE TP.ID_ORGANIZACAO = :PIDORGANIZACAO ' ) ;
    qryTodosTP.ParamByName('PIDORGANIZACAO').AsString := PIDORGANIZACAO;
    qryTodosTP.Open;

    Result := qryTodosTP;
end;



function TfrmManutencao.removeFilhosTP(pIdOrganizacao, pIdTPFilho: string): boolean;
begin

  qryRemoveFilhoTP.Close;
  qryRemoveFilhoTP.Connection := dmConexao.Conn;
  qryRemoveFilhoTP.ParamByName('PIDORGANIZACAO').AsString := PIDORGANIZACAO;
  qryRemoveFilhoTP.ParamByName('PIDTPFILHO').AsString := pIdTPFilho; //campo id do titulo a ser alterador

  qryRemoveFilhoTP.ExecSQL;

  dmConexao.Conn.CommitRetaining;

  Result := System.True;

end;

procedure TfrmManutencao.ObterQtdRegistro(pTable :string);
var
cmd : String;
begin
   cmd :=' SELECT count(*) as REGISTROS '+
        '  FROM  ' +  pTable +
        '  WHERE 1=1 ;' ;

    qryQtdRegistros.Close;
    qryQtdRegistros.Connection := dmConexao.Conn;
    qryQtdRegistros.SQL.Clear;
    qryQtdRegistros.SQL.Add(cmd);
    qryQtdRegistros.Open;

end;






end.
