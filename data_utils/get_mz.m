function [rtrn] = get_mz()
    if ~(exist('mz','var'))
        load(strcat(pwd,'\data\metadata.mat'),'mz');
    end
    rtrn = mz;
end
