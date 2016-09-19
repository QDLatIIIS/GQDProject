function pot = potential( x, y )
%POTENTIAL function describes a step potential
%   此处显示详细说明
if(x<-2)||(x>2)
    pot = 0;
elseif (x^2+y^2)<1.5^2
    pot =0;
elseif abs(y)<0.25
    pot=0.5;
else
    pot=1;
end
end

