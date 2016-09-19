% self-consistant solve for n1, assuming nb = -nt
function n1m = dividesolven1(nt, T1,T2,T3,Ef,E1,E3,tol)
%% parameters to set, include boundary conditions
%tolerance
%tol = 0.0000001;
%nt = -0.01e16;
if nargin < 8
    tol = 0.001;
end

%% initialization

n1l = -0.5*nt;n1r = -1*nt;
if n1l==n1r
    n1m = 0;
    return;
end

%% iteration
%count = 0;
while true
    n1m = (n1l+n1r)/2;
    fl = functosolve(n1l,nt,T1,T2,T3,Ef,E1,E3);
    fr = functosolve(n1r,nt,T1,T2,T3,Ef,E1,E3);
    fm = functosolve(n1m,nt,T1,T2,T3,Ef,E1,E3);
    
    % tracing iteration
    %count = count+1
    
    % break if relative change of <ni> is smaller than <tol>
    if (abs((n1l-n1r)/n1r) < tol)
        break
    elseif fl*fm > 0
            n1l = n1m;
    else
        n1r = n1m;
    end
    
end
end