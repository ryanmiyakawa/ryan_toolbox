function img = grating(res, d, size, phase)
img = 1/2+square(-phase + 2*pi*(meshgrid(0:res-1)+.001)/(res/(size/d)),50)/2;