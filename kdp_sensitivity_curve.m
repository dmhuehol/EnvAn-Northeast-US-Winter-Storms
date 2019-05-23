%%Attempting to determine the sensitivity of Kdp to various variables.
%Written by Daniel Hueholt
%North Carolina State University
%Undergraduate Research Assistant at Environment Analytics
%Version date: 5/23/2019
%

lambdaS = 10.7*10^-2;
lambdaC = 5.5*10^-2;
lambdaX = 3.2*10^-2;
lambdaKa = 0.86*10^-2;

C_rayleigh = 1.6; %(g/cm^(-3))^-2
rho_p = 0.9; %plate particle bulk density g/cm^3 %0.107 in textbook Bringi and Chandrasekar 2001 for cloud ice
IWC = linspace(0,1,100); %Ice Water Content, g/m^3
r = 0.25; %particle axis ratio

r_UmMcFarquharEtal_2015 = [2,0.2,0.25,0.5,0.99,1];
r_GarrettYuterEtal_2015 = [0.6,0.85];
r_PlateDistribution = [0.01,0.99];
r_AxisSpectrum = [0.01,0.99,1.01,2];
for r = r_AxisSpectrum
    KdpS = 10^-3.*(180/(lambdaS)).*C_rayleigh.*rho_p.*IWC.*(1-r);
    KdpC = 10^-3.*(180/(lambdaC)).*C_rayleigh.*rho_p.*IWC.*(1-r);
    KdpX = 10^-3.*(180/(lambdaX)).*C_rayleigh.*rho_p.*IWC.*(1-r);
    KdpKa= 10^-3.*(180/(lambdaKa)).*C_rayleigh.*rho_p.*IWC.*(1-r);
    sband = plot(IWC,KdpS);
    sband.LineWidth = 3; sband.Color = [230,159,0]./255;
    hold on
    cband = plot(IWC,KdpC);
    cband.LineWidth = 3; cband.Color = [86,180,233]./255;
    xband = plot(IWC,KdpX);
    xband.LineWidth = 3; xband.Color = [0,158,115]./255;
    axe = gca; axe.FontName = 'Open Sans'; axe.FontSize = 16;
    kaband = plot(IWC,KdpKa);
    kaband.LineWidth = 3; kaband.Color = [204,121,167]./255;
    
    point1line = plot([0.1 0.1],[0,5]);
    point1line.LineWidth = 2; point1line.Color = 'k';
    %leg = legend;
    xlabel('Ice water content (g/m^3)');
    ylabel('Kdp (deg/km)');
    ylim([-5,5]);
    leg = legend([sband,cband,xband,kaband,point1line],'S-band','C-band','X-band','Ka-band','IWC=0.1'); leg.Location = 'northwest';
    t = title(['IWC vs Kdp, rho_p =' num2str(rho_p) ', r=' num2str(r)]); t.FontSize = 20;
    pause(5)
end