nt=0.2e15:0.2e15:1e16;
nb=-nt;
numnt=length(nt);
numnb=length(nb);
Eft=zeros(numnt,numnb);
Deltat=Eft;
parfor i=1:numnt
    nti = nt(i);
    for j=1:numnb
        temp = ntnbtoEfDelta(nti,nb(j),T1,T2,T3,Ef,E1,E3);
        Eft(j,i)=temp(1);
        Deltat(j,i)=temp(2);
    end
end
figure
surf(nt,nb,Eft)
xlabel('nt');ylabel('nb');