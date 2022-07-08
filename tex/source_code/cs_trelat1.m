%Modelo 1 de Cucker Smale según trelat
function [acc]=cs_trelat1(XV,n,g)
acc=zeros(n,2);

X=XV(:,[1:2]);
V=XV(:,[3:4]);
medVel = sum(V)./n;

for ii = 1:n
    difVel = V([1:n],:)-V(ii,:);
   
    difX = X([1:n],:)-X(ii,:);
    d2 = (difX(:,1).^2)+(difX(:,2).^2);

    num = difVel;
    den = (1+d2).^g;

    vec_sum = num./den;
    sumatorio = sum(vec_sum);
    acc(ii,:) = sumatorio./n;
    acc(ii,:) = 0.5*(acc(ii,:)+(medVel-V(ii,:)));
    
end

end