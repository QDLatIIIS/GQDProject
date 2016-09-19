function pot = potential2( x, y )
%POTENTIAL function describes a step potential
%   �˴���ʾ��ϸ˵��
    d = cos(pi/6)*y+sin(pi/6)*x;
    pot = tanh(d);
end

