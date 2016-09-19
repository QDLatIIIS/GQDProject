%this script plot the energy levels vs B, can also plot Landau Levels

%% set default value for isPlotLL, mmin, mmax and orderOfEv
orderOfEv = 1;
mmin = -0;
%mmax = mmin;
mmax = 0;
%Plot LL?
plotLL = false;

%% initialization of len_m, B and solName

% modify this!!
midSolName='paraGeoMeshStepPotFFBLargeRangeEScanM2to3Calc1';
numOfEv = 300;
%mmin=-2;mmax=2;

eval(['len_m = len_m_' midSolName ';']);
m_0 = (len_m+1)/2;
eval(['B = B_' midSolName ';']);
solName = ['AllSolVals_' midSolName '_eV'];

%% plot E vs B
figure;
head = 'h = plot(';
cmd = ['B,' solName '(1,:,' num2str(mmin+m_0) '),''b'' '];
for mi = mmin:mmax
    m_order_i = mi + m_0;
    for i = (1:numOfEv) + orderOfEv - 1
        cmd = [cmd  ', B, ' solName '(' num2str(i) ',:,' num2str(m_order_i) '),'];
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
end

%% calculate accurate level with no E field
if plotLL
g1 = 0.4;
DeltaB = 0.03519960458095233*sqrt(B);
E1 = zeros(numOfEv,length(B));
for n = 0:(floor(numOfEv/2) - 1)
    coef_b = -2*g1^2 - 3*(n + 1)*DeltaB.^2;
    coef_c = g1^4 + 2*(1 + n)*g1^2 *DeltaB.^2 + (2 + 6 *n + 3 *n^2)*DeltaB.^4;
    coef_d = -n *(n + 1)* (n + 2)* DeltaB.^6;
    coef_R = -coef_b.^3/27 + coef_b.* coef_c/6 - coef_d/2;
    coef_Q = coef_b.^2/9 - coef_c/3;
    coef_theta = acos(coef_R./sqrt(coef_Q.^3));
    E1(n+1,:) = sqrt(2 *sqrt(coef_Q).*cos((coef_theta + 2 *pi)/3) - coef_b/3);
    cmd = [cmd ',B,E1(' num2str(n+1) ',:),''k'''];
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
for i = 1:(numOfEv*(mmax-mmin+1)+1)
set(h(i),'Marker','.','LineStyle','none');
%set(h(i),'Marker','o');
end