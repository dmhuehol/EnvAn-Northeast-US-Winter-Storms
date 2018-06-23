# EnvAn-Northeast US Winter Storms

Contains MATLAB software for soundings and surface observations data analysis, used mostly for the northeast US winter storms project at Environment Analytics.

Unless otherwise noted, all functions are written by Daniel Hueholt at North Carolina State University.

ASOSimportManyFiveMin: Imports multiple ASOS five-minute data files into MATLAB as a structure from a list of filenames.

importIGRAv2: Imports IGRA v2 sounding data files into a MATLAB data structure.

In progress:

periodOfRecord: Displays the timeline of soundings launches near Long Island, NY throughout the IGRA v2 period. Shows spans only; written before I realized there were discontinuities in the individual files that the documentation did not describe.

surfAnalysisLI: Creates a local surface analysis for Long Island based on ASOS five-minute observations. Currently in the very early stages of development.
