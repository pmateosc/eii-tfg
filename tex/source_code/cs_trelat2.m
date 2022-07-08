%Modelo 2 de Cucker Smale según trelat
function [acc]=cs_trelat2(XV,n,g)
acc=zeros(n,2);

X=XV(:,[1:2]);
V=XV(:,[3:4]);
normDifVel2=zeros(n,1);
medVel = sum(V)./n;
difVel2= medVel-V;

for jj=1:n
    normDifVel2(jj)=norm(difVel2(jj,:)); 
end
k=find(normDifVel2==max(normDifVel2));  

for ii = 1:n
    difVel = V([1:n],:)-V(ii,:);
    
    difX = X([1:n],:)-X(ii,:);
    d2 = (difX(:,1).^2)+(difX(:,2).^2);

    num = difVel;
    den = (1+d2).^g;

    vec_sum = num./den;
    sumatorio = sum(vec_sum);
    acc(ii,:) = sumatorio./n;  
    
end
acc(k,:) = 0.5*(acc(k,:)+(medVel-V(k,:)));
end