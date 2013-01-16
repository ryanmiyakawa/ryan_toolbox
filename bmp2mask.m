% converts a bitmap file to a matrix, using PIXELCONV pixels in the matrix
% to represent a single pixel in the bitmap.  If PIXELCONV is not
% specified, the function takes it to be 1-to-1. BMP is the path of the
% bitmap file.

function out = bmp2mask(bmp, pixelconv)

if nargin == 1
    pixelconv = 1;
end


img = imread(bmp);
[sr sc sz] = size(img);
if sz > 1
    img = sum(img,3);
end
img = floor(img./abs(max2(img)));

out = zeros(sr*pixelconv, sc*pixelconv);
for j = 1:sr
    for k = 1:sc
        out((pixelconv*(j-1)+1):(pixelconv*j),(pixelconv*(k-1)+1):(pixelconv*k)) ...
            = ones(pixelconv) * img(j,k);
    end
end

