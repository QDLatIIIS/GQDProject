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

B=0:-1:-5;
Vb=0.15:0.75:15;
lenB = length(B);
len_m = 3;
lenVoff=length(Vb);
modelName = 'model1';
approxNumOfEvs = 10;
firstSol = 7518;

%lenB = length(BVals);
%firstSol = orderOfFirstSol;
%tempAllSolVals = zeros(approxNumOfEvs,lenB,len_m);

tempAllSolVals = zeros(approxNumOfEvs,lenB,len_m,lenVoff);
errNum = zeros(2000,1);
i_error = 0;
for i = 1:lenB
    for j = 1:len_m
        for l=1:lenVoff
            solName = ['''sol' num2str(firstSol-1+((i-1)*len_m + j-1)*lenVoff+l) ''''];
            try
                eval(['tempSol = mphsolinfo(' modelName ',''soltag'',' solName ');']);
                solVals = tempSol.solvals;
                for k = 1:length(solVals)
                    tempAllSolVals(k,i,j,l) = solVals(k);
                end
            catch exception
                i_error = i_error+1;
                errNum(i_error) = 4+(i-1)*len_m + j;
                %exception
            end
        end
    end
end
%end