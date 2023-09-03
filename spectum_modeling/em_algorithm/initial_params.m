function [distributions] = initial_params(values, k)
%RANDOM_PARAMS This function makes an inital guess for the EM algorithm to start from
    min_value = min(values(:,1));
    max_value = max(values(:,1));
    distributions = struct();
    distributions.mu = zeros(k,1);
    distributions.sigma = zeros(k,1);
    distributions.lambda = zeros(k,1);
    lambda_sum = 0;
    for i = 1:k
       distributions.mu(i) = (max_value - min_value).*rand() + min_value; 
       distributions.sigma(i) = (max_value-min_value)/2*rand();
       if (i == k)
           distributions.lambda(i) = 1 - lambda_sum;
       else
           distributions.lambda(i) = rand()*(1-lambda_sum);
           lambda_sum = lambda_sum + distributions.lambda(i);
       end
    end
end

