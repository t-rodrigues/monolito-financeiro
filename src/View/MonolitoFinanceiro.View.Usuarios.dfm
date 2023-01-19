inherited frmUsuarios: TfrmUsuarios
  Caption = 'Cadastro de Usu'#225'rios'
  PixelsPerInch = 96
  TextHeight = 19
  inherited pnlPrincipal: TCardPanel
    inherited cardPesquisa: TCard
      TabOrder = 0
      inherited pnlPesquisa: TPanel
        inherited btnPesquisar: TButton
          OnClick = btnPesquisarClick
        end
      end
      inherited pnlPesquisaBotoes: TPanel
        inherited btnExcluir: TButton
          OnClick = btnExcluirClick
        end
      end
      inherited pnlGrid: TPanel
        inherited DBGrid1: TDBGrid
          DataSource = DataSource1
          PopupMenu = PopupMenu1
          Columns = <
            item
              Expanded = False
              FieldName = 'id'
              Width = 101
              Visible = True
            end
            item
              Expanded = False
              FieldName = 'nome'
              Width = 256
              Visible = True
            end
            item
              Expanded = False
              FieldName = 'login'
              Width = 143
              Visible = True
            end
            item
              Expanded = False
              FieldName = 'status'
              Width = 151
              Visible = True
            end>
        end
      end
    end
    inherited cardCadastro: TCard
      TabOrder = 1
      object Label2: TLabel [0]
        Left = 39
        Top = 39
        Width = 48
        Height = 19
        Caption = 'Nome:'
      end
      object Label3: TLabel [1]
        Left = 42
        Top = 72
        Width = 45
        Height = 19
        Caption = 'Login:'
      end
      object Label5: TLabel [2]
        Left = 38
        Top = 106
        Width = 49
        Height = 19
        Caption = 'Status:'
      end
      inherited pnlCadastroBotoes: TPanel
        inherited btnSalvar: TButton
          OnClick = btnSalvarClick
        end
      end
      object edtNome: TEdit
        Left = 93
        Top = 36
        Width = 360
        Height = 27
        TabOrder = 1
      end
      object edtLogin: TEdit
        Left = 93
        Top = 69
        Width = 360
        Height = 27
        TabOrder = 2
      end
      object ToggleSwitch1: TToggleSwitch
        Left = 93
        Top = 104
        Width = 130
        Height = 21
        StateCaptions.CaptionOn = 'Ativo'
        StateCaptions.CaptionOff = 'Bloqueado'
        TabOrder = 3
      end
    end
  end
  inherited ImageList1: TImageList
    Left = 617
    Top = 316
  end
  inherited DataSource1: TDataSource
    DataSet = dmUsuarios.cdsUsuarios
    Left = 617
    Top = 370
  end
  object PopupMenu1: TPopupMenu
    Left = 617
    Top = 258
    object menuLimparSenha: TMenuItem
      Caption = 'Limpar senha'
      OnClick = menuLimparSenhaClick
    end
  end
end
