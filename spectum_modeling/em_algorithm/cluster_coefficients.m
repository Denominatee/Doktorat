function [coefficients] = cluster_coefficients(values, distributions)
k = length(distributions.mu);
likelihoods = zeros(k,length(values));
for i = 1:k
    likelihoods(i,:) = normpdf(values(:,1),distributions.mu(i),distributions.sigma(i));
end
denominator = zeros(1,length(values));
for i = 1:k
    denominator = denominator + distributions.lambda(i)*likelihoods(i,:);
end
coefficients = zeros(k,length(values));
for i = 1:k
    numerator = distributions.lambda(i)*likelihoods(i,:);
    coefficients(i,:) = numerator./denominator;
end
end

