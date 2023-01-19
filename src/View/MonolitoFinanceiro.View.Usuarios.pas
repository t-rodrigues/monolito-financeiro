unit MonolitoFinanceiro.View.Usuarios;

interface

uses
  Winapi.Windows,
  Winapi.Messages,
  System.Variants,
  System.Classes,
  System.SysUtils,
  Vcl.Graphics,
  Vcl.Controls,
  Vcl.Forms,
  Vcl.Dialogs,
  Data.DB,
  System.ImageList,
  Vcl.ImgList,
  Vcl.Grids,
  Vcl.DBGrids,
  Vcl.StdCtrls,
  Vcl.ExtCtrls,
  Vcl.WinXPanels,
  Vcl.WinXCtrls,
  MonolitoFinanceiro.View.CadastroPadrao,
  MonolitoFinanceiro.Model.Usuarios,
  MonolitoFinanceiro.Utilitarios,
  Vcl.Menus;

type
  TfrmUsuarios = class(TfrmCadastroPadrao)
    edtNome: TEdit;
    edtLogin: TEdit;
    ToggleSwitch1: TToggleSwitch;
    Label2: TLabel;
    Label3: TLabel;
    Label5: TLabel;
    PopupMenu1: TPopupMenu;
    menuLimparSenha: TMenuItem;
    procedure btnPesquisarClick(Sender: TObject);
    procedure btnAlterarClick(Sender: TObject);
    procedure btnSalvarClick(Sender: TObject);
    procedure btnIncluirClick(Sender: TObject);
    procedure btnCancelarClick(Sender: TObject);
    procedure btnExcluirClick(Sender: TObject);
    procedure menuLimparSenhaClick(Sender: TObject);
  private
    { Private declarations }
    procedure limparFormulario;
    procedure validarFormulario;
    function hashSenha(payload: String): String;
  public
    { Public declarations }
  end;

var
  frmUsuarios: TfrmUsuarios;

const
  TEMP_PASSWORD = '123';

implementation

uses
  BCrypt,
  BCrypt.Types;

{$R *.dfm}

procedure TfrmUsuarios.btnAlterarClick(Sender: TObject);
begin
  inherited;
  dmUsuarios.cdsUsuarios.Edit;
  edtNome.Text := dmUsuarios.cdsUsuariosNome.AsString;
  edtLogin.Text := dmUsuarios.cdsUsuariosLogin.AsString;

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
    dmUsuarios.cdsUsuariossenha.AsString := hashSenha(TEMP_PASSWORD);
    LMensagem := 'Registro adicionado com sucesso.';
  end;

  dmUsuarios.cdsUsuariosNome.AsString := Trim(edtNome.Text);
  dmUsuarios.cdsUsuariosLogin.AsString := Trim(edtLogin.Text);
  dmUsuarios.cdsUsuariosstatus.AsString := LStatus.ToUpper;
  dmUsuarios.cdsUsuarios.Post;
  dmUsuarios.cdsUsuarios.ApplyUpdates(0);

  Application.MessageBox(PWideChar(LMensagem), 'Atenção',
    MB_OK + MB_ICONINFORMATION);
  pnlPrincipal.ActiveCard := cardPesquisa;
end;

function TfrmUsuarios.hashSenha(payload: String): String;
begin
  Result := TBCrypt.GenerateHash(payload);
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

procedure TfrmUsuarios.menuLimparSenhaClick(Sender: TObject);
var
  LNome: String;
begin
  inherited;

  if not DataSource1.DataSet.IsEmpty then
  begin
    LNome := DataSource1.DataSet.FieldByName('nome').AsString;
    dmUsuarios.LimparSenha(DataSource1.DataSet.FieldByName('id').AsString);
    Application.MessageBox
      (PWideChar(Format('Foi definida a senha padrão para o usuário %s.',
      [LNome])), 'Atenção', MB_OK + MB_ICONEXCLAMATION);
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
end;

end.
