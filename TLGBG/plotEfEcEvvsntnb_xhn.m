nb=0e15:0.2e15:1.5e16;
nt=-nb;
numnt=length(nt);
numnb=length(nb);
Eft=zeros(numnb,numnt);
Ect=Eft;
Evt=Eft;
completenum=0;
parfor i=1:numnt
    nti = nt(i);
    for j=1:numnb
        temp = ntnbtoEfEcEv_xhn(nti,nb(j),T1,T2,T3,Ef,E1,E3);
        Eft(j,i)=temp(1);
        Ect(j,i)=temp(2);
        Evt(j,i)=temp(3)
    end
    i
end
figure
surf(nt,nb,Eft)
xlabel('nt');ylabel('nb');

figure
surf(nt,nb,Ect)
xlabel('nt');ylabel('nb');

figure
surf(nt,nb,Evt)
xlabel('nt');ylabel('nb');