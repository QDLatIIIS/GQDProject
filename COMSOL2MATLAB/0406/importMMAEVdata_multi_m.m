%% import MMA EV data, multi m

%% parameters
dirname = 'C:\Users\jwt\Documents\GitHub\GQDProject\TLGAnalyticTheory\data\MMAdata\';
% SolName = 'ListSol0919TLGExpPotLM';
% SolName = 'ListSol0920TLGExpPotLMFB';
% SolName = 'ListSol0610TLGFinerBAndELargerEmax';
% SolName = 'ListSol0922TLGTheoPotLM';
% SolName = 'ListSol0923TLGTheoPotNearEdge';
% SolName = 'ListSol0925TLGTheoPotMTNearEdge';
SolName = 'ListSol0923TLGTheoPotNearEdge';

% mVals = -200:20:0;
mVals = -1:1:1;
% mVals = -2:2:1;
% BVals = 0.01:0.01:4;
BVals = 0.002:0.002:4;
lenB = length(BVals);
lenM = length(mVals);
% estiNumOfE = 25000;
estiNumOfE = 20000;
%% initialization
AllEVs = NaN(estiNumOfE,lenM);
AllBs = AllEVs;
% AllEVs = [];

%%
i = 1;
for m = mVals
    filename = [dirname SolName '_m=' num2str(m) '.dat'];
    
    [Bs, EVs] = importMMAEVdata(filename);
    AllEVs(1:length(EVs),i) = EVs;
    AllBs(1:length(EVs),i) = Bs;
    i = i + 1;
end