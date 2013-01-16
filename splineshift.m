% implements a sub-pixel shift by rebinning pixels.  Utilizes circshiftc,
% which does not wrap over

function out = splineshift(in, shftvec)

img00 = circshiftc(in, [  floor(shftvec(1))  , floor(shftvec(2))     ]  );
img10 = circshiftc(in, [   ceil(shftvec(1))  , floor(shftvec(2))     ]);
img01 = circshiftc(in, [  floor(shftvec(1))  , ceil(shftvec(2))      ]);
img11 = circshiftc(in, [   ceil(shftvec(1))  , ceil(shftvec(2))      ]);

rem1 = mod(shftvec(1), 1);
rem2 = mod(shftvec(2), 1);
rem1c = 1-rem1;
rem2c = 1-rem2;


out = img00*rem1c*rem2c + img10*rem1*rem2c + img01*rem1c*rem2 + img11*rem1*rem2;
