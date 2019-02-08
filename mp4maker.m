%savePath  - Where the data live. e.g. savePath = 'C:\me\myData\myFrames\'; 
function [] = mp4maker(savePath)
writerObj = VideoWriter([savePath 'v8_20180210_azi103_testwith_rhoHV_90'],'MPEG-4');
writerObj.FrameRate = 1; %in frames per second; customize to your data
open(writerObj);
%frameList=dir([savePath '*azi109*.png']);%make the wildcard strings that work for you

% Combined images have V, SW, Z, snow rate, and Zdr in that order
vpath = 'H:\radar output\testImages\11_semifinal\Sweep 1\V_dealiased\';
zpath = 'H:\radar output\testImages\11_semifinal\Sweep 1\Z\';
swpath = 'H:\radar output\testImages\11_semifinal\Sweep 1\SW\';
zdrpath = 'H:\radar output\testImages\11_semifinal\Sweep 1\Zdr\';
snowratepath = 'H:\radar output\testImages\11_semifinal\Sweep 1\snow_rate\';
rhohvpath = 'H:\radar output\testImages\11_semifinal\Sweep 1\rhoHV\';
frameListV = dir([vpath '*.png']);%make the wildcard strings that work for you
frameListZ = dir([zpath '*.png']);
frameListSW = dir([swpath '*.png']);
frameListZdr = dir([zdrpath '*.png']);
frameListSnowRate = dir([snowratepath '*.png']);
frameListRhohv = dir([rhohvpath '*.png']);

for ii=1:length(frameListV)-1
    %filenames{ii} = [vpath frameListV(ii).name];
    %filenames{ii+1} = [zpath frameListZ(ii).name];
    %Img=imread([savePath frameListV(ii).name]);
    V = imread([vpath frameListV(ii).name]);
    Z = imread([zpath frameListZ(ii).name]);
    SW = imread([swpath frameListSW(ii).name]);
    Zdr = imread([zdrpath frameListZdr(ii).name]);
    %[appropriateR,appropriateC,appropriate3] = size(Zdr);
    %blankMat = zeros(appropriateR,appropriateC,appropriate3);
    SnowRate = imread([snowratepath frameListSnowRate(ii).name]);
    rhoHV = imread([rhohvpath frameListRhohv(ii).name]);
    concatImage = [V, SW;Z,SnowRate;Zdr,rhoHV];%; Z; SnowRate; Zdr];
    %smallerConcat = imresize(concatImage,[1088 1920]);
    %smallerConcat = imresize(concatImage,0.90);
    %Img = imtile(filenames);
    %smallerConcat = concatImage;
    writeVideo(writerObj,concatImage); %that was easy
    %clear names
end
close(writerObj);

disp('COMPLETED!')

end

