function [parts] = spectr_parts(division_points,signal)
    x = get_mz();
    y = signal;
    parts = struct();
    parts(1).x = x(1:division_points(1));
    parts(1).y = y(1:division_points(1));
    for i=2:numel(division_points)
        partX = x(division_points(i-1):division_points(i));
        partY = y(division_points(i-1):division_points(i));  
        parts(i).x = partX;
        parts(i).y = partY;
        parts(i).offset = 0;
    end
    for i=1:length(parts)
        part = parts(i);
        parts(i) = offset_part(part);
    end     
end
function [part] = offset_part(part)
   y = part.y;
   offset = min(y);
   y = y-offset;
   part.y = y;
   part.offset = offset;
end