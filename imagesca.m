function [] = imagesca(img, caxisL, caxisH)

if nargin == 1
    L = min(abs(img(:)));
    H = max(abs(img(:)));
else
    vals = sort(img(find(abs(img))));
    len = length(vals);
    Lidx = ceil(len*caxisL/100);
    Hidx = floor(len*caxisH/100);
    L = vals(Lidx);
    H = vals(Hidx);
end


imagesc(abs(img));

if (L < H)
caxis([L, H]);
end

axis image;

