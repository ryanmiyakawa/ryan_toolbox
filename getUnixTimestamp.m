function out = getUnixTimestamp()

out =str2double(urlread('https://mymsd.msd.lbl.gov/legacy/cluster/unixtime.php'));
