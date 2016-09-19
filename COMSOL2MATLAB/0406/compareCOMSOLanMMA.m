figure
hold on
for i=1:numOfEv
    plot(B_evenMeshExpStepPotWECalc,AllSolVals_evenMeshExpStepPotWECalc_eV(i,:,1),'Marker','.','LineStyle','none')
end
plot(Bmma,Emma,'r','Marker','.','LineStyle','none','MarkerSize',2)
plot(Bmmabf,Emmabf,'g','Marker','.','LineStyle','none','MarkerSize',2)
hold off