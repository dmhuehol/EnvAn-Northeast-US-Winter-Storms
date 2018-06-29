datesJLN = [1970,2,16,12; 1970,3,3,12; 1970,4 14 12; 1971,2,11,12; 1971,11,29,12; 1971,12,10,12; 1972,1,4,12; ...
    1972,1,6,12; 1972,1,17,12; 1972,3,14,12];

newDatesJLN = [1969,11,19,12; 1969,12,2,12; 1969,12,9,12; 1969,12,29,12; 1969,12,30,12; 1970,1,5,12; 1970,1,12,12; ...
    1970,1,19,12; 1970,2,17,12; 1970,3,4,12; 1970,3,6,12; 1970,4,3,12; 1970,4,17,12; 1970,4,20,12; 1970,4,21,12; 1970,4,22,12; ...
    1970,4,23,12; 1970,11,2,12];

datesSterDC = [1973,1,16,12; 1973,2,6,12; 1973,2,7,12; 1973,2,14,12; 1973,2,15,12; 1973,2,20,12];

struct1 = subsetv2Ster;
struct2 = subsetv2DC;
struct3 = subsetv2WalIs;

for dateLoop = 1:length(datesSterDC)
    try
        TvZcomparison(datesSterDC(dateLoop),datesSterDC(dateLoop,2),datesSterDC(dateLoop,3),datesSterDC(dateLoop,4),struct1,struct2,struct3,3);
    catch ME
        disp(dateLoop)
        continue
    end
end