%% Audio Compression using DCT


function SNR=audiocompression(N,percentCoeff,mode)
%% Output/Input Arguments 
% * SNR = signal to noise ratio
% * N = size of window
% * percentCoeff = percenatge of DCT coefficients to be picked
% * mode = operation mode(0: picks first DCT coefficients, 1:  picks dominant DCT coefficients)


%% Flags
%mode0=pick first N% DCT coefficients 
%mode1=pick Dominant N% DCT coefficients 
%debug1=plots window level plots

debug=0;
soundFlag=0;


%% load audio
pathToAudio='/Users/talha/Desktop/DSPlabexam/sample.wav';
[audio, samplingFrequency]=audioread(pathToAudio);

%% Play input audio
if soundFlag ==1
    sound(audio, samplingFrequency)
end
%% Pick N samples 

samplesToPick=1:N;
thisWindow=0;
reconstructedAudio=[];

%% Selecting the frames
while samplesToPick(length(samplesToPick)) <= length(audio)
    
    thisWindow=audio(samplesToPick);
    currentDCT=dct(thisWindow);

    
    %% Pick dominant coefficients 
    if mode==1
        
        [sortedDCT,ind] = sort(abs(currentDCT),'descend');        
        ignoredInd=ind(floor(percentCoeff*length(sortedDCT)):end);
        currentDCT(ignoredInd) = 0;
     
    
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
SNR = 10*log10(sum(audio.^2)/sum(difSig.^2));


%% play the compressed audio
if(soundFlag==1)
    sound(reconstructedAudio, samplingFrequency)
end

end