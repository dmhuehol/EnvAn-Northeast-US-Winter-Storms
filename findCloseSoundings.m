start = [igra2stationlist.Start];
endYr = [igra2stationlist.End];

logicalEndYear = endYr==2018;

validLat = igra2stationlist.Latitude(logicalEndYear==1);
validLon = igra2stationlist.Longitude(logicalEndYear==1);
validNames = igra2stationlist.Name(logicalEndYear==1);


