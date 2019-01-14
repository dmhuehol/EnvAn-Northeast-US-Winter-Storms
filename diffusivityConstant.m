function [diffCon] = diffusivityConstant(temp,pressure)

A = 1.858*10^(-3); %(atm*square Angstrom*square centimeter*sqrt(g/mol))/(K^(3/2)*s)
mMassH2O = 18.015; %g/mol
mMassDryAir = 29; %g/mol

kB = 1.381*10^-23*6.022*10^23; %J/(K molecule)
g = 9.81*10^2; %cm/s^2

%meanFreePath = 66*10^(-7);
%numberDensity = pressure./(R.*T);

collisionDiameterH2O = 2.65; %Angstrom

pPas = 101325;
meanFreePathAtm = 66*10^(-7); %centimeter
numberDensityAtm = pPas./(kB.*temp);
collisionDiameterAtm = sqrt(1./(sqrt(2).*pi.*meanFreePathAtm.*numberDensityAtm));

sigma12 = 1/2.*(collisionDiameterH2O+collisionDiameterAtm);

omega = 0.9; %approximation

diffCon = (A.*(temp.^(3/2)).*sqrt(1./mMassH2O+1./mMassDryAir))./(pressure.*sigma12^2.*omega);
end
