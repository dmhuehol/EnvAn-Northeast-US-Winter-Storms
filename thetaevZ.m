function [] = thetaevZ(snum,sounding,kmTop)
%%thetaevZ
    %Plots equivalent potential temperature profile against height. The vertical 
    %gradient of equivalent potential temperature (theta_e) is a measure of stability.
    %If d(thetaie)/dz is positive, the layer is stable. Conversely, if d(thetaie)/dz
    %is negative, the layer is unstable.
    %
    %General form: thetaevZ(snum,sounding,kmTop)
    %
    %Inputs
    %snum: index of the sounding to plot within the data structure
    %sounding: a sounding data structure
    %kmTop: maximum height (in km) to be plotted
    %
    %
    %Version date: 4/9/2019
    %Last major revision: 4/9/2019
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

% Convert units
tempK = temp+273.15; %Celsius to Kelvin

[qvOut] = qv(tempK,rh,pres);
[thetae] = theta_e(pres,tempK,qvOut);

% Optional unit conversion
%thetae is usually displayed in Kelvin.
%thetae = thetaie-273.15; %Kelvin to Celsius

% Plot the equivalent potential temperature profile
thetaeProfile = plot(thetae,height);

% Plot settings
thetaeProfile.LineWidth = 2.5;
thetaeProfile.Color = [16 84 86]./255;
ylim([0 kmTop])
axe = gca;
axe.FontName = 'Lato';
axe.FontSize = 14;
xLab = xlabel('\theta_e (K)');
xLab.FontSize = 16;
yLab = ylabel('Height (km)');
yLab.FontSize = 16;

% Make title
fakeMin = 0; fakeSec = 0; %Need minutes, seconds to make datenums
soundDate = sounding(snum).valid_date_num;
dateNumber = datenum(soundDate(1),soundDate(2),soundDate(3),soundDate(4),fakeMin,fakeSec);
dateString = datestr(dateNumber,'DD mmm YYYY HH UTC');
t = title(['\theta_e vs height ' dateString]);
t.FontSize = 18;

end

