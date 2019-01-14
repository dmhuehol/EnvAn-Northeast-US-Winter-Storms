function [eVD] = excessVaporDensity(T)
%%excessVaporDensity
    %Calculates the excess water vapor density at a given temperature.
    %
    %General form: [eVD] = excessVaporDensity(T)
    %
    %Output
    %eVD: the excess water vapor density for the temperature
    %
    %Input
    %T: a temperature in Kelvin
    %
    %Version date: 8/14/2018
    %
    %Written by: Daniel Hueholt
    %North Carolina State University
    %Undergraduate Research Assistant at Environment Analytics
    %

% Constants
Lsub = 2.834*10^6; %J/(kg)
Lvap = 2.501*10^6; %J/Kg
Rv = 461.5; %J/(kgK)
es0 = 611; %Pa

% Calculate vapor pressures
esw = es0*exp(Lvap/Rv*(1/273.15-1./T)); %Calculate the saturated vapor pressure with respect to water
esi = es0*exp(Lsub/Rv*(1/273.15-1./T)); %Saturated vapor pressure with respect to ice

% Calculate excess vapor density
eDiff = esw-esi;
%disp(['eDiff is ' num2str(eDiff)])
eVD = (eDiff/(Rv*T)).*1000;
%disp(['rhoDiff is ' num2str(rhoDiff)])

end