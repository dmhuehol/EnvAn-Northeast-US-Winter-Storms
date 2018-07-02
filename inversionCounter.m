function [inversionNum,faulty,percentInversion] = inversionCounter(soundingStruct)
%%inversionCounter
    %Detects and counts temperature inversions in the lowest 5 km of the
    %atmosphere for all soundings in an input structure.
    %
    %General form: [inversionNum,faulty,percentInversion] = inversionCounter(soundingStruct)
    %
    %Outputs:
    %inversionNum: Number of soundings with temperature inversions present
    %   in the lowest ~5km
    %faulty: Number of soundings that failed somewhere in the process
    %percentInversion: Percentage of soundings in the structure that have a
    %   temperature inversion in the lowest ~5km
    %
    %Input:
    %soundingStruct: A soundings data structure, which must have a
    %   calculated height field.
    %
    %Version date: 7/2/2018
    %Last major revision: 7/2/2018
    %Written by: Daniel Hueholt
    %North Carolina State University
    %Undergraduate Research Assistant at Environment Analytics
    %
    %See also addHeight
    %

%% Counters
tc = 1;
heightPlus = 1;
inversionNum = 0;
faulty = 0;
fCount = 1;
switcher = 0;

%% Detect inversions
for sc = 1:length(soundingStruct)
    soundingStruct(sc).geopotential = soundingStruct(sc).geopotential./1000; %Convert to km
    km5Ind = find(soundingStruct(sc).geopotential>=5); %Locate the first index of 5km or greater height in the sounding
    if isempty(km5Ind)==1
        km5Ind = find(soundingStruct(sc).calculated_height>=5); %Try it again, with the calculated height field
        switcher = 1;
    end
    
    if isempty(km5Ind)==1 %If the index cannot be located in either calculated height or measured height, then the sounding is faulty
        faulty(fCount) = sc; %Record this
        fCount = fCount+1;
        continue %Skip the sounding
    end
    
    while tc<km5Ind(1) %For the lowest 5km of the atmosphere (roughly)
        try
            if switcher==0
                mcheck = soundingStruct(sc).geopotential(tc+heightPlus)-soundingStruct(sc).geopotential(tc); %Check the span between each index pair
            elseif switcher==1
                mcheck = soundingStruct(sc).calculated_height(tc+heightPlus)-soundingStruct(sc).calculated_height(tc); %Check the span between each index pair
            end
        catch ME %#ok If this fails
            disp(sc) %Let the user know
            %fCount = fCount+1; %The sounding is faulty? I don't think so,
            %this'll lead to a false increase in faulty soundings as the
            %fault counter could increment multiple times in a single
            %sounding
            tc = tc+1; %Try the next pair
        end
        if mcheck<0.20 %If the distance between the index span is less than 200 meters
            heightPlus = heightPlus+1; %Increase the index span
        else %If the distance is already greater than or equal to 200 meters
            try
                lr(tc) = soundingStruct(sc).temp(tc+heightPlus)-soundingStruct(sc).temp(tc); %The local lapse rate is the change in temperature within the layer of 200 meters or greater thickness
            catch ME %#ok If this fails (which it shouldn't)
                disp(sc) %Display the current loop indices
                disp(tc)
            end
            tc = tc+1; %Increment the loop, check the next pair of indices
            heightPlus = 1; %Reset the index span
        end
    end
    invert = lr(lr>0); %When the lapse rate is greater than 0, a temperature inversion is present
    %    disp(invert)
    %    pause(0.2)
    if isempty(invert)==1 %If there are no temperature inversions anywhere in the lowest 5 profile
%         %This is unused
%         standardtastic(st) = 1; %Then it's 'standard'
%         st = st+1;
    elseif isempty(invert)~=1 %If there is at least one temperature inversion somewhere in the lowest 5 profile
        inversionNum = inversionNum+1; %Increase the inversion number
%         nst = nst+1; %This is unused
    else
        disp('???') %Wow what
    end
    
    % Reset everything for the next loop
    lr = [];
    invert = [];
    heightPlus = 1;
    tc = 1;
end

percentInversion = inversionNum/(length(soundingStruct)-fCount)*100; %Calculate the percentage of soundings with inversions

end