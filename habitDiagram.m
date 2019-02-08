%%habitDiagram
    %Script to generate a habit diagram using boundaries from Bailey and
    %Hallett 2009. The boundaries are then used to construct a new habit
    %diagram.
    %
    %Habits are divided up in the code close to the BH09 classification:
    %plates, various plates, sector plates, column-like, dendrites, polycrystals
    %(platelike), polycrystals (columnar), and mixed.
    %However, on the diagram, they are plotted according to our new
    %classification scheme that focuses on growth habit: edge growth, face
    %growth, corner growth, polycrystals (platelike), polycrystals
    %(columnar), and mixed. The categories overlap as follows.
    %Edge growth: plates, various plates
    %Face growth: column-like (which includes columns and needles)
    %Corner growth: sector plates, dendrites
    %
    %Two diagrams are created: one in T-s space and one in s-T space. The
    %s-T version of the diagram is considered the primary diagram. Placing
    %temperature on the y-axis makes for easier visualization of precipitation,
    %soundings, and other data where T decreases with height. The ICAO
    %standard atmosphere heights corresponding to these temperatures is
    %plotted as a secondary y-axis. It is important to note that there is a large
    %degree of variance in these heights, particularly in locations where
    %temperature inversions are common in the lower troposphere. The T-s
    %diagram is created for consistency and comparison with previous
    %diagrams. (Until this one, all diagrams since the 1950s were designed
    %in T-s space.)
    %
    %Full citation for Bailey and Hallett 2009
    %Bailey, M.P. and J. Hallett, 2009: A Comprehensive
    %Habit Diagram for Atmospheric Ice Crystals: Confirmation from the
    %Laboratory, AIRS II, and Other Field Studies. J. Atmos. Sci., 66,
    %2888–2899, https://doi.org/10.1175/2009JAS2883.1
    %
    %Version date: 1/22/2019
    %Last major revision: 9/04/2018
    %Written by: Daniel Hueholt
    %North Carolina State University
    %Undergraduate Research Assistant at Environment Analytics
    %

%% Constants
Lsub = 2.834*10^6; %J/(kg)
Lvap = 2.501*10^6; %J/Kg
Rv = 461.5; %J/(kgK)
es0 = 611; %Pa

%% Calculate boundaries along the water saturation line

% "Various plates" habit
T_vp = [-8 -22];
T_vp = T_vp + 273.15;
esw_vp = es0*exp(Lvap/Rv*(1/273.15-1./T_vp)); %Saturated vapor pressure with respect to water
esi_vp = es0*exp(Lsub/Rv*(1/273.15-1./T_vp)); %Saturated vapor pressure with respect to ice

% "Sector plates" habit
T_sp = [-8 -12.2; -12.2 -17.6; -17.6 -22];
T_sp = T_sp + 273.15;
esw_sp = es0*exp(Lvap/Rv*(1/273.15-1./T_sp)); %Saturated vapor pressure with respect to water
esi_sp = es0*exp(Lsub/Rv*(1/273.15-1./T_sp)); %Saturated vapor pressure with respect to ice

%% Set up structure with information to plot habit diagram
% All temperatures in deg C
% All supersaturations with respect to ice

hd = struct('Plates',''); %Structure must have at least one field in order to assign elements using dot notation

hd.Plates.Habit = 'Edge growth (plate-like)'; %'Plates';
hd.Plates.Color = [243 139 156]./255;
hd.Plates.TempBounds = [0 0 -4 -4];
hd.Plates.supersatBounds = [0 0.1 0.1 0];

hd.ColumnLike.Habit = 'Face growth (column-like)'; %'Column-like';
hd.ColumnLike.Color = [165 162 221]./255;
hd.ColumnLike.TempBounds = [-4 -4 -8 -8];
hd.ColumnLike.supersatBounds = [0 0.28 0.28 0];

hd.VariousPlates.Habit = 'Edge growth (various plates)'; %'Various plates';
hd.VariousPlates.Color = hd.Plates.Color;
hd.VariousPlates.TempBounds = [-8 -8 -22 -22];
hd.VariousPlates.supersatBounds = [0 (esw_vp(1)-esi_vp(1))/esi_vp(1) (esw_vp(2)-esi_vp(2))/esi_vp(2) 0];

hd.SectorPlates.Habit = 'Corner growth (sector plates)'; %'Sector plates';
hd.SectorPlates.Color =  [218 146 56]./255;
hd.SectorPlates.TempBounds = [-8 -8 -12.2 -12.2; -12.2 -12.2 -17.6 -17.6; -17.6 -17.6 -22 -22];
hd.SectorPlates.supersatBounds = [(esw_sp(1)-esi_sp(1))/esi_sp(1) 0.36 0.36 (esw_sp(4)-esi_sp(4))/esi_sp(4); (esw_sp(2)-esi_sp(2))/esi_sp(2) 0.15 0.21 (esw_sp(5)-esi_sp(5))/esi_sp(5); (esw_sp(3)-esi_sp(3))/esi_sp(3) 0.46 0.46 (esw_sp(6)-esi_sp(6))/esi_sp(6)];

hd.Dendrites.Habit = 'Corner growth (branched, dendrites)'; %'Dendrites';
hd.Dendrites.Color = [247 214 153]./255;
hd.Dendrites.TempBounds = [-12.7 -12.7 -17.1 -17.1];
hd.Dendrites.supersatBounds = [0.16 0.43 0.43 0.21];

hd.PolycrystalsP.Habit = 'Polycrystals (platelike)';
hd.PolycrystalsP.Color = [63 1 22]./255;
hd.PolycrystalsP.TempBounds = [-46.6 -40.2 -22 -22; -40.2 -40.2 -22 -22];
hd.PolycrystalsP.supersatBounds = [0.038 0.33 0.33 0.038; 0.33 0.6 0.6 0.33];

hd.PolycrystalsC.Habit = 'Polycrystals (columnar)';
hd.PolycrystalsC.Color = [15 73 91]./255;
hd.PolycrystalsC.TempBounds = [-46.6 -40.2 -70 -70; -70 -70 -40.2 -40.2];
hd.PolycrystalsC.supersatBounds = [0.038 0.33 0.33 0.038; 0.33 0.6 0.6 0.33];

hd.Mixed.Habit = 'Mixed (polycrystals, plates, columns, equiaxed)';
hd.Mixed.Color = [209 203 193]./255;
hd.Mixed.TempBounds = [-8 -8 -70 -70; -46.6 -45.9 -70 -70];
hd.Mixed.supersatBounds = [0 0.038 0.038 0; 0.038 0.0697 0.0697 0.038 ];

hd.PolycrystalsIntermediate.Habit = 'Possible extension of the bullet rosette habit';
hd.PolycrystalsIntermediate.Color = [hd.PolycrystalsP.Color; hd.PolycrystalsP.Color]; %Not shown on current diagram
hd.PolycrystalsIntermediate.TempBounds = [-40.2 -40.2 -36.5 -36.5];
hd.PolycrystalsIntermediate.supersatBounds = [0.359 0.491 0.445 0.316];

hd.unnatural.Habit = 'Coordinates to block out unnatural supersaturations'; %Follows the 2*water saturation line
hd.unnatural.Color = [1 1 1];
hd.unnatural.TempBounds = [0 -7.5 -14 -18.5 -24.8 0];
hd.unnatural.supersatBounds = [0 0.1549 0.3068 0.4231 0.6 0.6];

%% Make T-s diagram
fig = figure;

plates = patch(hd.Plates.TempBounds, hd.Plates.supersatBounds,hd.Plates.Color);
plates.EdgeColor = 'none';

columnlike = patch(hd.ColumnLike.TempBounds,hd.ColumnLike.supersatBounds,hd.ColumnLike.Color);
columnlike.EdgeColor = 'none';

variousplates = patch(hd.VariousPlates.TempBounds,hd.VariousPlates.supersatBounds,hd.VariousPlates.Color);
variousplates.EdgeColor = 'none';

polycrystalsP1 = patch(hd.PolycrystalsP.TempBounds(1,:),hd.PolycrystalsP.supersatBounds(1,:),hd.PolycrystalsP.Color);
polycrystalsP1.EdgeColor = 'none';
polycrystalsP2 = patch(hd.PolycrystalsP.TempBounds(2,:),hd.PolycrystalsP.supersatBounds(2,:),hd.PolycrystalsP.Color);
polycrystalsP2.EdgeColor = 'none';
polycrystalsC1 = patch(hd.PolycrystalsC.TempBounds(1,:),hd.PolycrystalsC.supersatBounds(1,:),hd.PolycrystalsC.Color);
polycrystalsC1.EdgeColor = 'none';
polycrystalsC2 = patch(hd.PolycrystalsC.TempBounds(2,:),hd.PolycrystalsC.supersatBounds(2,:),hd.PolycrystalsC.Color);
polycrystalsC2.EdgeColor = 'none';
polycrystalsI = patch(hd.PolycrystalsIntermediate.TempBounds,hd.PolycrystalsIntermediate.supersatBounds,hd.PolycrystalsIntermediate.Color(1,:));
polycrystalsI2 = patch(hd.PolycrystalsIntermediate.TempBounds,hd.PolycrystalsIntermediate.supersatBounds,hd.PolycrystalsIntermediate.Color(2,:));
polycrystalsI.EdgeColor = 'none'; polycrystalsI.FaceAlpha = 0.5;
polycrystalsI2.EdgeColor = 'none'; polycrystalsI2.FaceAlpha = 0.5;

sectorplates1 = patch(hd.SectorPlates.TempBounds(1,:),hd.SectorPlates.supersatBounds(1,:),hd.SectorPlates.Color);
sectorplates1.EdgeColor = 'none';
sectorplates2 = patch(hd.SectorPlates.TempBounds(2,:),hd.SectorPlates.supersatBounds(2,:),hd.SectorPlates.Color);
sectorplates2.EdgeColor = 'none';
sectorplates3 = patch(hd.SectorPlates.TempBounds(3,:),hd.SectorPlates.supersatBounds(3,:),hd.SectorPlates.Color);
sectorplates3.EdgeColor = 'none';

dendrites = patch(hd.Dendrites.TempBounds,hd.Dendrites.supersatBounds,hd.Dendrites.Color);
dendrites.EdgeColor = 'none';


mixed1 = patch(hd.Mixed.TempBounds(1,:),hd.Mixed.supersatBounds(1,:),hd.Mixed.Color);
mixed1.EdgeColor = 'none';
mixed2 = patch(hd.Mixed.TempBounds(2,:),hd.Mixed.supersatBounds(2,:),hd.Mixed.Color);
mixed2.EdgeColor = 'none';

hold on
TlineStandardC = 0:-0.5:-70;
TlineStandard = TlineStandardC+273.15;
eswStandard = es0*exp(Lvap/Rv*(1/273.15-1./TlineStandard)); %Saturated vapor pressure with respect to water
esiStandard = es0*exp(Lsub/Rv*(1/273.15-1./TlineStandard)); %Saturated vapor pressure with respect to ice
eswLine = eswStandard./esiStandard-1;
eswSupersatLineStandard = plot(TlineStandardC,eswLine);
eswSupersatLineStandard.Color = [244 126 13]./255;
eswSupersatLineStandard.LineWidth = 3;
hold on
unnaturalLine = plot(TlineStandardC,2.*eswLine);
unnaturalLine.Color = [0 26 255]./255;
unnaturalLine.LineWidth = 3.2;

hold on
unnatural = patch(hd.unnatural.TempBounds,hd.unnatural.supersatBounds,hd.unnatural.Color);
unnatural.EdgeColor = 'none';

axe = gca;
axe.FontName = 'Lato';
axe.FontSize = 18;
leg = legend([plates columnlike sectorplates1 dendrites polycrystalsP1 polycrystalsC1 mixed1 eswSupersatLineStandard unnaturalLine],{hd.Plates.Habit,hd.ColumnLike.Habit,hd.SectorPlates.Habit,hd.Dendrites.Habit,hd.PolycrystalsP.Habit,hd.PolycrystalsC.Habit,hd.Mixed.Habit,'Water saturation line (T_{ice}=T_{air})','Approximate max natural supersaturation (with ventilation)'});
leg.Location = 'northwest';
leg.FontSize = 16;
xlim([-70 0])
ylim([0 0.6])
t = title('T-s ice growth diagram adapted from Bailey and Hallett 2009');
t.FontSize = 20;
xLab = xlabel(['Temperature in ' char(176) 'C']);
xLab.FontName = 'Lato Bold';
yLab = ylabel('Supersaturation with respect to ice');
yLab.FontName = 'Lato Bold';
axe.XTick = [-70 -60 -50 -40 -30 -22 -20 -18 -16 -14 -12 -10 -8 -6 -4 -2 0];
axe.YTick = [0 0.05 0.1 0.15 0.2 0.25 0.3 0.35 0.4 0.45 0.5 0.55 0.6];
axe.Layer = 'top'; %Forces tick marks to be displayed over the patch objects

%% Make s-T diagram
fig = figure;
leftColor = [0 0 0]; rightColor = [0 0 0];
set(fig,'defaultAxesColorOrder',[leftColor;rightColor])

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

hold on
%Settings were defined earlier
eswSupersatLineStandard = plot(eswLine,TlineStandardC);
eswSupersatLineStandard.Color = [255 230 0]./255;
eswSupersatLineStandard.LineWidth = 3.2; 

hold on
unnatural = patch(hd.unnatural.supersatBounds,hd.unnatural.TempBounds,hd.unnatural.Color);
unnatural.EdgeColor = 'none';

hold on
%Approximate maximum supersaturation line
maxVentLine = plot(2*eswLine,TlineStandardC);
maxVentLine.Color = [0 26 255]./255;
maxVentLine.LineWidth = 3.2;

% Diagram settings
axe = gca;
axe.FontName = 'Lato';
axe.FontSize = 18;
yyaxis right
axe.YTick = [0 2 4 6 8 10 12 14 16 18 20 22 30 40 50 60 70];
%z = [2300 2625 2925 3225 3550 3850 4150 4475 4775 5075 5400 5700 6925 8450 10000 71750 76750];
%z = z-2300; %Height above freezing line
zLabels = {'0' '325' '625' '925' '1250' '1550' '1850' '2175' '2475' '2775' '3100' '3400' '4625' '6150' '7700' '69450' '74450'}; %meters
yticklabels(zLabels);
ylim([0 70])
axe.Layer = 'top';
yLab = ylabel('Height above freezing level in m (ICAO standard atmosphere)');
yLab.FontName = 'Lato Bold';

yyaxis left
%leg = legend([plates columnlike variousplates sectorplates1 dendrites polycrystalsP1 polycrystalsC1 mixed1 eswSupersatLineStandard],{hd.Plates.Habit,hd.ColumnLike.Habit,hd.VariousPlates.Habit,hd.SectorPlates.Habit,hd.Dendrites.Habit,hd.PolycrystalsP.Habit,hd.PolycrystalsC.Habit,hd.Mixed.Habit,'Water saturation line (T_{ice} = T_{air})'});
leg = legend([plates columnlike sectorplates1 dendrites polycrystalsP1 polycrystalsC1 mixed1 eswSupersatLineStandard maxVentLine],{hd.Plates.Habit,hd.ColumnLike.Habit,hd.SectorPlates.Habit,hd.Dendrites.Habit,hd.PolycrystalsP.Habit,hd.PolycrystalsC.Habit,hd.Mixed.Habit,'Water saturation line (T_{ice} = T_{air})','Approximate max natural supersaturation (with ventilation)'});
leg.Location = 'northeast';
leg.FontSize = 16;
ylim([-70 0])
xlim([0 0.6])
t = title('s-T ice growth diagram adapted from Bailey and Hallett 2009');
t.FontSize = 20;
yLab = ylabel(['Temperature in ' char(176) 'C']);
yLab.FontName = 'Lato Bold';
xLab = xlabel('Supersaturation with respect to ice (%)');
xLab.FontName = 'Lato Bold';
axe.YTick = [-70 -60 -50 -40 -30 -22 -20 -18 -16 -14 -12 -10 -8 -6 -4 -2 0];
axe.XTick = [0 0.05 0.1 0.15 0.2 0.25 0.3 0.35 0.4 0.45 0.5 0.55 0.6];
xTickLabels = {'0' '5' '10' '15' '20' '25' '30' '35' '40' '45' '50' '55' '60'}; % YOU NEED TO ACTUALLY CHANGE THIS OVER TO %
xticklabels(xTickLabels);
axe.Layer = 'top'; %Forces tick marks to be displayed over the patch objects
axe.YDir = 'reverse';

%% Make s-T diagram, lines only
fig = figure;
leftColor = [0 0 0]; rightColor = [0 0 0];
set(fig,'defaultAxesColorOrder',[leftColor;rightColor])

%Settings were defined earlier
hold on
eswSupersatLineStandard = plot(eswLine,TlineStandardC);
eswSupersatLineStandard.Color = [255 230 0]./255;
eswSupersatLineStandard.LineWidth = 3.2; 

hold on
%Approximate maximum supersaturation line
maxVentLine = plot(2*eswLine,TlineStandardC);
maxVentLine.Color = [0 26 255]./255;
maxVentLine.LineWidth = 3.2;

% Diagram settings
axe = gca;
axe.FontName = 'Lato';
axe.FontSize = 18;
yyaxis right
axe.YTick = [0 2 4 6 8 10 12 14 16 18 20 22 30 40 50 60 70];
%z = [2300 2625 2925 3225 3550 3850 4150 4475 4775 5075 5400 5700 6925 8450 10000 71750 76750];
%z = z-2300; %Height above freezing line
zLabels = {'0' '325' '625' '925' '1250' '1550' '1850' '2175' '2475' '2775' '3100' '3400' '4625' '6150' '7700' '69450' '74450'}; %meters
yticklabels(zLabels);
ylim([0 70])
axe.Layer = 'top';
yLab = ylabel('Height above freezing level in m (ICAO standard atmosphere)');
yLab.FontName = 'Lato Bold';

yyaxis left
%leg = legend([plates columnlike variousplates sectorplates1 dendrites polycrystalsP1 polycrystalsC1 mixed1 eswSupersatLineStandard],{hd.Plates.Habit,hd.ColumnLike.Habit,hd.VariousPlates.Habit,hd.SectorPlates.Habit,hd.Dendrites.Habit,hd.PolycrystalsP.Habit,hd.PolycrystalsC.Habit,hd.Mixed.Habit,'Water saturation line (T_{ice} = T_{air})'});
leg = legend([eswSupersatLineStandard maxVentLine],{'Water saturation line (T_{ice} = T_{air})','Approximate max natural supersaturation (with ventilation)'});
leg.Location = 'northeast';
leg.FontSize = 16;
ylim([-70 0])
xlim([0 0.6])
t = title('s-T ice growth diagram adapted from Bailey and Hallett 2009');
t.FontSize = 20;
yLab = ylabel(['Temperature in ' char(176) 'C']);
yLab.FontName = 'Lato Bold';
xLab = xlabel('Supersaturation with respect to ice (%)');
xLab.FontName = 'Lato Bold';
axe.YTick = [-70 -60 -50 -40 -30 -22 -20 -18 -16 -14 -12 -10 -8 -6 -4 -2 0];
axe.XTick = [0 0.05 0.1 0.15 0.2 0.25 0.3 0.35 0.4 0.45 0.5 0.55 0.6];
xTickLabels = {'0' '5' '10' '15' '20' '25' '30' '35' '40' '45' '50' '55' '60'}; % YOU NEED TO ACTUALLY CHANGE THIS OVER TO %
xticklabels(xTickLabels);
axe.Layer = 'top'; %Forces tick marks to be displayed over the patch objects
axe.YDir = 'reverse';
