%%skewtIGRA
    %Function to plot a skewT-logP diagram for a given sounding from a
    %soundings data structure. For a general skew-T plotter, use skewT.
    %
    %General form: [] = skewtIGRA(snum,soundStruct)
    %
    %Inputs:
    %snum: the index of the desired sounding (use findsnd to locate a
    %sounding index for a particular date).
    %soundStruct: a soundings data structure
    %
    %Adapted from code found on MIT Open Courseware, ocw.mit.edu
    %Written by: Daniel Hueholt
    %Version date: 1/8/2020
    %Last major revision: 1/8/2020
    %
    %See also skewT, TvZ, soundplots, findsnd, fullIGRAimp
    %
    
function [] = skewtIGRA(snum,soundStruct)
pz = soundStruct(snum).pressure./100; %Retrieve pressure and convert from Pa to hPa
tz = soundStruct(snum).temp; %Retrieve temperature
rhz = soundStruct(snum).rhum./100; %Retrieve relative humidity and convert from % to decimal

ez=6.112.*exp(17.67.*tz./(243.5+tz)); %calculate saturation vapor pressure
qz=rhz.*0.622.*ez./(pz-ez); %calculate mixing ratio
chi=log(pz.*qz./(6.112.*(0.622+qz)));
tdz=243.5.*chi./(17.67-chi); %calculate dew

p=1050:-25:100; %Construct values for the pressure axis
pplot=p';
t0=-50:2:50; %Construct values for the temperature axis
ps = length(p);
ts = length(t0);
for i=1:ts
   for j=1:ps
      tem(i,j)=t0(i)+30.*log(0.001.*p(j)); %Used wherever temperature is needed
      thet(i,j)=(273.15+tem(i,j)).*(1000./p(j)).^.287; %dry adiabats
      es=6.112.*exp(17.67.*tem(i,j)./(243.5+tem(i,j)));
      q(i,j)=622.*es./(p(j)-es); %isohumes
      thetaea(i,j)=thet(i,j).*exp(2.5.*q(i,j)./(tem(i,j)+273.15)); %equivalent potential temperature
   end
end
p=p';
t0=t0';
temp=tem';
theta=thet';
thetae=thetaea';
qs=sqrt(q)';
figure;
hold on
set(gca,'yscale','log','ydir','reverse') %pressure decreases with height
set(gca,'ytick',100:100:1000)
set(gca,'ygrid','on') %Adds isobars
set(gca,'FontName','Lato Bold')
hold on
contour(t0,pplot,theta,24,'b'); %dry adiabats
contour(t0,pplot,qs,24,'g'); %isohumes
contour(t0,pplot,thetae,24,'r'); %moist adiabats
%tsound=30.+43.5.*log(0.001.*p);
%tsoundm=tsound-30.*log(0.001.*p);
tzm=tz-30.*log(0.001.*pz); %Skew observed temperature
tdzm=tdz-30.*log(0.001.*pz); %Skew observed dewpoint
h=plot(tzm,pz,'k',tdzm,pz,'k--'); %Plot observed temperature and dewpoint
set(h,'linewidth',2)

temps = -100:10:40; %Isotherm temperatures
tempNull = NaN(length(tzm'),length(temps)); %Each column will be an isotherm
for col = 1:length(temps)
    tempNull(:,col) = temps(col); %Populate NaN matrix with isotherm values
end
tempLines = tempNull-30.*log(0.001.*pz); %Apply skew
isotherms = plot(tempLines,pz,'Color','k','LineWidth',1); %Plot isotherms in black
zeroInd = find(temps==0); %Find the 0C isotherm
isotherms(zeroInd).Color = 'm'; %#ok %Plot the 0C isotherm in magenta! Suppress code analyzer warning because it doesn't apply here.

hold off
xlabel('Temperature (C)','FontName','Lato Bold')
ylabel('Pressure (mb)','FontName','Lato Bold')
dateString = num2str(soundStruct(snum).valid_date_num); %Used in title
t = title(['Sounding for ' dateString]);
set(t,'FontName','Lato Bold')
set(t,'FontSize',16)
xlim([-40,40])
ylim([100,1000])

end