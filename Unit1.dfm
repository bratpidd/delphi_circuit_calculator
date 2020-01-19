object Form1: TForm1
  Left = 597
  Top = 337
  BorderStyle = bsSingle
  Caption = 'Perehodnie processy 3000'
  ClientHeight = 596
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
    Top = 232
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
    Width = 649
    Height = 388
    OnMouseDown = Image1MouseDown
    OnMouseMove = Image1MouseMove
    OnMouseUp = Image1MouseUp
  end
  object Label1: TLabel
    Left = 8
    Top = 416
    Width = 27
    Height = 20
    Caption = 't=0'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -16
    Font.Name = 'MS Sans Serif'
    Font.Style = [fsBold]
    ParentFont = False
  end
  object Label2: TLabel
    Left = 8
    Top = 512
    Width = 61
    Height = 20
    Caption = 't=0.02s'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -16
    Font.Name = 'MS Sans Serif'
    Font.Style = [fsBold]
    ParentFont = False
  end
  object GroupBox3: TGroupBox
    Left = 384
    Top = 64
    Width = 121
    Height = 153
    Caption = 'Load graph'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -16
    Font.Name = 'MS Sans Serif'
    Font.Style = [fsBold]
    ParentFont = False
    TabOrder = 23
    Visible = False
  end
  object GroupBox2: TGroupBox
    Left = 512
    Top = 64
    Width = 121
    Height = 153
    Caption = 'Solve method'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -16
    Font.Name = 'MS Sans Serif'
    Font.Style = [fsBold]
    ParentFont = False
    TabOrder = 22
    Visible = False
  end
  object GroupBox1: TGroupBox
    Left = 296
    Top = 233
    Width = 489
    Height = 56
    Caption = 'Show Matrix'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -16
    Font.Name = 'MS Sans Serif'
    Font.Style = [fsBold]
    ParentFont = False
    TabOrder = 13
    Visible = False
  end
  object ValueListEditor1: TValueListEditor
    Left = 8
    Top = 256
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
    Left = 88
    Top = 88
    Width = 89
    Height = 41
    Caption = 'Load scheme'
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
    Left = 433
    Top = 255
    Width = 57
    Height = 25
    Caption = 'Loop'
    Enabled = False
    TabOrder = 2
    Visible = False
    OnClick = Button4Click
  end
  object Button5: TButton
    Left = 305
    Top = 255
    Width = 57
    Height = 25
    Caption = 'Incidence'
    Enabled = False
    TabOrder = 3
    Visible = False
    OnClick = Button5Click
  end
  object Button6: TButton
    Left = 497
    Top = 255
    Width = 57
    Height = 25
    Caption = 'Cut'
    Enabled = False
    TabOrder = 4
    Visible = False
    OnClick = Button6Click
  end
  object Button14: TButton
    Left = 672
    Top = 255
    Width = 49
    Height = 25
    Caption = 'Z'
    Enabled = False
    TabOrder = 5
    Visible = False
    OnClick = Button14Click
  end
  object Button17: TButton
    Left = 616
    Top = 255
    Width = 49
    Height = 25
    Caption = 'J'
    Enabled = False
    TabOrder = 6
    Visible = False
    OnClick = Button17Click
  end
  object Button18: TButton
    Left = 560
    Top = 255
    Width = 49
    Height = 25
    Caption = 'E'
    Enabled = False
    TabOrder = 7
    Visible = False
    OnClick = Button18Click
  end
  object Button19: TButton
    Left = 400
    Top = 176
    Width = 89
    Height = 25
    Caption = 'Simple scheme'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -12
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    ParentFont = False
    TabOrder = 8
    Visible = False
    OnClick = Button19Click
  end
  object Button21: TButton
    Left = 528
    Top = 120
    Width = 89
    Height = 25
    Caption = 'Nodal Voltage'
    Enabled = False
    TabOrder = 9
    Visible = False
    OnClick = Button21Click
  end
  object Button22: TButton
    Left = 728
    Top = 255
    Width = 49
    Height = 25
    Caption = 'Y'
    Enabled = False
    TabOrder = 10
    Visible = False
    OnClick = Button22Click
  end
  object Button23: TButton
    Left = 528
    Top = 88
    Width = 89
    Height = 25
    Caption = 'Loop'
    Enabled = False
    TabOrder = 11
    Visible = False
    OnClick = Button23Click
  end
  object Button26: TButton
    Left = 400
    Top = 136
    Width = 89
    Height = 25
    Caption = 'From input.txt'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -12
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    ParentFont = False
    TabOrder = 12
    Visible = False
    OnClick = Button26Click
  end
  object Button1: TButton
    Left = 528
    Top = 152
    Width = 89
    Height = 25
    Caption = 'Cutset'
    Enabled = False
    TabOrder = 14
    Visible = False
    OnClick = Button1Click
  end
  object Button3: TButton
    Left = 888
    Top = 5
    Width = 33
    Height = 25
    Caption = 'Loop1'
    TabOrder = 15
    Visible = False
    OnClick = Button3Click
  end
  object Button7: TButton
    Left = 888
    Top = 37
    Width = 33
    Height = 25
    Caption = 'NV1'
    TabOrder = 16
    Visible = False
    OnClick = Button7Click
  end
  object Button8: TButton
    Left = 888
    Top = 69
    Width = 33
    Height = 25
    Caption = 'Cut1'
    TabOrder = 17
    Visible = False
    OnClick = Button8Click
  end
  object Button9: TButton
    Left = 24
    Top = 8
    Width = 89
    Height = 25
    Caption = 'About'
    TabOrder = 18
    OnClick = Button9Click
  end
  object Button10: TButton
    Left = 528
    Top = 184
    Width = 89
    Height = 25
    Caption = 'Mesh current'
    Enabled = False
    TabOrder = 19
    Visible = False
    OnClick = Button10Click
  end
  object Button11: TButton
    Left = 888
    Top = 101
    Width = 33
    Height = 25
    Caption = 'MC1'
    TabOrder = 20
    Visible = False
    OnClick = Button11Click
  end
  object Button12: TButton
    Left = 369
    Top = 255
    Width = 57
    Height = 25
    Caption = 'Mesh'
    Enabled = False
    TabOrder = 21
    Visible = False
    OnClick = Button12Click
  end
  object Button13: TButton
    Left = 544
    Top = 24
    Width = 25
    Height = 25
    Caption = 'RU'
    Enabled = False
    TabOrder = 24
    Visible = False
    OnClick = Button13Click
  end
  object Button15: TButton
    Left = 160
    Top = 8
    Width = 89
    Height = 25
    Caption = 'View task'
    TabOrder = 25
    OnClick = Button15Click
  end
  object StringGrid2: TStringGrid
    Left = 16
    Top = 539
    Width = 913
    Height = 52
    ColCount = 13
    DefaultColWidth = 69
    DefaultRowHeight = 15
    RowCount = 3
    Font.Charset = ANSI_CHARSET
    Font.Color = clBlack
    Font.Height = -9
    Font.Name = 'Small Fonts'
    Font.Style = []
    ParentFont = False
    TabOrder = 26
  end
  object Button16: TButton
    Left = 136
    Top = 144
    Width = 74
    Height = 25
    Caption = 'Graphic'
    Enabled = False
    TabOrder = 27
    OnClick = Button16Click
  end
  object Button20: TButton
    Left = 48
    Top = 144
    Width = 75
    Height = 25
    Caption = 'Calculate'
    Enabled = False
    TabOrder = 28
    OnClick = Button20Click
  end
  object StringGrid1: TStringGrid
    Left = 16
    Top = 443
    Width = 913
    Height = 52
    ColCount = 13
    DefaultColWidth = 69
    DefaultRowHeight = 15
    RowCount = 3
    Font.Charset = ANSI_CHARSET
    Font.Color = clBlack
    Font.Height = -9
    Font.Name = 'Small Fonts'
    Font.Style = []
    ParentFont = False
    TabOrder = 29
  end
end
