function [model] = spectr_model(division_points,aggregated_spectrum)
    spectrum_parts = spectr_parts(division_points,aggregated_spectrum);
    for i=1:length(spectrum_parts)
        part = spectrum_parts(i);
        values = get_values(part);
        k = number_of_components(values);
        part_GMM = part_model(values,k); 
        scaled_part_GMM = scale_gmm(part, part_GMM); 
        model(i) = scaled_part_GMM;
    end
    array = model_to_array(models);
    T = struct2table(array);
    sortedT = sortrows(T, 1);
    sortedS = table2struct(sortedT);
    model = sortedS;
end