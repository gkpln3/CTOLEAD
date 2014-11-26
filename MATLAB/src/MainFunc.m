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
dataJson = {['{"carId": "', MLplatenum ...
    '", "color": "', vehicleColorFound, '", "camId": 1, "date": "', ...
    imgDate, 'T', imgHour, '"}']};

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