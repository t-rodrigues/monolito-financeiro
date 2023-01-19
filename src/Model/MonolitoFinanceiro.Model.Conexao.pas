unit MonolitoFinanceiro.Model.Conexao;

interface

uses
  System.SysUtils,
  System.Classes,
  FireDAC.Stan.Intf,
  FireDAC.Stan.Option,
  FireDAC.Stan.Error,
  FireDAC.UI.Intf,
  FireDAC.Phys.Intf,
  FireDAC.Stan.Def,
  FireDAC.Stan.Pool,
  FireDAC.Stan.Async,
  FireDAC.Phys,
  FireDAC.Phys.SQLite,
  FireDAC.Phys.SQLiteDef,
  FireDAC.Stan.ExprFuncs,
  FireDAC.Phys.SQLiteWrapper.Stat,
  FireDAC.VCLUI.Wait,
  Data.DB,
  FireDAC.Comp.Client,
  FireDAC.Stan.Param,
  FireDAC.DatS,
  FireDAC.DApt.Intf,
  FireDAC.DApt,
  FireDAC.Comp.DataSet;

type
  TdmConexao = class(TDataModule)
    SQLConexao: TFDConnection;
    procedure DataModuleCreate(Sender: TObject);
  private
  { Private declarations }
    const
    CONFIG_FILE = 'MonolitoFinanceiro.cfg';
  public
    { Public declarations }
    procedure CarregarConfiguracoes;
    procedure Conectar;
    procedure Desconectar;
  end;

var
  dmConexao: TdmConexao;

implementation

{%CLASSGROUP 'Vcl.Controls.TControl'}
{$R *.dfm}
{ TDataModule1 }

procedure TdmConexao.CarregarConfiguracoes;
var
  ParametroNome: String;
  ParametroValor: String;
  Item: String;
  ListaParametros: TStringList;
begin
  SQLConexao.Params.Clear;

  if not FileExists('MonolitoFinanceiro.cfg') then
    raise Exception.Create('Arquivo de configuração não encontrado!');

  ListaParametros := TStringList.Create;
  try
    ListaParametros.LoadFromFile(CONFIG_FILE);

    for Item in ListaParametros do
    begin
      if Item.IndexOf('=') > 0 then
      begin
        ParametroNome := Item.Split(['='])[0].Trim;
        ParametroValor := Item.Split(['='])[1].Trim;
        SQLConexao.Params.Add(ParametroNome + '=' + ParametroValor);
      end;
    end;
  finally
    ListaParametros.Free;
  end;
end;

procedure TdmConexao.Conectar;
begin
  SQLConexao.Connected;
end;

procedure TdmConexao.DataModuleCreate(Sender: TObject);
begin
  CarregarConfiguracoes;
  Conectar;
end;

procedure TdmConexao.Desconectar;
begin
  SQLConexao.Connected := false;
end;

end.
