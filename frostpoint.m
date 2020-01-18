%%frostpoint
    %Calculates frostpoint given dewpoint. The frostpoint is the dewpoint
    %with respect to ice saturation, that is, the temperature at which an
    %air parcel cooled isobarically with constant water vapor would reach
    %equilibrium with respect to ice.
    %
    %Vapor pressure equations are the Improved August-Roche-Magnus
    %approximation from:
    % Alduchov, O.A. and R.E. Eskridge, 1996: 
    % Improved Magnus Form Approximation of Saturation Vapor Pressure.
    % J. Appl. Meteor., 35, 601?609,
    % https://doi.org/10.1175/1520-0450(1996)035<0601:IMFAOS>2.0.CO;2
    % See equations 21 and 23 from above citation.
    %
    %Concept for calculating the frostpoint came from:
    % Young, K.C., 1993: Microphysical Processes in Clouds. Oxford
    % University Press, 406-407.
    %
    %General form: tFrost = frostpoint(Td)
    %
    %Output
    %tFrost: frostpoint temperature in C
    %
    %Input
    %Td: dewpoint in Celsius
    %
    %Version date: 1/17/2020
    %Last major revision: 1/17/2020
    %Written by: Daniel Hueholt
    %North Carolina State University
    %Undergraduate Research Assistant at Environment Analytics
    %

function [tFrost] = frostpoint(Td)
syms Tf %Declare the Tf symbol, required for symbolic toolbox operations

eAct = 6.1094.*exp((17.625.*Td)./(243.04+Td)); % Actual vapor pressure calculated from Td using improved ARM

tFrost = vpasolve(eAct == 6.1121.*exp((22.587.*Tf)./(273.86+Tf)),Tf,[-80 0]); %Calculates frostpoint numerically, using concept from pg. 407 of KC Young Microphysical Processes in Clouds and improved ARM relation

% Calculates frostpoint using UCAR 2011 vapor pressure document
%tFrost = vpasolve(Td == 0.009109+Tf.*(1.134055+0.001038.*Tf),Tf,[-60,0]); %eq 5
%tFrost = vpasolve(Td == 4.953828.*10^(-3)+Tf.*(1.132468+Tf.*(8.865794.*10^(-4)+Tf.*(-5.273161.*10^(-6)+Tf.*(-4.492316.*10^(-8))))),Tf,[-100,0]); %eq 6
%disp(tFrost-T) % Show difference between frostpoint and temperature--this should ALWAYS be negative, as temperature is strictly greater than frostpoint/dewpoint
%disp(tFrost)
end