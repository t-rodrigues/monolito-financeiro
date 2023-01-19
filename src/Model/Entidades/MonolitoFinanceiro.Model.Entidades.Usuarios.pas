unit MonolitoFinanceiro.Model.Entidades.Usuarios;

interface

type
  TUsuarioModel = class
  private
    FId: String;
    FLogin: String;
    FNome: String;
    procedure SetId(const Value: String);
    procedure SetLogin(const Value: String);
    procedure SetNome(const Value: String);
  public
    property Id: String read FId write SetId;
    property Nome: String read FNome write SetNome;
    property Login: String read FLogin write SetLogin;
  end;

implementation

{ TUsuarioModel }

procedure TUsuarioModel.SetId(const Value: String);
begin
  FId := Value;
end;

procedure TUsuarioModel.SetLogin(const Value: String);
begin
  FLogin := Value;
end;

procedure TUsuarioModel.SetNome(const Value: String);
begin
  FNome := Value;
end;

end.
