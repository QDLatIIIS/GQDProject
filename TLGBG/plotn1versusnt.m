% ssomething wrong
% probably non-convergence of dividesolven1 for some nt
kymid = 4*pi/3/a0;

allnt = 0:1e14:1.5e16;
numOfnt = length(allnt);
alln1 = zeros(numOfnt,1);
allDelta0 = alln1;

parfor i =1:numOfnt
    alln1(i) = dividesolven1(allnt(i),T1,T2,T3,Ef,E1,E3);
    n1 = alln1(i);n2=0;n3=-n1;nb=-allnt(i);
    Delta12 = alpha*(n2 + n3 + nb );
    Delta23 = alpha*(n3 + nb);
    evalsatgamma = eig(getHamiltonian(0, kymid, Delta12, Delta23));
    Delta0 = evalsatgamma(4) - evalsatgamma(3);
    allDelta0(i) = Delta0;
end
figure;
plot(allnt,alln1,allnt,-alln1)
xlabel('nt(1/m^2)');ylabel('ni(1/m^2)');title('n1 vs nt');
figure;
plot(allnt,allDelta0)
xlabel('nt(1/m^2)');ylabel('Delta0(eV)');title('Delta0 vs nt');


