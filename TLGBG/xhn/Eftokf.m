function [ kf ] = Eftokf( Ef,Enum,E1new,E3new )

Enum=Enum-2;
load('coeffofpoly4fitofEcEvVSE1E3.mat')
intercoef=zeros(5,1);
for i=1:5
    intercoef(i)=interp2(E1,E3,reshape(coeff(i,Enum,:,:),numel(E1),numel(E3)).',E1new,E3new,'cubic',0);
end
if abs(intercoef(5))>abs(Ef)
    kf=0;
else
    syms xx;
    kf = vpasolve(Ef == intercoef(1)*xx^4+intercoef(2)*xx^3+intercoef(3)*xx^2+intercoef(4)*xx+intercoef(5), xx,[0,0.5]);
    kf=double(kf);
end
end