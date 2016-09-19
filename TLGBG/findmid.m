%% find the midpoint of the reliable region
function [n1m, n3m] = findmid(nt,nb,T1,T2,T3,Ef,E1,E3)

% parameters
alln1 = -2e16:0.1e16:2e16;
alln3 = -2e16:0.2e16:2e16;
numOfn1 = length(alln1);
numOfn3 = length(alln3);
%normofftosol = zeros(numOfn3, numOfn1);
n1total = 0;n3total = 0;nn1=0;nn3=0;
for i=1:numOfn1
    tempn1 = alln1(i);
    for j=1:numOfn3
        tempn3 = alln3(j);
        tmp = functosolveallnnorm2_newinterp_out0(tempn1,tempn3,nt,nb,T1,T2,T3,Ef,E1,E3);
        if tmp>0
            n1total=n1total+tempn1;nn1=nn1+1;
            n3total=n3total+tempn3;nn3=nn3+1;
        end
    end
end
n1m = n1total/nn1;n3m=n3total/nn3;
end
