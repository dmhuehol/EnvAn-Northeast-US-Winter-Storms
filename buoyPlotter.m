%BUG: Currently requires that all fields have same number of entries
%BUG: x-axis tick count is wack
%ADDITION: needs wetbulb temperature

function [extract] = buoyPlotter(startTime,endTime,buoy)
%%buoyPlotter
    %Plots certain meteorological and oceanographic variables from NDBC
    %buoy data against time.
    %
    %General form:
    %[extract] = buoyPlotter(startTime,endTime,buoy)
    %
    %Outputs:
    %extract: extract of the buoy data structure corresponding to the input
    %times.
    %
    %Inputs:
    %startTime: starting datenum in YYYY,MM,DD,HH,MM,SS
    %endTime: ending datenum in YYYY,MM,DD,HH,MM,SS
    %buoy: a buoy data structure
    %
    %Version Date: 6/26/2018
    %
    %Written by: Daniel Hueholt
    %North Carolina State University
    %Undergraduate Research Assistant at Environment Analytics
    %
    %See also buoyImport
    %

%% Find time indices
allTime = [buoy.time];
allTime = allTime(:);
logicalStart = logical(allTime==startTime);
startInd = find(logicalStart==1);
logicalEnd = logical(allTime==endTime);
endInd = find(logicalEnd==1);

extract.time = allTime(startInd:endInd);

%% Extract data

allTemp = [buoy.temp];
allTemp = allTemp(:);
extract.temp = allTemp(startInd:endInd);

allDew = [buoy.dewpoint];
allDew = allDew(:);
extract.dew = allDew(startInd:endInd);

allSST = [buoy.sst];
allSST = allSST(:);
extract.sst = allSST(startInd:endInd);

airColor = [70 161 251]./255; %moderate blue
dewColor = [3 84 165]./255; %dark blue
seaColor = [84 237 161]./255; %foam

%% Plotting
figure;
seaPlot = plot(extract.time,extract.sst);
set(seaPlot,'Color',seaColor)
set(seaPlot,'LineWidth',2.8)
hold on
airPlot = plot(extract.time,extract.temp);
set(airPlot,'Color',airColor)
set(airPlot,'LineWidth',2.8)
hold on
dewPlot = plot(extract.time,extract.dew);
set(dewPlot,'Color',dewColor)
set(dewPlot,'LineWidth',2.8)
leg = legend(['Sea Surface Temperature, ' char(176) 'C'],['Air Temperature, ' char(176) 'C'],['Dewpoint, ' char(176) 'C']);
tlabel('x','dd HH:MM','keepticks','labelYM','')
axe = gca;
set(axe,'FontName','Lato Bold')
dateString{1} = datestr(extract.time(1),'yyyy-mm-dd, HH:MM');
dateString{2} = datestr(extract.time(end),'yyyy-mm-dd, HH:MM');
t = title(['Buoy data spanning ' dateString{1} ' to ' dateString{2}]);
set(t,'FontName','Lato Bold')
set(t,'FontSize',16)
yl = ylabel([char 176 'C']);
set(yl,'FontSize',16)


end