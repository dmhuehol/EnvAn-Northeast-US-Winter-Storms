%%periodOfRecord
    %Shows the period of record for all historical and current sounding
    %sites located around the Long Island area. Refers to the IGRA v2
    %dataset.
    %
    %Version date: 6/12/2018
    %
    %Written by: Daniel Hueholt
    %Undergraduate Research Assistant at Environment Analytics
    %North Carolina State University
    %

st.Upton = 1994:2018;
st.LaGuardia = 1939:1972;
st.JFK = 1952:1980;
st.Hempstead = 1918:1945;
st.NYU = 1935:1944;
st.Westhampton = 1943:1945;
st.FishersIsland = 1944:1945;
st.StatenIsland = 1929:1931;
st.Hartford = 1939:1947;
st.Lakehurst = 1946:1955;
st.SpringLake = 1943:1944;
st.FortMonmouth = 1929:1948;
st.Newark = 1929:1938;
st.PointJudith = 1944:1946;
st.Nantucket = 1941:1970;
st.FalmouthOtisAFB = 1964:1965;

stationLabels = {'Upton','La Guardia','JFK','Hempstead','NYU','Westhampton','Fishers Island','Staten Island','Hartford','Lakehurst','Spring Lake','Fort Monmouth','Newark','Point Judith','Nantucket','Falmouth-Otis AFB'};
stationPointers = {'Upton','LaGuardia','JFK','Hempstead','NYU','Westhampton','FishersIsland','StatenIsland','Hartford','Lakehurst','SpringLake','FortMonmouth','Newark','PointJudith','Nantucket','FalmouthOtisAFB'};

wire = 1;
for c = 1:length(stationPointers)
    plot(st.(stationPointers{c}),ones(1,length(st.(stationPointers{c}))).*wire,'LineWidth',2.5);
    hold on
    wire = wire+0.5;
end

axe = gca;
set(axe,'YTick',1:0.5:wire-0.5)
set(axe,'YTickLabel',stationLabels)
set(axe,'XTick',1918:3:2018)
ylim([0,wire+1])
xlim([1918 2018])
 