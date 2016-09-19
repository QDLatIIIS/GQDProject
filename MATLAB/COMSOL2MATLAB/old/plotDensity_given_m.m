%parameters
%20160122
%B = 0:0.02:4.14;
%20160125
%B = 0:0.1:3;
%smaller finer B:
%B = 0:0.01:0.77;
B = B_paraGeoMesh;
E = -0.1:0.005:0.35;
numOfEv = 150;
dataName = 'AllSolVals_paraGeoMesh_eV';
m = 1;
m_0 = 3;
sigma_E_sq = 0.00000005;

eval(['dataToPlot = ' dataName ';']);
m = m+m_0;
EnergyDensity3 = zeros(length(E),length(B));
for i = 1:length(B)
    for j = 1:length(E)
        EnergyDensity3(j,i)=0;
            for Ev = 1:numOfEv
                if real(dataToPlot(Ev,i,m)) == 0
                    continue
                end                
                EnergyDensity3(j,i)=EnergyDensity3(j,i)+2.718282^(-(E(j)-real(dataToPlot(Ev,i,m)))^2/sigma_E_sq);
            end
        %EnergyDensity(i,j) = log(EnergyDensity(i,j));
    end
end
figure;
hsurf = contourf(B,E,EnergyDensity3,50,'EdgeColor','none');
title([dataName ', Density of State, m = ' num2str(m-m_0) ', sigma_E_sq = ' num2str(sigma_E_sq)])
xlabel('B/T')
ylabel('E/eV')