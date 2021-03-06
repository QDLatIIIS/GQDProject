m = 0;
lenB = 121;
len_m = 11;
eV = 1.6e-19;
EVal1st = zeros(lenB,1);
EVal2nd = EVal1st;
EVal3rd = EVal1st;
EVal4th = EVal1st;
EVal5th = EVal1st;
EVal6th = EVal1st;
EVal7th = EVal1st;
for i = 1:lenB
    solName = ['sol' num2str(4+(i-1)*len_m + m + 6)];
    infoTLGsol = mphsolinfo(modelTLGnew,'soltag',solName);
    EVal1st(i) = infoTLGsol.solvals(1)/eV;
    EVal2nd(i) = infoTLGsol.solvals(2)/eV;
    EVal3rd(i) = infoTLGsol.solvals(3)/eV;
    EVal4th(i) = infoTLGsol.solvals(4)/eV;
    EVal5th(i) = infoTLGsol.solvals(5)/eV;
    EVal6th(i) = infoTLGsol.solvals(6)/eV;
    EVal7th(i) = infoTLGsol.solvals(7)/eV;
end