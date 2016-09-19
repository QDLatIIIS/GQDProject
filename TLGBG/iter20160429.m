%% do not converge, 04/29/2016
% self-consistant solve for <ni>, returns layer density n1, n2, n3; onsite energy E1, E3 and fermi energy Ef
function [n1, n2, n3, E1r, E3r, Ef_t]=iter20160429(nt, nb, T1,T2,T3,Ef,E1,E3, kappa, tol)

%% parameters to set, include boundary conditions
%tolerance
%tol = 0.001;
%nt = 0.5e16;
%nb = -0.1e16;
%kappa = 2.3;

if nargin < 10
    tol = 0.001;
    if nargin < 9
        kappa = 2.3;
        if nargin < 8
            loadTableforniVsEfE1E320160429;
        end
    end
end
%% initialization

c0 = 0.335e-9;
epsilon0 = 8.854e-12;
e = 1.6e-19;
alpha = e*c0/epsilon0/kappa;

n = nt + nb;
n1 =  n/2;
n3 = -n1;
n2 = 0;

% calculate the considered inherent density from valence bands(not needed)
%[n10v1, n20v1, n30v1] = onBandOnLayerCInt(1, 0, 0, 0);
%[n10v2, n20v2, n30v2] = onBandOnLayerCInt(2, 0, 0, 0);
%[n10v3, n20v3, n30v3] = onBandOnLayerCInt(3, 0, 0, 0);
%n10v = n10v1+n10v2+n10v3;
%n20v = n20v1+n20v2+n20v3;
%n30v = n30v1+n30v2+n30v3;

%% iteration
count = 0;
while true
    n1t = n1;n2t = n2;n3t = n3;
    Delta12t = alpha*( n2 + n3 + nb );Delta23t = alpha*( n3 + nb );
    %solve Ef for given <n> and layer potential, 
    %%%%%%%%%implemented%%%%%%%%%%%%%%
    Ef_t = ntoEk(n, -Delta12t, Delta23t,T1,T2,T3,Ef,E1,E3);
    
    
    %[n1c1, n2c1, n3c1] = onBandOnLayerCInt(4, Ef_t, Delta12t, Delta23t);
    %[n1c2, n2c2, n3c2] = onBandOnLayerCInt(5, Ef_t, Delta12t, Delta23t);
    %[n1c3, n2c3, n3c3] = onBandOnLayerCInt(6, Ef_t, Delta12t, Delta23t);
    %[n1v1, n2v1, n3v1] = onBandOnLayerCInt(1, Ef_t, Delta12t, Delta23t);
    %[n1v2, n2v2, n3v2] = onBandOnLayerCInt(2, Ef_t, Delta12t, Delta23t);
    %[n1v3, n2v3, n3v3] = onBandOnLayerCInt(3, Ef_t, Delta12t, Delta23t);
    %n1 = 4*(n1c1+n1c2+n1c3-n1v1-n1v2-n1v3+n10v);
    %n2 = 4*(n2c1+n2c2+n2c3-n2v1-n2v2-n2v3+n20v);
    %n3 = 4*(n3c1+n3c2+n3c3-n3v1-n3v2-n3v3+n30v);
    
    ntemp = getnibyinterp3(Ef_t, -Delta12t, Delta23t,T1,T2,T3,Ef,E1,E3)/2/pi
    n1 = ntemp(1); n2 = ntemp(2); n3 = ntemp(3);
    % tracing iteration
    count = count+1
    
    % break if relative change of <ni> is smaller than <tol>
    if (abs((n1-n1t)/n1t) < tol)&&(abs((n2-n2t)/n2t) < tol)&&(abs((n3-n3t)/n3t) < tol)
        break
    end
end
E1r = -Delta12t; E3r = Delta23t; 
end