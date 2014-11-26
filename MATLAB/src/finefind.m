function [fineI foundColorName] = finefind(I)

I = imcrop(I, [0 230 150 42]);

%I is an RBG image

IHSV = rgb2hsv(I);
e = im2bw(1-im2double(IHSV(:,:,1)));

er = bwmorph(e,'erode');

et = bwmorph(er,'thicken');

location = bwareaopen(et,100);

s = regionprops(location,'all');

licenseRatio=3.875;
licenseArea=248;
licenseColor = [58.1104   79.2137   98.9153];
licenseIndex = 0;
axisratio = 3;
foundaxisratio = 999999999;
foundRatio = 999999999;
foundArea = 999999999;
foundColor = 999999999;
maxSumProperties = 0;

for idxRatio=1:length(s)
    sumPropertiesFound = 0;
    tempImage = (imcrop(I, s(idxRatio).BoundingBox));
    colorArray = MainColor(tempImage);
    
    if abs(licenseRatio-(s(idxRatio).BoundingBox(3)/s(idxRatio).BoundingBox(4))) < foundRatio
        sumPropertiesFound = sumPropertiesFound+1;
    end
    
    if abs(licenseArea - (s(idxRatio).Area)) < foundArea
        sumPropertiesFound = sumPropertiesFound+1;
    end
    
    if abs(licenseColor(1)-colorArray(1))+abs(licenseColor(2)-colorArray(2))+abs(licenseColor(3)-colorArray(3)) < foundColor
        sumPropertiesFound = sumPropertiesFound+1;
    end
    
    if (abs(axisratio - s(idxRatio).MajorAxisLength/s(idxRatio).MinorAxisLength) < foundaxisratio)
        sumPropertiesFound = sumPropertiesFound+1;
    end
    
    if sumPropertiesFound > maxSumProperties
        
        if idxRatio > 1
            maxSumProperties = sumPropertiesFound;
        end
        
        foundRatio = abs(licenseRatio-(s(idxRatio).BoundingBox(3)/s(idxRatio).BoundingBox(4)));
        foundArea = abs(licenseArea - (s(idxRatio).Area));
        foundColor = abs(licenseColor(1)-colorArray(1))+abs(licenseColor(2)-colorArray(2))+abs(licenseColor(3)-colorArray(3));
        licenseIndex = idxRatio;
    end
end

vehicleBB = s(licenseIndex).BoundingBox;
vehicleArea = [vehicleBB(1) vehicleBB(2)-20 vehicleBB(3) vehicleBB(4)];
vehicleColor = MainColor(imcrop(I, vehicleArea));
foundColorName = ColorName(vehicleColor);
%imshow(imcrop(I, vehicleArea));
%disp(vehicleColor);
%disp(foundColorName);

fineI = imcrop(I, s(licenseIndex).BoundingBox);