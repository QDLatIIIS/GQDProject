% test for different nt & nb while total n = 0
% not functioning
allnt = 0.5e15:1e14:5e15;
allnb=-allnt;
numOfn = length(allnt);

alln1 = zeros(numOfn,1);
alln2 = zeros(numOfn,1);
alln3 = zeros(numOfn,1);
allE1 = zeros(numOfn,1);
allE3 = allE1;

parfor i=1:numOfn
    nt = allnt(i);
    nb = allnb(i);
    tempAns = iter20160429(nt, nb, T1, T2, T3, Ef, E1, E3);
    %i
    %size(alln)
    alln1(i) = tempAns(1);
    alln2(i) = tempAns(2);
    alln3(i) = tempAns(3);
    allE1(i) = tempAns(4);
    allE3(i) = tempAns(5);
end
figure;
hold on
for i=1:3
    plot(allnt,alln(:,i) );
end
hold off


