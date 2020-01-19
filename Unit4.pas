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
    Edit3: TEdit;
    UpDown2: TUpDown;
    Label5: TLabel;
    Label6: TLabel;
    Label8: TLabel;
    ListBox1: TListBox;
    ListBox2: TListBox;
    Label4: TLabel;
    Label9: TLabel;
    Image2: TImage;
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
    procedure Edit3Change(Sender: TObject);
    procedure Edit3KeyPress(Sender: TObject; var Key: Char);
    procedure Button2Click(Sender: TObject);
    procedure RadioButton1Click(Sender: TObject);
    procedure RadioButton2Click(Sender: TObject);
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
  DiagVertice, DiagCounter: byte;

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
  image1.Canvas.Pen.Color:=RGB(210,210,255);
  image1.Canvas.Font.Color := RGB(110,110,255);

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
    if CanvasX>image1.Width then TextX:=image1.Width-30;
    if CanvasY<0 then textY:=2;
    if CanvasY>image1.Height then TextY:=image1.Height-12;
    Image1.Canvas.TextOut(x+dx*size+2, textY, floattostrf (dx*price, ffgeneral, 5,5));
    Image1.Canvas.TextOut(textX, y+dy*size+2, floattostrf (-dy*price, ffgeneral, 5,5));
    Image1.Canvas.TextOut(x-dx*size+2, textY, floattostrf (-dx*price, ffgeneral, 5,5));
    Image1.Canvas.TextOut(textX, y-dy*size+2, floattostrf (dy*price, ffgeneral, 5,5));
  end;
  label7.Caption:='price deleniya: '+floattostr(price)+ ' A/V per deleniye';
end;

procedure TForm4.DrawDiag;
var a,b,x,y,x2,y2: integer;
pArrow,lArrow,rArrow, fArrow: TPoint;    //points for arrow
xI, xU, yI, yU: integer;
lnID, sign: integer;
qlength, sinf, cosf:real;
dx,dy: integer;
deltaY: real;
begin
  {Image1.Canvas.Brush.Color:=clwhite;
  Image1.Canvas.FillRect(Image1.Canvas.cliprect);
  GridScale:=TrackBar1.Position;
  DrawGrid(GridScale);
  x:=CanvasX;
  y:=CanvasY;
  xI:=x; xU:=x; yI:=y; yU:=y;
  image1.Canvas.Pen.Width:=2;

  image1.Canvas.Pen.Color:=clblack;
  Image1.Canvas.Font.Color:=clblack;
  for a:=1 to Graph.Vertices[DiagVertice].Degree do begin
    lnID:=Graph.Vertices[DiagVertice].LineID[a];
    if (Graph.Edges[lnID].side1<DiagVertice) or (Graph.Edges[lnID].side2<DiagVertice) then
      sign:=-1 else sign:=1;

    if sign=1 then begin
      x2:=xI+round(sign*GridScale*Graph.MSolve.Comp[lnID,1].Re);
      y2:=yI-round(sign*GridScale*Graph.MSolve.Comp[lnID,1].Im);
    end else begin
      x2:=xI;
      y2:=yI;
      xI:=xI+round(sign*GridScale*Graph.MSolve.Comp[lnID,1].Re);
      yI:=yI-round(sign*GridScale*Graph.MSolve.Comp[lnID,1].Im);
    end;
    qlength:=round(sqrt((xI-x2)*(xI-x2)+(yI-y2)*(yI-y2)));   //allowed length for drawing
    dx:=x2-xI;
    dy:=y2-yI;
    if qlength=0 then qlength:=1; //preventing div by zero
    sinf:=dx/qlength;
    cosf:=dy/qlength;

    Image1.Canvas.MoveTo(xI,yI);
    Image1.Canvas.LineTo(x2,y2);
    if sign=1 then begin
      fArrow.x:=x2; fArrow.y:=y2;
    end else begin
      fArrow.x:=xI; fArrow.y:=yI;
    end;

    pArrow.X:=round(fArrow.x-sign*sinf*15);
    pArrow.Y:=round(fArrow.y-sign*cosf*15);

    lArrow.X:=round(pArrow.X-cosf*5);
    lArrow.Y:=round(pArrow.Y+sinf*5);
    rArrow.X:=round(pArrow.X+cosf*5);
    rArrow.Y:=round(pArrow.Y-sinf*5);
    Image1.Canvas.Polyline([rArrow,fArrow, lArrow, rArrow]);
    Image1.Canvas.TextOut(fArrow.X, fArrow.Y, inttostr(lnID));

    xI:=fArrow.X;
    yI:=fArrow.Y;
  end;

  image1.Canvas.Pen.Color:=clred;
  image1.Canvas.Font.Color:=clred;
  for a:=1 to Graph.EdgeCount do begin
    sign:=round(Graph.MCyc.Comp[a,DiagCounter].Re);
    if sign<>0 then begin
      Image1.Canvas.TextOut(xU+sign*round(GridScale*Graph.MSolve.Comp[a,2].Re),
                            yU-sign*round(GridScale*Graph.MSolve.Comp[a,2].Im),
                            inttostr(a));
      Image1.Canvas.MoveTo(xU,yU);
      Image1.Canvas.LineTo(xU+sign*round(GridScale*Graph.MSolve.Comp[a,2].Re),
                           yU-sign*round(GridScale*Graph.MSolve.Comp[a,2].Im));
      xU:=xU+round(sign*GridScale*Graph.MSolve.Comp[a,2].Re);
      yU:=yU-round(sign*GridScale*Graph.MSolve.Comp[a,2].Im);
    end;
  end;}


  Image1.Canvas.Brush.Color:=clwhite;
  Image1.Canvas.FillRect(Image1.Canvas.cliprect);
  GridScale:=TrackBar1.Position;
  DrawGrid(GridScale);
  x:=CanvasX;
  y:=CanvasY;
  image1.Canvas.Pen.Width:=2;
  image1.Canvas.Pen.Color:=clgreen;
  xI:=x; yI:=y;
  for a:=0 to 299 do begin
    Image1.Canvas.MoveTo(xI, yI-round(GridScale*ResultUC[DiagCounter{+12*DiagVertice},a]));
    Image1.Canvas.LineTo(round(x+(a+2)*GridScale / 200), yI-round(GridScale*ResultUC[DiagCounter{+12*DiagVertice},a+1]));
    xI:=round(x+(a+2)*GridScale / 200);
  end;

  image1.Canvas.Pen.Color:=clred;
  xI:=x; yI:=y;
  for a:=0 to 299 do begin
    Image1.Canvas.MoveTo(xI, yI-round(GridScale*ResultUC[DiagCounter+12,a]));
    Image1.Canvas.LineTo(round(x+(a+2)*GridScale / 200), yI-round(GridScale*ResultUC[DiagCounter+12,a+1]));
    xI:=round(x+(a+2)*GridScale / 200);
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
  DiagVertice:=0;
  DiagCounter:=1;
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
var sign,oldpos,deltaX,canvX,canvY,deltaY:integer;
begin
  oldpos:=trackbar1.Position;
  deltaX:=Image1.Width div 2;
  deltaY:=Image1.Height div 2;
  canvX:=CanvasX-deltaX;
  canvY:=CanvasY-deltaY;
  TrackBar1.Position := TrackBar1.Position+ round(
                              (TrackBar1.Position/1000)*
                              (WheelDelta)
                              );

  if wheeldelta>0 then sign:=1 else sign:=-1;
  CanvasX:=deltaX+round(CanvX*trackbar1.Position/oldpos);
  CanvasY:=deltaY+round(CanvY*trackbar1.Position/oldpos);
  DownX:=CanvasX-DeltaX;
  DownY:=CanvasY;
  label6.Caption:='canvasX '+inttostr(round(CanvX*trackbar1.Position/oldpos));
  label8.Caption:=floattostrf(trackbar1.Position/oldpos,ffgeneral,4,4)
end;

procedure TForm4.Edit3Change(Sender: TObject);
var val:integer;
begin
  val:=strtoint(Edit3.Text);
  if val < 1 then val := 1;
  if val > (12) then val:=12;
  DiagCounter := val;
  Edit3.Text:=inttostr(val);
  DrawDiag;
  listbox1.Clear;
  listbox2.Clear;
  for val:=99 to 299 do begin
    listbox1.Items.Add(floattostrf(ResultUC[DiagCounter,val],ffGEneral,4,4));
    listbox2.Items.Add(floattostrf(ResultUC[DiagCounter+12,val],ffGEneral,4,4));
  end;
end;

procedure TForm4.Edit3KeyPress(Sender: TObject; var Key: Char);
begin
  if not (Key in [#8, '0'..'9']) then
    Key := #0;
end;

procedure TForm4.Button2Click(Sender: TObject);
var a: integer;
begin
  ListBox1.Clear;
  for a:=0 to 300 do
    ListBox1.AddItem(floattostrf(ResultUC[DiagCounter,a],ffGEneral,4,4),Sender);

end;

procedure TForm4.RadioButton1Click(Sender: TObject);
begin
  DiagVertice:=0;
  DrawDiag;
end;

procedure TForm4.RadioButton2Click(Sender: TObject);
begin
  DiagVertice:=1;
  DrawDiag;
end;

end.
