function [distributions] = fast_distributions(values, weights)
if isempty(weights) 
    n = sum(values(:,2));
    mu = sum(values(:,1).*values(:,2))/n;
    sigma = sqrt(sum((values(:,1)-mu).^2.*values(:,2)/n));
    distributions.mu(1)=mu;
    distributions.sigma(1)=sigma;
    distributions.lambda(1)=1;
    return
end   
n_of_clusters = length(weights(:,1));
wsum = weights * values(:,2);
for i = 1:n_of_clusters
    v = values(:,1).*values(:,2);
    distributions.mu(i) = sum(weights(i,:)*v)/wsum(i);
    distributions.sigma(i) = sqrt((weights(i,:).*((values(:,1)-distributions.mu(i)).^2).')*values(:,2)/wsum(i));
end
distributions.lambda = wsum/sum(values(:,2));
end

