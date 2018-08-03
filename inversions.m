function [] = inversions(invo,fa,run,v2Upton)
invo(fa) = [];

if nonzeros(ismember(run,1))==1
%% Height distribution (all years)
figure;
edges = [0 0.5 1 1.5 2 2.5 3 3.5 4 4.5 5];
c2 = 1;
for a = 1:length(invo)
    for c = 1:length(invo(a).AverageInversionHeights)
        cha(c2) = invo(a).AverageInversionHeights(c);
        c2 = c2+1;
    end
end
histogram(cha,edges,'Orientation','horizontal')
axe = gca;
axe.FontName = 'Lato Bold';
axe.FontSize = 14;
axe.Box = 'off';
t = title('Height distribution of temperature inversions, Upton 1994-2018 (all seasons)');
t.FontName = 'Lato';
t.FontSize = 18;
xl = xlabel('Number');
xl.FontName = 'Lato Bold';
xl.FontSize = 16;
yl = ylabel('Average height of inversion, binned by 500 m');
yl.FontName = 'Lato Bold';
yl.FontSize = 16;
end

if nonzeros(ismember(run,2))==1
%% Height distribution (winter)
edges = [0 0.5 1 1.5 2 2.5 3 3.5 4 4.5 5];
c2 = 1;
for a = 1:length(invo)
    for c = 1:length(invo(a).AverageInversionHeights)
        if invo(a).valid_date_num(2)~=5 && invo(a).valid_date_num(2)~=6 && invo(a).valid_date_num(2)~=7 && invo(a).valid_date_num(2)~=8 && invo(a).valid_date_num(2)~=9 && invo(a).valid_date_num(2)~=10
            chaWinter(c2) = invo(a).AverageInversionHeights(c);
            c2 = c2+1;
        end
    end
end
figure;
histogram(chaWinter,edges,'Orientation','horizontal')
axe = gca;
axe.FontName = 'Lato Bold';
axe.FontSize = 14;
axe.Box = 'off';
t = title('Height distribution of temperature inversions, Upton 1994-2018 (Nov-Apr)');
t.FontName = 'Lato';
t.FontSize = 18;
xl = xlabel('Number');
xl.FontName = 'Lato Bold';
xl.FontSize = 16;
yl = ylabel('Average height of inversion, binned by 500 m');
yl.FontName = 'Lato Bold';
yl.FontSize = 16;
end

if nonzeros(ismember(run,3))==1
%% Number of inversions per sounding (winter)
edges = [0 1 2 3 4 5 6 7 8 9 10 11 12 13 14 15];
c2 = 1;
c3 = 1;
for a = 1:length(invo)
    if isempty(invo(a).valid_date_num)==0
        if invo(a).valid_date_num(2)~=5 && invo(a).valid_date_num(2)~=6 && invo(a).valid_date_num(2)~=7 && invo(a).valid_date_num(2)~=8 && invo(a).valid_date_num(2)~=9 && invo(a).valid_date_num(2)~=10
            numberOfInversions(c2) = size(invo(a).UniqueInversionHeights,1);
            if numberOfInversions(c2)==1
                TvZ(invo(a).valid_date_num(1),invo(a).valid_date_num(2),invo(a).valid_date_num(3),invo(a).valid_date_num(4),v2Upton,5)
                disp(invo(a).UniqueInversionHeights)
                pause(6)
                %return %OH WOW I WONDER WHY THE FUNCTION KEEPS ENDING PREMATURELY WHOOPS
            end
            c2 = c2+1;
            %disp(invo(a).valid_date_num)
        end
    else
        c3 = c3+1;
    end
end
disp(c3)

figure;
histogram(numberOfInversions);
axe = gca;
axe.FontName = 'Lato Bold';
axe.FontSize = 14;
axe.Box = 'off';
t = title('Number of inversions per sounding, Upton 1994-2018 (Nov-Apr)');
t.FontName = 'Lato';
t.FontSize = 18;
xl = xlabel('Number of inversions');
xl.FontName = 'Lato Bold';
xl.FontSize = 16;
yl = ylabel('Number of soundings');
yl.FontName = 'Lato Bold';
yl.FontSize = 16;

end

if nonzeros(ismember(run,4))==1
%% Number of inversions per sounding (not winter)
edges = [0 1 2 3 4 5 6 7 8 9 10 11 12 13 14 15];
c2 = 1;
c3 = 1;
for a = 1:length(invo)
    if isempty(invo(a).valid_date_num)==0
        if invo(a).valid_date_num(2)~=11 && invo(a).valid_date_num(2)~=12 && invo(a).valid_date_num(2)~=1 && invo(a).valid_date_num(2)~=2 && invo(a).valid_date_num(2)~=3 && invo(a).valid_date_num(2)~=4
            numberOfInversions(c2) = size(invo(a).UniqueInversionHeights,1);
            c2 = c2+1;
            %disp(invo(a).valid_date_num)
        end
    else
        c3 = c3+1;
    end
end
disp(c3)

figure;
histogram(numberOfInversions);
axe = gca;
axe.FontName = 'Lato Bold';
axe.FontSize = 14;
axe.Box = 'off';
t = title('Number of inversions per sounding, Upton 1994-2018 (May-Oct)');
t.FontName = 'Lato';
t.FontSize = 18;
xl = xlabel('Number of inversions');
xl.FontName = 'Lato Bold';
xl.FontSize = 16;
yl = ylabel('Number of soundings');
yl.FontName = 'Lato Bold';
yl.FontSize = 16;
end

end
