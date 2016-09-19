function [ out ] = integralforni( Ef,E1,E3 )
%INTEGRALFORNI integrate from K point to kF
%   E1 from 0 to 0.0195eV
%   E3 from 0 to -0.0195eV
if Ef>0
    Enum=4;
else
    Enum=3;
end
kF=Eftokf(Ef,Enum,E1,E3);
if kF==0
    out=zeros(3,1);
else
    fun=@(kx) getlayerdensity( kx,Enum,E1,E3)*kx;
    out=integral(fun,0,kF,'RelTol',1e-5,'AbsTol',0,'ArrayValued',true)*2/pi*(-1)^Enum;
    
end
end

