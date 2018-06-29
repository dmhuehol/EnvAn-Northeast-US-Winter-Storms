function [v2] = fullIGRAimpv2(filename)
[~,v2] = importIGRAv2(filename);
[v2] = levfilter(v2,3);
[v2] = addHeight(v2);
[v2] = addDewRH(v2,'both');
[v2] = addDewRH(v2,'dew');
end