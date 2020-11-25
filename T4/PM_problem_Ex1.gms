sets
j 'properties (W,D,T)' /j1*j3/
i molecular groups /i1*i7/


parameters
po(j) property target
ps(j) property corresponding scale
pL(j) property lower bounds
pU(j) property upper bounds

A(i,j) property-group parameters A
B(i,j) property-group parameters B

nL(i)  groups lower bounds
nU(i)  groups upper bounds

sL     max property difference lower bound
sU     max property difference upper bound

;

*provide parameter values
*po(j)
po('j1')=0.005;
po('j2')=1.5;
po('j3')=383;
*ps(j)
ps(j)=po(j);
*pL(j)
pL('j1')=0.0001;
*pL('j1') changed from 0 to 0.0001 to avoid trivial solution
pL('j2')=1;
pL('j3')=298;
*pU(j)
pU('j1')=0.18;
pU('j2')=1.5;
pU('j3')=673;

*
Table A(i,j)
         j1              j2      j3
i1       0.000594        14      2700
i2       1.98            28      27000
i3       1.35            44      8000
i4       0.36            16      4000
i5       13.5            43      12000
i6       13.5            30      13000
i7       0.27            48.5    20000
;
Table B(i,j)
         j1              j2      j3
i1       14              15.85   14
i2       28              13.40   28
i3       44              23      44
i4       16              10      16
i5       43              24.9    43
i6       30              19.15   30
i7       48.5            29.35   48.5
;

*nL and nU bounds
nL(i)=0;
nU(i)=3;
*sL and sU bounds
sL=0;
sU=0.2;

variables
OF objective value
s  max property difference

n(i) molecular groups

p(j) property values

;

integer variables n;
positive variables s;
equations

*PM equations
objective objective function PM
eq1         difference calculation 1
eq2         difference calculation 2
eq3         property estimation
eqAux1      auxiliar equiation 1 (required to select the right solution as all 0 is a solution). ;

objective..      OF=e=s;
eq1(j)..         ps(j)*sum(i,B(i,j)*n(i))*s=g=(sum(i,A(i,j)*n(i))-po(j)*sum(i,B(i,j)*n(i)));
eq2(j)..         ps(j)*sum(i,B(i,j)*n(i))*s=g=-(sum(i,A(i,j)*n(i))-po(j)*sum(i,B(i,j)*n(i)));
eq3(j)..         p(j) * sum(i, B(i,j) * n(i)) =e= sum(i, A(i,j) * n(i));
*To avoid trivial solutions
eqAux1..         sum(i,n(i))=g=1;

*Bounds on number of groups, properties and deviation
n.lo(i)=nL(i);
n.up(i)=nU(i);
p.lo(j) = pL(j);
p.up(j) = pU(j);
s.lo = sL;
s.up = sU;
*Arbitrary initial guess
n.l('i1') = 1;
Model modelPM /all/;

option MIP=cplex;
option MINLP=dicopt;
option optcr=0;
option optca=1E-8;

solve modelPM minimising OF using MINLP;
Display n.l, p.l;






