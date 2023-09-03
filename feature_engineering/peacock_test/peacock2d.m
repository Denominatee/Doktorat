function [KSstatistic] = peacock2d(f1,f2,xy)
   KSstatistic = -inf;
   %Deklaracja funkcji
   fhCounts = @(x, edge)([(x(:, 1) > edge(1)) & (x(:, 2) > edge(2))...
   (x(:, 1) <= edge(1)) & (x(:, 2) > edge(2))...
   (x(:, 1) <= edge(1)) & (x(:, 2) <= edge(2))...
   (x(:, 1) > edge(1)) & (x(:, 2) <= edge(2))]);
   n1 = sum(f1);
   n2 = sum(f2);
   for i=1:length(xy)
       current = xy(i,:);
       counts = fhCounts(xy, current);
       sum1 = counts.' * f1;
       sum2 = counts.' * f2;
       cdf1 = sum1./n1;
       cdf2 = sum2./n2;
       iteration_statistic = max(abs(cdf1 - cdf2));
       if (iteration_statistic > KSstatistic)
       KSstatistic = iteration_statistic;
       end
   end 
   %n =  n1 * n2 /(n1 + n2);
   %Zn = sqrt(n) * KSstatistic;
   %Zinf = Zn / (1 - 0.53 * n^(-0.9));
   %pValue = 2 * exp(-2 * (Zinf - 0.5).^2);
end

