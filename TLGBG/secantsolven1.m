% self-consistant solve for <ni>
function out = secantsolven1(T1,T2,T3,Ef,E1,E3)
%% parameters to set, include boundary conditions
%tolerance
tol = 0.0000001;
nt = 0.01e16;
nb = -0.01e16;
kappa = 2.3;


%% initialization

c0 = 0.335e-9;
epsilon0 = 8.854e-12;
e = 1.6e-19;
alpha = e*c0/epsilon0/kappa;



n1t = -nt/10;n1tm1 = 0;
n3t = -n1t; n3tm1 = -n1tm1;

%% iteration
count = 0;
while true
    Delta12t = alpha*(  n3t + nb );Delta23t = alpha*( n3t + nb );
    Delta12tm1 = alpha*(  n3tm1 + nb );Delta23tm1 = alpha*( n3tm1 + nb );
    %solve Ef for given <n> and layer potential, 
    %%%%%%%%%implemented%%%%%%%%%%%%%%
    Ef_t = 0;Ef_tm1 = 0;
    

    
    ntemp = getnibyinterp3(Ef_t, -Delta12t, Delta23t,T1,T2,T3,Ef,E1,E3)
    ntempm1 = getnibyinterp3(Ef_tm1, -Delta12tm1, Delta23tm1,T1,T2,T3,Ef,E1,E3)
    n1 = ntemp(1);
    n1m1 = ntempm1(1);
    fk = n1t - n1
    fkm1 = n1tm1 - n1m1
    n1tp1 = n1t - fk*(n1t - n1tm1)/(fk-fkm1);
    % tracing iteration
    count = count+1
    
    % break if relative change of <ni> is smaller than <tol>
    if (abs((n1tp1-n1t)/n1t) < tol)
        break
    end
    
    n1t = n1tp1;n3t = -n1t;
    n1tm1 = n1t;n3tm1 = -n1tm1;
end
end