%%frostpoint
    %Calculates frostpoint given dewpoint. Calculates frostpoint
    %numerically, using equation from pg. 407 of KC Young Microphysical
    %Processes in Clouds.
    %
    %General form: tFrost = frostpoint(Td)
    %
    %Output
    %tFrost: frostpoint temperature (saturation with respect to ice) in C
    %
    %Input
    %Td: dewpoint in Celsius
    %
    %Version date: 1/10/2020
    %Last major revision: 
    %Written by: Daniel Hueholt
    %North Carolina State University
    %Undergraduate Research Assistant at Environment Analytics
    %

function [tFrost] = frostpoint(Td)
syms Tf %Declare the Tw symbol, required for symbolic toolbox operations

eAct = 6.1094.*exp((17.625.*Td)./(243.04+Td)); % Actual vapor pressure calculated from Td using improved ARM

tFrost = vpasolve(eAct == 6.1121.*exp((22.587.*Tf)./(273.86+Tf)),Tf,[-100 50]); %Solves the frostpoint equation numerically

end