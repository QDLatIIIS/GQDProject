function [ Efout ] = ntoEk( n,E1new,E3new,T1,T2,T3,Ef,E1,E3 )
%NTOEK given total density n, E1, E3, return Ef
%   此处显示详细说明

if abs(n)<5e12
    Efout=0;
else
s=sign(n);
Ei=0;
Ei2=s*0.1;
ni=0;
ni2=sum(getnibyinterp3(Ei2,E1new,E3new,T1,T2,T3,Ef,E1,E3));
while  abs(Ei-Ei2)>1e-4
    E0=(Ei+Ei2)/2;
    n0=sum(getnibyinterp3(E0,E1new,E3new,T1,T2,T3,Ef,E1,E3));
    if (ni2-n)*(n-n0)>0
        Ei=E0;
        ni=n0;
    else
        Ei2=E0;
        ni2=n0;
    end
end
Efout=Ei2;
end