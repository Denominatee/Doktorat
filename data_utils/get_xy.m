function [xy] = get_xy(spec_nr, bin)
    if bin
        md = filter_metadata([1 2],spec_nr);
    else
        md = filter_metadata([],spec_nr);
    end
    x = cell2mat({md(:).x});
    y = cell2mat({md(:).y});
    xy = [x.' y.'];
end

