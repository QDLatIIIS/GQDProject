%plot E vs B
figure;
h = plot(0:0.1:12,EVal1st,'b', 0:0.1:12,EVal2nd,'r',0:0.1:12,EVal3rd,'g', 0:0.1:12,EVal4th,'m', 0:0.1:12,EVal5th,'b', 0:0.1:12,EVal6th,'r', 0:0.1:12,EVal7th,'g');
xlabel('T')
ylabel('E')
for i = 1:7
%set(h(i),'Marker','.','LineStyle','none');
set(h(i),'Marker','o');
end