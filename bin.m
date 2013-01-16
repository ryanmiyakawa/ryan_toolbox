% 1D Bin, Ryan Miyakawa

% Bins vector X into N equal compartments.

function out = bin(x,N)

len = length(x);


out = zeros(1,N);
splits = linspace(1,len+1,N+1);

for k = 1:N
    if k ==1
        out(k) = sum(x(splits(k):(floor(splits(k+1))-1))) +...
            x(floor(splits(k+1)))*(splits(k+1) - floor(splits(k+1)));
    elseif k == N
         out(k) = sum(x(floor(splits(k)):((splits(k+1)-1)))) - ...
             x(floor(splits(k)))*(splits(k) - floor(splits(k)));
    else
        out(k) = sum(x( (floor(splits(k))):(floor(splits(k+1))-1))) - ...
             x(floor(splits(k)))*(splits(k) - floor(splits(k))) + ...
            x(floor(splits(k+1)))*(splits(k+1) - floor(splits(k+1)));
    end
    
end
