unit ComplexAlg;

interface

uses math, SysUtils;

type
  Complex = Record
    Re: extended;
    Im: extended;
  end;

  function ComplDeg (Compl: Complex): Real;      //degree, gr360
  function ComplAbs (Compl: Complex): real;      //absolute value
  function ComplString (Compl: Complex): string; //ComplToStr
  function ComplSub (A, B: Complex): Complex;
  function ComplAdd (A, B: Complex): Complex;
  function ComplDiv (A, B: Complex): Complex;
  function ComplMult (A, B: Complex): Complex;
  function Compl (Re, Im: extended): Complex;

  const inf=666;

implementation
function ComplDeg (Compl: Complex): real;
var over90:integer;
begin
  if Compl.Re<0 then over90:=2 else over90:=0;
  Result:=90*over90+(1-over90)*RadToDeg(ArcSin(Compl.Im/ComplAbs(Compl)));
end;

function ComplAbs (Compl: Complex): real;
begin
  Result:=sqrt(Compl.Re*Compl.Re + Compl.Im*Compl.Im);
end;

function ComplString (Compl: Complex): string;
var
sig: char;
begin
  if Compl.Im>=0 then sig:='+' else sig:='-';
  if Compl.Im=0 then begin
    Result:=floattostrf(Compl.Re,ffGeneral,2,2);
    exit;
  end;
  Result:=floattostrf(Compl.Re,ffGeneral,2,2)+' '+sig+'j'+floattostrf(abs(Compl.Im),ffGeneral,2,2);
  if Compl.Re=inf then Result:='inf';
end;

function ComplSub (A, B: Complex): Complex;
begin
  if (A.Re=inf) or (B.Re=inf) then begin
    Result.Re:=inf;
    Result.Im:=inf;
  end;

  Result.Re:=A.Re-B.Re;
  Result.Im:=A.Im-B.Im;
end;

function ComplAdd (A, B: Complex): Complex;
begin
  if (A.Re=inf) or (B.Re=inf) then begin
    Result.Re:=inf;
    Result.Im:=inf;
  end;
  Result.Re:=A.Re+B.Re;
  Result.Im:=A.Im+B.Im;
end;

function ComplMult (A, B: Complex): Complex;
begin
  Result.Re := A.Re*B.Re - A.Im*B.Im;
  Result.Im := A.Re*B.Im + B.Re*A.Im;

  if ((A.Re=inf) and (B.Re<>0)) or
     ((B.Re=inf) and (A.Re<>0))
  then begin
    Result.Re:=inf;
    Result.Im:=inf;
  end;

end;

function ComplDiv (A, B: Complex): Complex;
begin
  Result.Re := (A.Re*B.Re+A.Im*B.Im) / (B.Re*B.Re+B.Im*B.Im);
  Result.Im := (A.Im*B.Re-A.Re*B.Im) / (B.Re*B.Re+B.Im*B.Im);

  if ((A.Re=inf) and (B.Re<>inf))
  then begin
    Result.Re:=inf;
    Result.Im:=inf;
  end;

  if ((B.Re=inf) and (A.Re<>inf))
  then begin
    Result.Re:=0;
    Result.Im:=0;
  end;


end;

function Compl (Re, Im: extended): Complex;
begin
  Result.Re:=Re;
  Result.Im:=Im;
end;

end.
 