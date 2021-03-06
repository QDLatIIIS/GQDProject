%% return out=[Ef,Delta], n13=[n1.n3] for input nt, nb
% using functosolveallnnorm2_newinterp2
% random start point not enabled
function [out,n13]=ntnbtoEfDelta(nt,nb,T1,T2,T3,Ef,E1,E3, numOfStartPoints)

a0=0.246;%in-plane lattice vector, nm
kappa = 2.3;
c0 = 0.335e-9;
epsilon0 = 8.854e-12;
e = 1.6e-19;
alpha = e*c0/epsilon0/kappa;
if nargin < 9
    numOfStartPoints = 5;
end

fvals=zeros(numOfStartPoints,1);
n13outs=zeros(numOfStartPoints,2);
out = zeros(2,1);
[n1m,n3m]=findmid(nt,nb,T1,T2,T3,Ef,E1,E3);
fun = @(n13) functosolveallnnorm2_newinterp(n13(1),n13(2),n1m,n3m,nt,nb,T1,T2,T3,Ef,E1,E3);
for i=1:numOfStartPoints
    [n10,n30]=findstartrand(nt,nb,n1m, n3m,T1,T2,T3,Ef,E1,E3);
    [n13outs(i,:), fvals(i)] = fminsearch(fun, [n10,n30]);
end
[fvalmin,minindex]=min(fvals);
n1 = n13outs(minindex,1);
n3 = n13outs(minindex,2);
n2 = -(nt+nb)-n1-n3;

Delta12 = alpha*(n2 + n3 + nb );
Delta23 = alpha*(n3 + nb);
kymid = 4*pi/3/a0;

%% calculate band gap
evalsatgamma = eig(getHamiltonian(0, kymid, Delta12, Delta23));
Delta0 = evalsatgamma(4) - evalsatgamma(3);
Efexp = ntoEk_newinterp( n1+n2+n3,-Delta12,Delta23,T1,T2,T3,Ef,E1,E3 );
out(1)=Efexp;out(2)=Delta0;
n13 = n13outs(minindex,:);

end