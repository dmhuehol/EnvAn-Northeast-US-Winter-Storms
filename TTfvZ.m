%%TTfvZ
    %Function to plot the height profile of temperature and frostpoint
    %temperature given an input date and soundings structure. Additionally,
    %allows for user control of the maximum height plotted.
    %
    %General form: [foundit] = TTfvZ(y,m,d,t,sounding,kmTop)
    %
    %Output
    %foundit: the index of the sounding corresponding to the input time
    %
    %Inputs
    %y: four digit year
    %m: two digit month
    %d: one or two digit day
    %t: one or two digit time
    %sounding: a structure of soundings data with wetbulb temperature
    %kmTop: OPTIONAL INPUT maximum km to plot. Defaults to 13km melting
    %layers at Long Island are always within 5km of surface.    %
    %
    %Version Date: 1/17/2020
    %Last major revision: 1/17/2020
    %Written by: Daniel Hueholt
    %North Carolina State University
    %Undergraduate Research Assistant at Environment Analytics
    %
    %See also wetbulb, addWetbulb
    %

function [foundit] = TTfvZ(y,m,d,t,sounding,kmTop)

% Checks relating to the kmTop input
if exist('kmTop','var')==0 %Default height is 13 km
    kmTop = 13;
    disp('Maximum height value defaulted to 13 km.')
end
if kmTop>13
    disp('Maximum allowed km is 13!')
    kmTop = 13;
elseif kmTop<0
    disp('Negative km is not allowed!')
    kmTop = 13;
elseif kmTop==0
    disp('0 km input is not allowed! Please enter an integer between 0 and 13.')
    return
end
kmTop = round(kmTop); %Fractional kilometers are not allowed

r = length(sounding); %Find the number of soundings
dateString = cell(1,r);
for as = 1:r %Loop through everything
    dateString{as} = sounding(as).valid_date_num;
    if isequal(dateString{as},[y,m,d,t]) %Look for the requested date
        foundit = as; %here it is!
        indexMsg = 'Index in structure is ';
        disp([indexMsg num2str(foundit)])
        break %Don't loop longer than necessary
    else
        %do nothing
    end
end

if ~exist('foundit','var') %If the date doesn't have a corresponding entry in the sounding structure, foundit won't exist
    disp('No data available for this date!')
    return %Stop the function
end

% Confine all data to between surface and maximum requested height
kmCutoff = logical(sounding(foundit).calculated_height <= kmTop+1); %Find indices of readings where the height less than the maximum height requested, plus a bit for better plotting
useTemp = sounding(foundit).temp(kmCutoff==1);
useHeight = sounding(foundit).calculated_height(kmCutoff==1);
disp('Calculating frostpoint profile, please wait.');
useDew = sounding(foundit).dewpt(kmCutoff==1); %Needed for wetbulb calculation
useFrost = NaN(length(useDew),1);
frostError = 0;
for c = 1:length(useTemp)
    try
        [useFrost(c)] = frostpoint(useDew(c));
    catch ME %#ok
        frostError = frostError+1;
    end
end
disp(['Frostpoint calculation failed ' num2str(frostError) ' times on ' num2str(length(useTemp)) ' calculations (' num2str(frostError./length(useTemp)) '% failure rate)'])
useFrost = double(useFrost); %Certain operations will not function while the data type is symbolic

% Extra quality control to prevent jumps in the graphs
useHeight(useHeight<-150) = NaN;
useHeight(useHeight>100) = NaN;
useTemp(useTemp<-150) = NaN;
useTemp(useTemp>100) = NaN;
if all(isnan(useFrost)==1) %#ok Code Analyzer is wrong about behavior here
    disp('Frostpoint calculation failed! Frostpoint profile will not be displayed.')
else
    useFrost(useFrost<-150) = NaN;
    useFrost(useFrost>100) = NaN;
end
sounding(foundit).temp(sounding(foundit).temp<-150) = NaN;

% Freezing line
freezingy = [0 16];
freezingx = ones(1,length(freezingy)).*0;

% Plotting
f = figure; %Figure is assigned to a handle for save options
plot(useTemp,useHeight,'Color',[255 128 0]./255,'LineWidth',2.4) %TvZ
hold on
plot(freezingx,freezingy,'Color',[0 0 0],'LineWidth',2) %Freezing line
hold on
plot(useDew,useHeight,'Color',[64 224 208]./255,'LineWidth',2.4);
hold on
plot(useFrost,useHeight,'Color',[128 0 255]./255,'LineWidth',2.4); %TwvZ

% Plot settings
limits = [0 kmTop];
ylim(limits);
ax = gca;
set(ax,'box','off')
switch kmTop
    case 13
        set(ax,'YTick',[0 0.5 1 1.5 2 2.5 3 3.5 4 4.5 5 6 7 8 9 10 11 12 13])
    case 12
        set(ax,'YTick',[0 0.5 1 1.5 2 2.5 3 3.5 4 4.5 5 6 7 8 9 10 11 12])
    case 11
        set(ax,'YTick',[0 0.5 1 1.5 2 2.5 3 3.5 4 4.5 5 6 7 8 9 10 11])
    case 10
        set(ax,'YTick',[0 0.5 1 1.5 2 2.5 3 3.5 4 4.5 5 6 7 8 9 10])
    case 9
        set(ax,'YTick',[0 0.5 1 1.5 2 2.5 3 3.5 4 4.5 5 6 7 8 9])
    case 8
        set(ax,'YTick',[0 0.5 1 1.5 2 2.5 3 3.5 4 4.5 5 6 7 8])
    case 7
        set(ax,'YTick',[0 0.5 1 1.5 2 2.5 3 3.5 4 4.5 5 6 7])
    case 6
        set(ax,'YTick',[0 0.5 1 1.5 2 2.5 3 3.5 4 4.5 5 5.5 6])
    case 5
        set(ax,'YTick',[0 0.5 1 1.5 2 2.5 3 3.5 4 4.5 5])
    case 4
        set(ax,'YTick',[0 0.5 1 1.5 2 2.5 3 3.5 4])
    case 3
        set(ax,'YTick',[0 0.5 1 1.5 2 2.5 3])
    case 2
        set(ax,'YTick',[0 0.25 0.5 0.75 1 1.25 1.5 1.75 2])
    case 1
        set(ax,'YTick',[0 0.125 0.25 0.375 0.5 0.625 0.75 0.875 1])
end
set(ax,'FontName','Lato'); set(ax,'FontSize',16)
hold off

set(ax,'XTick',[-45 -40 -35 -30 -25 -22 -20 -18 -16 -14 -12 -10 -8 -6 -5 -4 -3 -2 -1 0 1 2 3 4 5 6 8 10 12 14 16 18 20 22 25 30 35 40])

leg = legend('Temperature','Freezing','Dewpoint','Frostpoint');
leg.FontName = 'Lato';
leg.FontSize = 14;
dateString = datestr(datenum(sounding(foundit).valid_date_num(1),sounding(foundit).valid_date_num(2),sounding(foundit).valid_date_num(3),sounding(foundit).valid_date_num(4),0,0),'mmm dd, yyyy HH UTC'); %For title
[launchname] = stationLookupIGRAv2(sounding(foundit).stationID);
t = title({['Sounding for ' dateString],launchname});
t.FontName = 'Lato Bold'; t.FontSize = 16;
xLab = xlabel(['Temperature in ' char(176) 'C']);
xLab.FontName = 'Lato Bold'; xLab.FontSize = 16;
yLab = ylabel('Height in km');
yLab.FontName = 'Lato Bold'; yLab.FontSize = 16;

if min(useFrost)<min(useTemp) %Frostpoint is usually less than air temperature
    minLim = min(useFrost);
else %But sometimes the moisture data cuts off early, and we still need to assign a minimum dynamically
    minLim = min(useTemp);
end
maxLim = max(useTemp);
xlim([minLim-1 maxLim+1])
    
% Common settings for making poster graphics from Long Island
%set(ax,'XTick',[-30 -15 -10 -6 -4 -3 -2 -1 0 1 2 3 4 6 10 15])
%xlim([-10 16]) %Typical to fix axis for poster graphics; this usually covers most cases from Long Island

% Optional save options
%print(f,'-dpng','-r300')
% set(f,'PaperPositionMode','manual')
% set(f,'PaperUnits','inches','PaperPosition',[0 0 9 9])
% print(f,'-dpng','-r400')

end