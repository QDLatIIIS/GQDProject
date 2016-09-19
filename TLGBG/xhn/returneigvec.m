function [ out,outE ] = returneigvec( kx,ky,Enum,laynum,E1,E3 )
%RETURNEIGVEC return the probability of certain layer according to band num and layer num
%   E in the unit of eV
%   此处显示详细说明
out=kx;
outE=out;
iB=2*laynum;
iA=iB-1;
parameters
for i=1:numel(out)
    [Vec,En]=eig(getHamiltonian(kx(i),ky(i),-E1,E3));
    out(i)=abs(Vec(iA,Enum))^2+abs(Vec(iB,Enum))^2;
    outE(i)=En(Enum,Enum);
end

end

