function pot = potential2( x, y )
%POTENTIAL function describes a step potential
%   此处显示详细说明
    d = cos(pi/6)*y+sin(pi/6)*x;
    pot = tanh(d);
end

