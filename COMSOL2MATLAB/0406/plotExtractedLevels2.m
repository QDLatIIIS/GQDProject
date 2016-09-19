numOfTotalLevel=386;
Ec = 0.0003;
%clear zero
extractedLevelsAddEc = extractedLevels;
for i=1:numOfTotalLevel
    for j=1:numOfExtractedB
        if extractedLevels(i,j)~=0
            extractedLevelsAddEc(i,j)=extractedLevels(i,j)+Ec*i;
        end
    end
end
figure;
hold on
for i=1:numOfTotalLevel    
    if rem(i,2) == 1
        colorstr = 'blue';
    end
    if rem(i,2) == 0
        colorstr = 'red';
    end
    h=plot(Bextracted,extractedLevelsAddEc(i,:),colorstr);
    %set(h,'Marker','.','LineStyle','none','MarkerSize',0.3);
end
title(['Ec = ' num2str(Ec) 'eV']);
hold off;