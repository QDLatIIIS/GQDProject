function [ v ] = inter3( xt,yt,zt,vt,x,y,z )
%INTER3 trilinear interpolation
%   xt is l*1. yt is m*1. zt is n*1. vt is l*m*n. xt yt and zt are equally spaced.

x0=xt(1);
y0=yt(1);
z0=zt(1);
dx=xt(2)-xt(1);
dy=yt(2)-yt(1);
dz=zt(2)-zt(1);
nx=((x-x0)/dx);
ix=floor(nx)+1;
ny=((y-y0)/dy);
iy=floor(ny)+1;
nz=((z-z0)/dz);
iz=floor(nz)+1;
dx1=nx+1-ix;
dx2=1-dx1;
dy1=ny+1-iy;
dy2=1-dy1;
dz1=nz+1-iz;
dz2=1-dz1;

v00z=dz2*vt(ix,iy,iz)+dz1*vt(ix,iy,iz+1);
v10z=dz2*vt(ix+1,iy,iz)+dz1*vt(ix+1,iy,iz+1);
v01z=dz2*vt(ix,iy+1,iz)+dz1*vt(ix,iy+1,iz+1);
v11z=dz2*vt(ix+1,iy+1,iz)+dz1*vt(ix+1,iy+1,iz+1);
v0yz=dy2*v00z+dy1*v01z;
v1yz=dy2*v10z+dy1*v11z;
v=dx2*v0yz+dx1*v1yz;
end

