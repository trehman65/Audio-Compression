

%% Initialization

close all
clear all
clc

%% Flags
%mode0=first N% DCT coefficients 
%mode1=Dominant N% DCT coefficients 
mode=0;


%% load audio
pathToAudio='/Users/talha/Desktop/DSPlabexam/sample.wav'
[audio, samplingFrequency]=audioread(pathToAudio);

%% Play audio
%sound(audio, samplingFrequency)

%% Pick N samples 
N=64;
samplesToPick=1:N;
thisWindow=0;
reconstructedAudio=[];

%% Selecting the frames
while samplesToPick(length(samplesToPick)) <= length(audio)
    
    thisWindow=audio(samplesToPick);
    currentDCT=dct(thisWindow);
    percentCoeff=.75;

    
    %% Pick dominant coefficients 
    if mode==1
        [sortedDCT,ind] = sort(abs(currentDCT),'descend');
    
        i = 1;
        
        %iterating over the audio lenght to pick 
        while norm(currentDCT(ind(1:i)))/norm(currentDCT) < percentCoeff
           i = i + 1;
        end
        needed = i;
        
        currentDCT(ind(needed+1:end)) = 0;
     
    
        %% Pick first Coefficients of DCT
        
    elseif mode==0
        currentDCT(floor(percentCoeff*length(currentDCT)):end)=0;

    end
    
    
    %% Reconstruction

    reconstructedWindow = idct(currentDCT);
    reconstructedAudio=[reconstructedAudio;reconstructedWindow];
    %% test the reconstructions
%         plot(thisWindow);
%         hold on 
%         plot(reconstructedWindow);
%         pause(1)
%         close all
    
    %% Moving the window over the audio to pick next samples 
    samplesToPick=samplesToPick+N;

end

%% play the compressed audio

sound(reconstructedAudio, samplingFrequency)
