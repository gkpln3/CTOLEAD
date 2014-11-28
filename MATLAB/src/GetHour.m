function [ hour ] = GetHour(  name )
% Read the entire image to memory
im = name;

% Get only hour section from the image
im = im(1:7, end-65:end,:);

im = im2bw(im);

% Array of digit locations
digits = [
    3, 9;
    11,17;
    27,33;
    35,41;
    51,57;
    59,65
    ];

hour = '';

for digit = 1:size(digits,1)
    hour = [hour sprintf('%d', FindDigit(im(:,digits(digit, 1):digits(digit,2))))];
end

end

