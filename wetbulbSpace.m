% Creates a 3-D table representing the space of possible wetbulb
% temperatures for the realistic range of pressure, temperature, and
% dewpoint in the atmosphere. This table can then be used to look up values
% given inputs rather than calculating wetbulb temperature anew for each.
%
%Version Date: 9/27/2019
%Last major revision: 
%Written by: Daniel Hueholt
%North Carolina State University
%Undergraduate Research Assistant at Environment Analytics


%P = [1000:0.1:0];
%T = [-80:0.1:50];
%Td = [-100:0.1:30];
P = [1000,900,800];
T = [0, -10, -20];
Td = [-10, -15, -25];

phaseSpace = NaN(length(P),length(T),length(Td));

for pCount = 1:length(P)
    for tCount = 1:length(T)
        for tdCount = 1:length(Td)
            if Td(tdCount)>T(tCount)
                continue % it's already NaN, so just skip and move on
            end
            epsilon = 0.622;
            Lv = 2.5*10^6; %J/kg
            Cp = 1005; %J/kg
            psychro = (Cp.*P(pCount))./(epsilon.*Lv); %Psychrometric constant
            syms Tw %Declare the Tw symbol, required for symbolic toolbox operations
            %T, P, e
            eAct = 6.11*10.^((7.5.*Td(tdCount))./(237.3+Td(tdCount))); %Actual vapor pressure is calculated from dewpoint
            phaseSpace(pCount,tCount,tdCount) = vpasolve(eAct == 6.11*10.^((7.5.*Tw)./(237.3+Tw))-psychro.*(T(tCount)-Tw), Tw, [-100 50]); %Solves the wetbulb equation numerically
        end
    end
end

pax = phaseSpace(:,1,1);
tax = phaseSpace(1,:,1)';
tdax = reshape(phaseSpace(1,1,:),[3 1]);

scatter3(pax,tax,tdax)
