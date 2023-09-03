function [k] = number_of_components(values)
    no_terations = 1000;
    K_ = zeros(1,no_terations);
    for i=1:no_terations
        [iteration_k] = gmm(values);
        K_(i) = iteration_k;
    end
    k = mode(K_);
end