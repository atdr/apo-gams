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




*Declaring equations in the model
*To be completed by the student by declaring all the equations below


*Defining the equations
*To be completed by the student by defining all the equations below


*Initial Guess
*To be completed by the student

*Defining the model
Model Garden /all/;

*Calling the solve statement
Solve Garden using nlp maximizing A;