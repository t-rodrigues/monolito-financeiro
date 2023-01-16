unit MonolitoFinanceiro.View.Spash;

interface

uses
  Winapi.Windows,
  Winapi.Messages,
  System.SysUtils,
  System.Variants,
  System.Classes,
  Vcl.Graphics,
  Vcl.Controls,
  Vcl.Forms,
  Vcl.Dialogs,
  Vcl.ComCtrls,
  Vcl.StdCtrls,
  Vcl.Imaging.pngimage,
  Vcl.ExtCtrls;

type
  TfrmSplashScreen = class(TForm)
    pnlPrincipal: TPanel;
    imgDll: TImage;
    lblStatus: TLabel;
    ProgressBar1: TProgressBar;
    lblNomeAplicacao: TLabel;
    Timer1: TTimer;
    imgLogo: TImage;
    imgBanco: TImage;
    imgConfiguracoes: TImage;
    imgIniciando: TImage;
    procedure Timer1Timer(Sender: TObject);
  private
    { Private declarations }
    procedure AtualizaStatus(Mensagem: String; Imagem: TImage);
  public
    { Public declarations }
  end;

var
  frmSplashScreen: TfrmSplashScreen;

implementation

{$R *.dfm}

procedure TfrmSplashScreen.AtualizaStatus(Mensagem: String; Imagem: TImage);
begin
  lblStatus.Caption := Mensagem;
  Imagem.Visible := true;
end;

procedure TfrmSplashScreen.Timer1Timer(Sender: TObject);
begin
  if ProgressBar1.Position <= 100 then
  begin
    ProgressBar1.StepIt;
    case ProgressBar1.Position of
      10:
        AtualizaStatus('Carregando dependências...', imgDll);
      25:
        AtualizaStatus('Conectando ao banco de dados...', imgBanco);
      45:
        AtualizaStatus('Carregando as configurações...', imgConfiguracoes);
      75:
        AtualizaStatus('Iniciando o Sistema...', imgIniciando);
    end;
  end;

  if ProgressBar1.Position = 100 then
    Close;
end;

end.
