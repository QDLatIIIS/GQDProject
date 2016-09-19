% self-consistant solve for <ni>
function n1tm1 = secantsolven1ver2(T1,T2,T3,Ef,E1,E3)
%% parameters to set, include boundary conditions
%tolerance
tol = 0.0000001;
nt = -0.01e16;
nb = -nt;
kappa = 2.3;


%% initialization

c0 = 0.335e-9;
epsilon0 = 8.854e-12;
e = 1.6e-19;
alpha = e*c0/epsilon0/kappa;



n1t = -nt;n1tm1 = 0;
n3t = -n1t; n3tm1 = -n1tm1;

%% iteration
count = 0;
while true
    
    fk = functosolve(n1t,nt,T1,T2,T3,Ef,E1,E3)
    fkm1 = functosolve(n1tm1,nt,T1,T2,T3,Ef,E1,E3)
    n1tp1 = n1t - fk*(n1t-n1tm1)/(fk-fkm1)
    
    % tracing iteration
    count = count+1
    
    % break if relative change of <ni> is smaller than <tol>
    if (abs((n1tp1-n1t)/n1t) < tol)
        break
    end
    
    n1t = n1tp1;
    n1tm1 = n1t;
end
end