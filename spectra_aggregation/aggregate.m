function [output] = aggregate(type, varargin)
    types = ['avg ', 'max ', 'percentile'];
    if ~contains(types,type)
        error('Error. \nType %s is invalid. \nValid types are %s.',type,types)
    end
    
    if isempty(varargin)
        percentile = 50;
    else
        percentile = varargin{1};
    end    
    mz = get_mz();
    output = zeros(1,length(mz));
    for i=1:length(mz)
        mz_channel = channel(i);
        if strcmp(type,'avg')
            output(i) = sum(mz_channel)/length(mz_channel);           
            continue;
        end
        if strcmp(type,'max')
            output(i) = max(mz_channel);
            continue;
        end
        if strcmp(type,'percentile')
            output(i) = prctile(mz_channel, percentile);
            continue;
        end  
    end
end