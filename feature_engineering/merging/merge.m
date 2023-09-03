function [features] = merge(features)
    path = char(strcat(pwd,'\data\peacock_test_distribution\sampl1dist.mat'));
    load(path);
    gmm_arr(1)= peacock_test_distribution;
    path = char(strcat(pwd,'\data\peacock_test_distribution\sampl2dist.mat'));
    load(path);
    gmm_arr(2)= peacock_test_distribution;
    path = char(strcat(pwd,'\data\peacock_test_distribution\sampl3dist.mat'));
    load(path);
    gmm_arr(3)= peacock_test_distribution;
    path = char(strcat(pwd,'\data\peacock_test_distribution\sampl4dist.mat'));
    load(path);
    gmm_arr(4)= peacock_test_distribution;
    dist_treshold = 0.75;
    %new field of stucture
    [features(:).merged] = deal(features([]));
    metadata = get_metadata();
    i = 1;
    while (i < length(features))
        disp(i);
        f1 = features(i);
        running = true;
        j = 1;
        while(i+j <= length(features))
            f2 = features(i+j);  
            %Check if in range
            if (f1.mu + dist_treshold < f2.mu)
                break;
            end
            %Peacock's test for each sample
            p_arr = zeros(1,4);
            for k=1:4
                bin = cell2mat({metadata(:).s_nr})==k;
                f1_bin = f1.value(bin,:);
                f2_bin = f2.value(bin,:);
                xy = get_xy(k,false);
                KSstatistic = peacock2d(f1_bin,f2_bin,xy);
                p_arr(k) = get_p_value(gmm_arr(k),KSstatistic);
            end
            %Combine p-values with Fisher method
            p_value = fisher(p_arr);
            if (p_value > 0.05)
                if (isLarger(f1,f2))
                    f1.merged(end+1) = rmfield(features(i+j),'merged');
                    features(i) = f1;
                    features(i+j) = [];
                    j = j - 1;
                else
                    f2.merged(end+1) = rmfield(features(i),'merged');
                    features(i+j) = f2;
                    features(i) = [];
                    i = i - 1;
                break;
                end         
            end
                j = j + 1;
        end  
        i = i + 1;
    end
end

function result = isLarger(f1,f2)
    x = -2:0.01:2;   
    npd1 =  f1.lambda * normpdf(x, 0, f1.sigma);
    npd2 =  f2.lambda * normpdf(x, 0, f2.sigma);
    s1 = sum(npd1);
    s2 = sum(npd2);
    result = s1 > s2;
end

function group_pval = fisher(pvals) 
    chi_vals = -2.*log(pvals);
    group_pval = 1 - chi2cdf(sum(chi_vals),2*length(pvals));
end

function p = get_p_value(gmm,x)
    id = find(gmm.mu==min(gmm.mu));
    p = gmm.sigma(id) * normpdf(x, gmm.mu(id), gmm.sigma(id));
end