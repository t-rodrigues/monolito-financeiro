object frmPrincipal: TfrmPrincipal
  Left = 0
  Top = 0
  Caption = 'Monolito Financeiro'
  ClientHeight = 411
  ClientWidth = 852
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -16
  Font.Name = 'Tahoma'
  Font.Style = []
  Menu = MainMenu1
  OldCreateOrder = False
  Position = poScreenCenter
  WindowState = wsMaximized
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 19
  object StatusBar1: TStatusBar
    Left = 0
    Top = 384
    Width = 852
    Height = 27
    Panels = <
      item
        Width = 150
      end
      item
        Width = 300
      end>
  end
  object MainMenu1: TMainMenu
    Left = 40
    Top = 240
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
  object Timer1: TTimer
    OnTimer = Timer1Timer
    Left = 40
    Top = 304
  end
end
