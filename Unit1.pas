unit Unit1;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ExtCtrls, StdCtrls, Math, Grids, ValEdit, ComplexAlg, MatrixAlg;

type



  Path = Array[0..1, 0..20] of integer; //0 for Vertices, 1 for Edges
  TForm1 = class(TForm)
    Image1: TImage;
    ValueListEditor1: TValueListEditor;
    Button2: TButton;
    Label3: TLabel;
    Button4: TButton;
    StringGrid1: TStringGrid;
    Button5: TButton;
    Button6: TButton;
    Button14: TButton;
    Button17: TButton;
    Button18: TButton;
    Button19: TButton;
    Button21: TButton;
    Button22: TButton;
    Button23: TButton;
    Button26: TButton;
    GroupBox1: TGroupBox;
    Label1: TLabel;
    Button1: TButton;
    Button3: TButton;
    Button7: TButton;
    Button8: TButton;
    Button9: TButton;
    Button10: TButton;
    Button11: TButton;
    Button12: TButton;
    GroupBox2: TGroupBox;
    GroupBox3: TGroupBox;
    Button13: TButton;
    Button15: TButton;
    StringGrid2: TStringGrid;
    Button16: TButton;
    procedure EnableButtons;
    procedure Image1MouseMove(Sender: TObject; Shift: TShiftState; X,
      Y: Integer);
    procedure FormCreate(Sender: TObject);
    procedure Image1MouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure Image1MouseUp(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure Button1Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure Button4Click(Sender: TObject);
    procedure Button5Click(Sender: TObject);
    procedure Button6Click(Sender: TObject);
    procedure Button8Click(Sender: TObject);
    procedure Button9Click(Sender: TObject);
    procedure Button10Click(Sender: TObject);
    procedure Button12Click(Sender: TObject);
    procedure Button13Click(Sender: TObject);
    procedure Button14Click(Sender: TObject);
    procedure Button15Click(Sender: TObject);
    procedure PrintMatrix (M: Matrix; Res:boolean=false);
    procedure Button16Click(Sender: TObject);
    procedure Button17Click(Sender: TObject);
    procedure Button18Click(Sender: TObject);
    procedure Button19Click(Sender: TObject);
    procedure Button20Click(Sender: TObject);
    procedure Button22Click(Sender: TObject);
    procedure Button23Click(Sender: TObject);
    procedure Button21Click(Sender: TObject);
    procedure Button24Click(Sender: TObject);
    procedure Button25Click(Sender: TObject);
    procedure Button26Click(Sender: TObject);
    procedure Button3Click(Sender: TObject);
    procedure Button7Click(Sender: TObject);
    procedure Button11Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

  TVertice=class
    Degree: integer;                //count of edges connected
    LineID:    array [1..10] of byte;  //ID's of edges connected
    ID:        word;                   //Vertice №
    constructor Create;
  end;

  TEdge = class
    IsTree:   boolean; //true => belongs to TREE
    Enabled:  boolean; //for secondary operations
    ID:       word;    //edge №
    side1:    word;    //vertice 1
    side2:    word;    //vertice 2
    eR:       real;    //active imp. 0=none
    eL:       word;    //coil        0=none
    eC:       word;    //capacitor   0=none
    IISrc:     byte;    //independent source. produces: 0=none, 1=current, 2=voltage
    IISPhase:  real;    //IS's phase, degrees
    IISAmp:    real;    //IS's amplitude
    IUSrc:     byte;    //independent source. produces: 0=none, 1=current, 2=voltage
    IUSPhase:  real;    //IS's phase, degrees
    IUSAmp:    real;    //IS's amplitude
    DSrc:     integer;    //dependent source. produces: 0=none, 1=current, 2=voltage
    DSCoef:   real;    //sort of coefficient. "beta" for U, "delta" for I
    DSEdge:   integer;    //№ of edge to read info from
    DSIn:     integer;    //what to read: 0=none, 1=current, 2=voltage
    constructor Create;   //Jesus Christ
    procedure Equalize (out EdgeOut: TEdge);
  end;

  TGraph = class
    public
    Phase:        integer; //phase, degrees
    Freq:         integer; //frequency
    EdgeCount:    integer;   //Edge Count
    VerticeCount: integer; //Vertice Count
    Edges:        Array[1..100] of TEdge;
    Vertices:     Array[1..100] of TVertice;
    VerticeXY:    Array[1..100] of TPoint;
    ElemXY:       Array[1..100, 1..7] of TPOint; //1..3 {R, L, C}, 4..5 {IS(I), IS(U)}, 6..7 {DS(I), DS(U)}
    CurrentFix:   Array[0..1, 0..10] of real;  //[0,0] - item count. [0,x]=EdgeNum, [1,x]=extra current
    MSolve:       Matrix;  //Matrix with calculated currents/voltages
    MMesh:        Matrix;  //Mesh matrix ftw
    MInc:         Matrix;  //Incidence matrix
    MCyc:         Matrix;  //Cycle Matrix
    MCut:         Matrix;
    MZ:           Matrix; //diagonal Z matrix
    MY:           Matrix; //diagonal 1/Z matrix
    ME:           Matrix; //Voltage sources matrix
    MJ:           Matrix; //Current sources matrix
//    Tree:         TGraph;
    constructor Create;
    procedure CreateSelf (p: byte); //0 for inside, 1 for file, 2 for simple
    procedure EnumEdges;
    function SDependentMesh:Matrix;
    function SDependentCut: Matrix;
    function SDependentMKT: Matrix;
    function SDependentNVM: Matrix;
    function SDependent: Matrix;
    function SolveMesh: Matrix;
    function SolveCut: Matrix;
    function Solve:    Matrix;
    function SolveNVM: Matrix;  //Node Voltages Method
    function SolveMKT: Matrix;
    procedure Restore;
    procedure SpreadCS (EdgeNum: word); //spreads a current source to random counter around it
    procedure CreateMatrix;  //MType: 0=Incidence, 1=Cycle, 2=Cut
    function SubTreeVertices (Vertice: word; Way: Path): Path;
    function FindCut (EdgeNum: word): Path;
    function FindCycle (EdgeNum: word): Path;
    function FindWay (Vertice1, Vertice2: integer; Method: byte; Way: Path): Path;
                    //Method: 0=Everything, 1=Tree+Enabled, 2=Everything w/o Disabled
    procedure FindTree (Vertice, Found: integer);
    procedure DefineVertices;
    procedure GenVerticeXY;
    procedure DrawGraph;
    function EdgeElemCount (EdgeNum: integer): integer;
    procedure DrawEdge (EdgeNum: integer);
    function ObjClicked (X, Y: integer; Out ObjectID, ElemID: integer) : integer;  //Object ID - either Edge or Vertice ID.
                                                                                    //ElemID exists only for Edge.
                                                                                    //Returns: 0 = nothing, 1 = Edge, 2 = Vertice
    procedure GenRandomGraph (NumVertices, NumEdges: integer);
    procedure DrawElem (x1, y1, x2, y2, elem: integer; color:TColor=clblack); //elem: 1=R; 2=L; 3=C;
                                                                              //      4=IS(I); 5=IS(U);                                                                             //      6=DS(I); 7=DS(U);
  end;

var
  GraphSet: boolean;
  locale: string;
  Form1: TForm1;
  mouse: TMouse;        //bullshit
  Center: TPoint;
  Graph: TGraph;
  MouseState: integer;       //0: none; 1: MouseDown; 2: MouseUp; Canvas Only!
  ObjectClicked: integer;   //Edge or Vertice clicked Number
  ElemClicked: integer;   //for Edge - elem type that was clicked. for Vertice is 0
implementation

uses Unit2, Unit3, Unit4;

{$R *.dfm}

constructor TVertice.Create;
var a: byte;
begin
  Degree:=0;
  for a:=1 to 10 do LineID[a]:=0;
  ID:=0;
end;

constructor TGraph.Create;
var a,b:integer;
begin
  CurrentFix[0,0]:=0;
  for a:=1 to 100 do begin
    Edges[a]:= TEdge.Create;
    Vertices[a]:= TVertice.Create;
    VerticeXY[a]:=Point(0,0);
    for b:=1 to 5 do
      ElemXY[a,b]:=Point(-100,-100);
  end;
end;

constructor TEdge.Create;
begin
  side1:=0;
  side2:=0;
  eR:=0;
  eL:=0;
  eC:=0;
  IISrc:=0;
  IISAmp:=0;
  IUSrc:=0;
  IUSAmp:=0;
  DSrc:=0;
  IsTree:=false;
  Enabled:=true;
end;

procedure TForm1.EnableButtons;
begin
  button23.Enabled:=true;
  button21.Enabled:=true;
  button1.Enabled:=true;
  button10.Enabled:=true;
  button5.Enabled:=true;
  button6.Enabled:=true;
  button4.Enabled:=true;
  button12.Enabled:=true;
  button17.Enabled:=true;
  button18.Enabled:=true;
  button14.Enabled:=true;
  button22.Enabled:=true;
end;

procedure TGraph.CreateSelf(p: byte);
var f: textfile;
a: integer;
begin
  GraphSet:=true;
  self.Create;
  case p of
  0: begin               //0 = from 'internal memory'
    VerticeCount:=7;
    EdgeCount:=12;
    Freq:=250;                    //Hz
    Phase:=0;

    Edges[1].ID:=1;
    Edges[1].side1:=1;
    Edges[1].side2:=2;
    Edges[1].IUSrc:=1;
    Edges[1].IUSAmp:=10;
    Edges[1].IUSPhase:=Phase;
    Edges[1].eR:=1;

    Edges[2].ID:=2;
    Edges[2].side1:=2;
    Edges[2].side2:=3;
    Edges[2].eR:=3;
    Edges[2].eL:=3;

    Edges[3].ID:=3;
    Edges[3].side1:=5;
    Edges[3].side2:=7;
    Edges[3].DSrc:=2;
    Edges[3].DSCoef:=0.5;
    Edges[3].DSEdge:=7;
    Edges[3].DSIn:=1;
    Edges[3].eR:=1;
    Edges[3].eC:=500;

    Edges[4].ID:=4;
    Edges[4].side1:=4;
    Edges[4].side2:=5;
    Edges[4].eC:=300;

    Edges[5].ID:=5;
    Edges[5].side1:=2;
    Edges[5].side2:=5;
    Edges[5].IISrc:=1;
    Edges[5].IISAmp:=1;
    Edges[5].IISPhase:=3*Phase;

    Edges[6].ID:=6;
    Edges[6].side1:=5;
    Edges[6].side2:=6;
    Edges[6].eR:=1;
    Edges[6].eL:=5;
    Edges[6].eC:=200;

    Edges[7].ID:=7;
    Edges[7].side1:=3;
    Edges[7].side2:=6;
    Edges[7].eL:=2;

    Edges[8].ID:=8;
    Edges[8].side1:=2;
    Edges[8].side2:=4;
    Edges[8].DSrc:=1;
    Edges[8].DSCoef:=0.1;
    Edges[8].DSEdge:=12;
    Edges[8].DSIn:=2;
    Edges[8].eL:=3;

    Edges[9].ID:=9;
    Edges[9].side1:=2;
    Edges[9].side2:=6;
    Edges[9].eR:=5;
    Edges[9].eL:=1;

    Edges[10].ID:=10;
    Edges[10].side1:=4;
    Edges[10].side2:=7;
    Edges[10].IUSrc:=1;
    Edges[10].IUSAmp:=10;
    Edges[10].IUSPhase:=2*Phase;

    Edges[11].ID:=11;
    Edges[11].side1:=1;
    Edges[11].side2:=4;
    Edges[11].eR:=10;

    Edges[12].ID:=12;
    Edges[12].side1:=6;
    Edges[12].side2:=7;
    Edges[12].eL:=3;
  end;
  1: begin                        //1 = from file
    AssignFile(f, 'input.txt');
    reset(f);
    read(f,VerticeCount);
    read(f,EdgeCount);
    read(f, Freq);
    read(f, Phase);
    for a:=1 to EdgeCount do begin
      read(f, Edges[a].ID);
      read(f, Edges[a].side1);
      read(f, Edges[a].side2);
      read(f, Edges[a].eR);
      read(f, Edges[a].eL);
      read(f, Edges[a].eC);
      read(f, Edges[a].IISrc);
      read(f, Edges[a].IISPhase);
      read(f, Edges[a].IISAmp);
      read(f, Edges[a].IUSrc);
      read(f, Edges[a].IUSPhase);
      read(f, Edges[a].IUSAmp);
      read(f, Edges[a].DSrc);
      read(f, Edges[a].DSCoef);
      read(f, Edges[a].DSEdge);
      read(f, Edges[a].DSIn);
    end;
    closefile(f);
    for a:=1 to EdgeCount do begin
      Edges[a].IISPhase := Edges[a].IISPhase*Phase;
      Edges[a].IUSPhase := Edges[a].IUSPhase*Phase;
    end;  

  end;
  2: begin                    //2 = simple scheme
    VerticeCount:=4;
    EdgeCount:=5;
    Freq:=250;                    //Hz

    Edges[1].ID:=1;
    Edges[1].side1:=1;
    Edges[1].side2:=2;
    Edges[1].eR:=1;

    Edges[2].ID:=2;
    Edges[2].side1:=1;
    Edges[2].side2:=3;
    Edges[2].IISrc:=1;
    Edges[2].IISAmp:=12*sqrt(2);

    Edges[3].ID:=3;
    Edges[3].side1:=1;
    Edges[3].side2:=4;
    Edges[3].eR:=5;

    Edges[4].ID:=4;
    Edges[4].side1:=2;
    Edges[4].side2:=3;
    Edges[4].eR:=1;

    Edges[5].ID:=5;
    Edges[5].side1:=3;
    Edges[5].side2:=4;
    Edges[5].eR:=1;
  end;
  end;
  for a:=1 to EdgeCount do begin
    Edges[a].IISAmp:=Edges[a].IISAmp/sqrt(2);
    Edges[a].IUSAmp:=Edges[a].IUSAmp/sqrt(2);
    if Edges[a].IUSrc=1 then Edges[a].eR:=Edges[a].eR+1/999999;
  end;
end;



procedure TEdge.Equalize(out EdgeOut: TEdge);
var EdgeIn: TEdge;
begin
  EdgeIn:=self;
  EdgeOut:=TEdge.Create;
  EdgeOut.IsTree:=IsTree;
  EdgeOut.Enabled:=Enabled;
  EdgeOut.ID:=ID;
  EdgeOut.side1:=side1;
  EdgeOut.side2:=side2;
  EdgeOut.eR:=eR;
  EdgeOut.eL:=eL;
  EdgeOut.eC:=eC;
  EdgeOut.IISrc:=IISrc;
  EdgeOut.IISPhase:=IISPhase;
  EdgeOut.IISAmp:=IISAmp;
  EdgeOut.IUSrc:=IUSrc;
  EdgeOut.IUSPhase:=IUSPhase;
  EdgeOut.IUSAmp:=IUSAmp;
  EdgeOut.DSrc:=DSrc;
  EdgeOut.DSCoef:=DSCoef;
  EdgeOut.DSEdge:=DSEdge;
  EDgeOut.DSIn:=DSIn;
end;

procedure TGraph.EnumEdges;
var a, b: byte;
cache: TEdge;
begin
  b:=0;
  for a:=1 to VerticeCount do begin
    if (not Edges[a].IsTree)and(a<VerticeCount) then begin //if non-tree edge has low number
      //simpleID:=a;
      for b:=VerticeCount to EdgeCount do begin
        if (Edges[b].IsTree) then begin
          Edges[a].Equalize(cache);
          Edges[b].Equalize(Edges[a]);
          cache.Equalize(Edges[b]);
        end;
      end;
    end;
  end;
  DefineVertices;
end;

function TGraph.SDependentMesh: Matrix;
var a,b: integer;
S: Matrix;
C: Complex;
begin
  for b:=1 to 5 do begin
    S:=SolveMesh;
    for a:=1 to EdgeCount do begin //assigning new ISrc's
      if Edges[a].DSrc=1 then begin
        Edges[a].IISrc:=1;
        C:=ComplMult(S.Comp[Edges[a].DSEdge, Edges[a].DSIn],
                     Compl(Edges[a].DSCoef, 0));
        Edges[a].IISAmp:=ComplAbs(C);
        Edges[a].IISPhase:=ComplDeg(C);
      end;
      if Edges[a].DSrc=2 then begin
        Edges[a].IUSrc:=1;
        C:=ComplMult(S.Comp[Edges[a].DSEdge, Edges[a].DSIn],
                     Compl(Edges[a].DSCoef, 0));
        Edges[a].IUSAmp:=ComplAbs(C);
        Edges[a].IUSPhase:=ComplDeg(C);
      end;
    end;
  end;
  MSolve:=SolveMesh;
  Result:=SolveMesh;
end;


function TGraph.SDependentCut: Matrix;
var a,b: integer;
S: Matrix;
C: Complex;
begin
  for b:=1 to 5 do begin
    S:=SolveCut;
    for a:=1 to EdgeCount do begin //assigning new ISrc's
      if Edges[a].DSrc=1 then begin
        Edges[a].IISrc:=1;
        //Edges[a].IISAmp:=S.Body[Edges[a].DSEdge, Edges[a].DSIn]*Edges[a].DSCoef;
        C:=ComplMult(S.Comp[Edges[a].DSEdge, Edges[a].DSIn],
                     Compl(Edges[a].DSCoef, 0));
        Edges[a].IISAmp:=ComplAbs(C);
        Edges[a].IISPhase:=ComplDeg(C);
      end;
      if Edges[a].DSrc=2 then begin
        Edges[a].IUSrc:=1;
        //Edges[a].IUSAmp:=S.Body[Edges[a].DSEdge, Edges[a].DSIn]*Edges[a].DSCoef;
        C:=ComplMult(S.Comp[Edges[a].DSEdge, Edges[a].DSIn],
                     Compl(Edges[a].DSCoef, 0));
        Edges[a].IUSAmp:=ComplAbs(C);
        Edges[a].IUSPhase:=ComplDeg(C);
      end;
    end;
  end;
  MSolve:=SolveCut;
  Result:=SolveCut;
end;

function TGraph.SDependentNVM: Matrix;
var a,b: integer;
S: Matrix;
C: Complex;
begin
  for b:=1 to 5 do begin
    S:=SolveNVM;
    for a:=1 to EdgeCount do begin //assigning new ISrc's
      if Edges[a].DSrc=1 then begin
        Edges[a].IISrc:=1;
        C:=ComplMult(S.Comp[Edges[a].DSEdge, Edges[a].DSIn],
                     Compl(Edges[a].DSCoef, 0));
        Edges[a].IISAmp:=ComplAbs(C);
        Edges[a].IISPhase:=ComplDeg(C);
      end;
      if Edges[a].DSrc=2 then begin
        Edges[a].IUSrc:=1;
        C:=ComplMult(S.Comp[Edges[a].DSEdge, Edges[a].DSIn],
                     Compl(Edges[a].DSCoef, 0));
        Edges[a].IUSAmp:=ComplAbs(C);
        Edges[a].IUSPhase:=ComplDeg(C);
      end;
    end;
  end;
  MSolve:=SolveNVM;
  Result:=SolveNVM;
end;

function TGraph.SDependentMKT: Matrix;
var a,b: integer;
S: Matrix;
C:Complex;
begin
  for b:=1 to 5 do begin
    S:=SolveMKT;
    for a:=1 to EdgeCount do begin //assigning new ISrc's
      if Edges[a].DSrc=1 then begin
        Edges[a].IISrc:=1;
        C:=ComplMult(S.Comp[Edges[a].DSEdge, Edges[a].DSIn],
                     Compl(Edges[a].DSCoef, 0));
        Edges[a].IISAmp:=ComplAbs(C);
        Edges[a].IISPhase:=ComplDeg(C);
      end;
      if Edges[a].DSrc=2 then begin
        Edges[a].IUSrc:=1;
        C:=ComplMult(S.Comp[Edges[a].DSEdge, Edges[a].DSIn],
                     Compl(Edges[a].DSCoef, 0));
        Edges[a].IUSAmp:=ComplAbs(C);
        Edges[a].IUSPhase:=ComplDeg(C);
      end;
    end;
  end;
  MSolve:=SolveMKT;
  Result:=SolveMKT;
end;

function TGraph.SDependent: Matrix;
var a,b: integer;
S: Matrix;
begin
  for b:=1 to 5 do begin
    S:=Solve;
    for a:=1 to EdgeCount do begin //assigning new ISrc's
      if Edges[a].DSrc=1 then begin
        Edges[a].IISrc:=1;
        Edges[a].IISAmp:=S.Body[Edges[a].DSEdge, Edges[a].DSIn]*Edges[a].DSCoef;
      end;
      if Edges[a].DSrc=2 then begin
        Edges[a].IUSrc:=1;
        Edges[a].IUSAmp:=S.Body[Edges[a].DSEdge, Edges[a].DSIn]*Edges[a].DSCoef;
      end;
    end;
  end;
  Result:=Solve;
end;

function TGraph.Solve: Matrix;
var mun, mkt: Matrix;
a: integer;
begin
  mun:=SolveNVM;
  mkt:=SolveMKT;
  for a:=1 to EdgeCount do
    mkt.Body[a,2]:=mun.body[a,2];
  Result:=mkt;
end;

function TGraph.SolveCut: Matrix;
var a,b,c: integer;
Dk, I, J, J1, J2, U: Matrix;
GraphCache: TGraph;
begin
  CreateMatrix;
  Dk:=MatrixMult(MCut, MY);      //DY
  Dk:=MatrixMult(Dk, transpose(MCut));  //DYDt = Dk
  Dk:=MatrixInverse(Dk);
  J1:=MatrixMult(MCut, MJ); //J1 = DJ
  J2:=MatrixMult(MCut, MY);
  J2:=MatrixMult(J2, ME);   //J2 = DYE
  J:=MatrixSub(J2, J1);   //J = DYE-DJ
  U:=MatrixMult(Dk, J);   //U=(DYDt)^(-1)*(DYE-DJ)
 //what we have got right now is tree edge's voltages
 //then we make all voltages from this input
 //and then as usual
  U:=MatrixMultReal(U,-1);
  U:=(MatrixMult(transpose(MCut), U));   //U=At*F
  result:=transpose(U);

  I:=MatrixAdd(U,ME);   //      U+E
  I:=MatrixMult(MY, I);  //      Y(U+E)
  I:=MatrixSub(I, MJ); //       Y(U+E)-J
  I.X:=2;
  for a:=1 to EdgeCount do begin
    I.Comp[2,a]:=U.Comp[1,a];
    I.Body[2,a]:=U.Body[1,a];
  end;
  Result:=transpose(I);
end;

function TGraph.SolveMesh: Matrix;
var a,b,c: integer;
Zk, Ik, Ek, Ek1, Ek2, U: Matrix;
GraphCache: TGraph;
begin
  CreateMatrix;
  Zk:=MatrixMult(MMesh, MZ);      //  MZ
  Zk:=MatrixMult(Zk, transpose(MMesh));  //  MZMt
  Zk:=MatrixInverse(Zk); //         (MZMt)^(-1)
  Ek1:=MatrixMult(MMesh, ME);  //  ME
  Ek2:=MatrixMult(MMesh, MZ);
  Ek2:=MatrixMult(Ek2, MJ);   //  MZJ
  Ek:=MatrixSub(Ek1, Ek2);    //  ME-MZJ
  Ik:=MatrixMult(Zk, Ek);
  Ik:=MatrixMult(transpose(Ik),MMesh);
//    Result:=Ik;

  U:=MatrixAdd(transpose(Ik),MJ);     //  I+J
  U:=MatrixMult(MZ, U);     //            Z(I+J)
  U:=MatrixSub(U, ME);      //            Z(I+J)-E
  Ik.Y:=2;
  U:=transpose(U);
  for a:=1 to EdgeCount do begin
    Ik.Body[a,2]:=U.Body[a,1];
    Ik.Comp[a,2]:=U.Comp[a,1];
  end;
  //Form1.PrintMatrix(Ik);
  Result:=Ik;
end;

function TGraph.SolveMKT: Matrix;
var a,b,c: integer;
Zk, Ik, Ek, Ek1, Ek2, U: Matrix;
GraphCache: TGraph;
begin
  CreateMatrix;
  Zk:=MatrixMult(MCyc, MZ);      //BZ
  Zk:=MatrixMult(Zk, transpose(MCyc));  //BZBt = Zk
  Zk:=MatrixInverse(Zk);
  Ek1:=MatrixMult(MCyc, ME);
  Ek2:=MatrixMult(MCyc, MZ);
  Ek2:=MatrixMult(Ek2, MJ);
  Ek:=MatrixSub(Ek1, Ek2);
  Ik:=MatrixMult(Zk, Ek);
  Ik:=MatrixMult(transpose(Ik),MCyc);
  U:=MatrixAdd(transpose(Ik),MJ);     //  I+J
  U:=MatrixMult(MZ, U);     //            Z(I+J)
  U:=MatrixSub(U, ME);      //            Z(I+J)-E
  Ik.Y:=2;
  U:=transpose(U);
  for a:=1 to EdgeCount do begin
    Ik.Body[a,2]:=U.Body[a,1];
    Ik.Comp[a,2]:=U.Comp[a,1];
  end;
  //Form1.PrintMatrix(Ik);
  Result:=Ik;
end;

function TGraph.SolveNVM: Matrix;
var a,b,c: integer;
Zk, Yy, Jy, Jy1, Jy2, U, Y, I: Matrix;
begin
  CreateMatrix;
  Y:=MY;
  Yy:=MatrixMult(MInc, Y);      //AY
  Yy:=MatrixMult(Yy, transpose(MInc));  //AYAt = Yy
  Yy:=MatrixInverse(Yy);
  Jy1:=MatrixMult(MInc, MJ);
  Jy2:=MatrixMult(MInc, Y);
  Jy2:=MatrixMult(Jy2, ME);
  Jy:=MatrixSub(Jy1, Jy2);
  U:=MatrixMult(Yy, Jy);
  //result:=transpose(U);
  U:=(MatrixMult(transpose(MInc), U));   //U=At*F
  I:=MatrixAdd(U,ME);   //      U+E
  I:=MatrixMult(MY, I);  //      Y(U+E)
  I:=MatrixSub(I, MJ); //       Y(U+E)-J
  I.X:=2;
  for a:=1 to EdgeCount do begin
    I.Body[2,a]:=U.Body[1,a];
    I.Comp[2,a]:=U.Comp[1,a];    
  end;
  Result:=transpose(I);
end;

procedure TGraph.Restore;
begin
  Form1.Button2Click(Form1);
end;

procedure TGraph.SpreadCS (EdgeNum: word);
var Way, WayOP: Path;
a,b,c: byte;
Vert1, Vert2: word;
begin
  for a:=0 to 1 do
    for b:=0 to 20 do begin
      Way[a,b]:=0;
      WayOp[a,b]:=0;
    end;
  Vert1:=Edges[EdgeNum].side1;
  Vert2:=Edges[EdgeNum].side2;
  Edges[EdgeNum].Enabled:=false;

  CurrentFix[0,0]:=CurrentFix[0,0]+1;
  c:=round(CurrentFix[0,0]);
  CurrentFix[0,c]:=EdgeNum;
  CurrentFix[1,c]:=Edges[EdgeNum].IISAmp;

  Way:=FindWay(Vert1, Vert2, 2, WayOP);
  for a:=1 to Way[0,0]-1 do begin
    Edges[Way[1,a]].IISrc:=1;
    CurrentFix[0,0]:=CurrentFix[0,0]+1;
    c:=round(CurrentFix[0,0]);
    CurrentFix[0,c]:=Way[1,a];
    if Edges[Way[1,a]].side1=Way[0,a] then begin
      Edges[Way[1,a]].IISAmp:=-Edges[EdgeNum].IISAmp;
      CurrentFix[1,c]:=-Edges[EdgeNum].IISAmp;
    end else begin
        Edges[Way[1,a]].IISAmp:=Edges[EdgeNum].IISAmp;
        CurrentFix[1,c]:=Edges[EdgeNum].IISAmp;
      end;
  end;
  //Edges[EdgeNum].Enabled:=true;
  Edges[EdgeNum].IISrc:=0;
end;

procedure TForm1.PrintMatrix(M:Matrix; Res: boolean=false);
var a,b: integer;
begin
  if not Res then begin
    for a:=1 to 20 do StringGrid1.Cols[a].Clear;
    for a:=1 to M.X do begin
      for b:=1 to M.Y do begin
     // StringGrid1.Cells[a,b]:=floattostrf(M.Body[a,b],ffGeneral,3,3);
        StringGrid1.Cells[a,b]:=ComplString(M.Comp[a,b]);
        StringGrid1.Cells[0,b]:=inttostr(b);
        StringGrid1.Cells[a,0]:=inttostr(a);
      end;
    end;
  end;

  if Res then begin
    for a:=1 to 20 do StringGrid2.Cols[a].Clear;
    for a:=1 to M.X do begin
      for b:=1 to M.Y do begin
        StringGrid2.Cells[a,b*2-1]:=ComplString(M.Comp[a,b]);
       // StringGrid2.Cells[0,b]:=inttostr(b);
        StringGrid2.Cells[a,0]:=inttostr(a);
       end;
    end;
    for a:=1 to M.X do begin
      StringGrid2.Cells[a,2]:=floattostrf(ComplDeg(M.Comp[a,1]),ffGeneral,3,2);
      StringGrid2.Cells[a,4]:=floattostrf(ComplDeg(M.Comp[a,2]),ffGeneral,3,2);
    end;
    StringGrid2.Cells[0,1]:='I, A';
    StringGrid2.Cells[0,3]:='U, V';
    StringGrid2.Cells[0,0]:='Edge №';
    StringGrid2.Cells[0,2]:='Phase, deg';
    StringGrid2.Cells[0,4]:='Phase, deg';
  end;
end;


procedure TGraph.CreateMatrix;
var a, b, c, CycN:integer;
vert1, vert2, edge1, edge2, cachemin, cachemax: integer;
ToAdd, ReZ, ImZ: extended;
sinf, cosf: real;
Way: Path;
CutN: integer;
led: boolean;
inf: integer;
Omega: extended;
begin
  inf:=999999;

  for a:=1 to 20 do              //mesh
    for b:=1 to 20 do begin
      MMesh.Body[a,b]:=0;
      MMesh.Comp[a,b]:=Compl(0,0);
    end;
  CycN:=0;
  for a:=1 to EdgeCount do begin
    vert1:=Edges[a].side1;
    vert2:=Edges[a].side2;
    for b:=1 to Vertices[vert1].Degree do
      for c:=1 to Vertices[vert2].Degree do begin
        led:=false;
        edge1:=Vertices[vert1].LineID[b];
        edge2:=Vertices[vert2].LineID[c];
        if (edge1>a) and (edge2>a) then begin
          if Edges[edge1].side1=Edges[edge2].side2 then begin
            inc(CycN);
            led:=true;
            MMesh.Body[edge1,CycN]:=1;
            MMesh.Body[edge2,CycN]:=1;

            MMesh.Comp[edge1,CycN]:=Compl(1,0);
            MMesh.Comp[edge2,CycN]:=Compl(1,0);
          end;
          if Edges[edge1].side1=Edges[edge2].side1 then begin
            inc(CycN);
            led:=true;
            MMesh.Body[edge1,CycN]:=1;
            MMesh.Body[edge2,CycN]:=-1;

            MMesh.Comp[edge1,CycN]:=Compl(1,0);
            MMesh.Comp[edge2,CycN]:=Compl(-1,0);
          end;
          if Edges[edge1].side2=Edges[edge2].side1 then begin
            inc(CycN);
            led:=true;
            MMesh.Body[edge1,CycN]:=-1;
            MMesh.Body[edge2,CycN]:=-1;

            MMesh.Comp[edge1,CycN]:=Compl(-1,0);
            MMesh.Comp[edge2,CycN]:=Compl(-1,0);
          end;
          if Edges[edge1].side2=Edges[edge2].side2 then begin
            inc(CycN);
            led:=true;
            MMesh.Body[edge1,CycN]:=-1;
            MMesh.Body[edge2,CycN]:=1;

            MMesh.Comp[edge1,CycN]:=Compl(-1,0);
            MMesh.Comp[edge2,CycN]:=Compl(1,0);
          end;
          if led then begin
            MMesh.Body[a,CycN]:=1;
            MMesh.Comp[a,CycN]:=Compl(1,0);
          end;
        end;
      end;
  end;
  MMesh.X:=EdgeCount;
  MMesh.Y:=CycN;

//incidence
  MInc.X:=EdgeCount;
  MInc.Y:=VerticeCount-1;
  for a:=1 to 20 do
    for b:=1 to 20 do begin
      MInc.Body[a,b]:=0;
      MInc.Comp[a,b]:=Compl(0,0);
    end;
  for a:=1 to EdgeCount do begin
    vert1:=Edges[a].side1;
    vert2:=Edges[a].side2;
    MInc.Body[a,vert1]:=1;
    MInc.Body[a,vert2]:=-1;

    MInc.Comp[a,vert1]:=Compl(1,0);
    MInc.Comp[a,vert2]:=Compl(-1,0);
  end;

        //cycle
  for a:=1 to 20 do
    for b:=1 to 20 do begin
      MCyc.Body[a,b]:=0;
      MCyc.Comp[a,b]:=Compl(0,0);
    end;
  CycN:=0;
  for a:=1 to EdgeCount do begin
    if not Edges[a].IsTree then begin //only non-tree edges
      inc(CycN);                      //cycle counter
      Way:=FindCycle(a);
      for b:=1 to Way[0,0] do begin
        if Edges[Way[1,b]].side1=Way[0,b] then ToAdd:=1
          else ToAdd:=-1;
        MCyc.Body[Way[1,b], CycN]:=ToAdd;
        MCyc.Comp[Way[1,b], CycN]:=Compl(ToAdd,0);
      end;
    end;
  end;
  MCyc.X:=EdgeCount;
  MCyc.Y:=CycN;

      //cut
  for a:=1 to 20 do
    for b:=1 to 20 do begin
      MCut.Body[a,b]:=0;
      MCut.Comp[a,b]:=Compl(0,0);
    end;
  CycN:=0;    //=>CutN
  for a:=1 to EdgeCount do begin
    if Edges[a].IsTree then begin //only non-tree edges
      inc(CycN);                      //cycle counter
      Way:=FindCut(a);
      for b:=1 to Way[0,0] do begin
         MCut.Body[Way[0,b],CycN]:=Way[1,b];
         MCut.Comp[Way[0,b],CycN]:=Compl(Way[1,b], 0);
      end;
    end;
  end;
  MCut.X:=EdgeCount;
  MCut.Y:=CycN;

   //common for MZ, ME, MJ, MY
  for a:=1 to 20 do
    for b:=1 to 20 do begin
      MZ.Body[a,b]:=0;
      ME.Body[a,b]:=0;
      MJ.Body[a,b]:=0;
      MZ.Comp[a,b]:=Compl(0,0);
      ME.Comp[a,b]:=Compl(0,0);
      MJ.Comp[a,b]:=Compl(0,0);
    end;
  MZ.X:=EdgeCount;
  MZ.Y:=EdgeCount;
  MY:=MZ;
  ME.X:=1;
  ME.Y:=EdgeCount;
  MJ.X:=1;
  MJ.Y:=EdgeCount;
  for a:=1 to EdgeCount do begin
    ReZ:=0;
    ImZ:=0;
    ToAdd:=0;
    Omega:=2*PI*Freq;
    if Edges[a].eR>0 then ReZ:=ReZ+Edges[a].eR;
    if Edges[a].eL>0 then ImZ:=ImZ+(Edges[a].eL*Omega)/1000;
    if Edges[a].eC>0 then ImZ:=ImZ-1000000/(Omega*Edges[a].eC);
    //if Edges[a].IUSrc=1 then ReZ:=ReZ+1/inf;
    if Edges[a].IISrc=1 then begin
      sinf:=sin(Edges[a].IISPhase*PI/180);
      cosf:=cos(Edges[a].IISPhase*PI/180);
      MJ.Body[1,a]:=Edges[a].IISAmp;
      MJ.Comp[1,a] := Compl(Edges[a].IISAmp*cosf, Edges[a].IISAmp*sinf);
    end;
    ToAdd:=sqrt(ReZ*ReZ+ImZ*ImZ);
    if not Edges[a].Enabled then begin
      ToAdd:=inf;
      ReZ:=inf;
      ImZ:=inf;
    end;
    MZ.Body[a,a]:=ToAdd;
    MZ.Comp[a,a]:=Compl(ReZ, ImZ);
     if ToAdd=0 then begin
      MY.Body[a,a]:=inf;
      MY.Comp[a,a]:=Compl(inf,inf);
      end else begin
        MY.Body[a,a]:=1/(ToAdd);
        MY.Comp[a,a]:=ComplDiv(Compl(1,0), Compl(ReZ, ImZ));
      end;
    if (ToAdd=0) and (Edges[a].IISrc=1) then begin
      MZ.Body[a,a]:=inf;
      MZ.Comp[a,a]:=Compl(inf,inf);
      MY.Body[a,a]:=0;
      MY.Comp[a,a]:=Compl(1/inf,0);
    end;
    if not Edges[a].Enabled then begin
      MY.Body[a,a]:=0;
      MY.Comp[a,a]:=Compl(1/inf,0);
    end;
    if Edges[a].IUSrc=1 then begin
      sinf:=sin(Edges[a].IUSPhase*PI/180);
      cosf:=cos(Edges[a].IUSPhase*PI/180);
      ME.Body[1,a]:=Edges[a].IUSAmp;
      ME.Comp[1,a]:=Compl(Edges[a].IUSAmp*cosf, Edges[a].IUSAmp*sinf);
      //MZ.Comp[a,a]:=Compl(1/inf,0);
    end;
  end;
end;

function TGraph.SubTreeVertices(Vertice: word; Way: Path): Path;  //returns vertices of separated tree
var a,b,c:byte;
EdgesN: byte; //count of edges connected to Vertice
LnID,LnID2: byte;   //current line ID
VertID: byte;
WayOp, WayOp2: Path;
IsRepeat: boolean;
begin
  WayOp:=Way;
  EdgesN:=Vertices[Vertice].Degree;
  if WayOp[0,0]=0 then begin
    inc(WayOp[0,0]);
    b:=WayOp[0,0];
    WayOp[0,b]:=Vertice;
  end;
  b:=WayOp[0,0];
  for a:=1 to EdgesN do begin   //searching for every vertice/edge connected to input vertice
    LnID:=Vertices[Vertice].LineID[a];
    if (Edges[LnID].IsTree) and (Edges[LnID].Enabled) then begin
      if Edges[LnID].side1=Vertice then
        VertID:=Edges[LnID].side2 else
          VertID:=Edges[LnID].side1;    //here we found another Vertice ID!
      //if VertID=3 then inc (WayOp[0,8]);
      IsRepeat:=false;
      for c:=1 to b do
        if (WayOp[0,c]=VertID) then IsRepeat:=true;
      if not IsRepeat then begin
        inc(WayOp[0,0]);
        b:=WayOp[0,0];
        WayOp[0,b]:=VertID;
        WayOp2:=WayOp;
        WayOp:=SubTreeVertices(VertID, WayOp2);
        b:=WayOp[0,0];
        //exit;
      end;
    end;
  end;
  Result:=WayOp;
end;

function TGraph.FindCut(EdgeNum: word): Path;
//output format: [0,0]=number of edges; [0,1..N]=edges; [1,1..N]: 1 if edge is going INTO .side1 of tree edge
var Vert1, Vert2, a, b, c, tr1, tr2: integer;
CutArr: Path;
Way, WayOp: Path;
N1, N2: Path;      //N1=number of tree vertices from .side1 of cut edge. N2 - from .side2
TrueSide: integer;
begin
  CutArr[0,0]:=1;
  b:=1;
  CutArr[0,1]:=EdgeNum;
  CutArr[1,1]:=1;
  if Edges[EdgeNum].IsTree then begin
    for c:=0 to 20 do begin
      WayOp[1,c]:=0;
      WayOp[0,c]:=0;
    end;
    Edges[EdgeNum].Enabled:=false;
    N1:=SubTreeVertices(Edges[EdgeNum].side1, WayOp);
    N2:=SubTreeVertices(Edges[EdgeNum].side2, WayOp);
    for a:=1 to EdgeCount do begin
      if not Edges[a].IsTree then begin
        Vert1:=Edges[a].side1;
        Vert2:=Edges[a].side2;
        for c:=0 to 20 do begin
          Way[1,c]:=0;
          Way[0,c]:=0;
        end;
        Way:=FindWay(Vert1, Vert2, 1, WayOp);
        if Way[1,0]<>55 then begin
                   //=if this edge connects separated parts of the tree
          inc(CutArr[0,0]);
          b:=CutArr[0,0];
          CutArr[0,b]:=a;
          TrueSide:=-1;
          for tr1:=1 to N1[0,0] do
            if N1[0,tr1]=Vert1 then TrueSide:=1;
          CutArr[1,b]:=TrueSide;
        end;
      end;
    end;
    Result:=CutArr;
    Edges[EdgeNum].Enabled:=true;
  end;
end;

function TGraph.FindCycle(EdgeNum: word): Path;
//result format: [0,0]=vertice/edge count. [0,1..N]=vertices from side1 to side2
                                         //[1,1..N]=edges in same order. side1-side2 is last
var Vertice1, Vertice2: integer;
Way, WayOp: Path;
a,b: byte;
begin
  for a:=0 to 1 do
    for b:=0 to 20 do begin
      Way[a,b]:=0;
      WayOp[a,b]:=0;
    end;
  Vertice1:=Edges[EdgeNum].side1;
  Vertice2:=Edges[EdgeNum].side2;
  Way:=FindWay(Vertice1, Vertice2, 1, WayOp);
  Way[1,Way[0,0]]:=EdgeNum;
  Result:=Way;
end;

function TGraph.FindWay(Vertice1, Vertice2: integer; Method: byte; Way: Path):Path;
//Way structure: [0,0] = way length(initially 0); [0,1..Way[0]] = Vertices
//               [1,0] = found/not found (1/0)    [1,1..Way[0]-1] = Edges
//Input Way[0,0] must be 0
//!!!never assign this function's out value (aka Result) to the same :Path as last parameter!!!
var a,b,c:byte;
EdgesN: byte; //count of edges connected to Vertice1
LnID: byte;   //current line ID
VertID: byte;
AllowEdge, NoRepeat: boolean;
WayOp:Path;
begin
//WayOp[0,5]:=55;
  //Result:=WayOp;
  WayOp:=Way;
  EdgesN:=Vertices[Vertice1].Degree;
  inc(WayOp[0,0]);
  b:=WayOp[0,0];
  WayOp[0,b]:=Vertice1;
  for a:=1 to EdgesN do begin   //searching for every vertice/edge connected to start vert.
    LnID:=Vertices[Vertice1].LineID[a];
    AllowEdge:=false;
    case Method of
      0: AllowEdge:=true;
      1: if (Edges[LnID].IsTree) and (Edges[LnID].Enabled) then AllowEdge:=true;
      2: if Edges[LnID].Enabled then AllowEdge:=true;
    end;
    if AllowEdge then begin
      if Edges[LnID].side1=Vertice1 then
        VertID:=Edges[LnID].side2 else
          if Edges[LnID].side2=Vertice1 then VertID:=Edges[LnID].side1;        //next vertice ID
      NoRepeat:=true;
      for c:=1 to b-1 do
        if (VertID=WayOp[0,c]) then NoRepeat:=false;
      if NoRepeat then begin
        WayOp[1,b]:=LnID;
        if VertID = Vertice2 then begin
          WayOp[0,b+1]:=Vertice2;
          inc(WayOp[0,0]);
          WayOp[1,0]:=55;
          Result:=WayOp;
          exit;
        end else begin
          Result:=FindWay(VertID, Vertice2, Method, WayOp);
          if Result[1,0]=55 then exit;
        end;
      end;
    end;
  end;
 // for a:=0 to 20 do
//    for b:=0 to 1 do
//      WayOp[b,a]:=0;
 // Result:=WayOp;

end;

procedure TGraph.FindTree (Vertice, Found:integer);   //"Found" is for recursion
var a,b,c:byte;
EdgesN: byte; //count of edges connected to Vertice
LnID,LnID2: byte;   //current line ID
VertID: byte;
Wood: boolean;
begin
  EdgesN:=Vertices[Vertice].Degree;
  for a:=1 to EdgesN do begin   //searching for every vertice/edge connected to input vertice
    LnID:=Vertices[Vertice].LineID[a];
    if Edges[LnID].side1=Vertice then
      VertID:=Edges[LnID].side2 else
        VertID:=Edges[LnID].side1;    //here we found another Vertice ID!
    Wood:=false;
    for b:=1 to Vertices[VertID].Degree do begin  //checking if any of the edges around VertID belongs to tree or not
      LnID2:=Vertices[VertID].LineID[b];
      if (Edges[LnID2].IsTree) then Wood:=true;
    end;
    if Wood=false then begin
      Edges[LnID].IsTree:=true;
      if (Found+1)=(VerticeCount-1) then //if all of tree's edges were found
        exit else
          FindTree(VertID, Found+1);
    end;
  end;  //tree has been found
end;

procedure TGraph.DefineVertices;
var a,c:integer;
begin
  for a:=1 to 100 do
    Vertices[a]:= TVertice.Create;

  for a:=1 to VerticeCount do
    Vertices[a].ID:=a;
    
  for a:=1 to EdgeCount do begin
    if Edges[a].side1>0 then begin
      c:=Edges[a].side1;    //c = ID of vertice that we are dealign with
      inc(Vertices[c].Degree);
      Vertices[c].LineID[Vertices[c].Degree]:=a; //adds current edgeID to the end of array with lineIDs
    end;

    if Edges[a].side2>0 then begin
      c:=Edges[a].side2;    //c = ID of vertice that we are dealign with
      inc(Vertices[c].Degree);
      Vertices[c].LineID[Vertices[c].Degree]:=a; //adds current edgeID to the end of array with lineIDs
    end;
  end;  
end;

procedure TGraph.GenRandomGraph(NumVertices, NumEdges: integer);
var a:integer;
begin
  randomize;
  for a:=1 to NumEdges do begin
    Edges[a].IsTree:=false;
    Edges[a].ID:=a;
    Edges[a].side1:=1+round(random(NumVertices));
    Edges[a].side2:=1+round(random(NumVertices));
    if Edges[a].side1=Edges[a].side2 then
      if Edges[a].side2=NumVertices then
        Edges[a].side2:=1 else inc(Edges[a].side2);

    Edges[a].eR:=round(random(20));
    Edges[a].eL:=round(random(20));
    Edges[a].eC:=round(random(20));
    //Edges[a].ISrc:=round(random(3));
    //Edges[a].ISPhase:=round(random(100));
    //Edges[a].ISAmp:=round(random(10));
    Edges[a].DSrc:=round(random(3));
    Edges[a].DSCoef:=random;
    Edges[a].DSEdge:=1+round(random(3));
    Edges[a].DSIn:=1+round(random(2));
  end;
  DefineVertices;
end;

procedure TGraph.DrawGraph;
var a:integer;
begin
  Form1.Image1.Canvas.Font.Color:=clblue;
  Form1.Image1.Canvas.Brush.Color:=clwhite;
  Form1.Image1.Canvas.FillRect(Form1.Image1.Canvas.cliprect);
  for a:=1 to EdgeCount do
    DrawEdge(a);

  Form1.Image1.Canvas.Pen.Color:=clblack;
  Form1.Image1.Canvas.Brush.Color:=clred;
  for a:=1 to VerticeCount do
    Form1.Image1.Canvas.Ellipse(VerticeXY[a].X+5, VerticeXY[a].Y+5, VerticeXY[a].X-5, VerticeXY[a].Y-5);

  Form1.Image1.Canvas.Font.Color:=clblack;
  Form1.Image1.Canvas.Brush.Color:=clwhite;
  for a:=1 to VerticeCount do
    Form1.Image1.Canvas.TextOut(VerticeXY[a].X-5, VerticeXY[a].Y-20, inttostr(a));
  end;

procedure TGraph.GenVerticeXY;
var a,Radx, Rady:integer;
    Degree: real;
begin
  Degree:=2*pi/VerticeCount; //degree step
  Radx:=Center.X-20;
  Rady:=Center.Y-20;
  //Rad:=round(min(Center.X, Center.Y)*0.9);
  for a:=1 to VerticeCount do begin
    VerticeXY[a].X:=Center.X+round(sin(Degree*(a-1))*Radx);
    VerticeXY[a].Y:=Center.Y-round(cos(Degree*(a-1))*Rady);
  end;
end;

function TGraph.EdgeElemCount(EdgeNum: integer) : integer;
  var ElemCount: integer;
begin
  ElemCount:=0;
  if Edges[EdgeNum].eR>0 then inc (ElemCount);
  if Edges[EdgeNum].eL>0 then inc (ElemCount);
  if Edges[EdgeNum].eC>0 then inc (ElemCount);
  if (Edges[EdgeNum].IISrc>0)and(Edges[EdgeNum].DSrc=0) then inc (ElemCount);
  if (Edges[EdgeNum].IUSrc>0)and(Edges[EdgeNum].DSrc=0) then inc (ElemCount);
  if Edges[EdgeNum].DSrc>0 then inc (ElemCount);
  Result:=ElemCount;
end;

procedure TGraph.DrawEdge(EdgeNum: integer);
var ElemCount, Drawn: integer;
    x1,x2,y1,y2:integer; //vertices' coordinates
    dx,dy:integer;
    Axis:TPoint;
begin
  Drawn:=0;
  ElemCount:=EdgeElemCount(EdgeNum);
  if Edges[EdgeNum].IsTree then
    Form1.Image1.Canvas.Pen.Width:=4 else Form1.Image1.Canvas.Pen.Width:=2;

  dx:=VerticeXY[Edges[EdgeNum].side2].X-VerticeXY[Edges[EdgeNum].side1].X; //dx between vertices
  dy:=VerticeXY[Edges[EdgeNum].side2].y-VerticeXY[Edges[EdgeNum].side1].y; //dy between vertices

  //here comes EDGE NUMBER

  if Edges[EdgeNum].eR>0 then begin
    inc (Drawn);
    x1:=VerticeXY[Edges[EdgeNum].side1].X+round(dx*(Drawn-1)/ElemCount);
    x2:=VerticeXY[Edges[EdgeNum].side1].X+round(dx*Drawn/ElemCount);
    y1:=VerticeXY[Edges[EdgeNum].side1].Y+round(dy*(Drawn-1)/ElemCount);
    y2:=VerticeXY[Edges[EdgeNum].side1].Y+round(dy*Drawn/ElemCount);
    if (ObjectClicked=EdgeNum) and (ElemClicked=1) then
      DrawElem(x1,y1,x2,y2, 1, clred) //1 means R
      else DrawElem(x1,y1,x2,y2, 1);
    Axis.X:=round((x1+x2)/2);
    Axis.Y:=round((y1+y2)/2);
    ElemXY[EdgeNum,1]:=Axis;
  end;

  if Edges[EdgeNum].eL>0 then begin
    inc (Drawn);
    x1:=VerticeXY[Edges[EdgeNum].side1].X+round(dx*(Drawn-1)/ElemCount);
    x2:=VerticeXY[Edges[EdgeNum].side1].X+round(dx*Drawn/ElemCount);
    y1:=VerticeXY[Edges[EdgeNum].side1].Y+round(dy*(Drawn-1)/ElemCount);
    y2:=VerticeXY[Edges[EdgeNum].side1].Y+round(dy*Drawn/ElemCount);
    if (ObjectClicked=EdgeNum) and (ElemClicked=2) then
      DrawElem(x1,y1,x2,y2, 2, clred) //2 means L
      else DrawElem(x1,y1,x2,y2, 2);
    Axis.X:=round((x1+x2)/2);
    Axis.Y:=round((y1+y2)/2);
    ElemXY[EdgeNum,2]:=Axis;
  end;

  if Edges[EdgeNum].eC>0 then begin
    inc (Drawn);
    x1:=VerticeXY[Edges[EdgeNum].side1].X+round(dx*(Drawn-1)/ElemCount);
    x2:=VerticeXY[Edges[EdgeNum].side1].X+round(dx*Drawn/ElemCount);
    y1:=VerticeXY[Edges[EdgeNum].side1].Y+round(dy*(Drawn-1)/ElemCount);
    y2:=VerticeXY[Edges[EdgeNum].side1].Y+round(dy*Drawn/ElemCount);
    if (ObjectClicked=EdgeNum) and (ElemClicked=3) then
      DrawElem(x1,y1,x2,y2, 3, clred) //3 means C
      else DrawElem(x1,y1,x2,y2, 3);
    Axis.X:=round((x1+x2)/2);
    Axis.Y:=round((y1+y2)/2);
    ElemXY[EdgeNum,3]:=Axis;
  end;

  if (Edges[EdgeNum].IISrc>0)and(Edges[EdgeNum].DSrc=0) then begin
    inc (Drawn);
    x1:=VerticeXY[Edges[EdgeNum].side1].X+round(dx*(Drawn-1)/ElemCount);
    x2:=VerticeXY[Edges[EdgeNum].side1].X+round(dx*Drawn/ElemCount);
    y1:=VerticeXY[Edges[EdgeNum].side1].Y+round(dy*(Drawn-1)/ElemCount);
    y2:=VerticeXY[Edges[EdgeNum].side1].Y+round(dy*Drawn/ElemCount);
    if (ObjectClicked=EdgeNum) and (ElemClicked=4) then
      DrawElem(x1,y1,x2,y2, 4, clred) //3 means C
      else DrawElem(x1,y1,x2,y2, 4);
    Axis.X:=round((x1+x2)/2);
    Axis.Y:=round((y1+y2)/2);
    ElemXY[EdgeNum,4]:=Axis;
  end;

  if (Edges[EdgeNum].IUSrc>0)and(Edges[EdgeNum].DSrc=0) then begin
    inc (Drawn);
    x1:=VerticeXY[Edges[EdgeNum].side1].X+round(dx*(Drawn-1)/ElemCount);
    x2:=VerticeXY[Edges[EdgeNum].side1].X+round(dx*Drawn/ElemCount);
    y1:=VerticeXY[Edges[EdgeNum].side1].Y+round(dy*(Drawn-1)/ElemCount);
    y2:=VerticeXY[Edges[EdgeNum].side1].Y+round(dy*Drawn/ElemCount);
    if (ObjectClicked=EdgeNum) and (ElemClicked=5) then
      DrawElem(x2,y2,x1,y1, 5, clred) //3 means C
      else DrawElem(x2,y2,x1,y1, 5);
    Axis.X:=round((x1+x2)/2);
    Axis.Y:=round((y1+y2)/2);
    ElemXY[EdgeNum,5]:=Axis;
  end;

  if Edges[EdgeNum].DSrc>0 then begin
    inc (Drawn);
    x1:=VerticeXY[Edges[EdgeNum].side1].X+round(dx*(Drawn-1)/ElemCount);
    x2:=VerticeXY[Edges[EdgeNum].side1].X+round(dx*Drawn/ElemCount);
    y1:=VerticeXY[Edges[EdgeNum].side1].Y+round(dy*(Drawn-1)/ElemCount);
    y2:=VerticeXY[Edges[EdgeNum].side1].Y+round(dy*Drawn/ElemCount);
    if (ObjectClicked=EdgeNum) and ((ElemClicked=6)or(ElemClicked=7)) then
      case Edges[EdgeNum].DSrc of
        1: DrawElem(x1,y1,x2,y2, 6, clred);
        2: DrawElem(x2,y2,x1,y1, 7, clred);
      end else
      case Edges[EdgeNum].DSrc of
        1: DrawElem(x1,y1,x2,y2, 6);
        2: DrawElem(x2,y2,x1,y1, 7);
      end;
    Axis.X:=round((x1+x2)/2);
    Axis.Y:=round((y1+y2)/2);
    ElemXY[EdgeNum,5+Edges[EdgeNum].DSrc]:=Axis;
  end;
  Form1.Image1.Canvas.TextOut(round(5+VerticeXY[Edges[EdgeNum].side1].X+dx/2),round(5+VerticeXY[Edges[EdgeNum].side1].Y+dy/2),inttostr(EdgeNum));
end;

procedure TGraph.DrawElem (x1, y1, x2, y2, elem: integer; color:TColor=clblack); //elem: 1=R; 2=L; 3=C;
                                                    //      4=IS(I); 5=IS(U);
                                                    //      6=DS(I); 7=DS(U);
var size, qlength, dx, dy, Rad: integer;
    sinf,cosf: real;
    AB,CD, A,B,C,D,E,F, Axis: TPoint;
begin
  Form1.Image1.Canvas.Pen.Color:=color;
  qlength:=round(sqrt((x1-x2)*(x1-x2)+(y1-y2)*(y1-y2)));   //allowed length for drawing
  size:=min(20, round(qlength/3));

  dx:=x2-x1;
  dy:=y2-y1;
  if qlength=0 then qlength:=1; //preventing div by zero
  sinf:=dx/qlength;
  cosf:=dy/qlength;
  Axis.X:=round((x1+x2)/2);
  Axis.Y:=round((y1+y2)/2);

  if elem=1 then begin               //R
    CD.X:=Axis.X+round(size*sinf);
    CD.Y:=Axis.Y+round(size*cosf);

    D.X:=CD.X-round(size/2*cosf);
    D.Y:=CD.Y+round(size/2*sinf);
    C.X:=CD.X+round(size/2*cosf);
    C.Y:=CD.Y-round(size/2*sinf);

    AB.X:=Axis.X-round(size*sinf);
    AB.Y:=Axis.Y-round(size*cosf);

    A.X:=AB.X-round(size/2*cosf);
    A.Y:=AB.Y+round(size/2*sinf);
    B.X:=AB.X+round(size/2*cosf);
    B.Y:=AB.Y-round(size/2*sinf);

    Form1.Image1.Canvas.Polyline([A,B,C,D,A]);
    Form1.Image1.Canvas.Polyline([Point(x1,y1),AB]);
    Form1.Image1.Canvas.Polyline([Point(x2,y2),CD]);
  end;

  if elem=2 then begin      //2 = L!!
    Rad:=round(size/3);
    B:=Axis;

    A.X:=B.X-round(2*Rad*sinf);
    A.Y:=B.Y-round(2*Rad*cosf);
    C.X:=B.X+round(2*Rad*sinf);
    C.Y:=B.Y+round(2*Rad*cosf);

    Form1.Image1.Canvas.Arc(A.X-Rad-1, A.Y-Rad-1, A.X+Rad+1, A.Y+Rad+1, x1, y1, x2, y2);
    Form1.Image1.Canvas.Arc(B.X-Rad-1, B.Y-Rad-1, B.X+Rad+1, B.Y+Rad+1, x1, y1, x2, y2);
    Form1.Image1.Canvas.Arc(C.X-Rad-1, C.Y-Rad-1, C.X+Rad+1, C.Y+Rad+1, x1, y1, x2, y2);

    E.X:=A.X-round(Rad*sinf);         //x1, y1 connection
    E.Y:=A.Y-round(Rad*cosf);
    F.X:=C.X+round(Rad*sinf);         //x2, y2 connection
    F.Y:=C.Y+round(Rad*cosf);

    Form1.Image1.Canvas.Polyline([Point(x1,y1),E]);
    Form1.Image1.Canvas.Polyline([Point(x2,y2),F]);
  end;

  if elem=3 then begin      //3 => C !
    CD.X:=Axis.X+round(sinf*size/6);
    CD.Y:=Axis.Y+round(cosf*size/6);

    C.X:=CD.X+round(cosf*size/1.2);
    C.Y:=CD.Y-round(sinf*size/1.2);
    D.X:=CD.X-round(cosf*size/1.2);
    D.Y:=CD.Y+round(sinf*size/1.2);

    AB.X:=Axis.X-round(sinf*size/6);
    AB.Y:=Axis.Y-round(cosf*size/6);

    B.X:=AB.X+round(cosf*size/1.2);
    B.Y:=AB.Y-round(sinf*size/1.2);
    A.X:=AB.X-round(cosf*size/1.2);
    A.Y:=AB.Y+round(sinf*size/1.2);

    Form1.Image1.Canvas.Polyline([A,B]);
    Form1.Image1.Canvas.Polyline([C,D]);
    Form1.Image1.Canvas.Polyline([Point(x1,y1),AB]);
    Form1.Image1.Canvas.Polyline([Point(x2,y2),CD]);
  end;

  if elem=4 then begin //4 for IS(I)
  //sinf:=dy/qlength;
  //cosf:=dx/qlength;

    E:=Axis;
    A.X:=Axis.X-round(cosf*size*0.4);
    A.Y:=Axis.Y+round(sinf*size*0.4);
    B.X:=Axis.X-round(sinf*size*0.3);
    B.Y:=Axis.Y-round(cosf*size*0.3);
    C.X:=Axis.X+round(cosf*size*0.4);
    C.Y:=Axis.Y-round(sinf*size*0.4);
    CD.X:=Axis.X+round(sinf*size*0.3);  //"CD" is between D and F
    CD.Y:=Axis.Y+round(cosf*size*0.3);
    D.X:=CD.X-round(cosf*size*0.4);
    D.Y:=CD.Y+round(sinf*size*0.4);
    F.X:=CD.X+round(cosf*size*0.4);
    F.Y:=CD.Y-round(sinf*size*0.4);

    Form1.Image1.Canvas.Arc(Axis.X-size, Axis.Y-size, Axis.X+size, Axis.Y+size,x1,y1,x1,y1);
    Form1.Image1.Canvas.Polyline([A,B,C]);
    Form1.Image1.Canvas.Polyline([D,E,F]);
    Form1.Image1.Canvas.Polyline([Point(x1,y1),Point(Axis.X-round(size*sinf*0.9),Axis.Y-round(size*cosf*0.9))]);
    Form1.Image1.Canvas.Polyline([Point(x2,y2),Point(Axis.X+round(size*sinf*0.9),Axis.Y+round(size*cosf*0.9))]);
  end;

  if elem=5 then begin   //5 for IS(U)
    A.X:=Axis.X-round(size*0.6*sinf);
    A.Y:=Axis.Y-round(size*0.6*cosf);
    B.X:=Axis.X+round(size*0.6*sinf);
    B.Y:=Axis.Y+round(size*0.6*cosf);
    CD.X:=Axis.X-round(size*0.15*sinf);
    CD.Y:=Axis.Y-round(size*0.15*cosf);
    C.X:=CD.X-round(size*0.25*cosf);
    C.Y:=CD.Y+round(size*0.25*sinf);
    D.X:=CD.X+round(size*0.25*cosf);
    D.Y:=CD.Y-round(size*0.25*sinf);

    Form1.Image1.Canvas.Arc(Axis.X-size, Axis.Y-size, Axis.X+size, Axis.Y+size,x1,y1,x1,y1);
    Form1.Image1.Canvas.Polyline([Point(x1,y1),Point(Axis.X-round(size*sinf*0.9),Axis.Y-round(size*cosf*0.9))]);
    Form1.Image1.Canvas.Polyline([Point(x2,y2),Point(Axis.X+round(size*sinf*0.9),Axis.Y+round(size*cosf*0.9))]);
    Form1.Image1.Canvas.Polyline([B,A,C,A,D]);
  end;

  if (elem=6) or (elem=7) then begin //6,7 for DS
    C.X:=Axis.X-round(size*sinf);
    C.Y:=Axis.Y-round(size*cosf);
    A.X:=Axis.X+round(size*sinf);
    A.Y:=Axis.Y+round(size*cosf);
    B.X:=Axis.X+round(size*0.7*cosf);
    B.Y:=Axis.Y-round(size*0.7*sinf);
    D.X:=Axis.X-round(size*0.7*cosf);
    D.Y:=Axis.Y+round(size*0.7*sinf);
    Form1.Image1.Canvas.Polyline([Point(x1,y1),C,B,A,D,C]);
    Form1.Image1.Canvas.Polyline([Point(x2,y2),A]);
  end;

  if elem=6 then begin
    E:=Axis;
    A.X:=Axis.X-round(cosf*size*0.3);
    A.Y:=Axis.Y+round(sinf*size*0.3);
    B.X:=Axis.X-round(sinf*size*0.2);
    B.Y:=Axis.Y-round(cosf*size*0.2);
    C.X:=Axis.X+round(cosf*size*0.3);
    C.Y:=Axis.Y-round(sinf*size*0.3);
    CD.X:=Axis.X+round(sinf*size*0.2);  //"CD" is between D and F
    CD.Y:=Axis.Y+round(cosf*size*0.2);
    D.X:=CD.X-round(cosf*size*0.3);
    D.Y:=CD.Y+round(sinf*size*0.3);
    F.X:=CD.X+round(cosf*size*0.3);
    F.Y:=CD.Y-round(sinf*size*0.3);
    Form1.Image1.Canvas.Polyline([A,B,C]);
    Form1.Image1.Canvas.Polyline([D,E,F]);
  end;

  if elem=7 then begin
    A.X:=Axis.X-round(size*0.5*sinf);
    A.Y:=Axis.Y-round(size*0.5*cosf);
    B.X:=Axis.X+round(size*0.5*sinf);
    B.Y:=Axis.Y+round(size*0.5*cosf);
    CD.X:=Axis.X-round(size*0.12*sinf);
    CD.Y:=Axis.Y-round(size*0.12*cosf);
    C.X:=CD.X-round(size*0.2*cosf);
    C.Y:=CD.Y+round(size*0.2*sinf);
    D.X:=CD.X+round(size*0.2*cosf);
    D.Y:=CD.Y-round(size*0.2*sinf);

    Form1.Image1.Canvas.Polyline([B,A,C,A,D]);

  end;

end;

function TGraph.ObjClicked (X, Y: integer; Out ObjectID, ElemID: integer) : integer;
var a, b, distance:integer;
begin
  distance:=15;
  Result:=0;
  ObjectID:=0;
  ElemID:=0;
  for a:=1 to VerticeCount do
    if (abs(X-VerticeXY[a].X)<distance) and (abs(Y-VerticeXY[a].Y)<distance) then begin
      ObjectID:=a;
      Result:=2;     //2=> Vertice
      exit;
    end;

  for a:=1 to EdgeCount do
    for b:=1 to 7 do
      if (abs(X-ElemXY[a,b].X)<distance) and (abs(Y-ElemXY[a,b].Y)<distance) then begin
        ObjectID:=a;
        ElemID:=b;
        Result:=1;      //1 => EDge
        exit;
      end;

end;

procedure TForm1.FormCreate(Sender: TObject);
begin
  locale:='enGB';
  ObjectClicked:=0;         //0=none, 1=Egde, 2=Vertice
  Center.X:=round(Image1.Width/2);
  Center.Y:=round(Image1.Height/2);
  Form1.Image1.Canvas.Pen.Width:=2;
  Form1.Image1.Canvas.Font.Style:= [fsbold];

  Graph:=TGraph.Create;
end;

procedure TForm1.Image1MouseDown(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
  var ObjParamName:array[1..4] of string; //1=name, 2=value, 3=phase/"beta"/"delta", 4=dependance
      a,b:integer;
begin
  for a:=1 to 4 do ObjParamName[a]:='';
  MouseState:=1;
  a:=Graph.ObjClicked(X, Y, ObjectClicked, ElemClicked);
  Graph.DrawGraph;
  ValueListEditor1.Strings.Clear;
  case ElemClicked of
    0: begin
      if a=2 then begin
        ValueListEditor1.InsertRow('Object','Vertice',true);
        ValueListEditor1.InsertRow('Number',inttostr(ObjectClicked),true);
        ObjParamName[1]:=inttostr(Graph.Vertices[ObjectClicked].Degree)+' (';
        if Graph.Vertices[ObjectClicked].Degree>0 then
          for b:=1 to Graph.Vertices[ObjectClicked].Degree do
            ObjParamName[1]:=ObjParamName[1]+inttostr(Graph.Vertices[ObjectClicked].LineID[b])+', ';
        ObjParamName[1]:=ObjParamName[1]+')';
        ValueListEditor1.InsertRow('Edges', ObjParamName[1], true)
      end;
    end;

    1: begin
      ObjParamName[1]:='Resistor';
      ObjParamName[2]:='Resistance, Ohm';
      ValueListEditor1.InsertRow('Object',ObjParamName[1],true);
      ValueListEditor1.InsertRow(ObjParamName[2],floattostr(Graph.Edges[ObjectClicked].eR),true);
      ValueListEditor1.InsertRow('Edge №',inttostr(Graph.Edges[ObjectClicked].ID),true);
    end;
    2: begin
      ObjParamName[1]:='Coil';
      ObjParamName[2]:='Inductance, mH';
      ValueListEditor1.InsertRow('Object',ObjParamName[1],true);
      ValueListEditor1.InsertRow(ObjParamName[2],inttostr(Graph.Edges[ObjectClicked].eL),true);
    end;
    3: begin
      ObjParamName[1]:='Condenser';
      ObjParamName[2]:='Capacitance, uF';
      ValueListEditor1.InsertRow('Object',ObjParamName[1],true);
      ValueListEditor1.InsertRow(ObjParamName[2],inttostr(Graph.Edges[ObjectClicked].eC),true);
    end;
    4: begin
      ObjParamName[1]:='Ideal current source';
      ObjParamName[2]:='Amplitude, A';
      ObjParamName[3]:='Phase, degrees';
      ValueListEditor1.InsertRow('Object',ObjParamName[1],true);
      ValueListEditor1.InsertRow(ObjParamName[2],floattostr(Graph.Edges[ObjectClicked].IISAmp*sqrt(2)),true);
      ValueListEditor1.InsertRow('RMS, A',floattostr(Graph.Edges[ObjectClicked].IISAmp),true);
      ValueListEditor1.InsertRow(ObjParamName[3],floattostr(Graph.Edges[ObjectClicked].IISPhase),true);
    end;
    5: begin
      ObjParamName[1]:='Ideal voltage source';
      ObjParamName[2]:='Amplitude, V';
      ObjParamName[3]:='Phase, degrees';
      ValueListEditor1.InsertRow('Object',ObjParamName[1],true);
      ValueListEditor1.InsertRow(ObjParamName[2],floattostr(Graph.Edges[ObjectClicked].IUSAmp*sqrt(2)),true);
      ValueListEditor1.InsertRow('RMS, V',floattostr(Graph.Edges[ObjectClicked].IUSAmp),true);
      ValueListEditor1.InsertRow(ObjParamName[3],floattostr(Graph.Edges[ObjectClicked].IUSPhase),true);
    end;
    6: begin
      ObjParamName[1]:='Dependent current source';
      ObjParamName[2]:='Depends on';
      if Graph.Edges[ObjectClicked].DSIn=2 then ObjParamName[3]:='Transconductance, S' else
        ObjParamName[3]:='Proportionality constant';
      case Graph.Edges[ObjectClicked].DSIn of
        1: ObjParamName[4]:='Current of edge № '+inttostr(Graph.Edges[ObjectClicked].DSEdge);
        2: ObjParamName[4]:='Voltage of edge № '+inttostr(Graph.Edges[ObjectClicked].DSEdge);
      end;
      ValueListEditor1.InsertRow('Object',ObjParamName[1],true);
      ValueListEditor1.InsertRow(ObjParamName[2],ObjParamName[4],true);
      ValueListEditor1.InsertRow(ObjParamName[3],floattostrf(Graph.Edges[ObjectClicked].DSCoef,ffGeneral,2,2),true);
      ValueListEditor1.InsertRow('Amplitude, A',floattostr(Graph.Edges[ObjectClicked].IISAmp*sqrt(2)),true);
      ValueListEditor1.InsertRow('RMS, A',floattostr(Graph.Edges[ObjectClicked].IISAmp),true);
      ValueListEditor1.InsertRow('Phase, deg', floattostr(Graph.Edges[ObjectClicked].IISPhase), true);
    end;
    7: begin
      ObjParamName[1]:='Dependent voltage source';
      ObjParamName[2]:='Depends on';
      if Graph.Edges[ObjectClicked].DSIn=1 then ObjParamName[3]:='Transresistance, Ohm' else
        ObjParamName[3]:='Proportionality constant';
      case Graph.Edges[ObjectClicked].DSIn of
        1: ObjParamName[4]:='Current of edge № '+inttostr(Graph.Edges[ObjectClicked].DSEdge);
        2: ObjParamName[4]:='Voltage of edge № '+inttostr(Graph.Edges[ObjectClicked].DSEdge);
      end;
      ValueListEditor1.InsertRow('Object',ObjParamName[1],true);
      ValueListEditor1.InsertRow(ObjParamName[2],ObjParamName[4],true);
      ValueListEditor1.InsertRow(ObjParamName[3],floattostrf(Graph.Edges[ObjectClicked].DSCoef,ffGeneral,2,2),true);
      ValueListEditor1.InsertRow('Amplitude, V',floattostr(Graph.Edges[ObjectClicked].IUSAmp*sqrt(2)),true);
      ValueListEditor1.InsertRow('RMS, V',floattostr(Graph.Edges[ObjectClicked].IUSAmp),true);
      ValueListEditor1.InsertRow('Phase, deg', floattostr(Graph.Edges[ObjectClicked].IUSPhase), true);
    end;
  end;

end;

procedure TForm1.Image1MouseUp(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
begin
  MouseState:=0;
  Graph.DrawGraph;
end;

procedure TForm1.Image1MouseMove(Sender: TObject; Shift: TShiftState; X,
  Y: Integer);
  var x1,y1:integer;
begin
  if (MouseState=1) and (ObjectClicked>0) and (ElemClicked=0) then begin
    X1:=X;
    Y1:=Y;
    if X<5 then X1:=5;
    if Y<5 then Y1:=5;
    if X>Image1.Width-5 then X1:=Image1.Width-5;
    if Y>Image1.Height-5 then Y1:=Image1.Height-5;
    Graph.VerticeXY[ObjectClicked]:=Point(X1,Y1);
  end;
  Graph.DrawGraph;

end;
procedure TForm1.Button1Click(Sender: TObject);
begin
  PrintMatrix(Graph.SDependentCut, true);
  if locale='enGB' then label1.Caption:='Сutset Analysis result';
  if locale='ruRU' then label1.Caption:='Результат по методу сечений';
end;

procedure TForm1.Button2Click(Sender: TObject);
begin
  Graph.CreateSelf(0);
  Graph.DefineVertices;
  Graph.FindTree(1,0);
  //Graph.EnumEdges;
  Graph.GenVerticeXY;
  Graph.VerticeXY[7].X:=round(Center.X / 0.55);
  Graph.VerticeXY[7].Y:=round(Center.Y / 1);
  Graph.VerticeXY[2].X:=round(Center.X / 9);
  Graph.VerticeXY[2].Y:=round(Center.Y / 1.05);
  Graph.VerticeXY[6].X:=round(Center.X / 1);
  Graph.VerticeXY[6].Y:=round(Center.Y / 0.55);
  Graph.VerticeXY[4].X:=round(Center.X);
  Graph.VerticeXY[4].Y:=round(Center.Y / 8);
  Graph.VerticeXY[5].X:=round(Center.X / 1);
  Graph.VerticeXY[5].Y:=round(Center.Y);
  Graph.VerticeXY[3].X:=round(Center.X / 10);
  Graph.VerticeXY[3].Y:=round(Center.Y / 0.55);
  Graph.VerticeXY[1].X:=round(Center.X / 10);
  Graph.VerticeXY[1].Y:=round(Center.Y / 10);
  Graph.DrawGraph;
  EnableButtons;
end;



procedure TForm1.Button4Click(Sender: TObject);
var a,b:integer;
begin
  if locale='enGB' then label1.Caption:='Loop Matrix';
  if locale='ruRU' then label1.Caption:='Матрица контуров';
  Graph.CreateMatrix;
  PrintMatrix(Graph.MCyc);

end;

procedure TForm1.Button5Click(Sender: TObject);
var a,b: integer;
begin
  Graph.CreateMatrix;
  PrintMatrix(Graph.MInc);
  if locale='enGB' then label1.Caption:='Incidence Matrix';
  if locale='ruRU' then label1.Caption:='Матрица инциденций';
end;

procedure TForm1.Button6Click(Sender: TObject);
var a,b: integer;
begin
  if locale='enGB' then label1.Caption:='Cutset Matrix';
  if locale='ruRU' then label1.Caption:='Матрица сечений';
  Graph.CreateMatrix;
  PrintMatrix(Graph.MCut);
end;


//floattostrf(Graph.Edges[ObjectClicked].DSCoef,ffGeneral,2,2)
procedure TForm1.Button8Click(Sender: TObject);
var a,b: integer;
begin
  PrintMatrix (Graph.SolveCut);
end;

procedure TForm1.Button9Click(Sender: TObject);
var a,b: integer;
begin
  Form2.show;
  Form2.Image1.Picture.LoadFromFile('img/img1.jpg');
  Form2.Image2.Picture.LoadFromFile('img/img2.jpg');
end;

procedure TForm1.Button10Click(Sender: TObject);
begin
  PrintMatrix(Graph.SDependentMesh, true);
  if locale='enGB' then label1.Caption:='Mesh Analysis result';
  if locale='ruRU' then label1.Caption:='Результат по методу сетки';
end;



procedure TForm1.Button12Click(Sender: TObject);
var a,b: integer;
begin
  if locale='enGB' then label1.Caption:='Mesh Matrix';
  if locale='ruRU' then label1.Caption:='Матрица сетки';
  Graph.CreateMatrix;
  PrintMatrix(Graph.MMesh);
end;

procedure TForm1.Button13Click(Sender: TObject);
begin
  if locale='enGB' then begin
    button15.Caption:='Задание';
    button13.Caption:='EN';
    Button9.Caption:='О программе';  //about
    GroupBox3.Caption:='Схема'; //load graph
    button2.Caption:='Из условия'; //from inside
    button26.Caption:='Из файла'; //from inpjt.txt
    button19.Caption:='Простая схема'; //simple scheme
    groupbox2.Caption:='Метод:'; //solve method
    button23.Caption:='МКТ'; //loop
    button21.Caption:='МУН'; //nodal voltage
    button1.Caption:='Метод сечений'; //cutset
    button10.Caption:='Сеточный'; //mesh current
    groupbox1.Caption:='Показать матрицу'; //show matrix
    button5.Caption:='Инциденц.'; //incidence
    button6.Caption:='Сечений'; //cut
    button4.Caption:='Контуров'; //loop
    button12.Caption:='Сетки'; //mesh
    Label3.Caption:='Параметры элемента'; //selected elems properties
    //label1.Caption:='Верхняя строка - токи в ветвях, нижняя - напряжения.'; //upper row is for current ...
    locale:='ruRU';
  end else begin
    button15.Caption:='View task';
    button13.Caption:='RU';
    Button9.Caption:='About';  //about
    GroupBox3.Caption:='Show graph'; //load graph
    button2.Caption:='From task'; //from inside
    button26.Caption:='From input.txt'; //from inpjt.txt
    button19.Caption:='Simple scheme'; //simple scheme
    groupbox2.Caption:='Solve method'; //solve method
    button23.Caption:='Loop'; //loop
    button21.Caption:='Nodal voltage'; //nodal voltage
    button1.Caption:='Cutset'; //cutset
    button10.Caption:='Mesh'; //mesh current
    groupbox1.Caption:='Show matrix'; //show matrix
    button5.Caption:='Incidence'; //incidence
    button6.Caption:='Cut'; //cut
    button4.Caption:='Loop'; //loop
    button12.Caption:='Mesh'; //mesh
    Label3.Caption:='Selected element properties'; //selected elems properties
    //label1.Caption:='Upper row shows currents in each branch, lower is for voltages.'; //upper row is for current ...
    locale:='enGB';
  end;


end;

procedure TForm1.Button14Click(Sender: TObject);
var a,b: integer;
begin
  if locale='enGB' then label1.Caption:='Impendance Matrix';
  if locale='ruRU' then label1.Caption:='Матрица сопротивлений';
  Graph.CreateMatrix;
  PrintMatrix(Graph.MZ);
end;
procedure TForm1.Button15Click(Sender: TObject);
begin
  Form3.show;
  Form3.Image1.Picture.LoadFromFile('img/task.jpg');
end;

procedure TForm1.Button16Click(Sender: TObject);
begin
  Form4.show;

end;

procedure TForm1.Button17Click(Sender: TObject);
begin
  if locale='enGB' then label1.Caption:='Сurrent Sources Matrix';
  if locale='ruRU' then label1.Caption:='Матрица источников тока';
  Graph.CreateMatrix;
  PrintMatrix(Graph.MJ);
end;

procedure TForm1.Button18Click(Sender: TObject);
begin
  if locale='enGB' then label1.Caption:='Voltage Sources Matrix';
  if locale='ruRU' then label1.Caption:='Матрица источников ЭДС';
  Graph.CreateMatrix;
  PrintMatrix(Graph.ME);

end;

procedure TForm1.Button19Click(Sender: TObject);
begin
  Graph.CreateSelf(2);
  Graph.DefineVertices;
  Graph.FindTree(1,0);
  Graph.GenVerticeXY;
  Graph.DrawGraph;
  EnableButtons;
end;

procedure TForm1.Button20Click(Sender: TObject);
begin
  Graph.SpreadCS(5);
end;

procedure TForm1.Button22Click(Sender: TObject);
begin
  if locale='enGB' then label1.Caption:='Conductance Matrix';
  if locale='ruRU' then label1.Caption:='Матрица проводимостей';
  Graph.CreateMatrix;
  PrintMatrix(Graph.MY);
end;

procedure TForm1.Button23Click(Sender: TObject);
begin
  PrintMatrix(Graph.SDependentMKT, true);
  if locale='enGB' then label1.Caption:='Loop Analysis result';
  if locale='ruRU' then label1.Caption:='Результат по методу контурных токов';
end;

procedure TForm1.Button21Click(Sender: TObject);
begin
  PrintMatrix(Graph.SDependentNVM, true);
  if locale='enGB' then label1.Caption:='Nodal Analysis result';
  if locale='ruRU' then label1.Caption:='Результат по методу узловых напряжений';
end;

procedure TForm1.Button24Click(Sender: TObject);
begin
  PrintMatrix(Graph.Solve, true);
end;

procedure TForm1.Button25Click(Sender: TObject);
begin
  PrintMatrix(Graph.SDependent, true);
end;

procedure TForm1.Button26Click(Sender: TObject);
begin
  Graph.CreateSelf(1);
  Graph.DefineVertices;
  Graph.FindTree(1,0);
//  Graph.EnumEdges;
  Graph.GenVerticeXY;
  Graph.DrawGraph;
  EnableButtons;
end;

procedure TForm1.Button3Click(Sender: TObject);
begin
  PrintMatrix (Graph.SolveMKT);
end;

procedure TForm1.Button7Click(Sender: TObject);
begin
  PrintMatrix (Graph.SolveNVM);
end;

procedure TForm1.Button11Click(Sender: TObject);
begin
  PrintMatrix(Graph.SolveMesh);
end;

end.
