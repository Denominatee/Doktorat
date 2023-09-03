function [params,L,params_log,L_log] = em(values,k)    
    %W przypdaku 1 klastra po prostu liczymy średnią, odchylenie standardowe i log likelihood
    if (k == 1)
        params = fast_distributions(values,[]);
        params_log = params;
        L = log_likelihood(values,params);
        L_log = L;
        return
    end    
    %Losujemy parametry dla klastrów
    params = initial_params(values,k);    
    init_L = log_likelihood(values,params);
    i=1;
    eps = -inf;
    shift = 0;
    params_log(1) = params;
    L_log(1) = init_L;
    %Wykonywanie pętli dopóki log likelihood jest lepszy od poprzedniej iteraacji o wartość eps 
    while (shift > eps)
        %Ochrona przed sytuacjami kiedy sigma dązy do inf
        if any(params.sigma < 10^-3)
            [params,L,params_log,L_log] = em(values,k);  
            return
        end
        coefficients = cluster_coefficients(values, params);  
        if any(isnan(coefficients(:)))
            [params,L,params_log,L_log] = em(values,k);  
            return
        end
        params = fast_distributions(values, coefficients);
        L = log_likelihood(values,params);  
        i = i + 1;
        params_log(i) = params;
        L_log(i) = L;
        shift = L - init_L; 
        if(i==2)
            eps = abs((L - init_L) / 10^4);
        end
        init_L = L;               
    end 
end