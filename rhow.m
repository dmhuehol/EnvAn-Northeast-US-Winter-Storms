function [rhoDiff] = rhow(percent,T)
%%eswLine
    %Calculates vapor density for a given RH percent and T
    %
    %General form: [rhoDiff] = rhow(percent,T)
    %
    %Output
    %rhoDiff: vapor density excess, hopefully
    %
    %Input
    %percent: A water saturation RH in percent
    %T: a temperature in Celsius
    %
    %Written by: Daniel Hueholt
    %North Carolina State University
    %Undergraduate Research Assistant at Environment Analytics
    %Version date: 4/30/2019
    %Last major revision: 
    %

%Constants
Lsub = 2.834*10^6; %J/(kg)
Lvap = 2.501*10^6; %J/Kg
Rv = 461.5; %J/(kgK)
es0 = 611; %Pa

percent = percent/100;

Tk = T+273.15;
eswStandard = es0*exp(Lvap/Rv*(1/273.15-(1./Tk))); %Saturated vapor pressure with respect to water
esiStandard = es0*exp(Lsub/Rv*(1/273.15-(1./Tk))); %Saturated vapor pressure with respect to ice
eswPercent = eswStandard.*percent;

%plot(Tk-273,eswStandard./100);
%hold on
%plot(Tk-273,esiStandard./100);

%e = rho*R*T
% e/(RT) = rho
rhow = eswPercent./(Rv*Tk);
rhoi = esiStandard./(Rv*Tk);

%rhowLineData = eswPercent./esiStandard-1;
rhoDiff = rhow-rhoi;
rhoDiff = rhoDiff.*10^3;


end