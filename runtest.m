%% Script to test the audio compression function and plots the graphs

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
    SNR2=zeros(1,length(N));

    for i  = 1:length(N)

        SNR(i)=audiocompression(N(i),.50,0);
        SNR2(i)=audiocompression(N(i),.50,1);
    end
    
    figure
    plot(N,SNR,'o--')
    hold on 
    plot(N,SNR2,'x--')
    
    
    title('Variation of SNR with size of window')
    xlabel('Size of window')
    ylabel('SNR')
    legend('First Coefficients','Dominant Coefficients')
end
%% Varying percentage of DCT coefficients 
if plotmode == 1 
    i=1;
    SNR=zeros(1,length(N));    SNR2=zeros(1,length(N));


    for i  = 1:length(N)

        SNR(i)=audiocompression(64,percentCoeff(i),0);
        SNR2(i)=audiocompression(64,percentCoeff(i),1);

    end

    figure
    plot(percentCoeff,SNR,'o--')
    hold on
    plot(percentCoeff,SNR2,'x-')
    
    title('Variaiton of SNR with Number of DCT Coefficients')
    xlabel('Percentage of DCT Coefficients selected')
    ylabel('SNR')
    legend('First Coefficients','Dominant Coefficients')

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
    xlabel('Percentage of DCT Coefficients selected')
    ylabel('SNR')
    legend('N=64','N=128','N=256','N=512')

end

%% Varying N for each DCT Coeffiecints

if plotmode == 3
    i=1;
    SNR=zeros(1,length(N));
    
    figure

    for i  = 1:length(N)

        SNR=zeros(1,length(percentCoeff));

        for j= 1:length(percentCoeff)
            SNR(j)=audiocompression(N(j),percentCoeff(i),1);
        end
        plot(N,SNR,'o-')
        hold on
    end


    title('Variation of SNR with size of window')
    xlabel('Size of window')
    ylabel('SNR')
    legend('P=10%','P=25%','P=50%','P=75%')

end
close all
