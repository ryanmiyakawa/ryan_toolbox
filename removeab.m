function out = removeab(wv, V, abVec)

for k = 1:length(V)
    wv = wv - abVec(k)*V{k};
end

out = wv;