
# EnvAn-Northeast US Winter Storms

Contains MATLAB software for meteorological data analysis, particularly soundings and surface observations. Used mostly for the northeast US winter storms project at Environment Analytics.

Unless otherwise noted, all functions are written by Daniel Hueholt at North Carolina State University.

abacusDemo: Demonstrates abacus plots, the plot style used to plot ASOS precipitation type data versus time in surfacePlotter.

addaxis: Functions to add multiple axes to a plot. Written by Harry Lee; found on the MATLAB file exchange. Updated 28 June 2018 with Jessica Keller's fix to make these functions compatible with MATLAB 2017+.
Original link: https://www.mathworks.com/matlabcentral/profile/authors/863384-harry-lee

addDewRH: Adds calculated dewpoint and/or relative humidity fields to a soundings data structure, as long as that structure includes dewpoint depression measurements. Updated 9 April 2019 to clean code.

addHeight: Adds a calculated geopotential height field to a soundings structure. Updated 25 June 2018 with new user input features to control error checking. Updated 9 April 2019 to clean code.

addWetbulb: Adds a calculated wetbulb field to a soundings structure. Runtime can be extremely long as a consequence of numerical evaluation.

ASOSdownloadFiveMin: Downloads Automated Surface Observation System (ASOS) five-minute data from the NCDC database.

ASOSgrabber: Enables browsing of ASOS structures by grabbing a section of data from a structure around a given input time.

ASOSimportFiveMin: Imports five-minute ASOS data into MATLAB given an input file.

ASOSimportManyFiveMin: Imports multiple ASOS five-minute data files into MATLAB as a structure from a list of filenames.

cloudplot: Plot cloud given vertical coordinates of the cloud layers.

compositePlotter: Plots composites of wetbulb and/or air temperature versus height.

convection: Calculates convective parameters given an input sounding. Currently only calculates K-index and Total Totals Index.

datetickzoom: Function which expands on datetick so the ticks update at different zoom levels, originally written by Christophe Lauwerys. Link: https://www.mathworks.com/matlabcentral/fileexchange/15029-datetickzoom-automatically-update-dateticks

dewFromRH: Calculates dewpoint given temperature and relative humidity.

dewrelh: Calculates dew point and relative humidity from temperature and dew point depression.

eswLine: Function to make arrays of water RH difference from ice saturation. Used to make isohumes on ice growth diagram.

findsnd: Find the index number corresponding to a particular date and time within a soundings data structure.

findTheCloud: Finds cloud layers within a sounding for a given time, outputting the upper and lower bounds for use by cloudplot. Uses threshold relative humidity values to locate cloud, which is known to be a poor method of locating cloud.

fullIGRAimp: Imports IGRA data and applies multiple processing methods from other functions, outputting a new sounding structure associated with each modification to the data structure. Updated 25 June 2018 with new version control at input to make compatible with IGRA v2 data. Requires importIGRAv1, importIGRAv2, timefilter, levfilter, addDewRH, dewrelh, surfconfilter, nosedetect, prestogeo, simple_prestogeo

growthDiagramProfile: Plot weather balloon data on the ice growth diagram.

habitDiagramLegacy: Legacy script to plot Bailey-Hallett 2009 habit diagram. Superseded by iceGrowthDiagram.

iceGrowthDiagram: Function to plot the s-T ice growth diagram with various viewing options (i.e. include isohumes, updraft guesstimation, ventilation supersaturation lin, etc.)

iceSupersatToRH: Convert an ice supersaturation to a relative humidity.

importIGRAv1: Creates a structure of soundings data from raw Integrated Global Radiosonde Archive v1 .dat data. Renamed from IGRAimpf on 3 June 2018. (Based on part of a script originally written by Megan Amanatides.)

importIGRAv2: Imports IGRA v2 sounding data files into a MATLAB data structure. Updated 25 June 2018 to fix spelling errors in the function help. Updated 28 June 2018 to import station ID as well.

levfilter: Removes an input level type from a soundings data structure.

locateASOSstations: Locates all ASOS stations within a bounding box of latitude and longitude.

makeGrowthDiagramStruct: Function to create a structure with information to make the ice growth diagram. Designed to be used by functions like iceGrowthDiagram, but also useful on its own.

newtip: Creates a custom Data Cursor tooltip using variables from within a parent function. Must be nested within another function. This version of newtip is specifically designed to work with wnAllPlot and wnYearPlot, but the method could easily be adapted for any similar circumstance.

plotyyy: Plots data using three y-axes. Small changes made to original function written by Denis Gilbert of the Maurice Lamontagne Institute. Link to original function: https://www.mathworks.com/matlabcentral/fileexchange/1017-plotyyy

precipfilterASOS: Filters a soundings data structure by whether precipitation was occurring near the time of the sounding, as determined by ASOS 5-minute observations. Updated 26 June 2018 to fix error where some soundings would not sync up with ASOS data properly.

prestogeo: Calculates geopotential height given pressure and temperature. Includes a variety of bonus options which make it easier to use with other functions; for a bare-bones geopotential height calculator, see simple_prestogeo. Equation comes from Durre and Yin (2008) http://journals.ametsoc.org/doi/pdf/10.1175/2008BAMS2603.1 

rangebardemo: Demonstration of the “stacked” and “patch" methods to make ranged bar charts.

rhow: Calculate excess vapor density with respect to ice for a given humidity and temperature.

rhumplot: Generate a figure with charts of relative humidity vs pressure and relative humidity vs height from input sounding number and sounding data structure.

RHvZ: Makes a simple plot of relative humidity vs height.

simple_prestogeo: Calculates geopotential height given pressure and temperature. This is a no-frills calculator; see prestogeo for a calculator designed to interface with other functions.

skewT: Generate a skew-T chart given information for input humidity, temperature, pressure, and dewpoint data. Adapted from code found at MIT OpenCourseware. Link to original site:
https://ocw.mit.edu/courses/earth-atmospheric-and-planetary-sciences/12-811-tropical-meteorology-spring-2011/tools/

skewtIGRA: Generate a skew-T chart for an input sounding. Adapted from code originally found at MIT OpenCourseware. Link to original site: https://ocw.mit.edu/courses/earth-atmospheric-and-planetary-sciences/12-811-tropical-meteorology-spring-2011/tools/

soundplots: Generates a variety of figures (TvZ, TvP, RHvZ, RHvP, skew-T) based on soundings data for a specific time and date. Requires: dewrelh, skewtIGRA, rhumplot

stationLookupIGRAv2: Retrieves the name of a sounding launch site given a station ID; allows for automation of figure title creation. Updated July 2018 with better name for Denver soundings.

surfacePlotter: Visualizes ASOS five-minute surface conditions data on two figures: one displaying temperature, pressure, dewpoint, humidity, wind, and wind character; the second is an abacus plot of precipitation type. Requires external functions addaxis, tlabel, and windbarb. addaxis was originally written by Harry Lee, tlabel by Carlos Adrian Vargas Aguilera, and windbarb by Laura Tomkins.
addaxis original link: https://www.mathworks.com/matlabcentral/fileexchange/9016-addaxis
tlabel original link: https://www.mathworks.com/matlabcentral/fileexchange/19314-tlabel-m-v2-6-1--sep-2009-
Laura Tomkins can be found on github @lauratomkins

surfAnalysisDemo: Demonstrates the creation of a local surface analysis using toy data.

surfconfilter: Filters a soundings data structure based on surface relative humidity and/or temperature.

thetaevZ: Function to plot equivalent potential temperature profile vs height. Equivalent potential temperature is a useful metric of static stability. Note that this function requires several helper functions not included in this repository.

timefilter: Removes input years and months from a sounding structure. Updated 25 June 2018 with some reorganization and more accurate final message. Updated 28 June 2018 to attempt to improve empty month message, but honestly the messaging system in this function is a trainwreck and needs to be reworked.

tlabel: External function to improve on datetick and datetickzoom. Written by Carlos Adrian Vargas Aguilera, found on the MATLAB file exchange. Original link: https://www.mathworks.com/matlabcentral/fileexchange/19314-tlabel-m-v2-6-1--sep-2009-

TTwvZ: Plots temperature and wetbulb temperature against height given an input time and soundings data structure. Updated 26 June 2018 to work with new names for calculated height field, and to change datatype to double. Updated 2 August 2018 with minor improvements and temporary aesthetic changes.

TvZ: Plots temperature vs height from soundings data given an input time.

TvZbasic: Plots temperature vs height from soundings data given an input time, with figure settings set up for maximum ease in customization. Renamed from TvZprint in final push.

TvZcomparison: Plots a composite temperature and wind vs height figure for multiple sites at an input time. Requires findsnd, TvZ, and windbarb. windbarb function was written by Laura Tomkins (github @lauratomkins).

TwindvZ: Plots temperature and wind vs height for an input time. Requires windbarb. windbarb function was written by Laura Tomkins (github @lauratomkins). Updated 23 July 2018 with repair for issue where windbarbs would be plotted in the wrong place if the T-span was set by user instead of being generated dynamically.

updraftSupersat: Calculates the guesstimated maximum possible supersaturation inside an updraft. Uses some magic parameters and updraft speed as an input. Based on the equation from MEA412 at NC State, which allegedly comes from Hodges 1967 but I've never actually been able to find it in that paper.

usefulColorSchemes: A script containing some useful color schemes.

viewer: Sequentially displays all soundings for an input span of time in either temperature vs height or temperature+wetbulb vs height format. Block of code to save all images is commented out. Suffers from the issue that prestogeo has when the first entry in a soundings temperature vector is NaN and therefore geopotential height cannot be calculated. In Phase 3, this function (and likely all vZ functions) will be changed to use the geopotential field included in IGRA v2 data. Updated 25 June 2018 so figures are only opened if the plotting completes successfully.

weatherCodeSearch: Locates all times that an input weather code is observed in an ASOS data structure.

wetbulb: Numerically evaluates the wetbulb temperature given dewpoint, pressure, and temperature.

windbarb: Plots wind barbs. Written by Laura Tomkins (github @lauratomkins) in May 2017. Edited to disable clipping for all possible lines (makes plotting wind profile vs height possible).

windbarbForSurfAn: Very lightly modified version of windbarb to make it plot correctly on ASOS surface analyses. windbarb function was written by Laura Tomkins (github @lauratomkins) in May 2017.

windplot: Demonstrates how to make a wind barb time series as used in surfacePlotter. Requires windbarb. windbarb function was written by Laura Tomkins (github @lauratomkins) in May 2017.

windvZ: Plots wind against height for an input sounding.

In progress:

buoyImport: Imports National Buoy Data Center buoy data files into MATLAB, applying some data conversions. Not very robust; needs better method of handling multiple files.

buoyPlotter: Plots air temperature, sea surface temperature, and dewpoint against time. Only works if all data is the same length; needs to be fixed in import and tested more extensively here.

diffusivityConstant: Function (in progress) to calculate the diffusivity constant.

eraT: Function to plot temperature profiles from European Reanalysis data given lat/lon, time, and surface pressure. Also shows a map with position of actual profile gridpoint relative to the input lat/lon. Currently written to work with Denver site, but wouldn't take much effort to generalize.

eraTz: As eraT, but for temperature-height profiles rather than temperature-pressure.

excessVaporDensity: cancelled

findCloseSoundings: Very beginning of a function to find close soundings given inputs such as time span, lat/lon box, or both.

fullIGRAimpAfrica: Imports IGRA v2 data and applies multiple processing methods specifically useful with historical data from Africa. Not perfect, moisture processing often needs to be redone as early soundings will report humidity and later soundings will report dewpoint depression.

fullIGRAimpv2: Imports and processes a v2 data structure. This function works great, but isn't documented.

gravityWaveASOS_testscript: Script that was used to test whether ASOS 5-minute or ASOS 1-minute pressure observations could easily detect gravity waves. Uses a known case from Raleigh with strong gravity waves detected by better pressure sensors and visible on radar.

inversionCounter: renamed 3 August 2018 to inversionsAndMeltingLayers

inversions: Generates plots of statistics of inversions, such as height distributions. Plots are generated correctly, but currently the function to count inversions doesn't work.

inversionsAndMeltingLayers: Detects and counts inversions within a sounding structure. Correctly represents whether a sounding has a lowest-5 inversion or not, but currently misrepresents the number of inversions in each sounding. Last updated 2 July 2018.

makeComparisonImages: Script to easily generate TvZcomparison images.

mp4maker: Old version of function to make mp4 loops of radar data. The current version of this is not included in this repository (but probably should be).

TTdTwvZ: Function to plot temperature, dewpoint, and wetbulb temperature against height. All of these more complicated profile plotter functions are a bit of a mess and should be reconsidered.

TTwThetaewindvZ: Plots profile for temperature, wetbulb, equivalent potential temperature, and wind against height. Doesn't work, and is overly complicated.

TTwwindvZ: Plots profiles for wind, temperature, and wetbulb temperature given an input sounding. Currently works, but needs testing and documentation revision. Documentation is currently unchanged from the precursor function TTwvZ. All of these complicated profile plotter functions are overly complicated and should be reworked.

TTwvZcompairons: Function to create composite temperature and wetbulb profiles vs height. Like TvZcomparison, but for TTwvZ figures.

periodOfRecord: Displays the timeline of soundings launches near Long Island, NY throughout the IGRA v2 period. Shows spans only; written before I realized there were discontinuities in the individual files that the documentation did not describe. Updated 28 June 2018 with NC stations.

surfAnalysisLI: Creates a local surface analysis for Long Island based on ASOS five-minute observations. Currently in the very early stages of development.

vaporDensityToSupersat: cancelled

Other files:

KISP 2015 ASOS data.mat: Data structure containing ASOS 5-minute data from all months of 2015.

