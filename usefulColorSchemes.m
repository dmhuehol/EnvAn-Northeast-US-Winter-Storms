%%usefulColorSchemes
    %Script defining various sets of colors that work well together.
    %
    %Version date: 8/16/2018
    %Last major revision: 8/15/2018
    %Written by: Daniel Hueholt
    %North Carolina State University
    %Undergraduate Research Assistant at Environment Analytics
    %
    
 %% Soft
 %Six-color discrete color scale that varies primarily along hue.
 %Safe for blue-yellow colorblindness, but not red-green or red-blue.
 bubblegum = [242 138 171]./255;
 lavender = [169 155 205]./255;
 mediumBlue = [76 167 187]./255;
 forestGreen = [120 150 73]./255;
 earth = [167 126 56]./255;
 teal = [64 164 130]./255;
 %extended
 duskyMagenta = [153 77 136]./255;
 goodGray = [150 150 150]./255; %doesn't-obscure-the-axes-tick gray
 
 %% University colors
 %Common colors corresponding to universities.
 university = struct('NC_State',' ');
 
 university.NC_State.wolfpackRed = [204 0 0]./255;
 university.NC_State.gray10 = [242 242 242]./255; %**Good poster background!
 university.NC_State.gray25 = [204 204 204]./255;
 university.NC_State.gray60 = [102 102 102]./255;
 university.NC_State.gray90 = [51 51 51]./255;
 university.NC_State.reynoldsRed = [153 0 0]./255;
 university.NC_State.pyromanFlame = [209 73 5]./255;
 university.NC_State.huntYellow = [253 215 38]./255;
 university.NC_State.genomicGreen = [111 125 28]./255;
 university.NC_State.innovationBlue = [66 126 147]./255;
 university.NC_State.bioIndigo = [65 86 161]./255;
 
 university.CSU.csuGreen = [30 77 43]./255;
 
 university.UNCW.uncwTeal = [0 112 115]./255;
 university.UNCW.uncwBlue = [0 51 102]./255;
 university.UNCW.uncwYellow = [255 215 0]./255;
 
 %% Habit diagram scales
 
 % Scheme 1: Colorbrewer qualitative colorblind safe 3-class dark2 green
 % and orange, linear by hue 24 degrees
 scheme1.Plates = {'1B9E77','1B909D','1B5C9D', '1B289D', '421B9D'};
 scheme1.Columns = {'D95F02', 'D9B502'};
 scheme1.Mixed = [150 150 150]./255;
 % Result: colors not consistent
 
% Scheme 2: Colorbrewer qualitative colorblind safe 3-class dark2 green
% and purple, shades picked by Creative Cloud
scheme2.Plates = [16 94 71; 40 234 177; 27 158 119; 29 171 129; 23 132 100]./255;
scheme2.Columns = [117 112 178; 75 72 114]./255;
scheme2.Mixed = [150 150 150]./255;
% Result: colors not distinct enough
 
% Scheme 3: Pink/green with shades chosen by Creative Cloud; dendrite color
% manually selected by manipulating luminance in HSL.
scheme3.Plates = [191 84 133; 127 56 89; 229 101 160; 255 112 178; 64 28 44]./255;
scheme3.Plates_backup = [178 61 115; 255 137 192; 242 178 208]./255;
scheme3.Columns = [112 255 117; 43 178 46]./255;
% Result: pretty good, but the amount of luminance variance is a little
% problematic

% Scheme 4: Blue/orange analogous colors chosen using Creative Cloud
scheme4.ComplexPlates = [32 112 252; 31 163 242]./255;
scheme4.Polycrystal = [41 59 229]./255;
scheme4.Plates = [18 143 255; 17 187 232]./255;
scheme4.Column = [223 113 65; 246 143 54]./255;
% Result: colors draw eye to wrong place

% Scheme 5: Blue/purple
scheme5.Plates = [119 216 238; 56 158 240; 56 61 240; 145 171 233; 96 54 230]./255;
scheme5.Column = [119 45 153; 148 54 191]./255;
% Result: pretty good!

%Scheme 6: Blue/teal + purple
scheme6.Plates = [0 236 235; 56 158 240; 71 66 241]./255;
scheme6.Column = [193 55 255; 148 54 191]./255;
scheme6.ComplexPlates = [0 112 115; 0 255 138]./255;
% Result: looks really good, but not red-green or blue-yellow colorblind
% safe


% 



 
 
 
 
 
 
 