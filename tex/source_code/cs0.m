%algoritmo de consenso Cucker-Smale
function [ acc ] = cs0(XV,n,g)
    acc=zeros(n,2);
    
    X=XV(:,[1:2]);
    V=XV(:,[3:4]);
    
    for ii = 1:n
        difV = V([1:n],:)-V(ii,:);
    
        difX = X([1:n],:)-X(ii,:);
        d2 = (difX(:,1).^2)+(difX(:,2).^2);
    
        num = difV;
        den = (1+d2).^g;
    
        vec_sum = num./den;
        sumatorio = sum(vec_sum);
        acc(ii,:) = sumatorio./n;
    end
end

