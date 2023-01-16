unit MonolitoFinanceiro.View.Usuarios;

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
  MonolitoFinanceiro.View.CadastroPadrao,
  Data.DB,
  System.ImageList,
  Vcl.ImgList,
  Vcl.Grids,
  Vcl.DBGrids,
  Vcl.StdCtrls,
  Vcl.ExtCtrls,
  Vcl.WinXPanels,
  MonolitoFinanceiro.Model.Conexao;

type
  TfrmUsuarios = class(TfrmCadastroPadrao)
    procedure btnPesquisarClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmUsuarios: TfrmUsuarios;

implementation

{$R *.dfm}

procedure TfrmUsuarios.btnPesquisarClick(Sender: TObject);
begin
  inherited;
  dmConexao.FDQuery1.Close;
  dmConexao.FDQuery1.SQL.Clear;
  dmConexao.FDQuery1.SQL.Add('Select * from usuarios order by nome');
  dmConexao.FDQuery1.Open;
end;

end.
