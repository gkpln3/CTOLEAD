function [sumPeaks folderName] = LicenseRecognition(licenseForSearch, getDigitsFlag)

%close all;

% Array of all number folder names
numberPathArr = ['0' '1' '2' '3' '4' '5' '6' '7' '8' '9'];

% License plate DB folder
%licensePath = 'licenseDB';
%licenseImagesPNG  = dir([licensePath '\*.png']);
%licenseImagesBMP  = dir([licensePath '\*.bmp']);
%licenseImages = [licenseImagesPNG ; licenseImagesBMP];
%licenseImages(1,:);

% Loop through all license plates in DB
%for idxLicense = 1:length(licenseImages)
%licenseForSearch = imread([licensePath '\' licenseImages(idxLicense).name]);

%matPeaks = zeros(10,9);

% sumPeaks = zeros(50, size(licenseForSearch ,2)-3);

tempNumImage = GetDigits(licenseForSearch, 0);


if getDigitsFlag == 1
    sumPeaks = zeros(25, 7);
else
    sumPeaks = zeros(25, size(licenseForSearch ,2)-size(tempNumImage,2));
end
folderName = char(zeros(25,1));

count = 1;

% Loop through number folder name
for idxNumberArr = 1:length(numberPathArr)
    numberPath = ['numberDB' '\' numberPathArr(idxNumberArr)];
    %disp(numberPath);
    numberImagesPNG = dir([numberPath '\*.png']);
    numberImagesBMP = dir([numberPath '\*.bmp']);
    numberImages = [numberImagesPNG ; numberImagesBMP];
    
    %sumPeaks = zeros(1,9);
    %divideBy = 1;
    
    
    % Loop through all images in number folder
    for idxNumber = 1:length(numberImages)
        
        numberToFind = imread([numberPath '\' numberImages(idxNumber).name]);
        %numberToFind = imresize(numberToFind, [size(licenseForSearch, 1) 3],'nearest');
        
        %disp([numberPath '\' numberImages(idxNumber).name]);
        
        %numberCorr=zeros(1,size(licenseForSearch ,2)-size(numberToFind,2));
        %numberCorr=zeros(1,7);
        
        % Find correlation in license plate
        
        if getDigitsFlag == 1
            a = GetDigits(licenseForSearch,0);
            for idxSearch=1:size(a,4)
                offsetCorMat = zeros(3,1);
                for offset = -1:1
                    a = GetDigits(licenseForSearch,offset);
                    temp = imresize(a(:,:,:,idxSearch), [size(numberToFind,1), size(numberToFind,2)]);
                    offsetCorMat(offset+2) = corr2(temp(:,:,2), numberToFind(:,:,2));
                end
                sumPeaks(count, idxSearch) = offsetCorMat(2); %max(offsetCorMat);
                %allPeaks = findpeaks(numberCorr);
                %sumPeaks = sumPeaks+allPeaks;
                %disp(sumPeaks);
                
                folderName(count) = numberPath(end);
                %divideBy = idxNumber;
            end
            
        else
            % In order to handle the case of a dbDigit larger than the
            % license
            if size(licenseForSearch ,1)<size(numberToFind,1)
                numberToFind= imresize(numberToFind,[size(licenseForSearch ,1) NaN]);
            end
            
            numberCorr = zeros(size(licenseForSearch ,1)-size(numberToFind,1)+1,size(licenseForSearch ,2)-size(numberToFind,2));
            for idxSearchRows=1:size(licenseForSearch ,1)-size(numberToFind,1)+1
                for idxSearch=1:size(licenseForSearch ,2)-size(numberToFind,2)
                    numberCorr(idxSearchRows,idxSearch)=corr2(licenseForSearch(idxSearchRows:(idxSearchRows+size(numberToFind,1)-1),idxSearch:(idxSearch+size(numberToFind,2)-1),2),numberToFind(:,:,2));
                    %                     imshow(imresize(licenseForSearch(idxSearchRows:(idxSearchRows+size(numberToFind,1)-1),idxSearch:(idxSearch+size(numberToFind,2)-1),2),10));
                    
                    drawnow
                end
            end
            if size(numberCorr,1)==1
                sumPeaks(count,:) = imresize((numberCorr),[1 size(licenseForSearch ,2)-size(tempNumImage,2)]);
            else
                sumPeaks(count,:) = imresize(max(numberCorr),[1 size(licenseForSearch ,2)-size(tempNumImage,2)]);
            end
            folderName(count) = numberPath(end);
        end
        
        count =count + 1;
        
    end
    
    %sumPeaks = sumPeaks/divideBy;
    %matPeaks(idxNumberArr,:) = sumPeaks;
    %disp(sumPeaks);
end

%disp(matPeaks);
%end

%Display Results

%imagesc(sumPeaks);
%ax = gca;
%set(ax, 'YTickLabel',folderName);
%set(ax, 'YTick',1:numel(folderName));
%[val idx] = max(sumPeaks);
%licenseText=folderName(idx);
%licenseText(licenseText-'0'<0) = '*';
%disp(licenseText');
%title(licenseText');
%figure(); imshow(licenseForSearch)