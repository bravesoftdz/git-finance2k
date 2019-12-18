unit uFrameContaBancaria;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes,
  Vcl.Graphics, Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls,
  FireDAC.Stan.Intf, FireDAC.Stan.Option, FireDAC.Stan.Param,uContaContabilModel,    udmConexao, uUtil,
  FireDAC.Stan.Error, FireDAC.DatS, FireDAC.Phys.Intf, FireDAC.DApt.Intf,
  FireDAC.Stan.Async, FireDAC.DApt, Data.DB, FireDAC.Comp.DataSet,
  FireDAC.Comp.Client, Vcl.ComCtrls;

type
  TfrmContaBancaria = class(TFrame)
    cbbConta: TComboBox;
    lbl1: TLabel;
    qryObterContaContabil: TFDQuery;
    qryObterTodos: TFDQuery;

  private
    { Private declarations }
    idOrganizacao : string;
    FsListaIdContas : TStringList;

  public
    { Public declarations }



 function obterTodos(pIdValue: string; var combo: TComboBox;   var listaID: TStringList): boolean;
 function obterContaContabil (pIDOrganizacao, pIDContaBancaria :string) : Boolean;
 function getContaContabil  (pIDOrganizacao, pIDContaBancaria :string) : TContaContabilModel;


  end;

implementation

{$R *.dfm}

{ TfrmContaBancaria }


function TfrmContaBancaria.getContaContabil(pIDOrganizacao, pIDContaBancaria: string): TContaContabilModel;
var
conta : TContaContabilModel;

begin
   conta :=TContaContabilModel.Create;

 try
    if obterContaContabil(pIDOrganizacao, pIDContaBancaria) then begin

        conta.SetFCodigoReduzido(qryObterContaContabil.FieldByName('CODREDUZ').AsString);
        conta.SetFConta(qryObterContaContabil.FieldByName('CONTA').AsString);
        conta.SetFDescricao(qryObterContaContabil.FieldByName('DESCRICAO').AsString);
        conta.SetFDgReduz(qryObterContaContabil.FieldByName('DGREDUZ').AsString);
        conta.SetFDgVer(qryObterContaContabil.FieldByName('DGVER').AsString);
        conta.SetFIdContaContabil(qryObterContaContabil.FieldByName('ID_CONTA_CONTABIL').AsString);
        conta.SetFIdOrganizacao(qryObterContaContabil.FieldByName('ID_ORGANIZACAO').AsString);

    end;

  except

    raise(Exception).Create('N�o foi poss�vel obter a conta cont�bil.');

  end;


  Result := conta;
end;



function TfrmContaBancaria.obterContaContabil(pIDOrganizacao,
  pIDContaBancaria: string): Boolean;
  var
  sqlCC :string;
begin
dmConexao.conectarBanco;
 idOrganizacao := TOrgAtual.getId;

  sqlCC :=  ' SELECT CB.ID_CONTA_BANCARIA, '+
            ' CB.ID_ORGANIZACAO, '+
            ' CC.ID_CONTA_CONTABIL,'+
            ' CC.DESCRICAO, '+
            ' CC.CONTA,  '+
            ' CC.DGVER,   '+
            ' CC.CODREDUZ,  '+
            ' CC.DGREDUZ   '+
            ' FROM CONTA_BANCARIA CB '+
            ' LEFT OUTER JOIN CONTA_CONTABIL CC ON (CC.ID_CONTA_CONTABIL = CB.ID_CONTA_CONTABIL) AND (CC.ID_ORGANIZACAO = CB.ID_ORGANIZACAO) '+
            ' WHERE (CB.ID_ORGANIZACAO = :PIDORGANIZACAO) AND   (CB.ID_CONTA_BANCARIA = :PIDCONTABANCARIA) ' ;


 try
  // qryObterContaContabil := TFDQuery.Create(Self);
   qryObterContaContabil.Close;
   qryObterContaContabil.Connection := dmConexao.conn;
   qryObterContaContabil.SQL.Clear;
   qryObterContaContabil.SQL.Add(sqlCC);
   qryObterContaContabil.ParamByName('PIDORGANIZACAO').AsString := idOrganizacao;
   qryObterContaContabil.ParamByName('PIDCONTABANCARIA').AsString := pIDContaBancaria;
   qryObterContaContabil.Open;

 except

    raise(Exception).Create('Problemas ao tentar consultar conta cont�bl');

  end;
 Result := not qryObterContaContabil.IsEmpty;

end;

function TfrmContaBancaria.obterTodos(pIdValue: string; var combo: TComboBox;
  var listaID: TStringList): boolean;
begin

dmConexao.conectarBanco;
idOrganizacao := TOrgAtual.getId;

  listaID := TStringList.Create;
  listaID.Clear;
  listaID.Add('Sem ID');
   combo.Clear;
   combo.Items.Add('<<< Selecione uma Conta  >>>');

   qryObterTodos.Close;
   qryObterTodos.Connection := dmConexao.conn;
   qryObterTodos.ParamByName('PIDORGANIZACAO').AsString := idOrganizacao;
   qryObterTodos.Open;

   if not qryObterTodos.IsEmpty then begin
          qryObterTodos.First;

      while not qryObterTodos.Eof do
        begin
          combo.Items.Add(qryObterTodos.FieldByName('CONTA').AsString);
          listaID.Add(qryObterTodos.FieldByName('ID_CONTA_BANCARIA').AsString);
          qryObterTodos.Next;
        end;
      qryObterTodos.Close;
      combo.ItemIndex := 0;

   end;

end;


end.
