%test
%kxmin = -2*pi/a0;
%kxstep = 0.1/a0;
%kxmax = 2*pi/a0;
%kymin = -2*pi/a0;
%kystep = 0.1/a0;
%kymax = 2*pi/a0;

kxmin = -0.5/a0;
kxstep = 0.01/a0;
kxmax = 0.5/a0;
kymin = (4*pi/3-0.5)/a0;
kystep = 0.01/a0;
kymax = (4*pi/3+0.5)/a0;

kx = kxmin:kxstep:kxmax;
ky = kymin:kystep:kymax;

Delta12 = 0.1;
Delta23 = 0.1;

bands = zeros(length(kx),length(ky),6);
C1_kx_ky = zeros(length(kx),length(ky));

i=1;
for kxi = kxmin:kxstep:kxmax
    j=1;
    for kyi = kymin:kystep:kymax
        %tempHam = getHamiltonian(kx,ky,Delta12, Delta23);
        [EVecs, EValues] = eig(getHamiltonian(kxi, kyi, Delta12, Delta23));
        %lambda = eig(getHamiltonian(kxi,kyi,Delta12, Delta23));
        for bandNum=1:6
            %bands(j, i, bandNum) = EValues(bandNum,bandNum);
            %j = (kyi - min(ky))/(0.01/a0)+1;
            %i = (kxi - min(kx))/(0.01/a0)+1;
            %bands(j, i, bandNum) = lambda(bandNum);
            bands(j, i, bandNum) = EValues(bandNum,bandNum);
        end
        j=j+1;
    end
    i=i+1;
end
%mesh(kx,ky,bands(:,:,1),kx,ky,bands(:,:,2),kx,ky,bands(:,:,3),kx,ky,bands(:,:,4),kx,ky,bands(:,:,5),kx,ky,bands(:,:,6))
figure;
mesh(kx,ky,bands(:,:,1)),hold on
mesh(kx,ky,bands(:,:,2))
mesh(kx,ky,bands(:,:,3))
mesh(kx,ky,bands(:,:,4))
mesh(kx,ky,bands(:,:,5))
mesh(kx,ky,bands(:,:,6))
hold off
