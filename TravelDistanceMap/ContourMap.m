clf;
A = csvread('average_times.csv', 1,1);

axesm('mercator', 'MapLatLimit', [23 55], 'MapLonLimit', [-130 -66]);
geoshow(shaperead('usastatehi.shp', 'UseGeoCoords', true),'FaceColor', [.15 .5 .15]);
geoshow(shaperead('shapefiles\mexstates\mexstates.shp', 'UseGeoCoords', true),'FaceColor', [.15 .5 .15]);
geoshow(shaperead('shapefiles\Canada_Provinces\Canada_Provinces.shp', 'UseGeoCoords', true),'FaceColor', [.15 .5 .15]);
geoshow(shaperead('shapefiles\highways\intrstat.shp', 'UseGeoCoords', true));
tightmap;

lng_lin = linspace(min(A(:,2)), max(A(:,2)), 50);
lat_lin = linspace(min(A(:,3)), max(A(:,3)), 50);
[LNG, LAT] = meshgrid(lng_lin, lat_lin);

Z = griddata(A(:,2), A(:,3), A(:,1), LNG, LAT, 'cubic');

%colormap([1 1 0] .* (linspace(0,1,20))')
colormap(hot)
%sortrows(A, 'descend');
%A([1 2],:)=[];
caxis([min(A(:,1)), max(A(A(:,1)<max(A(:,1)),1))]);
contourm(LAT, LNG, Z, 'LineWidth', 2, 'LevelStep', 1); % 'LevelList', [2:2:max(A(A(:,1)<max(A(:,1)),1))]);
scatterm(A(:,3), A(:,2), 20, A(:,1), 'filled');

colorbar('Location', 'southoutside');
saveas(gcf, 'time_contours.png');