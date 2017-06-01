

%% Initialization

close all
clear all
clc

%% Flags
%mode0=first N% DCT coefficients 
%mode1=Dominant N% DCT coefficients 
%debug1=plots window level plots
mode=0;
debug=0;
soundFlag=1;


%% load audio
pathToAudio='/Users/talha/Desktop/DSPlabexam/sample.wav'
[audio, samplingFrequency]=audioread(pathToAudio);

%% Play input audio
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
    if(debug==1)
        plot(thisWindow);
        hold on 
        plot(reconstructedWindow);
        pause(1)
        close all
    end
    
    %% Moving the window over the audio to pick next samples 
    samplesToPick=samplesToPick+N;

end

%% Calculating SNR 

difSig=audio(1:length(reconstructedAudio))-reconstructedAudio;
SNR = 10*log10(sum(reconstructedAudio.*reconstructedAudio)/sum(difSig.*difSig))


%% play the compressed audio
if(soundFlag==1)
    sound(reconstructedAudio, samplingFrequency)
end
