%plot functosolve
alln1 = -8e15:5e13:8e15;
nt = 0.8e16;

numOfn1 = length(alln1);
funcvalue = zeros(numOfn1,1);

parfor i = 1:numOfn1
    funcvalue(i) = functosolve(alln1(i),nt,T1,T2,T3,Ef,E1,E3);
end
figure;
plot(alln1, funcvalue);

