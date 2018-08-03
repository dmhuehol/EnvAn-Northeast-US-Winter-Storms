function [inversionNum,faulty,percentInversion,invo] = inversionsAndMeltingLayers(soundingStruct)
%%inversionsAndMeltingLayers
    %Detects and counts temperature inversions in the lowest 5 km of the
    %atmosphere for all soundings in an input structure.
    %
    %General form: [inversionNum,faulty,percentInversion,invo] = inversionsAndMeltingLayers(soundingStruct)
    %
    %Outputs:
    %inversionNum: Number of soundings with temperature inversions present
    %   in the lowest ~5km
    %faulty: Number of soundings that failed somewhere in the process
    %percentInversion: Percentage of soundings in the structure that have a
    %   temperature inversion in the lowest ~5km
    %invo: Structure containing information regarding the inversions
    %   detected
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

%% Counters and variables
tc = 1;
heightPlus = 1;
inversionNum = 0;
faulty = 0;
fCount = 1;
switcher = 0;
invo = struct([]);

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
        continue %Skip the faulty sounding
    end
    
    while tc<km5Ind(1) %For the lowest 5km of the atmosphere (roughly)
        try
            if switcher==0
                h1 = soundingStruct(sc).geopotential(tc);
                h2 = soundingStruct(sc).geopotential(tc+heightPlus);
                mcheck = h2-h1; %Check the span between each index pair
            elseif switcher==1
                h1 = soundingStruct(sc).calculated_height(tc);
                h2 = soundingStruct(sc).calculated_height(tc+heightPlus);
                mcheck = h2-h1; %Check the span between each index pair
            end
            hSave(tc,1) = h1; hSave(tc,2) = h2;
        catch ME %#ok %If this fails
            disp(sc) %Let the user know
            tc = tc+1; %Try the next pair
        end
        if mcheck<0.20 %If the distance between the index span is less than 200 meters
            heightPlus = heightPlus+1; %Increase the index span
        else %If the distance is greater than or equal to 200 meters
            try
                t1 = soundingStruct(sc).temp(tc);
                t2 = soundingStruct(sc).temp(tc+heightPlus);
                lr(tc) = t2-t1; %The local lapse rate is the change in temperature within the layer of 200 meters or greater thickness
                tSave(tc,1) = t1; tSave(tc,2) = t2;
            catch ME %#ok If this fails (which it shouldn't)
                disp(sc) %Display the current loop indices
                disp(tc)
            end
            tc = tc+heightPlus; %Increment the loop, check the next pair of indices that hasn't already been checked
            
            %There's an unresolved problem here that misrepresents the
            %inversion quantity and depth. tc = tc+1 will identify too
            %many, as the same inversion will be sampled multiple times,
            %but because the sample keeps advancing, it's not as simple as
            %just cutting out overlapping indices. tc = tc+heightPlus
            %doesn't oversample quite as bad, but seems to miss inversions
            %occasionally. This seems to be a better approach then trying
            %to fix the overlapping later, though.
            disp(tc)
            pause(0.1)
            heightPlus = 1; %Reset the index span
        end
        
    end
    invert = lr(lr>0); %When the lapse rate is greater than 0, a temperature inversion is present
    %    disp(invert)
    %    pause(0.2)
    
    invo(sc).valid_date_num = soundingStruct(sc).valid_date_num;
    if isempty(invert)==1 %If there are no temperature inversions anywhere in the lowest 5 profile
        invo(sc).Presence = 0;
        % These could be assigned outside the if statement, but I like this
        % order for the fields so I'm leaving it
        invo(sc).AllHeights = hSave;
        invo(sc).AllTemps = tSave;
        invo(sc).AllLapseRates = lr;
        invo(sc).LapseRateInversions = zeros(1,length(lr));
        invo(sc).InversionTemps = [];
        invo(sc).InversionHeights = [];
        invo(sc).AverageInversionHeights = [];
    elseif isempty(invert)~=1 %If there is at least one temperature inversion somewhere in the lowest 5 profile
        invo(sc).Presence = 1;
        invo(sc).AllHeights = hSave;
        invo(sc).AllTemps = tSave;
        invo(sc).AllLapseRates = lr;
        invo(sc).LapseRateInversions = invo(sc).AllLapseRates>0;
        invo(sc).InversionTemps = invo(sc).AllTemps(invo(sc).LapseRateInversions,:);
        invo(sc).InversionHeights = invo(sc).AllHeights(invo(sc).LapseRateInversions,:);
        
        invTops = invo(sc).AllHeights(invo(sc).LapseRateInversions,2);
        [~,uniqueInd,~] = unique(invTops);
        uniqueInvTemps = invo(sc).InversionTemps(uniqueInd,:);
        uniqueInvHeights = invo(sc).InversionHeights(uniqueInd,:);
        
        % The inversions can still overlap, which is a problem
        
        invo(sc).UniqueInversionTemps = invo(sc).InversionTemps(uniqueInd,:);
        invo(sc).UniqueInversionHeights = invo(sc).InversionHeights(uniqueInd,:);
        
        if size(invo(sc).UniqueInversionHeights,1)>1 %The inversion has to be unique if there's only one
            for uniCount = 2:size(uniqueInvHeights,1) %The first inversion must be unique, so start the loop at 2
                if uniqueInvHeights(uniCount,1)<uniqueInvHeights(uniCount-1,2)
                    uniqueInvHeights(uniCount,1) = NaN; %NaN both
                    uniqueInvHeights(uniCount-1,2) = NaN; %indices
                else
                    %do nothing
                end
            end
            invo(sc).UniqueInversionHeights(isnan(uniqueInvHeights)==1) = NaN; %NaN the overlapping indices in both the height
            invo(sc).UniqueInversionTemps(isnan(uniqueInvHeights)==1) = NaN; %and the temperature matrices
        end
            
        
        invo(sc).AverageInversionHeights = mean(invo(sc).UniqueInversionHeights,2); %Apply the mean function row-wise
        
 
        
%        disp('A lovely burnt-umber Segway')
    else %It should be logically impossible to reach this, but you can't be too careful
        disp('???')
    end
    
    if soundingStruct(sc).temp(1)>=0 %Check if there is a non-inverted melting layer at the surface
        invo(sc).MeltingAtSurface = 1;
    else
        invo(sc).MeltingAtSurface = 0;
    end    
    
    % Reset everything for the next loop
    lr = [];
    invert = [];
    heightPlus = 1;
    tc = 1;
    h1 = []; h2 = []; hSave = [];
    t1 = []; t2 = []; tSave = [];
end

presence = [invo.Presence];
inversionNum = length(presence(presence==1));

percentInversion = inversionNum/(length(soundingStruct)-fCount)*100; %Calculate the percentage of soundings with inversions

end