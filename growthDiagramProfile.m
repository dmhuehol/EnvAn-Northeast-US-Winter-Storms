function [] = growthDiagramProfile(sounding,timeIndex,legLog,dateString)
%%growthDiagramProfile
    %Function to plot a balloon temperature/humidity profile on the ice growth
    %diagram.
    %
    %General form: growthDiagramProfile(sounding,timeIndex,legLog)
    %
    %Inputs
    %sounding: a processed sounding data structure, must include moisture data
    %timeIndex: the index of the desired sounding within the structure
    %legLog: logical 1/0 to plot/not plot the rather giant legend. Enabled by default.
    %
    %Requires secondary functions makeGrowthDiagramStruct,
    %iceGrowthDiagram, and eswLine
    %
    %Written by: Daniel Hueholt
    %North Carolina State University
    %Undergraduate Research Assistant at Environment Analytics
    %Version date: 4/26/2019
    %Last major revision: 4/26/2019
    %
    %See also makeGrowthDiagramStruct, iceGrowthDiagram, eswLine
    %

%% Variable checks
if ~exist('legLog','var')
    legLog = 1;
    disp('Legend enabled by default')
end
if legLog~=0 && legLog~=1
    legLog = 1;
    disp('Legend enabled by default')
end

%% Setup growth diagram
crystalLog = 1; otherLog = 1;
[hd] = makeGrowthDiagramStruct(crystalLog,otherLog); %Instantiate the structure containing all growth diagram information

freezingLineLog = 1; isohumesLog = 1; ventLog = 1; updraftLog = 0;
[~,legendEntries,legendText] = iceGrowthDiagram(hd,freezingLineLog,isohumesLog,ventLog,updraftLog); %Plot the growth diagram

if length(timeIndex)==1
    % Autogenerate title for single profiles
    dateString = datestr(datenum(sounding(timeIndex).valid_date_num(1),sounding(timeIndex).valid_date_num(2),sounding(timeIndex).valid_date_num(3),sounding(timeIndex).valid_date_num(4),0,0),'mmm dd, yyyy HH UTC'); %For title
    [launchname] = stationLookupIGRAv2(sounding(timeIndex).stationID);
else
    % Manually generate title otherwise
    %dateString = 'DJF 2015-2016';
    launchname = 'Anchorage, AK';
end
t = title({['Ice phase space for ' dateString],launchname});
t.FontName = 'Lato Bold';
t.FontSize = 20;

%% Plot T,s points on the parameter space defined by the ice growth diagram
for c = 1:length(timeIndex)
    loopTime = timeIndex(c);
    rhumDecimal = [sounding(loopTime).rhum]./100; %Need humidity in decimal to plot balloon data
    radiosondeTemp = [sounding(loopTime).temp]; %Celsius for plotting
    radiosondeTempK = radiosondeTemp+273.15; %Kelvins for supersaturation calculations
    %radiosondeHeight = [sounding(loopTime).geopotential]; %For eventual implementation of color-coding for height
    eswStandardFromRadiosonde = hd.Constants.es0*exp(hd.Constants.Lvap/hd.Constants.Rv*(1/273.15-1./radiosondeTempK)); %Saturated vapor pressure with respect to water
    esiStandardFromRadiosonde = hd.Constants.es0*exp(hd.Constants.Lsub/hd.Constants.Rv*(1/273.15-1./radiosondeTempK)); %Saturated vapor pressure with respect to ice
    soundingHumidityPoints = rhumDecimal.*eswStandardFromRadiosonde./esiStandardFromRadiosonde-1;
    pointCloud = scatter(soundingHumidityPoints,radiosondeTemp,'filled','MarkerEdgeColor','k','MarkerFaceColor','w');
    
    %pointCloud = plot(soundingHumidityPoints,radiosondeTemp,'marker','o','color',rand(1,3));
    %pointCloud = line(soundingHumidityPoints,radiosondeTemp);
    %pointCloud.Color = rand(1,3);
    %Plot color for lowest 8 km or something? Divide for different kilometers and use Okabe Ito?
end

legendEntries(end+1) = pointCloud;
legendText{end+1} = 'Balloon data';
leg = legend(legendEntries,legendText);
leg.Location = 'southeast';
leg.FontSize = 12;
if legLog==0
    leg.Visible = 'off';
end

end