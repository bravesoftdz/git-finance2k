unit uFrmTituloPagarParcelado;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, ENumEd, Data.DB, uTituloPagarModel,
  Vcl.Grids, Vcl.DBGrids;

type
  TfrmTituloPagarParcelado = class(TForm)
    edtQtdParcelas: TEdit;
    Label1: TLabel;
    edtValorDespesa: TEvNumEdit;
    Label2: TLabel;
    DataSource1: TDataSource;
    DBGrid1: TDBGrid;
    procedure FormCreate(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
  private
    { Private declarations }
  public
    { Public declarations }

    constructor Create (AOwner :TComponent; pTitulo :TTituloPagarModel);


  end;

var
  frmTituloPagarParcelado: TfrmTituloPagarParcelado;

implementation

{$R *.dfm}

{ TfrmTituloPagarParcelado }

constructor TfrmTituloPagarParcelado.Create(AOwner: TComponent;  pTitulo: TTituloPagarModel);
var
parcela :Integer;

begin
  inherited Create(AOwner);

   edtQtdParcelas.Text    := pTitulo.Fparcela;
   edtValorDespesa.Value  := pTitulo.FvalorNominal;

end;

procedure TfrmTituloPagarParcelado.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
Action :=caFree;
end;

procedure TfrmTituloPagarParcelado.FormCreate(Sender: TObject);
begin
//

end;

end.