%20160122£º
%B = 0:0.02:4.14;
%20160126
B= 0:0.1:3;
E = -0.005:0.0001:0.105;
dataToPlot = AllSolVals0125_2_eV;
len_m = 5;


EnergyDensity3 = zeros(length(E),length(B));
for i = 1:length(B)
    for j = 1:length(E)
        EnergyDensity3(j,i)=0;
        for m = 1:len_m
            for Ev = 1:130
                if real(dataToPlot(Ev,i,m)) == 0
                    continue
                end                
                EnergyDensity3(j,i)=EnergyDensity3(j,i)+2.718282^(-(E(j)-real(dataToPlot(Ev,i,m)))^2/0.00000001);
            end
        end
        %EnergyDensity(i,j) = log(EnergyDensity(i,j));
    end
end
figure;
hsurf = contourf(B,E,EnergyDensity3,50,'EdgeColor','none');
title('Density of State')
xlabel('B/T')
ylabel('E/eV')