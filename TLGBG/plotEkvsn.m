% plot Ek vs n
alln = 0:1e13:1e15;
lenalln = length(alln);
allEk = zeros(lenalln,1);
parfor i=1:lenalln
    allEk(i) = ntoEk(alln(i),0.001,0.001,T1,T2,T3,Ef,E1,E3 );
end
figure;
plot(alln,allEk);
