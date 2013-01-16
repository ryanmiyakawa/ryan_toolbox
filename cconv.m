%Performs 1D circular convolution by fourier transform method

function out = cconv(a,b)

len = max(length(a), length(b));
%lengths of vectors must be the same, otherwise zeropad:
out = ifft( fft(a,len) .* fft(b,len));

