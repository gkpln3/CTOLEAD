% Read the reference image containing the logo.
logoImageName = 'ferrariLogo.png';
vehicleImageName = 'ferrariVehicle.jpg';

logoImage = imread(logoImageName);
figure; imshow(logoImage);
logoImage = rgb2gray(logoImage);
title('Image of the Logo');

% Read the target image containing the vehicle.
vehicleImageColor = imread(vehicleImageName);
vehicleImage = rgb2gray(vehicleImageColor);
%figure; imshow(vehicleImageColor);
%title('Image of the Vehicle');

% Detect feature points in both images.
logoPoints = detectSURFFeatures(logoImage);
vehiclePoints = detectSURFFeatures(vehicleImage);

% Visualize the strongest feature points found in the reference image.
%figure; imshow(logoImage);
%title('100 Strongest Feature Points from Logo Image');
%hold on;
%plot(logoPoints.selectStrongest(100));

% Visualize the strongest feature points found in the target image.
%figure; imshow(vehicleImage);
%title('300 Strongest Feature Points from Vehicle Image');
%hold on;
%plot(vehiclePoints.selectStrongest(300));

% Extract feature descriptors at the interest points in both images.
[logoFeatures, logoPoints] = extractFeatures(logoImage, logoPoints);
[vehicleFeatures, vehiclePoints] = extractFeatures(vehicleImage, vehiclePoints);

% Match the features using their descriptors. 
logoPairs = matchFeatures(logoFeatures, vehicleFeatures);

% Display putatively matched features. 
matchedlogoPoints = logoPoints(logoPairs(:, 1), :);
matchedvehiclePoints = vehiclePoints(logoPairs(:, 2), :);
%figure;
%showMatchedFeatures(logoImage, vehicleImage, matchedlogoPoints, ...
%    matchedvehiclePoints, 'montage');
%title('Putatively Matched Points (Including Outliers)');

% |estimateGeometricTransform| calculates the transformation relating the
% matched points, while eliminating outliers. This transformation allows
% to localize the object in the scene.
[tform, inlierlogoPoints, inliervehiclePoints] = ...
    estimateGeometricTransform(matchedlogoPoints, matchedvehiclePoints, 'affine');

% Display the matching point pairs with the outliers removed
%figure;
%showMatchedFeatures(logoImage, vehicleImage, inlierlogoPoints, ...
%    inliervehiclePoints, 'montage');
%title('Matched Points (Inliers Only)');

% Get the bounding polygon of the reference image.
logoPolygon = [1, 1;...                           % top-left
        size(logoImage, 2), 1;...                 % top-right
        size(logoImage, 2), size(logoImage, 1);... % bottom-right
        1, size(logoImage, 1);...                 % bottom-left
        1, 1];                   % top-left again to close the polygon

% Transform the polygon into the coordinate system of the target image.
% The transformed polygon indicates the location of the object in the
% scene.
newlogoPolygon = transformPointsForward(tform, logoPolygon);    

% Display the detected object.
figure; imshow(vehicleImageColor);
hold on;
line(newlogoPolygon(:, 1), newlogoPolygon(:, 2), 'Color', 'y');
title('Detected Logo');

% Calculate dominant color in vehicle image
%colors = 'RGB';
%[~,idx] = max(sum(sum(vehicleImage,1),2),[],3);
%dominant = colors(idx);
%disp('Vehicle color');
%disp(dominant);

vehicleImageColor = im2double(vehicleImageColor);
vehicleImageHSV = rgb2hsv(vehicleImageColor);
testRGB = reshape(vehicleImageColor, [size(vehicleImageColor,1)*size(vehicleImageColor,2),3]);
testHSV = reshape(vehicleImageHSV, [size(vehicleImageHSV,1)*size(vehicleImageHSV,2), 3]);
[y,x] = hist(testRGB, [0:255]/255);
[ya,xa] = hist(testHSV, [0:255]/255);
figure; plot(x,y);
figure; plot(xa,ya);
Scale = [0:255];
ScaleRGB = ind2rgb(Scale, hsv(256));
ScaleHSV = rgb2hsv(ScaleRGB);
figure; imagesc(ScaleHSV(1,:,1)); colormap(hsv(256));

% License Plate Recognition
disp('Vehicle Plate Number');
alprCommand = ['.\openalpr\alpr', ' ', vehicleImageName];
%commandAlpr = '.\openalpr\alpr ferrariVehicle.jpg';
%disp(commandAlpr);
[alprStatus,alprRes] = system(alprCommand);
disp(alprRes);