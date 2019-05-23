%%mp4maker
    %"Function" which saves an mp4 to an input path from images in given
    %directories. For now, requires a lot of personal intervention to locate
    %the data paths and specified azimuths.
    %savePath  - Where the data live. e.g. savePath = 'C:\me\myData\myFrames\'; 
    %
    %Version Date: 4/20/2019
    %Last major revision: 2/8/2019
    %Written by: Daniel Hueholt
    %North Carolina State University
    %Undergraduate Research Assistant at Environment Analytics
    %
    %Based on sample code by Matthew Miller
    %Senior Research Scholar at Environment Analytics
    %
    %Ideally: inputs are 
        %savePath (save location, will include filename)
        %master path (to date) and the data paths are automatically extrapolated
        %azimuth possibly to certain precision like +/- 1 deg using regular expressions
        %maybe optional input to choose panels plotted? like 8 panel plots
        %everything, 'ncp' plots with ncp, 6 panel plots minus derived
        %fields
    
function [] = mp4maker(savePath)

disp('In progress!')
writerObj = VideoWriter([savePath '20181030_azi271_8panel'],'MPEG-4');
%format: PPI_YYYYMMDD_8panel_angDEG YYYYMMDD_aziDEG_8panel
writerObj.FrameRate = 1; %in frames per second; customize to your data
open(writerObj);
%writerObj4 = VideoWriter([savePath '20181030_PPI_4panel'],'MPEG-4');
%writerObj4.FrameRate = 1;
%open(writerObj4);

% Combined images have V, SW, Z, snow rate, Zdr, rhoHV, PhiDP, and Kdp in that order
% NOTE: Paths MUST have a trailing /
vpath = '/Volumes/Andrew/radar output/CSU-CHILL/20181030/X/RHI/Sweep 0/V_dealiased/';
%v_aliased_path = '/Volumes/EMTECC450/loop/final_checks/Sweep 1/V_folded/';
zpath = '/Volumes/Andrew/radar output/CSU-CHILL/20181030/X/RHI/Sweep 0/Z/';
swpath = '/Volumes/Andrew/radar output/CSU-CHILL/20181030/X/RHI/Sweep 0/SW/';
zdrpath = '/Volumes/Andrew/radar output/CSU-CHILL/20181030/X/RHI/Sweep 0/Zdr/';
snowratepath = '/Volumes/Andrew/radar output/CSU-CHILL/20181030/X/RHI/Sweep 0/snow_rate/';
rhohvpath = '/Volumes/Andrew/radar output/CSU-CHILL/20181030/X/RHI/Sweep 0/rhoHV/';
phidppath = '/Volumes/Andrew/radar output/CSU-CHILL/20181030/X/RHI/Sweep 0/PhiDP/';
kdppath = '/Volumes/Andrew/radar output/CSU-CHILL/20181030/X/RHI/Sweep 0/Kdp/';
%ncppath = '/Volumes/EMTECC450/loop/final_checks/Sweep 1/ncp/';

aziString = '*azi27*'; %aziNUM, usually 3-digits but whatever is necessary to uniquely define
frameListV = dir([vpath aziString '.png']);%make the wildcard strings that work for you
%frameListVfold = dir([v_aliased_path '*.png']);
frameListZ = dir([zpath aziString '.png']);
frameListSW = dir([swpath aziString '.png']);
frameListZdr = dir([zdrpath aziString '.png']);
frameListSnowRate = dir([snowratepath aziString '.png']);
frameListRhohv = dir([rhohvpath aziString '.png']);
frameListPhiDP = dir([phidppath aziString '.png']);
frameListKdp = dir([kdppath aziString '.png']);
%frameListNCP = dir([ncppath '*.png']);

for ii=1:length(frameListZ)-1
    V = imread([vpath frameListV(ii).name]);
    %Vfold = imread([v_aliased_path frameListVfold(ii).name]);
    Z = imread([zpath frameListZ(ii).name]);
    SW = imread([swpath frameListSW(ii).name]);
    Zdr = imread([zdrpath frameListZdr(ii).name]);
    SnowRate = imread([snowratepath frameListSnowRate(ii).name]);
    rhoHV = imread([rhohvpath frameListRhohv(ii).name]);
    PhiDP = imread([phidppath frameListPhiDP(ii).name]);
    Kdp = imread([kdppath frameListKdp(ii).name]);
    %NCP = imread([ncppath frameListNCP(ii).name]);
    
    %[appropriateR,appropriateC,appropriate3] = size(Zdr);
    %blankMat = zeros(appropriateR,appropriateC,appropriate3);
    
    concatImage = [V,SW;Z,SnowRate;Zdr,rhoHV;PhiDP,Kdp]; %8 panel RHI
    %concatImage = [V,SW,Z,SnowRate;Zdr,PhiDP,Kdp,rhoHV]; %8 panel PPI
    %concatImage4 = [V,SW;Z,SnowRate]; %4 panel PPI
    %smallerConcat = imresize(concatImage,[2160 4096]); %y,x for some reason??
    %smallerConcat = concatImage; %test
    smallerConcat = imresize(concatImage,1);
    %smallerConcatImage4 = imresize(concatImage4,1); %4 panel PPI
    writeVideo(writerObj,smallerConcat); %that was easy
    %writeVideo(writerObj4,smallerConcatImage4);
end
close(writerObj);
%close(writerObj4);
disp('COMPLETED!')

end

