zrn=[0,0,0,0.4,-0.4,0,0,0];
zrnrot = rotZernVec(zrn, pi/3);

zrnRes = 200;
zidx = linspace(-1,1,zrnRes);

zrnmap = abdom(pinhole(zrnRes), [0 zrn]); %handles.zrn starts at tilt, abdom starts at piston
figure(13)
colormap jet
if ~all(zrnmap(:) == 0)
    imagesc(zidx,zidx,zrnmap);
else
    imagesc(zidx,zidx, pinhole(zrnRes));
end
axis xy
colorbar

zrnmap = abdom(pinhole(zrnRes), [0 zrnrot]); %handles.zrn starts at tilt, abdom starts at piston
figure(14)
colormap jet
if ~all(zrnmap(:) == 0)
    imagesc(zidx,zidx,zrnmap);
else
    imagesc(zidx,zidx, pinhole(zrnRes));
end
axis xy
colorbar
