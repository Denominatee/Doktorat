function [indexes] = div_points(signal,rng,alfa)
    indexes = []; 
    min_distance = 20;
    search=false;
    i = 1;
    if ~exist('rng','var')
       rng = 300;
    end
    if ~exist('alfa','var')
       alfa = 15;
    end
    for i = 2:numel(signal)
        if (signal(i)<signal(i-1)) %decreasing
            decreasing = true;
        else
            decreasing = false;
        end        
        treshold = get_treshold();       
        if (signal(i)<treshold && search == false)
            start_index=i;
            search=true;
        end       
        if (decreasing && signal(i)>treshold && search == true)
           search=false; 
           end_index = i;
           add_to_indexes();
        end
    end

    function add_to_indexes()
        window = signal(start_index:end_index);
        local_min = min(window);
        min_idx = find(window==local_min) + start_index -1;
        if (~isempty(indexes))            
            last = indexes(end);
            if (last+min_distance>min_idx)
                if (signal(last) > signal(min_idx))                   
                    indexes(end) = min_idx;
                end
            else
                indexes = [indexes min_idx];
            end
        else
           indexes = [min_idx];
        end
    end    
    function [t] = get_treshold()
        if i <= rng/2
            window = signal(1:rng);
        elseif (i+rng)>=numel(signal)
            window = signal(end-rng:end);
        else
            window = signal(i-(rng/2):i+(rng/2));
        end
        t = prctile(window, alfa);
    end  
    function plotp()
        figure
        hold on
        if i<=rng
            plot(signal(1:i+rng))         
        elseif (i+rng)>=numel(signal)
            plot(signal(i-rng:end))
        else
            plot(signal(i-rng:i+rng));
        end
        t = xlim; % current y-axis limits
        plot([t(1) t(2)],[treshold treshold],'-r')
    end
end