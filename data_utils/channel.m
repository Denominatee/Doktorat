function [ output ] = channel(index)
workspace_directory = pwd;
spectra_files = dir(fullfile(workspace_directory,'/data/specimens/*.mat'));
output = [];
for k = 1:length(spectra_files)
	baseFileName = spectra_files(k).name;
    spectra_file = matfile(baseFileName);
    output = [output ; spectra_file.data(:,index)]; 
end
end

