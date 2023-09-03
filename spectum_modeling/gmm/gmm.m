function [k,GMM_array,BIC_array,BF_array] = gmm(values)
    BF_array = [];
    BIC_array = [];
    n = sum(values(:,2));
    stop = false;
    k=1;
    while (~stop)      
        [GMM, logLikelihood] = em(values,k);
        BIC_array(end + 1) = BIC(n,k, logLikelihood); 
        if (length(BIC_array) > 1) % after 1st run checking for stop condition           
            BF_array(end + 1) = get_bf(BIC_array);
            if (BIC_array(end-1) < BIC_array(end))
                stop = true;
            end
        end        
        if (~stop)  
            GMM_array(k) = GMM;        
            k = k +1;
        end
    end
    function [BF] = get_bf(BIC_array)
         B0 = BIC_array(end-1);
         B1 = BIC_array(end);
         BF = exp((B0-B1)/2);
    end
end