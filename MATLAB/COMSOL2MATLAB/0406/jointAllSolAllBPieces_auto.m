%% set sol name and length of m, needs modification
midSolName = 'paraGeoMeshStepPotFFBLargeRangeEScanMCalc';
len_m = 7;
numOfSols = 13;

%% get data pieces, needs modification
for i=1:numOfSols
    eval(['sol' num2str(i) '= AllSolVals_' midSolName num2str(i) '_eV;']);
end

for i=1:numOfSols
    eval(['B' num2str(i)  '= B_' midSolName num2str(i) ';']);
end



%% generate standard named variables
eval(['len_m_' midSolName 'Jointed=' num2str(len_m) ';']);
% compensate different pieces to the same length
%maxNumOfEv = max([length(sol1(:,1,1)) length(sol2(:,1,1)) length(sol3(:,1,1)) length(sol4(:,1,1)) length(sol5(:,1,1))]);

lengthTupleStr = '[';
for i=1:numOfSols
    lengthTupleStr = [lengthTupleStr ' length(sol' num2str(i) '(:,1,1)) '];
end
lengthTupleStr = [lengthTupleStr ']'];
lengthTuple = eval(lengthTupleStr);
maxNumOfEv = max(lengthTuple);

for i=1:numOfSols
    eval(['solTemp = sol' num2str(i) ';']);
    eval(['sol' num2str(i) ' = zeros(maxNumOfEv, length(B' num2str(i) '), len_m_' midSolName 'Jointed);']);
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
eval(['AllSolVals_' midSolName 'Jointed_eV=' strAllSol ';']);
eval(['B_' midSolName 'Jointed= ' strAllB ';']);


