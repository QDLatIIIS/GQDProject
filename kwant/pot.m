function p = pot( x,y )
%POT 此处显示有关此函数的摘要
%   此处显示详细说明
[nx,ny]=size(x);
p = zeros(nx,ny);
for i=1:1:nx
    for j=1:1:ny
        p(i,j) = potential(x(i,j),y(i,j));
    end
end
end

