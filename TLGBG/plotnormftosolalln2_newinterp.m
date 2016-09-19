% plot norm of functosolvealln, i.e., sqrt sum of deviation of ni

%alln1 = -1.7e16:0.01e16:-0.27e16;
%alln3 = 0.26e16:0.01e16:1.75e16;
alln1 = -4e16:0.02e16:0e16;
alln3 = -0e16:0.02e16:4e16;


%Vt = 5;
%Vb = -5;
%nt = epsilon0*kappa*Vt/e/dist;
%nb = epsilon0*kappa*Vb/e/disb;
nt = 2e16;
nb = -2e16;

numOfn1 = length(alln1);
numOfn3 = length(alln3);
normofftosol = zeros(numOfn3, numOfn1);

%get midpoint of reliable region
[n1m,n3m]=findmid(nt,nb,T1,T2,T3,Ef,E1,E3);

parfor i=1:numOfn1
    tempn1 = alln1(i);
    for j=1:numOfn3
        %tempn3 = 
        normofftosol(j,i)= functosolveallnnorm2_newinterp(tempn1,alln3(j),n1m,n3m,nt,nb,T1,T2,T3,Ef,E1,E3);
    end
end
figure;meshc(alln1, alln3, normofftosol)
xlabel('n1');ylabel('n3');title('norm of deviation vector of ni, with nt&nb fixed');
%figure;contourf(alln1, alln3, normofftosol,50,'EdgeColor','none')
%xlabel('n1');ylabel('n3');title(['norm of deviation vector of ni, with nt=' num2str(nt) ',nb=' num2str(nb)]);
figure;contourf(alln1, alln3, log(normofftosol)/log(max(max(normofftosol))),50,'EdgeColor','none')
xlabel('n1');ylabel('n3');title(['log norm of deviation vector of ni, with nt=' num2str(nt) ',nb=' num2str(nb) ',Vt=' num2str(Vt) ',Vb=' num2str(Vb)]);
