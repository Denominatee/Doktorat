function [model_array] = model_to_array(models)
    model_array = struct();
    index = 1;
    for i=1:length(models)
        model = models(i);
        for j=1:length(model.mu)
            model_array(index).mu = model.mu(j);
            model_array(index).sigma = model.sigma(j);
            model_array(index).lambda = model.lambda(j);
            index = index + 1;
        end       
    end
end