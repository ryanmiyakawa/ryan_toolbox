% 2-D bin. Ryan Miyakawa

% bins 2-D array into Nr x Nc compartments

function out = bin2(in, Nr, Nc);

[sr,sc] = size(in);
out = zeros(Nr,Nc);
interm = zeros(Nr, sc);

for j = 1:sc
    interm(:,j) = bin(in(:,j),Nr);
end

for k = 1:Nr
    out(k,:) = bin(interm(k,:),Nc);
end

    
