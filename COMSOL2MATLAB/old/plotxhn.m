figure
hold on 
E=real(Esols);
B=abs(B);
Vb=abs(Vb);
for i=1:10
  %  scatter(Vb,reshape(E(i,1,1,:),numel(Vb),1),'.r');
    scatter(Vb,reshape(E(i,1,2,:),numel(Vb),1),'.g');
  % scatter(Vb,reshape(E(i,1,3,:),numel(Vb),1),'.b');
 %   scatter(Voff,reshape(E(i,2,1,:),numel(Voff),1),'b');
%    scatter(B,reshape(E(i,:,1,21),numel(E(i,:,3,21)),1),'.r');
%    scatter(B,reshape(E(i,:,2,21),numel(E(i,:,3,21)),1),'.g');
%    scatter(B,reshape(E(i,:,3,21),numel(E(i,:,3,21)),1),'.b');
 %   scatter(B,reshape(E(i,:,1,2),numel(E(i,:,3,1)),1),'.b');
 %   scatter(B,reshape(E(i,:,2,2),numel(E(i,:,3,1)),1),'.b');
 %   scatter(B,reshape(E(i,:,3,2),numel(E(i,:,3,1)),1),'.b');
end