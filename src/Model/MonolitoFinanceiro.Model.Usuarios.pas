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
    procedure DataModuleCreate(Sender: TObject);
    procedure DataModuleDestroy(Sender: TObject);
  private
    FUsuarioModel: TUsuarioModel;
    { Private declarations }
  public
    { Public declarations }
    function TemLoginCadastrado(Login, id: String): Boolean;
    procedure EfetuarLogin(Login: String; Senha: String);
    function GetUsuarioLogado: TUsuarioModel;
  end;

var
  dmUsuarios: TdmUsuarios;

implementation

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
    SQLConsulta.SQL.Add
      ('select * from usuarios where login = :login and senha = :senha');
    SQLConsulta.ParamByName('login').AsString := Login;
    SQLConsulta.ParamByName('senha').AsString := Senha;
    SQLConsulta.Open;

    if SQLConsulta.IsEmpty then
      raise Exception.Create('Usuário e/ou senha inválidos.');

    if SQLConsulta.FieldByName('status').AsString <> 'A' then
      raise Exception.Create
        ('Usuário bloqueado, favor entrar em contato com o administrador.');

    FUsuarioModel.Id := SQLConsulta.FieldByName('id').AsString;
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

end.
