%% given up...Read eigenvalues from COMSOL models which is already loaded
%on to the COMSOL server.
%%
%Parameters: 
%%It returns [AllSolVals, errNum], where AllSolVals are the solved
%%eigenvalues and errNum are labels of solution reading of which is failed

%below are remained notes during development
%20160124£º
%lenB = 208;
%20160125£º

%20160124:
%len_m = 11;
%20160125:
%%
%function [tempAllSolVals, errNum]=readTLGSolVals(modelName, approxNumOfEvs, BVals, len_m, orderOfFirstSol)

%lenB = length(B_paraGeoMeshStepPotFBBV2);
%len_m = len_m_paraGeoMeshStepPotFBBV2;
midSolName = 'evenMeshExpStepPotWEWM2Calc';

modelName = ['model' midSolName];

eval(['lenB=length(B_' midSolName  ');']);
eval(['len_m=len_m_' midSolName ';']);
approxNumOfEvs = 300;
firstSol = 5;

%lenB = length(BVals);
%firstSol = orderOfFirstSol;
%tempAllSolVals = zeros(approxNumOfEvs,lenB,len_m);

tempAllSolVals = zeros(approxNumOfEvs,lenB,len_m);
errNum = zeros(2000,1);
i_error = 0;
for i = 1:lenB
    for j = 1:len_m
        solName = ['''sol' num2str(firstSol-1+(i-1)*len_m + j) ''''];
        try
            eval(['tempSol = mphsolinfo(' modelName ',''soltag'',' solName ');']);
            solVals = tempSol.solvals;
            for k = 1:length(solVals)
                tempAllSolVals(k,i,j) = solVals(k);
            end
        catch exception
            display(exception.message)
            i_error = i_error+1;
            errNum(i_error) = firstSol-1+(i-1)*len_m + j;
            %exception
        end
    end
end

eV = 1.6e-19;
eval(['AllSolVals_' midSolName '_eV=real(tempAllSolVals/eV);']);
%end