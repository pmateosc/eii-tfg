%modificacion del modelo de Cucker-Smael según arbor
function [acc]=cs_arbor(XV,n,g)
acc=zeros(n,2);

X=XV(:,[1:2]);
V=XV(:,[3:4]);
normDifVel=zeros(n,1);

for ii = 1:n
    difVel = V([1:n],:)-V(ii,:);
    
    normDifVel=sqrt(sum(difVel.*difVel,2));
    normDifVel(ii)=1;
    
    difX = X([1:n],:)-X(ii,:);
    d2 = (difX(:,1).^2)+(difX(:,2).^2);

    num = difVel./(normDifVel.^(0.5));
    den = (1+d2).^g;

    vec_sum = num./den;
    sumatorio = sum(vec_sum);
    acc(ii,:) = sumatorio./n;
    
end

end