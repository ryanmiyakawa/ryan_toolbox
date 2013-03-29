% © Patrick Naulleau 1997
%
% This function reads a Winview spe file.
% This function can currently only read 1024x1024 files
%
% function f=speread(filename,[roi])
%
%   filename = full path name for file to be read
%   roi = optional vector contain the region of interest to be read
%           [xmin,ymin,xmax,,ymax]

function f=speread(filename,sz)

fid=fopen(filename,'r');
fseek(fid,4100,'bof');
f=zeros(sz);
f=fread(fid,[sz,sz],'uint16');
fclose(fid);