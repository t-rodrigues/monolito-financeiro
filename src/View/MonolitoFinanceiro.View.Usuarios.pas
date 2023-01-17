unit MonolitoFinanceiro.View.Usuarios;

interface

uses
  Winapi.Windows,
  Winapi.Messages,
  System.Variants,
  System.Classes,
  Vcl.Graphics,
  Vcl.Controls,
  Vcl.Forms,
  Vcl.Dialogs,
  MonolitoFinanceiro.View.CadastroPadrao,
  Data.DB,
  System.ImageList,
  Vcl.ImgList,
  Vcl.Grids,
  Vcl.DBGrids,
  Vcl.StdCtrls,
  Vcl.ExtCtrls,
  Vcl.WinXPanels,
  MonolitoFinanceiro.Model.Usuarios,
  Vcl.WinXCtrls,
  MonolitoFinanceiro.Utilitarios;

type
  TfrmUsuarios = class(TfrmCadastroPadrao)
    edtNome: TEdit;
    edtLogin: TEdit;
    edtSenha: TEdit;
    ToggleSwitch1: TToggleSwitch;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    Label5: TLabel;
    procedure btnPesquisarClick(Sender: TObject);
    procedure btnAlterarClick(Sender: TObject);
    procedure btnSalvarClick(Sender: TObject);
    procedure btnIncluirClick(Sender: TObject);
    procedure btnCancelarClick(Sender: TObject);
    procedure btnExcluirClick(Sender: TObject);
  private
    { Private declarations }
    procedure limparFormulario;
    procedure validarFormulario;
  public
    { Public declarations }
  end;

var
  frmUsuarios: TfrmUsuarios;

implementation

uses
  System.SysUtils;

{$R *.dfm}

procedure TfrmUsuarios.btnAlterarClick(Sender: TObject);
begin
  inherited;
  dmUsuarios.cdsUsuarios.Edit;
  edtNome.Text := dmUsuarios.cdsUsuariosNome.AsString;
  edtLogin.Text := dmUsuarios.cdsUsuariosLogin.AsString;
  edtSenha.Text := dmUsuarios.cdsUsuariosSenha.AsString;

  ToggleSwitch1.State := tssOn;
  if dmUsuarios.cdsUsuariosstatus.AsString.ToUpper = 'B' then
    ToggleSwitch1.State := tssOff;
end;

procedure TfrmUsuarios.btnCancelarClick(Sender: TObject);
begin
  inherited;
  dmUsuarios.cdsUsuarios.Cancel;
end;

procedure TfrmUsuarios.btnExcluirClick(Sender: TObject);
begin
  inherited;
  if Application.MessageBox('Deseja realmente excluir?', 'Atenção',
    MB_YESNO + MB_ICONQUESTION) <> mrYes then
  begin
    abort;
  end;

  try
    dmUsuarios.cdsUsuarios.Delete;
    dmUsuarios.cdsUsuarios.ApplyUpdates(0);
    Application.MessageBox('Registro excluido com sucesso!', 'Atenção',
      MB_OK + MB_ICONINFORMATION);
  except
    on E: Exception do
      Application.MessageBox(PWideChar(E.Message), 'Erro ao excluir',
        MB_OK + MB_ICONERROR);
  end;
end;

procedure TfrmUsuarios.btnIncluirClick(Sender: TObject);
begin
  inherited;
  limparFormulario;
  dmUsuarios.cdsUsuarios.Insert;
end;

procedure TfrmUsuarios.btnPesquisarClick(Sender: TObject);
begin
  inherited;
  dmUsuarios.cdsUsuarios.Close;
  dmUsuarios.cdsUsuarios.CommandText := 'select * from usuarios';
  dmUsuarios.cdsUsuarios.Open;
end;

procedure TfrmUsuarios.btnSalvarClick(Sender: TObject);
var
  LStatus: String;
  LMensagem: String;
begin
  inherited;
  validarFormulario;
  LStatus := 'A';
  if ToggleSwitch1.State = tssOff then
    LStatus := 'B';

  if dmUsuarios.TemLoginCadastrado(Trim(edtLogin.Text),
    dmUsuarios.cdsUsuariosid.AsString) then
  begin
    Application.MessageBox
      (PWideChar
      (Format('O login (%s) já está sendo utilizado por outro usuário.',
      [edtLogin.Text])), 'Atenção', MB_OK + MB_ICONERROR);
    edtLogin.SetFocus;
    abort;
  end;

  LMensagem := 'Registro atualizado com sucesso.';
  if dmUsuarios.cdsUsuarios.State in [dsInsert] then
  begin
    dmUsuarios.cdsUsuariosid.AsString := TUtilitario.GetId;
    dmUsuarios.cdsUsuariosdata_cadastro.AsDateTime := now;
    LMensagem := 'Registro adicionado com sucesso.';
  end;

  dmUsuarios.cdsUsuariosNome.AsString := Trim(edtNome.Text);
  dmUsuarios.cdsUsuariosLogin.AsString := Trim(edtLogin.Text);
  dmUsuarios.cdsUsuariosSenha.AsString := Trim(edtSenha.Text);
  dmUsuarios.cdsUsuariosstatus.AsString := LStatus.ToUpper;
  dmUsuarios.cdsUsuarios.Post;
  dmUsuarios.cdsUsuarios.ApplyUpdates(0);

  Application.MessageBox(PWideChar(LMensagem), 'Atenção',
    MB_OK + MB_ICONINFORMATION);
  pnlPrincipal.ActiveCard := cardPesquisa;
end;

procedure TfrmUsuarios.limparFormulario;
var
  I: Integer;
begin
  for I := 0 to Pred(ComponentCount) do
  begin
    if Components[I] is TCustomEdit then
      TCustomEdit(Components[I]).Clear;

    if Components[I] is TToggleSwitch then
      TToggleSwitch(Components[I]).State := tssOn;
  end;
end;

procedure TfrmUsuarios.validarFormulario;
begin
  if Trim(edtNome.Text) = '' then
  begin
    edtNome.SetFocus;
    Application.MessageBox('O campo nome não pode ser vazio.', 'Atenção',
      MB_OK + MB_ICONWARNING);
    abort;
  end;

  if Trim(edtLogin.Text) = '' then
  begin
    edtLogin.SetFocus;
    Application.MessageBox('O campo login não pode ser vazio.', 'Atenção',
      MB_OK + MB_ICONWARNING);
    abort;
  end;

  if Trim(edtSenha.Text) = '' then
  begin
    edtSenha.SetFocus;
    Application.MessageBox('O campo Senha não pode ser vazio.', 'Atenção',
      MB_OK + MB_ICONWARNING);
    abort;
  end;
end;

end.
