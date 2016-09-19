%% n1+n2+n3+nt+nb=0
% return a parabolic surface if outside reliable region, n1m&n3m required
function out = functosolveallnnorm2_newinterp(n1,n3,n1m,n3m,nt,nb,T1,T2,T3,Ef,E1,E3)

% parameters
c0 = 0.335e-9;
epsilon0 = 8.854e-12;
e = 1.6e-19;
kappa = 2.3;
alpha = e*c0/epsilon0/kappa;

n2 = -(nt + nb) - n1 - n3;
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
    n13=[n1,n3];
    E13=[-Delta12t,Delta23t];
    out = norm([n1-n1m,2e16,n3-n3m]);
end
end