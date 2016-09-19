sols=Esols;
lenB=length(B);
lenV=length(Vb);
Ecount=zeros(lenB,lenV);
for i=1:lenB
   for j=1:lenV
       solsAllm=sols(:,i,:,j);
       for k=1:numel(solsAllm)
           if (0<real(solsAllm(k)))&&(real(solsAllm(k))<0.5)
               Ecount(i,j)=Ecount(i,j)+1;
           end
       end
   end
end
figure
contourf(Vb,B,Ecount,50,'EdgeColor','none')