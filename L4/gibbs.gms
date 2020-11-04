$title Gibbs free energy

SETS
    i   elements
        / N, H, O /
    j   compounds
        / H, H2, H2O, N, N2, NH, NO, O, O2, OH /
;

TABLE
    alpha(i,j)  number of atoms of element i in compound j
            H   H2  H2O N   N2  NH  NO  O   O2  OH
        N   0   0   0   1   2   1   1   0   0   0
        H   1   2   2   0   0   1   0   0   0   1
        O   0   0   1   0   0   0   1   1   2   1
;

PARAMETERS
    F0(j)   standard Gibbs free energy of compound j
        /   H   -10.021
            H2  -21.096
            H2O -37.986
            N   -9.846
            N2  -28.653
            NH  -18.918
            NO  -28.032
            O   -14.640
            O2  -30.594
            OH  -26.11  /
    c(j)    calculated Gibbs free energy of compund j
    b(i)    atomic weights of element i in mixture
        /   N   1
            H   2
            O   1   /
    T       temperature [K] / 3500 /
    P       pressure [atm]  / 51.0345 /
    R       ideal gas const / 8.314 /
;

c(j) = F0(j)/(R*T) + log(P);

POSITIVE VARIABLES
    x(j)    moles of compound j in mixture
    xbar    total moles
;

VARIABLE
    A       total Gibbs free energy

EQUATIONS
    m1      total mass
    m2(i)   elemental sum
    e       free energy
;

m1..        xbar =e= sum(j, x(j));
m2(i)..     b(i) =e= sum(j, alpha(i,j)*x(j));
e..         A =e= sum(j, x(j)*( c(j) + log(x(j)/xbar) ));

x.lo(j) = 0.001;
xbar.lo = 0.01;

model gibbs /all/;
solve gibbs using NLP minimizing A;
