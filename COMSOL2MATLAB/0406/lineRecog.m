%% Line pattern recognition
% This script recognize line patterns from discrete data points

%% parameters
Xs = Bs;
% Ys = 1000*EVs;
Ys = EVs;       % do not need to convert to meV for near edge data
% % Xstep = 0.01;
% Xstart = 10;
% % Xstep = 2e-3;
% Xstep = 0.05;
% Xstop = 40;

Xstart = 0.5; Xstep = 1e-2; Xstop = 10;

thres = 1;
% thres = 0.01;   % smaller threshold for near edge data
% thres = 0.5;
% NumOfLines = 1000;   % these are from estimation
% NumOfLines = 6000;
NumOfLines = 100000;

%% initialization
Xregular = Xstart:Xstep:Xstop;
NumOfXs = length(Xregular);
AllLines = NaN(NumOfLines,NumOfXs);
TotalPoints = length(Xs);
Xmax = Xstop;

[XsSorted, indSorted] = sort(Xs);
YsSorted = Ys(indSorted);

% add All Y points of first X point to RightEnds
indX = 1;
CurrentMaxNumOfLines = find(XsSorted < Xstart + Xstep * 0.1, 1, 'last');
AllLines(1:CurrentMaxNumOfLines,indX) = YsSorted(1:CurrentMaxNumOfLines);

%%
CurrentX = Xstart;
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



















