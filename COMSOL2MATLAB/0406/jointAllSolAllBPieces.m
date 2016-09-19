%% set sol name and length of m, needs modification
midSolName = 'evenMeshExpStepPotWEWMCalcJointed';
len_m = 11;
numOfSols = 2;

%% get data pieces, needs modification
sol1 = AllSolVals_evenMeshExpStepPotWEWMCalc_eV;
sol2 = AllSolVals_evenMeshExpStepPotWEWM2Calc_eV;


B1 = B_evenMeshExpStepPotWEWMCalc;
B2 = B_evenMeshExpStepPotWEWM2Calc;


%% generate standard named variables
eval(['len_m_' midSolName '=' num2str(len_m) ';']);
% compensate different pieces to the same length
maxNumOfEv = max([length(sol1(:,1,1)) length(sol2(:,1,1))]);

for i=1:numOfSols
    eval(['solTemp = sol' num2str(i) ';']);
    eval(['sol' num2str(i) ' = zeros(maxNumOfEv, length(B' num2str(i) '), len_m_' midSolName ');']);
    eval(['sol' num2str(i) '(1:length(solTemp(:,1,1)),:,:) = solTemp;']);
end
strAllSol = '[sol1';
strAllB = '[B1';
for i=2:numOfSols
    strAllSol = [ strAllSol  ',sol' num2str(i) ];
    strAllB = [ strAllB ',B' num2str(i) ];
end
strAllSol = [ strAllSol  ']'];
strAllB = [ strAllB ']'];

% joint AllSolVals and all B with standard name
eval(['AllSolVals_' midSolName '_eV=' strAllSol ';']);
eval(['B_' midSolName ' = ' strAllB ';']);


