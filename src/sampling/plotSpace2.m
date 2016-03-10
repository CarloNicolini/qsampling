function plotSpace2(vProj,vModul)
x=vProj(:,1);
y=vProj(:,2);
z=vModul;

minx = min(x);
maxx = max(x);
miny = min(y);
maxy = max(y);
meanValue = mean(z);

heatMapImage = zeros(100,100);%meanValue  * ones(100, 100);
for k = 1 : length(x)
  column = round( (x(k) - minx) * 100 / (maxx-minx) ) + 1;
  row = round( (y(k) - miny) * 100 / (maxy-miny) ) + 1;
  heatMapImage(row, column) = z(k);
end
imagesc(heatMapImage);
colorbar;
