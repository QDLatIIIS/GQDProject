nit=sum(ni,4);
nited=reshape(mean(nit,1),51,3,10,10)+reshape(mean(nit,2),51,3,10,10);
%intnt=sum(intn,2);
figure
hold on
for i=1:3
%    surf(E1,E3,reshape(nited(25,i,:,:),numel(E1),numel(E3)))
 %   surf(E1,E3,reshape(intnt(i,1,:,:),numel(E1),numel(E3)))
 %   plot(E1,reshape(intnt(i,1,:,2),numel(E1),1))
 surf(kx,ky,reshape(nit(:,:,i,1,10,10),51,51))
end
hold off
