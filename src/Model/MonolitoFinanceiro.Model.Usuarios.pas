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
  MonolitoFinanceiro.Model.Conexao;

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
  private
    { Private declarations }
  public
    { Public declarations }
    function TemLoginCadastrado(Login, id: String): Boolean;
  end;

var
  dmUsuarios: TdmUsuarios;

implementation

{%CLASSGROUP 'Vcl.Controls.TControl'}
{$R *.dfm}
{ TdmUsuarios }

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
    SQLConsulta.free;
  end;
end;

end.
