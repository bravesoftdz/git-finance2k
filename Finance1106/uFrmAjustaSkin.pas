unit uFrmAjustaSkin;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,uUtil,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.ComCtrls, Vcl.FileCtrl,
  sSkinManager;

type
  TfrmSkin = class(TForm)
    redt1: TRichEdit;
    fllstSkin: TFileListBox;
    skm: TsSkinManager;
    procedure fllstSkinClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmSkin: TfrmSkin;

implementation

{$R *.dfm}

procedure TfrmSkin.fllstSkinClick(Sender: TObject);
begin
    //Atribui outro skin para gerenciador e salva no arquivo config
     skm.SkinName := uUtil.gravarSkinDefault(ExtractFileName(fllstSkin.FileName));
     Application.ProcessMessages;

end;

procedure TfrmSkin.FormCreate(Sender: TObject);
begin
    skm.SkinDirectory := uUtil.getPathPastaSkin('0');
    //Seta o endere�o dos skins para o lstSkin (TFileListBox)
    fllstSkin.Directory := skm.SkinDirectory;
    
end;

end.