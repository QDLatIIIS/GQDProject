%this script plot the energy levels vs B, can also plot Landau Levels

%% set default value for isPlotLL, mmin, mmax and orderOfEv
orderOfEv = 1;
mmin = -200;
mminToPlot = -80;
mmax = -80;
mstep = 20;
% m_0 = (len_m+1)/2;
% m_0 = 3;
%Plot LL?
plotLL = true;

%% initialization of len_m, B and solName

% modify this!!
midSolName='evenMeshExpStepPotWEWMCalcJointed';
numOfEv = 300;
%mmin=-2;mmax=2;

eval(['len_m = len_m_' midSolName ';']);

eval(['B = B_' midSolName ';']);
solName = ['AllSolVals_' midSolName '_eV'];

%% plot E vs B
figure;
head = 'h = plot(';
cmd = ['B,' solName '(1,:,' num2str((mminToPlot - mmin)/mstep + 1) '),''b'' '];
for mi = mminToPlot:mstep:mmax
    m_order_i = (mi - mmin)/mstep + 1;
    if rem(m_order_i,7) == 1
        colorstr = '''blue''';
    end
    if rem(m_order_i,7) == 2
        colorstr = '''red''';
    end
    if rem(m_order_i,7) == 3
        colorstr = '''green''';
    end
    if rem(m_order_i,7) == 4
        colorstr = '''magenta''';
    end
    if rem(m_order_i,7) == 5
        colorstr = '''cyan''';
    end
    if rem(m_order_i,7) == 6
        colorstr = '''black''';
    end
    if rem(m_order_i,7) == 0
        colorstr = '''yellow''';
    end
    for i = (1:numOfEv) + orderOfEv - 1
        cmd = [cmd  ', B, ' solName '(' num2str(i) ',:,' num2str(m_order_i) '),' colorstr];
    end
end



%% execute the plot command
cmd = [head cmd ');'];
eval(cmd);
%below is useless, already included in string cmd, which has been executed
%above.
%h = plot(0:0.1:12,AllSolVals_eV(1,:,m_order),'b', 0:0.1:12,AllSolVals_eV(2,:,6),'r',0:0.1:12,AllSolVals_eV(3,:,6),'g', 0:0.1:12,AllSolVals_eV(4,:,6),'m', 0:0.1:12,AllSolVals_eV(5,:,6),'b', 0:0.1:12,AllSolVals_eV(6,:,6),'r', 0:0.1:12,AllSolVals_eV(7,:,6),'g');
title(['E vs B, ' midSolName])
xlabel('B/T')
ylabel('E/eV')

%% set plotting style:
for i = 1:length(h)
%set(h(i),'Marker','.','LineStyle','none','MarkerSize',0.5);
set(h(i),'Marker','.','LineStyle','none');
%set(h(i),'Marker','o');
end