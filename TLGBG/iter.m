%% self-consistant solve for <ni>
%% parameters to set, include boundary conditions
%tolerance
tol = 0.001;
nt = 0.5e16;
nb = -0.5e16;
kappa = 2.3;
%% initialization
paras

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
    n1t = n1;
    n2t = n2;
    n3t = n3;
    Delta12t = alpha*( n2 + n3 + nb );
    Delta23t = alpha*( n3 + nb );
    %solve Ef for given <n> and layer potential, 
    %%%%%%%%%implemented%%%%%%%%%%%%%%
    Ef_t = ntoEk(n, -Delta12t, Delta23t)
    
    
    %[n1c1, n2c1, n3c1] = onBandOnLayerCInt(4, Ef_t, Delta12t, Delta23t);
    %[n1c2, n2c2, n3c2] = onBandOnLayerCInt(5, Ef_t, Delta12t, Delta23t);
    %[n1c3, n2c3, n3c3] = onBandOnLayerCInt(6, Ef_t, Delta12t, Delta23t);
    %[n1v1, n2v1, n3v1] = onBandOnLayerCInt(1, Ef_t, Delta12t, Delta23t);
    %[n1v2, n2v2, n3v2] = onBandOnLayerCInt(2, Ef_t, Delta12t, Delta23t);
    %[n1v3, n2v3, n3v3] = onBandOnLayerCInt(3, Ef_t, Delta12t, Delta23t);
    %n1 = 4*(n1c1+n1c2+n1c3-n1v1-n1v2-n1v3+n10v);
    %n2 = 4*(n2c1+n2c2+n2c3-n2v1-n2v2-n2v3+n20v);
    %n3 = 4*(n3c1+n3c2+n3c3-n3v1-n3v2-n3v3+n30v);
    
    ntemp = getnibyinterp3(Ef_t, -Delta12t, Delta23t)/2/pi; 
    n1 = ntemp(1); n2 = ntemp(2); n3 = ntemp(3);
    count = count+1
    
    % break if relative change of <ni> is smaller than <tol>
    if (abs((n1-n1t)/n1t) < tol)&&(abs((n2-n2t)/n2t) < tol)&&(abs((n3-n3t)/n3t) < tol)
        break
    end
end