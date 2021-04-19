$title Newsboy sales optimisation

SET i scenarios / 1 * 8 / ;

PARAMETERS
    D(i)    demand [units]
        /   1   100
            2   130
            3   150
            4   170
            5   200
            6   230
            7   240
            8   255 /
    P(i)    probability of scenario i occurring
        /   1   0.10
            2   0.13
            3   0.12
            4   0.20
            5   0.15
            6   0.10
            7   0.10
            8   0.10 /
    ED      expected demand [units]
;

ED = sum(i, D(i)*P(i));
display ED;

INTEGER VARIABLES
    B   units bought
    S   units sold
;

B.lo = 0;
S.lo = 0;

VARIABLES
    R   profit
;

EQUATIONS
* sales1
    sales2,sales3
    profit
;

* sales1..    S =e= min(B, ED);
sales2..    S =l= B;
sales3..    S =l= ED;
profit..    R =e= 1.4*S - ED;

MODEL news /all/;
SOLVE news USING MIP MAXIMIZING R;

display B.l, S.l, R.l;