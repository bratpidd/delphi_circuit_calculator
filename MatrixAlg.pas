unit MatrixAlg;

interface

uses ComplexAlg;

type

  Matrix = Record
    Body: Array[0..20, 0..20] of extended;
    Comp: Array[0..20, 0..20] of Complex;
    X: integer;    //X size = Col count
    Y: integer;    //Y size = Row count
  end;

  function ComplAlgExt (M: Matrix; Row, Col: integer): Complex;
  function ComplMultRowCol (MA, MB: Matrix; Row, Col: integer): Complex;
  function ComplMatrixDet (M: Matrix): Complex;
  function MatrixMultReal (M: Matrix; r: real): Matrix;
  function MultRowCol(MA, MB: Matrix; Row, Col: integer): real;
  function Transpose (M: Matrix): Matrix;
  function MatrixMult (MA, MB: Matrix): Matrix;
  function MatrixDet (M: Matrix): real;
  function MatrixAdj (M: Matrix): Matrix;
  function MatrixInverse (M: Matrix): Matrix;
  function MatrixSub (MA, MB: Matrix): Matrix;
  function MatrixAdd (MA, MB: Matrix): Matrix;
  function AlgExt (M: Matrix; Row, Col: integer): real;
  function ExcludeRowCol (M: Matrix; Row, Col: integer): Matrix;

implementation

function MatrixSub (MA, MB: Matrix): Matrix;
var
r,c: integer;
begin
  Result.X:=MA.X;
  Result.Y:=MA.Y;
  for c:=1 to MA.X do
    for r:=1 to MA.Y do begin
      Result.Comp[c,r]:=ComplSub(MA.Comp[c,r], MB.Comp[c,r]);
      Result.Body[c,r]:=MA.Body[c,r]-MB.Body[c,r];
    end;
end;

function MatrixAdd (MA, MB: Matrix): Matrix;
var
r,c: integer;
begin
  Result.X:=MA.X;
  Result.Y:=MA.Y;
  for c:=1 to MA.X do
    for r:=1 to MA.Y do begin
      Result.Comp[c,r]:=ComplAdd(MA.Comp[c,r], MB.Comp[c,r]);
      Result.Body[c,r]:=MA.Body[c,r]+MB.Body[c,r];
    end;
end;

function MatrixInverse (M: Matrix): Matrix;
var r,c: integer;
det:real;
compldet:Complex;
MAdj:Matrix;
begin
  MAdj:=MatrixAdj(M);
  Result.X:=M.X;
  Result.Y:=M.Y;
  det:=MatrixDet(M);
  compldet:=ComplMatrixDet(M);
  for r:=1 to M.Y do
    for c:=1 to M.X do begin
      Result.Body[r,c]:=MAdj.Body[r,c]/det;
      Result.Comp[r,c]:=ComplDiv(MAdj.Comp[r,c], compldet);
    end;
end;

function MatrixAdj (M: Matrix): Matrix;
var r,c: integer;
MOp: Matrix;
begin
  Result.X:=M.X;
  Result.Y:=M.Y;
  //MOp:=Transpose(M);
  for r:=1 to M.Y do
    for c:=1 to M.X do begin
      Result.Body[r,c]:=AlgExt(M,c,r);
      Result.Comp[r,c]:=ComplAlgExt(M,c,r);
    end;
  Result:=Transpose(Result);
end;

function ComplAlgExt (M: Matrix; Row, Col: integer): Complex;
var MOp: Matrix;
begin
  MOp:=ExcludeRowCol(M, Row, Col);
  Result:=ComplMult(ComplMatrixDet(MOp), Compl(1-2*((Row+Col)mod 2),0));
end;

function AlgExt (M: Matrix; Row, Col: integer): real;
var MOp: Matrix;
begin
  MOp:=ExcludeRowCol(M, Row, Col);
  Result:=MatrixDet(MOp)*(1-2*((Row+Col)mod 2));
end;

function ExcludeRowCol(M: Matrix; Row, Col: integer): Matrix;
var x,y,r,c: integer;
begin
  Result.X:=M.X-1;
  Result.Y:=M.Y-1;
  for c:=1 to M.X do begin
    for r:=1 to M.Y do begin
      if c<Col then x:=c else
        if c>col then x:=c-1 else
          if c=col then x:=0;
      if r<Row then y:=r else
        if r>Row then y:=r-1 else
          if r=Row then y:=0;
      Result.Body[x,y]:=M.body[c,r];
      Result.Comp[x,y]:=M.Comp[c,r];
      //Result.Re[x,y]:=M.Re[c,r];
      //Result.Im[x,y]:=M.Im[c,r];
    end;
  end;
end;

function ComplMatrixDet (M: Matrix): Complex;
//returns Det(M).
var a,b,c,r, sign: integer;
MOp: Matrix;
begin
  Result:=Compl(0,0);
  if (M.X=1) and (M.Y=1) then begin
    Result:=M.Comp[1,1];
    exit;
  end;
  if (M.X=2) and (M.Y=2) then begin
    //Result:=M.body[1,1]*M.body[2,2]-M.body[1,2]*M.body[2,1];
    Result:=ComplSub (ComplMult(M.Comp[1,1], M.Comp[2,2]),
                      ComplMult(M.Comp[1,2], M.Comp[2,1]));
    exit;
  end;
  if (M.X>2) and (M.Y>2) and (M.X=M.Y)then begin
    for a:=1 to M.X do begin
      if a mod 2 = 1 then sign:=1 else sign:=-1;
      MOp:=ExcludeRowCol(M,1,a);
      //Result:=Result+M.body[a,1]*MatrixDet(MOp)*sign;
      Result:=ComplAdd(Result,
                       ComplMult(M.Comp[a,1],
                                 ComplMult(ComplMatrixDet(MOp),
                                           Compl(sign, 0))));
    end;
  end;
end;


function MatrixDet (M: Matrix): real;
//returns Det(M).
var a,b,c,r, sign: integer;
MOp: Matrix;
begin
  Result:=0;
  if (M.X=1) and (M.Y=1) then begin
    Result:=M.body[1,1];
    exit;
  end;
  if (M.X=2) and (M.Y=2) then begin
    Result:=M.body[1,1]*M.body[2,2]-M.body[1,2]*M.body[2,1];
    exit;
  end;
  if (M.X>2) and (M.Y>2) and (M.X=M.Y)then begin
    for a:=1 to M.X do begin
      if a mod 2 = 1 then sign:=1 else sign:=-1;
      MOp:=ExcludeRowCol(M,1,a);
      Result:=Result+M.body[a,1]*MatrixDet(MOp)*sign;
    end;
  end;
end;

function MatrixMult (MA, MB: Matrix):Matrix;
var r,c: integer;
begin
  if MA.X=MB.Y then begin
    Result.X:=MB.X;
    Result.Y:=MA.Y;
    for r:=1 to MA.Y do
      for c:=1 to MB.X do begin
        Result.Comp[c,r]:=ComplMultRowCol (MA, MB, r, c);
        Result.Body[c,r]:=MultRowCol(MA, MB, r, c);
      end;
  end;
end;

function Transpose (M: Matrix): Matrix;
var
r,c: integer;
begin
  Result.X:=M.Y;
  Result.Y:=M.X;
  for r:=1 to M.X do
    for c:=1 to M.Y do begin
      Result.Body[c,r]:=M.body[r,c];
      Result.Comp[c,r]:=M.Comp[r,c];
    end;
end;

function MultRowCol(MA, MB: Matrix; Row, Col: integer):real;
//Row = Row number of matrix A; Col = column number of matrix B
var r,c:integer;
ret: real;
begin
  ret:=0;
  for r:=1 to MB.Y do
    ret:=ret+MA.body[r, Row]*MB.body[Col, r];
  Result:=ret;
end;

function ComplMultRowCol(MA, MB: Matrix; Row, Col: integer): Complex;
//Row = Row number of matrix A; Col = column number of matrix B
var r,c:integer;
ret: Complex;
begin
  ret:=Compl(0,0);
  for r:=1 to MB.Y do
    ret:=ComplAdd(ret, ComplMult(MA.Comp[r, Row],
                                 MB.Comp[Col, r]));
    //ret:=ret+MA.body[r, Row]*MB.body[Col, r];
  Result:=ret;
end;

function MatrixMultReal (M: Matrix; r: real): Matrix;
var a,b: byte;
begin
  Result:=M;
  for a:=1 to Result.X do
    for b:=1 to Result.Y do begin
      Result.Comp[a,b]:=ComplMult(Result.Comp[a,b], Compl(r,0));
      Result.Body[a,b]:=Result.Body[a,b]*r;
    end;
end;

end.
