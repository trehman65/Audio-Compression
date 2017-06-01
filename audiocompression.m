%initialization
close all
clear all
clc

%load audio
pathToAudio='/Users/talha/Desktop/DSPlabexam/sample.wav'
[audio, samplingFrequency]=audioread(pathToAudio);

%play audio
%sound(audio, samplingFrequency)

%pick N samples 
N=64;
samplesToPick=1:N;
thisWindow=0;

%selecting the frames
while samplesToPick(length(samplesToPick))<= length(audio)
    
    thisWindow=audio(samplesToPick);
    currentDCT=dct(thisWindow);
    plot(currentDCT)
    pause(1)
    

    %moving the window over the audio to pick next samples 
    samplesToPick=samplesToPick+N;
end