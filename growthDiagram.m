function [] = growthDiagram(sounding,timeIndex,legLog)
%%growthDiagram
    %Function to plot balloon temperature/humidity data on the ice growth
    %diagram.
    %
    %General form: growthDiagram(sounding,timeIndex,legLog)
    %
    %Inputs
    %sounding: a processed sounding data structure, must include moisture data
    %timeIndex: the index of the desired sounding within the structure
    %legLog: logical 1/0 to plot/not plot the rather giant legend. Enabled by default.
    %
    %Requires secondary function makeGrowthDiagramStruct
    %
    %Written by: Daniel Hueholt
    %North Carolina State University
    %Undergraduate Research Assistant at Environment Analytics
    %Version date: 4/17/2019
    %Last major revision: 4/17/2019
    %
    %See also makeGrowthDiagramStruct
    %

if ~exist('legLog','var')
    legLog = 1;
    disp('Legend enabled by default')
end
if legLog~=0 && legLog~=1
    legLog = 1;
    disp('Legend enabled by default')
end

%% Setup for growth space
crystalLog = 1;
otherLog = 1;
[hd] = makeGrowthDiagramStruct(crystalLog,otherLog); %Instantiate the structure containing all growth diagram information

%Make s-T diagram
fig = figure;
leftColor = [0 0 0]; rightColor = [0 0 0];
set(fig,'defaultAxesColorOrder',[leftColor; rightColor]) %Sets left and right y-axis color

%Draw the growth types
plates = patch(hd.Plates.supersatBounds, hd.Plates.TempBounds,hd.Plates.Color);
plates.EdgeColor = 'none';
columnlike = patch(hd.ColumnLike.supersatBounds,hd.ColumnLike.TempBounds,hd.ColumnLike.Color);
columnlike.EdgeColor = 'none';
variousplates = patch(hd.VariousPlates.supersatBounds,hd.VariousPlates.TempBounds,hd.VariousPlates.Color);
variousplates.EdgeColor = 'none';
polycrystalsP1 = patch(hd.PolycrystalsP.supersatBounds(1,:),hd.PolycrystalsP.TempBounds(1,:),hd.PolycrystalsP.Color);
polycrystalsP1.EdgeColor = 'none';
polycrystalsP2 = patch(hd.PolycrystalsP.supersatBounds(2,:),hd.PolycrystalsP.TempBounds(2,:),hd.PolycrystalsP.Color);
polycrystalsP2.EdgeColor = 'none';
polycrystalsC1 = patch(hd.PolycrystalsC.supersatBounds(1,:),hd.PolycrystalsC.TempBounds(1,:),hd.PolycrystalsC.Color);
polycrystalsC1.EdgeColor = 'none';
polycrystalsC2 = patch(hd.PolycrystalsC.supersatBounds(2,:),hd.PolycrystalsC.TempBounds(2,:),hd.PolycrystalsC.Color);
polycrystalsC2.EdgeColor = 'none';
polycrystalsI = patch(hd.PolycrystalsIntermediate.supersatBounds,hd.PolycrystalsIntermediate.TempBounds,hd.PolycrystalsIntermediate.Color(1,:));
polycrystalsI2 = patch(hd.PolycrystalsIntermediate.supersatBounds,hd.PolycrystalsIntermediate.TempBounds,hd.PolycrystalsIntermediate.Color(2,:));
polycrystalsI.EdgeColor = 'none'; polycrystalsI.FaceAlpha = 1;
polycrystalsI2.EdgeColor = 'none'; polycrystalsI2.FaceAlpha = 1;
sectorplates1 = patch(hd.SectorPlates.supersatBounds(1,:),hd.SectorPlates.TempBounds(1,:),hd.SectorPlates.Color);
sectorplates1.EdgeColor = 'none';
sectorplates2 = patch(hd.SectorPlates.supersatBounds(2,:),hd.SectorPlates.TempBounds(2,:),hd.SectorPlates.Color);
sectorplates2.EdgeColor = 'none';
sectorplates3 = patch(hd.SectorPlates.supersatBounds(3,:),hd.SectorPlates.TempBounds(3,:),hd.SectorPlates.Color);
sectorplates3.EdgeColor = 'none';
dendrites = patch(hd.Dendrites.supersatBounds,hd.Dendrites.TempBounds,hd.Dendrites.Color);
dendrites.EdgeColor = 'none';
intermediateSPD_floor = patch([hd.Dendrites.supersatBounds(1),hd.Dendrites.supersatBounds(1) hd.Dendrites.supersatBounds(2) hd.Dendrites.supersatBounds(2)], [hd.SectorPlates.TempBounds(5) hd.Dendrites.TempBounds(2) hd.Dendrites.TempBounds(2),hd.SectorPlates.TempBounds(5)],reshape([hd.SectorPlates.Color; hd.Dendrites.Color; hd.Dendrites.Color; hd.SectorPlates.Color],4,[],3));
intermediateSPD_floor.EdgeColor = 'none';
intermediateSPD_wall = patch([hd.SectorPlates.supersatBounds(5),hd.Dendrites.supersatBounds(4) hd.Dendrites.supersatBounds(4) hd.Dendrites.supersatBounds(1)], [hd.SectorPlates.TempBounds(5) hd.SectorPlates.TempBounds(11) hd.Dendrites.TempBounds(3),hd.Dendrites.TempBounds(2)],reshape([hd.SectorPlates.Color; hd.SectorPlates.Color; hd.Dendrites.Color; hd.Dendrites.Color],4,[],3));
intermediateSPD_wall.EdgeColor = 'none';
intermediateSPD_ceiling = patch([hd.Dendrites.supersatBounds(4),hd.Dendrites.supersatBounds(4) hd.SectorPlates.supersatBounds(6) hd.SectorPlates.supersatBounds(9)], [hd.Dendrites.TempBounds(4) hd.SectorPlates.TempBounds(11) hd.SectorPlates.TempBounds(11),hd.Dendrites.TempBounds(4)],reshape([hd.Dendrites.Color; hd.SectorPlates.Color; hd.SectorPlates.Color; hd.Dendrites.Color],4,[],3));
intermediateSPD_ceiling.EdgeColor = 'none';
intermediateSPD_cursedTriangle = patch([hd.SectorPlates.supersatBounds(5),hd.Dendrites.supersatBounds(1) hd.Dendrites.supersatBounds(1)], [hd.SectorPlates.TempBounds(5) hd.Dendrites.TempBounds(1) hd.SectorPlates.TempBounds(5)],reshape([hd.SectorPlates.Color; hd.Dendrites.Color; hd.SectorPlates.Color],3,[],3));
intermediateSPD_cursedTriangle.EdgeColor = 'none';
mixed1 = patch(hd.Mixed.supersatBounds(1,:),hd.Mixed.TempBounds(1,:),hd.Mixed.Color);
mixed1.EdgeColor = 'none';
mixed2 = patch(hd.Mixed.supersatBounds(2,:),hd.Mixed.TempBounds(2,:),hd.Mixed.Color);
mixed2.EdgeColor = 'none';
warmerThanFreezing = patch(hd.warm.supersatBounds(1,:),hd.warm.TempBounds(1,:),hd.warm.Color);
warmerThanFreezing.EdgeColor = 'none';
subsaturated = patch(hd.subsaturated.supersatBounds(1,:),hd.subsaturated.TempBounds(1,:),hd.subsaturated.Color);
subsaturated.EdgeColor = 'none';

hold on
TlineStandardC = 15:-0.1:-70;
TlineStandard = TlineStandardC+273.15;
eswStandard = hd.Constants.es0*exp(hd.Constants.Lvap/hd.Constants.Rv*(1/273.15-1./TlineStandard)); %Saturated vapor pressure with respect to water
esiStandard = hd.Constants.es0*exp(hd.Constants.Lsub/hd.Constants.Rv*(1/273.15-1./TlineStandard)); %Saturated vapor pressure with respect to ice
eswLine = eswStandard./esiStandard-1;
hold on
eswSupersatLineStandard = plot(eswLine,TlineStandardC);
eswSupersatLineStandard.Color = [255 230 0]./255;
eswSupersatLineStandard.LineWidth = 3.2;
hold on

eswStandard90 = 0.9*eswStandard;
eswLine90 = eswStandard90./esiStandard-1;
eswSupersatLineStandard90 = plot(eswLine90,TlineStandardC);
eswSupersatLineStandard90.LineStyle = '--';
eswSupersatLineStandard90.Color = [255/255 230/255 0 0.8];
eswSupersatLineStandard90.LineWidth = 3.2;
hold on
eswStandard80 = 0.8*eswStandard;
eswLine80 = eswStandard80./esiStandard-1;
eswSupersatLineStandard80 = plot(eswLine80,TlineStandardC);
eswSupersatLineStandard80.LineStyle = ':';
eswSupersatLineStandard80.Color = [255/255 230/255 0 0.8];
eswSupersatLineStandard80.LineWidth = 3.2;
hold on
eswStandardp25 = 1.025*eswStandard;
eswLinep25 = eswStandardp25./esiStandard-1;
eswSupersatLineStandardp25 = plot(eswLinep25(151:end),TlineStandardC(151:end));
eswSupersatLineStandardp25.LineStyle = '-.';
eswSupersatLineStandardp25.Color = [255/255 230/255 0 0.8];
eswSupersatLineStandardp25.LineWidth = 3.2;
eswStandardp5 = 1.05*eswStandard;
eswLinep5 = eswStandardp5./esiStandard-1;
eswSupersatLineStandardp5 = plot(eswLinep5(151:end),TlineStandardC(151:end));
%eswSupersatLineStandardp5.LineStyle = '-';
eswSupersatLineStandardp5.Marker = '.';
eswSupersatLineStandardp5.Color = [255/255 230/255 0 0.8];
%eswSupersatLineStandardp5.LineWidth = 3.2;

unnatural = patch(hd.unnatural.supersatBounds,hd.unnatural.TempBounds,hd.unnatural.Color);
unnatural.EdgeColor = 'none';
hold on
TlineFreezing = plot([-20,100],[0,0]);
TlineFreezing.LineWidth = 3.2;
TlineFreezing.Color = [255 0 255]./255;
hold on
%Approximate maximum supersaturation line
maxVentLine = plot(2*eswLine(151:end),TlineStandardC(151:end));
maxVentLine.Color = [0 26 255]./255;
maxVentLine.LineWidth = 3.2;

% Diagram settings
axe = gca;
axe.FontName = 'Lato';
axe.FontSize = 18;
yyaxis right
axe.YTick = [-12 -10 -8 -6 -4 -2 0 2 4 6 8 10 12 14 16 18 20 22 30 40 50 60 70];
%z = [2300 2625 2925 3225 3550 3850 4150 4475 4775 5075 5400 5700 6925 8450 10000 71750 76750];
%z = z-2300; %Height above freezing line
zLabels = {'' '' '' '' '' '' '0' '325' '625' '925' '1250' '1550' '1850' '2175' '2475' '2775' '3100' '3400' '4625' '6150' '7700' '69450' '74450'}; %meters
yticklabels(zLabels);
ylim([-8 70])
axe.Layer = 'top';
yLab = ylabel('Height above freezing level in m (ICAO standard atmosphere)');
yLab.FontName = 'Lato Bold';
yyaxis left

ylim([-70 8])
xlim([-0.1 0.6])
if length(timeIndex)==1
    dateString = datestr(datenum(sounding(timeIndex).valid_date_num(1),sounding(timeIndex).valid_date_num(2),sounding(timeIndex).valid_date_num(3),sounding(timeIndex).valid_date_num(4),0,0),'mmm dd, yyyy HH UTC'); %For title
    [launchname] = stationLookupIGRAv2(sounding(timeIndex).stationID);
else
    dateString = 'December 2017';
    launchname = 'Salt Lake City, UT';
end
t = title({['Ice phase space for ' dateString],launchname});
t.FontName = 'Lato Bold';
t.FontSize = 20;
yLab = ylabel(['Temperature in ' char(176) 'C']);
yLab.FontName = 'Lato Bold';
xLab = xlabel('Supersaturation with respect to ice (%)');
xLab.FontName = 'Lato Bold';
axe.YTick = [-70 -60 -50 -40 -30 -22 -20 -18 -16 -14 -12 -10 -8 -6 -4 -2 0 2 4 6 8 10 12];
axe.XTick = [0 0.05 0.1 0.15 0.2 0.25 0.3 0.35 0.4 0.45 0.5 0.55 0.6];
xTickLabels = {'0' '5' '10' '15' '20' '25' '30' '35' '40' '45' '50' '55' '60'};
xticklabels(xTickLabels);
axe.Layer = 'top'; %Forces tick marks to be displayed over the patch objects
axe.YDir = 'reverse';

%% Plot T,s points on the parameter space defined by the ice growth diagram

for c = 1:length(timeIndex)
    loopTime = timeIndex(c);
    rhumPercent = [sounding(loopTime).rhum];
    rhumDecimal = rhumPercent./100;
    radiosondeTemp = [sounding(loopTime).temp];
    radiosondeTempK = radiosondeTemp+273.15;
    %radiosondeHeight = [sounding(loopTime).geopotential]; %Will be used for eventual implementation of color-coding for height
    
    eswStandardFromRadiosonde = hd.Constants.es0*exp(hd.Constants.Lvap/hd.Constants.Rv*(1/273.15-1./radiosondeTempK)); %Saturated vapor pressure with respect to water
    esiStandardFromRadiosonde = hd.Constants.es0*exp(hd.Constants.Lsub/hd.Constants.Rv*(1/273.15-1./radiosondeTempK)); %Saturated vapor pressure with respect to ice
    soundingHumidityPoints = rhumDecimal.*eswStandardFromRadiosonde./esiStandardFromRadiosonde-1;
    [s_max] = updraftSupersat(1000,1,1);
    s_maxUsable = 1+s_max;
    updraftMaxSupersat = s_maxUsable.*eswStandard;
    updraftMaxSupersatPoints = updraftMaxSupersat./esiStandard-1;
    lineSupersat = plot(updraftMaxSupersatPoints,TlineStandardC);
    lineSupersat.LineWidth = 2;
    
    hold on
    pointCloud = scatter(soundingHumidityPoints,radiosondeTemp,'filled','MarkerEdgeColor','k','MarkerFaceColor','w');
    %Plot color like for lowest 8 km or something? Divide for different
    %kilometers and use Okabe Ito?
end

leg = legend([plates columnlike sectorplates1 dendrites polycrystalsP1 polycrystalsC1 mixed1 subsaturated eswSupersatLineStandard eswSupersatLineStandard80 eswSupersatLineStandard90 eswSupersatLineStandardp25 eswSupersatLineStandardp5 maxVentLine pointCloud lineSupersat],{hd.Plates.Habit,hd.ColumnLike.Habit,hd.SectorPlates.Habit,hd.Dendrites.Habit,hd.PolycrystalsP.Habit,hd.PolycrystalsC.Habit,hd.Mixed.Habit,'Subsaturated','Water saturation line (T_{ice} = T_{air})','80% water saturation','90% water saturation','1.025 water saturation','1.05 water saturation','Approximate max natural supersat (with ventilation)','Balloon data','Guesstimated max updraft supersat'});
%leg = legend([plates columnlike sectorplates1 dendrites polycrystalsP1 polycrystalsC1 mixed1 warmerThanFreezing eswSupersatLineStandard maxVentLine cloudLine],{hd.Plates.Habit,hd.ColumnLike.Habit,hd.SectorPlates.Habit,hd.Dendrites.Habit,hd.PolycrystalsP.Habit,hd.PolycrystalsC.Habit,hd.Mixed.Habit,'Melting','Water saturation line (T_{ice} = T_{air})','Approximate max natural supersat (with ventilation)','Balloon data'});
leg.Location = 'northeast';
leg.FontSize = 12;
if legLog==0
    leg.Visible = 'off';
end

end