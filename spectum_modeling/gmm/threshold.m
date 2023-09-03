function [d,biclog] = threshold(values,start)
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
            [temp, log_likelihood] = fast_em(start_index,values);
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