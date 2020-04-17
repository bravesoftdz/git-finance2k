unit uFrameBDTables;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes,
  Vcl.Graphics, Vcl.Controls, Vcl.Forms, Vcl.Dialogs, udmConexao, udmManutencao,
  Data.DB, Vcl.Grids, Vcl.DBGrids, Vcl.StdCtrls, FireDAC.Stan.Intf,
  FireDAC.Stan.Option, FireDAC.Stan.Param, FireDAC.Stan.Error, FireDAC.DatS,
  FireDAC.Phys.Intf, FireDAC.DApt.Intf, FireDAC.Stan.Async, FireDAC.DApt,
  FireDAC.Comp.DataSet, FireDAC.Comp.Client;

type
  TfrmBDTables = class(TFrame)
    dbgrd1: TDBGrid;
    ds1: TDataSource;
    qryAllTables: TFDQuery;
  private
  function obterTables: Boolean;
  function listaTables: TStringList;
    { Private declarations }
  public
  procedure obterTabelas();
      { Public declarations }
  end;

implementation

{$R *.dfm}

{ TfrmBDTables }

procedure TfrmBDTables.obterTabelas;
begin
listaTables;
end;



function TfrmBDTables.listaTables: TStringList;
var
  lista: TStringList;
begin

  lista := TStringList.Create;
  lista.Clear;
  lista.Add('>> Selecione uma tabela << ');

 if obterTables then begin

  qryAllTables.First;
  while not qryAllTables.Eof do
  begin
    lista.Add(qryAllTables.FieldByName('TABELA') .AsString);
    qryAllTables.Next;
  end;
 // qryAllTables.Close;

  Result := lista;

 end;
end;



function TfrmBDTables.obterTables: Boolean;
begin
  Result := false;

      try
        qryAllTables.Connection := dmConexao.Conn;
        qryAllTables.Close;
        qryAllTables.SQL.Clear;
        qryAllTables.SQL.Add(' SELECT rdb$relation_name as tabela FROM rdb$relations WHERE rdb$system_flag = 0 ORDER BY  rdb$relation_name ' );

        qryAllTables.Open;
      except
        raise Exception.Create('Erro ao obter tabelas do sistema ');

      end;

  //  listaTables; //preecnhe a lista com as tabelas encontradas


    Result := not qryAllTables.IsEmpty;


 end;

end.
