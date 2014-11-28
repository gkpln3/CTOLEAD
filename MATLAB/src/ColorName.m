function foundColorName = ColorName(checkColors)

%checkColors = [38 77 83];
%colorMat = readtable('colortable.csv','Delimiter','@');
%colorMat = table2cell(colorMat);
colorMat = {...
%'Blue',  '153.0014 100.2472 125.8768';
'Black', '143.8997 35.5542 53.8000';
'White', '134.8410 41.4204 212.967'...
};
%disp(colorMat);
%a = colorMat (2,:);
%test = char(a(1,2));
%test2 = strsplit(test);
%disp(test2(1));
%disp (length(colorMat));
foundColor = 999999999;
foundColorName = 'Unknown';

for i=1:length(colorMat)
    currColors = char(colorMat(i,2));
    currColors = strsplit(currColors);
    v1 = str2double(currColors(1));
    v2 = str2double(currColors(2));
    v3 = str2double(currColors(3));
    
    if abs(v1-checkColors(1))+abs(v2-(checkColors(2)))+abs(v3-(checkColors(3))) < foundColor
        foundColor = abs(v1-checkColors(1))+abs(v2-(checkColors(2)))+abs(v3-(checkColors(3)));
        foundColorName = char(colorMat(i,1));
    end
    %disp(foundColor);
end

%disp(foundColorName);