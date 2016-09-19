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
%completedlevels=zeros(2*numOfEv,numOfExtractedB);
%completedlevels(151:450,:)=EvtoExtract(:,(iB0+2):numOfB);
extractedLevels=NaN(2*numOfEv,numOfExtractedB);
for i=1:numOfExtractedB
    tempEorder = AllEorder(i+2);
    tempBi = i+iB0+1;
    for j=1:(2*numOfEv)
        temp = tempEorder-numOfEv+j;
        try
            extractedLevels(j,i)=EvtoExtract(temp,tempBi);
            if extractedLevels(j,i)==0
                extractedLevels(j,i)=NaN;
            end
        catch err
            extractedLevels(j,i)=NaN;
        end
    end
    i
end
figure;
plot(Bextracted,extractedLevels(298,:));
