*Hands-on exercise (1)
*Advanced Process Optimisation
*Kindly use the same variable for area as shown in the Solve statement

*Declaring parameters of the model
PARAMETERS
A0               Initial area of the garden
L0               Initial length of the garden
W0               Initial width of the garden
F                Length of fencing available ;

*Assigning values to the parameters
W0 = 1;
L0 = 7;
A0 = W0 * L0;
F = 16;

*Declaring variables in the model
*To be completed by the student by declaring all the variables below
VARIABLES
A   new area
L   new length
W   new width ;

*Declaring equations in the model
*To be completed by the student by declaring all the equations below
EQUATIONS
area    area of garden
perim   perimeter of garden ;

*Defining the equations
*To be completed by the student by defining all the equations below
area.. A =e= L * W;
perim.. F =e= 2*(L+W);

*Initial Guess
*To be completed by the student
A.l = A0;
L.l = L0;
W.l = W0

*Defining the model
Model Garden /all/;

*Calling the solve statement
Solve Garden using nlp maximizing A;