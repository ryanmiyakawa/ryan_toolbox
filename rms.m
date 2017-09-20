% Computes the RMS value of a wave over a domain

function r = rms(wave, domain)

if nargin == 1
    domain = wave ~= 0;
end

r = sqrt(mean(wave(logical(domain)).^2));