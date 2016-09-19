paras
krx=0.5/a0;
kxmin = 0;
kxstep = (kmax-kmin)/100;
kxmax = krx;
kry=0;
kymin = (4*pi/3)/a0-kry;
kystep = 0.01/a0;
kymax = (4*pi/3)/a0+kry;

kx = kxmin:kxstep:kxmax;
ky = kymin:kystep:kymax;

E1=-0.02:0.0005:0.02;
E3=E1;
intn=zeros(3,3,numel(E1),numel(E1));
ni=zeros(numel(kx),numel(ky),3,6,numel(E1),numel(E1));
Ei=zeros(numel(kx),numel(ky),6,numel(E1),numel(E1));
for i=1:numel(E1)
    for j=1:numel(E3)
        for laynum=1:3
            for Enum=1:3
                 %{
                fun=@(kx,ky) returneigvec( kx,ky,Enum,laynum,E1(i),E3(j));
                intn(laynum,Enum,i,j)=integral2(fun,kxmin,kxmax,kymin,kymax,'RelTol',1e-5,'AbsTol',0);
               %} 
                for ikx=1:numel(kx)
                    for iky=1:numel(ky)
                        [ni(ikx,iky,laynum,Enum,i,j),Ei(ikx,iky,Enum,i,j)]=returneigvec( kx(ikx),ky(iky),Enum,laynum,E1(i),E3(j));
                    end
                    
                end
                
            end
        end
        100*i+j
    end
    
end
% the integral proportion to E1 and E3
%E1 and E3 hardly change the shape of the valence band
%integral area for valence band in k space can be within a circle centerred at K with radius 0.5/a0