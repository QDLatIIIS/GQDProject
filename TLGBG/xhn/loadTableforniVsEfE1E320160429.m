load('TableforniVsEfE1E320160429.mat')
Tp=permute(Table_nivsEfE1E3,[1,3,2,4]);%rearrange the dimenson in order to execute interpolation
T1=reshape(Tp(1,:,:,:),numel(E1),numel(Ef),numel(E3));
T2=reshape(Tp(2,:,:,:),numel(E1),numel(Ef),numel(E3));
T3=reshape(Tp(3,:,:,:),numel(E1),numel(Ef),numel(E3));