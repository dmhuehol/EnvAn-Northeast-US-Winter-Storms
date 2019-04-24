function [s_max] = updraftSupersat(C,k,w)
%%updraftSupersat
    %Function to calculate maximum possible supersaturation inside an
    %updraft.
    %C, k are magic parameters having to do with aerosols and stuff
    %w is updraft speed in m/s (cm/s conversion handled inside the
    %function).
    %
    %Written by: Daniel Hueholt
    %North Carolina State University
    %Undergraduate Research Assistant at Environment Analytics
    %Version date: 4/15/2019
    %Last major revision: 
    %

if ~exist('C','var')
    C = 1000; %default parameter value for continental airmass, picked pretty arbitrarily from the 300 to 3000 range
end
if ~exist('k','var')
    k = 1; %default parameter value for continental airmass, picked arbitrarily from the 0.2 to 2.0
end
if ~exist('w','var')
    msg = 'Using default updraft speed of 1 m/s';
    warning(msg);
    w = 1;
end

w = w*100; %Convert from m/s to cm/s

s_max = 3.6*(((1.6*10^(-3)*w^(3/2)))/C)^(1/(k+2));


end