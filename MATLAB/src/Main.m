flagSaveImages = 0;
strDigitName = {'auto_1_1.png','auto_2_1.png','auto_3_1.png','auto_4_1.png','auto_5_1.png','auto_6_1.png','auto_7_1.png'};

% Array of all number folder names
numberPathArr = ['0' '1' '2' '3' '4' '5' '6' '7' '8' '9'];

getDigitsFlag = 0;

% License plate DB folder
bigImagesPath = 'bigImagesDB';
bigImagesPNG  = dir([bigImagesPath '\*.png']);
bigImagesBMP  = dir([bigImagesPath '\*.bmp']);
bigImages = [bigImagesPNG ; bigImagesBMP];
bigImages(1,:);

% Loop through all license plates in DB
for idxBig = 1:length(bigImages)
    bigImage = imread([bigImagesPath '\' bigImages(idxBig).name]);
    [licenseForSearch vehicleColorFound] = finefind(bigImage);
    if flagSaveImages == 0
        [sumPeaks folderName] = LicenseRecognition(licenseForSearch, 0);
        [val idx] = max(sumPeaks);
        [MLplatenum,SLplatenum] = findnumbers(sumPeaks, double(folderName-'0'));
        [imgDate] = GetDate(bigImage);
        [imgHour] = GetHour(bigImage);
        
        % Display results
        
%         disp('License Plate Number:');
%         disp('_____________________');
%         disp(' ');
%         disp(MLplatenum);
%         disp(' ');
%         
%         disp('Vehicle Color:');
%         disp('______________');
%         disp(' ');
%         disp(vehicleColorFound);
%         disp(' ');
%         
%         disp('Date:');
%         disp('_____');
%         disp(' ');
%         disp([imgDate(end-1:end) '/' imgDate(end-3:end-2) '/' imgDate(1:4)]);
%         disp(' ');
%         
%         disp('Hour:');
%         disp('_____');
%         disp(' ');
%         disp([imgHour(1:2) ':' imgHour(3:4) ':' imgHour(5:6)]);
%         disp(' ');

    MLplatenum = mat2str(MLplatenum);
    dataJson = {['{"carId": "', [MLplatenum(2),MLplatenum(4) '-' MLplatenum(6), MLplatenum(8), MLplatenum(10)...
        '-' MLplatenum(12), MLplatenum(14)], ...
        '", "color": "', vehicleColorFound, '", "camId": 1, "date": "', ...
        [imgDate(end-1:end) '-' imgDate(end-3:end-2) '-' imgDate(1:4)], ...
        'T', [imgHour(1:2) ':' imgHour(3:4) ':' imgHour(5:6)], '"}']};
    
    dataJson = char(dataJson);
    
    fileName = '.\sendJson\json.txt';
    fileID = fopen(fileName,'w');
    fprintf(fileID, '%s', dataJson);
    fclose(fileID);
    
    %disp(dataJson);
    
    jsonCommand = ['.\sendJson\sendJson', ' ', fileName];
    %commandAlpr = '.\openalpr\alpr ferrariVehicle.jpg';
    %disp(commandAlpr);
    [jsonStatus,jsonRes] = system(jsonCommand);
        
    else
        imagesToSave = GetDigits(licenseForSearch, 0);
        
        for i=1:7
            imwrite(imagesToSave(:,:,:,i), ['numberDB\' strDigitName{i}]);
        end
    end
end