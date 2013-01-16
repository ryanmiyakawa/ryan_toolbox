function out = cross_square(d)

spce = zeros(3*d);
vpinhole = pad2(ones(d), 3*d, 2*d);
hpinhole = pad2(ones(d), 2*d, 3*d);
cpinhole = ones(2*d);


uncropout = [  spce       vpinhole    spce; ...
            hpinhole   cpinhole    hpinhole;...
             spce       vpinhole       spce     ];

out = crop2(uncropout, 6*d, 6*d   );



     