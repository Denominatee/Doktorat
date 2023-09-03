function [rtrn] = get_metadata()
    if ~(exist('metadata','var'))
        load(strcat(pwd,'\data\metadata.mat'),'metadata');
    end
    rtrn = metadata;
end

