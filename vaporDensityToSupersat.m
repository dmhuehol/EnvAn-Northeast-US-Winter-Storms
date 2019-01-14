Rv = 461.5; %J/(kgK)
Tair = 273.15-10; %K
Lsub = 2.834*10^6; %J/(kg)
Lvap = 2.5*10^6; %J/kg
es0 = 611; %Pa

vaporDensity = 0.2;
vaporDensity = vaporDensity*10^-3;
eDiff = vaporDensity*Rv*Tair;
esw = es0*exp(Lvap/Rv*(1/273.15-1./Tair)); %Calculate the saturated vapor pressure with respect to water
esi = es0*exp(Lsub/Rv*(1/273.15-1./Tair)); %Saturated vapor pressure with respect to ice
%esi = esw-eDiff;

supersatIce = (esw-esi)/esi;
supersatIce = supersatIce*100


Tair = 273.15-15;
Tice = 273.15-15+0.45;
esi = es0*exp(Lsub/Rv*(1/273.15-1./Tice));
