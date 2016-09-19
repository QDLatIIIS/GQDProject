%% import MMA EV data, multi m

%% parameters
dirname = 'C:\Users\jwt\Documents\GitHub\GQDProject\TLGAnalyticTheory\data\MMAdata\';
SolName = 'ListSol0629TLGExpPotLM';
mVals = -200:20:0;
lenB = 400;
lenM = length(mVals);
%% initialization
AllEVs = NaN(10000,lenM);
AllBs = AllEVs;
% AllEVs = [];

%%
i = 1;
for m = mVals
    filename = [dirname SolName '_m=' num2str(m) '.dat'];
    
    [B, EVs] = importMMAEVdata(filename);
    AllEVs(1:length(EVs),i) = EVs;
    AllBs(1:length(EVs),i) = B;
    i = i + 1;
end