function r = rms(in)

s = in(:).^2;
m = mean(s);
r = sqrt(m); 