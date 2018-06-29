%%rhumplot
    %Function to generate figure with charts of relative humidity vs pressure
    %and relative humidity vs height, given a sounding number and a sounding
    %data structure.
    %
    %General form: [cloudBase] = rhumplot(snum,sounding)
    %
    %Outputs:
    %cloudBase: estimated level of cloud base, using a threshold value of
    %   relative humidity. This is extremely basic and findTheCloud should
    %   be used instead in almost every circumstance.
    %
    %Inputs:
    %snum: a sounding number (sounding number for a specific date can be found
    %   using findsnd or soundplots)
    %sounding: a soundings data structure
    %trz: logical to show a figure with subplots for Tvz and RHvz
    %
    %For another (arguably more useful) way to visualize moisture, use the
    %wetbulb functions.
    %
    %Version Date: 6/05/2018
    %Last major revision: 6/05/2018
    %Written by: Daniel Hueholt
    %North Carolina State University
    %Undergraduate Researcher at Environment Analytics
    %
    %See also: soundplots, findsnd, IGRAimpf, findTheCloud
    %
    
function [cloudBase] = rhumplot(snum,sounding,trz)
if ~exist('trz','var')
    trz = 1; %Assume trz on
end

% Define freezing line
freezingx = [0 1200];
freezingy = ones(1,2).*0; %If a different line is desired, change the .*0 to .*n
freezingxg = [0 16];
freezingyg = ones(1,2).*0;

thresholdRH = length(sounding);

check = fieldnames(sounding); %Find fieldnames; this is used to check if dewpoint and relative humidity need to be added

if isempty(nonzeros(ismember(check,'rhum'))) == 1 %Check if the sounding has a relative humidity field (named rhum if generated by dewrelh)
    for a = 1:thresholdRH
        [sounding(a).dewpoint,sounding(a).relative_humidity] = dewrelh(sounding(a).temp,sounding(a).dew_point_dep); %Call to dewrelh to add dewpoint and relative humidity
    end
end

mb200 = find(sounding(snum).pressure >= 20000); %Find indices of readings where the pressure is greater than 20000 Pa
presheight = sounding(snum).pressure(mb200); %Select readings greater than 20000 Pa
presheightvector = presheight/100; %Convert Pa to hPa (mb)

% If possible, first geopotential height entry should be straight from the data
if isnan(sounding(snum).geopotential(1))==0
    geoheightvector(1) = sounding(snum).geopotential(1)/1000;
    %disp('1 is good')
else
    %do nothing
end

geoheightvector = geoheightvector'; %Transpose to match shape of others, important for polyxpoly

% Define rhum and temp as humidities and temp from surface to 200mb as a
% basic attempt to cut out the stratosphere.
% (temp is not plotted, but still needed to calculate geopotential height)
rhum = sounding(snum).rhum(mb200);
geotemp = sounding(snum).temp(mb200);

R = 287.75; %dry air constant J/(kgK)
grav = 9.81; %gravity m/s^2

for z = 2:length(presheightvector')
    geoheightvector(z) = (R/grav*(((geotemp(1)+273.15)+(geotemp(z)+273.15))/2)*log(presheightvector(1)/presheightvector(z)))/1000; %%Equation comes from Durre and Yin (2008) http://journals.ametsoc.org/doi/pdf/10.1175/2008BAMS2603.1
end

% Extra quality control to prevent jumps in the graphs
geoheightvector(geoheightvector<-150) = NaN;
geoheightvector(geoheightvector>100) = NaN;
presheightvector(presheightvector<0) = NaN;
sounding(snum).rhum(sounding(snum).rhum<0) = NaN;
sounding(snum).dewpt(sounding(snum).dewpt<-150) = NaN;

% Find cloud base (estimated as first height where RH=100)
[thresholdRH,~] = find(rhum(rhum==100));
cloud = NaN; %Assume there isn't a cloud
if ~isempty(nonzeros(thresholdRH))
    cloud = thresholdRH(1);
end
if isnan(cloud)==1
    cloudBase(1) = NaN; %Pressure level
    cloudBase(2) = NaN; %Height
else
    cloudBase(1) = presheightvector(cloud); %Pressure level
    cloudBase(2) = geoheightvector(cloud); %Height
end

figure;
g = subplot(1,2,1); %RHvP is on left subplot
rhvp = plot(rhum,presheightvector);
ax = gca;
set(ax,'FontName','Lato Bold')
set(rhvp,'LineWidth',2.5)

g2 = subplot(1,2,2); %RHvz is on right subplot
rhvz = plot(rhum,geoheightvector); %RHvz
set(rhvz,'LineWidth',2.5)
axe = gca;
set(axe,'FontName','Lato Bold')

%Plot settings
dateString = num2str(sounding(snum).valid_date_num); %Used in title
title(g,['Sounding for ' dateString]);
title(g2,['Sounding for ' dateString]);
xlabel(g,'Relative Humidity in %');
xlabel(g2,'Relative Humidity in %');
xlim(g,[-2 102])
xlim(g2,[-2 102])
ylabel(g,'Pressure in mb')
ylabel(g2,'Height in km')
set(g,'YDir','reverse');
ylim(g,[250 nanmax(presheightvector)]);
ylim(g2,[0 12]);
set(g2,'yaxislocation','right')
hold off

if trz == 1 %Depending on input, a temperature vs height graph is also constructed
    figure;
    g3 = subplot(1,2,1); %Tvz on left subplot of second figure
    tvz = plot(geotemp,geoheightvector,freezingyg,freezingxg,'r'); %Tvz
    set(tvz,'LineWidth',2.5)
    ax2 = gca;
    set(ax2,'FontName','Lato Bold')
    
    g4 = subplot(1,2,2); %RHvz on right subplot of second figure
    rhvz2 = plot(rhum,geoheightvector); %RHvz
    set(rhvz2,'LineWidth',2.5)
    axe2 = gca;
    set(axe2,'FontName','Lato Bold')
    
    dateString = num2str(sounding(snum).valid_date_num);
    title(g3,['Sounding for ' dateString])
    title(g4,['Sounding for ' dateString])
    xlabel(g3,'Temperature (deg C)')
    xlabel(g4,'Relative Humidity (%)')
    ylabel(g3,'Height (km)')
    ylabel(g4,'Height (km)')
    ylim(g3,[0 12]);
    ylim(g4,[0 12]);
    xlim(g4,[-2,102])
    set(g4,'yaxislocation','right')
    hold off
else
    %do nothing
end

end