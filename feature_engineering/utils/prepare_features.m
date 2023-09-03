function [denoised_model] = prepare_features(denoised_model)
    for i=1:length(denoised_model)
        distribution = denoised_model(i);
        denoised_model(i).value = feature_value(distribution);
    end
end