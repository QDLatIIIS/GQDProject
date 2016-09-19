%no E field
function accurateLLWithoutE(B,n)

    g1 = 0.4;

    function out = DeltaB(B)
        out = 0.03519960458095233*sqrt(B);
    end
    
    function out = coef_b(B,n)
        out = -2*g1^2 - 3*(n + 1)*DeltaB(B)^2;
    end
    function out = coef_c(B,n)
        out = g1^4 + 2*(1 + n)*g1^2 *DeltaB(B)^2 + (2 + 6 *n + 3 *n^2)*DeltaB(B)^4;
    end
    function out = coef_d(B,n)
        out = -n *(n + 1)* (n + 2)* DeltaB(B)^6;
    end

    function out = coef_R(B,n)
        out = -coef_b(B, n)^3/27 + coef_b(B, n)* coef_c(B, n)/6 - coef_d(B, n)/2;
    end
    function out = coef_Q(B,n)
        out = coef_b(B, n)^2/9 - coef_c(B, n)/3;
    end
    function out = coef_theta(B,n)
        out = acos(coef_R(B, n)/sqrt(coef_Q(B, n)^3));
    end

    function out = E1(B,n)
        out = sqrt(2 *sqrt(coef_Q(B, n)) *cos((coef_theta(B, n) + 2 *pi)/3) - coef_b(B, n)/3);
    end
    function out = E2(B,n)
        out = sqrt(2 *sqrt(coef_Q(B, n)) *cos((coef_theta(B, n) + 4 *pi)/3) - coef_b(B, n)/3);
    end
    function out = E3(B,n)
        out = sqrt(2 *sqrt(coef_Q(B, n)) *cos(coef_theta(B, n)) - coef_b(B, n)/3);
    end


end
