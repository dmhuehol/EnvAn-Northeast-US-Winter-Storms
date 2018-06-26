function [buoy] = buoyImport(filelist)
%%buoyImport
    %Function which imports single or multiple National Buoy Data Center
    %buoy files into a structure, where each file is assigned a new
    %structure row.
    %
    %General form:
    %[buoy] = buoyImpoty(filelist)
    %
    %Outputs:
    %buoy: stucture with the following fields
    %   time: time in datenumbers; data is hourly and is reported on
    %       minute 50
    %   windHourly_speed: 1 hr average wind speed in m/s
    %   windHourly_speed_flag: quality control flag associated with 1 hr average wind speed
    %   windHourly_direction: 1 hr average wind direction in compass degrees
    %   windHourly_direction_flag: quality control flag associated with 1 hr average wind direction
    %   slp: 1 hr average sea level pressure in Pa
    %   slp_flag: quality control flag associated with 1 hr average pressure
    %   temp: 1 hr average temperature in deg C
    %   temp_flag: quality control flag associated with 1 hr average temperature
    %   dewpoint: 1 hr average dewpoint in deg C
    %   dewpoint_flag: quality control flag associated with 1 hr average dewpoint
    %   rhum: 1 hr average relative humidity in %
    %   rhum_flag: quality control flag associated with 1 hr average relative humidity
    %   sst: 1 hr average sea surface temperature in deg C
    %   sst_flag: quality control flag associated with 1 hr average sea surface temperature
    %   latitude: deg N
    %   longitude: deg E
    %
    %Input:
    %filelist: file path of an NDBC data file, or a cell array with
    %   multiple file paths
    %
    %Version Date: 6/26/2018
    %
    %Written by: Daniel Hueholt
    %North Carolina State University
    %Undergraduate Research Assistant at Environment Analytics
    %
    %See also buoyPlotter
    %
    
    
% filename1 = 'C:\Users\danielholt\Documents\MATLAB\Project 1 - Warm Noses\Buoy Data\NDBC_44025_201112_D2_v00.nc';
% filename2 = 'C:\Users\danielholt\Documents\MATLAB\Project 1 - Warm Noses\Buoy Data\NDBC_44025_201201_D2_v00.nc';
% filelist = {filename1,filename2};

buoy = struct([]);
for fileCount = 1:length(filelist)
    buoy(fileCount).time = double(ncread(filelist{fileCount},'time')); %Epoch time starting at 1970-1-1 00:00:00
    buoy(fileCount).time = datenum(buoy(fileCount).time./86400+datenum(1970,1,1,0,0,0)); %Convert time to datenum
    buoy(fileCount).windHourly_speed = ncread(filelist{fileCount},'payload_1/anemometer_1/wind_speed'); %m/s
    buoy(fileCount).windHourly_speed_flag = ncread(filelist{fileCount},'payload_1/anemometer_1/wind_speed_qc');
    buoy(fileCount).windHourly_direction = ncread(filelist{fileCount},'payload_1/anemometer_1/wind_direction'); %Compass degrees
    buoy(fileCount).windHourly_direction_flag = ncread(filelist{fileCount},'payload_1/anemometer_1/wind_direction_qc');
    buoy(fileCount).windHourly_gust = ncread(filelist{fileCount},'payload_1/anemometer_1/hourly_max_gust'); %Maximum 5-second gust in hour
    buoy(fileCount).windHourly_gust_flag = ncread(filelist{fileCount},'payload_1/anemometer_1/hourly_max_gust_qc');
    buoy(fileCount).windHourly_gust_direction = ncread(filelist{fileCount},'payload_1/anemometer_1/direction_of_hourly_max_gust'); %Direction of max 5-second gust in hour
    buoy(fileCount).windHourly_gust_direction_flag = ncread(filelist{fileCount},'payload_1/anemometer_1/direction_of_hourly_max_gust_qc');
    buoy(fileCount).slp = ncread(filelist{fileCount},'payload_1/barometer_1/air_pressure_at_sea_level'); %Sea level pressure in Pa
    buoy(fileCount).slp_flag = ncread(filelist{fileCount},'payload_1/barometer_1/air_pressure_at_sea_level_qc');
    buoy(fileCount).temp = ncread(filelist{fileCount},'/payload_1/air_temperature_sensor_1/air_temperature'); %Air temperature in K
    buoy(fileCount).temp = buoy(fileCount).temp-273.15; %Convert to deg C
    buoy(fileCount).temp_flag = ncread(filelist{fileCount},'/payload_1/air_temperature_sensor_1/air_temperature_qc');
    buoy(fileCount).dewpoint = ncread(filelist{fileCount},'/payload_1/air_temperature_sensor_1/dew_point_temperature'); %Dewpoint in K
    buoy(fileCount).dewpoint = buoy(fileCount).dewpoint-273.15; %Convert to deg C
    buoy(fileCount).dewpoint_flag = ncread(filelist{fileCount},'/payload_1/air_temperature_sensor_1/dew_point_temperature_qc');
    buoy(fileCount).rhum = ncread(filelist{fileCount},'payload_1/humidity_sensor_1/relative_humidity'); % Percent
    buoy(fileCount).rhum_flag = ncread(filelist{fileCount},'payload_1/humidity_sensor_1/relative_humidity_qc');
    buoy(fileCount).sst = ncread(filelist{fileCount},'/payload_1/ocean_temperature_sensor_1/sea_surface_temperature'); %SST in K
    buoy(fileCount).sst = buoy(fileCount).sst-273.15; %Convert to deg C
    buoy(fileCount).sst_flag = ncread(filelist{fileCount},'/payload_1/ocean_temperature_sensor_1/sea_surface_temperature_qc');
    buoy(fileCount).latitude = ncread(filelist{fileCount},'/payload_1/gps_1/latitude'); %Degrees N
    buoy(fileCount).longitude = ncread(filelist{fileCount},'/payload_1/gps_1/longitude'); %Degrees E
end
 
end