function [ n ] = getni( Ef,E1new,E3new )
%GETNI return layer densities given Ef E1 E3
%   n is an 3*1 array and in the unit of m^-2
n=zeros(3,1);
load('valencebandintegral.mat')
for i=1:3
    n(i)=interp2(E1,E3,reshape(intntdif(i,:,:),numel(E1),numel(E3)).',E1new,E3new,'cubic',0);
end
n=n+integralforni(Ef,E1new,E3new);
n=n*1e18;
end

