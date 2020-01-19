object Form4: TForm4
  Left = 315
  Top = 82
  BorderStyle = bsDialog
  Caption = 'Vector Diagram'
  ClientHeight = 564
  ClientWidth = 1116
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  Position = poDefault
  OnCreate = FormCreate
  OnMouseWheel = FormMouseWheel
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object Image1: TImage
    Left = 0
    Top = 0
    Width = 921
    Height = 465
    OnMouseDown = Image1MouseDown
    OnMouseMove = Image1MouseMove
    OnMouseUp = Image1MouseUp
  end
  object Label1: TLabel
    Left = 32
    Top = 472
    Width = 67
    Height = 13
    Caption = 'Diagram scale'
  end
  object Label2: TLabel
    Left = 8
    Top = 512
    Width = 12
    Height = 13
    Caption = '10'
  end
  object Label3: TLabel
    Left = 216
    Top = 512
    Width = 24
    Height = 13
    Caption = '1000'
  end
  object Label7: TLabel
    Left = 8
    Top = 544
    Width = 32
    Height = 13
    Caption = 'Label7'
  end
  object Label5: TLabel
    Left = 451
    Top = 486
    Width = 39
    Height = 13
    Caption = 'Edge N:'
  end
  object Label6: TLabel
    Left = 824
    Top = 504
    Width = 32
    Height = 13
    Caption = 'Label6'
  end
  object Label8: TLabel
    Left = 824
    Top = 520
    Width = 32
    Height = 13
    Caption = 'Label8'
  end
  object Label4: TLabel
    Left = 928
    Top = 472
    Width = 81
    Height = 13
    Caption = 'Current values, A'
  end
  object Label9: TLabel
    Left = 1024
    Top = 472
    Width = 83
    Height = 13
    Caption = 'Voltage values, V'
  end
  object Image2: TImage
    Left = 816
    Top = 416
    Width = 105
    Height = 49
  end
  object TrackBar1: TTrackBar
    Left = 24
    Top = 488
    Width = 193
    Height = 45
    Max = 1000
    Min = 10
    Frequency = 50
    Position = 100
    TabOrder = 1
    OnChange = TrackBar1Change
  end
  object Edit1: TEdit
    Left = 104
    Top = 520
    Width = 41
    Height = 21
    TabOrder = 2
    Text = '100'
    OnChange = Edit1Change
    OnKeyPress = Edit1KeyPress
  end
  object Button1: TButton
    Left = 248
    Top = 472
    Width = 75
    Height = 25
    Caption = 'CENTER'
    TabOrder = 0
    OnClick = Button1Click
  end
  object Edit3: TEdit
    Left = 496
    Top = 480
    Width = 41
    Height = 33
    Color = clMoneyGreen
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -20
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    ParentFont = False
    TabOrder = 3
    Text = '0'
    OnChange = Edit3Change
    OnKeyPress = Edit3KeyPress
  end
  object UpDown2: TUpDown
    Left = 537
    Top = 480
    Width = 40
    Height = 33
    Associate = Edit3
    TabOrder = 4
  end
  object ListBox1: TListBox
    Left = 920
    Top = 0
    Width = 97
    Height = 465
    ItemHeight = 13
    TabOrder = 5
  end
  object ListBox2: TListBox
    Left = 1019
    Top = 0
    Width = 97
    Height = 465
    ItemHeight = 13
    TabOrder = 6
  end
end
