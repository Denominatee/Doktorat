if (~exist('aggregated_spectrum','var'))
    load(char(strcat(pwd,'\data\workflow\aggregated_spectrum.mat')));
end
points = div_points(aggregated_spectrum);
close
mz = get_mz();
f = figure;
width = 1600;
height = 800;
f.Position = [10 10 width height]; 
axis tight
box off
set(gca,'ytick',[])
set(gca,'YColor','none')
hold on
plot(mz,aggregated_spectrum);
plot(mz(points),aggregated_spectrum(points),'go','MarkerSize',3)