$title Newsboy sales optimisation

SET i scenarios / 1 * 8 / ;

PARAMETERS
    D(i)    demand in scenario i [units]
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
    P_B     purchase price / 1.0 /
    P_S     sales price / 1.4 /
;

ED = sum(i, D(i)*P(i));
display ED;

INTEGER VARIABLES
    B       units bought
    S(i)    units sold in scenario i
;

B.lo = 0;
S.lo(i) = 0;

VARIABLES
    R(i)    profit in scenario i
    ER      expected profit
;

EQUATIONS
    salesB(i),salesD(i)
    profit(i)
    profitE
;

salesB(i).. S(i) =l= B;
salesD(i).. S(i) =l= D(i);
profit(i).. R(i) =e= P_S*S(i) - P_B*B;
profitE..   ER =e= sum(i, R(i)*P(i));

MODEL news /all/;
SOLVE news USING MIP MAXIMIZING ER;

display ER.l, B.l, S.l, R.l;
