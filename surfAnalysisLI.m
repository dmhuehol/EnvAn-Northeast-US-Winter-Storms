%Version Date: 6/11/2018
%Written by Daniel Hueholt
%function [] = surfAnalysisLI(years,months,days,hours,minutes,folder)

%WILL BE INPUTS
% startYear = 2016; startMonth = 2; startDay = 8; startHour = 10; startMinute = 0;
% endYear = 2016; endMonth = 3; endDay = 11; endHour = 10; endMinute = 30;

year = 2016;
month = 2;
day = 8;
hour = 10;
minute = 0;
folder = 'C:\Users\danielholt\Documents\MATLAB\Project 1 - Warm Noses\Surface Obs';
%Possible inputs: multiple months with single year, multiple years with
%single month, multiple months with multiple years

addpath(folder)
% Build file name to import
obsType = '64010'; %NOAA designation for ASOS 5-minute data
longIslandStations = {'KLGA','KJFK','KFRG','KISP','KHWV','KFOK'};

% Redo everything below this to obey new input structure
if startMonth==endMonth
    monthString = num2str(startMonth);
elseif startMonth<endMonth
    months = startMonth:endMonth;
    monthString = strsplit(num2str(months));
    lengthCheck = cellfun(@length,monthString); %Find months that are length 1
    logicalLength = logical(lengthCheck==1); %Logically index on months with length 1
    monthString(logicalLength) = strcat('0',monthString(logicalLength)); %Add a leading 0 to make them length 2
elseif startMonth>endMonth
    months = startMonth:12;
    months2 = 1:endMonth;
    months = [months,months2];
    monthString = strsplit(num2str(months));
    lengthCheck = cellfun(@length,monthString); %Find months that are length 1
    logicalLength = logical(lengthCheck==1); %Logically index on months with length 1
    monthString(logicalLength) = strcat('0',monthString(logicalLength)); %Add a leading 0 to make them length 2
end

if startYear==endYear
    yearString = num2str(startYear);
    yearString = yearString';
    yearString = reshape(jaa,1,[],4); %3D array where each 2D plane is a year
elseif startYear~=endYear
    years = startYear:endYear;
    yearString = strsplit(num2str(years)); %Cell array where each cell is a year
    
    %Change in year
end

extension = '.dat'; %File extension for ASOS data files


for monthCount = 1:months(end)
    for fileMaker = length(longIslandStations):-1:1
        filelist{fileMaker} = [obsType longIslandStations{fileMaker} yearString months(monthCount) extension];
    end
end

if strcmp(filenameStart,filenameEnd)==1
    [dataForAnalysis,~] = ASOSimportFiveMin(filenameStart);
else
    [dataForAnalysis1,~] = ASOSimportFiveMin(filenameStart);
    [dataForAnalysis2,~] = ASOSimportFiveMin(filenameEnd);
end

latMinNEUS = 40.485792;
lonMinNEUS = -74.213238;
latMaxNEUS = 41.101459;
lonMaxNEUS = -72.356828;
axLI = usamap([latMinNEUS latMaxNEUS],[lonMinNEUS lonMaxNEUS]);
latlim = getm(axLI,'MapLatLimit');
lonlim = getm(axLI,'MapLonLimit');
states = shaperead('usastatehi','UseGeoCoords',true,'BoundingBox',[lonlim',latlim']);
geoshow(axLI,states,'FaceColor',[1 1 1]);

KLGAlat = 40.777; KLGAlon = -73.873;
[KLGAx,KLGAy] = mfwdtran(KLGAlat,KLGAlon);
windbarb(KLGAx,KLGAy,10,31,0.028,0.08,'r',1)
KISPlat = 40.795; KISPlon = -73.1;
[KISPx,KISPy] = mfwdtran(KISPlat,KISPlon);
windbarb(KISPx,KISPy,10,95,0.028,0.08,'r',1)

temperature = textm(KISPlat+0.01,KISPlon-0.02,'10');
set(temperature,'FontSize',6); set(temperature,'FontName','Lato Bold'); set(temperature,'Color','r')
dewpoint = textm(KISPlat-0.01,KISPlon-0.02,'3');
set(dewpoint,'FontSize',6); set(dewpoint,'FontName','Lato Bold'); set(dewpoint,'Color','r')
altimeter = textm(KISPlat+0.01,KISPlon+0.01,'1014.7');
set(altimeter,'FontSize',6); set(altimeter,'FontName','Lato Bold'); set(altimeter,'Color','r')
precipCode = textm(KISPlat-0.01,KISPlon+0.01,'FZRA');
set(precipCode,'FontSize',6); set(precipCode,'FontName','Lato Bold'); set(precipCode,'Color','r')

%end