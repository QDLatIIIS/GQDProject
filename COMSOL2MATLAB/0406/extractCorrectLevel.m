B0 = 0.521;
tol = 10;
absolutetol=0.0005;
EvtoExtract = AllSolVals_paraGeoMeshStepPotFFBLargeRangeEJointed_eV;
BtoExtract = B_paraGeoMeshStepPotFFBLargeRangeEJointed;
[numOfEv,numOfB]=size(EvtoExtract);
for i=1:numOfB
    if BtoExtract(i)==B0
        iB0 = i;
        break
    end
end
%for i=1:numOfEv
%    if EvtoExtract(i,iB0)==0
%        ilevel= i;
%        break
%    end
%    EvtoExtract(i,iB0)
%end
Eorder = numOfEv;
numOfExtractedB = numOfB-iB0-1;
AllEorder = zeros(numOfExtractedB+2,1);
Onelevel = zeros(numOfExtractedB,1);
Bextracted = zeros(numOfExtractedB,1);
AllEorder(1) = numOfEv;
AllEorder(2) = numOfEv;
for i=1:numOfExtractedB
    AllEorder(i+2)=AllEorder(i+1);
    Eorder = AllEorder(i+2);
    pretol = tol*abs(EvtoExtract(AllEorder(i+1),i+iB0)-EvtoExtract(AllEorder(i),i+iB0-1));
    %if abs(EvtoExtract(AllEorder(i+2),i+iB0+1)-EvtoExtract(AllEorder(i+1),i+iB0))> pretol
    if abs(EvtoExtract(AllEorder(i+2),i+iB0+1)-EvtoExtract(AllEorder(i+1),i+iB0))> absolutetol
        if EvtoExtract(AllEorder(i+2),i+iB0+1) > EvtoExtract(AllEorder(i+1),i+iB0)
            while abs(EvtoExtract(Eorder,i+iB0+1)-EvtoExtract(AllEorder(i+1),i+iB0))> absolutetol
                Eorder = Eorder - 1;
            end
        else
            while abs(EvtoExtract(Eorder,i+iB0+1)-EvtoExtract(AllEorder(i+1),i+iB0))> pretol
                Eorder = Eorder + 1;
            end
        end
    end
    AllEorder(i+2)=Eorder;
    Onelevel(i)=EvtoExtract(Eorder,i+iB0+1);
    Bextracted(i) = BtoExtract(i+iB0+1);
end
figure;
plot(Bextracted,Onelevel,Bextracted,EvtoExtract(300,iB0+2:numOfB));


