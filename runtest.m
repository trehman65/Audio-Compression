%% Initialize the program 
close all
clear all
clc

%% Define Parameters 

N=[64,128,256,512];
percentCoeff=[.1,.25,.5,.75];
mode=[0,1];

%% Plot comparison curves 

%% Varying size of window
i=1;
SNR=zeros(1,length(N));

for i  = 1:length(N)
   
    SNR(i)=audiocompression(N(i),.75,0);
end

plot(N,SNR)

%% Varying percentage of DCT coefficients 
i=1;
SNR=zeros(1,length(N));

for i  = 1:length(N)
   
    SNR(i)=audiocompression(512,percentCoeff(i),0);
end

figure
plot(percentCoeff,SNR)