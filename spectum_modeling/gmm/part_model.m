function [GMM] = part_model(values,k)
    n = sum(values(:,2));
    no_iterations = 100;
    bestBIC = +inf; 
    for i = 1:no_iterations    
        [currentGMM, logLikelihood] = em(values,k);           
        currentBIC = BIC(n,k,logLikelihood);           
        if (currentBIC < bestBIC)
            bestBIC = currentBIC;
            GMM = currentGMM;
        end
    end
end

