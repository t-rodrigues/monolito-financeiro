program MonolitoFinanceiro;

uses
  Vcl.Forms,
  MonolitoFinanceiro.View.Principal in 'src\View\MonolitoFinanceiro.View.Principal.pas' {frmPrincipal},
  MonolitoFinanceiro.View.CadastroPadrao in 'src\View\MonolitoFinanceiro.View.CadastroPadrao.pas' {frmCadastroPadrao},
  MonolitoFinanceiro.View.Spash in 'src\View\MonolitoFinanceiro.View.Spash.pas' {frmSplashScreen},
  MonolitoFinanceiro.Model.Conexao in 'src\Model\MonolitoFinanceiro.Model.Conexao.pas' {DataModule1: TDataModule},
  MonolitoFinanceiro.View.Usuarios in 'src\View\MonolitoFinanceiro.View.Usuarios.pas' {frmCadastroPadrao1};

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TfrmPrincipal, frmPrincipal);
  Application.CreateForm(TfrmCadastroPadrao, frmCadastroPadrao);
  Application.CreateForm(TDataModule1, DataModule1);
  Application.CreateForm(TfrmCadastroPadrao1, frmCadastroPadrao1);
  Application.Run;
end.
