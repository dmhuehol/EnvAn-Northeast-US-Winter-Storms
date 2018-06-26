function [sndng,lev,withdew,withheight] = fullIGRAimpAfrica(input_file)
%%fullIGRAimpAfrica
    %Function which, given a file of raw IGRA v2 soundings data, will read
    %the data into MATLAB, filter it according to level type, add dewpoint,
    %At each step of the way, a new soundings structure is created and can
    %be output.
    %
    %General form:
    %[sndng,lev,withdew,withheight] = fullIGRAimpAfrica(input_file)
    %
    %Outputs:
    %sndng: raw soundings data read into MATLAB and separated into different
    %   readings, unfiltered.
    %lev: filtered by level type
    %withdew: dewpoint added
    %withheight: calculated height added
    %
    %Input:
    %input_file: file path of an IGRA v2 data file
    %
    %Written by Daniel Hueholt
    %North Carolina State University
    %Undergraduate Research Assistant at Environment Analytics
    %Version date: 6/25/2018
    %
    %
    %See also fullIGRAimp
    %

% Give a useful message, since the first step takes longer than the others
disp('Import started!')
    
% Read soundings data into MATLAB
try
    [~,sndng] = importIGRAv2(input_file); %Retains v2sndng structure only
catch ME
    msg = 'Failed to create raw soundings structure! Check data file for errors and try again.';
    error(msg)
end
disp('Successfully created raw soundings structure! 1/4')

% Filter soundings by level
try
[lev] = levfilter(sndng,3); %Remove all level type 3 data (corresponding to extra wind layers, which throw off geopotential height and other variables)
catch ME
    msg = 'Failed at level type filter!';
    error(msg)
end
disp('Level filtering complete! 2/4')

lev = lev'; %Correct shape of structure

% Add dewpoint and temperature to the soundings data
[withdew] = addDewRH(lev,'dew');
disp('Added dewpoint! 3/4')

% % Optional time filter
% filter_settings.year = [1970 1971 1972 1973];
% [withdew] = timefilter(withdew,filter_settings);

% Add height to the soundings data
[withheight] = addHeight(withdew);
disp('Added height! 4/4')

disp('Import complete!')

end