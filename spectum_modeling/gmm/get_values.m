function [values] = get_values(part)
    x = part.x;
    y = part.y;
    values = zeros(length(x),2);
    for j = 1:length(x)
        if y(j) < 0
            count = 0;
        else
            count = int64(y(j)*1000);   
        end
    values(j,1) = x(j);
    values(j,2) = count;
    end
end