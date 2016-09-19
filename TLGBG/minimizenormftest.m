% it works
% for non-zero n, cost approx. 100s
%
nt = 0.75e16;
nb = -0.75e16;

fun = @(n13) functosolveallnnorm(n13(1),n13(2),nt,nb,T1,T2,T3,Ef,E1,E3);
[n13out, fval] = fminsearch(fun, [-nt,-nb])


