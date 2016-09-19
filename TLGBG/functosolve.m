function n1out = functosolve(n1,nt,T1,T2,T3,Ef,E1,E3)
% return n1 - n1calc, where n1calc is calculated from

c0 = 0.335e-9;
epsilon0 = 8.854e-12;
e = 1.6e-19;
kappa = 2.3;
alpha = e*c0/epsilon0/kappa;

nb = -nt;
Ef_t = 0;

Delta12t = alpha*(  -n1 + nb );
temp = getnibyinterp3(Ef_t, -Delta12t, Delta12t,T1,T2,T3,Ef,E1,E3);
n1out = n1 - temp(1);
end