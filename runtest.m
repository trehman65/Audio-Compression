%% Initialize the program 
close all
clear all
clc

%% Operation Modes
plotmode=2;


%% Define Parameters 

N=[64,128,256,512];
percentCoeff=[.1,.25,.5,.75];
mode=[0,1];

%% Plot the comparison curves 
%SNR vs window size
%SNR vs percentage of DCT coefficients 


%% Varying size of window
if plotmode == 0
    i=1;
    SNR=zeros(1,length(N));

    for i  = 1:length(N)

        SNR(i)=audiocompression(N(i),.75,0);
    end
    
    figure
    plot(N,SNR,'o-')
    title('Variation of SNR with size of window')
    xlabel('Size of window')
    ylabel('SNR')
end
%% Varying percentage of DCT coefficients 
if plotmode == 1 
    i=1;
    SNR=zeros(1,length(N));

    for i  = 1:length(N)

        SNR(i)=audiocompression(512,percentCoeff(i),0);
    end

    figure
    plot(percentCoeff,SNR,'o-')
    title('Variaiton of SNR with Number of DCT Coefficients')
    xlabel('Percentage of DCT Coefficients selected')
    ylabel('SNR')
end
%% Varying DCT Coeffiecints for each N

if plotmode == 2
    i=1;
    SNR=zeros(1,length(N));

    figure

    for i  = 1:length(N)

        SNR=zeros(1,length(percentCoeff));

        for j= 1:length(percentCoeff)
            SNR(j)=audiocompression(N(i),percentCoeff(j),1);
        end
        plot(percentCoeff,SNR,'o-')
        hold on
    end


    title('Variation of SNR with size of window')
    xlabel('Size of window')
    ylabel('SNR')
    legend('N=64','N=128','N=256','N=512')

end