%filters input IN with 1D hanning window

function out = hanning1d(in, center, width)

len = length(in);

han = zeros(1,len);

hw = floor(width/2);
idx = center - hw + 1 : center + hw;

han(idx) = sin(pi*(idx-idx(1)+1)/width);

out = han.*in;


