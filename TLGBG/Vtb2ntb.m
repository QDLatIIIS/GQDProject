%% Vt, Vb to nt, nb
paras;
Vt = 4;
Vb = -16;
dist = 100e-9;
disb = 300e-9;
plotSurf = false;

%% calculate nt, nb and solve for n1, n2, n3
% while calculating nt & nb, there might be a factor 2
nt = -epsilon0*kappa*Vt/e/dist;
nb = -epsilon0*kappa*Vb/e/disb;

levelarm=4.85;
%nt = nb*Vt/Vb*levelarm;
nb = nt*Vb/Vt/levelarm;