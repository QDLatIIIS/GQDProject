% plot norm of functosolvealln, i.e., sqrt sum of deviation of ni
alln1 = -0.6e16:0.005e16:0.6e16;
alln3 = -0.6e16:0.005e16:0.6e16;
%nt = 0.1e16;
%nb = -0.05e16;

numOfn1 = length(alln1);
numOfn3 = length(alln3);
normofftosol = zeros(numOfn3, numOfn1);

parfor i=1:numOfn1
    tempn1 = alln1(i);
    for j=1:numOfn3
        %tempn3 = 
        normofftosol(j,i)= functosolveallnnorm2(tempn1,alln3(j),nt,nb,T1,T2,T3,Ef,E1,E3);
    end
end
figure;meshc(alln1, alln3, normofftosol)
xlabel('n1');ylabel('n3');title('norm of deviation vector of ni, with nt&nb fixed');
figure;contourf(alln1, alln3, normofftosol,50,'EdgeColor','none')
xlabel('n1');ylabel('n3');title(['norm of deviation vector of ni, with nt=' num2str(nt) ',nb=' num2str(nb)]);
figure;contourf(alln1, alln3, log(normofftosol)/log(max(max(normofftosol))),50,'EdgeColor','none')
xlabel('n1');ylabel('n3');title(['log norm of deviation vector of ni, with nt=' num2str(nt) ',nb=' num2str(nb)]);
