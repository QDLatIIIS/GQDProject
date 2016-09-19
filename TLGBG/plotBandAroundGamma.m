%kx = -0.5/a0:0.001/a0:0.5/a0;
%ky = ((4*pi/3-0.5):0.001:(4*pi/3+0.5))/a0;
kx = -0.5/a0:0.001/a0:0.5/a0;
numOfkx=length(kx);

Delta12 = -0.015;
Delta23 = 0.015;

bands = zeros(numOfkx,6);
for i=1:numOfkx
    ky = 4*pi/3/a0;
        %tempHam = getHamiltonian(kx,ky,Delta12, Delta23);
        [EVecs, EValues] = eig(getHamiltonian(kx(i),ky,Delta12, Delta23));
        for bandNum=1:6
            bands(i, bandNum) = EValues(bandNum,bandNum);
        end
end
figure;
hold on
for i=1:6
    plot(kx,bands(:,i))
end
hold off