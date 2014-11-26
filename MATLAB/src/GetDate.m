function [ date ] = GetDate( name )
% Read the entire image to memory
im = name;

% Get only hour section from the image
im = im(1:7,end-183:end-105,:);

im = im2bw(im);

% Array of digit locations
digits = [
    1, 7;
    8,14;
    16,22;
    25,31;
    40,46;
    48,54;
    64,70;
    73,79
    ];

date = '';

for digit = 1:size(digits,1)
    date = [date sprintf('%d', FindDigit(im(:,digits(digit, 1):digits(digit,2))))];
end

end

