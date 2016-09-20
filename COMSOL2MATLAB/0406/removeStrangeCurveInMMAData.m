%% remove strange levels in MMA data
% You need to have CurveData already in the Workspace, which are data
% for the four strange curve. B value for those curves should be the same
% as for the EV data from MMA. THIS SCRIPT DOES NOT CHECK THIS!

%% parameters
% Bmin = 0.01;
% Bstep = 0.01;
Bmin = 0.005;
Bstep = 0.005;
Bmax = 4;
len_m = 11;
% thre_E = 0.00002;
thre_E = 0.000002;


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
    for Bi = Bmin:Bstep:Bmax
        iStart = find(AllBs(:,im) >= Bi-Bstep/2,1,'first');
        iEnd = find(AllBs(:,im) <= Bi+Bstep/2,1,'last');
        tmpEVs = AllEVs(iStart:iEnd,im);
        iB = round((Bi-Bmin)/Bstep+1);
        for iC = 1:4
            tmpDevs = abs(tmpEVs - CurveData(iB,iC));
            [tmpDev,ind] = min(tmpDevs);
            if tmpDev < thre_E
                AllEVs_removed(iStart+ind-1,im) = NaN;
                B_track(end+1)=Bi;
            end
        end
    end
end

% remove particular points
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
solName = 'ListSol0920TLGExpPotLMFBAPmeV';
ms = -200:20:0;
for im = 1:len_m
    ind_lastNoneNaN = find(~isnan(AllEVs_removed_NaNRemoved(:,im)),1,'last');
    tmpOut = [AllBs_NaNRemoved(1:ind_lastNoneNaN,im), ...
        1e3*AllEVs_removed_NaNRemoved(1:ind_lastNoneNaN,im)];
    fname = [solName '_m=' num2str(ms(im)) '.dat'];
    save(fname,'tmpOut','-ascii');
end

