function p = pot( x,y )
%POT �˴���ʾ�йش˺�����ժҪ
%   �˴���ʾ��ϸ˵��
[nx,ny]=size(x);
p = zeros(nx,ny);
for i=1:1:nx
    for j=1:1:ny
        p(i,j) = potential(x(i,j),y(i,j));
    end
end
end

