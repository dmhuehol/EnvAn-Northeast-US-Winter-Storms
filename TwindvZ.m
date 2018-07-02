%%TwindvZ
    %Function to plot temperature and wind against height for a sounding given
    %an input date and a data structure.
    %
    %General form: [foundit] = TwindvZ(y,m,d,t,sounding,kmTop)
    %
    %Output:
    %foundit: the index of the sounding corresponding to the time
    %
    %Inputs:
    %y: four digit year
    %m: two digit month
    %d: one or two digit day
    %t: one or two digit time
    %sounding: a structure of soundings data
    %kmTop: OPTIONAL the maximum height in km to be plotted, defaults to 13 km.
    %
    %windbarb was written by Laura Tomkins, github @lauratomkins
    %
    %Version Date: 7/2/2018
    %Last major revision: 6/28/2018
    %Written by: Daniel Hueholt
    %North Carolina State University
    %Undergraduate Research Assistant at Environment Analytics
    %
    %See also windvZ, TvZ
    %

function [foundit] = TwindvZ(y,m,d,t,sounding,kmTop)
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
r = length(sounding);
dateString = cell(1,r);
for as = 1:r %Loop through everything
    dateString{as} = sounding(as).valid_date_num;
    if isequal(dateString{as},[y,m,d,t])==1 %Look for the requested date
        foundit = as; %here it is!
        foundMsg = 'Index in structure is ';
        disp([foundMsg num2str(foundit)])
        break %Don't loop longer than necessary
    else
        %do nothing
    end
end

if ~exist('foundit','var') %If the date doesn't have a corresponding entry in the sounding structure, foundit won't exist
    disp('No data available for this date!')
    return %Stop the function from running any more
end

if isfield(sounding,'calculated_height')==0 %If height isn't already a field of the sounding
    [sounding] = addHeight(sounding);
end


kmCutoff = logical(sounding(foundit).calculated_height <= kmTop+1); %Find indices of readings where the height is less than or equal to the input maximum height, plus one to prevent the plot from cutting off in an ugly way
useGeo = sounding(foundit).calculated_height(kmCutoff==1);
useTemp = sounding(foundit).temp(kmCutoff==1);
kmCutWind = logical(sounding(foundit).calculated_height<=kmTop);
useWindSpd = sounding(foundit).wind_spd(kmCutWind==1);
useWindSpd = useWindSpd.*1.943844; %Convert m/s to knots
useWindDir = sounding(foundit).wind_dir(kmCutWind==1);

% Extra quality control to prevent jumps in the graphs
useGeo(useGeo<-150) = NaN;
useGeo(useGeo>100) = NaN;
useTemp(useTemp<-150) = NaN;
useTemp(useTemp>100) = NaN;

% Freezing line
freezingx = [0 kmTop];
freezingy = ones(1,length(freezingx)).*0;

% Plotting
figure;
plot(useTemp,useGeo,'Color','b','LineWidth',2.4); %TvZ
hold on
plot(freezingy,freezingx,'Color','r','LineWidth',2) %Freezing line

% Plot settings
fig = gcf;
dateString = datestr(datenum(sounding(foundit).valid_date_num(1),sounding(foundit).valid_date_num(2),sounding(foundit).valid_date_num(3),sounding(foundit).valid_date_num(4),0,0),'mmm dd, yyyy HH UTC'); %For title
[launchname] = stationLookupIGRAv2(sounding(foundit).stationID);
axe = gca;
axe.Box = 'off';
axe.FontName = 'Lato';
axe.FontSize = 12;
axe.YTick = [0 0.5 1 1.5 2 2.5 3 3.5 4 4.5 5 6 7 8 9 10 11 12 13];
axe.XTick = [-45 -40 -35 -30 -25 -22 -20 -18 -16 -14 -12 -10 -8 -6 -5 -4 -3 -2 -1 0 1 2 3 4 5 6 8 10 12 14 16 18 20 22 25 30 35 40];
t = title([launchname ' Sounding for ' dateString]);
t.FontName = 'Lato';
t.FontSize = 18;
xLab = xlabel(['Temperature in ' char(176) 'C']);
xLab.FontName = 'Lato Bold';
xLab.FontSize = 14;
yLab = ylabel('Height in km');
yLab.FontName = 'Lato Bold';
yLab.FontSize = 14;
xlim([min(useTemp)-1 max(useTemp)+2])
%xlim([-11 0])
ylim([0 kmTop])
hold on

for w = 1:length(useWindSpd)
    if isnan(useWindSpd(w))==1 || isnan(useWindDir(w))==1 %If there's missing data
        continue %Skip it
    end
    windbarb(max(useTemp)+4,useGeo(w),useWindSpd(w),useWindDir(w),0.04,0.8,'r',1);
    hold on
end

fig = gcf;
set(fig,'PaperUnits','inches','PaperPosition',[0 0 20 10.46])
dateStringFilename = datestr(datenum(sounding(foundit).valid_date_num(1),sounding(foundit).valid_date_num(2),sounding(foundit).valid_date_num(3),sounding(foundit).valid_date_num(4),0,0),'mmddyyyyHH'); %For filename
print(fig,[dateStringFilename '.png'],'-dpng')


end