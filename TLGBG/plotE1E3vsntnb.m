nb=0e15:0.2e15:1.5e16;
nt=-nb;
numnt=length(nt);
numnb=length(nb);
E1t=zeros(numnb,numnt);
E3t=E1t;
completenum=0;
parfor i=1:numnt
    nti = nt(i);
    for j=1:numnb
        [temp,tempE13] = ntnbtoEfEcEv_xhn(nti,nb(j),T1,T2,T3,Ef,E1,E3);
        E1t(j,i)=tempE13(1);
        E3t(j,i)=tempE13(2);
    end
    i
end

figure
surf(nt,nb,E1t)
xlabel('nt');ylabel('nb');

figure
surf(nt,nb,E3t)
xlabel('nt');ylabel('nb');