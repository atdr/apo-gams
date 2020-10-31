$title material balance reconciliation

sets
    i measurements / 1 * 3 /
    x species / B, C /
;

table
    Mtilde(x,i) measured value of mass flow rate
            1       2       3
        B   92.4    94.3    93.8
        C   11.1    10.8    11.4
    ;

positive variable
    M(x)    true mass flow
;

* initialise variables at middle measured value
M.l('B') = 93.8; M.l('C') = 11.1;

variable
    E       total error
;

equations
    error   mean squared error
;
    
error..     E =e= sum((x,i), sqr( M(x)-Mtilde(x,i) )/M(x) );

model mb /all/;

solve mb using NLP minimizing E;
