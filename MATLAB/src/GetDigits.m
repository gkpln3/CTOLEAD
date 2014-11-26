function [ out ] = GetDigits( I , oX)
% Get all the digits from a provided image of a license plate
%
% @param I  The image (output from imread)

% Get the sizes of the provided image
[height, width, layers] = size(I);

% The constant collection of digit locations
% each row is width start, width end for each digit
% With blue
%
%digits = [
%  11, 17;
%  18, 24;
%  28, 34;
%  35, 41;
%  42, 48;
%  49, 55;
%  54, 60
%];
%baseImageSize = 34;
%digits = [
%  5, 8;
%  8, 11;
%  13, 16;
%  17, 20;
%  20, 23;
%  25, 28;
%  28, 31
%];
baseImageSize = 27;
digits = [
    2, 4;
    5, 7;
    10, 12;
    13, 15;
    16, 18;
    20, 22;
    23, 25
    ];

% The points were taken from a sample image of baseImageSize pixels
% Normalize them using the size of the current image
digits = digits .* (width / baseImageSize);

% Make sure that all the values are round numbers
for i = 1:numel(digits)
    digits(i)=ceil(digits(i));
end

% Get the maximal digit width
maxDigitWidth = max(digits(:,2)-digits(:,1));

% Get the number of digits to extract (number of rows)
numOfDigits = size(digits, 1);

% Make sure that the image size match
digits(:,2) = digits(:, 1) + maxDigitWidth;

% Generate an output array
out = uint8(zeros(height, maxDigitWidth+1, layers, numOfDigits));

digits = digits + oX;

% Iterare over all the digits
for i = 1:numOfDigits
    out(:,:,:,i) = I(1:height, digits(i, 1):digits(i, 2), :);
end


% Debug
%figure()
%pad = zeros(height, maxDigitWidth, layers);
%imshow([I pad out(:,:,:,1) pad out(:,:,:,2) pad out(:,:,:,3) pad out(:,:,:,4) pad out(:,:,:,5) pad out(:,:,:,6) pad out(:,:,:,7)])

end