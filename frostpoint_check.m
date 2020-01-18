%% Frostpoint checking
for fc = 1:length(Td)
tFrost(fc) = frostpoint(Td(fc));
end

frost_line = plot(tFrost,Td);
frost_line.LineWidth = 1;
frost_line.Color = [0 206 209]./255;
hold on
dew_line = plot(Td,Td);
dew_line.LineWidth = 1;
dew_line.Color = [204 0 0]./255;

t = title('Frostpoint vs Dewpoint');
t.FontSize = 16;

leg = legend('Frostpoint','Dewpoint');
leg.Location = 'northwest';
xlabel('Frostpoint (deg C)')
ylabel('Dewpoint (deg C)')