%define parameters
gamma1_eV = 0.39;
e = 1.6e-19;
gamma1 = 0.39*e;
n0 = gamma1_eV^2/(3.14159*(3/2 * 3*0.142e-9)^2);
c0 = 0.335e-9;
epsilon0 = 8.84194875135768e-12;
Gamma = c0*e^2*n0/(2*gamma1*epsilon0);
