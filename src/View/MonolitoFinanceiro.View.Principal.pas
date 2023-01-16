unit MonolitoFinanceiro.View.Principal;

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
  Vcl.Menus;

type
  TfrmPrincipal = class(TForm)
    MainMenu1: TMainMenu;
    menuCadastros: TMenuItem;
    menuRelatorios: TMenuItem;
    menuAjuda: TMenuItem;
    menuCadastroPadrao: TMenuItem;
    procedure menuCadastroPadraoClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmPrincipal: TfrmPrincipal;

implementation

uses
  MonolitoFinanceiro.View.CadastroPadrao,
  MonolitoFinanceiro.View.Spash;

{$R *.dfm}

procedure TfrmPrincipal.FormCreate(Sender: TObject);
begin
  frmSplashScreen := TfrmSplashScreen.Create(nil);
  try
    frmSplashScreen.ShowModal;
  finally
    FreeAndNil(frmSplashScreen);
  end;
end;

procedure TfrmPrincipal.menuCadastroPadraoClick(Sender: TObject);
begin
  frmCadastroPadrao.ShowModal;
end;

end.
