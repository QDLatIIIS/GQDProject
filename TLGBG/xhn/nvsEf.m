E1 = 0.01;
E3 = -0.01;
Ef = 0:0.0001:0.05;
ntotal = zeros(length(Ef),1);

i=1;
for Efi=0:0.0001:0.05
    ntotal(i) = sum(integralforni(Efi, E1, E3));
    i=i+1;
end