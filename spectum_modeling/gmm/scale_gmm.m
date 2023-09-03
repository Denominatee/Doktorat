function [distribution] = scale_gmm(part, distribution)      
        size = length(distribution.mu);
        y = zeros(size,length(part.x));
        for j = 1:size
            y(j,:) = distribution.lambda(j) * normpdf(part.x, distribution.mu(j), distribution.sigma(j));
        end
        if ~isvector(y)
            y = sum(y);    
        end
        part_area = trapz(part.x,part.y);
        distribution_area = trapz(part.x,y);
        scale = part_area / distribution_area;
        distribution.lambda = distribution.lambda * scale;
end