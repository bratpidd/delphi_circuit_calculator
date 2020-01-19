unit Unit4;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, Unit1, ExtCtrls, ComplexAlg, MatrixAlg, StdCtrls, ComCtrls, Math;

type
  TTrackBar = class(ComCtrls.TTrackBar)
  protected
    function DoMouseWheel(Shift: TShiftState; WheelDelta: Integer; MousePos: TPoint): Boolean; override;
  end;

  TForm4 = class(TForm)
    Image1: TImage;
    TrackBar1: TTrackBar;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    Edit1: TEdit;
    Label7: TLabel;
    Button1: TButton;
    procedure FormShow(Sender: TObject);
    procedure DrawDiag;
    procedure DrawGrid (scale: integer);
    procedure TrackBar1Change(Sender: TObject);
    procedure Edit1Change(Sender: TObject);
    procedure Edit1KeyPress(Sender: TObject; var Key: Char);
    procedure Edit2KeyPress(Sender: TObject; var Key: Char);
    procedure FormCreate(Sender: TObject);
    procedure Image1MouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure Image1MouseUp(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure Image1MouseMove(Sender: TObject; Shift: TShiftState; X,
      Y: Integer);
    procedure Button1Click(Sender: TObject);
    procedure FormMouseWheel(Sender: TObject; Shift: TShiftState;
      WheelDelta: Integer; MousePos: TPoint; var Handled: Boolean);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form4: TForm4;
  GridScale: integer;
  MouseState: integer;
  CanvasX, CanvasY: integer;
  DownX, DownY: integer;

implementation


{$R *.dfm}

procedure TForm4.FormShow(Sender: TObject);
begin
  DrawDiag;
end;

procedure TForm4.DrawGrid(scale: integer);
var a,b,x,y,size: integer;
price, pr2: real;
textX, textY: integer;
dx,dy: integer;
succ: boolean;
begin
  size:=30;
  price:= size/scale; //tcena deleniya    0.02 .. 2
  succ:=false;
  a:=-3;
  while not succ do begin    //min for price is 20/1000 = 0.02; max is 20/10 = 2
    if price < 5*IntPower(10,a) then begin    //so a goes approx from 0.02 to 2
      pr2 := 5*IntPower(10,a);
      succ:=true;
    end;
    if price < 2*IntPower(10,a) then begin
      pr2 := 2*IntPower(10,a);
      succ:=true;
    end;
    if price < 1*IntPower(10,a) then begin
      pr2 := 1*IntPower(10,a);
      succ:=true;
    end;
    inc(a);
  end;
  price:=pr2;
  size:=round(price*scale);    //size is grid cell's width/height
  x:=CanvasX;
  y:=CanvasY;
  image1.Canvas.Pen.Color:=clblue;
  image1.Canvas.Font.Color := clblue;

  for a:=0 to round(max(image1.Width, image1.Height)/size) do begin
    dx:=a - x div size;
    if dx=0 then image1.Canvas.Pen.Width:=2
      else image1.Canvas.Pen.Width:=1;
    Image1.Canvas.MoveTo(x+dx*size, 0);
    Image1.Canvas.LineTo(x+dx*size, image1.Height);

    dy:=a - y div size;
    if dy=0 then image1.Canvas.Pen.Width:=2
      else image1.Canvas.Pen.Width:=1;
    Image1.Canvas.MoveTo(0, y+dy*size);
    Image1.Canvas.LineTo(image1.Width, y+dy*size);

    textX:=CanvasX+1;
    textY:=CanvasY+1;
    if CanvasX<0 then textX:=2;
    if CanvasX>image1.Width then TextX:=image1.Width-20;
    if CanvasY<0 then textY:=2;
    if CanvasY>image1.Height then TextY:=image1.Height-12;
    Image1.Canvas.TextOut(x+dx*size+2, textY, inttostr (dx));
    Image1.Canvas.TextOut(textX, y+dy*size+2, inttostr (-dy));
    Image1.Canvas.TextOut(x-dx*size+2, textY, inttostr (-dx));
    Image1.Canvas.TextOut(textX, y-dy*size+2, inttostr (dy));
  end;
  label7.Caption:='price deleniya: '+floattostr(price)+ ' A/V per deleniye';
end;

procedure TForm4.DrawDiag;
var a,b,x,y: integer;
xI, xU, yI, yU: integer;
begin
  Image1.Canvas.Brush.Color:=clwhite;
  Image1.Canvas.FillRect(Image1.Canvas.cliprect);
  GridScale:=TrackBar1.Position;
  DrawGrid(GridScale);
  x:=CanvasX;
  y:=CanvasY;
  xI:=x; xU:=x; yI:=y; yU:=y;
  image1.Canvas.Pen.Width:=2;
  for a:=1 to Graph.EdgeCount do begin
    image1.Canvas.Pen.Color:=clblack;
    Image1.Canvas.Font.Color:=clblack;
    Image1.Canvas.MoveTo(xI,yI);
    Image1.Canvas.LineTo(xI+round(GridScale*Graph.MSolve.Comp[a,1].Re),yI-round(GridScale*Graph.MSolve.Comp[a,1].Im));
    Image1.Canvas.TextOut(xI+round(GridScale*Graph.MSolve.Comp[a,1].Re),yI-round(GridScale*Graph.MSolve.Comp[a,1].Im),inttostr(a));
    xI:=xI+round(GridScale*Graph.MSolve.Comp[a,1].Re);
    yI:=yI-round(GridScale*Graph.MSolve.Comp[a,1].Im);


    image1.Canvas.Pen.Color:=clred;
    image1.Canvas.Font.Color:=clred;
    Image1.Canvas.MoveTo(xU,yU);
    Image1.Canvas.LineTo(xU+round(GridScale*Graph.MSolve.Comp[a,2].Re),yU-round(GridScale*Graph.MSolve.Comp[a,2].Im));
    Image1.Canvas.TextOut(xU+round(GridScale*Graph.MSolve.Comp[a,2].Re),yU-round(GridScale*Graph.MSolve.Comp[a,2].Im),inttostr(a));
    xU:=xU+round(GridScale*Graph.MSolve.Comp[a,2].Re);
    yU:=yU-round(GridScale*Graph.MSolve.Comp[a,2].Im);
  end;
end;

procedure TForm4.TrackBar1Change(Sender: TObject);
begin
  GridScale:=TrackBar1.Position;
  Edit1.Text:=inttostr(GridScale);
  DrawDiag;
end;

procedure TForm4.Edit1Change(Sender: TObject);
var val: integer;
begin
  val:=strtoint(Edit1.Text);
  if val < 10 then val := 10;
  if val > 1000 then val:=1000;
  GridScale := val;
  Edit1.Text:=inttostr(val);
  Trackbar1.Position:=val;
  DrawDiag;
end;

procedure TForm4.Edit1KeyPress(Sender: TObject; var Key: Char);
begin
  if not (Key in [#8, '0'..'9']) then
    Key := #0;
end;

procedure TForm4.Edit2KeyPress(Sender: TObject; var Key: Char);
begin
  if not (Key in [#8, '0'..'9']) then
    Key := #0;
end;

procedure TForm4.FormCreate(Sender: TObject);
begin
  CanvasX:=Image1.Width div 2;
  CanvasY:=Image1.Height div 2;
  GridScale:=100;
  MouseState:=0;
end;

procedure TForm4.Image1MouseDown(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
begin
  MouseState:=1;
  DownX:=X;
  DownY:=Y;
end;

procedure TForm4.Image1MouseUp(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
begin
  MouseState:=2;
end;

procedure TForm4.Image1MouseMove(Sender: TObject; Shift: TShiftState; X,
  Y: Integer);
begin
  form4.SelectFirst;
  if MouseState=1 then begin
    CanvasX:=CanvasX+X-DownX;
    CanvasY:=CanvasY+Y-DownY;
    DrawDiag;
    DownX:=X;
    DownY:=Y;
  end;
end;

function TTrackBar.DoMouseWheel(Shift: TShiftState; WheelDelta: Integer; MousePos: TPoint): Boolean;
begin
  //Position := Position + WheelDelta div 10;
  Result := True;
end;

procedure TForm4.Button1Click(Sender: TObject);
begin
  CanvasX:=Image1.Width div 2;
  CanvasY:=Image1.Height div 2;
  DrawDiag;
end;

procedure TForm4.FormMouseWheel(Sender: TObject; Shift: TShiftState;
  WheelDelta: Integer; MousePos: TPoint; var Handled: Boolean);
begin
  TrackBar1.Position := TrackBar1.Position + WheelDelta div 10;
end;

end.
