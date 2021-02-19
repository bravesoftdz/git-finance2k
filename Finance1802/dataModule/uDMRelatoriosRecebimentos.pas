unit uDMRelatoriosRecebimentos;

interface

uses
  System.SysUtils, System.Classes, uUtil,
  udmConexao, FireDAC.Stan.Intf, FireDAC.Stan.Option, FireDAC.Stan.Param,
  FireDAC.Stan.Error, FireDAC.DatS, FireDAC.Phys.Intf, FireDAC.DApt.Intf,
  FireDAC.Stan.Async, FireDAC.DApt, Data.DB, FireDAC.Comp.DataSet,
  FireDAC.Comp.Client, FireDAC.UI.Intf, FireDAC.Comp.ScriptCommands,
  FireDAC.Stan.Util, FireDAC.Comp.Script;

type
  TdmRelRecebimentos = class(TDataModule)
    qryTitulosExcel: TFDQuery;
    qryCentroCusto: TFDQuery;
    sqlScriptContainer: TFDScript;
    qryObterCentroCustoPorTitulo: TFDQuery;
    qryTotalDebitoPorCliente: TFDQuery;
    qryTotalQuitadoPorCliente: TFDQuery;
    dsTitulosPagarAll: TDataSource;
    qryTitulosPorCliente: TFDQuery;
    qryRelPagamentos: TFDQuery;
    dsTituloPagarExcel: TDataSource;
    qryObterTodos: TFDQuery;
    qryObterPorNumeroDocumento: TFDQuery;
    qryObterTotalPorStatus: TFDQuery;
    dsTitulosExcel: TDataSource;
    qryObterTPHistoricoPorTitulo: TFDQuery;
    sqlScriptExcel: TFDScript;
    procedure DataModuleCreate(Sender: TObject);

  private

    { Private declarations }

        idOrgzanizacao :string;

  public
    { Public declarations }
     function obterHistoricoPorTP(pIdOrganizacao, pIdTitulo: string): Boolean;
    function obterCentroCustoPorTP(pIdOrganizacao, pIdTitulo: string): Boolean;
    function dataSourceIsEmpty(var dts: TDataSource): Boolean;
    function obterPorNumeroDocumento(pIdOrganizacao, pNumDoc: string): Boolean;
    function obterTitulosPorCliente(pIdOrganizacao, pIdCedente,
      campoOrdem: string; dtDataInicial, dtDataFinal: TDateTime): Boolean;
    function obterTodos(pIdOrganizacao: string): Boolean;
    function obterTotalPorCliente(pIdOrganizacao, pIdCedente: string;
      dtDataInicial, dtDataFinal: TDateTime): Currency;
    function obterTotalPorStatus(pIdOrganizacao, pIdStatus: string;
      dtDataInicial, dtDataFinal: TDate): Currency;
    function obterTotalQuitadoPorCliente(pIdOrganizacao, pIdCedente: string;
      dtDataInicial, dtDataFinal: TDateTime): Currency;
      function obterTodosCentroCustos(pIdOrganizacao : string) :Boolean;
      function obterTodosRecebimentos(sql :TStringList; pIdOrganizacao :string; dtDataInicial, dtDataFinal: TDate ) :Boolean;
      function obterTitulosExcel(sql :TStringList; pIdOrganizacao: string; dtDataInicial, dtDataFinal: TDateTime): Boolean;




  end;

var
  dmRelRecebimentos: TdmRelRecebimentos;

implementation

{%CLASSGROUP 'Vcl.Controls.TControl'}

{$R *.dfm}

 function TdmRelRecebimentos.obterCentroCustoPorTP(pIdOrganizacao,
  pIdTitulo: string): Boolean;
begin
   // codigoErro := 'TP-13';
    try
    // carrega os centros de custos .. sv jrg
      qryObterCentroCustoPorTitulo.Connection := dmConexao.Conn;
      qryObterCentroCustoPorTitulo.Close;
      qryObterCentroCustoPorTitulo.ParamByName('PIDTITULO').AsString := pIdTitulo;
      qryObterCentroCustoPorTitulo.ParamByName('PIDORGANIZACAO').AsString := pIdOrganizacao;
      qryObterCentroCustoPorTitulo.Open();

    except
     raise(Exception).Create('Erro ao tentar consultar o TR CENTRO_C '  );

    end;

  Result := not qryObterCentroCustoPorTitulo.IsEmpty;
end;

function TdmRelRecebimentos.obterHistoricoPorTP(pIdOrganizacao, pIdTitulo: string): Boolean;
begin
  try
      qryObterTPHistoricoPorTitulo.Connection := dmConexao.Conn;
      qryObterTPHistoricoPorTitulo.Close;
      qryObterTPHistoricoPorTitulo.ParamByName('PIDTITULO').AsString := pIdTitulo;
      qryObterTPHistoricoPorTitulo.ParamByName('PIDORGANIZACAO').AsString := pIdOrganizacao;
      qryObterTPHistoricoPorTitulo.Open();

      qryObterTPHistoricoPorTitulo.Open();
  except
  raise(Exception).Create('Erro ao tentar Obter Historicos por TR '  );
  end;

  Result := not qryObterTPHistoricoPorTitulo.IsEmpty;
end;



function TdmRelRecebimentos.obterTitulosExcel(sql :TStringList; pIdOrganizacao: string; dtDataInicial, dtDataFinal: TDateTime): Boolean;
begin
  try
      qryTitulosExcel.Connection := dmConexao.Conn;
      qryTitulosExcel.Close;
      qryTitulosExcel.SQL.Clear;
      qryTitulosExcel.SQL.Assign(sql);

    {  qryTitulosExcel.ParamByName('PIDORGANIZACAO').AsString := pIdOrganizacao;
      qryTitulosExcel.ParamByName('DTDATAINICIAL').AsString := (FormatDateTime('mm/dd/yyyy', dtDataInicial));   //ver pq pega com hora
      qryTitulosExcel.ParamByName('DTDATAFINAL').AsString := (FormatDateTime('mm/dd/yyyy', dtDataFinal)); }

      qryTitulosExcel.Open();
  except
  raise(Exception).Create('Erro ao tentar Obter todos os dados para o formato CSV '  );
  end;

  Result := not qryTitulosExcel.IsEmpty;
end;
//

procedure TdmRelRecebimentos.DataModuleCreate(Sender: TObject);
var
aux : string;
begin
  dmConexao.conectarBanco;

  aux := '';
  idOrgzanizacao := TOrgAtual.getId;
//  qryRelPagamentos.Open();
end;

function TdmRelRecebimentos.dataSourceIsEmpty(var dts: TDataSource): Boolean;
begin
  Result := dts.DataSet.IsEmpty;
end;

function TdmRelRecebimentos.obterTitulosPorCliente(pIdOrganizacao, pIdCedente, campoOrdem: string; dtDataInicial, dtDataFinal: TDateTime): Boolean;
var
  cmd: string;
begin
  cmd := 'SELECT * FROM  TITULO_RECEBER  TR ' + 'WHERE (TR.ID_SACADO = :PIDSACADO) AND ' + '(TR.ID_TIPO_STATUS in ' + '(''ABERTO'',''QUITADO'',''PARCIAL'')) AND ' + '(TR.ID_ORGANIZACAO = :PIDORGANIZACAO) AND ' + '(TR.DATA_EMISSAO BETWEEN :DTDATAINICIAL AND :DTDATAFINAL) ' + ' ORDER BY ' + campoOrdem;

  try
    qryTitulosPorCliente.Connection := dmConexao.Conn;
    qryTitulosPorCliente.Close;
    qryTitulosPorCliente.SQL.Clear;
    qryTitulosPorCliente.SQL.Add(cmd);
    qryTitulosPorCliente.ParamByName('PIDORGANIZACAO').AsString := pIdOrganizacao;
    qryTitulosPorCliente.ParamByName('PIDSACADO').AsString := pIdCedente;
    qryTitulosPorCliente.ParamByName('DTDATAINICIAL').AsString := FormatDateTime('mm/dd/yyyy', dtDataInicial);
    qryTitulosPorCliente.ParamByName('DTDATAFINAL').AsString := FormatDateTime('mm/dd/yyyy', dtDataFinal);
    qryTitulosPorCliente.Open;
  except

  raise(Exception).Create('Erro ao tentar Obter todos os TRs '  );


  end;

  Result := not qryTitulosPorCliente.IsEmpty;

end;

function TdmRelRecebimentos.obterTotalPorCliente(pIdOrganizacao, pIdCedente: string; dtDataInicial, dtDataFinal: TDateTime): Currency;
begin

  try
      qryTotalDebitoPorCliente.Connection := dmConexao.Conn;
      qryTotalDebitoPorCliente.Close;
      qryTotalDebitoPorCliente.ParamByName('PIDORGANIZACAO').AsString := pIdOrganizacao;
      qryTotalDebitoPorCliente.ParamByName('PIDSACADO').AsString := pIdCedente;
      qryTotalDebitoPorCliente.ParamByName('DTDATAINICIAL').AsString := FormatDateTime('mm/dd/yyyy', dtDataInicial);
      qryTotalDebitoPorCliente.ParamByName('DTDATAFINAL').AsString := FormatDateTime('mm/dd/yyyy', dtDataFinal);

      qryTotalDebitoPorCliente.Open;
  except

  raise(Exception).Create('Erro ao tentar Obter todos os TRs '  );


  end;

  Result := qryTotalDebitoPorCliente.Fields[0].AsCurrency;
end;

function TdmRelRecebimentos.obterTotalPorStatus(pIdOrganizacao, pIdStatus: string; dtDataInicial, dtDataFinal: TDate): Currency;
var
sqlCmd :String;
begin
dmConexao.conectarBanco;

sqlCmd := ' SELECT SUM(TR.VALOR_NOMINAL) DEBITO ' +
          ' FROM  TITULO_RECEBER  TR ' +
          ' WHERE (TR.ID_TIPO_STATUS IN (''ABERTO'')) '+
          ' AND  (TR.ID_ORGANIZACAO = :PIDORGANIZACAO) ' +
          ' AND  (TR.DATA_VENCIMENTO BETWEEN :DTDATAINICIAL AND :DTDATAFINAL); ' ;


    if pIdStatus.Equals('QUITADO') then begin
      sqlCmd := ' SELECT SUM(TR.VALOR_NOMINAL ) DEBITO ' +
                ' FROM  TITULO_RECEBER  TR ' +
                ' WHERE (TR.ID_ORGANIZACAO = :PIDORGANIZACAO) ' +
                ' AND   ((TR.ID_TIPO_STATUS = ''QUITADO'') OR  (TR.ID_TIPO_STATUS  = ''PARCIAL'') ) '+  // IN (''QUITADO'', ''PARCIAL'')) '+
                ' AND  (TR.DATA_PAGAMENTO IS NOT NULL) '+
                ' AND   (TR.DATA_VENCIMENTO BETWEEN :DTDATAINICIAL AND :DTDATAFINAL); ' ;
    end;


    try
      qryObterTotalPorStatus.Connection := dmConexao.Conn;
      qryObterTotalPorStatus.Close;
      qryObterTotalPorStatus.SQL.Clear;
      qryObterTotalPorStatus.SQL.Add(sqlCmd);
      qryObterTotalPorStatus.ParamByName('PIDORGANIZACAO').AsString := pIdOrganizacao;
  //    qryObterTotalPorStatus.ParamByName('PIDSTATUS').AsString := pIdStatus;
      qryObterTotalPorStatus.ParamByName('DTDATAINICIAL').AsDate :=dtDataInicial;
      qryObterTotalPorStatus.ParamByName('DTDATAFINAL').AsDate := dtDataFinal;

      qryObterTotalPorStatus.Open;

    except

    raise(Exception).Create('Erro ao tentar Obter total por status '  );


    end;

  Result := qryObterTotalPorStatus.Fields[0].AsCurrency;
end;

function TdmRelRecebimentos.obterTotalQuitadoPorCliente(pIdOrganizacao, pIdCedente: string; dtDataInicial, dtDataFinal: TDateTime): Currency;
begin
  try
      qryTotalQuitadoPorCliente.Connection := dmConexao.Conn;
      qryTotalQuitadoPorCliente.Close;
      qryTotalQuitadoPorCliente.ParamByName('PIDORGANIZACAO').AsString := pIdOrganizacao;
      qryTotalQuitadoPorCliente.ParamByName('PIDSACADO').AsString := pIdCedente;
      qryTotalQuitadoPorCliente.ParamByName('DTDATAINICIAL').AsString := FormatDateTime('mm/dd/yyyy', dtDataInicial);
      qryTotalQuitadoPorCliente.ParamByName('DTDATAFINAL').AsString := FormatDateTime('mm/dd/yyyy', dtDataFinal);

      qryTotalQuitadoPorCliente.Open;
  except

  raise(Exception).Create('Erro ao tentar Obter todos os TRB POR CLIENTE '  );


  end;

  Result := qryTotalQuitadoPorCliente.Fields[0].AsCurrency;

end;




function TdmRelRecebimentos.obterTodos(pIdOrganizacao: string): Boolean;
begin
   try
      qryObterTodos.Close;
      qryObterTodos.Connection := dmConexao.Conn;
      qryObterTodos.ParamByName('PIDORGANIZACAO').AsString := pIdOrganizacao;

      qryObterTodos.Open;
  except

  raise(Exception).Create('Erro ao tentar Obter todos os TRs '  );


  end;
  Result := not qryObterTodos.IsEmpty;
end;

function TdmRelRecebimentos.obterTodosCentroCustos(
  pIdOrganizacao: string): Boolean;
begin

  try
      qryCentroCusto.Close;
      qryCentroCusto.Connection := dmConexao.Conn;
      qryCentroCusto.ParamByName('PIDORGANIZACAO').AsString := pIdOrganizacao;
      qryCentroCusto.Open();
  except
  raise(Exception).Create('Erro ao tentar obter todos os Centro de Custos. ');
  end;

  Result := not qryCentroCusto.IsEmpty;

end;

function TdmRelRecebimentos.obterTodosRecebimentos(sql :TStringList; pIdOrganizacao : string; dtDataInicial, dtDataFinal: TDate): Boolean;
var
aux :Integer;
begin
     
  if sql.Count >0  then begin

      try

      qryRelPagamentos.Close;
      qryRelPagamentos.Connection := dmConexao.Conn;
      qryRelPagamentos.SQL.Clear;
      qryRelPagamentos.SQL.Assign(sql);
      qryRelPagamentos.Open;

      except
      raise(Exception).Create('Erro ao tentar  consultar os Titulos ' + ' obterTodosRecebimentos ' );
      end;
  end;
   aux :=qryRelPagamentos.RecordCount;

  Result := not qryRelPagamentos.IsEmpty;

end;

function TdmRelRecebimentos.obterPorNumeroDocumento(pIdOrganizacao, pNumDoc: string): Boolean;
begin
  try

      qryObterPorNumeroDocumento.Close;
      qryObterPorNumeroDocumento.Connection := dmConexao.Conn;
      qryObterPorNumeroDocumento.ParamByName('PIDORGANIZACAO').AsString := pIdOrganizacao;
      qryObterPorNumeroDocumento.ParamByName('PNUMDOC').AsString := pNumDoc;

      qryObterPorNumeroDocumento.Open;

  except

  raise(Exception).Create('Erro ao tentar consultar o TR DOC ' + pNumDoc );


  end;

  Result := not qryObterPorNumeroDocumento.IsEmpty;
end;



end.
