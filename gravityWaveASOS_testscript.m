%% Gravity wave testing
%Is it possible to detect gravity waves in ASOS data?
%Raleigh on 2019 01 13 is a test case with dramatic gravity waves.

load('I:\Surface Obs\gravityWaveData\KRDU201901_1314.mat');

validTimes = times(147:200); %when best waves are occurring
validPres = pres(147:200);

testTimes = times(50:103); %when no waves are occurring
testPres = pres(50:103);

figure;
vp = plot(validTimes,validPres); datetick;
vp.LineWidth = 2;
t = title('RDU ASOS 5-minute pressure timeseries (waves)');
axe = gca;
axe.FontName = 'Open Sans';
t.FontName = 'Open Sans';
xlabel('Time')
ylabel('Pressure (hPa)')

figure;
tep = plot(testTimes,testPres); datetick;
tep.LineWidth = 2;
t = title('RDU ASOS 5-minute pressure timeseries (no waves)');
axe = gca;
axe.FontName = 'Open Sans';
t.FontName = 'Open Sans';
xlabel('Time')
ylabel('Pressure (hPa)')

%Bleh! It doesn't look like it!

%% One Minute Data
load('I:\Surface Obs\gravityWaveData\KRDU201901_onemin.mat');

grab=18500:18740;
times = [jan19(grab).UTC];
pres = [jan19(grab).Pres1];
pres = 33.8639.*pres;

omtep = plot(times,pres);
omtep.LineWidth = 2; omtep.Color = [213,94,0]./255;
axe = gca; axe.FontName = 'Open Sans';
t = title('RDU ASOS 1-minute pressure timeseries (waves)');


