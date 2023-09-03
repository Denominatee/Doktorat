function [feature] = feature_value(distribution)
    %returns value of feature described by a single distribution
    mz = get_mz();
    mz_min = distribution.mu - 5 * distribution.sigma;
    mz_max = distribution.mu + 5 * distribution.sigma;
    start_index = find(mz <= mz_min,1,'last');
    end_index = find(mz >= mz_max,1,'first'); 
    if isempty(start_index)
       start_index=1;
    end
    if isempty(end_index)
       end_index=length(mz);
    end  
    x = mz(start_index : end_index);
    y = distribution.lambda * normpdf(x, distribution.mu, distribution.sigma);
    part_of_spectra = channels(start_index,end_index);
    feature = part_of_spectra * y.';
end

