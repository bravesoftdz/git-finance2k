unit uFrmTelaPagamentoTP;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls,uFrmBaixaFP;

type
  TfrmPagamentoTitulos = class(TForm)
    btnBaixaTP: TButton;
    procedure btnBaixaTPClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmPagamentoTitulos: TfrmPagamentoTitulos;

implementation

{$R *.dfm}

procedure TfrmPagamentoTitulos.btnBaixaTPClick(Sender: TObject);
var
vlrDevido :Currency;
begin
  vlrDevido := 199.23;
 try
    frmBaixa := TFrmBaixaFP.Create(Self,vlrDevido);
    frmBaixa.ShowModal;
    FreeAndNil(frmBaixa);

  except
    on e: Exception do
      ShowMessage(e.Message + sLineBreak + 'Contate o suporte. Informe erro: ' + ' TfrmBaixaFP ' );
  end;



end;

procedure TfrmPagamentoTitulos.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  Action := caFree;

end;

end.
