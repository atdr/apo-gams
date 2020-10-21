*-------------------------------------------------------------------------------
* Reactor Design Example
* Advanced Process Optimisation
*-------------------------------------------------------------------------------
SETS
i /Ain,A,B/
j /1*2/;

PARAMETERS
*rate constant in s^-1
k(j) 'rate constants '
/1   5
 2   2/;

Scalar V 'volume in m^3' /1/;

*Define variables
VARIABLES
*z       ’objective variable’
C(i)    ’concentration (mol*m^-3)’
F       ’flowrate (m^3*s^-1)’;

Positive variables
C(i),F;

*Define equations
EQUATIONS
obj       ’objective’
eq1,eq2   ’constraints';

obj..z =e= C('B');
eq1..F*(C('Ain')-C('A'))-k('1')*C('A')*V=e=0;
eq2..-F*C('B')+(k('1')*C('A')-k('2')*C('B'))*V=e=0;

*bounds
C.lo('Ain') = 0;
C.up('Ain') = 1;
C.up('A') = 0.1;
F.lo=0;
F.up=20;

*set starting point
C.1('A')=0.01;
F.l=10;
C.l('Ain')=0.8;
C.l('B')=0.5;

*Define model
MODEL reac / all / ;
* Set options and solve
SOLVE reac using nlp maximizing z ;
display z.l, C.l,F.l;