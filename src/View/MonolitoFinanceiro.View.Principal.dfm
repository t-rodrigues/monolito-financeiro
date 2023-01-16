object frmPrincipal: TfrmPrincipal
  Left = 0
  Top = 0
  Caption = 'Monolito Financeiro'
  ClientHeight = 411
  ClientWidth = 852
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  Menu = MainMenu1
  OldCreateOrder = False
  Position = poScreenCenter
  WindowState = wsMaximized
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 13
  object MainMenu1: TMainMenu
    Left = 56
    Top = 40
    object menuCadastros: TMenuItem
      Caption = 'Cadastros'
      object menuCadastroUsuarios: TMenuItem
        Caption = 'Usu'#225'rios'
        OnClick = menuCadastroUsuariosClick
      end
    end
    object menuRelatorios: TMenuItem
      Caption = 'Relat'#243'rios'
    end
    object menuAjuda: TMenuItem
      Caption = 'Ajuda'
    end
  end
end
