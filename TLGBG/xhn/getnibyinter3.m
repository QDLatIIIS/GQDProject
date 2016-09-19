function [ n ] = getnibyinter3( Efnew,E1new,E3new,T1t,T2t,T3t,Eft,E1t,E3t )
%should follow loadTablefroniVsEfE1E3 first. T1t,T2t,T3t,Eft,E1t,E3t should be filled by T1,T2,T3,Ef,E1,E3 (already loaded from the table)


n=zeros(3,1);

n(1)=inter3(Eft,E1t,E3t,T1t,Efnew,E1new,E3new);

n(2)=inter3(Eft,E1t,E3t,T2t,Efnew,E1new,E3new);

%try
n(3)=inter3(Eft,E1t,E3t,T3t,Efnew,E1new,E3new);
%catch err
%    err.getReport
%    n(3) = 0;
%end
end