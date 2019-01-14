%savePath  - Where the data live. e.g. savePath = 'C:\me\myData\myFrames\'; 
function [] = mp4maker(savePath)
writerObj = VideoWriter([savePath '20171221_azi200_fiveReordered'],'MPEG-4');
writerObj.FrameRate = 1; %in frames per second; customize to your data
open(writerObj);
%frameList=dir([savePath '*azi109*.png']);%make the wildcard strings that work for you

% Combined images have V, SW, Z, snow rate, and Zdr in that order
vpath = 'H:\radar output\CSU-CHILL\20171221\X\PPI\AMSloops\Sweep 0\V_dealiased\';
zpath = 'H:\radar output\CSU-CHILL\20171221\X\PPI\AMSloops\Sweep 0\Z\';
swpath = 'H:\radar output\CSU-CHILL\20171221\X\PPI\AMSloops\Sweep 0\SW\';
zdrpath = 'H:\radar output\CSU-CHILL\20171221\X\PPI\AMSloops\Sweep 0\Zdr\';
snowratepath = 'H:\radar output\CSU-CHILL\20171221\X\PPI\AMSloops\Sweep 0\snow_rate\';
frameListV = dir([vpath '*.png']);%make the wildcard strings that work for you
frameListZ = dir([zpath '*.png']);
frameListSW = dir([swpath '*.png']);
frameListZdr = dir([zdrpath '*.png']);
frameListSnowRate = dir([snowratepath '*.png']);

for ii=1:length(frameListV)-1
    %filenames{ii} = [vpath frameListV(ii).name];
    %filenames{ii+1} = [zpath frameListZ(ii).name];
    %Img=imread([savePath frameListV(ii).name]);
    V = imread([vpath frameListV(ii).name]);
    Z = imread([zpath frameListZ(ii).name]);
    SW = imread([swpath frameListSW(ii).name]);
    Zdr = imread([zdrpath frameListZdr(ii).name]);
    [appropriateR,appropriateC,appropriate3] = size(Zdr);
    blankMat = zeros(appropriateR,appropriateC,appropriate3);
    SnowRate = imread([snowratepath frameListSnowRate(ii).name]);
    concatImage = [V, SW;Z,SnowRate;Zdr,blankMat];%; Z; SnowRate; Zdr];
    %smallerConcat = imresize(concatImage,[1024 768]);
    smallerConcat = imresize(concatImage,0.31);
    %Img = imtile(filenames);
    writeVideo(writerObj,smallerConcat); %that was easy
    %clear names
end
close(writerObj);

disp('COMPLETED!')

end

