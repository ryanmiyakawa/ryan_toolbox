function out = sincexpand(in, siz)

out = ifft2(ifftshift(pad2(fftshift(fft2(in)), siz, siz)));