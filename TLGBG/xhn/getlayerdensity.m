function [ out ] = getlayerdensity( kx,Enum,E1,E3 )
%RETURNEIGVEC return the probability of certain layer according to band num from K point
%   E in the unit of eV
%   此处显示详细说明
out=zeros(3,numel(kx));

for i=1:numel(kx)
    [Vec,En]=eig(getHamiltonian(kx(i),17.0276,-E1,E3));
    for laynum=1:3
        iB=2*laynum;
        iA=iB-1;
        out(laynum,i)=abs(Vec(iA,Enum))^2+abs(Vec(iB,Enum))^2;
    end
end

end

