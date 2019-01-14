function [siteData] = eraT(filename,siteLat,siteLon,timeIndex,pressureAtSurface)
%%eraT
    %Plots temperature profiles for input European Reanalysis data
    %filename: file of ERA5 data file, containing temperature
    %siteLat: latitude of site you're looking for, rounded to nearest 0.25
    %siteLon: longitude of site you're looking for on 360 grid, rounded to nearest 0.25
    %timeIndex: index of the proper time within the netCDF file
    %pressureAtSurface: surface pressure--ERA5 interpolates data below the
    %surface when converting from eta to p-coordinates

%filename = 'adaptor.mars.internal-1542755538.6847239-31036-17-c2b42330-714a-4b12-994f-3ee6263bf575.nc';

[lat] = ncread(filename,'latitude'); %0.25 lat
[lon] = ncread(filename,'longitude'); %0.25 lon on a 360 grid
[levels] = ncread(filename,'level');
[temp] = ncread(filename,'t'); %dimensions lon,lat,level,time

%CSU-CHILL latitude = 40.445961
%CSU-CHILL longitude = 104.636811
DEN_launch_latitude = 39.7675;
DEN_launch_longitude = 360-104.8694;
%latDEN = 39.75; lonDEN = 360-104.75;

%siteLat = 40.5;
%siteLon = 104.75;

logicLat = lat==siteLat;
logicLon = lon==siteLon;

latFound = find(logicLat);
lonFound = find(logicLon);

siteData = temp(lonFound,latFound,:,:);

%timeIndex = 2;

tempProfile = temp(lonFound,latFound,:,timeIndex);
%disp(lonFound); disp(latFound)
tempProfileC = tempProfile-273.15;
tempProfileC_2DNoMask = reshape(tempProfileC,[37,1,[]]);

levelMask = levels<=pressureAtSurface;
levelsMasked = levels(levelMask);
tempProfileC_2D = tempProfileC_2DNoMask(levelMask);

eraTvZ = plot(tempProfileC_2D,levelsMasked);
eraTvZ.LineWidth = 3;
eraTvZ.Color = [0 112 115]./255;
ylim([300 pressureAtSurface])
hold on
freezeLine = plot([0 0],[1000 300]);
freezeLine.LineWidth = 3;
freezeLine.Color = [204 0 0]./255;

axe = gca;
axe.FontName = 'Open Sans';
axe.FontSize = 14;
set(gca,'Ydir','reverse')
xLab = xlabel(['Temperature (' char(176) 'C)']);
xLab.FontName = 'Open Sans';
xLab.FontSize = 16;
yLab = ylabel('Pressure (hPa)');
yLab.FontName = 'Open Sans';
yLab.FontSize = 16;

time = ncread(filename,'time');
time = double(time);
timeToShow = time(timeIndex);
timeToShowSec = timeToShow*3600;
datetimeToShow = datetime(timeToShowSec,'ConvertFrom','epochtime','Epoch','1900-01-01');

t = title(['ERA5 Temperature Profile for ' datestr(datetimeToShow)]);
t.FontName = 'Open Sans';
t.FontSize = 18;

disp(datetimeToShow)

boundaryLat = [siteLat-2,siteLat+2];
boundaryLon = [360+wrapTo180(siteLon)-2,360+wrapTo180(siteLon)+2];
figure;
usamap(boundaryLat,boundaryLon);
hold on
usCountiesShapefile = '/Volumes/EMTECC450/county_shapes/US_county_boundaries.shp';
countyShapes = shaperead(usCountiesShapefile,'UseGeoCoords',true);
geoshow(countyShapes,'FaceColor',[0 112 128]./255)
hold on
disp(360-siteLon)
era = geoshow(siteLat,360+wrapTo180(siteLon),'DisplayType','point','MarkerEdgeColor',[204 0 0]./255,'MarkerSize',3);
hold on
launch = geoshow(DEN_launch_latitude,360+wrapTo180(DEN_launch_longitude),'DisplayType','Point','MarkerEdgeColor',[255 155 48]./255,'MarkerSize',3);
leg = legend([era,launch],{'ERA location','Denver launch site'});
leg.FontName = 'Open Sans';


end