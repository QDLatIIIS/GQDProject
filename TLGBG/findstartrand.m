%% find one arbituary point of the reliable region
function [n10, n30] = findstartrand(nt,nb,n1m, n3m,T1,T2,T3,Ef,E1,E3)


%normofftosol = zeros(numOfn3, numOfn1);
%n1total = 0;n3total = 0;nn1=0;nn3=0;
while true
    tempn1 = n1m+ 1.4e16 * random('unid',100)/100-0.7e16;
    tempn3 = n3m+ 1.4e16 * random('unid',100)/100-0.7e16;
    tmp = functosolveallnnorm2_newinterp_out0(tempn1,tempn3,nt,nb,T1,T2,T3,Ef,E1,E3);
    if tmp>0
        n10 = tempn1;
        n30 = tempn3;
        return;
    end
end
end
