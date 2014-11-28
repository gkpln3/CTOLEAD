function [MLplatenum, vehicleColorFound, imgDate, imgHour, licenseForSearch, sumPeaks, folderName] = MainFunc(bigImage)

[licenseForSearch, vehicleColorFound] = finefind(bigImage);
[sumPeaks, folderName] = LicenseRecognition(licenseForSearch, 0);
[val idx] = max(sumPeaks);
[MLplatenum,SLplatenum] = findnumbers(sumPeaks, double(folderName-'0'));
MLplatenum = [num2str(MLplatenum(1)) num2str(MLplatenum(2)) '-' num2str(MLplatenum(3)) num2str(MLplatenum(4)) num2str(MLplatenum(5)) '-' num2str(MLplatenum(6)) num2str(MLplatenum(7))];
[imgDate] = GetDate(bigImage);
imgDate = [imgDate(end-1:end) '-' imgDate(end-3:end-2) '-' imgDate(1:4)];
[imgHour] = GetHour(bigImage);
imgHour = [imgHour(1:2) ':' imgHour(3:4) ':' imgHour(5:6)];
MLplatenum = mat2str(MLplatenum);
dateAll = num2str(fix(clock));
dateAll = strsplit(dateAll);

for i=2:length(dateAll)
    if length(char(dateAll(i))) < 2
        dateAll(i) = strcat('0', dateAll(i));
    end
end

dateJson = mat2str(cell2mat([dateAll(1) '-' dateAll(2) '-' dateAll(3)]));
timeJson = mat2str(cell2mat([dateAll(4) ':' dateAll(5) ':' dateAll(6)]));
dataJson = {['{"carId": "', MLplatenum ...
    '", "color": "', vehicleColorFound, '", "camId": 8, "date": "', ...
    dateJson, 'T', timeJson, '"}']};

dataJson = char(dataJson);
dataJson = strrep(dataJson, char(39), '');

fileName = '.\sendJson\json.txt';
fileID = fopen(fileName,'w');
fprintf(fileID, '%s', dataJson);
fclose(fileID);

%disp(dataJson);

jsonCommand = ['.\sendJson\sendJson', ' ', fileName];
%commandAlpr = '.\openalpr\alpr ferrariVehicle.jpg';
%disp(commandAlpr);
[jsonStatus,jsonRes] = system(jsonCommand);