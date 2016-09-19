%plot E vs B
m = 5;
numOfEv = 100;
m_order = m + 6;
B = 0:0.02:4.14;
solName = 'AllSolVals_eV0124';

figure;
head = 'h = plot(';
cmd = [head 'B,' solName '(1,:,' num2str(m_order) '),''b'' '];
for i = 2:numOfEv
    cmd = [cmd  ', B, ' solName '(' num2str(i) ',:,' num2str(m_order) '),'];
    if rem(i,4) == 1
        cmd = [cmd '''b'''];
    end
    if rem(i,4) == 2
        cmd = [cmd '''r'''];
    end
    if rem(i,4) == 3
        cmd = [cmd '''g'''];
    end
    if rem(i,4) == 0
        cmd = [cmd '''m'''];
    end
end
cmd = [cmd ');'];
eval(cmd);
%h = plot(0:0.1:12,AllSolVals_eV(1,:,m_order),'b', 0:0.1:12,AllSolVals_eV(2,:,6),'r',0:0.1:12,AllSolVals_eV(3,:,6),'g', 0:0.1:12,AllSolVals_eV(4,:,6),'m', 0:0.1:12,AllSolVals_eV(5,:,6),'b', 0:0.1:12,AllSolVals_eV(6,:,6),'r', 0:0.1:12,AllSolVals_eV(7,:,6),'g');
title(['E vs B, m = ' num2str(m)])
xlabel('B/T')
ylabel('E/eV')
for i = 1:numOfEv
set(h(i),'Marker','.','LineStyle','none');
%set(h(i),'Marker','o');
end