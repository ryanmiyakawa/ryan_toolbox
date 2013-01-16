function ftpUp(ftpHost, ftpObjStruct, sourcePath, destDir)

if ~isstruct(ftpObjStruct)
    load(ftpObjStruct)
end

h = statusBox('Connecting to FTP...');
F = ftp(ftpHost, ftpObjStruct.UN, ftpObjStruct.PW);
pasv(F); % Make passive connection
close(h)

h = statusBox('Putting files...');

    mkdir(F,destDir)
    dirs = regexp(destDir,'\', 'split');
    for k = 1:length(dirs)
        mkdir(F,dirs{k});
        cd(F,dirs{k});
    end
    

    mput(F, sourcePath);
   

close(h)
close(F)