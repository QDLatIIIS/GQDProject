%% remove strange levels in MMA data
% You need to have CurveData already in the Workspace, which are data
% for the four strange curve. B value for those curves should be the same
% as for the EV data from MMA. THIS SCRIPT DOES NOT CHECK THIS!

%% parameters
Bmin = 0.01;
Bstep = 0.01;
Bmax = 4;
len_m = 11;
thre_E = 0.00002;


%% initialization
AllEVs_removed = AllEVs;
B = Bmin:Bstep:Bmax;

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
        iStart = find(AllBs(:,im) >= Bi,1,'first');
        iEnd = find(AllBs(:,im) <= Bi,1,'last');
        tmpEVs = AllEVs(iStart:iEnd,im);
        iB = round((Bi-Bmin)/Bstep+1);
        for iC = 1:4
            tmpDevs = abs(tmpEVs - CurveData(iB,iC));
            [tmpDev,ind] = min(tmpDevs);
            if tmpDev > thre_E
                continue;
            else
                AllEVs_removed(iStart+ind-1,im) = NaN;
            end
        end
    end
end













