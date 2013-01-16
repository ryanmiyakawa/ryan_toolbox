% 8/13/2007 Ryan Miyakawa
%
% function out = hammingbp(in, cenr, cenc, width, dropoff)
%
% Hamming circular bandpass filter.  IN is the input matrix, CENR and CENC specify
% the center of the filter, WIDTH specifies the diameter of the filter, and
% DROPOFF is a number between 1 and 100 that determines how quickly the
% filter drops off.  Higher numbers correspond to sharper dropoffs.

function [out, Hshift] = hammingbp(in, cenr, cenc, width, dropoff)
%change xy -> ij
% cenr = -ysh;
% cenc = xsh;

if mod(dropoff,2) ~= 1
    dropoff = dropoff+1; %to avoid complex filter
end

[sr sc] = size(in);
if sr~=sc
    error('HAMMINGBP only handles square domains');
end


[f1,f2] = freqspace(dropoff,'meshgrid');
Hd = ones(dropoff);
r = sqrt(f1.^2 + f2.^2);
Hd(( r > width/sr)) = 0;
h = fwind1(Hd,hamming(dropoff));
H = freqz2(h, sr, sc);
Hshift = circshift(H, [cenr cenc]);
out = Hshift.*in;
% figure
% mesh(Hshift)
% title('filter')