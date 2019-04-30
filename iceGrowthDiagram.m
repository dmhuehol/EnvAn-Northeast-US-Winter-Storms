function [fig,legendEntries,legendTexts] = iceGrowthDiagram(hd,freezingLineLog,isohumeFlag,ventLog,updraftLog,legLog)
%%iceGrowthDiagram
    %Function to plot an ice growth diagram. Returns the figure handle
    %so further modifications are possible.
    %
    %General form: [fig] = plainIceGrowthDiagram(hd)
    %
    %Output
    %fig: figure handle for the s-T ice growth diagram
    %
    %Input
    %hd: the habit diagram structure, create with makeGrowthDiagramStruct
    %
    %Requires secondary function eswLine
    %
    %Written by: Daniel Hueholt
    %North Carolina State University
    %Undergraduate Research Assistant at Environment Analytics
    %Version date: 4/26/2019
    %Last major revision: 
    %
    %See also plainIceGrowthDiagram
    %

%% Check variables
if ~exist('hd','var')
    crystalLog = 1;
    otherLog = 1;
    [hd] = makeGrowthDiagramStruct(crystalLog,otherLog); %Instantiate the structure containing all growth diagram information
end
if ~exist('updraftLog','var')
    updraftLog = 0;
    disp('Updraft guesstimation disabled by default');
end

%% Make s-T diagram
fig = figure;
leftColor = [0 0 0]; rightColor = [0 0 0];
set(fig,'defaultAxesColorOrder',[leftColor; rightColor]) %Sets left and right y-axis color

%% Draw the growth types
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
unnatural = patch(hd.unnatural.supersatBounds,hd.unnatural.TempBounds,hd.unnatural.Color);
unnatural.EdgeColor = 'none';
hold on

legendEntries = [plates columnlike sectorplates1 dendrites polycrystalsP1 polycrystalsC1 mixed1];
legendTexts = {hd.Plates.Habit,hd.ColumnLike.Habit,hd.SectorPlates.Habit,hd.Dendrites.Habit,hd.PolycrystalsP.Habit,hd.PolycrystalsC.Habit,hd.Mixed.Habit};

%% Plot other lines
if freezingLineLog==1
    %Draw line at 0 deg C
    TlineFreezing = plot([-20,100],[0,0]);
    TlineFreezing.LineWidth = 3.2;
    TlineFreezing.Color = [255 0 255]./255;
    legendEntries(end+1) = TlineFreezing;
    legendTexts{end+1} = 'Freezing line';
end

if isohumeFlag==1
    %Draw isohumes
    Tupper = 15; Tlower = -70;
    TlineStandardC = Tupper:-0.1:Tlower;
    [eswLineData] = eswLine(100,Tlower,Tupper);
    eswSupersatLineStandard = plot(eswLineData,TlineStandardC);
    eswSupersatLineStandard.Color = [255 230 0]./255;
    eswSupersatLineStandard.LineWidth = 3.2;
    
    eswLine90Data = eswLine(90,Tlower,Tupper);
    eswSupersatLineStandard90 = plot(eswLine90Data,TlineStandardC);
    eswSupersatLineStandard90.LineStyle = ':';
    eswSupersatLineStandard90.Color = [255/255 230/255 0 0.8];
    eswSupersatLineStandard90.LineWidth = 3.2;
    
    eswLine80Data = eswLine(80,Tlower,Tupper);
    eswSupersatLineStandard80 = plot(eswLine80Data,TlineStandardC);
    eswSupersatLineStandard80.LineStyle = ':';
    eswSupersatLineStandard80.Color = [255/255 230/255 0 0.8];
    eswSupersatLineStandard80.LineWidth = 3.2;
    
    eswLine70Data = eswLine(70,Tlower,Tupper);
    eswSupersatLineStandard70 = plot(eswLine70Data,TlineStandardC);
    eswSupersatLineStandard70.LineStyle = ':';
    eswSupersatLineStandard70.Color = [255/255 230/255 0 0.8];
    eswSupersatLineStandard70.LineWidth = 3.2;
    
    eswLine60Data = eswLine(60,Tlower,Tupper);
    eswSupersatLineStandard60 = plot(eswLine60Data,TlineStandardC);
    eswSupersatLineStandard60.LineStyle = ':';
    eswSupersatLineStandard60.Color = [255/255 230/255 0 0.8];
    eswSupersatLineStandard60.LineWidth = 3.2;
    
    eswLine50Data = eswLine(50,Tlower,Tupper);
    eswSupersatLineStandard50 = plot(eswLine50Data,TlineStandardC);
    eswSupersatLineStandard50.LineStyle = ':';
    eswSupersatLineStandard50.Color = [255/255 230/255 0 0.8];
    eswSupersatLineStandard50.LineWidth = 3.2;
    
    eswLinep25Data = eswLine(102.5,Tlower,Tupper);
    eswSupersatLineStandardp25 = plot(eswLinep25Data(151:end),TlineStandardC(151:end));
    eswSupersatLineStandardp25.LineStyle = '-.';
    eswSupersatLineStandardp25.Color = [255/255 230/255 0 0.8];
    eswSupersatLineStandardp25.LineWidth = 3.2;
    
    eswLinep5Data = eswLine(105,Tlower,Tupper);
    eswSupersatLineStandardp5 = plot(eswLinep5Data(151:end),TlineStandardC(151:end));
    eswSupersatLineStandardp5.LineStyle = '-.';
    eswSupersatLineStandardp5.Color = [255/255 230/255 0 0.8];
    eswSupersatLineStandardp5.LineWidth = 3.2;
    
    
    legendEntries(end+1) = eswSupersatLineStandard;
    legendEntries(end+1) = eswSupersatLineStandard90;
    legendEntries(end+1) = eswSupersatLineStandardp5;
    
    legendTexts{end+1} = 'Water saturation line (T_{ice} = T_{air})';
    legendTexts{end+1} = 'Water saturation 50%, 60%, 70%, 80%, 90%';
    legendTexts{end+1} = 'Water saturation 102.5%, 105%';
    
end

if isohumeFlag==2
    %Draw isohumes
    Tupper = 15; Tlower = -70;
    TlineStandardC = Tupper:-0.1:Tlower;
    [eswLineData] = eswLine(100,Tlower,Tupper);
    eswSupersatLineStandard = plot(eswLineData,TlineStandardC);
    eswSupersatLineStandard.Color = [255 230 0]./255;
    eswSupersatLineStandard.LineWidth = 3.2;
    
    legendEntries(end+1) = eswSupersatLineStandard;
    legendTexts{end+1} = 'Water saturation line (T_{ice} = T_{air})';
end

if ventLog==1
    %Approximate maximum supersaturation line
    maxVentLine = plot(2*eswLineData(151:end),TlineStandardC(151:end));
    maxVentLine.Color = [0 26 255]./255;
    maxVentLine.LineWidth = 3.2;
    
    legendEntries(end+1) = maxVentLine;
    legendTexts{end+1} = 'Approximate max natural supersat (with ventilation)';
end
if updraftLog == 1
    %Plot guesstimated maximum updraft supersaturation (of questionable use)
    [s_max] = updraftSupersat(1000,1,1);
    s_maxUsable = 1+s_max;
    [updraftMaxSupersatPoints] = eswLine(s_maxUsable*100,Tlower,Tupper);
    lineSupersat = plot(updraftMaxSupersatPoints,TlineStandardC);
    lineSupersat.LineWidth = 2;
    
    legendEntries(end+1) = lineSupersat;
    legendTexts{end+1} = 'Guesstimated max supersaturation in updraft';
end

%% Diagram settings
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

t = title('Ice growth diagram');
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

leg = legend(legendEntries,legendTexts);
leg.Location = 'southeast';
if legLog==0
    leg.Visible = 'off';
end

end