%plot functosolve
alln1 = 1e14:1e14:5e15;
allnt = -0.5e16:1e14:0.5e16;

numOfn1 = length(alln1);
numOfnt = length(allnt);
funcvalue = zeros(numOfn1,numOfnt);

parfor i = 1:numOfnt
    for j = 1:numOfn1
        funcvalue(j,i) = functosolve(alln1(j),allnt(i),T1,T2,T3,Ef,E1,E3);
    end
end
figure;
mesh(alln1,allnt, funcvalue);

