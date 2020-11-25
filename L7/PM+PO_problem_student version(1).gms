sets
j 'properties (W,D,T)' /j1*j3/
i molecular groups /i1*i7/
k binary index /k1*k4/

c integer cuts /1*1/
dyn(c) dynamic set of c
;

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

Kmax max binary factor

yv(i,k,c) store y values from previous solutions
nv(i,c) store n values
sv(c) store s values
pv(c,j) store parameter values

pj property to be minimised in PO
;

*provide parameter values
*po(j)
po('j1')=0.005;
po('j2')=1.5;
po('j3')=383;
*ps(j)
ps(j)=po(j);
*pL(j)
pL('j1')=0;
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

*Kmax
Kmax=smax(i,ceil(log(nU(i)-nL(i))/log(2)));

variables
OF objective value
s  max property difference

n(i) molecular groups
ns(i) auxiliar product variable 1

y(i,k) binary auxiliar variable
ys(i,k) auxiliar product variable 2

p(j) property values
np(i,j) auxiliar product variable 3
yp(i,j,k) auxiliar product variable 4
;

binary variables y;
integer variables n;
positive variables s,ys,ns;
equations

*PM equations
objective1a objective function PM
eq1, eq2, eq3, eq4, eq5, eq6, eq7, eq8, eqAux;

objective1a.. OF=e=s;

eq1(j)..    ps(j)*sum(i, B(i,j)*ns(i)) =g= sum(i, A(i,j)*n(i)) - po(j)*sum(i, B(i,j)*n(i));
eq2(j)..    ps(j)*sum(i, B(i,j)*ns(i)) =g= -sum(i, A(i,j)*n(i)) + po(j)*sum(i, B(i,j)*n(i));
eq3(i)..    n(i) =e= nL(i) + sum(k$(ord(k) lt (Kmax+1)), 2**(ord(k)-1) * y(i,k));
eq4(i)..    ns(i) =e= s*nL(i) + sum(k$(ord(k) lt (Kmax+1)), 2**(ord(k)-1) * ys(i,k));
eq5(i,k)..  s - sU*(1-y(i,k)) =l= ys(i,k);
eq6(i,k)..  ys(i,k) =l= s - sL*(1-ys(i,k));
eq7(i,k)..  sL*y(i,k) =l= ys(i,k);
eq8(i,k)..  ys(i,k) =l= sU*y(i,k);

eqAux..     sum(i, n(i)) =g= 1;

Model original /all/;
* initial guess
n.l('i1') = 1;

option MIP=cplex;
option MINLP=sbb;
option optcr=0;
option optca=0;

solve original minimising OF using MIP;







