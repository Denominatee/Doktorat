function [threshold] = lambda_threshold(model)
    T = struct2table(model);
    lambdas = T.lambda;
    s = [lambdas' ; ones(1,length(lambdas))]';
    distribution = gmm2(s);
    size = length(distribution(end).mu);
    distribution = distribution(end);
    distribution.mu = distribution.mu';
    distribution.sigma = distribution.sigma';
    T = struct2table(distribution);
    sortedT = sortrows(T, 1);
    sortedT.mu(1);
    x = -50:0.01:120;
    d1 = sortedT.lambda(1) * normpdf(x, sortedT.mu(1), sortedT.sigma(1));
    d2 = sortedT.lambda(2) * normpdf(x, sortedT.mu(2), sortedT.sigma(2));
    idx = find(d1>d2,1,'last');  
    threshold = x(idx);
end

function [d] = gmm2(values,start)
    %tic
    iteration_distributions = 0;
    if exist('start','var')
       start_index = start;   
    else
       start_index = 1;
       start = 1;
    end
    index = 1;
    n = sum(values(:,2));
    isContinue = true;
    bic = +inf;
    while (isContinue)
        iteration_bic = +inf;
        for i = 1:5
            [temp, log_likelihood] = em(values,start_index);
            if any(temp.sigma < 10^-6)
                i = i - 1;
                continue;
            end
            temp_bic = BIC(n,start_index,log_likelihood);
            if (temp_bic < iteration_bic)
                iteration_bic = temp_bic;
                iteration_distributions = temp;
            end
        end
        %stop conditions for number of elements in GMM
        biclog(index) = iteration_bic;
        if (start_index ~= start)
            grad = gradient(biclog);
            %if (index > 20)
            %    isContinue = false;
            %end
            if (grad(end) > 0)
                isContinue = false;
            end
            if (check(grad))
                isContinue = false;
            end             
        end
        if (isContinue)
            d(index) = iteration_distributions;           
            distributions = iteration_distributions;
            bic = iteration_bic;
            index = index + 1;  
            start_index = start_index +1;
        end
    end
    %toc
    
    
    function [r] = check(grad)
        t = 0.1*(max(grad)-min(grad));
        v = abs(grad(end) - grad(end-1));
        r = v < t;
    end
end