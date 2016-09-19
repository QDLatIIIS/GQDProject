H=zeros(6);
Hdiag=H;
a=1.42e-10;
E1=0:0.001:0.02;
E3=-E1;
kx=0*4*pi/3/a;
ky=0/a;
kn=kx-ky*1i;
kp=kx+ky*1i;
H(1,2)=v*hbar*kn/e;
H(3,4)=v*hbar*kn/e;
H(5,6)=v*hbar*kn/e;
H(2,1)=v*hbar*kp/e;
H(4,3)=v*hbar*kp/e;
H(6,5)=v*hbar*kp/e;
H(2,3)=gamma1/e;
H(4,5)=gamma1/e;
H(3,2)=gamma1/e;
H(5,4)=gamma1/e;
En=zeros(6,6,numel(E1),numel(E1));
Vec=En;
for i=1:numel(E1)
    for j=1:numel(E1)
        Hdiag(1,1)=E1(i);
        Hdiag(2,2)=E1(i);
        Hdiag(5,5)=E3(j);
        Hdiag(6,6)=E3(j);
        [Vec(:,:,i,j),En(:,:,i,j)]=eig(H+Hdiag);
    end
end
figure
hold on
for i=1:6
    plot(E3,reshape(abs(Vec(i,1,1,:)).^2,1,numel(E1)))
end
hold off
%when E3=0, |ci|^2 proportion to E1, vice versa