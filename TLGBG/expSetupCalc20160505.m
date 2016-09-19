% using functosolveallnnorm2_newinterp2
% 20160505: added random start points to ensure global minimum
%% set boundary condition
paras;
Vt = 3.4;
Vb = -16;
dist = 100e-9;
disb = 300e-9;
% plot or not
plotSurf = false;
plotLine = true;
numOfStartPoints = 5;


fvals=zeros(numOfStartPoints,1);
n13outs=zeros(numOfStartPoints,2);
%% calculate nt, nb and solve for n1, n2, n3
% while calculating nt & nb, there might be a factor 2
nt = epsilon0*kappa*Vt/e/dist;
nb = epsilon0*kappa*Vb/e/disb;
nt = -5.091050000000000e+15;
nb =+4.198804123711341e+15;
% get the midpoint of the reliable region as the initial value
[n1m,n3m]=findmid(nt,nb,T1,T2,T3,Ef,E1,E3);
fun = @(n13) functosolveallnnorm2_newinterp(n13(1),n13(2),n1m,n3m,nt,nb,T1,T2,T3,Ef,E1,E3);
for i=1:numOfStartPoints
    [n10,n30]=findstartrand(nt,nb,n1m, n3m,T1,T2,T3,Ef,E1,E3);
    [n13outs(i,:), fvals(i)] = fminsearch(fun, [n10,n30]);
end
[fvalmin,minindex]=min(fvals);
fvalmin
n1 = n13outs(minindex,1)
n3 = n13outs(minindex,2)
n2 = -(nt+nb)-n1-n3;

% interlayer potential difference
Delta12 = alpha*(n2 + n3 + nb );
Delta23 = alpha*(n3 + nb);

%% calculate k-space band structure
kxmin = -0.2/a0;
kxstep = 0.005/a0;
kxmax = 0.2/a0;
kymid = 4*pi/3/a0;
kymin = kymid - 0.2/a0;
kystep = 0.005/a0;
kymax = kymid + 0.2/a0;

kx = kxmin:kxstep:kxmax;
ky = kymin:kystep:kymax;
lenkx = length(kx);
lenky = length(ky);

bands = zeros(lenkx,lenky,6);
evalsatgamma = eig(getHamiltonian(0, kymid, Delta12, Delta23));
Delta0 = evalsatgamma(4) - evalsatgamma(3)

for i = 1:lenkx
    for j = 1:lenky
        evals = eig(getHamiltonian(kx(i), ky(j), Delta12, Delta23));
        for bandNum = 1:6
            bands(j, i, bandNum) = evals(bandNum);
        end
    end
end

%% plot the band structure(surface) if plotSurf==true
if plotSurf
figure;
hold on
for i=1:6
meshc(kx,ky,bands(:,:,i))
end
hold off
title(['Vt=' num2str(Vt) ', Vb=' num2str(Vb)]);
end

%% plot the band structure(line)
if plotLine
% large range
figure;
hold on
for i=1:6
plot(kx*a0,bands(floor(lenky/2)+1,:,i))
end
hold off
xlabel('kx(1/a0)');ylabel('E(eV)');title(['Vt=' num2str(Vt) ', Vb=' num2str(Vb)]);

% small range, finer
kxfine = -0.1/a0:0.001/a0:0.1/a0;
bandsfine = zeros(length(kxfine),6);
for i = 1:length(kxfine)
    evals = eig(getHamiltonian(kxfine(i), kymid, Delta12, Delta23));
    for bandNum = 1:6
        bandsfine(i,bandNum) = evals(bandNum);
    end
end
figure;
hold on
for i=3:4
plot(kxfine*a0,bandsfine(:,i))
end
hold off
xlabel('kx(1/a0)');ylabel('E(eV)');
title(['Vt=' num2str(Vt) ', Vb=' num2str(Vb)]);
end

Delta = min(min(bands(:,:,4))) - max(max(bands(:,:,3)))
Efexp = ntoEk_newinterp( n1+n2+n3,-Delta12,Delta23,T1,T2,T3,Ef,E1,E3 )
