%accurate Landau level
%no E field
%parameters:
g1 = 0.4;
B = 0:0.1:12;
n = 40;

E1 = zeros(n+1,length(B));
E2 = E1;
E3 = E1;
head = 'plot(';
nmax = n;
n = 0;

DeltaB = 0.03519960458095233*sqrt(B);
coef_b = -2*g1^2 - 3*(n + 1)*DeltaB.^2;
coef_c = g1^4 + 2*(1 + n)*g1^2 *DeltaB.^2 + (2 + 6 *n + 3 *n^2)*DeltaB.^4;
coef_d = -n *(n + 1)* (n + 2)* DeltaB.^6;
coef_R = -coef_b.^3/27 + coef_b.* coef_c/6 - coef_d/2;
coef_Q = coef_b.^2/9 - coef_c/3;
coef_theta = acos(coef_R./sqrt(coef_Q.^3));
E1(1,:) = sqrt(2 *sqrt(coef_Q).*cos((coef_theta + 2 *pi)/3) - coef_b/3);
E2(1,:) = sqrt(2 *sqrt(coef_Q).*cos((coef_theta + 4 *pi)/3) - coef_b/3);
E3(1,:) = sqrt(2 *sqrt(coef_Q).*cos((coef_theta)/3) - coef_b/3);
figure;
cmd = [head 'B,E1(1,:),''r'',B,E2(1,:),''b'',B,E3(1,:),''g'''];
for n = 1:nmax
    coef_b = -2*g1^2 - 3*(n + 1)*DeltaB.^2;
    coef_c = g1^4 + 2*(1 + n)*g1^2 *DeltaB.^2 + (2 + 6 *n + 3 *n^2)*DeltaB.^4;
    coef_d = -n *(n + 1)* (n + 2)* DeltaB.^6;
    coef_R = -coef_b.^3/27 + coef_b.* coef_c/6 - coef_d/2;
    coef_Q = coef_b.^2/9 - coef_c/3;
    coef_theta = acos(coef_R./sqrt(coef_Q.^3));
    E1(n+1,:) = sqrt(2 *sqrt(coef_Q).*cos((coef_theta + 2 *pi)/3) - coef_b/3);
    E2(n+1,:) = sqrt(2 *sqrt(coef_Q).*cos((coef_theta + 4 *pi)/3) - coef_b/3);
    E3(n+1,:) = sqrt(2 *sqrt(coef_Q).*cos((coef_theta)/3) - coef_b/3);
    cmd = [cmd ',B,E1(' num2str(n+1) ',:),''r'',B,E2(' num2str(n+1) ',:),''b'',B,E3(' num2str(n+1) ',:),''g'''];
end
cmd = [cmd ');'];
eval(cmd);

