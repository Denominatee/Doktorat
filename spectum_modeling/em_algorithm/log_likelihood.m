function [log_likelihood] = log_likelihood(values, distributions)
    size = length(distributions.mu);
    cluster_probabilities = zeros(length(distributions),length(values));
    for i = 1:size
        l = distributions.lambda(i);
        m = distributions.mu(i);
        s = distributions.sigma(i);        
        cluster_probabilities(i,:) = l * normpdf(values(:,1),m,s);
    end
    if (size ==1)
        log_likelihood = sum(log(cluster_probabilities).'.*values(:,2));
        return
    else
    points_probabilities = sum(cluster_probabilities);
    log_likelihood = sum(log(points_probabilities).'.*values(:,2));
    end
end