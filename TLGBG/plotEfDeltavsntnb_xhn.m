nb=0e15:0.02e15:1.5e16;
nt=-nb;
numnt=length(nt);
numnb=length(nb);
Eft=zeros(numnt,numnb);
Deltat=Eft;
completenum=0;
parfor i=1:numnt
    nti = nt(i);
    for j=1:numnb
        temp = ntnbtoEfDelta_xhn(nti,nb(j),T1,T2,T3,Ef,E1,E3);
        Eft(j,i)=temp(1);
        Deltat(j,i)=temp(2);
    end
    i
end
figure
surf(nt,nb,Eft)
xlabel('nt');ylabel('nb');