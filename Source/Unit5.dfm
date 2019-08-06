object Form5: TForm5
  Left = 0
  Top = 0
  BorderStyle = bsSingle
  Caption = 'Form5'
  ClientHeight = 181
  ClientWidth = 167
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  Position = poDesktopCenter
  OnClose = FormClose
  PixelsPerInch = 96
  TextHeight = 13
  object Label1: TLabel
    Left = 24
    Top = 8
    Width = 39
    Height = 13
    Caption = 'Lozinka:'
  end
  object Edit1: TEdit
    Left = 24
    Top = 27
    Width = 121
    Height = 21
    PasswordChar = '*'
    TabOrder = 0
  end
  object Button1: TButton
    Left = 24
    Top = 54
    Width = 121
    Height = 25
    Caption = 'Omoguci Admina'
    TabOrder = 1
    OnClick = Button1Click
  end
  object CheckBox1: TCheckBox
    Left = 8
    Top = 156
    Width = 137
    Height = 17
    Caption = 'Rucno editovanje baze'
    TabOrder = 2
    Visible = False
    OnClick = CheckBox1Click
  end
  object Button2: TButton
    Left = 8
    Top = 120
    Width = 151
    Height = 30
    Caption = 'Obrisi istoriju izvestaja'
    TabOrder = 3
    Visible = False
    OnClick = Button2Click
  end
end
