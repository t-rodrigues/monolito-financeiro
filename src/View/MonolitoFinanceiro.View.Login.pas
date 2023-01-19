unit MonolitoFinanceiro.View.Login;

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
  Vcl.ExtCtrls,
  Vcl.Imaging.pngimage,
  Vcl.StdCtrls;

type
  TfrmLogin = class(TForm)
    pnlEsquerda: TPanel;
    imgLogo: TImage;
    pnlPrincipal: TPanel;
    Panel1: TPanel;
    Panel2: TPanel;
    lblNomeAplicacao: TLabel;
    Label1: TLabel;
    Panel3: TPanel;
    Label2: TLabel;
    edtSenha: TEdit;
    Panel4: TPanel;
    Label3: TLabel;
    edtLogin: TEdit;
    btnEntrar: TButton;
    Panel5: TPanel;
    procedure btnEntrarClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmLogin: TfrmLogin;

implementation

uses
  MonolitoFinanceiro.Model.Usuarios,
  MonolitoFinanceiro.Model.Sistema;

{$R *.dfm}

procedure TfrmLogin.btnEntrarClick(Sender: TObject);
var
  Login, Senha: String;
begin
  Login := Trim(edtLogin.Text);
  Senha := Trim(edtSenha.Text);

  if Login = '' then
  begin
    edtLogin.SetFocus;
    Application.MessageBox('Informe o seu usuário.', 'Atenção',
      MB_OK + MB_ICONWARNING);
    abort;
  end;

  if Senha = '' then
  begin
    edtLogin.SetFocus;
    Application.MessageBox('Informe a sua senha.', 'Atenção',
      MB_OK + MB_ICONWARNING);
    abort;
  end;

  try
    dmUsuarios.EfetuarLogin(Login, Senha);
    dmSistema.UsuarioUltimoAcesso(Login);
    dmSistema.DataUltimoAcesso(now);
    ModalResult := mrOk;
  except
    on E: Exception do
    begin
      Application.MessageBox(PWideChar(E.Message), 'Atenção',
        MB_OK + MB_ICONWARNING);
      edtLogin.SetFocus;
    end;
  end;
end;

procedure TfrmLogin.FormShow(Sender: TObject);
var
  Login: String;
begin
  Login := dmSistema.UsuarioUltimoAcesso;

  if Login <> '' then
  begin
    edtLogin.Text := Login;
    edtSenha.SetFocus;
  end;
end;

end.
