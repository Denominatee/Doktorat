function [denoised_model] = denoise(model)
    threhsold = lambda_threshold(model);
    T = struct2table(model);
    nT = T(T.lambda>threhsold,:);
    denoised_model = table2struct(nT);
end