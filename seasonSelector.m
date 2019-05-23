function [season] = seasonSelector(sounding,season,year)

if strcmp(season,'winter')==1
    startInd = findsnd(year-1,12,1,00,sounding);
    if isnan(startInd)==1
        startInd = findsnd(year-1,12,1,12,sounding);
    end
    endInd = findsnd(year,2,29,12,sounding);
    if isnan(endInd)==1
        endInd = findsnd(year,2,28,12,sounding);
    end
    if isnan(endInd)==1
        endInd = findsnd(year,2,28,00,sounding);
    end
    if isnan(endInd)==1
        endInd = findsnd(year,2,27,12,sounding);
    end
end
    
    season = sounding(startInd:endInd);


end