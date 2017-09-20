% Finds the rotation that optimizes HV contrast.  Angular range and res in
% degrees

function ang = findRotation(in, angRange, angRes, mode)

angs = linspace(-angRange, angRange, angRes);
sliceMags = zeros(size(angs));


switch mode
    case 'fft'
        for k = 1:length(angs)
            img = abs(fft2(imrotate(in, angs(k), 'bilinear','crop')));
            sliceMags(k) = sum(img(1,:)) + sum(img(:,1));
        end

        [~, idx] = max(sliceMags);
        ang = angs(idx);
    case 'projection'
        for k = 1:length(angs)
            img = sum(imrotate(in, angs(k), 'bilinear','crop'));
            
            sliceMags(k) = (max(img) - min(img))/(max(img) + min(img));
        end

        [~, idx] = max(sliceMags);
        ang = angs(idx);
        
end