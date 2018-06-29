function [validCall,asosSubset] = locateASOSstations(lat,lon)
%%locateASOSstations
    %Finds all ASOS 5-minute stations within a bounding box of decimal
    %latitude/longitude.
    %
    %General form: [validCall,asosSubset] = locateASOSstations(lat,lon)
    %
    %Outputs:
    %validCall: 4-letter call identifiers (i.e. KISP, KLGA) for all
    %   stations within the boundary box, except for those with no call ID.
    %asosSubset: Extract of station ID structure that contains all
    %   information on the stations within the boundary box, including
    %   those with no call ID.
    %
    %Inputs:
    %lat: a 2-element vector containing decimal latitudes in increasing order
    %lon: a 2-element vector containing decimal longitudes in increasing order
    %
    %Version date: 6/28/2018
    %Last major revision: 6/28/2018
    %Written by: Daniel Hueholt
    %North Carolina State University
    %Undergraduate Research Assistant at Environment Analytics
    %
    %See also ASOSimportFiveMin, ASOSimportManyFiveMin
    %

% lat = [33 35];
% lon = [-79 -76];

% Point the function to the station list file (only needs to be changed if
% file has been moved)
try
    stationlistPath = '/Users/Daniel/Documents/MATLAB/ASOS/asos-stations.txt'; %Location of station list file
catch ME
    msg = 'Could not locate station list file! Change stationlistPath to point to the ASOS station list file.';
    error(msg);
end

% Import the station list file as a structure using regular expressions
raw = fileread(stationlistPath);
form = '(?<NCDC>.{8})\s(?<WBAN>.{5})\s(?<COOPID>.{6})\s(?<CALL>.{4})\s(?<Name>.{30})\s(?<AltName>.{30})\s(?<Country>.{20})\s(?<State>.{2})\s(?<County>.{30})\s(?<Latitude>.{9})\s(?<Longitude>.{10})\s(?<Elevation>.{6})\s(?<Time>.{5})\s(?<Type>.{50})\s';
asosList = regexp(raw,form,'names');
asosList(1:2) = []; %Destroy the first two entries, which are placeholders

% Convert latitude/longitude to double
latitudes = cellfun(@str2double,{asosList.Latitude})';
longitudes = cellfun(@str2double,{asosList.Longitude})';

% Call IDs are the standard ASOS IDs (like KISP, KLGA), minus the preceding K.
call = strcat('K',{asosList.CALL}); %It really is this simple!
call = strtrim(call); %Remove trailing whitespace

% Locate valid call IDs
validCall = call(latitudes>lat(1) & latitudes<lat(2) & longitudes>lon(1) & longitudes<lon(2)); %& instead of && since the logicals are vectors, not scalars
validCall(strcmp(validCall,'K')==1) = []; %Remove stations with no call numbers, as this data lowkey doesn't exist

% Extract the structure subset
validInd = latitudes>lat(1) & latitudes<lat(2) & longitudes>lon(1) & longitudes<lon(2);
asosSubset = asosList(validInd==1);


end

