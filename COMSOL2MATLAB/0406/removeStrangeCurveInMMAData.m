%% remove strange levels in MMA data
% You need to have CurveData already in the Workspace, which are data
% for the four strange curve. B value for those curves should be the same
% as for the EV data from MMA. THIS SCRIPT DOES NOT CHECK THIS!

%% parameters
% Bmin = 0.01;
% Bstep = 0.01;
% Bmin = 0.005;
% Bstep = 0.005;
Bmin = 0.002;
Bstep = 0.002;
Bmax = 4;
% len_m = 11;
len_m = lenM;
% thre_E = 0.00002;
% thre_E = 0.000002;
thre_E = 5e-7;
numOfCurves = 1;

% for NearEdge, these intervals are under: thre_E = 5e-7;
BExceptionIntervals = [1.112, 1.142; 1.33, 1.374; 1.672, 1.722; 2.25, 2.32];
specialBExceptionInterval = [3.42,3.584];

%% initialization
AllEVs_removed = AllEVs;
B = Bmin:Bstep:Bmax;
B_track = [];

%% remove, ver 1
% this version will remove extra levels. Max removed levels for one B value
% should be less than or equal 4
% 
% for im = 1:len_m
%     for il = 1:10000
%         if isnan(AllEVs(il,im))
%             break;
%         end
%         tmpEV = AllEVs(il,im);
%         tmpB = AllBs(il,im);
%         iB = round((tmpB-Bmin)/Bstep+1);
%         for iC = 1:4
%             if ( abs( tmpEV - CurveData(iB,iC) )<thre_E )
%                 AllEVs_removed(il,im) = NaN;
%                 break;
%             end
%         end
%     end
% 
% end


%% remove ver 2

for im = 1:len_m
    if im == 2
        tmpIntervals = [BExceptionIntervals;specialBExceptionInterval];
    else
        tmpIntervals = BExceptionIntervals;
    end
    for Bi = Bmin:Bstep:Bmax
        
        % do not remove for certain B intervals
        isInInterval = false;
        tmpSize = size(tmpIntervals);
        for iInterval = 1:tmpSize(1)
            if(Bi> tmpIntervals(iInterval,1) && Bi<tmpIntervals(iInterval,2))
                isInInterval = true;
                break;
            end
        end
        if isInInterval
            continue;
        end
        
        iStart = find(AllBs(:,im) >= Bi-Bstep/2,1,'first');
        iEnd = find(AllBs(:,im) <= Bi+Bstep/2,1,'last');
        tmpEVs = AllEVs(iStart:iEnd,im);
        iB = round((Bi-Bmin)/Bstep+1);
        for iC = 1:numOfCurves
            tmpDevs = abs(tmpEVs - CurveData(iB,iC));
            [tmpDev,ind] = min(tmpDevs);
            if tmpDev < thre_E
                AllEVs_removed(iStart+ind-1,im) = NaN;
                B_track(end+1)=Bi;
            end
        end
    end
end

%% remove particular points
EvalToRemove = -0.000484;
tmpThres = 0.0000015;
tmpBStart = 0.3;
tmpBStop = 0.39;
for im = 11
    for Bi = tmpBStart:Bstep:tmpBStop        
        iStart = find(AllBs(:,im) >= Bi-Bstep/2,1,'first');
        iEnd = find(AllBs(:,im) <= Bi+Bstep/2,1,'last');
        tmpEVs = AllEVs(iStart:iEnd,im);
        iB = round((Bi-Bmin)/Bstep+1);
        tmpDevs = abs(tmpEVs - EvalToRemove);
        [tmpDev,ind] = min(tmpDevs);
        if tmpDev < tmpThres
            AllEVs_removed(iStart+ind-1,im) = NaN;
        end
    end
end

%% plot to check the result of the remove
figure
hold all
for i = 1:lenM
plot(AllBs(:,i),AllEVs_removed(:,i),'.')
end



%% remove NaN in AllEVs_removed
% iEV_max = 3740;     % largest index of non NaN EV, look it up in AllEVs_removed
iEV_max = 8650;
AllEVs_removed_NaNRemoved = NaN(iEV_max,len_m);
AllBs_NaNRemoved = NaN(iEV_max,len_m);
for im = 1:len_m
    iEV_NaNRemoved = 1;
    for iEV = 1:iEV_max
        if (~isnan(AllEVs_removed(iEV,im)))
            AllEVs_removed_NaNRemoved(iEV_NaNRemoved,im) = ...
                AllEVs_removed(iEV,im);
            AllBs_NaNRemoved(iEV_NaNRemoved,im) = ...
                AllBs(iEV,im);
            iEV_NaNRemoved = iEV_NaNRemoved + 1;
        end
    end
        
end




%% output to file
solName = 'ListSol0920TLGExpPotLMFBAP';
ms = -200:20:0;
for im = 1:len_m
    ind_lastNoneNaN = find(~isnan(AllEVs_removed_NaNRemoved(:,im)),1,'last');
    tmpOut = [AllBs_NaNRemoved(1:ind_lastNoneNaN,im), ...
        AllEVs_removed_NaNRemoved(1:ind_lastNoneNaN,im)];
    fname = [solName '_m=' num2str(ms(im)) '.dat'];
    save(fname,'tmpOut','-ascii');
end


%% output EVs in meV
% solName = 'ListSol0920TLGExpPotLMFBAPmeV';
solName = 'ListSol0925TLGTheoPotMTNearEdgeAPmeV';

% ms = -200:20:0;
ms = -1:1:1;
for im = 1:len_m
    ind_lastNoneNaN = find(~isnan(AllEVs_removed_NaNRemoved(:,im)),1,'last');
    tmpOut = [AllBs_NaNRemoved(1:ind_lastNoneNaN,im), ...
        1e3*AllEVs_removed_NaNRemoved(1:ind_lastNoneNaN,im)];
    fname = [solName '_m=' num2str(ms(im)) '.dat'];
    save(fname,'tmpOut','-ascii');
end

