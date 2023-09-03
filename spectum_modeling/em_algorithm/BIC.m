function [value] = BIC(n,k,log_likelihood)
    value = (log(n) * ((k * 3) - 1)) - (2 * log_likelihood);
end

