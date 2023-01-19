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
  Vcl.Menus,
  Vcl.ComCtrls,
  Vcl.ExtCtrls;

type
  TfrmPrincipal = class(TForm)
    MainMenu1: TMainMenu;
    menuCadastros: TMenuItem;
    menuRelatorios: TMenuItem;
    menuAjuda: TMenuItem;
    menuCadastroUsuarios: TMenuItem;
    StatusBar1: TStatusBar;
    Timer1: TTimer;
    procedure menuCadastroUsuariosClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure Timer1Timer(Sender: TObject);
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
  MonolitoFinanceiro.View.Login,
  MonolitoFinanceiro.Model.Usuarios,
  MonolitoFinanceiro.Model.Entidades.Usuarios;

{$R *.dfm}

procedure TfrmPrincipal.FormCreate(Sender: TObject);
var
  LUsuarioLogado: TUsuarioModel;
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
  LUsuarioLogado := dmUsuarios.GetUsuarioLogado;
  StatusBar1.Panels.Items[1].Text := 'Usuario: ' + LUsuarioLogado.Nome + ' - ' +
    LUsuarioLogado.Login;
end;

procedure TfrmPrincipal.menuCadastroUsuariosClick(Sender: TObject);
begin
  frmUsuarios.ShowModal;
end;

procedure TfrmPrincipal.Timer1Timer(Sender: TObject);
begin
  StatusBar1.Panels.Items[0].Text := DateTimeToStr(now);
end;

end.
