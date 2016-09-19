plottocheck = false;
% set out put
outputFinek=kxfine*a0;
outputFinek=transpose(outputFinek);
outputFineEv = bandsfine(:,3);
outputFineEc = bandsfine(:,4);
outputFineE = [outputFineEv, outputFineEc];
outputk=kx*a0;
outputk=transpose(outputk);
outputBands=bands(floor(lenky/2)+1,:,:);
tempSize = size(outputBands);
outputBands=reshape(outputBands,tempSize(2:3));
%plot ot check
if plottocheck
figure;
hold on
plot(outputFinek,outputEv);
plot(outputFinek,outputEc);
hold off
xlabel('kx(1/a0)');ylabel('E(eV)');
title(['Vt=' num2str(Vt) ', Vb=' num2str(Vb)]);

figure;
hold on
for i=1:6
    plot(outputk,outputBands(:,i));
end
hold off
xlabel('kx(1/a0)');ylabel('E(eV)');
title(['Vt=' num2str(Vt) ', Vb=' num2str(Vb)]);
end

save('Finek.txt','outputFinek','-ascii')
save('k.txt','outputk','-ascii')
save('FineE Vt=4.txt','outputFineE','-ascii')
save('Bands Vt=4.txt','outputBands','-ascii')

