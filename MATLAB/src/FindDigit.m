function [ digit ] = FindDigit( I )

dir = 'letters/';
ext = '.bmp';

max_coeff = -2;

for i = 1:10
   im = imread([dir sprintf('%d', i-1) ext]);
   coeff = corr2(im, I);
   if coeff > max_coeff
      max_coeff = coeff;
      digit = i-1;
   end
end


end

