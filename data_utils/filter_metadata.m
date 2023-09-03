function [output] = filter_metadata(classes,varargin)
%Filters metadata by class and sample number 
%filter_metadata([1 2],[2, 3]) will return metadata only for spectrum from
%samples 2 and 3 with class 1 or 2
    metadata = get_metadata();
    bin = zeros(1,length(metadata));
    if isempty(classes)
        output = metadata;
    else
        for i=1:length(classes)
            temp_bin = cell2mat({metadata(:).class})==classes(i);
            bin = bin | temp_bin; 
        end
        output = metadata(bin);
    end
    
    samples = varargin{1};
    if isempty(samples)
        return;
    end
    bin = zeros(1,length(output));
    for i=1:length(samples)
        temp_bin = cell2mat({output(:).s_nr})==samples(i);
        bin = bin | temp_bin; 
    end
     output = output(bin);
end

