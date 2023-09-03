function [] = plot_distribution(distribution)
f = figure;
size = length(distribution(end).mu);
distribution = distribution(end);
x = -50:0.0001:120;
y = zeros(size+1,length(x));
for i = 1:size
    y(i+1,:) = distribution.lambda(i) * normpdf(x, distribution.mu(i), distribution.sigma(i));
end
y(1,:) = sum(y);   
%figure
hold on
for i = 1:size+1
    plot(x,y(i,:),LineWidth=2);
end
hold off
set(gca,'ytick',[])
box off
axis tight
width = 1200;
height = 800;
f.Position = [10 10 width height];
end

