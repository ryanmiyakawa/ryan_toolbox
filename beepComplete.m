function beepComplete
[y fs] = wavread('complete.wav');
beepPlay = audioplayer(y,fs);
play(beepPlay)
pause(.75)