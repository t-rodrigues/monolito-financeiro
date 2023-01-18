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
    menuCadastroUsuarios: TMenuItem;
    procedure menuCadastroUsuariosClick(Sender: TObject);
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
  MonolitoFinanceiro.View.Spash,
  MonolitoFinanceiro.View.Usuarios,
  MonolitoFinanceiro.View.Login;

{$R *.dfm}

procedure TfrmPrincipal.FormCreate(Sender: TObject);
begin
  frmSplashScreen := TfrmSplashScreen.Create(nil);
  try
    frmSplashScreen.ShowModal;
  finally
    FreeAndNil(frmSplashScreen);
  end;
  frmLogin := TfrmLogin.Create(nil);
  try
    frmLogin.ShowModal;

    if frmLogin.ModalResult <> mrOk then
      Application.Terminate;
  finally
    FreeAndNil(frmLogin);
  end;
end;

procedure TfrmPrincipal.menuCadastroUsuariosClick(Sender: TObject);
begin
  frmUsuarios.ShowModal;
end;

end.
