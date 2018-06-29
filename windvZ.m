%%windvz
    %Function to plot wind vs height for an input sounding. Wind is plotted
    %as windbarbs, with speed represented in knots.
    %
    %General form: [foundit] = windvZ(y,m,d,t,sounding,kmTop)
    %
    %Output:
    %foundit: the index of the sounding corresponding to the time
    %
    %Inputs:
    %y: four digit year
    %m: two digit month
    %d: one or two digit day
    %t: one or two digit time (hour)
    %sounding: a structure of soundings data
    %kmTop: OPTIONAL the maximum height in km to be plotted, defaults to 13 km.
    %
    %Version Date: 6/28/2018
    %Last major revision: 6/28/2018
    %Written by: Daniel Hueholt
    %North Carolina State University
    %Undergraduate Research Assistant at Environment Analytics
    %
    %See also TwindvZ
    %

function [foundit] = windvZ(y,m,d,t,sounding,kmTop)
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
kmCutWind = logical(sounding(foundit).calculated_height<=kmTop);
useWindSpd = sounding(foundit).wind_spd(kmCutWind==1);
useWindSpd = useWindSpd.*1.943844; %Convert m/s to knots
useWindDir = sounding(foundit).wind_dir(kmCutWind==1);

% Extra quality control to prevent jumps in the graphs
useGeo(useGeo<-150) = NaN;
useGeo(useGeo>100) = NaN;

figure;
% Plot settings must come first or windbarb scaling will be screwed up
dateString = datestr(datenum(sounding(foundit).valid_date_num(1),sounding(foundit).valid_date_num(2),sounding(foundit).valid_date_num(3),sounding(foundit).valid_date_num(4),0,0),'mmm dd, yyyy HH UTC'); %For title
[launchname] = stationLookupIGRAv2(sounding(foundit).stationID);
axe = gca;
axe.FontName = 'Lato';
axe.FontSize = 12;
axe.YTick = [0 0.5 1 1.5 2 2.5 3 3.5 4 4.5 5 6 7 8 9 10 11 12 13];
axe.XTick = [];
xlim([0.5 1.5])
ylim([0 kmTop])
titleHand = title([launchname ' Sounding for ' dateString]);
titleHand.FontName = 'Lato Bold';
titleHand.FontSize = 14;
ylabelHand = ylabel('Height in km');
ylabelHand.FontName = 'Lato Bold';
ylabelHand.FontSize = 14;
axe.Box = 'off';

% Make wind barbs
for w = 1:length(useWindSpd)
    windbarb(1,useGeo(w),useWindSpd(w),useWindDir(w),0.04,0.8,'r',1);
    hold on
end


hold off

end