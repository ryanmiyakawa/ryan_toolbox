function out = cross_circle(d)

spce = zeros(3*d);
vpinhole = pinhole(d, 3*d, 2*d);
hpinhole = pinhole(d, 2*d, 3*d);
cpinhole = pinhole(2*d);


uncropout = [  spce       vpinhole    spce; ...
            hpinhole   cpinhole    hpinhole;...
             spce       vpinhole       spce     ];

out = crop2(uncropout, 6*d, 6*d   );



     
     
     