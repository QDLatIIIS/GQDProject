
B = 0.01:0.01:1;
E = -0.06:0.0001:0.06;
dataToPlot = AllSolVals_biggerGap_eV;
m = 0;
m_0 = 3;

m = m+m_0;
EnergyDensity3 = zeros(length(E),length(B));
for i = 1:length(B)
    for j = 1:length(E)
        EnergyDensity3(j,i)=0;
            for Ev = 1:130
                if real(dataToPlot(Ev,i,m)) == 0
                    continue
                end                
                EnergyDensity3(j,i)=EnergyDensity3(j,i)+2.718282^(-(E(j)-real(dataToPlot(Ev,i,m)))^2/0.0000001);
            end
        %EnergyDensity(i,j) = log(EnergyDensity(i,j));
    end
end
figure;
hsurf = contourf(B,E,EnergyDensity3,50,'EdgeColor','none');
title(['Density of State, m = ' num2str(m-m_0)])
xlabel('B/T')
ylabel('E/eV')