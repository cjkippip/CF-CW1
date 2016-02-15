% Computational Finance CW1
% Question 3
load dataR.mat
dataR=flipud(dataR);
L=length(dataR(:,1));
dataRHalf=dataR(1:round(L/2),:);
dataRRest=dataR(round(L/2)+1:end,:);



