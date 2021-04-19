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
* stochastic model
    B       units bought
    S(i)    units sold in scenario i
* deterministic model
    B2      units bought
    S2      units sold
;

B.lo = 0; B2.lo = 0;
S.lo(i) = 0; S2.lo = 0;

VARIABLES
* stochastic model
    R(i)    profit in scenario i
    ER      expected profit
* deterministic model
    R2      profit
;

EQUATIONS
* stochastic model
    salesB(i),salesD(i)
    profit(i)
    profitE
* deterministic model
    salesB2,salesD2
    profit2
;

salesB(i).. S(i) =l= B;
salesD(i).. S(i) =l= D(i);
profit(i).. R(i) =e= P_S*S(i) - P_B*B;
profitE..   ER =e= sum(i, R(i)*P(i));

MODEL news_stochastic / salesB, salesD, profit, profitE /;
SOLVE news_stochastic USING MIP MAXIMIZING ER;

display ER.l, B.l, S.l, R.l;

salesB2..   S2 =l= B2;
salesD2..   S2 =l= ED;
profit2..   R2 =e= P_S*S2 - P_B*B2;

MODEL news_deterministic / salesB2, salesD2, profit2 /;
SOLVE news_deterministic USING MIP MAXIMIZING R2;

display R2.l, B2.l, S2.l;
