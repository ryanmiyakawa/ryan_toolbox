function out = quickbin(in, fac)
ph = zeros(size(in));
for k = 0:fac-1
    for m = 0:fac-1 
        ph = ph + circshift(in, [-k, -m]);
    end
end

out = ph(1:fac:end, 1:fac:end);



%jeanette jonathan functamija portia