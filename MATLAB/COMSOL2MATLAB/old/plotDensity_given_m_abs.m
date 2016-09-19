%parameters
B = 0:0.02:4.14;
E = -0.005:0.0001:0.105;
dataToPlot = AllSolVals_eV0124;
m = 1;

m = m+6;
EnergyDensity3 = zeros(length(E),length(B));
for i = 1:length(B)
    for j = 1:length(E)
        EnergyDensity3(j,i)=0;
            for Ev = 1:130
                if real(dataToPlot(Ev,i,m)) == 0
                    continue
                end                
                EnergyDensity3(j,i)=EnergyDensity3(j,i)+2.718282^(-abs(E(j)-real(dataToPlot(Ev,i,m)))/0.0001);
            end
        %EnergyDensity(i,j) = log(EnergyDensity(i,j));
    end
end
figure;
hsurf = contourf(B,E,EnergyDensity3,50,'EdgeColor','none');
title(['Density of State, m = ' num2str(m-6)])
xlabel('B/T')
ylabel('E/eV')