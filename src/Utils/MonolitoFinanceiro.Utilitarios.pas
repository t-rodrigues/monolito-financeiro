unit MonolitoFinanceiro.Utilitarios;

interface

uses
  System.SysUtils;

type
  TUtilitario = class
    class function GetId: String;
  end;

implementation

{ TUtilitario }

class function TUtilitario.GetId: String;
begin
  Result := TGUid.NewGuid.ToString;
  Result := StringReplace(Result, '{', '', [rfReplaceAll]);
  Result := StringReplace(Result, '}', '', [rfReplaceAll]);
end;

end.
