% test for different nt & nb while total n = 0
allnt = 0.5e15:1e14:5e15;
allnb=-allnt;
numOfn = length(allnt);

alln = zeros(numOfn,3);
allE1 = zeros(numOfn,1);
allE3 = allE1;

for i=1:numOfn
    nt = allnt(i);
    nb = allnb(i);
    [alln(i,1),alln(i,2),alln(i,3), allE1(i), allE3(i)] = iter20160429Ave(nt, nb, T1, T2, T3, Ef, E1, E3);
    %i
    %size(alln)
    %alln(i,:) = tempAns(1:3);
    %allE1(i) = tempAns(4);
    %allE3(i) = tempAns(5);
end
figure;
hold on
for i=1:3
    plot(allnt,alln(:,i) );
end
hold off


