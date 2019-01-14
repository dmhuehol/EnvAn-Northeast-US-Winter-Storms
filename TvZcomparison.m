function [foundit] = TvZcomparison(y,m,d,t,sounding1,sounding2,sounding3,kmTop)
%%TvZcomparison
    %Function to create a composite temperature vs height plot for multiple
    %soundings from different locations given an input date and multiple
    %data structures. Can plot up to three soundings.
    %
    %General form: [foundit] = TvZcomparison(y,m,d,t,sounding1,sounding2,sounding3,kmTop)
    %
    %Output:
    %foundit: the index of the sounding corresponding to the time
    %
    %Inputs:
    %y: four digit year
    %m: two digit month
    %d: one or two digit day
    %t: one or two digit time
    %sounding1: a structure of soundings data
    %sounding2: a structure of soundings data
    %sounding3: a structure of soundings data (enter [] if not plotting a third sounding)
    %kmTop: OPTIONAL the maximum height in km to be plotted, defaults to 13 km.
    %
    %The number of soundings to be plotted is controlled by findsnd and the
    %number of colors; changing these would allow for more soundings to be
    %plotted.
    %
    %Version Date: 9/4/2018
    %Last major revision: 6/28/2018
    %Written by: Daniel Hueholt
    %North Carolina State University
    %Undergraduate Research Assistant at Environment Analytics
    %
    %See also compositePlotter, findsnd
    %

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

% Collect data to plot
[foundit] = findsnd(y,m,d,t,sounding1,sounding2,sounding3);

if isnan(foundit)==1 %If the date doesn't have a corresponding entry in the sounding structure, foundit will be NaN
    %findsnd generates its own command window message but won't stop the function on its own
    return
end

% Mash all input soundings into a single structure--this allows for access
% to the different structures by parsing the fieldnames.
composite.sounding1 = sounding1;
composite.sounding2 = sounding2;
if isempty(sounding3)~=1
    composite.sounding3 = sounding3;
end
fields = fieldnames(composite);

% Declare colors
% colors.blackberry = [174,109,143]./255;
% colors.duskyblue = [132,154,197]./255;
% colors.turquoisey = [65,197,199]./255;
colors.darkteal = [63 149 165]./255;
colors.chartreuse = [184 182 77]./255;

colors.dustypurple = [121 86 116]./255; 
colornames = fieldnames(colors);

for sc = length(foundit):-1:1
    kmCutoff = logical(composite.(fields{sc})(foundit(sc)).calculated_height <= kmTop+1); %Find indices of readings where the height is less than or equal to the input maximum height, plus one to prevent the plot from cutting off in an ugly way
    useGeo = composite.(fields{sc})(foundit(sc)).calculated_height(kmCutoff==1);
    useTemp = composite.(fields{sc})(foundit(sc)).temp(kmCutoff==1);
    kmCutWind = logical(composite.(fields{sc})(foundit(sc)).calculated_height<=kmTop); %Cut off at kmTop (instead of kmTop+1) as otherwise barbs will be plotted in the top since clipping has been disabled
    useWindSpd = composite.(fields{sc})(foundit(sc)).wind_spd(kmCutWind==1);
    useWindSpd = useWindSpd.*1.943844; %Convert m/s to knots
    useWindDir = composite.(fields{sc})(foundit(sc)).wind_dir(kmCutWind==1);
    
    if isempty(useTemp)==1
        useGeo = composite.(fields{sc})(foundit(sc)).geopotential./1000;
        kmCutoff = logical(useGeo <= kmTop+1);
        kmCutWind = logical(useGeo <= kmTop);
        useGeo = useGeo(kmCutoff==1);
        useWindSpd = composite.(fields{sc})(foundit(sc)).wind_spd(kmCutWind==1);
        useWindDir = composite.(fields{sc})(foundit(sc)).wind_dir(kmCutWind==1);
        useTemp = NaN(1,length(useGeo));
    end
    
    % Extra quality control to prevent jumps in the graphs
    useGeo(useGeo<-150) = NaN;
    useGeo(useGeo>100) = NaN;
    useTemp(useTemp<-150) = NaN;
    useTemp(useTemp>100) = NaN;
    useWindDir(useWindDir>360) = NaN;
    useWindSpd(useWindSpd>999.9) = NaN;
    
    % Freezing line
    freezingy = [0 16];
    freezingx = ones(1,length(freezingy)).*0;
    
    % Plotting
    TvZ(sc) = plot(useTemp,useGeo); %TvZ
    set(TvZ(sc),'Color',colors.(colornames{sc})); %Set color dynamically
    set(TvZ(sc),'LineWidth',2.8)
    hold on
    
    % Plot settings
    dateString = datestr(datenum(composite.(fields{sc})(foundit(sc)).valid_date_num(1),composite.(fields{sc})(foundit(sc)).valid_date_num(2),composite.(fields{sc})(foundit(sc)).valid_date_num(3),composite.(fields{sc})(foundit(sc)).valid_date_num(4),0,0),'dd mmm yyyy HH UTC'); %For title
    [launchname{sc}] = stationLookupIGRAv2(composite.(fields{sc})(foundit(sc)).stationID);
    axe = gca;
    axe.Box = 'off';
    axe.FontName = 'Lato';
    axe.FontSize = 30;
    if length(launchname)>1
        t = title([launchname ' Soundings for ' dateString]);
    else
        t = title([launchname ' Sounding for ' dateString]);
    end
    t.FontName = 'Lato Bold';
    t.FontSize = 14;
    xLab = xlabel(['Temperature in ' char(176) 'C']);
    xLab.FontName = 'Lato Bold';
    xLab.FontSize = 30;
    yLab = ylabel('Height in km');
    yLab.FontName = 'Lato Bold';
    yLab.FontSize = 30;
    axe.YTick = [0 0.5 1 1.5 2 2.5 3 3.5 4 4.5 5 6 7 8 9 10 11 12 13];
    axe.XTick = [-45 -40 -35 -30 -25 -22 -20 -18 -16 -14 -12 -10 -8 -7 -6 -5 -4 -3 -2 -1 0 1 2 3 4 5 6 8 10 12 14 16 18 20 22 25 30 35 40];
    %xlim([min(useTemp)-1 max(useTemp)+1]) %Dynamically set x-axis limits
    
    %Best consistent axis for winter JFK/LGA comparison is -15 to 20C
    %JFK/LGA winter: -15 to 20
    %Falmouth/Nantucket summer: 0 to 25
    %Aberdeen/Rapid City/Omaha Valley winter: -20 to 10
    
    xMin = -8; %C
    xMax = 11; %C
    xlim([xMin xMax])
    ylim([0 kmTop])
    hold on
    
    for w = 1:length(useWindSpd)
        if isnan(useWindSpd(w))==1
            continue %Don't plot NaN winds at all
        end
        %windbarb(xMax+0.4+sc,useGeo(w),useWindSpd(w),useWindDir(w),0.025,1.9,colors.(colornames{sc}),1); %original
        if sc==1 %Start the wind profile just outside of the figure, far enough that no possible barb will intrude onto the TvZ
            windbarb(xMax+0.4,useGeo(w),useWindSpd(w),useWindDir(w),0.025,1.9,colors.(colornames{sc}),1); %for narrow plot
        else
            windbarb(xMax+sc-0.8,useGeo(w),useWindSpd(w),useWindDir(w),0.025,1.9,colors.(colornames{sc}),1); %for narrow plot
        end
        hold on
    end
    
end

freeze = plot(freezingx,freezingy,'Color','k','LineWidth',2.2); %Freezing line; plotted last so that it will have the final legend item

if length(launchname)==1
    leg = legend([TvZ freeze],launchname{1},'Freezing');
if length(launchname)==2
    leg = legend([TvZ freeze],launchname{1},launchname{2},'Freezing');
elseif length(launchname)==3
    leg = legend([TvZ freeze],launchname{1},launchname{2},launchname{3},'Freezing');
end
leg.FontName = 'Lato';
leg.FontSize = 24;

fig = gcf;
set(fig,'PaperUnits','inches','PaperPosition',[0 0 20 10.46]) %1920x1004
dateStringFilename = datestr(datenum(composite.(fields{sc})(foundit(sc)).valid_date_num(1),composite.(fields{sc})(foundit(sc)).valid_date_num(2),composite.(fields{sc})(foundit(sc)).valid_date_num(3),composite.(fields{sc})(foundit(sc)).valid_date_num(4),0,0),'mmmddyyyyHH');
print(fig,[dateStringFilename '.png'],'-dpng')

%close all
end