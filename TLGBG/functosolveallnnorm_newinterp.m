%% n1+n2+n3=nt+nb
function out = functosolveallnnorm_newinterp(n1,n3,nt,nb,T1,T2,T3,Ef,E1,E3)
% return n1 - n1calc, where n1calc is calculated from
% parameters
c0 = 0.335e-9;
epsilon0 = 8.854e-12;
e = 1.6e-19;
kappa = 2.3;
alpha = e*c0/epsilon0/kappa;

n2 = nt + nb - n1 - n3;
Delta12t = alpha*(n2 + n3 + nb );
Delta23t = alpha*(n3 + nb);
try
Ef_t = ntoEk_newinterp(nt + nb, -Delta12t, Delta23t,T1,T2,T3,Ef,E1,E3);
temp = getnibyinter3(Ef_t, -Delta12t, Delta23t,T1,T2,T3,Ef,E1,E3);
out1 = n1 - temp(1);
out2 = n2 - temp(2);
out3 = n3 - temp(3);
out = norm([out1,out2,out3]);
catch err
    %err.getReport
    out = norm([n1+nt,n2,n3+nt]);
end
end