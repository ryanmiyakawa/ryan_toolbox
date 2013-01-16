% GENLINES, 8/15/2007 Ryan Miyakawa
%
% function out = genlines(size, freq, th, phase)
% 
% Generates lines that are intended for use in structured illumination
% simulations.  SIZE specifies the size of the output matrix, FREQ is the
% frequency of the lines times the number of pixels: f*N, ie, the location
% of the first order FT delta offset from the origin.  TH is the RHS
% rotation angle of the fourier components measured from the horizontal (+x axis) and PHASE 
% is a phase offset where zero phase is arbitrarily defined.  The 
% sinusoidal output ranges from 0 to 1.

function out = genlines(size, freq, th, phase)
out = zeros(size);
[R,C] = freqspace([size size], 'meshgrid');
V = R*cos(th) - C*sin(th);
out = 1/2 + 1/2*cos(pi*freq*V - phase);
