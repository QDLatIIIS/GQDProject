%% Line pattern recognition
% This script recognize line patterns from discrete data points

%% parameters
Xs = Bs;
% Ys = 1000*EVs;
Ys = EVs;       % do not need to convert to meV for near edge data
% Xstep = 0.01;
Xstep = 2e-3;
% thres = 1;
thres = 0.01;   % smaller threshold for near edge data


%% initialization
Xregular = Xstep:Xstep:Xmax;
% NumOfLines = 1000;   % these are from estimation
NumOfLines = 6000;
NumOfXs = length(Xregular);
AllLines = NaN(NumOfLines,NumOfXs);
% RightEnds = NaN(1,NumOfLines);
TotalPoints = length(Xs);
Xmax = max(Xs);

[XsSorted, indSorted] = sort(Xs);
YsSorted = Ys(indSorted);

% add All Y points of first X point to RightEnds
indX = 1;
CurrentMaxNumOfLines = find(XsSorted < Xstep * 1.1, 1, 'last');
% RightEnds(1:CurrentMaxNumOfLines) = YsSorted(1:CurrentMaxNumOfLines);
% AllLines(1:CurrentMaxNumOfLines,indX) = RightEnds(1:CurrentMaxNumOfLines);
AllLines(1:CurrentMaxNumOfLines,indX) = YsSorted(1:CurrentMaxNumOfLines);

%%
CurrentX = Xstep;
indMin = CurrentMaxNumOfLines + 1;
% indX = indX + 1;
while (CurrentX < Xmax + Xstep * 0.1)
    dNumOfLines = 0;
    EndsStatus = zeros(1,CurrentMaxNumOfLines);
    indMax = find(XsSorted < CurrentX + Xstep * 1.1, 1, 'last');
    YsToAssign = YsSorted(indMin:indMax);
    for i = 1:length(YsToAssign)
        [dY, indLine] = min( abs( AllLines( 1:CurrentMaxNumOfLines, indX )-YsToAssign(i) ) );
        if (EndsStatus(indLine)||dY>thres)          % selected line end already has a descendant
            dNumOfLines = dNumOfLines + 1;          % or the difference is beyond the threshold
            AllLines(CurrentMaxNumOfLines + dNumOfLines, indX+1) = YsToAssign(i);
        else
            AllLines(indLine, indX+1 ) = YsToAssign(i);
            EndsStatus(indLine) = true;            
        end
    end
    
    
    CurrentX = CurrentX + Xstep;
    CurrentMaxNumOfLines = CurrentMaxNumOfLines + dNumOfLines;
    indMin = indMax + 1;
    indX = indX + 1;
end

%% plot
% raw
figure
hold all
for i = 1:CurrentMaxNumOfLines
    plot(Xregular,AllLines(i,:))
end



%% remove NaN and save
tmp = 0;
save test.mat tmp;      % creating the .mat file
for i = 1:CurrentMaxNumOfLines
    indLeft = find(~isnan(AllLines(i,:)), 1, 'first');
    indRight = find(~isnan(AllLines(i,:)), 1, 'last');
    eval(['line' num2str(i) '= [Xregular(indLeft:indRight)'',AllLines(i,indLeft:indRight)''];']);
    eval(['save(''test.mat'',''line' num2str(i) ''',''-append'');']);
end



















