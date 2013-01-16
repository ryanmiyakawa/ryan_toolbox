% creates ft domain indices.
%  Same as linspace(-.5, .5-1/N,N)

function out =  ftspace(N)
out = -.5 + .5*freqspace(N, 'whole');

