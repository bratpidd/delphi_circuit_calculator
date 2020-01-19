object Form1: TForm1
  Left = 107
  Top = 285
  BorderStyle = bsSingle
  Caption = 'Dopolnitelnaya glava TOE'
  ClientHeight = 682
  ClientWidth = 931
  Color = clActiveBorder
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 13
  object Label3: TLabel
    Left = 8
    Top = 200
    Width = 236
    Height = 24
    Caption = 'Selected element properties'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -20
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    ParentFont = False
  end
  object Image1: TImage
    Left = 272
    Top = 5
    Width = 657
    Height = 292
    OnMouseDown = Image1MouseDown
    OnMouseMove = Image1MouseMove
    OnMouseUp = Image1MouseUp
  end
  object Label1: TLabel
    Left = 8
    Top = 456
    Width = 45
    Height = 20
    Caption = 'Table'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -16
    Font.Name = 'MS Sans Serif'
    Font.Style = [fsBold]
    ParentFont = False
  end
  object GroupBox3: TGroupBox
    Left = 8
    Top = 40
    Width = 121
    Height = 153
    Caption = 'Load graph'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -16
    Font.Name = 'MS Sans Serif'
    Font.Style = [fsBold]
    ParentFont = False
    TabOrder = 24
  end
  object GroupBox2: TGroupBox
    Left = 136
    Top = 40
    Width = 121
    Height = 153
    Caption = 'Solve method'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -16
    Font.Name = 'MS Sans Serif'
    Font.Style = [fsBold]
    ParentFont = False
    TabOrder = 23
  end
  object GroupBox1: TGroupBox
    Left = 272
    Top = 297
    Width = 489
    Height = 56
    Caption = 'Show Matrix'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -16
    Font.Name = 'MS Sans Serif'
    Font.Style = [fsBold]
    ParentFont = False
    TabOrder = 14
  end
  object ValueListEditor1: TValueListEditor
    Left = 8
    Top = 224
    Width = 249
    Height = 137
    Color = clWhite
    Font.Charset = RUSSIAN_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    Options = [goFixedVertLine, goFixedHorzLine, goVertLine, goHorzLine, goColSizing, goAlwaysShowEditor, goThumbTracking]
    ParentFont = False
    TabOrder = 0
    ColWidths = (
      109
      134)
  end
  object Button2: TButton
    Left = 24
    Top = 72
    Width = 89
    Height = 25
    Caption = 'From task'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -12
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    ParentFont = False
    TabOrder = 1
    OnClick = Button2Click
  end
  object Button4: TButton
    Left = 409
    Top = 319
    Width = 57
    Height = 25
    Caption = 'Loop'
    Enabled = False
    TabOrder = 2
    OnClick = Button4Click
  end
  object StringGrid1: TStringGrid
    Left = 8
    Top = 472
    Width = 913
    Height = 217
    ColCount = 13
    DefaultColWidth = 69
    DefaultRowHeight = 15
    RowCount = 13
    Font.Charset = RUSSIAN_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    ParentFont = False
    TabOrder = 3
    RowHeights = (
      15
      15
      15
      15
      15
      15
      15
      15
      15
      15
      15
      15
      15)
  end
  object Button5: TButton
    Left = 281
    Top = 319
    Width = 57
    Height = 25
    Caption = 'Incidence'
    Enabled = False
    TabOrder = 4
    OnClick = Button5Click
  end
  object Button6: TButton
    Left = 473
    Top = 319
    Width = 57
    Height = 25
    Caption = 'Cut'
    Enabled = False
    TabOrder = 5
    OnClick = Button6Click
  end
  object Button14: TButton
    Left = 592
    Top = 319
    Width = 49
    Height = 25
    Caption = 'Z'
    Enabled = False
    TabOrder = 6
    OnClick = Button14Click
  end
  object Button17: TButton
    Left = 648
    Top = 319
    Width = 49
    Height = 25
    Caption = 'J'
    Enabled = False
    TabOrder = 7
    OnClick = Button17Click
  end
  object Button18: TButton
    Left = 536
    Top = 319
    Width = 49
    Height = 25
    Caption = 'E'
    Enabled = False
    TabOrder = 8
    OnClick = Button18Click
  end
  object Button19: TButton
    Left = 24
    Top = 152
    Width = 89
    Height = 25
    Caption = 'Simple scheme'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -12
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    ParentFont = False
    TabOrder = 9
    OnClick = Button19Click
  end
  object Button21: TButton
    Left = 152
    Top = 96
    Width = 89
    Height = 25
    Caption = 'Nodal Voltage'
    Enabled = False
    TabOrder = 10
    OnClick = Button21Click
  end
  object Button22: TButton
    Left = 704
    Top = 319
    Width = 49
    Height = 25
    Caption = 'Y'
    Enabled = False
    TabOrder = 11
    OnClick = Button22Click
  end
  object Button23: TButton
    Left = 152
    Top = 64
    Width = 89
    Height = 25
    Caption = 'Loop'
    Enabled = False
    TabOrder = 12
    OnClick = Button23Click
  end
  object Button26: TButton
    Left = 24
    Top = 112
    Width = 89
    Height = 25
    Caption = 'From input.txt'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -12
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    ParentFont = False
    TabOrder = 13
    OnClick = Button26Click
  end
  object Button1: TButton
    Left = 152
    Top = 128
    Width = 89
    Height = 25
    Caption = 'Cutset'
    Enabled = False
    TabOrder = 15
    OnClick = Button1Click
  end
  object Button3: TButton
    Left = 320
    Top = 128
    Width = 33
    Height = 25
    Caption = 'Loop1'
    TabOrder = 16
    Visible = False
    OnClick = Button3Click
  end
  object Button7: TButton
    Left = 320
    Top = 160
    Width = 33
    Height = 25
    Caption = 'NV1'
    TabOrder = 17
    Visible = False
    OnClick = Button7Click
  end
  object Button8: TButton
    Left = 320
    Top = 192
    Width = 33
    Height = 25
    Caption = 'Cut1'
    TabOrder = 18
    Visible = False
    OnClick = Button8Click
  end
  object Button9: TButton
    Left = 8
    Top = 8
    Width = 89
    Height = 25
    Caption = 'About'
    TabOrder = 19
    OnClick = Button9Click
  end
  object Button10: TButton
    Left = 152
    Top = 160
    Width = 89
    Height = 25
    Caption = 'Mesh current'
    Enabled = False
    TabOrder = 20
    OnClick = Button10Click
  end
  object Button11: TButton
    Left = 320
    Top = 224
    Width = 33
    Height = 25
    Caption = 'MC1'
    TabOrder = 21
    Visible = False
    OnClick = Button11Click
  end
  object Button12: TButton
    Left = 345
    Top = 319
    Width = 57
    Height = 25
    Caption = 'Mesh'
    Enabled = False
    TabOrder = 22
    OnClick = Button12Click
  end
  object Button13: TButton
    Left = 232
    Top = 8
    Width = 25
    Height = 25
    Caption = 'RU'
    TabOrder = 25
    OnClick = Button13Click
  end
  object Button15: TButton
    Left = 112
    Top = 8
    Width = 89
    Height = 25
    Caption = 'View task'
    TabOrder = 26
    OnClick = Button15Click
  end
  object StringGrid2: TStringGrid
    Left = 8
    Top = 363
    Width = 913
    Height = 83
    ColCount = 13
    DefaultColWidth = 69
    DefaultRowHeight = 15
    Font.Charset = ANSI_CHARSET
    Font.Color = clBlack
    Font.Height = -9
    Font.Name = 'Small Fonts'
    Font.Style = []
    ParentFont = False
    TabOrder = 27
  end
  object Button16: TButton
    Left = 800
    Top = 320
    Width = 89
    Height = 25
    Caption = 'Vector Diagram'
    TabOrder = 28
    OnClick = Button16Click
  end
end
