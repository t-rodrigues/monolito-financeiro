unit MonolitoFinanceiro.Model.Usuarios;

interface

uses
  System.SysUtils,
  System.Classes,
  FireDAC.Stan.Intf,
  FireDAC.Stan.Option,
  FireDAC.Stan.Param,
  FireDAC.Stan.Error,
  FireDAC.DatS,
  FireDAC.Phys.Intf,
  FireDAC.DApt.Intf,
  FireDAC.Stan.Async,
  FireDAC.DApt,
  Datasnap.Provider,
  Datasnap.DBClient,
  Data.DB,
  FireDAC.Comp.DataSet,
  FireDAC.Comp.Client,
  MonolitoFinanceiro.Model.Conexao,
  MonolitoFinanceiro.Model.Entidades.Usuarios;

type
  TdmUsuarios = class(TDataModule)
    sqlUsuarios: TFDQuery;
    cdsUsuarios: TClientDataSet;
    dspUsuarios: TDataSetProvider;
    cdsUsuariosid: TStringField;
    cdsUsuariosNome: TStringField;
    cdsUsuarioslogin: TStringField;
    cdsUsuariosstatus: TStringField;
    cdsUsuariosdata_cadastro: TDateField;
    cdsUsuariossenha: TStringField;
    cdsUsuariossenha_temporaria: TStringField;
    procedure DataModuleCreate(Sender: TObject);
    procedure DataModuleDestroy(Sender: TObject);
  private
    FUsuarioModel: TUsuarioModel;
    { Private declarations }
    function ValidaSenha(payload: String; hash: String): Boolean;
    function HashSenha(payload: String): String;
  public
    { Public declarations }
    function TemLoginCadastrado(Login, id: String): Boolean;
    procedure EfetuarLogin(Login: String; Senha: String);
    function GetUsuarioLogado: TUsuarioModel;
    procedure LimparSenha(IdUsuario: String);
    procedure RedefinirSenha(Usuario: TUsuarioModel);
  end;

var
  dmUsuarios: TdmUsuarios;

implementation

uses
  BCrypt;

{%CLASSGROUP 'Vcl.Controls.TControl'}
{$R *.dfm}
{ TdmUsuarios }

procedure TdmUsuarios.DataModuleCreate(Sender: TObject);
begin
  FUsuarioModel := TUsuarioModel.Create;
end;

procedure TdmUsuarios.DataModuleDestroy(Sender: TObject);
begin
  FreeAndNil(FUsuarioModel);
end;

procedure TdmUsuarios.EfetuarLogin(Login: String; Senha: String);
var
  SQLConsulta: TFDQuery;
begin
  SQLConsulta := TFDQuery.Create(nil);
  try
    SQLConsulta.Connection := dmConexao.SQLConexao;
    SQLConsulta.SQL.Clear;
    SQLConsulta.SQL.Add('select * from usuarios where login = :login');
    SQLConsulta.ParamByName('login').AsString := Login;
    SQLConsulta.Open;

    if SQLConsulta.IsEmpty or not ValidaSenha(Senha,
      SQLConsulta.FieldByName('senha').AsString) then
      raise Exception.Create('Usuário e/ou senha inválidos.');

    if SQLConsulta.FieldByName('status').AsString <> 'A' then
      raise Exception.Create
        ('Usuário bloqueado, favor entrar em contato com o administrador.');

    FUsuarioModel.id := SQLConsulta.FieldByName('id').AsString;
    FUsuarioModel.Nome := SQLConsulta.FieldByName('nome').AsString;
    FUsuarioModel.Login := SQLConsulta.FieldByName('login').AsString;
  finally
    SQLConsulta.Close;
    SQLConsulta.Free;
  end;
end;

function TdmUsuarios.GetUsuarioLogado: TUsuarioModel;
begin
  Result := FUsuarioModel;
end;

function TdmUsuarios.HashSenha(payload: String): String;
begin
  Result := TBcrypt.GenerateHash(payload);
end;

procedure TdmUsuarios.LimparSenha(IdUsuario: String);
var
  SQLQuery: TFDQuery;
  TempPassword: String;
begin
  SQLQuery := TFDQuery.Create(nil);
  TempPassword := HashSenha(random(100000).ToString);
  try
    SQLQuery.Connection := dmConexao.SQLConexao;
    SQLQuery.SQL.Clear;
    SQLQuery.SQL.Add
      ('update usuarios set senha_temporaria = :senhaTemporaria, senha = :senha where id = :idUsuario');
    SQLQuery.ParamByName('senhaTemporaria').AsString := 'S';
    SQLQuery.ParamByName('senha').AsString := TempPassword;
    SQLQuery.ParamByName('idUsuario').AsString := IdUsuario;
    SQLQuery.ExecSQL;
  finally
    SQLQuery.Close;
    SQLQuery.Free;
  end;
end;

procedure TdmUsuarios.RedefinirSenha(Usuario: TUsuarioModel);
var
  SQLQuery: TFDQuery;
begin
  SQLQuery := TFDQuery.Create(nil);
  try
    SQLQuery.Connection := dmConexao.SQLConexao;
    SQLQuery.SQL.Clear;
    SQLQuery.SQL.Add
      ('UPDATE USUARIOS SET SENHA_TEMPORARIA = :SENHA_TEMPORARIA, SENHA = :SENHA WHERE ID = :ID');
    SQLQuery.ParamByName('SENHA_TEMPORARIA').AsString := 'N';
    SQLQuery.ParamByName('SENHA').AsString := HashSenha(Usuario.Senha);
    SQLQuery.ParamByName('ID').AsString := Usuario.id;
    SQLQuery.ExecSQL;
  finally
    SQLQuery.Close;
    SQLQuery.Free;
  end;
end;

function TdmUsuarios.TemLoginCadastrado(Login, id: String): Boolean;
var
  SQLConsulta: TFDQuery;
begin
  Result := false;
  SQLConsulta := TFDQuery.Create(nil);
  try
    SQLConsulta.Connection := dmConexao.SQLConexao;
    SQLConsulta.SQL.Clear;
    SQLConsulta.SQL.Add('select id from usuarios where login = :login');
    SQLConsulta.ParamByName('login').AsString := Login;
    SQLConsulta.Open;

    if not SQLConsulta.IsEmpty then
      Result := SQLConsulta.FieldByName('id').AsString <> id;
  finally
    SQLConsulta.Close;
    SQLConsulta.Free;
  end;
end;

function TdmUsuarios.ValidaSenha(payload, hash: String): Boolean;
begin
  Result := TBcrypt.CompareHash(payload, hash);
end;

end.
