function [] = thetaievZ(snum,sounding,kmTop)
%%thetaievZ
    %Calculates the isobaric equivalent potential temperature at each level for an
    %input sounding, then plots the isobaric equivalent potential temperature
    %profile against height. The vertical gradient of equivalent potential
    %temperature (thetaie) is a measure of stability. In general, if d(thetaie)/dz
    %is positive, the layer is stable. Conversely, if d(thetaie)/dz is
    %negative, the layer is unstable.
    %
    %General form: thetaievZ(snum,sounding,kmTop)
    %
    %Inputs
    %snum: index within the structure of the sounding to plot
    %sounding: a sounding data structure
    %kmTop: maximum height (in km) to be plotted
    %
    %
    %Version date: 8/16/2018
    %Last major revision: 8/15/2018
    %Written by: Daniel Hueholt
    %North Carolina State University
    %Undergraduate Research Assistant at Environment Analytics
    %
    %See also addHeight
    %

if ~exist('kmTop','var')
    kmTop = 8;
    heightMsg = 'Maximum height defaulted to 8 km.';
    disp(heightMsg)
end
    
temp = sounding(snum).temp;
pres = sounding(snum).pressure;
rh = sounding(snum).rhum;
%height = sounding(snum).geopotential./1000; %Height included with observations (usually preferred)
height = sounding(snum).calculated_height; %Height calculated by addHeight function

% Constants
pSurface = 100000; %Pa
poissonConstant = 2/7;
Lv = 2.5*10^6; %J/kg
cp = 1005; %J/(K*kg)
pConstant = 611; %Pa
tConstant = 5417; %K
%Rv = 461.5; %J/(K*kg)
ccConstant = 19.83;
epsilon = 0.622;

% Convert units
temp = temp+273.15; %Celsius to Kelvin

% Calculate mixing ratio from relative humidity
esT = pConstant.*(exp(ccConstant-tConstant./temp));
e = rh./100.*esT;
w = (epsilon.*e)./(pres-e); %mixing ratio

% Calculate the potential temperature
theta = temp.*(pSurface./pres).^(poissonConstant);

% Calculate the equivalent potential temperature
thetaie = theta.*(1+(Lv.*w)./(cp.*temp));

% Optional unit conversion
%thetaie is usually displayed in Kelvin. If this section is uncommented, it
%will instead be converted to degrees Celsius.
%thetaie = thetaie-273.15; %Kelvin to Celsius

% Plot the equivalent potential temperature profile
thetaieProfile = plot(thetaie,height);
thetaieProfile.LineWidth = 2.5;
thetaieProfile.Color = [16 84 86]./255;
ylim([0 kmTop])

% Plot settings
axe = gca;
axe.FontName = 'Lato';
axe.FontSize = 14;

fakeMin = 0;
fakeSec = 0;
soundDate = sounding(snum).valid_date_num;
dateNumber = datenum(soundDate(1),soundDate(2),soundDate(3),soundDate(4),fakeMin,fakeSec);
dateString = datestr(dateNumber,'DD mmm YYYY HH UTC');
t = title(['Equivalent potential temperature vs height ' dateString]);
t.FontSize = 18;

xLab = xlabel('Isobaric equivalent potential temperature (K)');
xLab.FontSize = 16;
yLab = ylabel('Height (km)');
yLab.FontSize = 16;

end

